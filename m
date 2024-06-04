Return-Path: <linux-efi+bounces-1159-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8988FBF0C
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jun 2024 00:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F27D1F230A1
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 22:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F13B14D293;
	Tue,  4 Jun 2024 22:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wa1jwYWe"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD43014C5AE;
	Tue,  4 Jun 2024 22:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717540589; cv=none; b=vBDWcH56j5zVBLP7sYhbec3pbJqcXk9s+oXheTFj6mCJ71uAVa/yveCyXJZK7555FMWsfmKDtxzX/vC9XWA60obAAjJGveLDGlx640H+clJ0ZNPRcIoE/D6Px0c4GoRzIkcdMs8N72MBPrnDquEKzcd8cOu8+3O/7bmqDU5NQq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717540589; c=relaxed/simple;
	bh=vkh29LcZuA4Sz0xUo0Giq6q/HmkTXs9ahlbNzKVYxng=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=MHkSXC+ksEis5d5AMH+OQ4QDBfr7Y26BfSm4BAyXqv5cT7qM1ZMdrGicPoXYrDIrrTACYXfhH2sOezAHcQaQQj/0WHY6/8+i70JVX//Ag7PrtjrAF0h1r2hDYba2bDiGSt2epudTKXiilVcPnQFQPtS92yd3WYWqnrht9hmPnOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wa1jwYWe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7037C2BBFC;
	Tue,  4 Jun 2024 22:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717540589;
	bh=vkh29LcZuA4Sz0xUo0Giq6q/HmkTXs9ahlbNzKVYxng=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Wa1jwYWe1gDKB/JcdKkJd5eqvpX/bLh954mEJEiY5sfp1Jsl9BzcS7gIADAcpRFQ8
	 5b2Z+KR0PO7iC+UefSD+nWYWgv5dim7w3OceDBruFV/tyaWv7LDlGrITfKmLGoAM6a
	 57yxX26az1npx87W6+VsZxy1l3ruChkkm4Pzk7eYQK0dOcyeNIoegwdV1vps+HxRSO
	 FcPOpucMgOCpo9fUxHYSbyfugusoq5loIrWUAewdkYAUpoUYvEe7Kv6HTcEuWk8TxF
	 QgIqjzR2Sq65KRa0Piil1C789ZsmBR+bfL1YZBun7IlsuINQyGQLIitVySKAf4bAbN
	 puw6F6rCHqlBg==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Jun 2024 01:36:22 +0300
Message-Id: <D1RLBMTUKRFN.34KQXEFZTBA08@kernel.org>
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
To: <ross.philipson@oracle.com>, <linux-kernel@vger.kernel.org>,
 <x86@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-5-ross.philipson@oracle.com>
 <D1RFWFIJEYWL.2FC7V79321264@kernel.org>
 <1eca8cb1-4b3b-402b-993b-53de7c810016@oracle.com>
In-Reply-To: <1eca8cb1-4b3b-402b-993b-53de7c810016@oracle.com>

On Tue Jun 4, 2024 at 11:31 PM EEST,  wrote:
> On 6/4/24 11:21 AM, Jarkko Sakkinen wrote:
> > On Fri May 31, 2024 at 4:03 AM EEST, Ross Philipson wrote:
> >> Introduce the Secure Launch Resource Table which forms the formal
> >> interface between the pre and post launch code.
> >>
> >> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> >=20
> > If a uarch specific, I'd appreciate Intel SDM reference here so that I
> > can look it up and compare. Like in section granularity.
>
> This table is meant to not be architecture specific though it can=20
> contain architecture specific sub-entities. E.g. there is a TXT specific=
=20
> table and in the future there will be an AMD and ARM one (and hopefully=
=20
> some others). I hope that addresses what you are pointing out or maybe I=
=20
> don't fully understand what you mean here...

At least Intel SDM has a definition of any possible architecture
specific data structure. It is handy to also have this available
in inline comment for any possible such structure pointing out the
section where it is defined.

BR, Jarkko

