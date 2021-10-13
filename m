Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 829DA42BC2F
	for <lists+linux-efi@lfdr.de>; Wed, 13 Oct 2021 11:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238388AbhJMJzy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 13 Oct 2021 05:55:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52740 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237621AbhJMJzx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 13 Oct 2021 05:55:53 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F0B90201CA;
        Wed, 13 Oct 2021 09:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634118829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=268Zgl/ULNiaJbHZilRHMoZ0VVi6LmiMjE5l5nxBWeI=;
        b=YL2gLfrazkxrD/KsQzWWl+foWU7I2DQadMHj3xr0/2WfoGToOPRLfxgJp09YeBFibEeuu7
        kXuQ9dw+gyX9bGa9cgWPrzeWHVDDXCYj1kOG0wGJ70xVE1RjUZlxo+m9V0E9Q/FPXBb309
        6ewAz+uOmw3XGpbmrwOynQ6DpKW4ZtM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634118829;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=268Zgl/ULNiaJbHZilRHMoZ0VVi6LmiMjE5l5nxBWeI=;
        b=igWpNP6dXcilIn3SP8jiqaQ9EhfHrRkG3Yi8LStT3bWfe5Am+UQ9LJGa1D16v8kiZYTfxk
        FrqexyPB/aVR4hCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B9C7E13CEC;
        Wed, 13 Oct 2021 09:53:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FTFtK62sZmHbOgAAMHmgww
        (envelope-from <iivanov@suse.de>); Wed, 13 Oct 2021 09:53:49 +0000
From:   "Ivan T. Ivanov" <iivanov@suse.de>
Message-Id: <7BB7EE30-257A-4B27-B420-B0C72292444A@suse.de>
Content-Type: multipart/mixed;
        boundary="Apple-Mail=_0733DEBC-C88A-4E79-8746-17CE6F9C3D12"
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [RESEND] [PATCH] Revert "efi/random: Treat EFI_RNG_PROTOCOL
 output as bootloader randomness"
Date:   Wed, 13 Oct 2021 12:53:48 +0300
In-Reply-To: <2E0472BF-BC05-4722-83EC-26919278CC2E@suse.de>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
References: <20211012082708.121931-1-iivanov@suse.de>
 <YWVKAk4h5bsUA3b6@light.dominikbrodowski.net>
 <4eccf707f2553f0f66ae3789b5689231@suse.de>
 <CAMj1kXE7FbEqxyBcPS6mx5wU82+H0WK67HU=S6hq=WAG5EBwyQ@mail.gmail.com>
 <2E0472BF-BC05-4722-83EC-26919278CC2E@suse.de>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--Apple-Mail=_0733DEBC-C88A-4E79-8746-17CE6F9C3D12
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 13 Oct 2021, at 12:51, Ivan T. Ivanov <iivanov@suse.de> wrote:
>=20
> Hi,
>=20
>> On 13 Oct 2021, at 10:50, Ard Biesheuvel <ardb@kernel.org> wrote:
>>=20
>> On Wed, 13 Oct 2021 at 09:30, Ivan T. Ivanov <iivanov@suse.de> wrote:
>>>=20
>>> Hi,
>>>=20
>>> Quoting Dominik Brodowski (2021-10-12 11:40:34)
>>>> Am Tue, Oct 12, 2021 at 11:27:08AM +0300 schrieb Ivan T. Ivanov:
>>>>> This reverts commit 18b915ac6b0ac5ba7ded03156860f60a9f16df2b.
>>>>>=20
>>>>> When CONFIG_RANDOM_TRUST_BOOTLOADER is enabled =
add_bootloader_randomness()
>>>>> calls add_hwgenerator_randomness() which might sleep,
>>>>=20
>>>> Wouldn't it be better to fix add_bootloader_randomness(), =
considering
>>>> that
>>>> calls to that function are likely to happen quite early during =
kernel
>>>> initialization? Especially as it seems to have worked beforehand?
>>>=20
>>> I have tried. I made wait_event_interruptible() optional, but then
>>> crng_reseed() segfault badly. And I don't think crng_reseed() is
>>> something that I could fix easily. Suggestions are welcomed ;-)
>>>=20
>>=20
>> How about
>>=20
>> diff --git a/drivers/char/random.c b/drivers/char/random.c
>> index 605969ed0f96..1828dc691ebf 100644
>> --- a/drivers/char/random.c
>> +++ b/drivers/char/random.c
>> @@ -2297,9 +2297,8 @@ EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
>> */
>> void add_bootloader_randomness(const void *buf, unsigned int size)
>> {
>> +       add_device_randomness(buf, size);
>>       if (IS_ENABLED(CONFIG_RANDOM_TRUST_BOOTLOADER))
>> -               add_hwgenerator_randomness(buf, size, size * 8);
>> -       else
>> -               add_device_randomness(buf, size);
>> +               credit_entropy(&input_pool, size * 8);
>> }
>> EXPORT_SYMBOL_GPL(add_bootloader_randomness);
>=20
> This doesn=E2=80=99t boot. I just changed following and kernel panics. =
=20
>=20
> - credit_entropy
> + credit_entropy_bits
>=20
> Please see attached file.
>=20

