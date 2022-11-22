Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEF9633ADC
	for <lists+linux-efi@lfdr.de>; Tue, 22 Nov 2022 12:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbiKVLNB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Nov 2022 06:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbiKVLMu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Nov 2022 06:12:50 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65D42AEC;
        Tue, 22 Nov 2022 03:12:48 -0800 (PST)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 47A1840737D8;
        Tue, 22 Nov 2022 11:12:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 47A1840737D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1669115563;
        bh=crSlzJwK96YW/rE+r+0VuFq2u4zO2iJQEIttDiLLC3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HZvlcI6T9aWDGQqrRXS8cjF5H0rQ63ngSLaMc5ftyOH5hUATAk1DdStVQkfo7oYa+
         Hr2z4elSgKFLllD0x7YSGln3+LloM9wKWOzd3QOMia+1FToMaLIfBCV0VSfSn6QuM3
         YgM8Vr9UDc4wHe0S8gfs9/kiR/akD7MgLSopsf7I=
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
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v3 12/24] x86/boot: Make kernel_add_identity_map() a pointer
Date:   Tue, 22 Nov 2022 14:12:21 +0300
Message-Id: <9251fb0d8dbb6fbb3a4730952314170c6771df0e.1668958803.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <cover.1668958803.git.baskov@ispras.ru>
References: <cover.1668958803.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

