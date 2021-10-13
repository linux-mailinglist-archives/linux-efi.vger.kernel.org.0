Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB7DB42C158
	for <lists+linux-efi@lfdr.de>; Wed, 13 Oct 2021 15:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbhJMNZk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 13 Oct 2021 09:25:40 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57030 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234896AbhJMNZg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 13 Oct 2021 09:25:36 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 46D1722349;
        Wed, 13 Oct 2021 13:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634131412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oZyBkiR23eLUY9zYUwi72aab8a0rEnfHoQwUcj+ieIk=;
        b=iKI1QdfkF3T0K5D83ip+Di/QwhpU6ymij8ETTXvPCzx0eKHcavoyC66/AxldpCb9SURVRy
        ArejHxUL6vhBv2vt3p1owoDVW5aeP2wv5Zm3whF6vf6AQjW78oXLMjTPwCR0EHYW2l5ICp
        SLURzzOYWVD1YMGJccPU0bVt5AX77Oo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634131412;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oZyBkiR23eLUY9zYUwi72aab8a0rEnfHoQwUcj+ieIk=;
        b=kOiZU2CQOpwoI43togyV/D4SL2mqf8TGXeY9MlkDO6wHDEVnuASuZ0cQZ+6oGK8fvgj4XT
        Pw++vD/BJpcrEmAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0B80713CF6;
        Wed, 13 Oct 2021 13:23:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id M/+yANTdZmG7LQAAMHmgww
        (envelope-from <iivanov@suse.de>); Wed, 13 Oct 2021 13:23:32 +0000
From:   "Ivan T. Ivanov" <iivanov@suse.de>
Message-Id: <CB0F618D-2B3C-473A-93BC-A6AD752B9EC6@suse.de>
Content-Type: multipart/mixed;
        boundary="Apple-Mail=_C476DF10-B533-485E-A35A-1DEC4164C313"
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [RESEND] [PATCH] Revert "efi/random: Treat EFI_RNG_PROTOCOL
 output as bootloader randomness"
Date:   Wed, 13 Oct 2021 16:23:31 +0300
In-Reply-To: <7BB7EE30-257A-4B27-B420-B0C72292444A@suse.de>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
References: <20211012082708.121931-1-iivanov@suse.de>
 <YWVKAk4h5bsUA3b6@light.dominikbrodowski.net>
 <4eccf707f2553f0f66ae3789b5689231@suse.de>
 <CAMj1kXE7FbEqxyBcPS6mx5wU82+H0WK67HU=S6hq=WAG5EBwyQ@mail.gmail.com>
 <2E0472BF-BC05-4722-83EC-26919278CC2E@suse.de>
 <7BB7EE30-257A-4B27-B420-B0C72292444A@suse.de>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--Apple-Mail=_C476DF10-B533-485E-A35A-1DEC4164C313
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi,

> On 13 Oct 2021, at 12:53, Ivan T. Ivanov <iivanov@suse.de> wrote:
>=20
>=20
>=20
>> On 13 Oct 2021, at 12:51, Ivan T. Ivanov <iivanov@suse.de> wrote:
>>=20
>> Hi,
>>=20
>>> On 13 Oct 2021, at 10:50, Ard Biesheuvel <ardb@kernel.org> wrote:
>>>=20
>>> On Wed, 13 Oct 2021 at 09:30, Ivan T. Ivanov <iivanov@suse.de> =
wrote:
>>>>=20
>>>> Hi,
>>>>=20
>>>> Quoting Dominik Brodowski (2021-10-12 11:40:34)
>>>>> Am Tue, Oct 12, 2021 at 11:27:08AM +0300 schrieb Ivan T. Ivanov:
>>>>>> This reverts commit 18b915ac6b0ac5ba7ded03156860f60a9f16df2b.
>>>>>>=20
>>>>>> When CONFIG_RANDOM_TRUST_BOOTLOADER is enabled =
add_bootloader_randomness()
>>>>>> calls add_hwgenerator_randomness() which might sleep,
>>>>>=20
>>>>> Wouldn't it be better to fix add_bootloader_randomness(), =
considering
>>>>> that
>>>>> calls to that function are likely to happen quite early during =
kernel
>>>>> initialization? Especially as it seems to have worked beforehand?
>>>>=20
>>>> I have tried. I made wait_event_interruptible() optional, but then
>>>> crng_reseed() segfault badly. And I don't think crng_reseed() is
>>>> something that I could fix easily. Suggestions are welcomed ;-)
>>>>=20
>>>=20
>>> How about
>>>=20
>>> diff --git a/drivers/char/random.c b/drivers/char/random.c
>>> index 605969ed0f96..1828dc691ebf 100644
>>> --- a/drivers/char/random.c
>>> +++ b/drivers/char/random.c
>>> @@ -2297,9 +2297,8 @@ EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
>>> */
>>> void add_bootloader_randomness(const void *buf, unsigned int size)
>>> {
>>> +       add_device_randomness(buf, size);
>>>      if (IS_ENABLED(CONFIG_RANDOM_TRUST_BOOTLOADER))
>>> -               add_hwgenerator_randomness(buf, size, size * 8);
>>> -       else
>>> -               add_device_randomness(buf, size);
>>> +               credit_entropy(&input_pool, size * 8);
>>> }
>>> EXPORT_SYMBOL_GPL(add_bootloader_randomness);
>>=20
>> This doesn=E2=80=99t boot. I just changed following and kernel =
panics. =20
>>=20

