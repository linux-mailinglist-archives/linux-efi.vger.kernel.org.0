Return-Path: <linux-efi+bounces-3749-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F5EABA066
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 17:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 823849E47EF
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 15:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB531C4A10;
	Fri, 16 May 2025 15:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="AjJ9cePP"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4011B87C0;
	Fri, 16 May 2025 15:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747411050; cv=none; b=L9s7jdO0l7ce8BA1M3jpHkePURzr8yP796cqr3j/aWlx+5MJbdmN4uHC5btc6uAR94wkCf1c7tlIbhXOuGDz1Pa32mM8UxqyQXPMpNkaXaAPeESUCPH7jVb0MXyZo8DnyMGiSCnNQlR485XmbFaB6B9JVV6SxcwYVfK/FjDI/ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747411050; c=relaxed/simple;
	bh=vmOhw7E5n8ItXJtoI0Qn1bmqPGvIwGI25HVL824vRQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ny2gMgcJqkcypldFIs4NDA2kAJ5lL3vW+27DH3QtcMyC0jbhjmF9fP5sSIFNzr36IOO2HbAS02DRyduL65vIMR3saVcMgCcCQ71ha3S0eTqdAaXOdVOf4s0caqzFhfLlKq8ezijg5hZheW3KxYF0Hb9GBDjRLCYATjoZvdGRI3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=AjJ9cePP reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 766CD40E0196;
	Fri, 16 May 2025 15:57:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ftRXRXYPH5WN; Fri, 16 May 2025 15:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1747411039; bh=d43PR9DO7flii+mSU353fCYxRMVTIixhK4mXJVLuqvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AjJ9cePP7C8WJjPGUBhpAGUIwQSbXvP5Y/KBwNRbCto1Kl6rmnUL8kB7a0K2KaHxn
	 LGhLp8LxH9qEq8+sFBPRku+hXkZ3PEfcJyvaVCDSUSWQaAn/8+Ltab/SwVA3EYbCND
	 jGfZkEh3/ebi5b/5ZrGU4PtYGzBn4g9s5F1ZNdQdbY1wbt+3dFKoFQ+i1/PP1UnN/q
	 NNxdf3jACnj+RGPInrkxbcHDD+g3Ux1CqBCY+Rg1ma8HxxHgbagdPTfOwLKx33QeSW
	 dNCcDm08qDjhui2empuUurv/RQF624XAvLqcQnljUJWs064HWAagP0sdWnKKaAcrDU
	 mHnh79jqhtQi+5xKHbj1x+LFg2/Q0A3DEO8r4sH3F+asol1by69VEQxtNeAQf01UrL
	 bj9unSQqLzM+eQRyFbkem+pG2n0txW88XYnv1vm5dahcoNacRFefKL8byO5zAmj4r3
	 37XVv3oFzLA+bvCXaNnAznN5GQMrQ240rvo6oEQjFRv14I62aIul3lfp+TWFcmE3HX
	 W6ILZ3piqRAHkKJM3RXNHAOciA6tlL5YpWNfVEyYPUF6OTmbycA1K2s8ulRssHxsWI
	 LwsGoMbg3IdSEUybVtvSAS4VZz4i4hScxUGgeFWhLwhoEM+XRFCXqoHFzaPTvKY8qr
	 SavJA9Mp/Kz9zVtD0quep+QM=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F032F40E0239;
	Fri, 16 May 2025 15:56:55 +0000 (UTC)
Date: Fri, 16 May 2025 17:56:49 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Michael Roth <michael.roth@amd.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Juergen Gross <jgross@suse.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 3/3] x86/64/mm: Make 5-level paging support
 unconditional
Message-ID: <20250516155649.GFaCdgQa7sX75vOLSm@fat_crate.local>
References: <20250516091534.3414310-1-kirill.shutemov@linux.intel.com>
 <20250516091534.3414310-4-kirill.shutemov@linux.intel.com>
 <20250516153009.GEaCdaAdhCVpjaViSx@fat_crate.local>
 <aCdd60hwRbx207bU@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aCdd60hwRbx207bU@gmail.com>
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 05:46:51PM +0200, Ingo Molnar wrote:
>=20
> * Borislav Petkov <bp@alien8.de> wrote:
>=20
> > On Fri, May 16, 2025 at 12:15:33PM +0300, Kirill A. Shutemov wrote:
> > > @@ -173,10 +173,10 @@ For example, when an old kernel is running on=
 new hardware.
> > >  The kernel disabled support for it at compile-time
> > >  --------------------------------------------------
> > > =20
> > > -For example, if 5-level-paging is not enabled when building (i.e.,
> > > -CONFIG_X86_5LEVEL is not selected) the flag "la57" will not show u=
p [#f1]_.
> > > +For example, if Linear Address Masking (LAM) is not enabled when b=
uilding (i.e.,
> > > +CONFIG_ADDRESS_MASKING is not selected) the flag "lam" will not sh=
ow up.
> > >  Even though the feature will still be detected via CPUID, the kern=
el disables
> > > -it by clearing via setup_clear_cpu_cap(X86_FEATURE_LA57).
> > > +it by clearing via setup_clear_cpu_cap(X86_FEATURE_LAM).
> >=20
> > LOL, good one.
> >=20
> > The rest looks nice and good to me. And FWIW, it boots fine on my Zen=
5 with
> > 5lvl enabled.
> >=20
> > Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>

Bah, and I thought I'm replying to v3. :-\

Anyway...

> What's your preference on timing? v6.17 or v6.16?

Right, here's what I'm thinking:

* Kirill's patches would simplify Ard's cleanup a bit

* The 4th one: Kirill A. Shutemov ( :  85|) =E2=94=9C=E2=94=80>[PATCHv3 4=
/4] x86/paravirt: Restrict PARAVIRT_XXL to 64-bit only

looks ok too.

So, I don't see anything speaking against queueing them *now* for the upc=
oming
merge window, I am testing the tip lineup on a daily basis this and next =
week
and if it all looks good, we could probably send them.

If not, we delay.

And if there's other issues which get detected later, during the 6.16-rc
phase, we revert.

So we have an exit route from each scenario.

So I guess let's...

Unless I'm missing an aspect.

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

