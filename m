Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA14780B33
	for <lists+linux-efi@lfdr.de>; Fri, 18 Aug 2023 13:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376689AbjHRLhq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Aug 2023 07:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376691AbjHRLhk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Aug 2023 07:37:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4000B30F6
        for <linux-efi@vger.kernel.org>; Fri, 18 Aug 2023 04:37:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9F6263F2E
        for <linux-efi@vger.kernel.org>; Fri, 18 Aug 2023 11:37:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F01C43391;
        Fri, 18 Aug 2023 11:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692358658;
        bh=lKrYL3uoj3AftwTA+wum5aWk6rB9/ZdGJQ5n+b0lnqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nYR5I1HVsuaTIyIdrO/Vrmp0f3Qm6VncRC5NuhmVKulcbQpouVSFNRwSSKev2lddZ
         u/nTR0Z+YsHEKbMugiY3LXiIO0/wRXfQxczqmTdsyE8LYJNUrSGnrXDLi2MbW6HxgW
         ImVXRsH7cz6dCM+2Not7wYIGiA3u0DxUE4Et2saVvls8D7y7D1DaAZKboLtkrqWnu0
         Ow4TftKPO6W+LaIU0G/XDVlIeRb0Ji235BuSWYq1xEhL63hf0V1LDeVY+RV4bjNFNJ
         fJkufAB2sQon5DVz6uyntzCXjwOwV6JAPCD6DlwqxG1EpiOkZTIsycCvZKNEGyee4b
         ipbG2LNrkVqUA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2 01/11] efi/x86: Move EFI runtime call setup/teardown helpers out of line
Date:   Fri, 18 Aug 2023 13:37:14 +0200
Message-Id: <20230818113724.368492-2-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230818113724.368492-1-ardb@kernel.org>
References: <20230818113724.368492-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4172; i=ardb@kernel.org; h=from:subject; bh=lKrYL3uoj3AftwTA+wum5aWk6rB9/ZdGJQ5n+b0lnqQ=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeV++JvG5tZIe822p0rH2c46zxX49MS4Inp2rfSMI16F2 rpsDo86SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwEQuPmT471rvGzfNRJ/9eISe 1Xy2Z5rRRkxtjn/K18xb5nzk7Mek24wMiwIv326oSLtvwsW5ZIuZy3P98BuhN30nvmbO/On7hH0 PFwA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Only the arch_efi_call_virt() macro that some architectures override
needs to be a macro, given that it is variadic and encapsulates calls
via function pointers that have different prototypes.

The associated setup and teardown code are not special in this regard,
and don't need to be instantiated at each call site. So turn them into
ordinary C functions and move them out of line.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/efi.h     | 32 ++------------------
 arch/x86/platform/efi/efi_32.c | 12 ++++++++
 arch/x86/platform/efi/efi_64.c | 19 ++++++++++--
 3 files changed, 31 insertions(+), 32 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index b0994ae3bc23f84d..c4555b269a1b2474 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -91,19 +91,6 @@ static inline void efi_fpu_end(void)
 
 #ifdef CONFIG_X86_32
 #define EFI_X86_KERNEL_ALLOC_LIMIT		(SZ_512M - 1)
-
-#define arch_efi_call_virt_setup()					\
-({									\
-	efi_fpu_begin();						\
-	firmware_restrict_branch_speculation_start();			\
-})
-
-#define arch_efi_call_virt_teardown()					\
-({									\
-	firmware_restrict_branch_speculation_end();			\
-	efi_fpu_end();							\
-})
-
 #else /* !CONFIG_X86_32 */
 #define EFI_X86_KERNEL_ALLOC_LIMIT		EFI_ALLOC_LIMIT
 
@@ -116,14 +103,6 @@ extern bool efi_disable_ibt_for_runtime;
 	__efi_call(__VA_ARGS__);					\
 })
 
-#define arch_efi_call_virt_setup()					\
-({									\
-	efi_sync_low_kernel_mappings();					\
-	efi_fpu_begin();						\
-	firmware_restrict_branch_speculation_start();			\
-	efi_enter_mm();							\
-})
-
 #undef arch_efi_call_virt
 #define arch_efi_call_virt(p, f, args...) ({				\
 	u64 ret, ibt = ibt_save(efi_disable_ibt_for_runtime);		\
@@ -132,13 +111,6 @@ extern bool efi_disable_ibt_for_runtime;
 	ret;								\
 })
 
-#define arch_efi_call_virt_teardown()					\
-({									\
-	efi_leave_mm();							\
-	firmware_restrict_branch_speculation_end();			\
-	efi_fpu_end();							\
-})
-
 #ifdef CONFIG_KASAN
 /*
  * CONFIG_KASAN may redefine memset to __memset.  __memset function is present
@@ -168,8 +140,8 @@ extern void efi_delete_dummy_variable(void);
 extern void efi_crash_gracefully_on_page_fault(unsigned long phys_addr);
 extern void efi_free_boot_services(void);
 
-void efi_enter_mm(void);
-void efi_leave_mm(void);
+void arch_efi_call_virt_setup(void);
+void arch_efi_call_virt_teardown(void);
 
 /* kexec external ABI */
 struct efi_setup_data {
diff --git a/arch/x86/platform/efi/efi_32.c b/arch/x86/platform/efi/efi_32.c
index e06a199423c0fedd..b2cc7b4552a16630 100644
--- a/arch/x86/platform/efi/efi_32.c
+++ b/arch/x86/platform/efi/efi_32.c
@@ -140,3 +140,15 @@ void __init efi_runtime_update_mappings(void)
 		}
 	}
 }
+
+void arch_efi_call_virt_setup(void)
+{
+	efi_fpu_begin();
+	firmware_restrict_branch_speculation_start();
+}
+
+void arch_efi_call_virt_teardown(void)
+{
+	firmware_restrict_branch_speculation_end();
+	efi_fpu_end();
+}
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 77f7ac3668cb4ac0..91d31ac422d6cde7 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -474,19 +474,34 @@ void __init efi_dump_pagetable(void)
  * can not change under us.
  * It should be ensured that there are no concurrent calls to this function.
  */
-void efi_enter_mm(void)
+static void efi_enter_mm(void)
 {
 	efi_prev_mm = current->active_mm;
 	current->active_mm = &efi_mm;
 	switch_mm(efi_prev_mm, &efi_mm, NULL);
 }
 
-void efi_leave_mm(void)
+static void efi_leave_mm(void)
 {
 	current->active_mm = efi_prev_mm;
 	switch_mm(&efi_mm, efi_prev_mm, NULL);
 }
 
+void arch_efi_call_virt_setup(void)
+{
+	efi_sync_low_kernel_mappings();
+	efi_fpu_begin();
+	firmware_restrict_branch_speculation_start();
+	efi_enter_mm();
+}
+
+void arch_efi_call_virt_teardown(void)
+{
+	efi_leave_mm();
+	firmware_restrict_branch_speculation_end();
+	efi_fpu_end();
+}
+
 static DEFINE_SPINLOCK(efi_runtime_lock);
 
 /*
-- 
2.39.2

