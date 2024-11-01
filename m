Return-Path: <linux-efi+bounces-2097-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D93609B93C3
	for <lists+linux-efi@lfdr.de>; Fri,  1 Nov 2024 15:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73C6F28155C
	for <lists+linux-efi@lfdr.de>; Fri,  1 Nov 2024 14:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DA51AAE1E;
	Fri,  1 Nov 2024 14:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLhfBdhQ"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4341AAE09;
	Fri,  1 Nov 2024 14:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730472715; cv=none; b=gW+at5VYsaRD25bs5mzvLjUzgG1R/HgnU17Zy0QkZSuS/fVTGpvjtrmUBghQqLFa3FkHggFAdzrgdjuUQ7VQUCgMA88TbDYJmNaePhunLYn9T3py8t/1oWbk18bk953PNVAV+zfD/TsZeuQ+a/042qBhDLv17sAn/x9iRdSt+Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730472715; c=relaxed/simple;
	bh=fBmciF+8K11L8eGrwOJGRPAF0tISY2XVqBxqg8Opu4U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=t/HB5PL1RHcKNrh62wG7cfBq5xoaG3Ba5AAW9PMvw6G/7VKEIoc7QH7qbTCLpo/troB6DiQiudYM82uSq3FGNYTocKqn5ALeiLx3P2L9XWQIEC45Cq2FwhWPpua3fKgb1NjzaVADHYaoXdHqdnCDyx5cEsnJqemlqxPwFy0vI0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pLhfBdhQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7E1C4CECD;
	Fri,  1 Nov 2024 14:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730472715;
	bh=fBmciF+8K11L8eGrwOJGRPAF0tISY2XVqBxqg8Opu4U=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=pLhfBdhQcDWy1mnIlIpI0fOGxQXBqk3WkdTqtzWxYa3Xu2vgoWazyk+oRO4J8V1pe
	 J12+zyrD3bpt/2XYSTT9A+rLfKfpZnQooZfbr3hXIKGNmAf/0/fZ5VzYidOSm8s1CB
	 qXRqoncGrKqJsKcpb8FbDwj9ybgRiGjtyguDdA5nxy7drXN+PGO2YFvp5itn7JLMXV
	 fbJNJrTcnGTDVhmMNfF4tuazJXCfSvg/G5WTcKQmKUR7fse/fqr9sdbG+0bKpjMcgv
	 ZOhOnn3yPdMWS3GtiT3Ts0h2JZJl95ikhDcsovwWxxpvK21esgAM8w8igj4MQDpyZm
	 AiQeBW27/ymrA==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 Nov 2024 16:51:50 +0200
Message-Id: <D5AXDOQWNMIY.3RD4A8I5H6OOJ@kernel.org>
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

Yes, I did that.

>
> Thanks,
>
>         tglx

BR, Jarkko

