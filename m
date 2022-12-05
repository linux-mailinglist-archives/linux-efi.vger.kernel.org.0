Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870FD64355F
	for <lists+linux-efi@lfdr.de>; Mon,  5 Dec 2022 21:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbiLEUM0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 5 Dec 2022 15:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbiLEUMZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 5 Dec 2022 15:12:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B78127173
        for <linux-efi@vger.kernel.org>; Mon,  5 Dec 2022 12:12:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD0EB61307
        for <linux-efi@vger.kernel.org>; Mon,  5 Dec 2022 20:12:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E55C433D6;
        Mon,  5 Dec 2022 20:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670271143;
        bh=goSU823T86J6kjDXvEC7WqXZhLUmNmBC0euU4f+9sqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pabG0PJoEcvA1GNYvmeWie0JzlyOvvYvjlMpOv1O+MZx+Fcj0h5TkDOVLsZbJLJlF
         bmUD7/Ll51YvT7DtXdlBLm6bIvTZfeloy/iLOZVoHm0O3rtzL6hzqMrvsP/JP6Rexx
         LMisBcF0NiGJvzG2PEMN6yrcDmMwsm4RPRGLOK0zdB5rI4rnguy1DMyNjI/xlpLIZG
         VmaygdjHbnho7Ig/rcofsV6CDmsma7lFPjmLQcTZ2gZmsBF/4JVpsT7eWWyEWOnws7
         c8BXJc1bghpSk7UGQfk2G3keMyby4JUamptIgkTQUuH/gRfU6JFJcqTv62fH8oyvNP
         PkNSIbNTVZIdw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, will@kernel.org,
        catalin.marinas@arm.com, mark.rutland@arm.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 2/2] arm64: efi: Recover from synchronous exceptions occurring in firmware
Date:   Mon,  5 Dec 2022 21:12:10 +0100
Message-Id: <20221205201210.463781-3-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221205201210.463781-1-ardb@kernel.org>
References: <20221205201210.463781-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6103; i=ardb@kernel.org; h=from:subject; bh=goSU823T86J6kjDXvEC7WqXZhLUmNmBC0euU4f+9sqs=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjjlCZNXpWHY902aRBpsDx0WD587MJ0qaBcvGASIqi s6a+AGyJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY45QmQAKCRDDTyI5ktmPJEXjDA Cxjw9Hj4lduImg48FLjV21xlNgYnwOgZqEaZ8XrxM5aQqiNus3mMMI0IjaYlc9+rv3EAhcK57e9AFJ YY8WiIHJAufFtFnAPDBIqOdNJ+Vnqs4ZLFdhpzSj++bMI+MAQkTSlixKtSQKTWuoTQ2HE6MpNfYQX1 XZyH89ZaPvHx1kQYfMacsDO6lE3smrdMKvz1AR40vf9faTQ+97h6yh0arqLJM7/H31MYu7NxhqWmm2 0/QUPwvYe5z9ABhEqAMq9ktPFB7UJsCD8Qr1tU5Ei9UPLQ8b4q7SG6ogwxyNoyvW2CtC0uyuS8eVjV fXUWel0d69VjCApES2O3OhZcHj1Cdf935AOAA3AezZ6K/ADN2Jca5Ppm2GjjzB5I/NtZ5OMZ47DnHz 3j+G9EwM0eNMOlBmFFabjXImNobST9kVMUbrKBoT0oTDJdkCUdivXU4LkSkHa3NNgyPzokMLkqPKCT uCjOKgnC5W9hVsAhw0VHPOR2rZdXAoIEloyjPfhYRlYwQ=
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

Unlike x86, which has machinery to deal with page faults that occur
during the execution of EFI runtime services, arm64 has nothing like
that, and a synchronous exception raised by firmware code brings down
the whole system.

With more EFI based systems appearing that were not built to run Linux
(such as the Windows-on-ARM laptops based on Qualcomm SOCs), as well as
the introduction of PRM (platform specific firmware routines that are
callable just like EFI runtime services), we are more likely to run into
issues of this sort, and it is much more likely that we can identify and
work around such issues if they don't bring down the system entirely.

Since we already use a EFI runtime services call wrapper in assembler,
we can quite easily add some code that captures the execution state at
the point where the call is made, allowing us to revert to this state
and proceed execution if the call triggered a synchronous exception.

Given that the kernel and the firmware don't share any data structures
that could end up in an indeterminate state, we can happily continue
running, as long as we mark the EFI runtime services as unavailable from
that point on.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/efi.h            |  8 +++++
 arch/arm64/kernel/efi-rt-wrapper.S      | 31 ++++++++++++++++----
 arch/arm64/kernel/efi.c                 | 22 ++++++++++++++
 arch/arm64/mm/fault.c                   |  4 +++
 drivers/firmware/efi/runtime-wrappers.c |  1 +
 5 files changed, 61 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 1c408ec3c8b3a883..31d13a6001df49c4 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -14,8 +14,16 @@
 
 #ifdef CONFIG_EFI
 extern void efi_init(void);
+
+bool efi_runtime_fixup_exception(struct pt_regs *regs, const char *msg);
 #else
 #define efi_init()
