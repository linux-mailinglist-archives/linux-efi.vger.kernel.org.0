Return-Path: <linux-efi+bounces-983-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CCF8B3185
	for <lists+linux-efi@lfdr.de>; Fri, 26 Apr 2024 09:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01FD61F23086
	for <lists+linux-efi@lfdr.de>; Fri, 26 Apr 2024 07:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B99713C3D2;
	Fri, 26 Apr 2024 07:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzT/7lFz"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B75913BC2B;
	Fri, 26 Apr 2024 07:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714117227; cv=none; b=njYYeOtgck/zgAbglWkcdvm1JcLuSZQwXeshTWauU/OFrKskMzbJAiAauBrWfIRuaccoCFT8mLbefA21WTnsY60+yJHGTdiiXp5b223h+EpSy+6+XHKnJHKwh35S8T3CdPflratA0xa3+JNtWqijdhHRXycqRitV5P5y9vxMmLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714117227; c=relaxed/simple;
	bh=chUCBKm0g/EgYZKxrCjqZZNilka/lvBLEBGvalg6iHQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=qp50dAuGq5IMUgIK8gDKPfgb+cAdJoWVtgauRj/ez0hU1LQsZUEDQC3OH0KENyRM5kqaQU2r9HL8Pt+taRsqXajsuy+Ws1skpjQb+txjJqjwgls9kCO6MAULUIU/eAePMjdtJaVcQ9DHFgeTcZcZ5+B+KsCTyp5uM7LYRBQ3zn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzT/7lFz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510FFC113CD;
	Fri, 26 Apr 2024 07:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714117226;
	bh=chUCBKm0g/EgYZKxrCjqZZNilka/lvBLEBGvalg6iHQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=BzT/7lFzpdtMz/MgN0gy+U2KrPftZrw4FISRXVC52TuD4n3j0gvZbipwiOFG8YOZd
	 Ci1NpAb/BLGUwLCSb4c3wNGTeP1hGqhg2kkhsgREZR0/jKwFjnLZAM6lrLtzu87/2n
	 swmWVYst0m5LyT2VjbEfGB+QIh/oERGxSQ/ksF5OYt22eBxfWUxcxLTDnWjjQ+lUu+
	 lMo95iqFYYK1p8BkShCLgNF+JpkJ1K4Boyjz9Mn08LipyMIZtfud7j+g0Ms5gCraDD
	 rAXpc/zPClOUs9Zz8Ko/6LhYsV7o1EEv2WSwT3SyCUgJO/0mHXfNifyk0uEUUSzECJ
	 f0Scbs0PLZjBw==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 26 Apr 2024 10:40:20 +0300
Message-Id: <D0TVUC3PEG7K.1XYIAGIM2T0UQ@kernel.org>
Cc: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>, "James Bottomley"
 <James.Bottomley@hansenpartnership.com>, "Mikko Rapeli"
 <mikko.rapeli@linaro.org>, <linux-efi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH] efi: expose TPM event log to userspace via sysfs
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Lennart Poettering"
 <mzxreary@0pointer.de>, "Ard Biesheuvel" <ardb@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240422112711.362779-1-mikko.rapeli@linaro.org>
 <6e751959b9056884c1b9d3ba23e303d1737d8763.camel@HansenPartnership.com>
 <ZiZhSfgeAdrbnaVL@nuoska>
 <CAC_iWjKA-xRH=3FK+=woXsB8AW4+_mVhJhUQnL8iFKxGzOwKiA@mail.gmail.com>
 <e3038141413e25350f0e53496f7a7af1bf8419cf.camel@HansenPartnership.com>
 <CAC_iWj+zbs2tq_nMASDX6pgCAP23+PpctJFiu9=mgOVDz8Trzw@mail.gmail.com>
 <e1da76ca4c7fe9319aaac5f8ff6eb46db433ec60.camel@HansenPartnership.com>
 <CAC_iWjLH=SDoTw_Pgr2hOKHkjEp_dKqwpUe9j6a=_WNW9UcxKw@mail.gmail.com>
 <CAMj1kXGHT2wULF2zwNM_QxD29dRW_dtFX2sOvsLahPiRVB61qg@mail.gmail.com>
 <ZiopXE6-AucAB9NM@gardel-login> <D0T9BM4E1F5C.2TZMIRSHCKCQ2@kernel.org>
 <D0TVQWEDNZO0.PN96CXJOTN1B@kernel.org>
In-Reply-To: <D0TVQWEDNZO0.PN96CXJOTN1B@kernel.org>

On Fri Apr 26, 2024 at 10:35 AM EEST, Jarkko Sakkinen wrote:
> On Thu Apr 25, 2024 at 5:01 PM EEST, Jarkko Sakkinen wrote:
> > On Thu Apr 25, 2024 at 12:58 PM EEST, Lennart Poettering wrote:
> > > General purpose distros typically don't build all TPM drivers into th=
e
> > > kernel, but ship some in the initrd instead. Then, udev is responsibl=
e
> > > for iterating all buses/devices and auto-loading the necessary
> > > drivers. Each loaded bus driver might make more devices available for
> >
> > I've had since day 0 that I've worked with TPM driver (i.e. since 2013
>
> - had the opinion (typo)

Tbh, I have zero idea what this discussion is about anyway because the
original thread *was not* CC'd to linux-integrity and I'm not subscribed
to linux-efi. So next time put all the relevant mailing lists. I.e.
definitive NAK for this patch.

BR, Jarkko

