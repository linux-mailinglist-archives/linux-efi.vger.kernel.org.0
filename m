Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 057C210120E
	for <lists+linux-efi@lfdr.de>; Tue, 19 Nov 2019 04:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfKSDPv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 Nov 2019 22:15:51 -0500
Received: from mout.gmx.net ([212.227.15.19]:58439 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbfKSDPv (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 18 Nov 2019 22:15:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574133336;
        bh=HXZgfdquNJN95+GjB3c2ybMyiD0ApmVVOtzBGc+NWgw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=HFi3Odo90gswAMi6G/bjan5KRAr1Dn2t0m4uetB/dDLRxpLX7zawIG6gegvYnk7V3
         uQGpnTfOwOTLw0EeQ4JbaJgyoqiofVTPfgVkNGVgHAS9hXYQ85BuHMXy+1uIyefKBY
         IIQblkFlGhsCVI8i5GEuOlUxGKAe7sqqafGA+bpQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.51] ([94.114.42.168]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuUj2-1hfceA37BK-00rVXH; Tue, 19
 Nov 2019 04:15:36 +0100
Subject: Re: [PATCH 0/1] Temporary fix for data abort on armv6z EFI boot
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Guillaume GARDET <guillaume.gardet@arm.com>
Cc:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kairui Song <kasong@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        linux-efi <linux-efi@vger.kernel.org>
References: <20191118174252.26758-1-cristian.ciocaltea@gmail.com>
 <20191118181020.GA17031@lakrids.cambridge.arm.com>
 <CAKv+Gu_Ob5T6FfDo7dHnC+eF09_89HW2uYZv2J9A6+7jn65w0w@mail.gmail.com>
 <20191118185116.GB17031@lakrids.cambridge.arm.com>
 <CAKv+Gu8KGQ_+sLL01yGhr5m4YbH2a7tDS9F33=oe=b_3Z5tyLQ@mail.gmail.com>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <8a4237f7-6757-1fea-0f4a-b78e4b698799@gmx.de>
Date:   Tue, 19 Nov 2019 04:15:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8KGQ_+sLL01yGhr5m4YbH2a7tDS9F33=oe=b_3Z5tyLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EKSbrqz5YX05etUeuEPWTMJfLy4oYG+h5e719LLdGmt/7SFahJh
 KZ/cC2nTtaP9eg1yTgx9ICrnkvzDOrDcHlPxvYQ0llhpE8PZ/cZVgIxe2y2tEpkKN2WVq+E
 e3Xcm0uy9Lcsk4cSn8DuGwVY9B0EWjyb1uBsbOFDnsIs1WiHDgYhPuekJLoPZn0dLR4CvQy
 /n6BLbBqEuTA/lEZT15QA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:StmCkHbB+9Y=:beMBpCVrB76ZpW0WKO6Pik
 zTEMmye9yFehmLmaXD/WAgRNdvwCVYBmsgQeqCfzQdDNkagyKa4/BATXsgVaY/g5GQpmN6sS4
 w1C5rIvyepHDGL2e4wBFlaB3XJmxYe7LXe4Yc/FKhCa1LnlbfPvlvc8w/98iXVIyQbas1sYrp
 v8Jv+jDlUVbWmbKK5cfEORU4D+R9JxPsqpxnseRJ9KpWwLp5//vgdaJf6Q9YtuxYT6XVUTFyC
 GfFHpxxEtBKYU2Fs6+uMKIatsVsJnMjCzKGR7zGhjJwnBBDpRar84VP9wbnOqjM2qz7tfa5qj
 3dmqYl8uh9iQs2P4JjfXC4dXiPLbSusL1viLJO12wnKvDvRHyC9aTYnoxrez9TykJt4HHBUxH
 nP8y42a5+8LplYDNDEL/+9KAqk9bdDy3KyIZFbyv9/KdNwBtibBufYe0UodOYX3xMI6jtr4ed
 Ev4M27WfKGrHPjF39ttpa25A5gPY1gcnBCmK1t9ffskXRo4wK4JEwMFkULriJctkNrcqbPPf6
 xr4G1/82mV2Tj53KkXtIblJomoyU9u1V94/Rqa0BO6OZnP14wDN2zZbBkNjlGvAButuAgU9ri
 T0ZOgcJ5PXt8n+vd7GCg0G+3ctrdRKVmqlYLORAec/uoycDGWv59m7VlwzF2Nt5iSfZNXw/VK
 DGj/oZp5dGTd1jfoZvvRgg7IjjMOxkUHFXOsMC8JDGS8pFzCUk1SKa/r6IJeEn2HojdCwdxM1
 tDRZN5i44ETRZT9c6mDf99cca7TqN2zyDJ0VxzbpwFPxV9qE6J1mWEsQ0Vpc9+UPMuWIU2K5q
 DbRJVsFBhQ6BOaT3SpoDz43pL/T87olj2EdES8HLsfYJ6DRnt3wsxJJzZXjXNMcLiFSWvP2rp
 z+XEM5W1RC1iUO/5JO1+AXCD3zqFUnTdmDc9U4OOEeV6pVwCIEu4b6dWYIc1o2CKCIskBgI7C
 zeZKD4XzxQzD79tZuUC2BBDPHq8swsHTj9Io5e7q7rFL7NoUxs+CT/OJDnWhl74ciozoDRNVi
 3LBXHabUDHwOsfwq0YPvc6bT4MBzB/Ay0fUTLjlPbmBrqW9JJ/fbhhWFrKhU6e3eLTxAaC1dE
 PoIuzQ5TCHi2nqUujdz4qLcJ/HB3wOljpyYWgQhHOEDAu0yxyzuYk41LKHQVQBv0VgaCa0BTw
 XWzXHOnFsiJAO2Es+mHgglJEW1aHQJFRgPcWOkgyq4K9M3pTxKwwduoduy202MXlSbofO087s
 aGxjYLwLfPSl1G+AfvUX15kzd9hEogvEgFBQYV+6zFVcj+PkW1zUrhLAs1aw=
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 11/18/19 8:41 PM, Ard Biesheuvel wrote:
> (adding Heinrich and Guillaume again)
>
> On Mon, 18 Nov 2019 at 19:51, Mark Rutland <mark.rutland@arm.com> wrote:
>>
>> On Mon, Nov 18, 2019 at 07:15:04PM +0100, Ard Biesheuvel wrote:
>>> On Mon, 18 Nov 2019 at 19:10, Mark Rutland <mark.rutland@arm.com> wrot=
e:
>>>>
>>>> On Mon, Nov 18, 2019 at 07:42:51PM +0200, Cristian Ciocaltea wrote:
>>>>> I'm trying to boot the Linux kernel on RaspberryPi Zero via GRUB2,
>>>>> which in turn is executed by U-Boot as an UEFI binary.
>>>>>
>>>>> However, I'm facing data abort issues in efi_get_memory_map()
>>>>> that seem to be related to some ldrd instructions generated by the
>>>>> compiler.
>>>>>
>>>>> To simplify the investigation, I temporarily gave up on GRUB2 and
>>>>> started directly the Linux kernel via U-Boot bootefi command.
>>>>> The result is an immediate crash at PC 0x92c8:

Hello Christian,

could you, please, check if this patch applied to U-Boot v2019.10
resolves your problem:

https://github.com/xypron/u-boot-patches/blob/efi-next/0001-arm-arm11-allo=
w-unaligned-memory-access.patch

Currently I do not have an ARMv6 board available for testing. (But I
just ordered one.)

Best regards

Heinrich Schuchardt

>>>>>
>>>>> data abort
>>>>> pc : [<1c6b12c8>]          lr : [<1c6b1558>]
>>>>> reloc pc : [<fe76a2c8>]    lr : [<fe76a558>]
>>>>> sp : 1db43b30  ip : 00000000     fp : 1db43cc0
>>>>> r10: 20494249  r9 : ffffffff     r8 : 00000000
>>>>> r7 : 1db43b3c  r6 : 00000000     r5 : 1db43bfa  r4 : 1db43bb0
>>>>> r3 : 1db43b9c  r2 : 00000028     r1 : 00000000  r0 : 1df4f828
>>>>> Flags: nZCv  IRQs off  FIQs off  Mode SVC_32
>>>>> Code: e3a02028 e3a01000 e527100c e5832000 (e1c420d4)
>>>>> UEFI image [0x1c6a8000:0x1cb2ffff] pc=3D0x92c8 '/boot\zImage'
>>>>> Resetting CPU ...
>>>>>
>>>>> The related disassembled section shows the *ldrd* instruction
>>>>> in the context of the following statement:
>>>>> *map->map_size =3D      *map->desc_size * 32;
>>>>>
>>>>> drivers/firmware/efi/libstub/efi-stub-helper.c:90
>>>>>        *map->desc_size =3D       sizeof(*m);
>>>>>      92ac:     e5913008        ldr     r3, [r1, #8]
>>>>> drivers/firmware/efi/libstub/efi-stub-helper.c:84
>>>>> {
>>>>>      92b0:     e1a04001        mov     r4, r1
>>>>> drivers/firmware/efi/libstub/efi-stub-helper.c:85
>>>>>        efi_memory_desc_t *m =3D NULL;
>>>>>      92b4:     e28d7018        add     r7, sp, #24
>>>>> linux/drivers/firmware/efi/libstub/efi-stub-helper.c:90
>>>>>        *map->desc_size =3D       sizeof(*m);
>>>>>      92b8:     e3a02028        mov     r2, #40 ; 0x28
>>>>>      92c4:     e5832000        str     r2, [r3]
>>>>> linux/drivers/firmware/efi/libstub/efi-stub-helper.c:91
>>>>>        *map->map_size =3D        *map->desc_size * 32;
>>>>>      92c8:     e1c420d4        ldrd    r2, [r4, #4]
>>>>
>>>> At this point, r4 is 16-byte aligned, so that's a misaligned LDRD.
>>>>
>>>> Looking at version 2.8of the UEFI spec, in section 2.3.5 "AArch32
>>>> Platforms", it states that SCTLR should be configured:
>>>>
>>>> | A=3D0, U=3D1 on ARMv6 and ARMv7
>>>>
>>>> ... which IIUC should permit a misaligned LDRD. Is U-Boot definitely
>>>> configuring SCTLR that way? Or has it perhaps set A=3D1, U=3D0?
>>>
>>> LDRD requires word alignment only, no?
>>
>> Looking at the ARMv6 ARM ARM, I see mention of modulo-8 alignemnt
>> checking (specifically for LDRD/STRD) when A=3D1, U=3D0. Unless I've
>> misunder
>>
>> See A2.7.3 "Endian configuration and control" in ARM DDI 0100I. Table
>> A2-6 and A2-8 both suggest that, with A2-8 saying that a Data Abort
>> would result.
>>
>
> You are right.
>
> I have added Heinrich to cc [again] - perhaps he knows whether u-boot
> always adheres to this UEFI requirement?
>

