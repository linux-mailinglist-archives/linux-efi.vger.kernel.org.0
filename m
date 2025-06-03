Return-Path: <linux-efi+bounces-3813-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCEAACCB49
	for <lists+linux-efi@lfdr.de>; Tue,  3 Jun 2025 18:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8FF43A1107
	for <lists+linux-efi@lfdr.de>; Tue,  3 Jun 2025 16:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7589D23BF9F;
	Tue,  3 Jun 2025 16:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vp21XgMu"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E2D53365;
	Tue,  3 Jun 2025 16:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748968186; cv=none; b=LyjOaazRpQYlEpq4Y3+v7aSLCHInaFUx7WUrQpL4/XcLxmpJBtv01WJmNb1/GB8bFPFOK2uIQCCMN//Ttg33piBu7xF5rrjIf96C81jNiIR8WrTlyxtWh6aeDdo3BdZ6UZXnh856g+3PuBBdNcZmrpgqDNuJ/SHsiRxE6UBe1sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748968186; c=relaxed/simple;
	bh=V/fyaYLOrDY8tA1Rrph3iEASp/Sh9QR/Asau7/6kriQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZr/6Tczhj+YUt2BU05dZ/SD95P+RHZyjS5v3X3XftHgn8o7/ltmvvUrgbGqCcjBRLeMZ3FPJ4s9wGtqtIyg6MK+M0PI9172xQxupU7YQfDENO90/a9XZCdSf+9UGjUn1moBU5/ius7pTInbLaQdHNH3WXrYyWgs8KN8KSJ3kvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vp21XgMu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4AEDC4CEED;
	Tue,  3 Jun 2025 16:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748968185;
	bh=V/fyaYLOrDY8tA1Rrph3iEASp/Sh9QR/Asau7/6kriQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vp21XgMu2a3rofboHt9VBMYbLInMjoEss4LESBg1Vyokis/66aW3EdHaxu7WegGn/
	 apUgAYafNflj9+EEqpP8DWhwtm0JSVB7GuKPOgljivsBNgRNCFgx7fVVnCMyzp6gjP
	 YpBj5cY1CP7o2ypn/ChmLXFTHjrAMuwqDDKhetTum0Vt9KxdPRquOVU8IzkbypIRwS
	 bdYtncMNNVg6ZYNeUMsUoDawt+b0bkk079un3WsLt3aGni7mvXBEqazGWUc8QCtYA/
	 q4X5fBDw1cIVINMkI+AWjmIWd68l3A8QIJXlE7Zg9KXvJKKxcXf2F7nU5p7TjpjnO0
	 YVYjl8ORCUDag==
Date: Tue, 3 Jun 2025 09:29:43 -0700
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
Message-ID: <eegs5wq4eoqpu5yqlzug7icptiwzusracrp3nlmjkxwfywzvez@jngbkb3xqj6o>
References: <20250503095023.GE4198@noisy.programming.kicks-ass.net>
 <p6mkebfvhxvtqyz6mtohm2ko3nqe2zdawkgbfi6h2rfv2gxbuz@ktixvjaj44en>
 <20250506073100.GG4198@noisy.programming.kicks-ass.net>
 <20250506133234.GH4356@noisy.programming.kicks-ass.net>
 <vukrlmb4kbpcol6rtest3tsw4y6obopbrwi5hcb5iwzogsopgt@sokysuzxvehi>
 <20250528074452.GU39944@noisy.programming.kicks-ass.net>
 <20250528163035.GH31726@noisy.programming.kicks-ass.net>
 <20250528163557.GI31726@noisy.programming.kicks-ass.net>
 <20250529093017.GJ31726@noisy.programming.kicks-ass.net>
 <fp5amaygv37wxr6bglagljr325rsagllbabb62ow44kl3mznb6@gzk6nuukjgwv>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fp5amaygv37wxr6bglagljr325rsagllbabb62ow44kl3mznb6@gzk6nuukjgwv>

On Mon, Jun 02, 2025 at 10:43:42PM -0700, Josh Poimboeuf wrote:
> On Thu, May 29, 2025 at 11:30:17AM +0200, Peter Zijlstra wrote:
> > > > So the sequence of fail is:
> > > > 
> > > > 	push %rbp
> > > > 	mov %rsp, %rbp	# cfa.base = BP
> > > > 
> > > > 	SAVE
> > 
> > 	sub    $0x40,%rsp
> > 	and    $0xffffffffffffffc0,%rsp
> > 
> > This hits the 'older GCC, drap with frame pointer' case in OP_SRC_AND.
> > Which means we then hard rely on the frame pointer to get things right.
> > 
> > However, per all the PUSH/POP_REGS nonsense, BP can get clobbered.
> > Specifically the code between the CALL and POP %rbp below are up in the
> > air. I don't think it can currently unwind properly there.
> 
> RBP is callee saved, so there's no need to pop it or any of the other
> callee-saved regs.  If they were to change, that would break C ABI
> pretty badly.  Maybe add a skip_callee=1 arg to POP_REGS?

This compiles for me:

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index d83236b96f22..414f8bcf07ec 100644
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
@@ -113,29 +113,31 @@ For 32-bit we have the following conventions - kernel is built with
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
+	.endif
 
 .endm
 
-.macro PUSH_AND_CLEAR_REGS rdx=%rdx rcx=%rcx rax=%rax save_ret=0 clear_bp=1 unwind_hint=1
+.macro PUSH_AND_CLEAR_REGS rdx=%rdx rcx=%rcx rax=%rax save_ret=0 clear_callee=1 unwind_hint=1
 	PUSH_REGS rdx=\rdx, rcx=\rcx, rax=\rax, save_ret=\save_ret unwind_hint=\unwind_hint
-	CLEAR_REGS clear_bp=\clear_bp
+	CLEAR_REGS clear_callee=\clear_callee
 .endm
 
-.macro POP_REGS pop_rdi=1
+.macro POP_REGS pop_rdi=1 pop_callee=1
+.if \pop_callee
 	popq %r15
 	popq %r14
 	popq %r13
 	popq %r12
 	popq %rbp
 	popq %rbx
+.endif
 	popq %r11
 	popq %r10
 	popq %r9
diff --git a/arch/x86/entry/entry_64_fred.S b/arch/x86/entry/entry_64_fred.S
index 29c5c32c16c3..277f980c46fd 100644
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
+	POP_REGS pop_callee=0
+
+	ALTERNATIVE "mov %rbp, %rsp", __stringify(ERETS), X86_FEATURE_FRED
 1:
 	/*
 	 * Objtool doesn't understand what ERETS does, this hint tells it that

