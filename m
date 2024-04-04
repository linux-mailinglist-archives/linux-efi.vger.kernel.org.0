Return-Path: <linux-efi+bounces-922-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEA5898A77
	for <lists+linux-efi@lfdr.de>; Thu,  4 Apr 2024 16:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 148D11C21590
	for <lists+linux-efi@lfdr.de>; Thu,  4 Apr 2024 14:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1B51C2AF;
	Thu,  4 Apr 2024 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aen+RE8a"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3F91BDE6;
	Thu,  4 Apr 2024 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712242530; cv=none; b=lKIuEBVAU2gBGydAiySPoAhvnd7N3rVPO8j1w/LifFULJNFZuWxT31TfrbqeDywOjeDYTcfyVWv2h6fdo0UoIAsmbBkWjlh3cfvb3nHvJEkoFvtBmpxBdjVGXG9xs+6LQzW7qZnaxcdzY6i8np+CUb+9e0TIbApp2Vsve6O0OxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712242530; c=relaxed/simple;
	bh=G9lUvFywXgRdKLfamnkBnonk8oOiR9MI0r12zS6dtX0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=M7QFfmio2YvYcrlL15LTlLDyF+1BrfFDLYZPNWnhUmZft8KcbUZViPyvPTISFgE1Qkg91KZjx7Mad69ZhXIL7ypl4CgNEzOCeF9TPch1D+7vY4mdn1bJsEkU2Grr7Pv4rrIebuXQSjkG45SI6ywagFxxIJyF/H7mRHdeOWd47Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aen+RE8a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D9FC433F1;
	Thu,  4 Apr 2024 14:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712242529;
	bh=G9lUvFywXgRdKLfamnkBnonk8oOiR9MI0r12zS6dtX0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=aen+RE8ak25vlpX9Pe4w1s2I0IEuN0Xe8dsQ4xMCxRg401Ddm7Z4hTU7uhk3fCUgW
	 GO+03+G0RSM+nLr2h8MsZmTZ+t+Y+YtN5Oi35yxECq2gH1KN+OeWgdWfs2BIGtmf07
	 ozPdiS8nUL1wFS7zlORa+rjPcklbJXgUy6Y0Nvdq7gILpx6w1PCgVGDid/HHCyyQSZ
	 egq4Ie94OJd3yeK5HZMzHWjCUNOtESyziFGcUDR12e/eav83l6kxPAo3YEAeC/nq/t
	 2mXF9RP0DOWmABFVLYJWd7tjKUhoJwdz2l7KDmUWMIYSV8FBFzmoolBXAxqTe/LYpm
	 Rk+PK0mphpHSg==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Apr 2024 17:55:22 +0300
Message-Id: <D0BFBFRVGG47.FXCTWETKP7H4@kernel.org>
Cc: "Andrew Cooper" <andrew.cooper3@citrix.com>, "Ard Biesheuvel"
 <ardb@kernel.org>, "Ross Philipson" <ross.philipson@oracle.com>, "Linux
 Kernel Mailing List" <linux-kernel@vger.kernel.org>, "the arch/x86
 maintainers" <x86@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, "Linux Crypto Mailing List"
 <linux-crypto@vger.kernel.org>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <dpsmith@apertussolutions.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, "Matthew Garrett" <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "luto@amacapital.net" <luto@amacapital.net>,
 "Arvind Sankar" <nivedita@alum.mit.edu>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
 <kanth.ghatraju@oracle.com>, <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v8 06/15] x86: Add early SHA support for Secure Launch
 early measurements
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Eric Biggers" <ebiggers@kernel.org>, "Andy Lutomirski"
 <luto@kernel.org>
X-Mailer: aerc 0.17.0
References: <CAMj1kXEmMBY_jc0uM5UgZbuZ3-C7NPKzg5AScaunyu9XzLgzZA@mail.gmail.com> <98ad92bb-ef17-4c15-88ba-252db2a2e738@citrix.com> <CAMj1kXFTu+bV2kQhAyu15hrYai20NcBLb4Zu8XG2Y-XjL0f+rw@mail.gmail.com> <1a8e69a7-89eb-4d36-94d6-0da662d8b72f@citrix.com> <CAMj1kXEvmGy9RJo4s8tECsFj2dufZ8jBPoJOEtkcGUoj+x2qsw@mail.gmail.com> <431a0b3a-47e5-4e61-a7fc-31cdf56f4e4c@citrix.com> <20240223175449.GA1112@sol.localdomain> <e641e2f1-16cf-4717-8a1f-8afac2644efe@citrix.com> <20240223183004.GE1112@sol.localdomain> <10db421c-77da-4a1c-a25e-2374a7a2ef79@app.fastmail.com> <20240403235635.GA24248@quark.localdomain>
In-Reply-To: <20240403235635.GA24248@quark.localdomain>

