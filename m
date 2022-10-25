Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A8760CEA9
	for <lists+linux-efi@lfdr.de>; Tue, 25 Oct 2022 16:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbiJYOOP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Oct 2022 10:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbiJYONv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Oct 2022 10:13:51 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D51A4853;
        Tue, 25 Oct 2022 07:13:49 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 4832640737AC;
        Tue, 25 Oct 2022 14:13:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 4832640737AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1666707228;
        bh=DZTrbaBaHe77iGD0+HZCDY+dD1tpBzVWypKX0yhMApE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hSA4oTacdmboTGxjLXOr5oGkOsiMFnT3xJPfu/VNlPtW7JIOXZMeMgWWHF0EgbLVW
         D5UuKr7CK2Q4bYnegBpFEjz0ocLVEntGoQSj33IHkzhtpWZxhwb7DWXd69Xz/sPf7t
         6n8NSPXbDeCVRIXbPDY2qQ2kgLdqTk2er3PdiL3E=
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Evgeniy Baskov <baskov@ispras.ru>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2 12/23] x86/boot: Make kernel_add_identity_map() a pointer
Date:   Tue, 25 Oct 2022 17:12:50 +0300
Message-Id: <d94c98c0cb8506aae1972e86cb58f70ce6a90e4f.1666705333.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <cover.1666705333.git.baskov@ispras.ru>
References: <cover.1666705333.git.baskov@ispras.ru>
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

Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
---
 arch/x86/boot/compressed/ident_map_64.c |  7 ++++---
 arch/x86/boot/compressed/misc.c         | 24 ++++++++++++++++++++++++
 arch/x86/boot/compressed/misc.h         | 15 +++------------
 3 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index ba5108c58a4e..1aee524d3c2b 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -92,9 +92,9 @@ bool has_nx; /* set in head_64.S */
 /*
  * Adds the specified range to the identity mappings.
  */
-unsigned long kernel_add_identity_map(unsigned long start,
-				      unsigned long end,
-				      unsigned int flags)
+unsigned long kernel_add_identity_map_(unsigned long start,
+				       unsigned long end,
+				       unsigned int flags)
 {
 	int ret;
 
@@ -142,6 +142,7 @@ void initialize_identity_maps(void *rmode)
 	struct setup_data *sd;
 
 	boot_params = rmode;
+	kernel_add_identity_map = kernel_add_identity_map_;
 
 	/* Exclude the encryption mask from __PHYSICAL_MASK */
 	physical_mask &= ~sme_me_mask;
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index aa4a22bc9cf9..c9c235d65d16 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -275,6 +275,22 @@ static void parse_elf(void *output, unsigned long output_len,
 	free(phdrs);
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
+static inline unsigned long kernel_add_identity_map_dummy(unsigned long start,
+							  unsigned long end,
+							  unsigned int flags)
+{
+	return start;
+}
+
 /*
  * The compressed kernel image (ZO), has been moved so that its position
  * is against the end of the buffer used to hold the uncompressed kernel
@@ -312,6 +328,14 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 
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
index 38d31bec062d..0076b2845b4b 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -180,18 +180,9 @@ static inline int count_immovable_mem_regions(void) { return 0; }
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
2.37.4

