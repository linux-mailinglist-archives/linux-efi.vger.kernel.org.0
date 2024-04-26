Return-Path: <linux-efi+bounces-982-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E9C8B3179
	for <lists+linux-efi@lfdr.de>; Fri, 26 Apr 2024 09:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05E17B2158B
	for <lists+linux-efi@lfdr.de>; Fri, 26 Apr 2024 07:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002D8139D11;
	Fri, 26 Apr 2024 07:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOV5FuHk"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D2842040;
	Fri, 26 Apr 2024 07:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714116957; cv=none; b=amBKyo0I5q4hRCmo5cE7mhz6keeAV7qwOp6qC4O7+a4xm4yzgESVgFtcQa89BcEzviPACdGToB8PLgFTiBW91FDn/EQjlhYDSrZwq6jDvamM/a2NM6c3oOtZgqqmvfowPWBwvF/2iemTsxpRRTvSe70LRuFntLev6pQtG0hmpMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714116957; c=relaxed/simple;
	bh=fKzJqecCQuXBB/Bg3EXO3byJ6b3SOoYHAtjUmZZJkxI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ZIUfLHrhsMaXmE98ULCgDtwX1nITa5cz+e3agnQokba8kOzQXuwcmA95wkLiwqhsqBJofrs/oZYPaCbOAQDTnlxpAO5Wb4i44/RBWF2YPQQ3RX3LfII8B19ZFQqDtFdHrl63vgFNBd2TsNxCPt94X0gIYmKZDJEFF0HfQfOg1KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOV5FuHk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5EDC113CD;
	Fri, 26 Apr 2024 07:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714116957;
	bh=fKzJqecCQuXBB/Bg3EXO3byJ6b3SOoYHAtjUmZZJkxI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=GOV5FuHk1Mq9fKRra96XmOWnFqnaLzugHbViNkfV7sEZ3jx5o35PNFwy8yb/R19nD
	 oPYq4j9u1yvN3mAPTBAAZ1i8kj1oY32RgzTN9KfTJFRGZg3+JbrKWHf0F7yIAE7Fx3
	 PQXwyPUcE+x1mtlX3AnCVrzAahuzug1DcsPp4B92L8MZavkIApi76msAcC5E6nHj6Q
	 WCzDYLhkrcdgB0Yj8vT1r7S0Mb73eh0W2LdlKa5reFczZCGFgM+ChJXZaaYYvX14Ac
	 W7kLtjgt6MDg1qHc56OEIvlf3VhYfaskSK1l4VPCaLaryu4GKToGglZXA7bXTswH6T
	 aS5pp3VnkaRVw==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 26 Apr 2024 10:35:51 +0300
Message-Id: <D0TVQWEDNZO0.PN96CXJOTN1B@kernel.org>
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
In-Reply-To: <D0T9BM4E1F5C.2TZMIRSHCKCQ2@kernel.org>

On Thu Apr 25, 2024 at 5:01 PM EEST, Jarkko Sakkinen wrote:
> On Thu Apr 25, 2024 at 12:58 PM EEST, Lennart Poettering wrote:
> > General purpose distros typically don't build all TPM drivers into the
> > kernel, but ship some in the initrd instead. Then, udev is responsible
> > for iterating all buses/devices and auto-loading the necessary
> > drivers. Each loaded bus driver might make more devices available for
>
> I've had since day 0 that I've worked with TPM driver (i.e. since 2013

- had the opinion (typo)

BR, Jarkko

