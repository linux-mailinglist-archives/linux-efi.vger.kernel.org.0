Return-Path: <linux-efi+bounces-1170-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBD38FC287
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jun 2024 06:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E7DB1F2246B
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jun 2024 04:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D5D61FEC;
	Wed,  5 Jun 2024 04:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLHBjXbj"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEB1171B0;
	Wed,  5 Jun 2024 04:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717560292; cv=none; b=hSIyzVK9Me2plBEwy3X8TT+zKMEbUd3v0u8Jvvyut2Ngq7FmLmKxiH5D0uy83/Bgf8elPjR5MXfbY2KXIzL3fWS/gZCLZRCc34BAMVgVtTI08qprIWZzF3AubUftK462XFQsQQ9/L/PZ0OVEBZh2su96rxqtxMtvF1N4BBsV4oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717560292; c=relaxed/simple;
	bh=D7YS8tUT6zoxR7+gztQhZtUYQS3g8Jha1gq4gWlWSOY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=RiLKJm3keyvEIHE4ZRxZsUb9llrQN14DZli6q8iWpkULTsZJ8Am87z2ImqEHEmqEt42yZFUZ5NZFIV+h9e2yeXkn0RiucS72eWLimve1exK3xgSc6zfMbb1fOk9rB/dwisFifctXuAka1Z/pnOaqMUsF/bcqUyUUTOK4y03+IZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLHBjXbj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8DB9C32781;
	Wed,  5 Jun 2024 04:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717560291;
	bh=D7YS8tUT6zoxR7+gztQhZtUYQS3g8Jha1gq4gWlWSOY=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=OLHBjXbjh6nagm8wzjsU74vNbjvZwzzPO+E00JnpPO6Tulhx7zlyZpBPqdWd6WPF1
	 0o02okbEIMvrN84g7B34RhAKA3TzXOzc9L4I4qoFW3GE5yp8iV3D161WZL+TKfivxp
	 KDrad0HF7ReV0kat6LU5tGwJfNFBlYhDTbQ1hupt6j2nlLT061/WeQYPx4hHMJfD+e
	 s3UlT8wgXGfl56Pk4WEwnn1M8Rxi7E20n92tqvzbrxiVE4UuJYp5DJeSWCzmnuQCx3
	 5EXyZTzK7B8tDsB+2fAwatEU+JWnzlEaTmd4BmcudlGhxXZFypidLPXm54h7rlf+l/
	 lF6g9OOk30l+w==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Jun 2024 07:04:44 +0300
Message-Id: <D1RSB1PB5XGS.2X032M0E1VMJW@kernel.org>
Subject: Re: [PATCH v9 04/19] x86: Secure Launch Resource Table header file
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
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-5-ross.philipson@oracle.com>
 <D1RFWFIJEYWL.2FC7V79321264@kernel.org>
 <1eca8cb1-4b3b-402b-993b-53de7c810016@oracle.com>
 <D1RLBMTUKRFN.34KQXEFZTBA08@kernel.org>
 <249a9b27-c18d-4377-8b51-9bc610b53a8b@oracle.com>
 <D1RNKV4JIE5L.1LNG82UAC916M@kernel.org>
 <f66de08f-4905-48d6-8bcf-5b1ab847492f@oracle.com>
In-Reply-To: <f66de08f-4905-48d6-8bcf-5b1ab847492f@oracle.com>

On Wed Jun 5, 2024 at 5:33 AM EEST,  wrote:
> On 6/4/24 5:22 PM, Jarkko Sakkinen wrote:
> > On Wed Jun 5, 2024 at 2:00 AM EEST,  wrote:
> >> On 6/4/24 3:36 PM, Jarkko Sakkinen wrote:
> >>> On Tue Jun 4, 2024 at 11:31 PM EEST,  wrote:
> >>>> On 6/4/24 11:21 AM, Jarkko Sakkinen wrote:
> >>>>> On Fri May 31, 2024 at 4:03 AM EEST, Ross Philipson wrote:
> >>>>>> Introduce the Secure Launch Resource Table which forms the formal
> >>>>>> interface between the pre and post launch code.
> >>>>>>
> >>>>>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> >>>>>
> >>>>> If a uarch specific, I'd appreciate Intel SDM reference here so tha=
t I
> >>>>> can look it up and compare. Like in section granularity.
> >>>>
> >>>> This table is meant to not be architecture specific though it can
> >>>> contain architecture specific sub-entities. E.g. there is a TXT spec=
ific
> >>>> table and in the future there will be an AMD and ARM one (and hopefu=
lly
> >>>> some others). I hope that addresses what you are pointing out or may=
be I
> >>>> don't fully understand what you mean here...
> >>>
> >>> At least Intel SDM has a definition of any possible architecture
> >>> specific data structure. It is handy to also have this available
> >>> in inline comment for any possible such structure pointing out the
> >>> section where it is defined.
> >>
> >> The TXT specific structure is not defined in the SDM or the TXT dev
> >> guide. Part of it is driven by requirements in the TXT dev guide but
> >> that guide does not contain implementation details.
> >>
> >> That said, if you would like links to relevant documents in the commen=
ts
> >> before arch specific structures, I can add them.
> >=20
> > Vol. 2D 7-40, in the description of GETSEC[WAKEUP] there is in fact a
> > description of MLE JOINT structure at least:
> >=20
> > 1. GDT limit (offset 0)
> > 2. GDT base (offset 4)
> > 3. Segment selector initializer (offset 8)
> > 4. EIP (offset 12)
> >=20
> > So is this only exercised in protect mode, and not in long mode? Just
> > wondering whether I should make a bug report on this for SDM or not.
>
> I believe you can issue the SENTER instruction in long mode, compat mode=
=20
> or protected mode. On the other side thought, you will pop out of the=20
> TXT initialization in protected mode. The SDM outlines what registers=20
> will hold what values and what is valid and not valid. The APs will also=
=20
> vector through the join structure mentioned above to the location=20
> specified in protected mode using the GDT information you provide.
>
> >=20
> > Especially this puzzles me, given that x86s won't have protected
> > mode in the first place...
>
> My guess is the simplified x86 architecture will not support TXT. It is=
=20
> not supported on a number of CPUs/chipsets as it stands today. Just a=20
> guess but we know only vPro systems support TXT today.

I'm wondering could this bootstrap itself inside TDX or SNP, and that
way provide path forward? AFAIK, TDX can be nested straight of the bat
and SNP from 2nd generation EPYC's, which contain the feature.

I do buy the idea of attesting the host, not just the guests, even in
the "confidential world". That said, I'm not sure does it make sense
to add all this infrastructure for a technology with such a short
expiration date?

I would not want to say this at v9, and it is not really your fault
either, but for me this would make a lot more sense if the core of
Trenchboot was redesigned around these newer technologies with a
long-term future.

The idea itself is great!

BR, Jarkko

