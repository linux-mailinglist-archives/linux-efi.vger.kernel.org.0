Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA2E6B8F94
	for <lists+linux-efi@lfdr.de>; Tue, 14 Mar 2023 11:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjCNKRu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Mar 2023 06:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjCNKRe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Mar 2023 06:17:34 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82C99BE01;
        Tue, 14 Mar 2023 03:16:36 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 18BE340770A1;
        Tue, 14 Mar 2023 10:16:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 18BE340770A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1678788963;
        bh=RI3tsd7FWDEqFja/9FovpdCEr1yXpj8RlCN24KH1JfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qcpu7NOhu8TX2SOjvX0eoGQeDfw3duxtIRlehiOZ90vaIO/Rn7NAhWHIv7E6rqjBE
         BGO/zcSJv6XcvP8/N1R0TlphYTmLhlvoQ/pO0PPUDD2FeGIMyTqR0E8vNRsXnkISkD
         hy1bc7x6Ftll9/k127V8/ki0288OoPyad5U1g0Js=
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Evgeniy Baskov <baskov@ispras.ru>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v5 12/27] x86/boot: Make kernel_add_identity_map() a pointer
Date:   Tue, 14 Mar 2023 13:13:39 +0300
Message-Id: <a12645e74f68b77a8c97015795e71529d8499b3f.1678785672.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1678785672.git.baskov@ispras.ru>
References: <cover.1678785672.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Convert kernel_add_identity_map() into a function pointer to be able
to provide alternative implementations of this function. Required
to enable calling the code using this function from EFI environment.

Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>

Warnings on the previous version were
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202303090348.l0pqa8oz-lkp@intel.com/
---
 arch/x86/boot/compressed/ident_map_64.c |  7 ++++---
 arch/x86/boot/compressed/misc.c         | 24 ++++++++++++++++++++++++
 arch/x86/boot/compressed/misc.h         | 15 +++------------
 3 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index 378f99b1d7e8..1995560d3b43 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -92,9 +92,9 @@ bool has_nx; /* set in head_64.S */
 /*
  * Adds the specified range to the identity mappings.
  */
-unsigned long kernel_add_identity_map(unsigned long start,
-				      unsigned long end,
-				      unsigned int flags)
+static unsigned long kernel_add_identity_map_impl(unsigned long start,
+						  unsigned long end,
+						  unsigned int flags)
 {
 	int ret;
 
@@ -143,6 +143,7 @@ void initialize_identity_maps(void *rmode)
 	struct setup_data *sd;
 
 	boot_params = rmode;
+	kernel_add_identity_map = kernel_add_identity_map_impl;
 
 	/* Exclude the encryption mask from __PHYSICAL_MASK */
 	physical_mask &= ~sme_me_mask;
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 76773a989364..74f028cf2dfd 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -277,6 +277,22 @@ static size_t parse_elf(void *output, unsigned long output_len,
 	return ehdr.e_entry - LOAD_PHYSICAL_ADDR;
 }
 
+/*
+ * This points to actual implementation of mapping function
+ * for current environment: either EFI API wrapper,
+ * own implementation or dummy implementation below.
+ */
+unsigned long (*kernel_add_identity_map)(unsigned long start,
+					 unsigned long end,
+					 unsigned int flags);
+
+static unsigned long kernel_add_identity_map_dummy(unsigned long start,
+						   unsigned long end,
+						   unsigned int flags)
+{
+	return start;
+}
+
 /*
  * The compressed kernel image (ZO), has been moved so that its position
  * is against the end of the buffer used to hold the uncompressed kernel
@@ -315,6 +331,14 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 
 	init_default_io_ops();
 
+	/*
+	 * On 64-bit this pointer is set during page table uninitialization,
+	 * but on 32-bit it remains uninitialized, since paging is disabled.
+	 */
+	if (IS_ENABLED(CONFIG_X86_32))
+		kernel_add_identity_map = kernel_add_identity_map_dummy;
+
+
 	/*
 	 * Detect TDX guest environment.
 	 *
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index e20f60bfe91b..fe201b45b038 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -182,18 +182,9 @@ static inline int count_immovable_mem_regions(void) { return 0; }
 #ifdef CONFIG_X86_5LEVEL
 extern unsigned int __pgtable_l5_enabled, pgdir_shift, ptrs_per_p4d;
 #endif
-#ifdef CONFIG_X86_64
-extern unsigned long kernel_add_identity_map(unsigned long start,
-					     unsigned long end,
-					     unsigned int flags);
-#else
-static inline unsigned long kernel_add_identity_map(unsigned long start,
-						    unsigned long end,
-						    unsigned int flags)
-{
-	return start;
-}
-#endif
+extern unsigned long (*kernel_add_identity_map)(unsigned long start,
+						unsigned long end,
+						unsigned int flags);
 /* Used by PAGE_KERN* macros: */
 extern pteval_t __default_kernel_pte_mask;
 
-- 
2.39.2

