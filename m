Return-Path: <linux-efi+bounces-3514-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C873FAA546C
	for <lists+linux-efi@lfdr.de>; Wed, 30 Apr 2025 21:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32FEA4E51EC
	for <lists+linux-efi@lfdr.de>; Wed, 30 Apr 2025 19:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58A0218EB1;
	Wed, 30 Apr 2025 19:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DOdlrjdk"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BA9264637;
	Wed, 30 Apr 2025 19:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746039939; cv=none; b=V7drSwGm/MsOPDloI0zSp0HTLkdE5RFQ2BkelwMHF5xiUjB4BwSNTOK6YsY1utKLozGcZBIc2cHOSS98ICvgdOawjQ/RiXVv/zUa9r4WY91KI6zqTraUSbFAdlaGo0N6E0bfTeDD9rsHQ/ZHBbCI+g1nThYY5pNRj8lWtIChwxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746039939; c=relaxed/simple;
	bh=c1t7eSCAiZvlDZ61BADgLXDcTsFS9P5pvZzP3toCeYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/zDVeyNSnmLdtOYPDxnWARH2Ie5XsMX/atagH0U/x6p0Tn24cAEF7KfduzY2pAEX/gfXfD+OQtoJO6dfQiFFQRmWvsx2C8gmtUu4XiEznzvuAIrfyshUMF8uuEhsM9scOSCVNI7nYvYWJMTwqk1q46P045f+w2zhJJzUuqug4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DOdlrjdk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SZpm4TgHj412fYO7BdCfyFSDw7jiNAUl9vwargqx/Rk=; b=DOdlrjdkgaCJo/0QeF/REiXRlS
	4muQ2b/Ybj2RxdRdNbn5CJh++Hoq5ugLSFVuzOBtHb3e25QU+zgSrAdxGLKX4TzAt0Vru7BL6UXXf
	7uf5+VnjfFYHg9IEqPpjM7qN9lbHTFbtp/Dey6enHVezdxXIeXoY82Uj+6c6TE75vgvBciMKfWtx5
	ZRJ9II18Ye34Y9ozpaviV9ku7EnmuEGoBXgUdLqLZOI7XIm6TUFaz24U9WTN6Yrcmgy6QssRzsUU3
	h+0Fpbh94bL8/zPL4ptQNbNVvyoV5fidWsg9g48lHiIh3HymAE8mHGJEVkVUwlwUqDa0cKQteiJ5m
	oPLTT1Bg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uACkE-0000000DYz6-430N;
	Wed, 30 Apr 2025 19:05:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 29331300642; Wed, 30 Apr 2025 21:05:22 +0200 (CEST)
Date: Wed, 30 Apr 2025 21:05:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, seanjc@google.com, pbonzini@redhat.com,
	ardb@kernel.org, kees@kernel.org, Arnd Bergmann <arnd@arndb.de>,
	gregkh@linuxfoundation.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-efi@vger.kernel.org, samitolvanen@google.com,
	ojeda@kernel.org
Subject: Re: [PATCH v2 02/13] x86/kvm/emulate: Introduce COP1
Message-ID: <20250430190521.GP4439@noisy.programming.kicks-ass.net>
References: <20250430110734.392235199@infradead.org>
 <20250430112349.208590367@infradead.org>
 <mw73dy5rhbbdcknxjhupsgmp3wdkedtlstwaqxonjzl6z627f7@bxxop3txiom5>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mw73dy5rhbbdcknxjhupsgmp3wdkedtlstwaqxonjzl6z627f7@bxxop3txiom5>

On Wed, Apr 30, 2025 at 09:19:38AM -0700, Josh Poimboeuf wrote:
> On Wed, Apr 30, 2025 at 01:07:36PM +0200, Peter Zijlstra wrote:
> > +++ b/arch/x86/kvm/emulate.c
> > @@ -267,11 +267,56 @@ static void invalidate_registers(struct
> >  		     X86_EFLAGS_PF|X86_EFLAGS_CF)
> >  
> >  #ifdef CONFIG_X86_64
> > -#define ON64(x) x
> > +#define ON64(x...) x
> >  #else
> >  #define ON64(x)
> 
> Doesn't the 32-bit version need to be 
> 
>   #define ON64(x...)
> 
> since it now accepts multiple "args"?

Right, so far the robot hasn't complained, but yeah, consistency would
demand this :-)

> > -FASTOP1(not);
> > -FASTOP1(neg);
> > -FASTOP1(inc);
> > -FASTOP1(dec);
> > +COP1(not);
> > +COP1(neg);
> > +COP1(inc);
> > +COP1(dec);
> 
> I assume COP stands for "C op", but that will never be obvious.

Aww :-)

Right before sending I wondered if EM_ASM_*() would be a better
namespace.

