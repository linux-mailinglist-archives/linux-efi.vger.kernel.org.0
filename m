Return-Path: <linux-efi+bounces-2090-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AE79B8DDE
	for <lists+linux-efi@lfdr.de>; Fri,  1 Nov 2024 10:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED320B231FF
	for <lists+linux-efi@lfdr.de>; Fri,  1 Nov 2024 09:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A364156C6F;
	Fri,  1 Nov 2024 09:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zkya8/hD"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23A515696E;
	Fri,  1 Nov 2024 09:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730453461; cv=none; b=IWBvY75AbdMrlZjt+T7I9hCwMe6x44BYPHYs0TtRN7BqOIebZlfImQDpXHkxGUu7XVObcnIkkQqFxpR6DUbdkW1GXlpTVUsoLA13wZA2UUaKJNp1blmTlrvOAoUzN8bqwBvR90nw5eSDgnf5D2zyRgTNzTIZoc0obFbFt1sM5co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730453461; c=relaxed/simple;
	bh=E2hqZuQZtN0s10rwxtt69HOZ+Xb8z/BgC9HjxUEaI8I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=W6I3JoiQv9gu6X8GVHgc1CbGd0wPe6mnl4/hiMxSJVUxr96EVUv3KgXjgkGEElTIgd3q6QFN5Kv6mik3I23yhIj07tHuE+X+CeRH0hzAIvmWXN7M6q8o9w6T8NQJHGy46q9yCnrIGYP74dsYRCBHwzwj/jOZOPldyi9f1YxR154=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zkya8/hD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81E9C4CECD;
	Fri,  1 Nov 2024 09:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730453460;
	bh=E2hqZuQZtN0s10rwxtt69HOZ+Xb8z/BgC9HjxUEaI8I=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Zkya8/hD7vHw7APlNFmnxhWEkpDonfTxxz8OWZ+5yd6bN6LCtcPcxwsVE4U7z6DDP
	 axnPzOvjCL6gChmB6XulcLUOprx36LAu5iMNXWzVPRXPbDOqKpoLUJ6iduXcDyflT/
	 MGr+5cRmIRyVpfucy34v+J2ldo2IwS6yp/UXbWLgo3x0F4O1nUVnbJY3WBeqM6aRXF
	 EP7NRCMufh/YmLLTgvYeE4Z82criQF5xuFnk5KcA3VUhhV8BGeltxg2rih8cv0ya7h
	 Fd7aWjWXjLqa6ANGOzuDQQWJu596wZ/9wiXgDCCm/AHABThwJgXn6v4l7PmyqqFSTi
	 q48cT5bH1WOWQ==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 Nov 2024 11:30:56 +0200
Message-Id: <D5AQJZG7APIG.3VIKP5N265AQA@kernel.org>
Cc: "Thomas Gleixner" <tglx@linutronix.de>, "Ross Philipson"
 <ross.philipson@oracle.com>, <linux-kernel@vger.kernel.org>,
 <x86@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>, <dpsmith@apertussolutions.com>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v11 00/20] x86: Trenchboot secure dynamic launch Linux
 kernel support
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Ard Biesheuvel"
 <ardb@kernel.org>
X-Mailer: aerc 0.18.2
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
 <87wmhoulb9.ffs@tglx> <D5ACNMVX5LXB.1L0S9P2J3UDJH@kernel.org>
 <87ldy3vpjh.ffs@tglx> <D5AF4HY1I6AA.27WRBDDGLYH39@kernel.org>
 <D5AF9K79H8WO.PVW93P31GHMH@kernel.org>
 <CAMj1kXHFDMKEH46MG3731FS043XyxHchoTJtDOst6kvfMezUuQ@mail.gmail.com>
 <D5AQA7LCE0KW.1QHQJLG2D2WQK@kernel.org>
In-Reply-To: <D5AQA7LCE0KW.1QHQJLG2D2WQK@kernel.org>

On Fri Nov 1, 2024 at 11:18 AM EET, Jarkko Sakkinen wrote:
> On Fri Nov 1, 2024 at 10:50 AM EET, Ard Biesheuvel wrote:
> > On Fri, 1 Nov 2024 at 01:40, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > >
> > > On Fri Nov 1, 2024 at 2:33 AM EET, Jarkko Sakkinen wrote:
> > > > On Fri Nov 1, 2024 at 1:08 AM EET, Thomas Gleixner wrote:
> > > > > On Fri, Nov 01 2024 at 00:37, Jarkko Sakkinen wrote:
> > > > > > On Thu Oct 31, 2024 at 9:25 PM EET, Thomas Gleixner wrote:
> > > > > >> So this looks pretty reasonable to me by now and I'm inclined =
to take it
> > > > > >> through the tip x86 tree, but that needs reviewed/acked-by's f=
rom the
> > > > > >> crypto and TPM folks. EFI has been reviewed already.
> > > > > >>
> > > > > >> Can we make progress on this please?
> > > > > >
> > > > > > So TPM patches do have bunch of glitches:
> > > > > >
> > > > > > - 15/20: I don't get this. There is nothing to report unless tr=
ee
> > > > > >   is falling. The reported-by tag literally meaningless. Maybe =
this
> > > > > >   is something that makes sense with this feature. Explain from=
 that
> > > > > >   angle.
> > > > > > - 16/20: Is this actually a bug fix? If it is should be before =
15/20.
> > > > > > - 17/20: the commit message could do a better job explaining ho=
w the
> > > > > >   locality can vary. I'm not sure how this will be used by rest=
 of
> > > > > >   the patch set.
> > > > > > - 18/20: I'm not confident we want to give privilege to set loc=
ality
> > > > > >   to the user space. The commit message neither makes a case of=
 this.
> > > > > >   Has this been tested to together with bus encryption (just ch=
ecking)?
> > > > >
> > > > > Can you please explicitely voice your detailed technical concerns=
 in
> > > > > replies to the actual patches?
> > > >
> > > > - 15/20 looks like a rigged patch. I don't really know why it is do=
ne
> > > >   so it is hard to either suggest how "resolve it".
> > > > - 16/20 probably makes sense but if it is a bug fix or part of it i=
s,
> > > >   the bug fix should have relevant fixes etc tags so that it can be
> > > >   picked up to stable kernels.
> > > > - 17-18/20: I'd speak about this as the "one whole" i.e. here the
> > > >   privilege to be able change locality during run-time is really
> > > >   concerning. Could the locality be figured out for the kernel
> > > >   command-line instead? The sysfs attribute can exist as read-only.
> > > >
> > > > So yeah, the way I see it 15-16 are the more trivial issue to sort
> > > > out (probably) but with 17-18 we have an actual architectural conce=
rn
> > > > for kernel overall.
> > >
> > > Further:
> > >
> > > 15/20: I can accept this without reported-by tag (or changed as
> > > suggested-by). It does not harm.
> > > 16/20: I'll re-review this with time. I'll try to get this done
> > > latest next week.
> > >
> > > So let's put focus only on 17 and 18. Can this problem be sorted out
> > > by kernel command-line parameter? In the case of locality we want to
> > > keep regular "chain of trust" i.e. boot-loader makes the decision,
> > > *even* in the case of DRTM. I would call this almost as constraint
> > > that would be wise to set.
> > >
> >
> > Please don't add a kernel command line parameter for this - the code
> > running in the decompressor will be the one setting it and there are
> > better ways to pass information between these components (and the
> > slaunch stack is already doing that in any case)
>
> Not sure if I follow this (I don't know what "decompressor" is).

Right you refer to the process running GETSEC[SENTER], sorry, in the page w=
ith
this detail.

BR, Jarkko

