Return-Path: <linux-efi+bounces-1544-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 439BE9546DA
	for <lists+linux-efi@lfdr.de>; Fri, 16 Aug 2024 12:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 685241C221C2
	for <lists+linux-efi@lfdr.de>; Fri, 16 Aug 2024 10:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A59B18FC83;
	Fri, 16 Aug 2024 10:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NB193JTX"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA0013C689;
	Fri, 16 Aug 2024 10:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723804937; cv=none; b=MdYNST8h/GfcIXe0/iShAezR1yFpnnOJ+fyKz6CQUyiq7r2PFCMP+fYlbSbG1kb5bRIIm+tyYvq5AK7VzD2NfTZHfJHS8KrD9aCKYilH7t45a1h8wBEgCbueTQsS99Xk6y0B4AqJhGa26Ln2nYieBeyfYQ3Mj8DazO4N3xjBosk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723804937; c=relaxed/simple;
	bh=zg3dRit0opyHfuuTVglW5AtRP4DAPWyWCTz/Rq9Op8U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=evReghtF/PyMWhycixiJ1Y9lhdOP6USlZoILb1Lhw3x212RREC3pNPtkOT8viU1WzgE4xVTxy0VNE7fst7LmcDDpPKtLDP7OBBvxyLbgB/QhUQpoxDMqAy2ycdMxf19SuHh/2DInZmjtQIdAYrM1vAOf9sNUjLWLdRBhHp30H5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NB193JTX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C679C32782;
	Fri, 16 Aug 2024 10:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723804936;
	bh=zg3dRit0opyHfuuTVglW5AtRP4DAPWyWCTz/Rq9Op8U=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=NB193JTXK3JRQ7RSKkOV16g8BU8FoDpFZ9LrZZP3Mr/3BsNpE4kWT2iUeatduZZUe
	 42iqfmX+LeVxQUsdm8vSGspHkZbszI5FZ3EPXdHy9uQPwn8HkZlPSmKdcwx8DF+wtm
	 nFt0M7aq8L1mzCPQPuZUhVBGGOjDBOkbMum9ikJr/AVq3DkDb/koO8d8n6IgkN9f59
	 BexA35uQhGZv4ph6LKZoSbT0wspZgo7Ff6avGvl0r8QC8Apl3M1iwrQYf4L1yhr7W4
	 bYYTtbhcN8kgzIAFe1rQAe/rM0UYJS0HEr2bRTvySuQwtTKcLGMqksaTknDYo3S8qi
	 6uwqFaJIb34bw==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Aug 2024 13:42:13 +0300
Message-Id: <D3H9ULV1NH4M.1A8EKXWZFTEF2@kernel.org>
Cc: "Ross Philipson" <ross.philipson@oracle.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Daniel P. Smith"
 <dpsmith@apertussolutions.com>, "Eric W. Biederman"
 <ebiederm@xmission.com>, "Eric Biggers" <ebiggers@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com>
 <20240531021656.GA1502@sol.localdomain>
 <874jaegk8i.fsf@email.froward.int.ebiederm.org>
 <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
 <87ttflli09.ffs@tglx>
In-Reply-To: <87ttflli09.ffs@tglx>

On Thu Aug 15, 2024 at 10:10 PM EEST, Thomas Gleixner wrote:
> On Thu, Aug 15 2024 at 13:38, Daniel P. Smith wrote:
> > On 5/31/24 09:54, Eric W. Biederman wrote:
> >> Eric Biggers <ebiggers@kernel.org> writes:
> >>> That paragraph is also phrased as a hypothetical, "Even if we'd prefe=
r to use
> >>> SHA-256-only".  That implies that you do not, in fact, prefer SHA-256=
 only.  Is
> >>> that the case?  Sure, maybe there are situations where you *have* to =
use SHA-1,
> >>> but why would you not at least *prefer* SHA-256?
> >>=20
> >> Yes.  Please prefer to use SHA-256.
> >>=20
> >> Have you considered implementing I think it is SHA1-DC (as git has) th=
at
> >> is compatible with SHA1 but blocks the known class of attacks where
> >> sha1 is actively broken at this point?
> >
> > We are using the kernel's implementation, addressing what the kernel=20
> > provides is beyond our efforts. Perhaps someone who is interested in=20
> > improving the kernel's SHA1 could submit a patch implementing/replacing=
=20
> > it with SHA1-DC, as I am sure the maintainers would welcome the help.

Git also has a bit more wide than secure launch, and the timeline is
also completely different. Git maintains legacy, while has also
introduced SHA-256 support in 2018. This as a new feature in the kernel
stack.

The purpose of SHA1-DC has obviously been to extend the lifespan, not
fix SHA-1.

Linux will be better of not adding anything new related to SHA-1 or
TPM 1.2. They still have a maintenance cost and I think that time
would be better spent of for almost anything else (starting from
taking your trashes out or boiling coffee) ;-)

>
> Well, someone who is interested to get his "secure" code merged should
> have a vested interested to have a non-broken SHA1 implementation if
> there is a sensible requirement to use SHA1 in that new "secure" code,
> no?
>
> Just for the record. The related maintainers can rightfully decide to
> reject known broken "secure" code on a purely technical argument.
>
> Thanks,
>
>         tglx

BR, Jarkko

