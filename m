Return-Path: <linux-efi+bounces-2978-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD99A5E6A0
	for <lists+linux-efi@lfdr.de>; Wed, 12 Mar 2025 22:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F8647AD3FE
	for <lists+linux-efi@lfdr.de>; Wed, 12 Mar 2025 21:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EED15CD74;
	Wed, 12 Mar 2025 21:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bens.haus header.i=@bens.haus header.b="ePsYSQZL"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69724C13B
	for <linux-efi@vger.kernel.org>; Wed, 12 Mar 2025 21:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741815008; cv=none; b=cEuthqadcm4oYzs+ywN+JvjVeKsEePc9G4Zw/M22ItkJM1345lIjdYhgVnw8ShT9qTeiAW/gSJDRePR7s+6mDGiRMo1w0Do7JsnKKeDlmeuLtbqcdaJTjV2gkiemvDkapiuZoPvmUzX4Klr4sVKvdVc9zvPwkWEVcjdC4Q5aZUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741815008; c=relaxed/simple;
	bh=8EfnLEaFnZgstrvsP4BhtJB+xHKFXIJcuRVBU0dzG0A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rEWSM5pAsMdTkWEZhD8LochUg+YTWxGWYHx7Y0sucpLr4iqHoC0zCk1AtZAAKmG204sfMhP8CJcpB+Q0SZiWR+vzun4FWpSlfLKJ7AWQYfjkDEhximWmWKudkHMkuaHRieL7vdmgPHLWtyyke7CkYWlj4zMQzm7/X8aDlNlTbhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bens.haus; spf=pass smtp.mailfrom=bens.haus; dkim=pass (2048-bit key) header.d=bens.haus header.i=@bens.haus header.b=ePsYSQZL; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bens.haus
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bens.haus
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bens.haus;
	s=protonmail; t=1741814998; x=1742074198;
	bh=8EfnLEaFnZgstrvsP4BhtJB+xHKFXIJcuRVBU0dzG0A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=ePsYSQZLdIi24VneYYJbfD4XivfuRZ9wFRtgK0eZwpRVeAOHHboM4+EuQFKBjdjyz
	 rdGRAPqOpJxfMvVZY4z+tzkD5p+5moKV9a2l3SwmMFCEQ3GdNX0WDVredY8VplGkH3
	 6A//VdcRPGDrFnWUbc94pfXIzzPMzwE9KNNRCbc84FE7Ti4GsRBiYq3JYdPUBwdWSu
	 6jWC5R80TmT1t8QIJWAOcGmmdrq7pUStKV/YR3Z9WYfUCXrwCFD6XdxMdZBzpDYxmF
	 E24chNQXhJTCT4zR5vGe0xVJJ0yFp+onYQ4+FM/HQu+ZBTDwcs4jXGR+vFQsfPJlBe
	 kzi6JVYMDviyw==
Date: Wed, 12 Mar 2025 21:29:55 +0000
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
From: Ben Schneider <ben@bens.haus>
Cc: Ard Biesheuvel <ardb@kernel.org>, "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
Subject: Re: efi_random_alloc() returning EFI_NOT_FOUND
Message-ID: <DpAZYuRk4WyI-zq4nphTCsquKBgtbasVAB6AUkMVXTEefAEPzFFRWxPagtIHpiof1_Frb82n9T3eN0N41nmSQztm8TzUIZOJa-DJUdBpodw=@bens.haus>
In-Reply-To: <CAC_iWj+L9CJjg9ZMdT5aOM26osXo=90Xw1JKz+u102wa50W0jQ@mail.gmail.com>
References: <5BK24Nc0mA4pe8BFp-FUgN4Q9lCFpR1TUFMKB8mRUJIhOG1hP3yYcVIulRsDSQA_7MvOOH9dg1nUiDvQSkQ2tS1vZeiZbMEFEnsMbPzB0cg=@bens.haus> <PkBypGXyjiJ7T845148vEiHaoabJOyVg26qTLI-SygtRbQ9aQjnMWUddWHiYB9KPR8JVqDFQ1pZRnRUq06vIRR7L4CDLERwJL9-2LdvcxBc=@bens.haus> <CAC_iWj+YFNMZZneaQ+zh3ziM2iogB-whRsH81A8hKyNVPY0H9w@mail.gmail.com> <CihxtexZ2w9qfxFQ1v6_JhRD4eYGMDbKtlXqd7KTBfgKhNif3Qq3yaJriSzdiInTiywwgk-CxDDPCYqRPdfYKK3hf93yx774aFfjJKeIhs0=@bens.haus> <CAC_iWj+9DNswD7qCc7V8UxsAOaBTzx7QTYA7Yo8py5pEuHdWDw@mail.gmail.com> <gqqWrf3trBPlLLAJDR55YYQBffE1dToIMzSMgebh-GuI-06E3pX4WcYuFU7XOF3s_ZEjK70ePUUJBXu_V0tAxKc8dmNcQjlqR55cLRAHAJI=@bens.haus> <CAC_iWjKL7nSkr8CyFW6hOzfOTiCU+tES_PsEYC7hkcCA9gAp=Q@mail.gmail.com> <xPmYxk1shimT-7PEuiLsqTN03MY68Lcvo9Yud8PBo6IW7UdpvL-sS60VXmLbH3o3CgkyG4bH7kpZ2sgWaVQPn2y69m1vCj_AC_ukMKJKaz4=@bens.haus> <CAC_iWj+L9CJjg9ZMdT5aOM26osXo=90Xw1JKz+u102wa50W0jQ@mail.gmail.com>
Feedback-ID: 124562356:user:proton
X-Pm-Message-ID: e7700c494de5bb4382b6ffd01989efa21c274c7d
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wednesday, March 12th, 2025 at 1:46 PM, Ilias Apalodimas <ilias.apalodim=
as@linaro.org> wrote:
> >=20
> > As a reminder, size is 18087936.
>=20
> This is a decimal right ?
>=20

Correct. The result of printk("%lu", size).

> U-Boot has 64mb available and you are requesting to allocate ~17mb which =
fails.

Agreed. My uncompressed aarch64 kernels (Image) are ~17-18MB.

> Since this seems a U-Boot issue, I'll send a patch over to the other
> thread and we can continue from there
>=20

Thank you!

Ben

