Return-Path: <linux-efi+bounces-1168-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D608FC0C1
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jun 2024 02:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C68B280FF3
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jun 2024 00:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9A14C6C;
	Wed,  5 Jun 2024 00:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFnRrFoL"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B604A1E;
	Wed,  5 Jun 2024 00:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717547236; cv=none; b=X5FNSe8/xK+9CMNQg3ycy68UI+LlvXnwhVwKtx0aX1OA5SRvZ4iNRuk2v8LWt6zbQ6XlHs7NfGbLI7vLxrTRbKHk6E6c/obCxiLkaDLoNJCuchCmkQpL73/V7Xnr1qc4D9BZ9i6myzqvt3GLIH+J9hfDxW01BucDeql2icSIOyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717547236; c=relaxed/simple;
	bh=4912uwV8cdajJtlRg+qCEDg0Nk4Wff5MmTkSwg78oUw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Tp15LW1kGGUQo0HTdE9n1LS9YmTjGgG0hifcVh9voPHbCEbiY5AkxdxHdI5IXQ/SzyqLgYUfCK6vf4OURfivfWAYeSZb9Tq19/f+9fLFQ0eTw5D20y1q6jpRQE4ulWjfpnsKD2UCe1cxK2HlT5bbTtu4kNWqqAf9vipICU7pRyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFnRrFoL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB0BC2BBFC;
	Wed,  5 Jun 2024 00:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717547235;
	bh=4912uwV8cdajJtlRg+qCEDg0Nk4Wff5MmTkSwg78oUw=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=dFnRrFoLF3/EIZvvf7Lx45KFej7+drLQF6oOxWYkrAlSsPxFFHAPMi2qKBekBbJzR
	 ujcf8NZi/mktwGwZV6IUqmV+HhO3k4khQozt0qk4+4v9SFXBQpBR4aUnAmo2EvgFP8
	 5K42DdgGzhxORdDiCOrBYzJ8WSZRdSEGFu9AZeMAO5vRpyhg6OBGdzkbHSHPmW3qMG
	 ysZ0T/vnOktIEVNz2OurvuUJ/Mm9/830zbL1dkW6W3Yit+qdi1Hso9WCAg4K6WGwGu
	 9XwJprn8YNGhdx7BTbmPN2IRi0ho93rhoSmM3gFECyEdMApflMGwTNIlWVOhNjMsHh
	 z/fUw2/8zx8IA==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Jun 2024 03:27:08 +0300
Message-Id: <D1RNOFV1R1IK.2MSSUT0CAPVMB@kernel.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v9 04/19] x86: Secure Launch Resource Table header file
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, <ross.philipson@oracle.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-5-ross.philipson@oracle.com>
 <D1RFWFIJEYWL.2FC7V79321264@kernel.org>
 <1eca8cb1-4b3b-402b-993b-53de7c810016@oracle.com>
 <D1RLBMTUKRFN.34KQXEFZTBA08@kernel.org>
 <249a9b27-c18d-4377-8b51-9bc610b53a8b@oracle.com>
 <D1RNKV4JIE5L.1LNG82UAC916M@kernel.org>
In-Reply-To: <D1RNKV4JIE5L.1LNG82UAC916M@kernel.org>

On Wed Jun 5, 2024 at 3:22 AM EEST, Jarkko Sakkinen wrote:
> On Wed Jun 5, 2024 at 2:00 AM EEST,  wrote:
> > On 6/4/24 3:36 PM, Jarkko Sakkinen wrote:
> > > On Tue Jun 4, 2024 at 11:31 PM EEST,  wrote:
> > >> On 6/4/24 11:21 AM, Jarkko Sakkinen wrote:
> > >>> On Fri May 31, 2024 at 4:03 AM EEST, Ross Philipson wrote:
> > >>>> Introduce the Secure Launch Resource Table which forms the formal
> > >>>> interface between the pre and post launch code.
> > >>>>
> > >>>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> > >>>
> > >>> If a uarch specific, I'd appreciate Intel SDM reference here so tha=
t I
> > >>> can look it up and compare. Like in section granularity.
> > >>
> > >> This table is meant to not be architecture specific though it can
> > >> contain architecture specific sub-entities. E.g. there is a TXT spec=
ific
> > >> table and in the future there will be an AMD and ARM one (and hopefu=
lly
> > >> some others). I hope that addresses what you are pointing out or may=
be I
> > >> don't fully understand what you mean here...
> > >=20
> > > At least Intel SDM has a definition of any possible architecture
> > > specific data structure. It is handy to also have this available
> > > in inline comment for any possible such structure pointing out the
> > > section where it is defined.
> >
> > The TXT specific structure is not defined in the SDM or the TXT dev=20
> > guide. Part of it is driven by requirements in the TXT dev guide but=20
> > that guide does not contain implementation details.
> >
> > That said, if you would like links to relevant documents in the comment=
s=20
> > before arch specific structures, I can add them.
>
> Vol. 2D 7-40, in the description of GETSEC[WAKEUP] there is in fact a
> description of MLE JOINT structure at least:
>
> 1. GDT limit (offset 0)
> 2. GDT base (offset 4)
> 3. Segment selector initializer (offset 8)
> 4. EIP (offset 12)
>
> So is this only exercised in protect mode, and not in long mode? Just
> wondering whether I should make a bug report on this for SDM or not.
>
> Especially this puzzles me, given that x86s won't have protected
> mode in the first place...

That raises a relevant question: will this ever work in x86s? SDM does
not really support that it would but it could be also just outdated
information.

I'm neither sure how or will AMD align with x86s.

Just point out a glitch...

BR, Jarkko

