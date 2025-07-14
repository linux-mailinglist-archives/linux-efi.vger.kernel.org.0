Return-Path: <linux-efi+bounces-4324-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D3EB03C46
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 12:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25313A460E
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 10:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2120248F7A;
	Mon, 14 Jul 2025 10:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B1MsDznr"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE401A38F9;
	Mon, 14 Jul 2025 10:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489909; cv=none; b=ZTLg0W+TlHdiFHA37bcwFBq/59g8l5Hao4HUziuVYbJpkozb0DcBJMRYCJrNJkV7a6qSixy+3NsRU1VUMjKd0+McvJHBqFBE4/yOI5J0eZRuERuOwixT33s3smMZGPzLgi02Ov+Es21vVnAhYYtrVxAnkyqSbXMcERe17PffPhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489909; c=relaxed/simple;
	bh=HcFn8Q0xwnm6suBA2N/nvS0KE9mbW5Qxd19hx1mLQMw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=GHFebNK5FE4tgBr+MKcCqYhdc0SGZ4z65wVGbICOpBaYRjwgDFWWtPyWxpCss8gu2x7LkOnQe6v4ex/d/5hGISIBGSGThB3vFxlrG4j+S9AVWYzQMru91pKZS272H+9NS9SXt+mU6WZezrAKKvGFTMeYXlW+3K4r/Hlgn8pJo2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B1MsDznr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=52GVqrYarxAbay9vWyxzRq6hCVQnEhJYo4bGbdbqIGI=; b=B1MsDznrPqmZQe8ozWqn7fJJUQ
	/wHbnnqTlr5zDinO+VkTdreppaIHQeD4c8YG7TA0RVJO2dfTWdfDOKzb7qulXrsb4+DcP6KUspmRc
	CEG57COZEkQl8+yQLGHBGGOSBPV5kSPWPA49wlw5RzwtEFLHuBSYOpdR1gUYmK+W2fzVqDX8AKpQf
	FGkQpnbVgqPpDj8pQR1lYPtr4/+KjArZFU/ii5Y28hKZAbgIcukMnjjywYKGykLudfekPLz4+IZkl
	pu/QGi8JUS2zmNjeJlqEgRC6Iqd2RG3L4JfbcC9Z429ogyOYkDMv5Aza1XnOEqwcV8HTTiYtD4eM0
	+YYXl+Cg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubGg1-00000006uLG-10BX;
	Mon, 14 Jul 2025 10:44:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 28779302E03; Mon, 14 Jul 2025 12:44:51 +0200 (CEST)
Message-ID: <20250714103441.245417052@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 14 Jul 2025 12:20:25 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: kys@microsoft.com,
 haiyangz@microsoft.com,
 wei.liu@kernel.org,
 decui@microsoft.com,
 tglx@linutronix.de,
 mingo@redhat.com,
 bp@alien8.de,
 dave.hansen@linux.intel.com,
 hpa@zytor.com,
 seanjc@google.com,
 pbonzini@redhat.com,
 ardb@kernel.org,
 kees@kernel.org,
 Arnd Bergmann <arnd@arndb.de>,
 gregkh@linuxfoundation.org,
 jpoimboe@kernel.org,
 peterz@infradead.org,
 linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org,
 linux-efi@vger.kernel.org,
 samitolvanen@google.com,
 ojeda@kernel.org
Subject: [PATCH v3 14/16] x86/fred: Play nice with invoking asm_fred_entry_from_kvm() on non-FRED hardware
References: <20250714102011.758008629@infradead.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

Modify asm_fred_entry_from_kvm() to allow it to be invoked by KVM even
when FRED isn't fully enabled, e.g. when running with
CONFIG_X86_FRED=y on non-FRED hardware.  This will allow forcing KVM
to always use the FRED entry points for 64-bit kernels, which in turn
will eliminate a rather gross non-CFI indirect call that KVM uses to
trampoline IRQs by doing IDT lookups.

The point of asm_fred_entry_from_kvm() is to bridge between C
(vmx:handle_external_interrupt_irqoff()) and more C
(__fred_entry_from_kvm()) while changing the calling context to appear
like an interrupt (pt_regs). Making the whole thing bound by C ABI.

All that remains for non-FRED hardware is to restore RSP (to undo the
redzone and alignment). However the trivial change would result in
code like:

  push %rbp
  mov %rsp, %rbp

  sub $REDZONE, %rsp
  and $MASK, %rsp

  PUSH_AND_CLEAR_REGS
   push %rbp

  POP_REGS
   pop %rbp <-- *objtool fail*

  mov %rbp, %rsp
  pop %rbp
  ret

And this will confuse objtool something wicked -- it gets confused by
the extra pop %rbp, not realizing the push and pop preserve the value.

Rather than trying to each objtool about this, recognise that since
the code is bound by C ABI on both ends and interrupts are not allowed
to change pt_regs (only exceptions are) it is sufficient to PUSH_REGS
in order to create pt_regs, but there is no reason to POP_REGS --
provided the callee-saved registers are preserved.

