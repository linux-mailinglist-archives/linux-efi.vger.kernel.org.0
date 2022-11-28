Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C6263A55D
	for <lists+linux-efi@lfdr.de>; Mon, 28 Nov 2022 10:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiK1Jtv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 28 Nov 2022 04:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiK1Jtu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 28 Nov 2022 04:49:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474AD12AFC
        for <linux-efi@vger.kernel.org>; Mon, 28 Nov 2022 01:49:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B021060FE9
        for <linux-efi@vger.kernel.org>; Mon, 28 Nov 2022 09:49:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E09AC433C1;
        Mon, 28 Nov 2022 09:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669628988;
        bh=IYgx8aYCHMJXqPUUbXfcldTTpG8Zc+8llafQDmuZ0BM=;
        h=From:To:Cc:Subject:Date:From;
        b=Rl/d3h7LhtZqMCuxP0LaAfra5dcIj0cr7GgBxOXw+f65+ZCTI7Zq1nGb+5ugYjobM
         5h6NWdnaKarC0w1xLpPyNWmahaURCwit2kV0qfugS33dM7gx38QVwa+nO6jQMD7kli
         WYOxRdm0nsERe77S1n9ryRWhLAH6Q+x7FHU8VFf888BQzzDUrJgFS+oHNS8LqSk2Oj
         OzZvtbwNr2aS9fWcXMkWP1bfAIc/jKmr0UMvyR2U1U/bkqogNCXILYTYRzQWdgjdxn
         XmEO6PyAexs9Pb5UU1FEuQmA9+tN21drsxDW8xJhNnw678LtWsOztYG75TIfNCdu0a
         ea+tu09eDXtZw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] arm64: efi: Make runtime service wrapper more robust
Date:   Mon, 28 Nov 2022 10:49:39 +0100
Message-Id: <20221128094939.801232-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2846; i=ardb@kernel.org; h=from:subject; bh=IYgx8aYCHMJXqPUUbXfcldTTpG8Zc+8llafQDmuZ0BM=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjhIQy5KUt+463PJ61h9EDy8Z6Tn0PzpB7nPv4STEH vzqoQLeJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY4SEMgAKCRDDTyI5ktmPJE81C/ 9JFizrIyQvMOlqntS5kSRv6ubuJ0JGeaHelmY6ZT72o9qHVucvCkKip9I7lNtW41QbjfJihQfYIlmp x6bkrtyq4cBd8kROczFj9a9TqCfc1WyqaO5Qi+pyHoBwcWSL+RVjyHULc63fRLMaVM8ov/jAF00fXz Bz0YPwQhfkSEIxzo3jFET0hLtK4On7b0r+Su0fjtRkC9mVnXWYh+rB+vGxcVUoIXKFVxaPnq1ep1OB zY/rql6ch1AtI4VViTSIyyqPnr012eHL+sqqxh921CZQhRYAEQ1pwMWD6Uha3aVIKqTcKq4ojg/Sv1 MLD/C39XxMUkLdc9DoXhtX9P1pYrfLml0fDF5qYOfrPbz5se7t3Dk95zPqi468//eBWcBnc6k28Y8N YZHcbd3QkqhZn7wC8hwdngqgVSUvLqS8Qm5MtS3QK/XGf/QlKzC5gp236V1jX2yzAlqjq7lNLX6MJT KqH4EMxnDkxOXJI4H+6TwxW8Fx0PhuKwrdLRrwnPfSlak=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Prevent abuse of the runtime service wrapper code by avoiding restoring
the shadow call stack pointer from the ordinary stack, or the stack
pointer itself from a GPR. Also, given that the exception recovery
routine is never called in an ordinary way, it doesn't need BTI landing
pads so it can be SYM_CODE rather than SYM_FUNC.

Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/efi-rt-wrapper.S | 16 +++++++++-------
 arch/arm64/kernel/efi.c            |  6 +++++-
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/efi-rt-wrapper.S b/arch/arm64/kernel/efi-rt-wrapper.S
index 67babd5f04c27c7a..afd3e81e1b627b87 100644
--- a/arch/arm64/kernel/efi-rt-wrapper.S
+++ b/arch/arm64/kernel/efi-rt-wrapper.S
@@ -28,7 +28,7 @@ SYM_FUNC_START(__efi_rt_asm_wrapper)
 	stp	x27, x28, [sp, #96]
 
 	adr_this_cpu	x8, __efi_rt_asm_recover_sp, x9
-	str		x29, [x8]
+	stp		x29, x18, [x8]
 
 	/*
 	 * We are lucky enough that no EFI runtime services take more than
@@ -56,15 +56,17 @@ SYM_FUNC_START(__efi_rt_asm_wrapper)
 	 * called with preemption disabled and a separate shadow stack is used
 	 * for interrupts.
 	 */
-	mov	x18, x2
+#ifdef CONFIG_SHADOW_CALL_STACK
+	ldr_this_cpu	x18, __efi_rt_asm_recover_sp + 8, x9
+#endif
+
 	b	efi_handle_corrupted_x18	// tail call
 SYM_FUNC_END(__efi_rt_asm_wrapper)
 
-SYM_FUNC_START(__efi_rt_asm_recover)
-	ldr_this_cpu	x8, __efi_rt_asm_recover_sp, x9
-	mov		sp, x8
+SYM_CODE_START(__efi_rt_asm_recover)
+	mov	sp, x30
 
-	ldp	x0,  x18, [sp, #16]
+	ldr	x0, [sp, #16]
 	ldp	x19, x20, [sp, #32]
 	ldp	x21, x22, [sp, #48]
 	ldp	x23, x24, [sp, #64]
@@ -73,4 +75,4 @@ SYM_FUNC_START(__efi_rt_asm_recover)
 	ldp	x29, x30, [sp], #112
 
 	b	efi_handle_runtime_exception
-SYM_FUNC_END(__efi_rt_asm_recover)
+SYM_CODE_END(__efi_rt_asm_recover)
diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 8d36e66a6e64cdaa..db7bdce1c7da578b 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -130,7 +130,7 @@ asmlinkage efi_status_t efi_handle_corrupted_x18(efi_status_t s, const char *f)
 	return s;
 }
 
-asmlinkage DEFINE_PER_CPU(u64, __efi_rt_asm_recover_sp);
+asmlinkage DEFINE_PER_CPU(u64[2], __efi_rt_asm_recover_sp);
 
 asmlinkage efi_status_t __efi_rt_asm_recover(void);
 
@@ -151,6 +151,10 @@ bool efi_runtime_fixup_exception(struct pt_regs *regs, const char *msg)
 	add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
 	dump_stack();
 
+	regs->regs[30] = __this_cpu_read(__efi_rt_asm_recover_sp[0]);
+#ifdef CONFIG_SHADOW_CALL_STACK
+	regs->regs[18] = __this_cpu_read(__efi_rt_asm_recover_sp[1]);
+#endif
 	regs->pc = (u64)__efi_rt_asm_recover;
 	return true;
 }
-- 
2.35.1