And before anyone asked =E2=80=9C.. Hey but this is 5.3.18 kernel =
version=E2=80=9D
here is the kernel panic with 5.14.11 :-)

Regards,
Ivan


--Apple-Mail=_C476DF10-B533-485E-A35A-1DEC4164C313
Content-Disposition: attachment;
	filename=kernel-5.14-panic.log
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="kernel-5.14-panic.log"
Content-Transfer-Encoding: 7bit

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x481fd010]
[    0.000000] Linux version 5.14.11-0.g6451538-default (geeko@buildhost) (gcc (SUSE Linux) 11.2.1 20210816 [revision 056e324ce46a7924b5cf10f61010cf9dd2ca10e9], GNU ld (GNU Binutils; openSUSE Tumbleweed) 2.37.20210803-1) #1 SMP Wed Oct 13 12:57:23 UTC 2021 (6451538)
[    0.000000] earlycon: pl11 at MMIO 0x0000000009000000 (options '')
[    0.000000] printk: bootconsole [pl11] enabled
[    0.000000] efi: EFI v2.70 by EDK II
[    0.000000] efi: SMBIOS 3.0=0xbbed0000 MEMATTR=0xba613018 ACPI 2.0=0xb8420018 RNG=0xbbfdbd98 MEMRESERVE=0xb82b8d98
[    0.000000] efi: seeding entropy pool
[    0.000000] Unable to handle kernel read from unreadable memory at virtual address 0000000000000100
[    0.000000] Mem abort info:
[    0.000000]   ESR = 0x96000004
[    0.000000]   EC = 0x25: DABT (current EL), IL = 32 bits
[    0.000000]   SET = 0, FnV = 0
[    0.000000]   EA = 0, S1PTW = 0
[    0.000000]   FSC = 0x04: level 0 translation fault
[    0.000000] Data abort info:
[    0.000000]   ISV = 0, ISS = 0x00000004
[    0.000000]   CM = 0, WnR = 0
[    0.000000] [0000000000000100] user address but active_mm is swapper
[    0.000000] Internal error: Oops: 96000004 [#1] SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.14.11-0.g6451538-default #1 openSUSE Tumbleweed (unreleased) 60c96ed3deefa67df40302b86abb113f2e90c73b
[    0.000000] pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO BTYPE=--)
[    0.000000] pc : __queue_work+0x34/0x600
[    0.000000] lr : queue_work_on+0x64/0xa0
[    0.000000] sp : ffffce52f6c03b00
[    0.000000] x29: ffffce52f6c03b00 x28: ffffce52f63ddb80 x27: 0000000000007ffe
[    0.000000] x26: 00000000000001e0 x25: ffffce52f70a6000 x24: 00000000000001e0
[    0.000000] x23: ffffce52f70a6f10 x22: 0000000000000000 x21: ffffce52f70a6f30
[    0.000000] x20: ffffce52f6443000 x19: ffffce52f6e9a4a8 x18: 0000000000000007
[    0.000000] x17: 000000000000000e x16: 0000000000000001 x15: 0000000000000019
[    0.000000] x14: 0000000000000001 x13: 000000000000004c x12: 0000000000000068
[    0.000000] x11: ffffce52f6053528 x10: 00000000000000d8 x9 : 000000006f6e4246
[    0.000000] x8 : ffffce52f6c03c4c x7 : 0000000000000007 x6 : 0000000000000000
[    0.000000] x5 : 0000000000000000 x4 : 0000000fffffffe1 x3 : 0000000fffffffe0
[    0.000000] x2 : ffffce52f6e9a4a8 x1 : 0000000000000000 x0 : 00000000000001e0
[    0.000000] Call trace:
[    0.000000]  __queue_work+0x34/0x600
[    0.000000]  queue_work_on+0x64/0xa0
[    0.000000]  crng_reseed+0x668/0x790
[    0.000000]  credit_entropy_bits.constprop.0+0x208/0x21c
[    0.000000]  add_bootloader_randomness+0x2c/0x3c
[    0.000000]  efi_config_parse_tables+0x134/0x250
[    0.000000]  efi_init+0x170/0x21c
[    0.000000]  setup_arch+0x2a4/0x6b0
[    0.000000]  start_kernel+0x90/0x9cc
[    0.000000]  __primary_switched+0xc0/0xc8
[    0.000000] Code: a90363f7 2a0003f8 a9046bf9 2a0003fa (b9410020)
[    0.000000] random: get_random_bytes called from oops_exit+0x44/0x80 with crng_init=0
[    0.000000] ---[ end trace d23bd08a2a1c3f33 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] Rebooting in 90 seconds..
[    0.000000] Reboot failed -- System halted
--Apple-Mail=_C476DF10-B533-485E-A35A-1DEC4164C313--
