Return-Path: <linux-efi+bounces-1559-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 407269572AB
	for <lists+linux-efi@lfdr.de>; Mon, 19 Aug 2024 20:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B777EB21383
	for <lists+linux-efi@lfdr.de>; Mon, 19 Aug 2024 18:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCEE188CB3;
	Mon, 19 Aug 2024 18:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adPXV4dv"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B0B1CAAF;
	Mon, 19 Aug 2024 18:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724090752; cv=none; b=doRR96QtEAiGsvze58ymyYe0sBbDBjrou5TMhw7RduZtMmhn62yMPLLMO9mFIwQrQOSFMOPunfTP38ZF5lwSW/cdvECRehExR7TmwW9GrWvg7hBlg6L7NmY94RF8szCyJ2Sx4PZ+vdsH7JgIHcphZc+fzuS3nXOYyaCOsZ32FBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724090752; c=relaxed/simple;
	bh=uLSpmh/E5SFR+0qV7rTBO7Co/W3e9kkntMp3LEBgW5A=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=nBRDN2moqb7tOMc3y1xL0QLCvJLLQTrulGXWEGkVoNd5yaoIMNo5rE/isU1o79NCN04QVIN6A49pZWAoRiF0KTMi3Erjl4ano3ruF4T98nTcjdydYxVVMZbtnzpOmGR1hfWahbwi59EUBJRcqYuaGX0q1Zaimm5yBBcaQ+UMXpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adPXV4dv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECEA4C4AF0E;
	Mon, 19 Aug 2024 18:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724090751;
	bh=uLSpmh/E5SFR+0qV7rTBO7Co/W3e9kkntMp3LEBgW5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=adPXV4dvUSE0pwCC6K1YfPntPyebWDDj0fD+pJW3wr5fWWivDUihmzH65OZg46th3
	 XY10Ijh0JETmHQ73y7+fG4I7PgmkHr7U80iDyJGFtweWoz0YsD2HhM0IN6gAouT3+4
	 6/b3YMhfpj3SjpIxmEsO8HaHTh/HP48Vhopc1sof3H6TSo2NuxemqhNg0cvH00Yqjd
	 FoE10+toTGsLcJhCGFlHGlNrtMPcWL+mwRQvrS4NYp3KGBtiTY7wERz0v8glMM02y5
	 B4p9QyU2xjbp0fZfBDFDQLq1UwKFMdeTscNEQhbErYHeZ8xohsUeIfaNIwX+yr65Nd
	 gZnFXr8lOKE8A==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Aug 2024 21:05:47 +0300
Message-Id: <D3K35VBCWZSW.2WCXJMW1HGGD5@kernel.org>
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
X-Mailer: aerc 0.18.2
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com>
 <20240531021656.GA1502@sol.localdomain>
 <874jaegk8i.fsf@email.froward.int.ebiederm.org>
 <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
 <87ttflli09.ffs@tglx> <550d15cd-5c48-4c20-92c2-f09a7e30adc9@citrix.com>
 <D3HAP4O4OVS3.2LOSH5HMQ34OZ@kernel.org> <Zr+dTMYZNY1b9cRV@srcf.ucam.org>
In-Reply-To: <Zr+dTMYZNY1b9cRV@srcf.ucam.org>

On Fri Aug 16, 2024 at 9:41 PM EEST, Matthew Garrett wrote:
> On Fri, Aug 16, 2024 at 02:22:04PM +0300, Jarkko Sakkinen wrote:
>
> > For (any) non-legacy features we can choose, which choices we choose to
> > support, and which we do not. This is not an oppositive view just sayin=
g
> > how it is, and platforms set of choices is not a selling argument.
>
> NIST still permits the use of SHA-1 until 2030, and the most significant=
=20
> demonstrated weaknesses in it don't seem applicable to the use case=20
> here. We certainly shouldn't encourage any new uses of it, and anyone=20
> who's able to use SHA-2 should be doing that instead, but it feels like=
=20
> people are arguing about not supporting hardware that exists in the real=
=20
> world for vibes reasons rather than it being a realistically attackable=
=20
> weakness (and if we really *are* that concerned about SHA-1, why are we=
=20
> still supporting TPM 1.2 at all?)

We are life-supporting TPM 1.2 as long as necessary but neither the
support is extended nor new features will gain TPM 1.2 support. So
that is at least my policy for that feature.

BR, Jarkko

