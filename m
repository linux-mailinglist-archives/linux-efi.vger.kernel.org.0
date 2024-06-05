Return-Path: <linux-efi+bounces-1167-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 040508FC064
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jun 2024 02:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6134828495B
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jun 2024 00:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FC4323D;
	Wed,  5 Jun 2024 00:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpS8JCUP"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBE92F43;
	Wed,  5 Jun 2024 00:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717546957; cv=none; b=dq0L9UNiiSB17BPhPHTW4rQ033+WkDrnlX90DuF8I5T0Oe/1+yhDtLT6YPsntsHaJcNLICrSPejRAY4jGN3kkfReyIw4cmueoAKnFJtRGAv3u1CHFO8HKA0Fdwh7VWye42l92Wi1X4KP0g2bY2SWsQHV0KxzHn8CWv95zG7VfgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717546957; c=relaxed/simple;
	bh=qnHIpwOv9R+4h5FqLF1d7WUJag+t2UlUxgUBxANOKTs=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=d051FWyIRdKJA6MnVHeCAYtYcpNEeJoMbcQ1Wi4BbEdaJWB99Exi0rl7WpcJJmfxtX8dweyUWDUGXkUNhbJJPko6iQescHADiV79V3dejiYtodZ7lZCQURzmP+N9vnxs6jhUnfqb2m2v/Uohd6yWfqm9tbVO10AYP5ZP2r/FiAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpS8JCUP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D836FC2BBFC;
	Wed,  5 Jun 2024 00:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717546956;
	bh=qnHIpwOv9R+4h5FqLF1d7WUJag+t2UlUxgUBxANOKTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gpS8JCUPVudbfLoCJNfzcfmZ6SFh99FLZs51VgiUe6UAhKbyd/FWxsSWpbDQ6dZ6c
	 lYiex9VIlFvoQaypZgxbyZENW7OwIlJyAjjZJTPTEn6YV+LelBDlDsWsAzMRxWBUy9
	 XHY9yvhF057HhXTDnUu2akRiESqsW8vJd9ld4UEp0FT+NXZuAIzRiuGAXIku6/nWEm
	 nbIv12JqGj1B6P84Wd6NSj2iYKhSbj2SJfo6ER3z8rU17A5ThjwKtEMHsGfeQ65C41
	 fGMihXTqPhomNMsdW+wBXfn1N7FvgBkZnzGChV/WKzb6XUrA2nol2LCOhtzah0VozP
	 30I243cBKrIAQ==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Jun 2024 03:22:27 +0300
Message-Id: <D1RNKV4JIE5L.1LNG82UAC916M@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: <ross.philipson@oracle.com>, <linux-kernel@vger.kernel.org>,
 <x86@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
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
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-5-ross.philipson@oracle.com>
 <D1RFWFIJEYWL.2FC7V79321264@kernel.org>
 <1eca8cb1-4b3b-402b-993b-53de7c810016@oracle.com>
 <D1RLBMTUKRFN.34KQXEFZTBA08@kernel.org>
 <249a9b27-c18d-4377-8b51-9bc610b53a8b@oracle.com>
In-Reply-To: <249a9b27-c18d-4377-8b51-9bc610b53a8b@oracle.com>

On Wed Jun 5, 2024 at 2:00 AM EEST,  wrote:
> On 6/4/24 3:36 PM, Jarkko Sakkinen wrote:
> > On Tue Jun 4, 2024 at 11:31 PM EEST,  wrote:
> >> On 6/4/24 11:21 AM, Jarkko Sakkinen wrote:
> >>> On Fri May 31, 2024 at 4:03 AM EEST, Ross Philipson wrote:
> >>>> Introduce the Secure Launch Resource Table which forms the formal
> >>>> interface between the pre and post launch code.
> >>>>
> >>>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> >>>
> >>> If a uarch specific, I'd appreciate Intel SDM reference here so that =
I
> >>> can look it up and compare. Like in section granularity.
> >>
> >> This table is meant to not be architecture specific though it can
> >> contain architecture specific sub-entities. E.g. there is a TXT specif=
ic
> >> table and in the future there will be an AMD and ARM one (and hopefull=
y
> >> some others). I hope that addresses what you are pointing out or maybe=
 I
> >> don't fully understand what you mean here...
> >=20
> > At least Intel SDM has a definition of any possible architecture
> > specific data structure. It is handy to also have this available
> > in inline comment for any possible such structure pointing out the
> > section where it is defined.
>
> The TXT specific structure is not defined in the SDM or the TXT dev=20
> guide. Part of it is driven by requirements in the TXT dev guide but=20
> that guide does not contain implementation details.
>
> That said, if you would like links to relevant documents in the comments=
=20
> before arch specific structures, I can add them.

Vol. 2D 7-40, in the description of GETSEC[WAKEUP] there is in fact a
description of MLE JOINT structure at least:

1. GDT limit (offset 0)
2. GDT base (offset 4)
3. Segment selector initializer (offset 8)
4. EIP (offset 12)

So is this only exercised in protect mode, and not in long mode? Just
wondering whether I should make a bug report on this for SDM or not.

Especially this puzzles me, given that x86s won't have protected
mode in the first place...

BR, Jarkko

