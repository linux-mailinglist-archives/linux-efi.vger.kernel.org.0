Return-Path: <linux-efi+bounces-1562-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8A5958B33
	for <lists+linux-efi@lfdr.de>; Tue, 20 Aug 2024 17:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2A44B23029
	for <lists+linux-efi@lfdr.de>; Tue, 20 Aug 2024 15:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126101A00F5;
	Tue, 20 Aug 2024 15:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYij2JgH"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11A219FA93;
	Tue, 20 Aug 2024 15:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724167596; cv=none; b=A8NfyzQcQ89CCTmvyhUTjGOzV48HBHvezjHkcxZSQPp+GtS7W9ExjX27lmzTsBe4hSLwHreB9ORW3+bkXPUTAV6GydXLwCRGsm6b4PwNmsz62aq3z4nh7esgTkGMmKVPfiIXs0l9g4tG6QnImQpUFhXnYdJjijAP1Mt70mpGxH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724167596; c=relaxed/simple;
	bh=cul7AYUW/oUYJetixYQFOVkrNIZzj7nX7ZdNR4EJkYY=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=JDmV8VyKaR2F4n0MRkPpM2lOqxbzQ4tMnzAy7z9ELjjixds9k2wvXvhG4MjgnP8LL7POX0FnxKZZ52f5JaudhfyFJ9RsqmMUu1QCEnBbDn/kVo5PN0nKmW+zcvw3g0y3TSEhjKcTxABmwM6IUPLYMsTQqQKBIB5krFwX8gnT1H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYij2JgH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51E3C4AF14;
	Tue, 20 Aug 2024 15:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724167595;
	bh=cul7AYUW/oUYJetixYQFOVkrNIZzj7nX7ZdNR4EJkYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YYij2JgHvU1AVhaIiSFSmqh3C4f+ic8eJASZifn6Evsee/JMB21kiEgUtpOIBAzfw
	 WhPHhWbdxcAJ3GX75aIWxGKoIE+TbIbkElRQxkSiCM1gSh7PD6MUNxSUUoVKCpdCo5
	 Br49eRY1Fh7j8jsrdqPjohHKrKIQUkf6RV1BkZp3Zhod/8qnYQgViR4l08DXR6aSmW
	 DulskVJSqnfDMUzs1+E910tAcZopB11i46RMlqd/GfDzeV8Bwbz6KJUBtopdAKLoXo
	 UJG9b6LftIfnK02/OMGuvfBF4uYp8xc4JKrLL2vskwO7qu1TbpCs1VTOoV0Mv/xjHN
	 vN7mHGvix1P4A==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Aug 2024 18:26:31 +0300
Message-Id: <D3KUEGW4Q63K.NEFOY5C6ZG2O@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Matthew Garrett" <mjg59@srcf.ucam.org>
Cc: "Andrew Cooper" <andrew.cooper3@citrix.com>, "Thomas Gleixner"
 <tglx@linutronix.de>, "Daniel P. Smith" <dpsmith@apertussolutions.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>, "Eric Biggers"
 <ebiggers@kernel.org>, "Ross Philipson" <ross.philipson@oracle.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com>
 <20240531021656.GA1502@sol.localdomain>
 <874jaegk8i.fsf@email.froward.int.ebiederm.org>
 <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
 <87ttflli09.ffs@tglx> <550d15cd-5c48-4c20-92c2-f09a7e30adc9@citrix.com>
 <D3HAP4O4OVS3.2LOSH5HMQ34OZ@kernel.org> <Zr+dTMYZNY1b9cRV@srcf.ucam.org>
 <D3K35VBCWZSW.2WCXJMW1HGGD5@kernel.org> <ZsONwsWs3zCln70O@srcf.ucam.org>
In-Reply-To: <ZsONwsWs3zCln70O@srcf.ucam.org>

On Mon Aug 19, 2024 at 9:24 PM EEST, Matthew Garrett wrote:
> On Mon, Aug 19, 2024 at 09:05:47PM +0300, Jarkko Sakkinen wrote:
> > On Fri Aug 16, 2024 at 9:41 PM EEST, Matthew Garrett wrote:
> > > On Fri, Aug 16, 2024 at 02:22:04PM +0300, Jarkko Sakkinen wrote:
> > >
> > > > For (any) non-legacy features we can choose, which choices we choos=
e to
> > > > support, and which we do not. This is not an oppositive view just s=
aying
> > > > how it is, and platforms set of choices is not a selling argument.
> > >
> > > NIST still permits the use of SHA-1 until 2030, and the most signific=
ant=20
> > > demonstrated weaknesses in it don't seem applicable to the use case=
=20
> > > here. We certainly shouldn't encourage any new uses of it, and anyone=
=20
> > > who's able to use SHA-2 should be doing that instead, but it feels li=
ke=20
> > > people are arguing about not supporting hardware that exists in the r=
eal=20
> > > world for vibes reasons rather than it being a realistically attackab=
le=20
> > > weakness (and if we really *are* that concerned about SHA-1, why are =
we=20
> > > still supporting TPM 1.2 at all?)
> >=20
> > We are life-supporting TPM 1.2 as long as necessary but neither the
> > support is extended nor new features will gain TPM 1.2 support. So
> > that is at least my policy for that feature.
>
> But the fact that we support it and provide no warning labels is a=20
> pretty clear indication that we're not actively trying to prevent people=
=20
> from using SHA-1 in the general case. Why is this a different case?=20
> Failing to support it actually opens an entire separate set of footgun=20
> opportunities in terms of the SHA-1 banks now being out of sync with the=
=20
> SHA-2 ones, so either way we're leaving people open to making poor=20
> choices.

This is a fair and enclosing argument. I get where you are coming from
now. Please as material for the commit message.

BR, Jarkko


