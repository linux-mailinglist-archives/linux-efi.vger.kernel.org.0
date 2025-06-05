Return-Path: <linux-efi+bounces-3814-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97294ACF541
	for <lists+linux-efi@lfdr.de>; Thu,  5 Jun 2025 19:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6DC11882CBB
	for <lists+linux-efi@lfdr.de>; Thu,  5 Jun 2025 17:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6713F149C7B;
	Thu,  5 Jun 2025 17:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aud9rPAn"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3618E8633A;
	Thu,  5 Jun 2025 17:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749143985; cv=none; b=D6yyxXfALH4Fxe6feJf+eVee94B1OgeHFjdJlJ+TBJC/L7vqBzi3Op5Cr0yAb/O3zPvcb+fTRiZgmnIH9yPRC3n2LIlVse6JzmWLzeCsdbrN1tSNp+AvH5EI8eyqkEZdVqqnic/TzI4VG+u/qYTPK+hkUh/T5EvV2rDYazVZ6Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749143985; c=relaxed/simple;
	bh=ftjIODcJElgKCE4DU8BhMhWX2Y6yrqizED7saqK8bXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwCGWzTVjjZMU3sa6Rumgv0xBxmISKFkGEJszTQapIEsbgjrj6csRcHy684ZJePZSw+4APAsG8xQUG83vO6m/2JrgQxiH6mbE2Id7Dg0S1Se7EycAB6Zj9wRLq4ASF/uXGnQcggINYvBpPUsTHXsZ5E3NDLaw4f7mfIqjPJkAs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aud9rPAn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D0AC4CEE7;
	Thu,  5 Jun 2025 17:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749143984;
	bh=ftjIODcJElgKCE4DU8BhMhWX2Y6yrqizED7saqK8bXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aud9rPAnhm+5tgBEVIxf/CkuHsaLbcHonC6VLFjKIMGWx0eVNruJ9yB5qBB3E+6cU
	 dwIxG3BLYiCLdQKRU5CSjtLgz5SxzaIAUBLhCgYVxzHOorLuKTlVGY2QOuCIrIVNrS
	 vHhSyThu6wSK7HuwcG1imc9Cw7VdnRBqvl646fCPCzY/Fk3PPq1p+PdQx4zwIO3ZbY
	 wgeJCjyFJ3/Fa5DdI4NZZ0+AqqDqwCh0EzENmnApr694VvXGiWJG0xncKiSda33UuR
	 ayBzsxgaXcdY/GSDlEL/P5DpbN0Pw16OJRtMY2e7t0KEBM41jl8gF/2UnFCfkxqCON
	 A/6m/oA9iOGpQ==
Date: Thu, 5 Jun 2025 10:19:41 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sean Christopherson <seanjc@google.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, 
	wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, pbonzini@redhat.com, 
	ardb@kernel.org, kees@kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	gregkh@linuxfoundation.org, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-efi@vger.kernel.org, samitolvanen@google.com, 
	ojeda@kernel.org, xin@zytor.com
Subject: Re: [PATCH v2 00/13] objtool: Detect and warn about indirect calls
 in __nocfi functions
Message-ID: <4z4fhaqesjlevwiugiqpnxdths5qkkj7vd4q3wgdosu4p24ppl@nb6c2gybuwe5>
References: <p6mkebfvhxvtqyz6mtohm2ko3nqe2zdawkgbfi6h2rfv2gxbuz@ktixvjaj44en>
 <20250506073100.GG4198@noisy.programming.kicks-ass.net>
 <20250506133234.GH4356@noisy.programming.kicks-ass.net>
 <vukrlmb4kbpcol6rtest3tsw4y6obopbrwi5hcb5iwzogsopgt@sokysuzxvehi>
 <20250528074452.GU39944@noisy.programming.kicks-ass.net>
 <20250528163035.GH31726@noisy.programming.kicks-ass.net>
 <20250528163557.GI31726@noisy.programming.kicks-ass.net>
 <20250529093017.GJ31726@noisy.programming.kicks-ass.net>
 <fp5amaygv37wxr6bglagljr325rsagllbabb62ow44kl3mznb6@gzk6nuukjgwv>
 <eegs5wq4eoqpu5yqlzug7icptiwzusracrp3nlmjkxwfywzvez@jngbkb3xqj6o>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eegs5wq4eoqpu5yqlzug7icptiwzusracrp3nlmjkxwfywzvez@jngbkb3xqj6o>

