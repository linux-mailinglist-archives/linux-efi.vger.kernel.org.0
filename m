Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32071EFC47
	for <lists+linux-efi@lfdr.de>; Fri,  5 Jun 2020 17:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgFEPO1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Jun 2020 11:14:27 -0400
Received: from mout.gmx.net ([212.227.17.22]:42773 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726601AbgFEPO0 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 5 Jun 2020 11:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591370052;
        bh=iF8RLtxHp4hCNQUfAtO7WDqjaLTBwATiO0NZf3f2ZZI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Rb7/bdsiUXNqPou7B0ASpRtSp+OO3/JdBQe5MbH7D1iMavw5+faitigB4oCuySJMX
         1PCJqj24m9Z2LnBezfkuixjp0a0KMhY02QfmX8DPi2kvA0w/BKLYErB6mAPTKf3SZh
         yloHjPQFJ6fUjavHnCIcdvb2oZ1MZJ90D4Z8vYIU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.70] ([88.152.145.75]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4JmT-1jhV1p2aAL-000Mpz; Fri, 05
 Jun 2020 17:14:12 +0200
Subject: Re: [PATCH] efi/arm: decompressor: deal with HYP mode boot gracefully
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Russell King <linux@armlinux.org.uk>
References: <20200605115200.413921-1-ardb@kernel.org>
 <4498d910-f5cb-8559-afba-34710e9ca730@gmx.de>
 <CAMj1kXHS8AVczRPzySgzkkztD0yT1MXnCyMwmOt=ihZ9Bvo0vQ@mail.gmail.com>
 <589478fe-14a6-a921-3fdf-ae527e14b945@gmx.de>
 <CAMj1kXHwWwGyX1ijk-qjuV10p0Zr6sAYeAntx+iDVHp-tVaNwg@mail.gmail.com>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Autocrypt: addr=xypron.glpk@gmx.de; prefer-encrypt=mutual; keydata=
 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 Eg==
Message-ID: <99692142-0ee1-37a7-582e-56c38b2ef3d8@gmx.de>
Date:   Fri, 5 Jun 2020 17:14:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAMj1kXHwWwGyX1ijk-qjuV10p0Zr6sAYeAntx+iDVHp-tVaNwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZipPCLiaBh+FMmx9pGildUw47TNTi6DNz+Tdf4gnnM2kzKqffbf
 Zrw3Ue1Cs7hyIoh3gobYwmlBy6IGmrKHgJrHgUt//1spnnZe+fXGk+64DbwfVqPKElORqT2
 G/qnqxCBkKUxQzpvuV+6W3zXGCBMshXum4OpaGAM1tikfJf/IXVpO9x11j+mK1MYTE+Uu+1
 3oeMb5Pq5vpJm9M0VrQNg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:z4/toiyEcWM=:OsHZxNmF4yJcy4mGHmDkWm
 BD9B9hRCCq6WPXokbYWd77TtHYJdQ/DcOp9eOfBiTQ1GQWRLzr9FoyNUfNmLxEjDqPhIMRRqa
 02cEIM11QYQAYDduthHqAF6gfePYl5b+whkOJIozANp3OAxAwmmQ3mQWvZmmWCwcVeq3HAj+t
 JKJPA10njZaT4K0zU2UONadUo7dsxreloHU7LantTG3GiD+oNF3BYTBDzWR73PzKJC56deth6
 PoOhRc65tC+v3gtm/YH7c6YxFClxmoVLsYpctsbJCJh5xP6V0eB3EDYg+7jeT7sWAyXYc0bd5
 LUXuS64NFF1WdbHpZtvUje8Kb6Sd/YKUMURZ5YSHYofOzpVz/olwnPyiMfquHEnWJmxGO1wdX
 HHtTxUQYw3ahZ2FWSL13WUxAgDlRItqCHGw/wwz4jRBkKncf2ihHbt9G/IBpvytqlvmElTzZM
 lKrUKxebwl3L6jc5j/we+3YeAjJrVLpyBULGxKHWnXEIQxlogRl2dEkqEMQ3ABnKbMx38Iyeb
 OUII5YwsEH6yo2JC1VoHS9nuM3mJrbriMGYJITCrN2eQ0B/dB/eoK6JD0JbjEVUYdtoIkt6Zr
 G62Fca/WVD0aLW9LaBU9xAS5j0FBzYRemqXZKWH+5Hkufs2I9C7JeKfnTCqW0J/ChEj0BYY6f
 Q9kybCuTLRHUQ4+zgW26gxdDRv+BZACjoJ21kpafCFzbeUt/9AnubUXP6U3hQZOJ1plp94m7y
 ELM4jCxbtHuIaMROeCb6hZGJbhLAVJEZ/qtmXoAVUeK6cx1sdSZGT2Y/OsgOOtP641kwNko1q
 /j2OGGS7pESFYDORQ1SznCKY6OqaJriZQMSeMt/VgWztxg9nrIeq8lcTcNKLelaZkGGn8OpNJ
 h8E0a2YUU5jSvr10tlGFjQVCKdpL2V08qQlVtDZFQCZn0RSzLa45wDiObsqh5MJ712ACdfyIB
 6M2iukkzGLHTRVHCLNJbc4MG+nImRcNhyZn8LcyLosK/F28AAfB/jGlKoz1GPAej0VEbAMiDN
 WOQpS2f59V2GEu16SjwzSXqhMvMvUnLHVnbNgi4eu8VlNGNGfSJRVlmd+iKF/yLWtoy/SXZ+L
 s0+WYrYCpncD34tlRD5eOiisvX8FroWmhkTKvP/SsclflQ57be6Cs1H4Kgyu3F8deYA2DRs9A
 yc3+gMAfgvwwL+VlM9KtJN3QJFaFaQpm5UjYSDxFaVLqefJWHS0WtPKoGrty30pxbaH8kdiBK
 SjyngtvHRu8khHZDR
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 05.06.20 16:57, Ard Biesheuvel wrote:
> On Fri, 5 Jun 2020 at 16:54, Heinrich Schuchardt <xypron.glpk@gmx.de> wr=
ote:
>>
>> On 05.06.20 14:39, Ard Biesheuvel wrote:
>>> On Fri, 5 Jun 2020 at 14:20, Heinrich Schuchardt <xypron.glpk@gmx.de> =
wrote:
>>>>
>>>> On 05.06.20 13:52, Ard Biesheuvel wrote:
>>>>> EFI on ARM only supports short descriptors, and given that it mandat=
es
>>>>> that the MMU and caches are on, it is implied that booting in HYP mo=
de
>>>>> is not supported.
>>>>>
>>>>> However, implementations of EFI exist (i.e., U-Boot) that ignore thi=
s
>>>>> requirement, which is not entirely unreasonable, given that it does
>>>>> not make a lot of sense to begin with.
>>>>
>>>> Hello Ard,
>>>>
>>>> thanks for investigating the differences between EDK2 and U-Boot.
>>>>
>>>> What I still do not understand is if there is a bug in U-Boot where
>>>> U-Boot does not conform to the UEFI specification? In this case I wou=
ld
>>>> expect a fix in U-Boot.
>>>>
>>>
>>> U-Boot violates the EFI spec, yes. The spec is very clear on how the
>>> MMU is configured, and this rules out booting with the caches off, or
>>> booting in HYP mode.
>>>
>>> However, given that this is the situation today, we still need to deal
>>> with it on the Linux side.
>>> In parallel, fixing it in U-boot may be appropriate. However, I think
>>> the EFI spec is too detailed here - instead of 'booting at the highest
>>> non-secure privilege mode', it tells you which exact bits to set in
>>> SCTLR, which seems overzealous to me. In other words, even though it
>>> violates the letter of the spec, I don't mind dealing with this
>>> exception in the Linux side, since the requirement is somewhat
>>> unreasonable to begin with.
>>>
>>>> Or is it simply a deficiency of Linux that it does not properly suppo=
rt
>>>> HYP/EL2 mode on 32-bit ARM?
>>>>
>>>
>>> No, this is definitely not the fault of Linux.
>>>
>>>> Up to now I never experience a problem booting a 32bit board via U-Bo=
ot
>>>> -> GRUB-EFI -> Linux. Where did you have a problem when booting via
>>>> U-Boot's UEFI implementation and the current Linux kernel?
>>>>
>>>
>>> I haven't managed to make it fail, but my only 32-bit HYP capable
>>> platform is QEMU. I am not 100% convinced that the EFI+HYP+U-Boot case
>>> is rock solid, and I may have gotten lucky with QEMU (which uses
>>> emulation not virtualization when running at HYP)
>>>
>>> Do you have any A7/A15 based boards that don't print 'WARNING: Caches
>>> not enabled' at boot?
>>
>> Hello Ard,
>>
>> I have no board that prints this. Where did you actually see this outpu=
t?
>>
>
> In U-boot
>
> arch/arm/lib/cache.c: * Default implementation of enable_caches()
> arch/arm/lib/cache.c- * Real implementation should be in platform code
> arch/arm/lib/cache.c- */
> arch/arm/lib/cache.c:__weak void enable_caches(void)
> arch/arm/lib/cache.c-{
> arch/arm/lib/cache.c-   puts("WARNING: Caches not enabled\n");
> arch/arm/lib/cache.c-}
> arch/arm/lib/cache.c-
>
> The QEMU port does not override that routine. This may be the reason
> it doesn't work for me under KVM, but only under emulation.
>
>> The string "Caches not enabled" does not exist in Linux next-20200505
>> according to "git grep -n 'ache not enabled'".
>>
>> Here is some sample output for an Orange Pi PC with a quad core
>> Allwinner H3 Soc. "ARMv7 Processor rev 5 (v7l)" according to
>> /proc/cpuinfo, compatible to "arm,cortex-a7" according to the device tr=
ee.
>>
>> $ uname -m
>> Linux orangepi-pc 5.6.0-2-armmp-lpae #1 SMP Debian 5.6.14-1 (2020-05-23=
)
>> armv7l GNU/Linux
>>
>
> Could you check whether it boots in HYP mode?
>
> [    0.381460] CPU: All CPU(s) started in SVC mode.
>
> vs
>
> [    0.135626] CPU: All CPU(s) started in HYP mode.
>
>
> ?
>

Booted via GRUB-EFI:

sudo dmesg -H | grep 'started in'
[  +0.000017] CPU: All CPU(s) started in HYP mode.

Booted via Linux stub:

$ sudo dmesg -H | grep 'started in'
[  +0.000016] CPU: All CPU(s) started in HYP mode.

Best regards

Heinrich

