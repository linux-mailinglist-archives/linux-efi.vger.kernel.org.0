Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3277D345254
	for <lists+linux-efi@lfdr.de>; Mon, 22 Mar 2021 23:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhCVWPa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 22 Mar 2021 18:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhCVWO7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 22 Mar 2021 18:14:59 -0400
Received: from smtp.gentoo.org (mail.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58F4C061574
        for <linux-efi@vger.kernel.org>; Mon, 22 Mar 2021 15:14:55 -0700 (PDT)
Received: by sf.home (Postfix, from userid 1000)
        id 07CF95A22061; Mon, 22 Mar 2021 22:14:44 +0000 (GMT)
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     Sergei Trofimovich <slyfox@gentoo.org>, linux-ia64@vger.kernel.org
Subject: [PATCH] ia64: fix EFI_DEBUG build
Date:   Mon, 22 Mar 2021 22:14:41 +0000
Message-Id: <20210322221441.3555003-1-slyfox@gentoo.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When enabled local debugging via `#define EFI_DEBUG 1` noticed
build failure:

    ia64/kernel/efi.c:564:8: error: 'i' undeclared (first use in this function)
      564 |   for (i = 0, p = efi_map_start; p < efi_map_end;
          |        ^

CC: Ard Biesheuvel <ardb@kernel.org>
CC: linux-efi@vger.kernel.org
CC: linux-ia64@vger.kernel.org
Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
---
 arch/ia64/kernel/efi.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/ia64/kernel/efi.c b/arch/ia64/kernel/efi.c
index c5fe21de46a8..31149e41f9be 100644
--- a/arch/ia64/kernel/efi.c
+++ b/arch/ia64/kernel/efi.c
@@ -415,10 +415,10 @@ efi_get_pal_addr (void)
 		mask  = ~((1 << IA64_GRANULE_SHIFT) - 1);
 
 		printk(KERN_INFO "CPU %d: mapping PAL code "
-                       "[0x%lx-0x%lx) into [0x%lx-0x%lx)\n",
-                       smp_processor_id(), md->phys_addr,
-                       md->phys_addr + efi_md_size(md),
-                       vaddr & mask, (vaddr & mask) + IA64_GRANULE_SIZE);
+			"[0x%llx-0x%llx) into [0x%llx-0x%llx)\n",
+			smp_processor_id(), md->phys_addr,
+			md->phys_addr + efi_md_size(md),
+			vaddr & mask, (vaddr & mask) + IA64_GRANULE_SIZE);
 #endif
 		return __va(md->phys_addr);
 	}
@@ -560,6 +560,7 @@ efi_init (void)
 	{
 		efi_memory_desc_t *md;
 		void *p;
+		unsigned int i;
 
 		for (i = 0, p = efi_map_start; p < efi_map_end;
 		     ++i, p += efi_desc_size)
@@ -586,7 +587,7 @@ efi_init (void)
 			}
 
 			printk("mem%02d: %s "
-			       "range=[0x%016lx-0x%016lx) (%4lu%s)\n",
+			       "range=[0x%016llx-0x%016llx) (%4lu%s)\n",
 			       i, efi_md_typeattr_format(buf, sizeof(buf), md),
 			       md->phys_addr,
 			       md->phys_addr + efi_md_size(md), size, unit);
-- 
2.31.0

