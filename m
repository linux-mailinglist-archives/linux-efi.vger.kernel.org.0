Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15CF348A719
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jan 2022 06:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbiAKFRa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 11 Jan 2022 00:17:30 -0500
Received: from mail-4325.protonmail.ch ([185.70.43.25]:26113 "EHLO
        mail-4325.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236404AbiAKFRa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 11 Jan 2022 00:17:30 -0500
Date:   Tue, 11 Jan 2022 05:17:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1641878248;
        bh=cYRvPsRTbr0F5Cm8cyAJ/mKD2RTDDw1A0v/DzkSatCQ=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=hfA0/CRWFAyhXB6BLEJDd9HBXjUactsFBPdCpKVcrjAIcVgNcJdyx23xz9Qnfgt32
         xCpqb0/AG5DkIoQtsv5BKLz1FlHTRkEYAtH0Hv3eMq4VU/4bLd+g2nnEu0I1RVE4vV
         eO9OhuE1P3k2YfmFADDyrSKNeJK++Udxr+rOXa8DVpQEgyeSRaqRBumIA5IP0yBxZP
         iHvL1DmNDI5cnVCptXkqDgOqRDJLjOhpSGx5NoXXuhH+PsMGW6dZaciDjWLgw7Gp9E
         fGFloNx5Ajo3dciUiAkv5oMv/n84HymBdIl6g41/EGrlgPREUuKARGxloPqzK2Z9Sc
         rbxR5qC1VlJ2w==
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
Message-ID: <20220111051717.25b86946@localhost>
In-Reply-To: <CAMj1kXEjmJxS-_r4HK_v_Qm85y2oeawk+bWUpSY7mV5NLFCm4g@mail.gmail.com>
References: <6D757C75-65B1-468B-842D-10410081A8E4@live.com> <CAMj1kXETPO9iJoFm26v5gof2xpakHkvz3YV4ahet7BLjX5m5FQ@mail.gmail.com> <D3B9962F-F6F0-4622-9E0F-A3EABACAD471@live.com> <CAMj1kXGem3QB0rj-b57xrcDYkCv6Moi=RX1OUspj3s4vMtsdug@mail.gmail.com> <CAMj1kXEjmJxS-_r4HK_v_Qm85y2oeawk+bWUpSY7mV5NLFCm4g@mail.gmail.com>
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

On Tue, 11 Jan 2022 04:45:35 +1100
"Ard Biesheuvel" <ardb@kernel.org> wrote:

> On Mon, 10 Jan 2022 at 17:37, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Mon, 10 Jan 2022 at 17:28, Aditya Garg <gargaditya08@live.com>
> > wrote: =20
> ...
> > > >>
> > > >> This seems to be triggered by EFI_QUERY_VARIABLE_INFO here
> > > >> =20
> > > >
> > > > This is interesting. QueryVariableInfo() was introduced in EFI
> > > > 2.00, and for a very long time, Intel MACs would claim to
> > > > implement EFI 1.10 only. This means Linux would never attempt
> > > > to use QueryVariableInfo() on such platforms.
> > > >
> > > > Can you please check your boot log which revision it claims to
> > > > implement now?
> > > >
> > > > Mine says
> > > >
> > > > efi: EFI v1.10 by Apple =20
> > >
> > > Mine says
> > >
> > > efi: EFI v2.40 by Apple
> > > =20
>=20
> Can you check whether things work as before after applying the change
> below?
>=20
> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> index 147c30a81f15..d7203355cc69 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -399,7 +399,7 @@ static int __init efi_systab_init(unsigned long
> phys) efi_nr_tables           =3D systab32->nr_tables;
>         }
>=20
> -       efi.runtime_version =3D hdr->revision;
> +       efi.runtime_version =3D EFI_1_10_SYSTEM_TABLE_REVISION;
>=20
>         efi_systab_report_header(hdr, efi_fw_vendor);
>         early_memunmap(p, size);

This patch works for me, I was able to use `efibootmgr -t 2` without
panics and the change to the boot timeout value persisted after a
reboot. (I don't think the Apple firmware would actually use this
timeout value for a timeout time, but it is an nvram vairable that i
was able to write to)

efi: EFI v2.40 by Apple
efi: ACPI=3D0x7affe000 ACPI 2.0=3D0x7affe014 SMBIOS=3D0x7aed0000 SMBIOS 3.0=
=3D0x7aece000=20
SMBIOS 3.1.1 present.
DMI: Apple Inc. MacBookPro16,1/Mac-E1008331FDC96864, BIOS 1715.60.5.0.0 (iB=
ridge: 19.16.10647.0.0,0) 11/16/2021

("iBridge" might be something to use for a quirk, as it should cover
all Macs with the T2 chip)


--=20

