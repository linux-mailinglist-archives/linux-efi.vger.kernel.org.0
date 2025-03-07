Return-Path: <linux-efi+bounces-2922-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D584CA56AE1
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 15:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C480D3A88B6
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 14:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7692E192D68;
	Fri,  7 Mar 2025 14:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ITqqkU4U"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39E916EB4C;
	Fri,  7 Mar 2025 14:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741359173; cv=none; b=KKa2/jmebfLgHWNd2D/NDPUXyAh/zYoJYKmkdWfO2msHU9BmURMmjNGKQ/YSeyGxfQPXUStgZeyMXWqtY6tlt0aUzE9BlrHsN7hjPbhSlRCfcTy7cqUJWc6C3xWAtDxs32iU1uwaCPSMXLs+VQUVvjQmIW4Xbt6prSyZQIUikvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741359173; c=relaxed/simple;
	bh=ow/CxyCveehpyi+AMsvz13Db0iERxnsb0LBD0S8iRdg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=tK480kp23JywZe4W1N2eAb2CZG+jJ2Yz2KlYOZEAhoOSgkR67O/z9RgVgPCmjXiPktZG/8vDrKNBYJvW6qoUzodXsfLKPRvfgmSTmUlz7T8drtO0kIl3k2SHdT9M2kfpjWnSlWxa3rigDbxkbof0J1J0RXeSX+O8Txfglu+MOxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=ITqqkU4U; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 527EqIST276923
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 7 Mar 2025 06:52:19 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 527EqIST276923
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741359140;
	bh=wDm8ZBbwVf2xYgmRDmNQakZ/Sl2xnVeRQQQ12ZxMGDc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=ITqqkU4UCxrbH2IhHojAkxPV/8OVvKQTwilKlWGevMczC+sDdwItvUbrlhr8embGE
	 7bGwcg5a6p6TdaMC91MqWbKO5yU56KXQvB/SouzEz0jdoKpELmzl0l1HVSYf/pMvzs
	 YmaVeViFXu6BQ9B2Su9F5G7luQ2QYJgcfpiZV0H1nbw+MmCNp+TF34tH+m2n6+hyyY
	 vwEUIlGEuv/CWvecdQ6eQcq9wX5gn6TopRMMxxWeqLYtnGtDxMumf7sZwWHT2iHo5Z
	 4r5JEgl3XUBy7f/vtjVO46dKBRp6rwAFNl8v9buFd+qHNKVfx7kZCGhy5yk2MhMK8J
	 GonkC2gLUpsMw==
Date: Fri, 07 Mar 2025 06:52:17 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Ard Biesheuvel <ardb@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>
CC: Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org,
        linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Jones <pjones@redhat.com>, Daniel Berrange <berrange@redhat.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>, Luca Boccassi <bluca@debian.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] x86/efi: Add a mechanism for embedding SBAT section
User-Agent: K-9 Mail for Android
In-Reply-To: <CAMj1kXHQydeGHTa3Jd-ZByMntdqRp4f74ow6Uc0GLwjmejCSbw@mail.gmail.com>
References: <20250305101744.1706803-1-vkuznets@redhat.com> <CAMj1kXF-c46Bdw_cmLK-TckxukefqkpAYkOhg3jzfvW6YucDog@mail.gmail.com> <63vy4xc4mpm5tttdqz5vfzwyriqlminjdiffrbuamxcubmpuur@nxszi7xzxa6a> <CAMj1kXHQydeGHTa3Jd-ZByMntdqRp4f74ow6Uc0GLwjmejCSbw@mail.gmail.com>
Message-ID: <885FB3F6-B085-45DE-9710-10563322B61A@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 7, 2025 6:15:27 AM PST, Ard Biesheuvel <ardb@kernel=2Eorg> wrote:
>On Fri, 7 Mar 2025 at 14:29, Gerd Hoffmann <kraxel@redhat=2Ecom> wrote:
>>
>>   Hi,
>>
>> > > This patch suggests a different approach: instead of defining SBAT
>> > > information, provide a mechanism for downstream kernel builders (di=
stros)
>> > > to include their own SBAT data=2E
>> >
>> > Why does this require a mechanism in the upstream kernel at all?
>>
>> To avoid every distro re-inventing the wheel?
>>
>
>Fair enough=2E
>
>> > > - CRC32 must be at the end of the file=2E
>> >
>> > We never cared about the CRC32 before with signed EFI images, which
>> > gets clobbered when the image is signed=2E Why should we start caring
>> > about it now?
>>
>> I have some blurry memories on having seen this crc32 discussion
>> before =2E=2E=2E
>>
>> The crc32 is not clobbered=2E  The signature is simply appended and
>> wouldn't overwrite the crc32=2E  But if software expects to find that
>> crc32 in the last four bytes of the file then yes, that assumption does
>> not hold any more for signed kernel binaries=2E
>>
>
>The crc32 is a CRC over the entire bzImage=2E Whether or not it lives at
>the end is irrelevant, as signing the bzImage will necessarily [*]
>break the CRC, and subsequently regenerating the CRC will invalidate
>the signature=2E (The CRC lives at the end because that is the easiest
>way to generate an image whose checksum including the CRC itself is
>~0=2E However, there are also other ways to achieve this)
>
>> Who uses that crc32 and how?  If it is useless anyway, can we just drop
>> it upstream?
>>
>
>I tried but hpa objected to that=2E [0]
>
>> > Please don't create a special case for x86 again - iff this needs to
>> > be in upstream (which I am not convinced about) it needs to be
>> > implemented for all architectures=2E
>>
>> Well, x86 *is* the special case=2E  Everybody else just uses zboot=2E
>>
>> But, yes, when this RfC patch discussion comes to the conclusion that
>> this is useful to have upstream the plan is to do this for zboot too
>> so all architectures are covered=2E
>>
>
>Good=2E
>
>> > So I'd like to understand better what is preventing you from appendin=
g
>> > a PE/COFF section on an arbitrary bzImage (or EFI zboot image)=2E
>>
>> Well, assuming it is safe to ignore the crc32 as per above discussion
>> then nothing really=2E  It should be possible to do this as part of the
>> signing process instead=2E  That leaves the "not re-inventing the wheel=
"
>> aspect of this on the table=2E
>>
>
>[*] While it is feasible to generate an image that checksums to ~0 and
>is signed for UEFI secure boot (details in [0]), I seriously doubt
>that we should bother=2E Not even hpa's own bootloader 'syslinux' cares
>about the CRC-32, and given that all signed distro kernels that have
>been in circulation since they started signing them have corrupted
>CRCs, there is really no need to start caring about that now=2E
>
>If there is a need to maintain this upstream, we can host the tools
>but I don't see a reason to integrate this with the bzImage build as
>this patch proposes=2E
>
>
>
>
>
>[0] https://lore=2Ekernel=2Eorg/all/20230818134422=2E380032-1-ardb@kernel=
=2Eorg/T/#m3d3c7b62045072090c49706295a1fc9aa6a5e349

I don't remember who it was that asked for the CRC32 long ago=2E It wasn't=
 for Syslinux; it was for an embedded boot loader which didn't have a file =
system=2E=20

I don't know what would break, and it is obviously a mess that the signing=
 protocol didn't take that into consideration, but that is water under the =
bridge, too=2E

We could try zeroing out the CRC field and see if anyone screams=2E=2E=2E


