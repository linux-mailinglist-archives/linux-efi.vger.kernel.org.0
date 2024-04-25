Return-Path: <linux-efi+bounces-980-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F128B2361
	for <lists+linux-efi@lfdr.de>; Thu, 25 Apr 2024 16:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A184A28AB3B
	for <lists+linux-efi@lfdr.de>; Thu, 25 Apr 2024 14:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8AA149DEA;
	Thu, 25 Apr 2024 14:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbeyGHjb"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54D8149C6E;
	Thu, 25 Apr 2024 14:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714053695; cv=none; b=lCjuaz2HJK4w0p0RrTTKhXDLHbDN7gakVpRpnHTJPZtlplqgc+7Wz8Axhk9gJ/NJ1/MPPvVE8IZjYN0svzSRk2SI5sQry4GdfFnjnO3p6ULJ1N3s8NDsMiEq39ol1SMIiTni2NInoiEQcMw5TiE4Bsm6Rubrrby3keHkBq5fwAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714053695; c=relaxed/simple;
	bh=gOKjqTrwy/H/hFGh4uedpQPBDplAM1BDzbOPolpCIYg=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=tlUc8Txksa3qvXJBbCng/tgeTnbsSEmpRThuQvQVVi2CuD7CWOJ0iIYMeU583DMIB/Ore7MZeaQzK7lKIpoqfLjqVOLTNROCj9iIdx9PWocW678P215RPSIQyD98wF7VA+VTCxO/p6lMw/Kais960MF0CcHmmYJe1t3++0rmI+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbeyGHjb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A1FC113CC;
	Thu, 25 Apr 2024 14:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714053694;
	bh=gOKjqTrwy/H/hFGh4uedpQPBDplAM1BDzbOPolpCIYg=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=EbeyGHjbiDenFYP6KGmF/qCZqSu6doaojbB9dgrUPfciACqeqsBTPpfSn1RekYtTw
	 CufsNwYj+bScnknse+DnYbet1t3Ziqn8DUQop+Ej5fqex+ag8duuyQjzMwNHrvKX5B
	 0Ux2whXse8jX/0w0y7hF/S5to5IUyRPihqrhgZWPTHf8o4Oz7cVs6J/938dIIkJamF
	 Zf2ZNbxL3ibXeaFpaTfUETc+KvNDwmriW42SUVPHb164ERFpDsiSTB5azlqleLhvUp
	 vYOyHC+vo5yGzw7KU11M3fJswSBNJ5nDpxTnL+vwYvJkuEyBP5HEa3kArC6GVEEvel
	 xFhnAT+pLkxNQ==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Apr 2024 17:01:28 +0300
Message-Id: <D0T9BM4E1F5C.2TZMIRSHCKCQ2@kernel.org>
To: "Lennart Poettering" <mzxreary@0pointer.de>, "Ard Biesheuvel"
 <ardb@kernel.org>
Cc: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>, "James Bottomley"
 <James.Bottomley@hansenpartnership.com>, "Mikko Rapeli"
 <mikko.rapeli@linaro.org>, <linux-efi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH] efi: expose TPM event log to userspace via sysfs
From: "Jarkko Sakkinen" <jarkko@kernel.org>
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
 <ZiopXE6-AucAB9NM@gardel-login>
In-Reply-To: <ZiopXE6-AucAB9NM@gardel-login>

On Thu Apr 25, 2024 at 12:58 PM EEST, Lennart Poettering wrote:
> General purpose distros typically don't build all TPM drivers into the
> kernel, but ship some in the initrd instead. Then, udev is responsible
> for iterating all buses/devices and auto-loading the necessary
> drivers. Each loaded bus driver might make more devices available for

I've had since day 0 that I've worked with TPM driver (i.e. since 2013
or 2014) that module support should be removed.

I've kept the module compilation only because huge turnback from the
community.

It does not make sense:

1. Because it makes sense as part of "TCB".
2. "TCB" is should in be vmlinux.
3. TPM is also a subsystem with other clients in the kernel.

At minimum the main TPM driver should IMHO just in vmlinux e.g. because
it is rare to see distro kernel with TPM enabled and IMA disabled, I
don't know any.

That said, I would not mind either if TPM subsystem drivers were only
y/n *except* tpm_vtpm_proxy.

BR, Jarkko

