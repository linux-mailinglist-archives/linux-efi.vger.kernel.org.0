Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326FA611556
	for <lists+linux-efi@lfdr.de>; Fri, 28 Oct 2022 17:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbiJ1PBn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Oct 2022 11:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiJ1PB0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 28 Oct 2022 11:01:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEB31905F3
        for <linux-efi@vger.kernel.org>; Fri, 28 Oct 2022 08:01:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC87562900
        for <linux-efi@vger.kernel.org>; Fri, 28 Oct 2022 15:01:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8ADBC433D7;
        Fri, 28 Oct 2022 15:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666969284;
        bh=dihYPMNuXKjQgsQD/+2B9Ye3RFiW8N8piXGZu0YF3YI=;
        h=From:To:Cc:Subject:Date:From;
        b=dmYW3xrPAs4mWmWZEkbz5LpwQ88qSDDVqkoAyJRw8nP6ddflLKYdZT0IJN6RfpP3o
         6ACdUuFM3kObyKFVqH7c4TahtTESqbJWXSWu6yrLcHNqfsNyjTULS88PKk7ScLpFMF
         RNNtezC1xI6x/NOGn1EOBA519PXLda2ubWsMpKfoRgMcV6W61N2w3Uypuz50eneX21
         2ZBkiktFd1LhyvrOk4fzye0c7AJnjaxzH3VEVs1z+3fzh5kA4D+fCRSiiCLycTFU/i
         3RnTWio+vpX394qZyWAWQZtCAkLCfqLvWVEUDQX5eWn1UCEOOePoZar7HcTyeMQS9b
         3nZGmBsu7VoKQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com, maz@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] arm64: efi: Recover from synchronous exceptions occurring in firmware
Date:   Fri, 28 Oct 2022 17:01:12 +0200
Message-Id: <20221028150112.2883620-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5757; i=ardb@kernel.org; h=from:subject; bh=dihYPMNuXKjQgsQD/+2B9Ye3RFiW8N8piXGZu0YF3YI=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjW+63hlnXDVKFZbZXpgkUZ/sLOYyjrFGqcOCgXRUq yaFAqdqJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY1vutwAKCRDDTyI5ktmPJMLEC/ 9tbDE/9/ud7od97MIaGgkoYrvW33vL9qb/2MFXsn+7KEH3Jq6GQHH+Q0XFAzfGRZ1++oJpTMKp3IzY QOxO6LC+1Qfd++5BpxTU57p581f2EMVLk8w5ZXuFAHaRzWG8BkT3nC8jlo+nMUKLeEWz1TUQrIFPf4 7ekqin9NEFUsgyBmTrPWTMWYgHQ+MJ9BZaClA+bCTt6Apn31BHBW+UuqcMK92ZEYh0HeN+Jm3CjMQe LqyAVnGlI3+HHx/eRpU812Y9Wf9a/CbMqA+1cLEOuB9K7QJePPihKhVbBQyEhrRn5e79A0GpugcAfV DQ1eTNz/lkhkFALjqFon8JimMIU2ZBxpPEgb+QcJX7PJ3bNfzUQaFMxn4uYC+bFf/3xzG0jC0CtWQH XX2/WNoDXVsNb8+Vr2yBza3gTS2rCvlC+gqwPQNRhLKYVMYeYIIBTbL3AS37jL6SQTZ3WXceOhUDbk yuwLmu6WtybLC8URCymYV5d1I0r2r+3zfYZOu9FwrStpc=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
---
 arch/arm64/include/asm/efi.h       |  8 ++++++++
 arch/arm64/kernel/efi-rt-wrapper.S | 33 ++++++++++++++++++++++++++++--
 arch/arm64/kernel/efi.c            | 26 +++++++++++++++++++++++
 arch/arm64/mm/fault.c              |  4 ++++
 4 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 439e2bc5d5d8..d6cf535d8352 100644
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
index 75691a2641c1..67babd5f04c2 100644
--- a/arch/arm64/kernel/efi-rt-wrapper.S
+++ b/arch/arm64/kernel/efi-rt-wrapper.S
@@ -6,7 +6,7 @@
 #include <linux/linkage.h>
 
 SYM_FUNC_START(__efi_rt_asm_wrapper)
-	stp	x29, x30, [sp, #-32]!
+	stp	x29, x30, [sp, #-112]!
 	mov	x29, sp
 
 	/*
@@ -16,6 +16,20 @@ SYM_FUNC_START(__efi_rt_asm_wrapper)
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
+	adr_this_cpu	x8, __efi_rt_asm_recover_sp, x9
+	str		x29, [x8]
+
 	/*
 	 * We are lucky enough that no EFI runtime services take more than
 	 * 5 arguments, so all are passed in registers rather than via the
@@ -31,7 +45,7 @@ SYM_FUNC_START(__efi_rt_asm_wrapper)
 
 	ldp	x1, x2, [sp, #16]
 	cmp	x2, x18
-	ldp	x29, x30, [sp], #32
+	ldp	x29, x30, [sp], #112
 	b.ne	0f
 	ret
 0:
@@ -45,3 +59,18 @@ SYM_FUNC_START(__efi_rt_asm_wrapper)
 	mov	x18, x2
 	b	efi_handle_corrupted_x18	// tail call
 SYM_FUNC_END(__efi_rt_asm_wrapper)
+
+SYM_FUNC_START(__efi_rt_asm_recover)
+	ldr_this_cpu	x8, __efi_rt_asm_recover_sp, x9
+	mov		sp, x8
+
+	ldp	x0,  x18, [sp, #16]
+	ldp	x19, x20, [sp, #32]
+	ldp	x21, x22, [sp, #48]
+	ldp	x23, x24, [sp, #64]
+	ldp	x25, x26, [sp, #80]
+	ldp	x27, x28, [sp, #96]
+	ldp	x29, x30, [sp], #112
+
+	b	efi_handle_runtime_exception
+SYM_FUNC_END(__efi_rt_asm_recover)
diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index e1be6c429810..7c1e62a20e1e 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -9,6 +9,7 @@
 
 #include <linux/efi.h>
 #include <linux/init.h>
+#include <linux/percpu.h>
 
 #include <asm/efi.h>
 
@@ -128,3 +129,28 @@ asmlinkage efi_status_t efi_handle_corrupted_x18(efi_status_t s, const char *f)
 	pr_err_ratelimited(FW_BUG "register x18 corrupted by EFI %s\n", f);
 	return s;
 }
+
+asmlinkage DEFINE_PER_CPU(u64, __efi_rt_asm_recover_sp);
+
+asmlinkage efi_status_t __efi_rt_asm_recover(void);
+
+asmlinkage efi_status_t efi_handle_runtime_exception(const char *f)
+{
+	pr_err(FW_BUG "Fault occurred in EFI runtime service %s()\n", f);
+	clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
+	return EFI_ABORTED;
+}
+
+bool efi_runtime_fixup_exception(struct pt_regs *regs, const char *msg)
+{
+	 /* Check whether the exception occurred while running the firmware */
+	if (current_work() != &efi_rts_work.work || regs->pc >= TASK_SIZE_64)
+		return false;
+
+	pr_err(FW_BUG "Unable to handle %s in EFI runtime service\n", msg);
+	add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
+	dump_stack();
+
+	regs->pc = (u64)__efi_rt_asm_recover;
+	return true;
+}
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 5b391490e045..3e9cf9826417 100644
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
 
-- 
2.35.1

