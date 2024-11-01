Return-Path: <linux-efi+bounces-2085-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A64BC9B87BD
	for <lists+linux-efi@lfdr.de>; Fri,  1 Nov 2024 01:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30C61B22003
	for <lists+linux-efi@lfdr.de>; Fri,  1 Nov 2024 00:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E9417BA5;
	Fri,  1 Nov 2024 00:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDVdeGoS"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CE517753;
	Fri,  1 Nov 2024 00:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730421215; cv=none; b=KstCablHElQ6mo4dyFNWFlZ3z9tlGXJYk5wiltppXCNaEZyqZmCWsPBcUG1BS5T5K5Zq5r/Axy9zX2abJMf3HWEIcBWwhnAkN87VyrtofeUU88aUvQmS+ZDD+VjqofdP3ezqwTMsQM0qPZl+cnV0V/5MruRDnbe63jMgTuB7qAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730421215; c=relaxed/simple;
	bh=JOqTpgy5T4UYFfRSxeC8Hsvp7K+oY1FR38Cm1XCvAJw=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=BUVz1/RN+gOthH3f28jMa6mjKgQfkHhnG5XOfemXKdTuQu5fbHJBRJ4/FLrbNDuYBAzrkc0p8435nu4Ztw9prtM7tUc1hK9LNkE0ojm21oJoN8WbIDSeh5+egx73+6mVKpX5nTIT7LqXWuOKUzxgssc50Q6ceg3bWWyUIVsiIn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDVdeGoS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC80C4CED4;
	Fri,  1 Nov 2024 00:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730421215;
	bh=JOqTpgy5T4UYFfRSxeC8Hsvp7K+oY1FR38Cm1XCvAJw=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=tDVdeGoShHzHJ4KUpuULtbcdXFySN9uy/gfThoWBusIWDUa0IeYatInt0hkyM5Tzq
	 LouYEGFgfBSs7YLVVjbNDXK5ZYwAjZXxEA1h5tKRMPrn43fIt5SZuDMqJRJvQlMvp7
	 A9aR3ACyH58sUg0szTxRf1mgBWMn0RPcGMBsD/hVZpa+SuWf0VXva9aEOSMxSN21FY
	 AbU4us6aTzDvpv+c22zTeTKelXaCjrMDHkfeSY5qLViLUCs4M24IsERwqFWkCSlmNs
	 0KNTrffIhVhY5TaEgY0gKtHrAPqhzmq2vVKG6HPxD6QQeuBmQ8M+FcEozYJMGq+VEy
	 bUhV66CbYt8rQ==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 Nov 2024 02:33:30 +0200
Message-Id: <D5AF4HY1I6AA.27WRBDDGLYH39@kernel.org>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Ross Philipson"
 <ross.philipson@oracle.com>, <linux-kernel@vger.kernel.org>,
 <x86@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
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
X-Mailer: aerc 0.18.2
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
 <87wmhoulb9.ffs@tglx> <D5ACNMVX5LXB.1L0S9P2J3UDJH@kernel.org>
 <87ldy3vpjh.ffs@tglx>
In-Reply-To: <87ldy3vpjh.ffs@tglx>

On Fri Nov 1, 2024 at 1:08 AM EET, Thomas Gleixner wrote:
> On Fri, Nov 01 2024 at 00:37, Jarkko Sakkinen wrote:
> > On Thu Oct 31, 2024 at 9:25 PM EET, Thomas Gleixner wrote:
> >> So this looks pretty reasonable to me by now and I'm inclined to take =
it
> >> through the tip x86 tree, but that needs reviewed/acked-by's from the
> >> crypto and TPM folks. EFI has been reviewed already.
> >>
> >> Can we make progress on this please?
> >
> > So TPM patches do have bunch of glitches:
> >
> > - 15/20: I don't get this. There is nothing to report unless tree
> >   is falling. The reported-by tag literally meaningless. Maybe this
> >   is something that makes sense with this feature. Explain from that
> >   angle.
> > - 16/20: Is this actually a bug fix? If it is should be before 15/20.
> > - 17/20: the commit message could do a better job explaining how the
> >   locality can vary. I'm not sure how this will be used by rest of
> >   the patch set.
> > - 18/20: I'm not confident we want to give privilege to set locality
> >   to the user space. The commit message neither makes a case of this.
> >   Has this been tested to together with bus encryption (just checking)?
>
> Can you please explicitely voice your detailed technical concerns in
> replies to the actual patches?

- 15/20 looks like a rigged patch. I don't really know why it is done
  so it is hard to either suggest how "resolve it".
- 16/20 probably makes sense but if it is a bug fix or part of it is,
  the bug fix should have relevant fixes etc tags so that it can be
  picked up to stable kernels.
- 17-18/20: I'd speak about this as the "one whole" i.e. here the
  privilege to be able change locality during run-time is really
  concerning. Could the locality be figured out for the kernel
  command-line instead? The sysfs attribute can exist as read-only.

So yeah, the way I see it 15-16 are the more trivial issue to sort
out (probably) but with 17-18 we have an actual architectural concern
for kernel overall.

> Thanks,
>
>         tglx

BR, Jarkko

