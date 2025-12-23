Return-Path: <linux-efi+bounces-5921-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4CCCDA5CC
	for <lists+linux-efi@lfdr.de>; Tue, 23 Dec 2025 20:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5434930358C3
	for <lists+linux-efi@lfdr.de>; Tue, 23 Dec 2025 19:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F23528C5AA;
	Tue, 23 Dec 2025 19:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="cK5j6/WJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E5B27467E;
	Tue, 23 Dec 2025 19:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766517913; cv=none; b=SqGJWnKFJNvLuJen39ICO1dF5iM/yOedqBhbYOruIGGirLF6+PRR12Wi1CkFQ1lKgTVqSJWfO1uOedk1nEoVC07IcCVQXRuYMROSGto/J4LUK4L3QlNu0jt770Avy57CcqGJ/WYc4PBRDCzKf4H7eer7xUPxxS59w+uDWtBo1xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766517913; c=relaxed/simple;
	bh=rBMlsRRSL7SYzmLnlzQfBiudmDv05SeXL32l7wrOggg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H4bVknCUcUCxNNs28VfW3Sy/9nUg0rwbRPAaowi+uqIUwVXzlhIISugzsoXph2TvigUJMA7BkkhNWcpBjHyb/0G+o0zgRdJBBKXXRAeTWxPPaehIvi1TsJqFM5PernrTK1kP/Li9JCOTfOQPf4n5dBNl3hBMhIcxv7g1Tl74m7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=cK5j6/WJ; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=MKVZ6gnaghV+4OuvPE0MfgGwA+znTse9G/0vYKIzuzc=; b=cK5j6/WJxuN6PUjAGb5ilVl03d
	yAfLxWN6svhzkrUr9lZKZJLo2EfAKVNMdTrpd8umBGeroEYFOEH9bU8tsIvhhy+rEKQqtYJW9j668
	OjXdinWl0UXznZcP0+b1HO1/TAIH9+O37NaoAdhvUWeNiF+XXzbXZhZUiOX0IYkCMooyzh/bAqyZn
	HQQ3a1JzDng4lcTG4H9+yZk6TYqHuQQeihYnubj8eClYvPM0iiGrzRZ4ckg8yQ0QFbcP5nsatLdSY
	E+jrPYAI0agE6GKt50OuVMTbkPbM+PoerV7ua/tAHe/N5HZ7WowbGLxKIybesFvqLIntJFQjd04Ih
	6Ysq7I1Q==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1vY7zk-000000005Kw-26qy;
	Tue, 23 Dec 2025 14:24:33 -0500
Message-ID: <a060d8ec023cb7b8dbec0cb4105d03fb24c57a3d.camel@surriel.com>
Subject: Re: [PATCH 1/2] arm64: efi: Fix NULL pointer dereference by
 initializing user_ns
From: Rik van Riel <riel@surriel.com>
To: Breno Leitao <leitao@debian.org>, Ard Biesheuvel <ardb@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, puranjay@kernel.org, 
	usamaarif642@gmail.com, kernel-team@meta.com
Date: Tue, 23 Dec 2025 14:24:33 -0500
In-Reply-To: <20251223-efi_fix_619-v1-1-e0146b8b9d73@debian.org>
References: <20251223-efi_fix_619-v1-0-e0146b8b9d73@debian.org>
	 <20251223-efi_fix_619-v1-1-e0146b8b9d73@debian.org>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33A
 eo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47
 Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/
 lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdY
 dIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gU
 mllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986o
 gEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/
 r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHV
 WjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o
 6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635
 Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE
 +BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTe
 g4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/jddPx
 KRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/Ne
 fO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z
 3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0Mm
 G1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tP
 okBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznneko
 TE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44N
 cQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhI
 omYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0Ip
 QrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkE
 c4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-12-23 at 02:55 -0800, Breno Leitao wrote:
>=20
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index a9070d00b833..55452e61af31 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -73,6 +73,7 @@ struct mm_struct efi_mm =3D {
> =C2=A0	MMAP_LOCK_INITIALIZER(efi_mm)
> =C2=A0	.page_table_lock	=3D
> __SPIN_LOCK_UNLOCKED(efi_mm.page_table_lock),
> =C2=A0	.mmlist			=3D
> LIST_HEAD_INIT(efi_mm.mmlist),
> +	.user_ns		=3D &init_user_ns,
> =C2=A0	.cpu_bitmap		=3D { [BITS_TO_LONGS(NR_CPUS)] =3D 0},
> =C2=A0#ifdef CONFIG_SCHED_MM_CID
> =C2=A0	.mm_cid.lock		=3D
> __RAW_SPIN_LOCK_UNLOCKED(efi_mm.mm_cid.lock),

Seems legit?

Acked-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.

