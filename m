Return-Path: <linux-efi+bounces-4726-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8635B5219C
	for <lists+linux-efi@lfdr.de>; Wed, 10 Sep 2025 22:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7A611C252E2
	for <lists+linux-efi@lfdr.de>; Wed, 10 Sep 2025 20:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69932EDD45;
	Wed, 10 Sep 2025 20:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="VvtVfaZt"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAA42EC0AF;
	Wed, 10 Sep 2025 20:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757535051; cv=none; b=tvh5ism9wyJw55qekeRli/aLs1YhsGbUcHyaxpPcMjZTlaAXQxPyguBa84yYAg8AvnyNGo5UF1olTYL43ghH2wBmV7eDzX8tjCOQc/3oFW4/1pnrAsvJI81MpcZzkysPf8ocz9yVgIOiUx1P9Nsx6aWtDRbuWZaLwsBhvvNGTWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757535051; c=relaxed/simple;
	bh=g50av+dzWXwAkB1AvWeZAugrVNqbOK44tdqJQn2s1mk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=RewgsKmsCg8pMtuTGmNapksPpq/rciIQXo1AvJbdZv0Gv7dy+MHcZgaYgbC62k0UOaVc67SxJs+GgIqc1R4V7XjCeRZ3cfOeoeSGMscBP9q8qAUBxc/hQpgGK9mEQDna1WU1bNVhin50kLL43QdDPK8rtdfBdJjCqHJJ3Myhtys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=VvtVfaZt; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 58AK9owl2967955
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 10 Sep 2025 13:09:51 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 58AK9owl2967955
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025082201; t=1757534991;
	bh=g50av+dzWXwAkB1AvWeZAugrVNqbOK44tdqJQn2s1mk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=VvtVfaZt8l0o8z8E4U8WMPnbkS+F0b4T2xeL1eiG3WR4zHL/XFcUldIZFHm+0HZs+
	 /xi2pudkHbQrgllTKqlSXCPp+xkPyxAyLoChkqRnEiBsOnJJKvT4re897hbHESh6AE
	 aBHx1aW3G6nfPCBa4afaNOF+ldXALL3VTbIADflwKoUSXleIhXAR1FxbD8Exs+bVbV
	 EHyVvO7e4m/63BPpT/lnG4BLVyMPlcpt880PsUXf8Hg5GlyUO3mD/gBTli7vyYdBbx
	 pgLf5JnL1jXXcHLZk6puxhsRabDz9t0Tw0YZQtpOGPfncBqIUkZACSO74x4Z7R22Sh
	 z6nLEvyWDNWKg==
Date: Wed, 10 Sep 2025 13:09:50 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux EFI <linux-efi@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Hugo Osvaldo Barrera <hugo@whynothugo.nl>
Subject: Re: [PATCH] x86/Documentation: explain LINUX_EFI_INITRD_MEDIA_GUID
User-Agent: K-9 Mail for Android
In-Reply-To: <aMEUUkVQv2tqpO2L@archie.me>
References: <20250910015738.14848-2-bagasdotme@gmail.com> <0b61b6f3-f11a-494c-9d4e-94ca19fd1eb6@infradead.org> <aMEUUkVQv2tqpO2L@archie.me>
Message-ID: <0C55A642-8BC8-4C19-9FF5-8B803E2CCABA@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On September 9, 2025 11:01:54 PM PDT, Bagas Sanjaya <bagasdotme@gmail=2Ecom=
> wrote:
>On Tue, Sep 09, 2025 at 08:25:34PM -0700, Randy Dunlap wrote:
>> On 9/9/25 6:57 PM, Bagas Sanjaya wrote:
>> > +=2E=2E _pe-coff-entry-point:
>> > +
>> > +PE/COFF entry point
>> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > +
>> > +When compiled with ``CONFIG_EFI_STUB=3Dy``, the kernel can be execut=
ed as a
>> > +regular PE/COFF binary=2E See Documentation/admin-guide/efi-stub=2Er=
st for
>> > +implementation details=2E
>> > +
>> > +The stub loader can request the initrd via a UEFI protocol=2E For th=
is to work,
>> > +the firmware or bootloader needs to register a handle which implemen=
ts the
>> > +``EFI_LOAD_FILE2`` protocol with the ``LINUX_EFI_INITRD_MEDIA_GUID``=
 device
>> > +path=2E In this case, a kernel booting via the EFI stub will use the=
 ``LoadFile``
>> > +function on the registered handle to obtain a reference to the initr=
d=2E
>>=20
>> drivers/firmware/efi/libstub/efi-stub-helper=2Ec (line 509) says LoadFi=
le2
>> protocol=2E Is that the same as the LoadFile function?
>>=20
>> https://github=2Ecom/u-boot/u-boot/commit/ec80b4735a593961fe701cc3a5d71=
7d4739b0fd0
>> (the link below) also says LoadFile2() 4 times (and LoadFile 0 times)=
=2E
>
>From UEFI spec [1], both LoadFile and LoadFile2 protocol versions of Load=
File()
>function has same prototype but somewhat different in behavior=2E To answ=
er
>your question, however, I think so=2E
>
>EFI folks, what are your opinions?
>
>Thanks=2E
>
>[1]: https://uefi=2Eorg/specs/UEFI/2=2E10/13_Protocols_Media_Access=2Ehtm=
l
>

Sounds like the code was updated but not the documentation=2E

