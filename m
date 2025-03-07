Return-Path: <linux-efi+bounces-2924-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA5AA56C4D
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 16:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 657451898853
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 15:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8E921D59E;
	Fri,  7 Mar 2025 15:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="YuuNbRUQ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2E62E822;
	Fri,  7 Mar 2025 15:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741361988; cv=none; b=FiYgyg503eFewtH9vGQdUh6+RTbP17t/e+jZORXAWVAtslPcxutKjUvhGbO3bI3pONd2fRVltIIgk3NaUlAinePN/pWy0/ccWnUX5Q6zlnamoBqC/5T3Pq4UMdwgarovgy5a2AyT5PHG1TN2au9r/17qzWlJvIVvXLzT0zpBMLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741361988; c=relaxed/simple;
	bh=vPqeNz54Wb9FFR8fdVTjrai7dSJIfvJ57luorzLSyaY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=VinEMF2kKplneM/mqFt4Pg1RwwUxoNVNEv36ZLL22H7UZmmRVI+U0FhKYrKuP3veBase+CI8GT48i0Blj9DApbfd77DajGuUq91eG/2W9CWcTZ6LSVTUqOscE/3imUrmZQJ/62NPYLZumpYPoTbHhaKXBQcGFHKOm+3pgH4hblU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=YuuNbRUQ; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 527FdPKX298223
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 7 Mar 2025 07:39:25 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 527FdPKX298223
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741361966;
	bh=51/p7Nh9x69EMjvMrY+40a3K4XnNy1F2j71wTDLIWyk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=YuuNbRUQH4U/P7Xe7qlfUFq2faaDsrUEyBkGNILAghwiMg3q/+IBX3hVWhD7VbGs/
	 7fbLWvNK6cVBdPbt7knIvLKYDM0SFnqeHN4tY6TuCLmg2DGcf/EYF+FkA7SFt0RlSx
	 6sx8iJa3oopm0xMhZzZhSWX5oFwZKHvCgcsJQ/SH+VEiEOsEOHatMyV9jAXyvZJMYs
	 J4TE5QNaW9x0bNTYlYwToRHFcAdufvjNkzHrK9H1NYrRKXLKAqM2WOdmC2lXr0QOj3
	 iV8lP0fBdTBE1xPRg9F9qANo++G8jmDlYOSSEq3R3yppkjwzVeXrqWxrpoYlmN/epD
	 Ax/KmMEszWFbw==
Date: Fri, 07 Mar 2025 07:39:22 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Ard Biesheuvel <ardb@kernel.org>
CC: Gerd Hoffmann <kraxel@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
        x86@kernel.org, linux-efi@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
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
In-Reply-To: <CAMj1kXF7Qs=9COU63k8651uEtSh9soOHddSo=Dqdn1kHTuuzoA@mail.gmail.com>
References: <20250305101744.1706803-1-vkuznets@redhat.com> <CAMj1kXF-c46Bdw_cmLK-TckxukefqkpAYkOhg3jzfvW6YucDog@mail.gmail.com> <63vy4xc4mpm5tttdqz5vfzwyriqlminjdiffrbuamxcubmpuur@nxszi7xzxa6a> <CAMj1kXHQydeGHTa3Jd-ZByMntdqRp4f74ow6Uc0GLwjmejCSbw@mail.gmail.com> <885FB3F6-B085-45DE-9710-10563322B61A@zytor.com> <CAMj1kXF7Qs=9COU63k8651uEtSh9soOHddSo=Dqdn1kHTuuzoA@mail.gmail.com>
Message-ID: <82D253A5-FD13-4530-BC1D-237EF42B9E07@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 7, 2025 7:29:27 AM PST, Ard Biesheuvel <ardb@kernel=2Eorg> wrote:
>On Fri, 7 Mar 2025 at 15:52, H=2E Peter Anvin <hpa@zytor=2Ecom> wrote:
>>
>> On March 7, 2025 6:15:27 AM PST, Ard Biesheuvel <ardb@kernel=2Eorg> wro=
te:
>> >On Fri, 7 Mar 2025 at 14:29, Gerd Hoffmann <kraxel@redhat=2Ecom> wrote=
:
>> >>
>=2E=2E=2E
>> >> The crc32 is not clobbered=2E  The signature is simply appended and
>> >> wouldn't overwrite the crc32=2E  But if software expects to find tha=
t
>> >> crc32 in the last four bytes of the file then yes, that assumption d=
oes
>> >> not hold any more for signed kernel binaries=2E
>> >>
>> >
>> >The crc32 is a CRC over the entire bzImage=2E Whether or not it lives =
at
>> >the end is irrelevant, as signing the bzImage will necessarily [*]
>> >break the CRC, and subsequently regenerating the CRC will invalidate
>> >the signature=2E (The CRC lives at the end because that is the easiest
>> >way to generate an image whose checksum including the CRC itself is
>> >~0=2E However, there are also other ways to achieve this)
>> >
>> >> Who uses that crc32 and how?  If it is useless anyway, can we just d=
rop
>> >> it upstream?
>> >>
>> >
>> >I tried but hpa objected to that=2E [0]
>> >
>=2E=2E=2E
>>
>> I don't remember who it was that asked for the CRC32 long ago=2E It was=
n't for Syslinux; it was for an embedded boot loader which didn't have a fi=
le system=2E
>>
>> I don't know what would break, and it is obviously a mess that the sign=
ing protocol didn't take that into consideration, but that is water under t=
he bridge, too=2E
>>
>> We could try zeroing out the CRC field and see if anyone screams=2E=2E=
=2E
>>
>
>If dropping the CRC is on the table, we might also consider my
>original patch, which gets rid of the build tool entirely, given the
>fact that generating the CRC is the only thing it is still used for=2E
>(Either change can easily be reverted anyway)

I think it would have to be up to the x86 maintainers, but I would be will=
ing to test it=2E Perhaps it would be better, though, to make the CRC a bui=
ld option =E2=80=93 or we make it mutually exclusive with efistub=2E

