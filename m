Return-Path: <linux-efi+bounces-3914-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDC1AE4870
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 17:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 469153A5B23
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 15:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00CE275B18;
	Mon, 23 Jun 2025 15:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="KA9g1Hl5"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30C3770E2;
	Mon, 23 Jun 2025 15:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750692287; cv=none; b=FwmzbIBjEm5oPrN7yicyoNkd80XZCj5kBU1WLOlLp1vLEo7wryF0U6QeUHBcX967gulVbwSVQ5d6elskPtgFsapQ2qZJcq3K/ec0dWVXu4y29CqgeoW85F9SfMz6CFYoessGee8jF04dSBlZQAJRSdsylM4GcJl85X9vgXu8Uq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750692287; c=relaxed/simple;
	bh=wlTiKIjvWwqf6t18hxDB41x4laHO4+OvmqsPz5wPksw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=vDrcWsY19BGOM5D2k7FMqmJxWU3tnkTrt1NukI1nDYyBpbeaXZR4VIGsQMKcb0WNfk8dLQJvf9x98u2baDwBdbh8AcW4dGDdteZgQLfItOwaR6AD4J+9ZMmnOAOOlFiCmRkedEyErflqafxISP0UHasiFDe0hSnxo5ejIz/uywU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=KA9g1Hl5; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 55NFOFxO981170
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 23 Jun 2025 08:24:15 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 55NFOFxO981170
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1750692256;
	bh=A1jMMXa/nw7lqBnFyr8Ce3LJwcClP6AKSk/3M0i9qfA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=KA9g1Hl56Dr7ze7uSMBmDaEo4af0rw/UOjgUFavm0WLWHKVlTPzThFkEG/sWIlhcR
	 pdhvtbSRmnh7IUFVzzN6zGV7OS+5b6DDk9O3p+v5ciw8J6q6NmFsaDHnhK9OfQFKQ5
	 1jOQwG5rSIVwXkntRYi3ccTte4j0Tr3RUQc/lVvIf0LdvqZRkEeWXGs5kAt46Wfr/g
	 +QW8HSARe3/32K5n9pjFMJ5NHpOUTxhdJ1W+1sya9VRSuKd9J/7DuK++VfwV449fpy
	 HEU0pqlrNjAFPoza97J3a8vrCZJoC6dj50hBORuCtmES8flPgwcRbXj16JLnhiuo/q
	 +BAhyw7oMGj5Q==
Date: Mon, 23 Jun 2025 08:24:16 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Khalid Ali <khaliidcaliy@gmail.com>, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, ubizjak@gmail.com
CC: x86@kernel.org, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] Recieve boot_param from RDI Instead of RSI
User-Agent: K-9 Mail for Android
In-Reply-To: <20250623081550.1262-1-khaliidcaliy@gmail.com>
References: <20250623081550.1262-1-khaliidcaliy@gmail.com>
Message-ID: <2D63735B-FA76-428E-8F68-8EBCAEA0985E@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On June 23, 2025 1:15:23 AM PDT, Khalid Ali <khaliidcaliy@gmail=2Ecom> wrot=
e:
>From: Khalid Ali <khaliidcaliy@gmail=2Ecom>
>
>Adjust the kernel entry point to recieve arguments from RDI instead of
>RSI=2E
>
>Signed-off-by: Khalid Ali <khaliidcaliy@gmail=2Ecom>
>---
> arch/x86/kernel/head_64=2ES | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/arch/x86/kernel/head_64=2ES b/arch/x86/kernel/head_64=2ES
>index dfb5390e5c9a=2E=2Ed24fea15b6a6 100644
>--- a/arch/x86/kernel/head_64=2ES
>+++ b/arch/x86/kernel/head_64=2ES
>@@ -43,7 +43,7 @@ SYM_CODE_START_NOALIGN(startup_64)
> 	 * for us=2E  These identity mapped page tables map all of the
> 	 * kernel pages and possibly all of memory=2E
> 	 *
>-	 * %RSI holds the physical address of the boot_params structure
>+	 * %RDI holds the physical address of the boot_params structure
> 	 * provided by the bootloader=2E Preserve it in %R15 so C function call=
s
> 	 * will not clobber it=2E
> 	 *
>@@ -56,7 +56,7 @@ SYM_CODE_START_NOALIGN(startup_64)
> 	 * compiled to run at we first fixup the physical addresses in our page
> 	 * tables and then reload them=2E
> 	 */
>-	mov	%rsi, %r15
>+	mov	%rdi, %r15
>=20
> 	/* Set up the stack for verify_cpu() */
> 	leaq	__top_init_kernel_stack(%rip), %rsp

This is an ABI=2E

Nacked-by: H=2E Peter Anvin <hpa@zytor=2Ecom>

