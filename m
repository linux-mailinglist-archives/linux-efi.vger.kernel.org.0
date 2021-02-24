Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876AA3243F1
	for <lists+linux-efi@lfdr.de>; Wed, 24 Feb 2021 19:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbhBXSpT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 24 Feb 2021 13:45:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31468 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232417AbhBXSpS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 24 Feb 2021 13:45:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614192232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7Pi1Huj1io0WE2uM4yhK/jodNm0pVYNEApXxjjAhh1M=;
        b=AqTxEPEtpN+32azjkwdSrb2ESGSVe/L0qp7oOSXf0jIW8VnDIjwyHtVrAiR5XQIUtc/gs+
        fM3RBx5bLoBcJZMllPJmjoKDsNl7CroU4mOp3djA53JG2BssNYDP7Qo898aOcgtEJi40gp
        gSkkiSfI8A1bGkdxJasL8C4v7X1VxwE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-QyaVNpYHNeG8QgMWw6_86Q-1; Wed, 24 Feb 2021 13:43:47 -0500
X-MC-Unique: QyaVNpYHNeG8QgMWw6_86Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0D7180196E;
        Wed, 24 Feb 2021 18:43:46 +0000 (UTC)
Received: from kasong-rh-laptop.intra.hackret.com (ovpn-12-86.pek2.redhat.com [10.72.12.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF40C5D6AD;
        Wed, 24 Feb 2021 18:43:44 +0000 (UTC)
From:   Kairui Song <kasong@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Kairui Song <kasong@redhat.com>
Subject: [PATCH] efi: memmap insertion should adjust the vaddr as well
Date:   Thu, 25 Feb 2021 02:43:08 +0800
Message-Id: <20210224184308.1416903-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Currently when efi_memmap_insert is called, only the
physical memory addresses are re-calculated. The virt
addresses of the split entries are untouched.

If any later operation depends on the virt_addaress info, things
will go wrong. One case it may fail is kexec on x86, after kexec,
efi is already in virtual mode, kernel simply do fixed mapping
reuse the recorded virt address. If the virt address is incorrect,
the mapping will be invalid.

Update the virt_addaress as well when inserting a memmap entry to
fix this potential issue.

Signed-off-by: Kairui Song <kasong@redhat.com>
---
 drivers/firmware/efi/memmap.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
index 2ff1883dc788..de5c545b2074 100644
--- a/drivers/firmware/efi/memmap.c
+++ b/drivers/firmware/efi/memmap.c
@@ -292,7 +292,7 @@ void __init efi_memmap_insert(struct efi_memory_map *old_memmap, void *buf,
 {
 	u64 m_start, m_end, m_attr;
 	efi_memory_desc_t *md;
-	u64 start, end;
+	u64 start, end, virt_offset;
 	void *old, *new;
 
 	/* modifying range */
@@ -321,6 +321,11 @@ void __init efi_memmap_insert(struct efi_memory_map *old_memmap, void *buf,
 		start = md->phys_addr;
 		end = md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT) - 1;
 
+		if (md->virt_addr)
+			virt_offset = md->virt_addr - md->phys_addr;
+		else
+			virt_offset = -1;
+
 		if (m_start <= start && end <= m_end)
 			md->attribute |= m_attr;
 
@@ -337,6 +342,8 @@ void __init efi_memmap_insert(struct efi_memory_map *old_memmap, void *buf,
 			md->phys_addr = m_end + 1;
 			md->num_pages = (end - md->phys_addr + 1) >>
 				EFI_PAGE_SHIFT;
+			if (virt_offset != -1)
+				md->virt_addr = md->phys_addr + virt_offset;
 		}
 
 		if ((start < m_start && m_start < end) && m_end < end) {
@@ -351,6 +358,8 @@ void __init efi_memmap_insert(struct efi_memory_map *old_memmap, void *buf,
 			md->phys_addr = m_start;
 			md->num_pages = (m_end - m_start + 1) >>
 				EFI_PAGE_SHIFT;
+			if (virt_offset != -1)
+				md->virt_addr = md->phys_addr + virt_offset;
 			/* last part */
 			new += old_memmap->desc_size;
 			memcpy(new, old, old_memmap->desc_size);
@@ -358,6 +367,8 @@ void __init efi_memmap_insert(struct efi_memory_map *old_memmap, void *buf,
 			md->phys_addr = m_end + 1;
 			md->num_pages = (end - m_end) >>
 				EFI_PAGE_SHIFT;
+			if (virt_offset != -1)
+				md->virt_addr = md->phys_addr + virt_offset;
 		}
 
 		if ((start < m_start && m_start < end) &&
@@ -373,6 +384,8 @@ void __init efi_memmap_insert(struct efi_memory_map *old_memmap, void *buf,
 			md->num_pages = (end - md->phys_addr + 1) >>
 				EFI_PAGE_SHIFT;
 			md->attribute |= m_attr;
+			if (virt_offset != -1)
+				md->virt_addr = md->phys_addr + virt_offset;
 		}
 	}
 }
-- 
2.29.2

