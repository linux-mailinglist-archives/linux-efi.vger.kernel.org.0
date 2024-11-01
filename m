Return-Path: <linux-efi+bounces-2086-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 409319B87C4
	for <lists+linux-efi@lfdr.de>; Fri,  1 Nov 2024 01:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61DE31F2289B
	for <lists+linux-efi@lfdr.de>; Fri,  1 Nov 2024 00:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841BC1C6B4;
	Fri,  1 Nov 2024 00:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXgSOas5"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473721C28E;
	Fri,  1 Nov 2024 00:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730421613; cv=none; b=ZMyl4BucxYRAqdWAGHZUEhpQIg0UpRIo47TneOuK/1shwEk+AkPboyrArtCHvwg6Q2b4i6qS551NwReQEbgVqqrHkIk7fLtSuQ+q+j4pX8d+19/T0Wy2ed8QFf4nPNyMeHlk75mBCNYV274nInsWRoSzoTMp572qnE6X2jw1a/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730421613; c=relaxed/simple;
	bh=khToelwF3PdjMHu9gLNv5hYj5GOCcxTEfxob0mgVilA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=jpt39u83+OQf8AT6dKGZS0kWLtXtpUO9Tub04vCKo9VfWT+O8EQxnBpOjhcmL9Lo44nJNsiL0XioMTcsfiNm9Rfe8nYLOdwEytaeKbZLGx4n1DHjstxB4VWGgCraF95ACuKeDyoyTmh4y87qHj6l/gJTe5UFgqmkwdnjunzUHoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXgSOas5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264FCC4CEC3;
	Fri,  1 Nov 2024 00:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730421611;
	bh=khToelwF3PdjMHu9gLNv5hYj5GOCcxTEfxob0mgVilA=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=oXgSOas5ntIz28xbfE5hezqUcn836bgtpllTMn49l3dpjLR0NYg63KL42ezR4M/Ve
	 cOUkJ4Ty7lmb9Mou3bnMu4wIqADozfZDN0aaJM7ilPFE5GKmFopHCxGZwzF5NC0UC8
	 zjDx5yC4ArMKz4XBEY0EGUlERnlhwUR8XKhGQKK+ZD4ECv81x32APPpKNVpyG+jDbK
	 t4jc4SPLwyK83kBANC6JFfN8hRpMjN8ry8Zx3mlJEUBUow5nk2IvJ0Ugx9joTMasFQ
	 X2T0dXuuCvecpb9JR/L//s/M+JjPzm6gORwws4z2/tOnxyEssozC2WzynhoQrBOgxd
	 NBpldRHdnNgGw==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 Nov 2024 02:40:07 +0200
Message-Id: <D5AF9K79H8WO.PVW93P31GHMH@kernel.org>
Cc: <dpsmith@apertussolutions.com>, <mingo@redhat.com>, <bp@alien8.de>,
 <hpa@zytor.com>, <dave.hansen@linux.intel.com>, <ardb@kernel.org>,
 <mjg59@srcf.ucam.org>, <James.Bottomley@hansenpartnership.com>,
 <peterhuewe@gmx.de>, <jgg@ziepe.ca>, <luto@amacapital.net>,
 <nivedita@alum.mit.edu>, <herbert@gondor.apana.org.au>,
 <davem@davemloft.net>, <corbet@lwn.net>, <ebiederm@xmission.com>,
 <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v11 00/20] x86: Trenchboot secure dynamic launch Linux
 kernel support
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Thomas Gleixner"
 <tglx@linutronix.de>, "Ross Philipson" <ross.philipson@oracle.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.18.2
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
 <87wmhoulb9.ffs@tglx> <D5ACNMVX5LXB.1L0S9P2J3UDJH@kernel.org>
 <87ldy3vpjh.ffs@tglx> <D5AF4HY1I6AA.27WRBDDGLYH39@kernel.org>
In-Reply-To: <D5AF4HY1I6AA.27WRBDDGLYH39@kernel.org>

On Fri Nov 1, 2024 at 2:33 AM EET, Jarkko Sakkinen wrote:
> On Fri Nov 1, 2024 at 1:08 AM EET, Thomas Gleixner wrote:
> > On Fri, Nov 01 2024 at 00:37, Jarkko Sakkinen wrote:
> > > On Thu Oct 31, 2024 at 9:25 PM EET, Thomas Gleixner wrote:
> > >> So this looks pretty reasonable to me by now and I'm inclined to tak=
e it
> > >> through the tip x86 tree, but that needs reviewed/acked-by's from th=
e
> > >> crypto and TPM folks. EFI has been reviewed already.
> > >>
> > >> Can we make progress on this please?
> > >
> > > So TPM patches do have bunch of glitches:
> > >
> > > - 15/20: I don't get this. There is nothing to report unless tree
> > >   is falling. The reported-by tag literally meaningless. Maybe this
> > >   is something that makes sense with this feature. Explain from that
> > >   angle.
> > > - 16/20: Is this actually a bug fix? If it is should be before 15/20.
> > > - 17/20: the commit message could do a better job explaining how the
> > >   locality can vary. I'm not sure how this will be used by rest of
> > >   the patch set.
> > > - 18/20: I'm not confident we want to give privilege to set locality
> > >   to the user space. The commit message neither makes a case of this.
> > >   Has this been tested to together with bus encryption (just checking=
)?
> >
> > Can you please explicitely voice your detailed technical concerns in
> > replies to the actual patches?
>
> - 15/20 looks like a rigged patch. I don't really know why it is done
>   so it is hard to either suggest how "resolve it".
> - 16/20 probably makes sense but if it is a bug fix or part of it is,
>   the bug fix should have relevant fixes etc tags so that it can be
>   picked up to stable kernels.
> - 17-18/20: I'd speak about this as the "one whole" i.e. here the
>   privilege to be able change locality during run-time is really
>   concerning. Could the locality be figured out for the kernel
>   command-line instead? The sysfs attribute can exist as read-only.
>
> So yeah, the way I see it 15-16 are the more trivial issue to sort
> out (probably) but with 17-18 we have an actual architectural concern
> for kernel overall.

Further:

15/20: I can accept this without reported-by tag (or changed as
suggested-by). It does not harm.
16/20: I'll re-review this with time. I'll try to get this done
latest next week.

So let's put focus only on 17 and 18. Can this problem be sorted out
by kernel command-line parameter? In the case of locality we want to
keep regular "chain of trust" i.e. boot-loader makes the decision,
*even* in the case of DRTM. I would call this almost as constraint
that would be wise to set.

BR, Jarkko

