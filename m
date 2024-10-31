Return-Path: <linux-efi+bounces-2083-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 901649B8622
	for <lists+linux-efi@lfdr.de>; Thu, 31 Oct 2024 23:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EA081F21DBF
	for <lists+linux-efi@lfdr.de>; Thu, 31 Oct 2024 22:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D7619922E;
	Thu, 31 Oct 2024 22:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkpDpmu7"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9401E481;
	Thu, 31 Oct 2024 22:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730414252; cv=none; b=UlGniP3YfQQvO4yUK+P2OZJ3vxah5vEX3Um7JXtnRA7LC/CRP6rZwNWCjpCj66Ov1jzi+5ca7kCm2uSXhRauLNUguPBOzfGKbasbo9WtfyPsoNrY24EHufvQaRnjeSxMAnuJZV0iERPKCqud7DIS7t8bOCU0Z9ebJS7nBVrfnEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730414252; c=relaxed/simple;
	bh=HfxuReQImXwvhpLuPipg5vqXGCC5//yJ2cqMYklD4uE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Gmnv/QYNOADNVUbuqsixXtstrubkTCTM/Ts8e6jZWijmrpMBEF7+H8lLFd8NSsUWPuKpmOhHOPDnXQnWNxM3X034TLpyrFwzDU2woyA/3ggE4XAdfYLLL7FCsT7nFtteEorWHrYYN9wshWAZ7NRYgflzt2wozaA9fGpQ1pt42QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkpDpmu7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37DBCC4CEC3;
	Thu, 31 Oct 2024 22:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730414251;
	bh=HfxuReQImXwvhpLuPipg5vqXGCC5//yJ2cqMYklD4uE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=HkpDpmu7UAbaJtrXnkkFcec2474fvBoqy1ujDdyxLJNxpkcAbhiAXS1i+Za5t54bZ
	 GVwE5D/p4jdo5We7G5n3MMQRMeZt1O4PwIEk3Q8dSYOvRJp80k8RjogGFcur/qZ9A4
	 65A4DQPqRNeJPryDCd7dZX/z2M2Qj8ilUSZb90Qw15sK2bj1m9OGio2DHx9qbloBzI
	 03SnuZRNrUzggGH9xeKrEfxS8fiBmLPxUjVP6p1J98HwOansT2wUsTL+V9wzx6AmkH
	 IK4e9kIEtrcKNkxVSuQU1G4u+Vdbl9KNU2pocO2pR1bDSBN1vVB/WbCKXWURZsDZGW
	 fsY12541kUjOQ==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 Nov 2024 00:37:27 +0200
Message-Id: <D5ACNMVX5LXB.1L0S9P2J3UDJH@kernel.org>
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
To: "Thomas Gleixner" <tglx@linutronix.de>, "Ross Philipson"
 <ross.philipson@oracle.com>, <linux-kernel@vger.kernel.org>,
 <x86@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.18.2
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
 <87wmhoulb9.ffs@tglx>
In-Reply-To: <87wmhoulb9.ffs@tglx>

On Thu Oct 31, 2024 at 9:25 PM EET, Thomas Gleixner wrote:
> On Fri, Sep 13 2024 at 13:04, Ross Philipson wrote:
> > The larger focus of the TrenchBoot project (https://github.com/TrenchBo=
ot) is to
> > enhance the boot security and integrity in a unified manner. The first =
area of
> > focus has been on the Trusted Computing Group's Dynamic Launch for esta=
blishing
> > a hardware Root of Trust for Measurement, also know as DRTM (Dynamic Ro=
ot of
> > Trust for Measurement). The project has been and continues to work on p=
roviding
> > a unified means to Dynamic Launch that is a cross-platform (Intel and A=
MD) and
> > cross-architecture (x86 and Arm), with our recent involvment in the upc=
oming
> > Arm DRTM specification. The order of introducing DRTM to the Linux kern=
el
> > follows the maturity of DRTM in the architectures. Intel's Trusted eXec=
ution
> > Technology (TXT) is present today and only requires a preamble loader, =
e.g. a
> > boot loader, and an OS kernel that is TXT-aware. AMD DRTM implementatio=
n has
> > been present since the introduction of AMD-V but requires an additional
> > component that is AMD specific and referred to in the specification as =
the
> > Secure Loader, which the TrenchBoot project has an active prototype in
> > development. Finally Arm's implementation is in specification developme=
nt stage
> > and the project is looking to support it when it becomes available.
> >
> > This patchset provides detailed documentation of DRTM, the approach use=
d for
> > adding the capbility, and relevant API/ABI documentation. In addition t=
o the
> > documentation the patch set introduces Intel TXT support as the first p=
latform
> > for Linux Secure Launch.
>
> So this looks pretty reasonable to me by now and I'm inclined to take it
> through the tip x86 tree, but that needs reviewed/acked-by's from the
> crypto and TPM folks. EFI has been reviewed already.
>
> Can we make progress on this please?

So TPM patches do have bunch of glitches:

- 15/20: I don't get this. There is nothing to report unless tree
  is falling. The reported-by tag literally meaningless. Maybe this
  is something that makes sense with this feature. Explain from that
  angle.
- 16/20: Is this actually a bug fix? If it is should be before 15/20.
- 17/20: the commit message could do a better job explaining how the
  locality can vary. I'm not sure how this will be used by rest of
  the patch set.
- 18/20: I'm not confident we want to give privilege to set locality
  to the user space. The commit message neither makes a case of this.
  Has this been tested to together with bus encryption (just checking)?

>
> Thanks,
>
>         tglx

BR, Jarkko