Ah, sorry. I missed file attachment. Now it should be fine.


--Apple-Mail=_0733DEBC-C88A-4E79-8746-17CE6F9C3D12
Content-Disposition: attachment;
	filename=panic.log
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="panic.log"
Content-Transfer-Encoding: 7bit

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x481fd010]
[    0.000000] Linux version 5.3.18-0.gd323798-default (geeko@buildhost) (gcc version 7.5.0 (SUSE Linux)) #1 SMP Wed Oct 13 09:23:12 UTC 2021 (d323798)
[    0.000000] earlycon: pl11 at MMIO 0x0000000009000000 (options '')
[    0.000000] printk: bootconsole [pl11] enabled
[    0.000000] efi: EFI v2.70 by EDK II
[    0.000000] efi: SMBIOS 3.0=0xbbed0000 MEMATTR=0xb9cde018 ACPI 2.0=0xb8420018 MOKvar=0xba64c000 RNG=0xbbfdbd98 MEMRESERVE=0xb834d218
[    0.000000] efi: seeding entropy pool
[    0.000000] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000100
[    0.000000] Mem abort info:
[    0.000000]   ESR = 0x96000004
[    0.000000]   Exception class = DABT (current EL), IL = 32 bits
[    0.000000]   SET = 0, FnV = 0
[    0.000000]   EA = 0, S1PTW = 0
[    0.000000] Data abort info:
[    0.000000]   ISV = 0, ISS = 0x00000004
[    0.000000]   CM = 0, WnR = 0
[    0.000000] [0000000000000100] user address but active_mm is swapper
[    0.000000] Internal error: Oops: 96000004 [#1] SMP
[    0.000000] Modules linked in:
[    0.000000] Supported: No, Unreleased kernel
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.3.18-0.gd323798-default #1 SLE15-SP3 (unreleased)
[    0.000000] pstate: 60000085 (nZCv daIf -PAN -UAO)
[    0.000000] pc : __queue_work+0x30/0x568
[    0.000000] lr : __queue_work+0x2c/0x568
[    0.000000] sp : ffffa9f829d43c40
[    0.000000] x29: ffffa9f829d43c40 x28: 0000000000004000
[    0.000000] x27: 0000000000000000 x26: ffffa9f82a86d8a0
[    0.000000] x25: ffffa9f82a86d000 x24: 0000000000000300
[    0.000000] x23: ffffa9f829f4d000 x22: 0000000000000300
[    0.000000] x21: 0000000000000300 x20: ffffa9f829ecbdd0
[    0.000000] x19: ffffa9f829ecbdd0 x18: 00000000fffffff8
[    0.000000] x17: 0000000000000000 x16: 0000000fffffffe1
[    0.000000] x15: 0000000000000007 x14: 0000000000000001
[    0.000000] x13: 0000000000000019 x12: 0000000000000033
[    0.000000] x11: 000000000000004c x10: 0000000000000068
[    0.000000] x9 : ffffa9f8292f3f48 x8 : 000000004e2e5202
[    0.000000] x7 : 0000000000000005 x6 : ffffa9f829d43d68
[    0.000000] x5 : 000000000000007f x4 : 0000000000000001
[    0.000000] x3 : 0000000000000000 x2 : ffffa9f829ecbdd0
[    0.000000] x1 : 0000000000000000 x0 : ffffa9f8286de150
[    0.000000] Call trace:
[    0.000000]  __queue_work+0x30/0x568
[    0.000000]  queue_work_on+0x98/0xa0
[    0.000000]  crng_reseed+0x1a8/0x328
[    0.000000]  credit_entropy_bits+0x34c/0x368
[    0.000000]  add_bootloader_randomness+0x3c/0x48
[    0.000000]  efi_config_parse_tables+0x120/0x250
[    0.000000]  efi_init+0x138/0x1e0
[    0.000000]  setup_arch+0x394/0x778
[    0.000000]  start_kernel+0x90/0x568
[    0.000000] Code: aa0203f4 aa1e03e0 97fe35be 2a1603f8 (b9410360)
[    0.000000] random: get_random_bytes called from print_oops_end_marker+0x54/0x70 with crng_init=0
[    0.000000] ---[ end trace 75d6efa456d89665 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---
--Apple-Mail=_0733DEBC-C88A-4E79-8746-17CE6F9C3D12
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii



Ivan


--Apple-Mail=_0733DEBC-C88A-4E79-8746-17CE6F9C3D12--
