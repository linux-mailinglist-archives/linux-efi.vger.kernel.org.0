Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1021248C0B3
	for <lists+linux-efi@lfdr.de>; Wed, 12 Jan 2022 10:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351931AbiALJGU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 Jan 2022 04:06:20 -0500
Received: from mail-0301.mail-europe.com ([188.165.51.139]:57959 "EHLO
        mail-0301.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351929AbiALJGQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 12 Jan 2022 04:06:16 -0500
Date:   Wed, 12 Jan 2022 09:06:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1641978367;
        bh=3OW8/QTh8VzBFezKsbQAmUoKdvtKDvroS3M/a7vQQUI=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=oZyw+1iWaQJjOg18hIjSfGiZBj2ds2kcvB9GC5B3Q1uck7jKVFY8iBJs2T7Lw3/k5
         5AtzZKrDXi9zDgC/JlbcWvkeqWH6GtEQeqYpRXuRbWaU4ngKXfUvhP/sxk5EXwkpTy
         T54MaxNggtMcAZ0mJI1CRCGwEoN/6enq4tESRQDNFaYG/Udcj/W9UeYxmKikoPpcCG
         VBvrB/eT+6Ww3xEFZgVTn7qZ2LTgQqvGDeofMltWJGPufvlBzKp50wSYk0v3LFvFIi
         l1wFPXNm+O/dB7/h607IGAQcXaf7DMtZG8bxcBan591DtlsjPc/o/0Q28SNnr9Armw
         sD/ygSM1vZL4g==
To:     Ard Biesheuvel <ardb@kernel.org>
From:   Orlando Chamberlain <redecorating@protonmail.com>
Cc:     Aditya Garg <gargaditya08@live.com>,
        "jk@ozlabs.org" <jk@ozlabs.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aun-Ali Zaidi <admin@kodeit.net>
Reply-To: Orlando Chamberlain <redecorating@protonmail.com>
Subject: Re: [BUG][SEVERE] Enabling EFI runtime services causes panics in the T2 security chip on Macs equipped with it.
Message-ID: <20220112090554.1b279c4e@localhost>
In-Reply-To: <CAMj1kXExPTyxSaioSmwhz+bTYwLjQJQ5PHRJKY11cX9M71STSQ@mail.gmail.com>
References: <6D757C75-65B1-468B-842D-10410081A8E4@live.com> <CAMj1kXETPO9iJoFm26v5gof2xpakHkvz3YV4ahet7BLjX5m5FQ@mail.gmail.com> <D3B9962F-F6F0-4622-9E0F-A3EABACAD471@live.com> <CAMj1kXGem3QB0rj-b57xrcDYkCv6Moi=RX1OUspj3s4vMtsdug@mail.gmail.com> <CAMj1kXEjmJxS-_r4HK_v_Qm85y2oeawk+bWUpSY7mV5NLFCm4g@mail.gmail.com> <787447CE-C7DC-4EA3-B498-6FEA88C523A1@live.com> <CAMj1kXExPTyxSaioSmwhz+bTYwLjQJQ5PHRJKY11cX9M71STSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 12 Jan 2022 19:21:55 +1100
"Ard Biesheuvel" <ardb@kernel.org> wrote:
> What we might do is just use EFI 1.10 for all Apple x86 EFI machines.

I have found logs of pre-T2 x86 Macs that have EFI v2.40 but I haven't
heard of them having the issue with writing to nvram:

[    0.000000] efi: EFI v2.40 by Apple
[    0.000000] efi:  ACPI=3D0x88ffe000  ACPI 2.0=3D0x88ffe014  SMBIOS=3D0x8=
8f00000  SMBIOS 3.0=3D0x88efe000=20
[    0.000000] secureboot: Secure boot disabled
[    0.000000] SMBIOS 3.0.0 present.
[    0.000000] DMI: Apple Inc. MacBookPro14,1/Mac-B4831CEBD52A0C4C, BIOS XX=
X.XXX.XXX.XXX.0 04/24/2020

MacBookPro14,1 [1], and MacBookPro13,1 [2] have EFI v2.40, but
MacBookPro12,1 [3] has v1.10

[1] https://linux-hardware.org/?probe=3Db1b965bcfa&log=3Ddmesg
[2] https://linux-hardware.org/?probe=3Ddf102d9c8c&log=3Ddmesg
[3] https://linux-hardware.org/?probe=3Def5195a62e&log=3Ddmesg

I don't know if this would mean the other Macs with EFI v2.40 would lose
any functionality due to a patch like this (I'm not familiar with what
was added to the runtime services between v1.10 and v2.40).

> Please try the below:
>
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index ae79c3300129..2303f9b06412 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -722,6 +722,13 @@ void __init efi_systab_report_header(const
> efi_table_hdr_t *systab_hdr,
>                 systab_hdr->revision >> 16,
>                 systab_hdr->revision & 0xffff,
>                 vendor);
> +
> +       if (IS_ENABLED(CONFIG_X86_64) &&
> +           systab_hdr->revision > EFI_1_10_SYSTEM_TABLE_REVISION &&
> +           !strcmp(vendor, "Apple")) {
> +               pr_info("Apple EFI Mac detected, using EFI v1.10
> runtime services only\n");
> +               efi.runtime_version =3D EFI_1_10_SYSTEM_TABLE_REVISION;
> +       }
>  }
>=20
>  static __initdata char memory_type_name[][13] =3D {

This patch makes writing to nvram work for me on MacBookPro16,1

--=20

