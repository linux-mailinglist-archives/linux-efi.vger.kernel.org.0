Return-Path: <linux-efi+bounces-5922-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FFFCDA5F3
	for <lists+linux-efi@lfdr.de>; Tue, 23 Dec 2025 20:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA718300726D
	for <lists+linux-efi@lfdr.de>; Tue, 23 Dec 2025 19:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2236C2AF1D;
	Tue, 23 Dec 2025 19:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="XvcgwatD"
X-Original-To: linux-efi@vger.kernel.org
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1BB34B433;
	Tue, 23 Dec 2025 19:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766518311; cv=none; b=hQ6UWInxFKQ2NIZUaJg4xWFKwx07wwjW4z69qPUvXYFn8y1vl7fMrD5ywrGDBOyR1W4htY94rMOOPBT7639G3FfgsFoOhl3mDuokj+8/bipCjDvsAwKZW4n6MTyqRXjYa66hD+vcJOZhq2LMKf75NSUDSOyaDrqHOoSm3L/yrBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766518311; c=relaxed/simple;
	bh=S3MC/DJyxuqUqO+aA+Wb0Xz81EzDT3zbLRjYsUOml1Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eDw8OZ+teQAPlutBpaqJHw85WaEjpFE/GgBcRm5AU8I8aJloNKePNiesx2AgMrZKuJgQsJdNFwqJLuORsW45dR5C3gX3wAHksglN5lEqLiCg56JXSP4sP9gmjzRBuQnFEAIAeDSWHXIBYFy0bx6dkqTZgvESm4UDOS1v2m50Tok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=XvcgwatD; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=S3MC/DJyxuqUqO+aA+Wb0Xz81EzDT3zbLRjYsUOml1Q=; b=XvcgwatDvNRIqTVzxBEvAtRgmD
	rFkbSYKJopSiemzHlULOFVByZwO+jcvsno7jG50qWziVJDNvgANFEgF8fuV2pTK4Qn+VDodpXvBGu
	uA+v25gq4eFGrsNCpmLhrxihh8vRM/jzbkO1mAgmLsFu4KZ86dP7BLXo4Kdgw9ehJm3I8ZrUTLker
	O0HChL0WBF7Sf0W63PKlHiwi4Zmwe3M+EgkvkfP7govGfwvWOr6/9WiMO8QpzdjrWzjsJWwblORCK
	abajXy7BIwQj79KS7+9KyEr4LrcuDjTPVtH+oN67oPZCW2aZ4y6mhCCP2yhNMQk7TA6Mt9RWiRB7h
	p83Fiypw==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1vY86V-000000005Xj-0BE2;
	Tue, 23 Dec 2025 14:31:32 -0500
Message-ID: <4d867df02dcc3cc8f519903282f6e63b2974a461.camel@surriel.com>
Subject: Re: [PATCH 2/2] kthread: Warn if mm_struct lacks user_ns in
 kthread_use_mm()
From: Rik van Riel <riel@surriel.com>
To: Breno Leitao <leitao@debian.org>, Ard Biesheuvel <ardb@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, puranjay@kernel.org, 
	usamaarif642@gmail.com, kernel-team@meta.com
Date: Tue, 23 Dec 2025 14:31:32 -0500
In-Reply-To: <20251223-efi_fix_619-v1-2-e0146b8b9d73@debian.org>
References: <20251223-efi_fix_619-v1-0-e0146b8b9d73@debian.org>
	 <20251223-efi_fix_619-v1-2-e0146b8b9d73@debian.org>
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
> Add a WARN_ON_ONCE() check to detect mm_struct instances that are
> missing user_ns initialization when passed to kthread_use_mm().
>=20
> When a kthread adopts an mm via kthread_use_mm(), LSM hooks and
> capability checks may access current->mm->user_ns for credential
> validation. If user_ns is NULL, this leads to a NULL pointer
> dereference crash.
>=20
> This was observed with efi_mm on arm64, where commit a5baf582f4c0
> ("arm64/efi: Call EFI runtime services without disabling preemption")
> introduced kthread_use_mm(&efi_mm), but efi_mm lacked user_ns
> initialization, causing crashes during /proc access.
>=20
> Adding this warning helps catch similar bugs early during development
> rather than waiting for hard-to-debug NULL pointer crashes in
> production.
>=20
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.