+
+static inline
+bool efi_runtime_fixup_exception(struct pt_regs *regs, const char *msg)
+{
+	return false;
+}
 #endif
 
 int efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md);
diff --git a/arch/arm64/kernel/efi-rt-wrapper.S b/arch/arm64/kernel/efi-rt-wrapper.S
index b2786b968fee68dd..ee0c6c719ab573b7 100644
--- a/arch/arm64/kernel/efi-rt-wrapper.S
+++ b/arch/arm64/kernel/efi-rt-wrapper.S
@@ -6,7 +6,7 @@
 #include <linux/linkage.h>
 
 SYM_FUNC_START(__efi_rt_asm_wrapper)
-	stp	x29, x30, [sp, #-32]!
+	stp	x29, x30, [sp, #-112]!
 	mov	x29, sp
 
 	/*
@@ -16,11 +16,20 @@ SYM_FUNC_START(__efi_rt_asm_wrapper)
 	 */
 	stp	x1, x18, [sp, #16]
 
+	/*
+	 * Preserve all callee saved registers and record the stack pointer
+	 * value in a per-CPU variable so we can recover from synchronous
+	 * exceptions occurring while running the firmware routines.
+	 */
+	stp	x19, x20, [sp, #32]
+	stp	x21, x22, [sp, #48]
+	stp	x23, x24, [sp, #64]
+	stp	x25, x26, [sp, #80]
+	stp	x27, x28, [sp, #96]
+
 	ldr_l	x16, efi_rt_stack_top
 	mov	sp, x16
-#ifdef CONFIG_SHADOW_CALL_STACK
-	str	x18, [sp, #-16]!
-#endif
+	stp	x18, x29, [sp, #-16]!
 
 	/*
 	 * We are lucky enough that no EFI runtime services take more than
@@ -38,7 +47,7 @@ SYM_FUNC_START(__efi_rt_asm_wrapper)
 	mov	sp, x29
 	ldp	x1, x2, [sp, #16]
 	cmp	x2, x18
-	ldp	x29, x30, [sp], #32
+	ldp	x29, x30, [sp], #112
 	b.ne	0f
 	ret
 0:
@@ -56,3 +65,15 @@ SYM_FUNC_START(__efi_rt_asm_wrapper)
 
 	b	efi_handle_corrupted_x18	// tail call
 SYM_FUNC_END(__efi_rt_asm_wrapper)
+
+SYM_CODE_START(__efi_rt_asm_recover)
+	mov	sp, x30
+
+	ldp	x19, x20, [sp, #32]
+	ldp	x21, x22, [sp, #48]
+	ldp	x23, x24, [sp, #64]
+	ldp	x25, x26, [sp, #80]
+	ldp	x27, x28, [sp, #96]
+	ldp	x29, x30, [sp], #112
+	ret
+SYM_CODE_END(__efi_rt_asm_recover)
diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 8cb2e005f8aca589..0169a669fde7544f 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -149,6 +149,28 @@ DEFINE_SPINLOCK(efi_rt_lock);
 
 asmlinkage u64 *efi_rt_stack_top __ro_after_init;
 
+asmlinkage efi_status_t __efi_rt_asm_recover(void);
+
+bool efi_runtime_fixup_exception(struct pt_regs *regs, const char *msg)
+{
+	 /* Check whether the exception occurred while running the firmware */
+	if (current_work() != &efi_rts_work.work || regs->pc >= TASK_SIZE_64)
+		return false;
+
+	pr_err(FW_BUG "Unable to handle %s in EFI runtime service\n", msg);
+	add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
+	clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
+
+	regs->regs[0]	= EFI_ABORTED;
+	regs->regs[30]	= efi_rt_stack_top[-1];
+	regs->pc	= (u64)__efi_rt_asm_recover;
+
+	if (IS_ENABLED(CONFIG_SHADOW_CALL_STACK))
+		regs->regs[18] = efi_rt_stack_top[-2];
+
+	return true;
+}
+
 /* required by the EFI spec */
 static_assert(THREAD_SIZE >= SZ_8K);
 
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 5b391490e045be91..3e9cf9826417a434 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -30,6 +30,7 @@
 #include <asm/bug.h>
 #include <asm/cmpxchg.h>
 #include <asm/cpufeature.h>
+#include <asm/efi.h>
 #include <asm/exception.h>
 #include <asm/daifflags.h>
 #include <asm/debug-monitors.h>
@@ -391,6 +392,9 @@ static void __do_kernel_fault(unsigned long addr, unsigned long esr,
 		msg = "paging request";
 	}
 
+	if (efi_runtime_fixup_exception(regs, msg))
+		return;
+
 	die_kernel_fault(msg, addr, esr, regs);
 }
 
diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
index f3e54f6616f02475..7feee3d9c2bfbeec 100644
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -83,6 +83,7 @@ struct efi_runtime_work efi_rts_work;
 	else								\
 		pr_err("Failed to queue work to efi_rts_wq.\n");	\
 									\
+	WARN_ON_ONCE(efi_rts_work.status == EFI_ABORTED);		\
 exit:									\
 	efi_rts_work.efi_rts_id = EFI_NONE;				\
 	efi_rts_work.status;						\
-- 
2.35.1

