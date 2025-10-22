Return-Path: <linux-efi+bounces-5081-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A38D5BFAE0C
	for <lists+linux-efi@lfdr.de>; Wed, 22 Oct 2025 10:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B0B84F430A
	for <lists+linux-efi@lfdr.de>; Wed, 22 Oct 2025 08:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F5C309DCB;
	Wed, 22 Oct 2025 08:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rFRRymTv"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F5D2FE060;
	Wed, 22 Oct 2025 08:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761121567; cv=none; b=MTIixetXCxyiGY8c48o6Yi7tN6+EcFZwrraYmdVYc9CYwhB+i1d5DR2QSED22/QNdtlMwyXBcHqzx/1EZ9bQPAhBEymKTYMOstGi91DUQz3PpGPlJKAlA41xjlgr6Dl7L2zrpz9VDNJ2ECOVuFhamvQqoyJagdprW0kK8mrAA5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761121567; c=relaxed/simple;
	bh=GcOayzrpL3XN45TYF8aRFDQHCEpABTubndQWUs/Olos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwyaE2l2pm2nhdfORft2qMFt5KuayWqpU8ua/6Uce/B64XsyR4CM0hnHhKwDqr8UATKmLQeuy70/o+Kb6EazE8xdZGmiZMBSiQ17RfPmQ2VPXIoV4zRf0ABvgQwdvCeRyUnusxE1iieEmV3UVU3VZzaKEIsujGK/8ihpDT0Ur4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rFRRymTv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HwH5x5HyQ0iNsnWYUIrOkwzBLLqSWs26PFnB9Hw9zrg=; b=rFRRymTvsxiHY5Z9kk6gQcPDdH
	q+LBhU6IgfqCPMOqEen7bfrcl/FO4M7yDOeIzepUAVgK8BejefMm/2wrIo2IzPrm01EjWc/3p5dYY
	IXKDjSEqQuLyzlVr/OG1j4WiAmIdzvXNy0RGvCHyoeBahthZWBtRPv8qFrUGmR5O3gbPSI6bm2zGF
	lPxbFuMuevP7QUkKT34AwysjhhFHQHQzycqeAomW/7DbQqKw8qnf99qOb58IOBuIPAXW2VIdQGbt8
	mhIjbqyQOhoW/ry50sMIlXZYxK9cVa56MToV19GO+h2b//S1mMkuK7dE7GeVPutVT1b74bkKONyxn
	aph1QZTw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBUA9-00000000cYB-2CVJ;
	Wed, 22 Oct 2025 08:25:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BB95330039F; Wed, 22 Oct 2025 10:25:41 +0200 (CEST)
Date: Wed, 22 Oct 2025 10:25:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Kirill A . Shutemov" <kas@kernel.org>, Xin Li <xin@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Sean Christopherson <seanjc@google.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	David Laight <david.laight.linux@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v10 03/15] x86/alternatives: Disable LASS when patching
 kernel alternatives
Message-ID: <20251022082541.GL4067720@noisy.programming.kicks-ass.net>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
 <20251007065119.148605-4-sohil.mehta@intel.com>
 <20251021200328.GMaPfnEDibnBrhNTmQ@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021200328.GMaPfnEDibnBrhNTmQ@fat_crate.local>

On Tue, Oct 21, 2025 at 10:03:28PM +0200, Borislav Petkov wrote:
> On Mon, Oct 06, 2025 at 11:51:07PM -0700, Sohil Mehta wrote:
> > +static __always_inline void lass_clac(void)
> > +{
> > +	alternative("", "clac", X86_FEATURE_LASS);
> > +}
> > +
> > +static __always_inline void lass_stac(void)
> > +{
> > +	alternative("", "stac", X86_FEATURE_LASS);
> > +}
> 
> So I probably missed the whole discussion on how we arrived at
> lass_{stac,clac}() but just in case, those names sound silly.
> 

Initially the suggestion was to use stac/clac directly iirc; but that
looses the information these are for LASS only. Hence the LASS specific
ones.

(its an unfortunate arch detail that LASS and SMAP both use the AC flag
and all that)

> diff --git a/arch/x86/include/asm/smap.h b/arch/x86/include/asm/smap.h
> index 3ecb4b0de1f9..066d83a6b1ff 100644
> --- a/arch/x86/include/asm/smap.h
> +++ b/arch/x86/include/asm/smap.h
> @@ -55,16 +55,8 @@ static __always_inline void stac(void)
>   * Use lass_stac()/lass_clac() when accessing kernel mappings
>   * (!_PAGE_USER) in the lower half of the address space.
>   */
> -
> -static __always_inline void lass_clac(void)
> -{
> -	alternative("", "clac", X86_FEATURE_LASS);
> -}
> -
> -static __always_inline void lass_stac(void)
> -{
> -	alternative("", "stac", X86_FEATURE_LASS);
> -}
> +#define lass_disable()		stac()
> +#define lass_enable()		clac()

But that's not the same, stac() and clac() are FEATURE_SMAP, these are
FEATURE_LASS.

If you really want the _disable _enable naming that's fine with me, but
then perhaps we should also s/clac/smap_disable/ and s/stac/smap_enable/
for consistency.

