Return-Path: <linux-efi+bounces-4567-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BAFB29F34
	for <lists+linux-efi@lfdr.de>; Mon, 18 Aug 2025 12:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E0AB18A27E4
	for <lists+linux-efi@lfdr.de>; Mon, 18 Aug 2025 10:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E752258EF8;
	Mon, 18 Aug 2025 10:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WGzYcKZj"
X-Original-To: linux-efi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85DA2C2346;
	Mon, 18 Aug 2025 10:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755513444; cv=none; b=huMyitN2R/NnUTtuL9tX9Wypb0UH2qoz7wXwTtcUkCq5adDFYrDJ+nYcYhxKI0E2ycuULN2r/cxV3pJ4zEOCgk7/HNLtR8XNXK9E0puL7yU35pRgy5w/gKfz1jLyiq60nYbDySXbI9hhkXR2htvpNNw2O2rq+R1Ohjnyp8e+i2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755513444; c=relaxed/simple;
	bh=obRvKFjFF9Ph4yb683ydZkubdyABhWe8E+Nb4yeus5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJw7+G/Lx6kaTN1ArcDLWNebSrV6dABTAL9civ6Mva8nKSPsMIYaYH0+YfLqLWFLLtKV/7M2h2rxrUFP0UCUyLJpFD3lFSUlh/R5TKxWF6Pw9Ja4fyWLrp6AoRPcN/B/9w9KI5bN9IuXaL2R6gi5wI/JbK4lL2O5tA0PdvwlZL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WGzYcKZj; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KxEF2mWH99v4+b1UrI9IK7DaLZgRBo7s4tDuR3rNvE0=; b=WGzYcKZjsItpYvqVp29yV+vgRp
	y4Ct18bPaIkE+HS/bVCm2xb50P20W6c92pPHVUv8fAxu4m+m69fZgTHQ4GWekfIducpBwQFFlUmGz
	bfMwYmSZ+7H4xRsfd4uxfbWyBRH3ZcY1OBCzjZoh8aQQ/Pov4YUVyhINrjH1mZpJ4lX+kmgzzMXig
	4bRvwMNibvAXVosRpFLjtsvsAVJaJ0/Bgx1rz6n0EsRd0YOl/SBas2gF5X5eoY/nk8PJ2POafcD3Z
	ItEjON1qKKCUOBtW5+oYjqXLQzoqmOQ7yDza71uEpgc7A6vfawFANH/yuP1IBQ+z86KTcHmVfJEBe
	bg01KTiQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unxEk-0000000HLsT-1dC2;
	Mon, 18 Aug 2025 10:37:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E405530029B; Mon, 18 Aug 2025 12:37:09 +0200 (CEST)
Date: Mon, 18 Aug 2025 12:37:09 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sean Christopherson <seanjc@google.com>
Cc: x86@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, pbonzini@redhat.com, ardb@kernel.org,
	kees@kernel.org, Arnd Bergmann <arnd@arndb.de>,
	gregkh@linuxfoundation.org, jpoimboe@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-efi@vger.kernel.org,
	samitolvanen@google.com, ojeda@kernel.org
Subject: Re: [PATCH v3 07/16] x86/kvm/emulate: Introduce EM_ASM_1SRC2
Message-ID: <20250818103709.GE3289052@noisy.programming.kicks-ass.net>
References: <20250714102011.758008629@infradead.org>
 <20250714103440.394654786@infradead.org>
 <aIF7ZhWZxlkcpm4y@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIF7ZhWZxlkcpm4y@google.com>

On Wed, Jul 23, 2025 at 05:16:38PM -0700, Sean Christopherson wrote:
> For all of the KVM patches, please use
> 
>   KVM: x86:
> 
> "x86/kvm" is used for guest-side code, and while I hope no one will conflate this
> with guest code, the consistency is helpful.

Sure.

> On Mon, Jul 14, 2025, Peter Zijlstra wrote:
> > Replace the FASTOP1SRC2*() instructions.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  arch/x86/kvm/emulate.c |   34 ++++++++++++++++++++++++++--------
> >  1 file changed, 26 insertions(+), 8 deletions(-)
> > 
> > --- a/arch/x86/kvm/emulate.c
> > +++ b/arch/x86/kvm/emulate.c
> > @@ -317,6 +317,24 @@ static int em_##op(struct x86_emulate_ct
> >  	ON64(case 8: __EM_ASM_1(op##q, rax); break;) \
> >  	EM_ASM_END
> >  
> > +/* 1-operand, using "c" (src2) */
> > +#define EM_ASM_1SRC2(op, name) \
> > +	EM_ASM_START(name) \
> > +	case 1: __EM_ASM_1(op##b, cl); break; \
> > +	case 2: __EM_ASM_1(op##w, cx); break; \
> > +	case 4: __EM_ASM_1(op##l, ecx); break; \
> > +	ON64(case 8: __EM_ASM_1(op##q, rcx); break;) \
> > +	EM_ASM_END
> > +
> > +/* 1-operand, using "c" (src2) with exception */
> > +#define EM_ASM_1SRC2EX(op, name) \
> > +	EM_ASM_START(name) \
> > +	case 1: __EM_ASM_1_EX(op##b, cl); break; \
> > +	case 2: __EM_ASM_1_EX(op##w, cx); break; \
> > +	case 4: __EM_ASM_1_EX(op##l, ecx); break; \
> > +	ON64(case 8: __EM_ASM_1(op##q, rcx); break;) \
> 
> This needs to be __EM_ASM_1_EX().  Luckily, KVM-Unit-Tests actually has testcase
> for divq (somewhere in the morass of testcases).  I also now have an extension to
> the fastops selftest to explicitly test all four flavors of div-by-zero; I'll get
> it posted tomorrow.
> 
> (also, don't also me how long it took me to spot the copy+paste typo; I was full
>  on debugging the exception fixup code before I realized my local diff looked
>  "odd", *sigh*)

Urgh, sorry about that. Typically I use regex for these things, clearly
I messed up here.

Thanks and fixed!

