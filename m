Return-Path: <linux-efi+bounces-3816-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B69AD00C5
	for <lists+linux-efi@lfdr.de>; Fri,  6 Jun 2025 12:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57970172420
	for <lists+linux-efi@lfdr.de>; Fri,  6 Jun 2025 10:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F6C286887;
	Fri,  6 Jun 2025 10:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Torlej3I"
X-Original-To: linux-efi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AC62C3242;
	Fri,  6 Jun 2025 10:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749207005; cv=none; b=DD4bDpOW8zw5AGm683hlNZTdrPVgbhXOBzuBH1QwtmGfpL03FZh90PH/0vADWIgpiH9sVGQqo9JhAwszk6ZmLP9zCscs2tP9X6Fcc3QpFGuzcGf4ctA7lSy718naAKxjo8r7jFTQ8Oj6rYCw3PNNuMqQfHXV8nXXj3ucpEnkpiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749207005; c=relaxed/simple;
	bh=oVChse1wLr1LatGOtuMGq5IMy2U8hxvfsamh2B8qz9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=egNAsMWaGt+tkRvNT6XBKbJEFYDd7xZNFiqgtPD6wqaySV4/2waL5zi8d2pXUdlyZ+vF80Cpn2KlNDBJMZstraismxvxZnrV83y3QHjdtQv357iDZScVxgIm9oIeDcXwL+iVEBBDGO8O5ze/8zFPtkL4qgSNnqkwZ4l4UnHJ/Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Torlej3I; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RgB6+Le5gZuvkTyuy9hjeapQkiI3tD5aj0y4LFHCOn0=; b=Torlej3I0MsK1FluWphWjPqhsU
	dYVV1Iq3HXQwbpZ4GJPpspOkLrHMdyGDEmocb19R4VBLitr0DShyV9gUU1KA0nO2o8qHQ4oj2+Mea
	ZkYT8kN2mdJyfPOZoEcG1LqGibuuMfFVE8slw+g9N1tF9P4ndbI00fCWneAVBZjhgnSKacWOXwuVZ
	dvHSKONQ7BrU9xHYFYpVaKe8XVMmWNFrs7Co/CWhtFD3jWbnSEaN8tJD6YfV8XfTLZbPZz8HGoADB
	pz4Lo1m4tNt4yClsbpq3GMlZp8yEd2XAfRqjsD60qUBJfGi4UHjU6iCxBzPcPmt7PloO4J0n2f17N
	9SpAdLhQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNUdu-00000001GGo-2krp;
	Fri, 06 Jun 2025 10:49:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8F36B3005AF; Fri,  6 Jun 2025 12:49:45 +0200 (CEST)
Date: Fri, 6 Jun 2025 12:49:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, pbonzini@redhat.com, ardb@kernel.org,
	kees@kernel.org, Arnd Bergmann <arnd@arndb.de>,
	gregkh@linuxfoundation.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-efi@vger.kernel.org, samitolvanen@google.com,
	ojeda@kernel.org, xin@zytor.com
Subject: Re: [PATCH v2 00/13] objtool: Detect and warn about indirect calls
 in __nocfi functions
Message-ID: <20250606104945.GY39944@noisy.programming.kicks-ass.net>
References: <20250506073100.GG4198@noisy.programming.kicks-ass.net>
 <20250506133234.GH4356@noisy.programming.kicks-ass.net>
 <vukrlmb4kbpcol6rtest3tsw4y6obopbrwi5hcb5iwzogsopgt@sokysuzxvehi>
 <20250528074452.GU39944@noisy.programming.kicks-ass.net>
 <20250528163035.GH31726@noisy.programming.kicks-ass.net>
 <20250528163557.GI31726@noisy.programming.kicks-ass.net>
 <20250529093017.GJ31726@noisy.programming.kicks-ass.net>
 <fp5amaygv37wxr6bglagljr325rsagllbabb62ow44kl3mznb6@gzk6nuukjgwv>
 <eegs5wq4eoqpu5yqlzug7icptiwzusracrp3nlmjkxwfywzvez@jngbkb3xqj6o>
 <4z4fhaqesjlevwiugiqpnxdths5qkkj7vd4q3wgdosu4p24ppl@nb6c2gybuwe5>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4z4fhaqesjlevwiugiqpnxdths5qkkj7vd4q3wgdosu4p24ppl@nb6c2gybuwe5>

On Thu, Jun 05, 2025 at 10:19:41AM -0700, Josh Poimboeuf wrote:

> diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
> index d83236b96f22..e680afbf65b6 100644
> --- a/arch/x86/entry/calling.h
> +++ b/arch/x86/entry/calling.h
> @@ -99,7 +99,7 @@ For 32-bit we have the following conventions - kernel is built with
>  	.endif
>  .endm
>  
> -.macro CLEAR_REGS clear_bp=1
> +.macro CLEAR_REGS clear_callee=1
>  	/*
>  	 * Sanitize registers of values that a speculation attack might
>  	 * otherwise want to exploit. The lower registers are likely clobbered
> @@ -113,20 +113,19 @@ For 32-bit we have the following conventions - kernel is built with
>  	xorl	%r9d,  %r9d	/* nospec r9  */
>  	xorl	%r10d, %r10d	/* nospec r10 */
>  	xorl	%r11d, %r11d	/* nospec r11 */
> +	.if \clear_callee
>  	xorl	%ebx,  %ebx	/* nospec rbx */
> -	.if \clear_bp
>  	xorl	%ebp,  %ebp	/* nospec rbp */
> -	.endif
>  	xorl	%r12d, %r12d	/* nospec r12 */
>  	xorl	%r13d, %r13d	/* nospec r13 */
>  	xorl	%r14d, %r14d	/* nospec r14 */
>  	xorl	%r15d, %r15d	/* nospec r15 */
> -
> +	.endif
>  .endm
>  
> -.macro PUSH_AND_CLEAR_REGS rdx=%rdx rcx=%rcx rax=%rax save_ret=0 clear_bp=1 unwind_hint=1
> +.macro PUSH_AND_CLEAR_REGS rdx=%rdx rcx=%rcx rax=%rax save_ret=0 clear_callee=1 unwind_hint=1
>  	PUSH_REGS rdx=\rdx, rcx=\rcx, rax=\rax, save_ret=\save_ret unwind_hint=\unwind_hint
> -	CLEAR_REGS clear_bp=\clear_bp
> +	CLEAR_REGS clear_callee=\clear_callee
>  .endm
>  
>  .macro POP_REGS pop_rdi=1

Nice. So that leaves the callee-clobbered, extra caller-saved and return
registers cleared, and preserves the callee-saved regs.

> diff --git a/arch/x86/entry/entry_64_fred.S b/arch/x86/entry/entry_64_fred.S
> index 29c5c32c16c3..5d1eef193b79 100644
> --- a/arch/x86/entry/entry_64_fred.S
> +++ b/arch/x86/entry/entry_64_fred.S
> @@ -112,11 +112,12 @@ SYM_FUNC_START(asm_fred_entry_from_kvm)
>  	push %rax				/* Return RIP */
>  	push $0					/* Error code, 0 for IRQ/NMI */
>  
> -	PUSH_AND_CLEAR_REGS clear_bp=0 unwind_hint=0
> +	PUSH_AND_CLEAR_REGS clear_callee=0 unwind_hint=0
>  	movq %rsp, %rdi				/* %rdi -> pt_regs */
>  	call __fred_entry_from_kvm		/* Call the C entry point */
> -	POP_REGS
> -	ERETS
> +	addq $C_PTREGS_SIZE, %rsp
> +
> +	ALTERNATIVE "mov %rbp, %rsp", __stringify(ERETS), X86_FEATURE_FRED

So... I was wondering.. do we actually ever need the ERETS? AFAICT this
will only ever 'inject' external interrupts, and those are not supposed
to change the exception frame, like ever. Only exceptions get to change
the exception frame, but those are explicitly excluded in fred_extint().

As such, it should always be correct to just do:

	leave;
	RET;

at this point, and call it a day, no? Just completely forget about all
this sillyness with alternatives and funky stack state.

Only problem seems to be that if we do this, then
has_modified_stack_frame() has a fit, because of the register state.

The first to complain is bx, the push %rbx modifies the CFI state to
track where on the stack its saved, and that's not what initial_func_cfi
has.

We can stomp on that with UNWIND_HINT_FUNC right before RET. It's all a
bit magical, but should work, right?

So keeping your CLEAR_REGS changes, I've ended up with the below:

---
diff --git a/arch/x86/entry/entry_64_fred.S b/arch/x86/entry/entry_64_fred.S
index 29c5c32c16c3..8c03d04ea69d 100644
--- a/arch/x86/entry/entry_64_fred.S
+++ b/arch/x86/entry/entry_64_fred.S
@@ -62,8 +62,6 @@ SYM_FUNC_START(asm_fred_entry_from_kvm)
 	push %rbp
 	mov %rsp, %rbp
 
-	UNWIND_HINT_SAVE
-
 	/*
 	 * Both IRQ and NMI from VMX can be handled on current task stack
 	 * because there is no need to protect from reentrancy and the call
@@ -112,19 +110,35 @@ SYM_FUNC_START(asm_fred_entry_from_kvm)
 	push %rax				/* Return RIP */
 	push $0					/* Error code, 0 for IRQ/NMI */
 
-	PUSH_AND_CLEAR_REGS clear_bp=0 unwind_hint=0
+	PUSH_AND_CLEAR_REGS clear_callee=0 unwind_hint=0
 	movq %rsp, %rdi				/* %rdi -> pt_regs */
+
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
+	 * Therefore, all that remains to be done at this point is restore the
+	 * stack and frame pointer register.
+	 */
+	leave
 	/*
-	 * Objtool doesn't understand what ERETS does, this hint tells it that
-	 * yes, we'll reach here and with what stack state. A save/restore pair
-	 * isn't strictly needed, but it's the simplest form.
+	 * Objtool gets confused by the cfi register state; this doesn't match
+	 * initial_func_cfi because of PUSH_REGS, where it tracks where those
+	 * registers are on the stack.
+	 *
+	 * Forcefully make it forget this before returning.
 	 */
-	UNWIND_HINT_RESTORE
-	pop %rbp
+	UNWIND_HINT_FUNC
 	RET
 
 SYM_FUNC_END(asm_fred_entry_from_kvm)

