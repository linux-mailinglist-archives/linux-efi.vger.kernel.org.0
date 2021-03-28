Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E390934BF40
	for <lists+linux-efi@lfdr.de>; Sun, 28 Mar 2021 23:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhC1VXD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 28 Mar 2021 17:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhC1VW6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 28 Mar 2021 17:22:58 -0400
Received: from smtp.gentoo.org (woodpecker.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCA6C061756;
        Sun, 28 Mar 2021 14:22:58 -0700 (PDT)
Received: by sf.home (Postfix, from userid 1000)
        id BD73D5A22061; Sun, 28 Mar 2021 22:22:52 +0100 (BST)
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-ia64@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Sergei Trofimovich <slyfox@gentoo.org>
Subject: [PATCH v2] ia64: fix EFI_DEBUG build
Date:   Sun, 28 Mar 2021 22:22:46 +0100
Message-Id: <20210328212246.685601-1-slyfox@gentoo.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <CAMj1kXEmuVWR=TAmzXHnvKxbtSn1-Zkhr-0rOWV0BB1OGyx_TQ@mail.gmail.com>
References: <CAMj1kXEmuVWR=TAmzXHnvKxbtSn1-Zkhr-0rOWV0BB1OGyx_TQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When enabled local debugging via `#define EFI_DEBUG 1` noticed
build failure:
    arch/ia64/kernel/efi.c:564:8: error: 'i' undeclared (first use in this function)

While at it fixed benign string format mismatches visible only
when EFI_DEBUG is enabled:

    arch/ia64/kernel/efi.c:589:11:
        warning: format '%lx' expects argument of type 'long unsigned int',
        but argument 5 has type 'u64' {aka 'long long unsigned int'} [-Wformat=]

Fixes: 14fb42090943559 ("efi: Merge EFI system table revision and vendor checks")
CC: Ard Biesheuvel <ardb@kernel.org>
CC: linux-efi@vger.kernel.org
CC: linux-ia64@vger.kernel.org
Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
---
Change since v1: mention explicitly format string change

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
2.31.1

