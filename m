Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB83348C0C8
	for <lists+linux-efi@lfdr.de>; Wed, 12 Jan 2022 10:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238222AbiALJNT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 Jan 2022 04:13:19 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42484 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238051AbiALJNT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 12 Jan 2022 04:13:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C10A6184D;
        Wed, 12 Jan 2022 09:13:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6425DC36AE9;
        Wed, 12 Jan 2022 09:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641978798;
        bh=fNXSkQ/rUwWBpHEym/uBUc0X7/PYMXkb/1AK0/pYtlk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Tg5RlQ5BMhNHIavtr/ZeGbJgpyvg9ftWICrKqbKPl3VThBv5Z6ok8zQcWZ5sWrqny
         i9y6S9cvs4gUsJ8vx1fI+pcflEQqWnQRobhxj+1Oz24Dtl+9a12A9KM+6Cc8ghEupq
         ia0Z/XYtTafTOeGaeDDdDP12UwC8v1qsFoi0x4eYwMXa9F37KLFNUqKZIAm0PTbxIb
         yCsTiUMXtebnIot+mIZ136IjHY0Zv9e0CoEFqUBuMwwhlIdl/2fPxv6L+aBoTBOfKy
         nuUm87euZoWroI38rHVxRP5qdMzOpGbt5apNowMhrEydmvu86gExPvinllwkfGAH8g
         DxkOMEOe3We2g==
Received: by mail-wr1-f46.google.com with SMTP id s1so2943736wra.6;
        Wed, 12 Jan 2022 01:13:18 -0800 (PST)
X-Gm-Message-State: AOAM533HscsbZgdvaLJoZAuKxs1oPRVaHgRxMlxmcGpIVsmRHX/gElHg
        Olf0aD1UuThREEKtYVwb2bjTB/0pz9fPTAArc0U=
X-Google-Smtp-Source: ABdhPJx6NiZBs5QqAwCsI0ZD70oRYRNhrN+a4PlLd0MOAenLhqUZ8UgHYWBySNlt4UH6dfx1mE6YI5WkDIANCJAAoQ4=
X-Received: by 2002:a05:6000:154c:: with SMTP id 12mr7125742wry.447.1641978796761;
 Wed, 12 Jan 2022 01:13:16 -0800 (PST)
MIME-Version: 1.0
References: <6D757C75-65B1-468B-842D-10410081A8E4@live.com>
 <CAMj1kXETPO9iJoFm26v5gof2xpakHkvz3YV4ahet7BLjX5m5FQ@mail.gmail.com>
 <D3B9962F-F6F0-4622-9E0F-A3EABACAD471@live.com> <CAMj1kXGem3QB0rj-b57xrcDYkCv6Moi=RX1OUspj3s4vMtsdug@mail.gmail.com>
 <CAMj1kXEjmJxS-_r4HK_v_Qm85y2oeawk+bWUpSY7mV5NLFCm4g@mail.gmail.com>
 <787447CE-C7DC-4EA3-B498-6FEA88C523A1@live.com> <CAMj1kXExPTyxSaioSmwhz+bTYwLjQJQ5PHRJKY11cX9M71STSQ@mail.gmail.com>
 <20220112090554.1b279c4e@localhost>
In-Reply-To: <20220112090554.1b279c4e@localhost>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 12 Jan 2022 10:13:05 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEiVmsQxEsKOy1GwtZRQQ04Wei0OvyBofs1UQy5WxW-pg@mail.gmail.com>
Message-ID: <CAMj1kXEiVmsQxEsKOy1GwtZRQQ04Wei0OvyBofs1UQy5WxW-pg@mail.gmail.com>
Subject: Re: [BUG][SEVERE] Enabling EFI runtime services causes panics in the
 T2 security chip on Macs equipped with it.
To:     Orlando Chamberlain <redecorating@protonmail.com>
Cc:     Aditya Garg <gargaditya08@live.com>,
        "jk@ozlabs.org" <jk@ozlabs.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aun-Ali Zaidi <admin@kodeit.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 12 Jan 2022 at 10:06, Orlando Chamberlain
<redecorating@protonmail.com> wrote:
>
> On Wed, 12 Jan 2022 19:21:55 +1100
> "Ard Biesheuvel" <ardb@kernel.org> wrote:
> > What we might do is just use EFI 1.10 for all Apple x86 EFI machines.
>
> I have found logs of pre-T2 x86 Macs that have EFI v2.40 but I haven't
> heard of them having the issue with writing to nvram:
>
> [    0.000000] efi: EFI v2.40 by Apple
> [    0.000000] efi:  ACPI=0x88ffe000  ACPI 2.0=0x88ffe014  SMBIOS=0x88f00000  SMBIOS 3.0=0x88efe000
> [    0.000000] secureboot: Secure boot disabled
> [    0.000000] SMBIOS 3.0.0 present.
> [    0.000000] DMI: Apple Inc. MacBookPro14,1/Mac-B4831CEBD52A0C4C, BIOS XXX.XXX.XXX.XXX.0 04/24/2020
>
> MacBookPro14,1 [1], and MacBookPro13,1 [2] have EFI v2.40, but
> MacBookPro12,1 [3] has v1.10
>
> [1] https://linux-hardware.org/?probe=b1b965bcfa&log=dmesg
> [2] https://linux-hardware.org/?probe=df102d9c8c&log=dmesg
> [3] https://linux-hardware.org/?probe=ef5195a62e&log=dmesg
>

Thanks for providing this context, this is really helpful.

> I don't know if this would mean the other Macs with EFI v2.40 would lose
> any functionality due to a patch like this (I'm not familiar with what
> was added to the runtime services between v1.10 and v2.40).
>

The only differences are capsule update (which we don't use at runtime
anyway, and isn't implemented on Macs as far as I know), and this
QueryVariableInfo() runtime service that is causing the issue. The
efivars code only uses that when it is available, to avoid breaking
systems with buggy firmware when setting variables while the NVRAM is
out of space.

So in summary, this shouldn't matter for Apple machines.

> > Please try the below:
> >
> > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > index ae79c3300129..2303f9b06412 100644
> > --- a/drivers/firmware/efi/efi.c
> > +++ b/drivers/firmware/efi/efi.c
> > @@ -722,6 +722,13 @@ void __init efi_systab_report_header(const
> > efi_table_hdr_t *systab_hdr,
> >                 systab_hdr->revision >> 16,
> >                 systab_hdr->revision & 0xffff,
> >                 vendor);
> > +
> > +       if (IS_ENABLED(CONFIG_X86_64) &&
> > +           systab_hdr->revision > EFI_1_10_SYSTEM_TABLE_REVISION &&
> > +           !strcmp(vendor, "Apple")) {
> > +               pr_info("Apple EFI Mac detected, using EFI v1.10
> > runtime services only\n");
> > +               efi.runtime_version = EFI_1_10_SYSTEM_TABLE_REVISION;
> > +       }
> >  }
> >
> >  static __initdata char memory_type_name[][13] = {
>
> This patch makes writing to nvram work for me on MacBookPro16,1
>

Thanks. I will take that as a tested-by
