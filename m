Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50DAF780B32
	for <lists+linux-efi@lfdr.de>; Fri, 18 Aug 2023 13:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376691AbjHRLhq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Aug 2023 07:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376692AbjHRLhn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Aug 2023 07:37:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E6C30F6
        for <linux-efi@vger.kernel.org>; Fri, 18 Aug 2023 04:37:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1784863FB9
        for <linux-efi@vger.kernel.org>; Fri, 18 Aug 2023 11:37:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9DBFC433CC;
        Fri, 18 Aug 2023 11:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692358661;
        bh=Iq7X6ZDY43lbw90pcqL5PNnyIedzbRO+mGLLwYciL/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LVQKNaz12Bb3UlujJs7Zs4EsR/FaEbKNcVdrau4dtvj8MSQKw3aq7Q/5NKRJiS/cs
         qzm0EBpHozey3YU6O95V0STSTxBAexm0Ok9CuiPww/lf3Xb4X6hcbVunAhiyB84gCn
         2eS4RgyIuzXfOpMzjuUPwZkQs7hH8K2F3N5cl4poymB+D+Lm1WEALTCk8hs1KODddG
         72G+BZyryuVk61f8E86Ztk10+KHsp5AEaVuTr7zFLEkyVWZ7DLIBnKDYyToOrCToPc
         whnpB9KyvBH76JA3u979th8C6jLbDLJvqBr0EctJ0XvErubtLvOLeH+KCPpXsVq9Oz
         +o9ZwHQjI5nPg==
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
Subject: [PATCH v2 02/11] efi/arm64: Move EFI runtime call setup/teardown helpers out of line
Date:   Fri, 18 Aug 2023 13:37:15 +0200
Message-Id: <20230818113724.368492-3-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230818113724.368492-1-ardb@kernel.org>
References: <20230818113724.368492-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2507; i=ardb@kernel.org; h=from:subject; bh=Iq7X6ZDY43lbw90pcqL5PNnyIedzbRO+mGLLwYciL/g=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeV++BuniLQvC1eta5jN/qbXPfnucbGbHJ13NTbph0988 vf+EauOjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjAR9mSG//FR2z5HWf44Pkc3 gVs94NlqG/1stQozQx6DWJ/e2KcrHjIyNBr8N9l05+aMQ1otMp82dNo8+qMVeeB+VFqxfMx9qdP 7uAE=
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
 arch/arm64/include/asm/efi.h | 18 +++---------------
 arch/arm64/kernel/efi.c      | 16 +++++++++++++++-
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 4cf2cb053bc8df95..f482b994c608ccf3 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -30,28 +30,16 @@ int efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md);
 int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md,
 				bool has_bti);
 
-#define arch_efi_call_virt_setup()					\
-({									\
-	efi_virtmap_load();						\
-	__efi_fpsimd_begin();						\
-	raw_spin_lock(&efi_rt_lock);					\
-})
-
 #undef arch_efi_call_virt
 #define arch_efi_call_virt(p, f, args...)				\
 	__efi_rt_asm_wrapper((p)->f, #f, args)
 
-#define arch_efi_call_virt_teardown()					\
-({									\
-	raw_spin_unlock(&efi_rt_lock);					\
-	__efi_fpsimd_end();						\
-	efi_virtmap_unload();						\
-})
-
-extern raw_spinlock_t efi_rt_lock;
 extern u64 *efi_rt_stack_top;
 efi_status_t __efi_rt_asm_wrapper(void *, const char *, ...);
 
+void arch_efi_call_virt_setup(void);
+void arch_efi_call_virt_teardown(void);
+
 /*
  * efi_rt_stack_top[-1] contains the value the stack pointer had before
  * switching to the EFI runtime stack.
diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index baab8dd3ead3c27a..49efbdbd6f7ae766 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -158,7 +158,21 @@ asmlinkage efi_status_t efi_handle_corrupted_x18(efi_status_t s, const char *f)
 	return s;
 }
 
-DEFINE_RAW_SPINLOCK(efi_rt_lock);
+static DEFINE_RAW_SPINLOCK(efi_rt_lock);
+
+void arch_efi_call_virt_setup(void)
+{
+	efi_virtmap_load();
+	__efi_fpsimd_begin();
+	raw_spin_lock(&efi_rt_lock);
+}
+
+void arch_efi_call_virt_teardown(void)
+{
+	raw_spin_unlock(&efi_rt_lock);
+	__efi_fpsimd_end();
+	efi_virtmap_unload();
+}
 
 asmlinkage u64 *efi_rt_stack_top __ro_after_init;
 
-- 
2.39.2