On Tue, Jun 03, 2025 at 09:29:45AM -0700, Josh Poimboeuf wrote:
> On Mon, Jun 02, 2025 at 10:43:42PM -0700, Josh Poimboeuf wrote:
> > On Thu, May 29, 2025 at 11:30:17AM +0200, Peter Zijlstra wrote:
> > > > > So the sequence of fail is:
> > > > > 
> > > > > 	push %rbp
> > > > > 	mov %rsp, %rbp	# cfa.base = BP
> > > > > 
> > > > > 	SAVE
> > > 
> > > 	sub    $0x40,%rsp
> > > 	and    $0xffffffffffffffc0,%rsp
> > > 
> > > This hits the 'older GCC, drap with frame pointer' case in OP_SRC_AND.
> > > Which means we then hard rely on the frame pointer to get things right.
> > > 
> > > However, per all the PUSH/POP_REGS nonsense, BP can get clobbered.
> > > Specifically the code between the CALL and POP %rbp below are up in the
> > > air. I don't think it can currently unwind properly there.
> > 
> > RBP is callee saved, so there's no need to pop it or any of the other
> > callee-saved regs.  If they were to change, that would break C ABI
> > pretty badly.  Maybe add a skip_callee=1 arg to POP_REGS?
> 
> This compiles for me:

That last patch had a pretty heinous bug: it didn't adjust the stack
accordingly when it skipped the callee-saved pops.

But actually there's no need to pop *any* regs there.

asm_fred_entry_from_kvm() uses C function ABI, so changes to
callee-saved regs aren't allowed, and changes to caller-saved regs would
have no effect.

How about something like this?

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index d83236b96f22..e680afbf65b6 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -99,7 +99,7 @@ For 32-bit we have the following conventions - kernel is built with
 	.endif
 .endm
 
-.macro CLEAR_REGS clear_bp=1
+.macro CLEAR_REGS clear_callee=1
 	/*
 	 * Sanitize registers of values that a speculation attack might
 	 * otherwise want to exploit. The lower registers are likely clobbered
@@ -113,20 +113,19 @@ For 32-bit we have the following conventions - kernel is built with
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
diff --git a/arch/x86/entry/entry_64_fred.S b/arch/x86/entry/entry_64_fred.S
index 29c5c32c16c3..5d1eef193b79 100644
--- a/arch/x86/entry/entry_64_fred.S
+++ b/arch/x86/entry/entry_64_fred.S
@@ -112,11 +112,12 @@ SYM_FUNC_START(asm_fred_entry_from_kvm)
 	push %rax				/* Return RIP */
 	push $0					/* Error code, 0 for IRQ/NMI */
 
-	PUSH_AND_CLEAR_REGS clear_bp=0 unwind_hint=0
+	PUSH_AND_CLEAR_REGS clear_callee=0 unwind_hint=0
 	movq %rsp, %rdi				/* %rdi -> pt_regs */
 	call __fred_entry_from_kvm		/* Call the C entry point */
-	POP_REGS
-	ERETS
+	addq $C_PTREGS_SIZE, %rsp
+
+	ALTERNATIVE "mov %rbp, %rsp", __stringify(ERETS), X86_FEATURE_FRED
 1:
 	/*
 	 * Objtool doesn't understand what ERETS does, this hint tells it that
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index ad4ea6fb3b6c..d4f9bfdc24a7 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -94,6 +94,7 @@ static void __used common(void)
 
 	BLANK();
 	DEFINE(PTREGS_SIZE, sizeof(struct pt_regs));
+	OFFSET(C_PTREGS_SIZE, pt_regs, orig_ax);
 
 	/* TLB state for the entry code */
 	OFFSET(TLB_STATE_user_pcid_flush_mask, tlb_state, user_pcid_flush_mask);

