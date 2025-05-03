Return-Path: <linux-efi+bounces-3545-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CDEAA7FC8
	for <lists+linux-efi@lfdr.de>; Sat,  3 May 2025 11:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 711CA46491D
	for <lists+linux-efi@lfdr.de>; Sat,  3 May 2025 09:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2021BE23F;
	Sat,  3 May 2025 09:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jp5p9y8s"
X-Original-To: linux-efi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2891AF0C9;
	Sat,  3 May 2025 09:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746265839; cv=none; b=D8IHP93gnYzF4yvlAuTfUnyRRKV2qN7n7iS6ziTn7SA/M3jZhyfIn11ubSwdeqo3peKTia+T6bmYuLTSMLBxeCQuJ57YHdFIYxamoIfHGTRwrBE3XoBJYlTuPTcdsB5HmreRXCrkQZ2DHPwRhFbWREtxnHijeLjcwmcZZGQ+Y7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746265839; c=relaxed/simple;
	bh=gkmHBEEZgpAKHuvJtHJksQtBCm/39ztFxlfyUdImWgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1zp5KHUodgMTC3fIdbmprHN746mU0VJCU9AJnViR5Ev65ixhQmIMiUy+PwFR01Z5EqyArBD3Hc1VUZw9eRZ+8mfQwYwjGr6viZImV8g3BR/0OCLpVPiKI+6EIZJBHascgUImPNXcViYPOK8OFyRY6amHwwEglHWP1F6t0jJz2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jp5p9y8s; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eHC2397cZh2Zevg+s8fAwXnLYWIWM+Fy5VIPYrgXPno=; b=jp5p9y8sOe/bwgDRoQpaOHrlFJ
	oWfnRmTT8FOQ7wF6r6WMrT9Z3Nvci8Kt8You2sp58mCut8YE3FRspnPct4Q6SSnNhxpLfiVM1274h
	cDi2vn+rj0y8RiCoA6uXRfE5qZBYISiJ4dZzMe4N8elDtzoHK74Sw3w8aRkpk54wtzXP1gGBEmsa4
	AB6WgsU5Tnzu2hNWqH55mQJCrF2npqaVdxrtd1UD5NXEJRKGvkR/1LczSTBsYwPtcyUHBhsmWr61u
	xVO28WTq1Ppb5cK4uHtMXQ5cl7s+mZcRduER8opPpvZccW6aoNJrvJZIzDxnaOIfAq791fpOn1Ju3
	j3KKdjMA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uB9Vo-0000000FCS5-1PJe;
	Sat, 03 May 2025 09:50:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 98BF13003AF; Sat,  3 May 2025 11:50:23 +0200 (CEST)
Date: Sat, 3 May 2025 11:50:23 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sean Christopherson <seanjc@google.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, pbonzini@redhat.com, ardb@kernel.org,
	kees@kernel.org, Arnd Bergmann <arnd@arndb.de>,
	gregkh@linuxfoundation.org, jpoimboe@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-efi@vger.kernel.org,
	samitolvanen@google.com, ojeda@kernel.org, xin@zytor.com
Subject: Re: [PATCH v2 00/13] objtool: Detect and warn about indirect calls
 in __nocfi functions
Message-ID: <20250503095023.GE4198@noisy.programming.kicks-ass.net>
References: <20250430110734.392235199@infradead.org>
 <8B86A3AE-A296-438C-A7A7-F844C66D0198@zytor.com>
 <20250430190600.GQ4439@noisy.programming.kicks-ass.net>
 <20250501103038.GB4356@noisy.programming.kicks-ass.net>
 <20250501153844.GD4356@noisy.programming.kicks-ass.net>
 <aBO9uoLnxCSD0UwT@google.com>
 <20250502084007.GS4198@noisy.programming.kicks-ass.net>
 <aBUiwLV4ZY2HdRbz@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBUiwLV4ZY2HdRbz@google.com>

On Fri, May 02, 2025 at 12:53:36PM -0700, Sean Christopherson wrote:

> > So the FRED NMI code is significantly different from the IDT NMI code
> > and I really didn't want to go mixing those.
> > 
> > If we get a nested NMI I don't think it'll behave well.
> 
> Ah, because FRED hardwware doesn't have the crazy NMI unblocking behavior, and
> the FRED NMI entry code relies on that.

Just so.

> But I don't see why we need to care about NMIs from KVM, while they do bounce
> through assembly to create a stack frame, the actual CALL is direct to
> asm_exc_nmi_kvm_vmx().  If it's just the unwind hint that's needed, that

That part is all fine.


>  arch/x86/entry/entry_64_fred.S | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/entry/entry_64_fred.S b/arch/x86/entry/entry_64_fred.S
> index 29c5c32c16c3..7aff2f0a285f 100644
> --- a/arch/x86/entry/entry_64_fred.S
> +++ b/arch/x86/entry/entry_64_fred.S
> @@ -116,7 +116,8 @@ SYM_FUNC_START(asm_fred_entry_from_kvm)
>  	movq %rsp, %rdi				/* %rdi -> pt_regs */
>  	call __fred_entry_from_kvm		/* Call the C entry point */
>  	POP_REGS
> -	ERETS
> +
> +	ALTERNATIVE "", __stringify(ERETS), X86_FEATURE_FRED
>  1:
>  	/*
>  	 * Objtool doesn't understand what ERETS does, this hint tells it that
> @@ -124,7 +125,7 @@ SYM_FUNC_START(asm_fred_entry_from_kvm)
>  	 * isn't strictly needed, but it's the simplest form.
>  	 */
>  	UNWIND_HINT_RESTORE
> -	pop %rbp
> +	leave
>  	RET

So this, while clever, might be a problem with ORC unwinding. Because
now the stack is different depending on the alternative, and we can't
deal with that.

Anyway, I'll go have a poke on Monday (or Tuesday if Monday turns out to
be a bank holiday :-).

