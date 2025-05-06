Return-Path: <linux-efi+bounces-3617-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEB8AAC678
	for <lists+linux-efi@lfdr.de>; Tue,  6 May 2025 15:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C673716D070
	for <lists+linux-efi@lfdr.de>; Tue,  6 May 2025 13:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF29280032;
	Tue,  6 May 2025 13:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n7yeE+TB"
X-Original-To: linux-efi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2A4280A22;
	Tue,  6 May 2025 13:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746538368; cv=none; b=uMG6Wz4SsXvlmS2gLMsapXVch+liqSfk+8XCFvkMmIa15zg3PthkwXDpAKTiOnECgs6RER+BMSQ/l4eAyO2gOGj3OgLNPO1zSCc+9H57PVMFBY7OYvB/7kR5rRK5wIptVSpBtcxr+Y7p6G25NbHYPOm4azAkfJm4AGo3CLnvXkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746538368; c=relaxed/simple;
	bh=kSvXr+b2Hy2f2NJD4lZL4d9PEdA5TH8rETVkdgx3URI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBOLwVFWP50frwjvZVHE12G8TFc7vq2/RwInSSz4IgFqTUZ/863EK6LtueZrifghdY21l9PyU2gs0iv9PkvIHuLvkM3Ae2zWC5bCeuyNczD0WNBX8GoIQ3Q0ZSRCyKqtiw6pVNI9iYDwsk4esSmNlxjqZmjSYwEYcRO5IueBeFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=n7yeE+TB; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6cpI98hWfgFel/wjRnW+Dxp5TlwemkuKmbKCnMNw4jc=; b=n7yeE+TBrHIHKZGaVFCAVfDdd8
	9yrCGjO0R1hS6oa3Owmd6CNGJXpS+KKssrLwI8chILGFybjyYgLR3+ibpbybCmTC3F5dhTMqu5RK/
	LJRAiTsakNKkYNCTcht19eNNtRUst4+MUBY60lN/cPsf3AEpTCgRQxPpBM1OWUDD5rW+VJg62GqNw
	X5E2fqslkkasXgjPpctQx//H+7WbEeAacaB2Wq4REG4EWuEWxfyAVR0ReiBYTwP2MKohSXt+M7ihj
	nN1lL6geKsPbyDPTxVg4jhQKCgWYlUuagGEZIw3hC4CREIhjT0a/kPWMJuFJ9S1rjeX5+rE5xlAVQ
	8eADS2cQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uCIPS-0000000FeCx-3nP7;
	Tue, 06 May 2025 13:32:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4E72C300348; Tue,  6 May 2025 15:32:34 +0200 (CEST)
Date: Tue, 6 May 2025 15:32:34 +0200
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
Message-ID: <20250506133234.GH4356@noisy.programming.kicks-ass.net>
References: <8B86A3AE-A296-438C-A7A7-F844C66D0198@zytor.com>
 <20250430190600.GQ4439@noisy.programming.kicks-ass.net>
 <20250501103038.GB4356@noisy.programming.kicks-ass.net>
 <20250501153844.GD4356@noisy.programming.kicks-ass.net>
 <aBO9uoLnxCSD0UwT@google.com>
 <20250502084007.GS4198@noisy.programming.kicks-ass.net>
 <aBUiwLV4ZY2HdRbz@google.com>
 <20250503095023.GE4198@noisy.programming.kicks-ass.net>
 <p6mkebfvhxvtqyz6mtohm2ko3nqe2zdawkgbfi6h2rfv2gxbuz@ktixvjaj44en>
 <20250506073100.GG4198@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506073100.GG4198@noisy.programming.kicks-ass.net>

On Tue, May 06, 2025 at 09:31:00AM +0200, Peter Zijlstra wrote:
> On Sat, May 03, 2025 at 11:28:37AM -0700, Josh Poimboeuf wrote:
> > On Sat, May 03, 2025 at 11:50:23AM +0200, Peter Zijlstra wrote:
> > > > +++ b/arch/x86/entry/entry_64_fred.S
> > > > @@ -116,7 +116,8 @@ SYM_FUNC_START(asm_fred_entry_from_kvm)
> > > >  	movq %rsp, %rdi				/* %rdi -> pt_regs */
> > > >  	call __fred_entry_from_kvm		/* Call the C entry point */
> > > >  	POP_REGS
> > > > -	ERETS
> > > > +
> > > > +	ALTERNATIVE "", __stringify(ERETS), X86_FEATURE_FRED
> > > >  1:
> > > >  	/*
> > > >  	 * Objtool doesn't understand what ERETS does, this hint tells it that
> > > > @@ -124,7 +125,7 @@ SYM_FUNC_START(asm_fred_entry_from_kvm)
> > > >  	 * isn't strictly needed, but it's the simplest form.
> > > >  	 */
> > > >  	UNWIND_HINT_RESTORE
> > > > -	pop %rbp
> > > > +	leave
> > > >  	RET
> > > 
> > > So this, while clever, might be a problem with ORC unwinding. Because
> > > now the stack is different depending on the alternative, and we can't
> > > deal with that.
> > > 
> > > Anyway, I'll go have a poke on Monday (or Tuesday if Monday turns out to
> > > be a bank holiday :-).
> > 
> > Can we just adjust the stack in the alternative?
> > 
> > 	ALTERNATIVE "add $64 %rsp", __stringify(ERETS), X86_FEATURE_FRED
> 
> Yes, that should work. 

Nope, it needs to be "mov %rbp, %rsp". Because that is the actual rsp
value after ERETS-to-self.

> But I wanted to have a poke at objtool, so it
> will properly complain about the mistake first.

So a metric ton of fail here :/

The biggest problem is the UNWIND_HINT_RESTORE right after the
alternative. This ensures that objtool thinks all paths through the
alternative end up with the same stack. And hence won't actually
complain.

Second being of course, that in order to get IRET and co correct, we'd
need far more of an emulator.

Also, it actually chokes on this variant, and I've not yet figured out
why. Whatever state should be created by that mov, the restore hint
should wipe it all. But still the ORC generation bails with unknown base
reg -1.



