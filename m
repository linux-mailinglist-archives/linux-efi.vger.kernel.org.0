Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB977112DC8
	for <lists+linux-efi@lfdr.de>; Wed,  4 Dec 2019 15:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfLDOwc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Dec 2019 09:52:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:37948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727912AbfLDOwc (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 4 Dec 2019 09:52:32 -0500
Received: from e123331-lin.cambridge.arm.com (fw-tnat-cam5.arm.com [217.140.106.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6E012081B;
        Wed,  4 Dec 2019 14:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575471151;
        bh=2Hhr1DoiPHOZk7B+fdoNv2WRhAw5ziTKXzdrxtsKJbw=;
        h=From:To:Cc:Subject:Date:From;
        b=2QKVkLOgtMI2leXLzHm7e90HDOewfx4mqxF9KVzm0dvshjmuh+bQ+rv3IlMhRvl++
         pJlfpZtjdipdpNdXZ2+kmQd8Z9Qsrvirh7qicNQCwczJSrrExP5TVi9qCnYui0vO7W
         HLntdNiPdw/K9HRng3gTvN3qjloPA4/z3q+Lu3q8=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     mark.rutland@arm.com, james.morse@arm.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        d.hatayama@fujitsu.com, kexec@lists.infradead.org
Subject: [PATCH] efi/memreserve: register reservations as 'reserved' in /proc/iomem
Date:   Wed,  4 Dec 2019 14:52:33 +0000
Message-Id: <20191204145233.11962-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Memory regions that are reserved using efi_mem_reserve_persistent()
are recorded in a special EFI config table which survives kexec,
allowing the incoming kernel to honour them as well. However,
such reservations are not visible in /proc/iomem, and so the kexec
tools that load the incoming kernel and its initrd into memory may
overwrite these reserved regions before the incoming kernel has a
chance to reserve them from further use.

So add these reservations to /proc/iomem as they are created. Note
that reservations that are inherited from a previous kernel are
memblock_reserve()'d early on, so they are already visible in
/proc/iomem.

Cc: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Cc: d.hatayama@fujitsu.com
Cc: kexec@lists.infradead.org
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi.c | 29 ++++++++++++++++++--
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index d101f072c8f8..fcd82dde23c8 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -979,6 +979,24 @@ static int __init efi_memreserve_map_root(void)
 	return 0;
 }
 
+static int efi_mem_reserve_iomem(phys_addr_t addr, u64 size)
+{
+	struct resource *res, *parent;
+
+	res = kzalloc(sizeof(struct resource), GFP_ATOMIC);
+	if (!res)
+		return -ENOMEM;
+
+	res->name	= "reserved";
+	res->flags	= IORESOURCE_MEM;
+	res->start	= addr;
+	res->end	= addr + size - 1;
+
+	/* we expect a conflict with a 'System RAM' region */
+	parent = request_resource_conflict(&iomem_resource, res);
+	return parent ? request_resource(parent, res) : 0;
+}
+
 int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 {
 	struct linux_efi_memreserve *rsv;
@@ -1001,9 +1019,8 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 		if (index < rsv->size) {
 			rsv->entry[index].base = addr;
 			rsv->entry[index].size = size;
-
 			memunmap(rsv);
-			return 0;
+			return efi_mem_reserve_iomem(addr, size);
 		}
 		memunmap(rsv);
 	}
@@ -1013,6 +1030,12 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 	if (!rsv)
 		return -ENOMEM;
 
+	rc = efi_mem_reserve_iomem(__pa(rsv), SZ_4K);
+	if (rc) {
+		free_page(rsv);
+		return rc;
+	}
+
 	/*
 	 * The memremap() call above assumes that a linux_efi_memreserve entry
 	 * never crosses a page boundary, so let's ensure that this remains true
@@ -1029,7 +1052,7 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 	efi_memreserve_root->next = __pa(rsv);
 	spin_unlock(&efi_mem_reserve_persistent_lock);
 
-	return 0;
+	return efi_mem_reserve_iomem(addr, size);
 }
 
 static int __init efi_memreserve_root_init(void)
-- 
2.17.1

