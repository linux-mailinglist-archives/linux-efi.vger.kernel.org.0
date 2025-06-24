Return-Path: <linux-efi+bounces-3930-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A76AE58C6
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 02:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F33E3189A944
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 00:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE4F19B5B1;
	Tue, 24 Jun 2025 00:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="e4o1w0cg"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEC6142E67;
	Tue, 24 Jun 2025 00:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750725840; cv=none; b=OKghQKDmDfsk2wDOXxV58ZXdnZJJF0g8cTk2SfBYKceNplGoltNaomClhSmT18sUlpZ0CO7qJyw9RGxJNNROBIHWr79sC4JXy2JBq35c6d1orBfM85qH8uRALSTVY2TKTs5yr7BvQi3qGczXPbdT07WzvokDf216JYK7vR4eadI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750725840; c=relaxed/simple;
	bh=UqObijsHs/LnfKJV9REC1QPHyu1RhgzDFngNxcMPNbA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ikU1NMZ008Q+r1PpVMpVtsQSRqe17ZIn/8OcGEXN3t8ONRem+gkeUuMV51Pri0UozQ5k+j0YFu+ZkNwH8aKfdCyXeT2Dn3FeAdCdKicnWSJU/vKE5EE1ka8AGtthJ8JfMLv7ryRa2mprVMsWO6KnnWCflUcfoWUgaeDf7vzwynk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=e4o1w0cg; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 55O0hSrm1141806
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 23 Jun 2025 17:43:29 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 55O0hSrm1141806
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1750725809;
	bh=+X9wnwhrmMF8m9tf/ubM1Lr1lJrCj+FL49ugXnmAQhg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=e4o1w0cgnq9O3fig5pEQTfzDGEyQPJY2ljs5avJMyikzGxgpHdYZaej4tvAIrN0Wo
	 BG8ou2f2JDYQDxNVtLjrhB7ud+P7GJDWkbSCbbcWYw0Ml3nKS0T1MFij0w8hDAAcN7
	 WACsy7pq4DBKZBKm8Ox1r+5/MyXM8eQxaAwkc6XPyO1A5qCHFNuimnVBaFOi5b5p8H
	 s+XwJC8lgYlZlNocDd+hzA4hYR33s/qkCXeJdBppNDb7/SBwMiWA142xRz2qeB9iIP
	 C8D5EIXKO1GPhPwQLZZM+sTUzYU+5MVKeH6ix2jXTwPKxweCFHlTy/h1feV5JBHeWQ
	 tYhHnN/7RHgkQ==
Date: Mon, 23 Jun 2025 17:43:27 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Brian Gerst <brgerst@gmail.com>, Khalid Ali <khaliidcaliy@gmail.com>
CC: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, ubizjak@gmail.com, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1_0/3=5D_x86/boot=3A_Supply_boot=5Fpa?=
 =?US-ASCII?Q?ram_in_rdi_instead_of_rsi_from_startup=5F64=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAMzpN2jP_rtFjvL3NQLcwFCgY8uwbJvqbup-KFHVaaSh-oRCcQ@mail.gmail.com>
References: <860684c8-a985-47bc-af30-3370f203e80d@zytor.com> <20250623183917.13132-1-khaliidcaliy@gmail.com> <CAMzpN2jP_rtFjvL3NQLcwFCgY8uwbJvqbup-KFHVaaSh-oRCcQ@mail.gmail.com>
Message-ID: <9FE74F68-5CF9-4EFE-8271-551ECC9087B9@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On June 23, 2025 12:24:50 PM PDT, Brian Gerst <brgerst@gmail=2Ecom> wrote:
>On Mon, Jun 23, 2025 at 2:40=E2=80=AFPM Khalid Ali <khaliidcaliy@gmail=2E=
com> wrote:
>>
>> > This is also invoked by some external bootloaders that boot the ELF
>> > image directly, even though this is strongly discouraged=2E
>> >
>> > Therefore this patchset is NAKed with extreme prejudice=2E
>>
>> Thanks both of you peter and brian,
>>
>> however, the boot protocol document saying "%rsi must hold the base add=
ress of the struct boot_params",
>> it doesn't mention why=2E Maybe the document needs update to justify th=
e reasons=2E I wouldn't have known it
>> if you didn't tell me, so this shouldn't confuse anyone else=2E
>
>The use of RSI was inherited from the 32-bit kernel, but the real
>reason is lost to history=2E  It's just always been that way and there
>is no compelling reason to change it=2E
>
>
>Brian Gerst
>

The reason isn't lost to history: I picked %esi because I found that none =
of the weird bootloaders which looked the protected mode jump clobbered tha=
t particular register=2E