On Thu Apr 4, 2024 at 2:56 AM EEST, Eric Biggers wrote:
> On Wed, Apr 03, 2024 at 09:32:02AM -0700, Andy Lutomirski wrote:
> > On Fri, Feb 23, 2024, at 10:30 AM, Eric Biggers wrote:
> > > On Fri, Feb 23, 2024 at 06:20:27PM +0000, Andrew Cooper wrote:
> > >> On 23/02/2024 5:54 pm, Eric Biggers wrote:
> > >> > On Fri, Feb 23, 2024 at 04:42:11PM +0000, Andrew Cooper wrote:
> > >> >> Yes, and I agree.=C2=A0 We're not looking to try and force this i=
n with
> > >> >> underhand tactics.
> > >> >>
> > >> >> But a blind "nack to any SHA-1" is similarly damaging in the oppo=
site
> > >> >> direction.
> > >> >>
> > >> > Well, reviewers have said they'd prefer that SHA-1 not be included=
 and given
> > >> > some thoughtful reasons for that.  But also they've given suggesti=
ons on how to
> > >> > make the SHA-1 support more palatable, such as splitting it into a=
 separate
> > >> > patch and giving it a proper justification.
> > >> >
> > >> > All suggestions have been ignored.
> > >>=20
> > >> The public record demonstrates otherwise.
> > >>=20
> > >> But are you saying that you'd be happy if the commit message read
> > >> something more like:
> > >>=20
> > >> ---8<---
> > >> For better or worse, Secure Launch needs SHA-1 and SHA-256.
> > >>=20
> > >> The choice of hashes used lie with the platform firmware, not with
> > >> software, and is often outside of the users control.
> > >>=20
> > >> Even if we'd prefer to use SHA-256-only, if firmware elected to star=
t us
> > >> with the SHA-1 and SHA-256 backs active, we still need SHA-1 to pars=
e
> > >> the TPM event log thus far, and deliberately cap the SHA-1 PCRs in o=
rder
> > >> to safely use SHA-256 for everything else.
> > >> ---
> > >
> > > Please take some time to read through the comments that reviewers hav=
e left on
> > > previous versions of the patchset.
> >=20
> > So I went and read through the old comments, and I'm lost.  In brief su=
mmary:
> >=20
> > If the hardware+firmware only supports SHA-1, then some reviewers would=
 prefer
> > Linux not to support DRTM.  I personally think this is a bit silly, but=
 it's
> > not entirely unreasonable.  Maybe it should be a config option?
> >=20
> > If the hardware+firmware does support SHA-256, then it sounds (to me, r=
eading
> > this -- I haven't dug into the right spec pages) that, for optimal secu=
rity,
> > something still needs to effectively turn SHA-1 *off* at runtime by cap=
ping
> > the event log properly.  And that requires computing a SHA-1 hash.  And=
, to be
> > clear, (a) this is only on systems that already support SHA-256 and tha=
t we
> > should support and (b) *not* doing so leaves us potentially more vulner=
able to
> > SHA-1 attacks than doing so.  And no SHA-256-supporting tooling will ac=
tually
> > be compromised by a SHA-1 compromise if we cap the event log.
> >=20
> > So is there a way forward?  Just saying "read through the comments" see=
ms like
> > a dead end.
> >=20
>
> It seems there may be a justification for some form of SHA-1 support in t=
his
> feature.  As I've said, the problem is that it's not explained in the pat=
chset
> itself.  Rather, it just talks about "SHA" and pretends like SHA-1 and SH=
A-2 are
> basically the same.  In fact, SHA-1 differs drastically from SHA-2 in ter=
ms of
> security.  SHA-1 support should be added in a separate patch, with a clea=
rly
> explained rationale *in the patch itself* for the SHA-1 support *specific=
ally*.

Yeah, this is important so that we don't end up deleting that support
by accident. Just adding to denote that this more than just a "process
issue".

> - Eric

BR, Jarkko

