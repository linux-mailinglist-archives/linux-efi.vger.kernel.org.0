Return-Path: <linux-efi+bounces-3612-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9A0AABC07
	for <lists+linux-efi@lfdr.de>; Tue,  6 May 2025 09:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB8AE1C42CC4
	for <lists+linux-efi@lfdr.de>; Tue,  6 May 2025 07:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8783A2367D6;
	Tue,  6 May 2025 07:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZAQ3QZ5j"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71EB2343B6;
	Tue,  6 May 2025 07:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746516685; cv=none; b=hsMwDzSdVho2Ti3aM/xfcPJB7lHkEwpv/B/vwkGw+JbrMbz06C+yNtYhG+yUMVWkBPM4h/TcLtFl7hQN+nmFEpOHVBE+gyQ1QiQAwA9PQMAXR7d/IhwtazByyNrhvHESegMJXo6fmTaysUyYzxa9jFJorxqFg/bH6fgEG8+y+Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746516685; c=relaxed/simple;
	bh=3MFMFKTpvoycC4ErDW1aAMLFvTj2p3AIoaoGRL7FFac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUOoTTaGzJOYDECGqrzkBkHRA6TqnIkt4KD94qwVG0xVXnusg7mXV2zHUg6SRGrz/1ZyOzbWwNaZYz8+WRLGx6nQHYJHhmlzVM628DwDuu9n30Gzg7l8Z3avdsWm25aE7L9lMhiYtWfhIuEW5ltFIqFskRzAMYGUf+jUsDYRzcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZAQ3QZ5j; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Z8bIiaqqf7hK7/LPXDmXMUql27tUrzUQtZi3jDCElZo=; b=ZAQ3QZ5jU3LWyd0UL7/q0AH62B
	yZaJIXX/DgwzpsI8b9NwdokYhsZ8Ly8OQpjk+a/s1HQbmkvEvLsK2vOVvOXTKFqyra3a+4lvCv1CY
	ehYo1Nl6V78j9hLsYMGyg1WFyCWpNQUDPX1u/jHCoESzT588Lar1tofhIGs2njEtcDUHtmxuJS0q8
	avVa8DOFPXMfYV3Wfx+4Um2bKtS5IjQhKCKLjEHVhYi45Dn92s2+1uUzEe+LBbW7OIvZuK7URhUxL
	WnKFYk0UP/blwhHeFDjvVJpGqk7gWf3/OYs3z1GU6kVHYRoTjMHujhauxCgFm0zks36lx7FNZbAp/
	eyl1yWmw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCClb-00000003B9S-0Jnk;
	Tue, 06 May 2025 07:31:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C2717300321; Tue,  6 May 2025 09:31:00 +0200 (CEST)
Date: Tue, 6 May 2025 09:31:00 +0200
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
Message-ID: <20250506073100.GG4198@noisy.programming.kicks-ass.net>
References: <20250430110734.392235199@infradead.org>
 <8B86A3AE-A296-438C-A7A7-F844C66D0198@zytor.com>
 <20250430190600.GQ4439@noisy.programming.kicks-ass.net>
 <20250501103038.GB4356@noisy.programming.kicks-ass.net>
 <20250501153844.GD4356@noisy.programming.kicks-ass.net>
 <aBO9uoLnxCSD0UwT@google.com>
 <20250502084007.GS4198@noisy.programming.kicks-ass.net>
 <aBUiwLV4ZY2HdRbz@google.com>
 <20250503095023.GE4198@noisy.programming.kicks-ass.net>
 <p6mkebfvhxvtqyz6mtohm2ko3nqe2zdawkgbfi6h2rfv2gxbuz@ktixvjaj44en>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p6mkebfvhxvtqyz6mtohm2ko3nqe2zdawkgbfi6h2rfv2gxbuz@ktixvjaj44en>

On Sat, May 03, 2025 at 11:28:37AM -0700, Josh Poimboeuf wrote:
> On Sat, May 03, 2025 at 11:50:23AM +0200, Peter Zijlstra wrote:
> > > +++ b/arch/x86/entry/entry_64_fred.S
> > > @@ -116,7 +116,8 @@ SYM_FUNC_START(asm_fred_entry_from_kvm)
> > >  	movq %rsp, %rdi				/* %rdi -> pt_regs */
> > >  	call __fred_entry_from_kvm		/* Call the C entry point */
> > >  	POP_REGS
> > > -	ERETS
> > > +
> > > +	ALTERNATIVE "", __stringify(ERETS), X86_FEATURE_FRED
> > >  1:
> > >  	/*
> > >  	 * Objtool doesn't understand what ERETS does, this hint tells it that
> > > @@ -124,7 +125,7 @@ SYM_FUNC_START(asm_fred_entry_from_kvm)
> > >  	 * isn't strictly needed, but it's the simplest form.
> > >  	 */
> > >  	UNWIND_HINT_RESTORE
> > > -	pop %rbp
> > > +	leave
> > >  	RET
> > 
> > So this, while clever, might be a problem with ORC unwinding. Because
> > now the stack is different depending on the alternative, and we can't
> > deal with that.
> > 
> > Anyway, I'll go have a poke on Monday (or Tuesday if Monday turns out to
> > be a bank holiday :-).
> 
> Can we just adjust the stack in the alternative?
> 
> 	ALTERNATIVE "add $64 %rsp", __stringify(ERETS), X86_FEATURE_FRED

Yes, that should work. But I wanted to have a poke at objtool, so it
will properly complain about the mistake first.