So avoid clearing callee-saved regs and skip POP_REGS.

[Original patch by Sean; much of this version by Josh; Changelog,
comments and final form by Peterz]

Originally-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/calling.h       |   11 +++++------
 arch/x86/entry/entry_64_fred.S |   33 ++++++++++++++++++++++++++-------
 arch/x86/kernel/asm-offsets.c  |    1 +
 3 files changed, 32 insertions(+), 13 deletions(-)

--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -99,7 +99,7 @@ For 32-bit we have the following convent
 	.endif
 .endm
 
-.macro CLEAR_REGS clear_bp=1
+.macro CLEAR_REGS clear_callee=1
 	/*
 	 * Sanitize registers of values that a speculation attack might
 	 * otherwise want to exploit. The lower registers are likely clobbered
@@ -113,20 +113,19 @@ For 32-bit we have the following convent
 	xorl	%r9d,  %r9d	/* nospec r9  */
 	xorl	%r10d, %r10d	/* nospec r10 */
 	xorl	%r11d, %r11d	/* nospec r11 */
+	.if \clear_callee
 	xorl	%ebx,  %ebx	/* nospec rbx */
-	.if \clear_bp
 	xorl	%ebp,  %ebp	/* nospec rbp */
-	.endif
 	xorl	%r12d, %r12d	/* nospec r12 */
 	xorl	%r13d, %r13d	/* nospec r13 */
 	xorl	%r14d, %r14d	/* nospec r14 */
 	xorl	%r15d, %r15d	/* nospec r15 */
-
+	.endif
 .endm
 
-.macro PUSH_AND_CLEAR_REGS rdx=%rdx rcx=%rcx rax=%rax save_ret=0 clear_bp=1 unwind_hint=1
+.macro PUSH_AND_CLEAR_REGS rdx=%rdx rcx=%rcx rax=%rax save_ret=0 clear_callee=1 unwind_hint=1
 	PUSH_REGS rdx=\rdx, rcx=\rcx, rax=\rax, save_ret=\save_ret unwind_hint=\unwind_hint
-	CLEAR_REGS clear_bp=\clear_bp
+	CLEAR_REGS clear_callee=\clear_callee
 .endm
 
 .macro POP_REGS pop_rdi=1
--- a/arch/x86/entry/entry_64_fred.S
+++ b/arch/x86/entry/entry_64_fred.S
@@ -112,18 +112,37 @@ SYM_FUNC_START(asm_fred_entry_from_kvm)
 	push %rax				/* Return RIP */
 	push $0					/* Error code, 0 for IRQ/NMI */
 
-	PUSH_AND_CLEAR_REGS clear_bp=0 unwind_hint=0
+	PUSH_AND_CLEAR_REGS clear_callee=0 unwind_hint=0
+
 	movq %rsp, %rdi				/* %rdi -> pt_regs */
+	/*
+	 * At this point: {rdi, rsi, rdx, rcx, r8, r9}, {r10, r11}, {rax, rdx}
+	 * are clobbered, which corresponds to: arguments, extra caller-saved
+	 * and return. All registers a C function is allowed to clobber.
+	 *
+	 * Notably, the callee-saved registers: {rbx, r12, r13, r14, r15}
+	 * are untouched, with the exception of rbp, which carries the stack
+	 * frame and will be restored before exit.
+	 *
+	 * Further calling another C function will not alter this state.
+	 */
 	call __fred_entry_from_kvm		/* Call the C entry point */
-	POP_REGS
-	ERETS
-1:
+
+1:	/*
+	 * When FRED, use ERETS to potentially clear NMIs, otherwise simply
+	 * restore the stack pointer.
+	 */
+	ALTERNATIVE "nop; nop; mov %rbp, %rsp", \
+	            __stringify(add $C_PTREGS_SIZE, %rsp; ERETS), \
+		    X86_FEATURE_FRED
+
 	/*
-	 * Objtool doesn't understand what ERETS does, this hint tells it that
-	 * yes, we'll reach here and with what stack state. A save/restore pair
-	 * isn't strictly needed, but it's the simplest form.
+	 * Objtool doesn't understand ERETS, and the cfi register state is
+	 * different from initial_func_cfi due to PUSH_REGS. Tell it the state
+	 * is similar to where UNWIND_HINT_SAVE is.
 	 */
 	UNWIND_HINT_RESTORE
+
 	pop %rbp
 	RET
 
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -102,6 +102,7 @@ static void __used common(void)
 
 	BLANK();
 	DEFINE(PTREGS_SIZE, sizeof(struct pt_regs));
+	OFFSET(C_PTREGS_SIZE, pt_regs, orig_ax);
 
 	/* TLB state for the entry code */
 	OFFSET(TLB_STATE_user_pcid_flush_mask, tlb_state, user_pcid_flush_mask);



