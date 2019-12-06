Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3419D1155D8
	for <lists+linux-efi@lfdr.de>; Fri,  6 Dec 2019 17:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfLFQ4E (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 6 Dec 2019 11:56:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:50756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbfLFQ4E (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 6 Dec 2019 11:56:04 -0500
Received: from e123331-lin.cambridge.arm.com (fw-tnat-cam5.arm.com [217.140.106.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99E522464E;
        Fri,  6 Dec 2019 16:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575651363;
        bh=IVLdhYRWY5tYVVwLJ4OV2x+arjj3+DxKN+oVeExsJ6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wFzY0gVExciXHZItBHvEX68e1G9KixiDq0uedyXFBTHNJIN0p+mlcB+dvE4ggLB0K
         De1UD0d4YHZxZlaqQi2afjihkfzITku9DBji9PN0Nqy6xwaVVDLaSBs7MdB8WxhsYc
         VMB4/DGO1DVNbS/xZ99gvWmJ2isXli8Cxis3Bd4c=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: [PATCH 1/6] efi/memreserve: register reservations as 'reserved' in /proc/iomem
Date:   Fri,  6 Dec 2019 16:55:37 +0000
Message-Id: <20191206165542.31469-2-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191206165542.31469-1-ardb@kernel.org>
References: <20191206165542.31469-1-ardb@kernel.org>
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

Address this problem by adding these reservations to /proc/iomem as
they are created. Note that reservations that are inherited from a
previous kernel are memblock_reserve()'d early on, so they are already
visible in /proc/iomem.

Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Tested-by: Bhupesh Sharma <bhsharma@redhat.com>
Reviewed-by: Bhupesh Sharma <bhsharma@redhat.com>
Cc: <stable@vger.kernel.org> # v5.4+
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index d101f072c8f8..b0961950d918 100644
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
@@ -1003,7 +1021,7 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 			rsv->entry[index].size = size;
 
 			memunmap(rsv);
-			return 0;
+			return efi_mem_reserve_iomem(addr, size);
 		}
 		memunmap(rsv);
 	}
@@ -1013,6 +1031,12 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 	if (!rsv)
 		return -ENOMEM;
 
+	rc = efi_mem_reserve_iomem(__pa(rsv), SZ_4K);
+	if (rc) {
+		free_page((unsigned long)rsv);
+		return rc;
+	}
+
 	/*
 	 * The memremap() call above assumes that a linux_efi_memreserve entry
 	 * never crosses a page boundary, so let's ensure that this remains true
@@ -1029,7 +1053,7 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 	efi_memreserve_root->next = __pa(rsv);
 	spin_unlock(&efi_mem_reserve_persistent_lock);
 
-	return 0;
+	return efi_mem_reserve_iomem(addr, size);
 }
 
 static int __init efi_memreserve_root_init(void)
-- 
2.17.1

