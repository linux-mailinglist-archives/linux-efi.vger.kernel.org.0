Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4E01A8523
	for <lists+linux-efi@lfdr.de>; Tue, 14 Apr 2020 18:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391799AbgDNQf7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Apr 2020 12:35:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:47318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391800AbgDNQfz (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 14 Apr 2020 12:35:55 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED80E2075E;
        Tue, 14 Apr 2020 16:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586882155;
        bh=2fMLCgNMiZFmx0Qt1Q1vqSQe2+/NjRgn2Y1LBwTa5SU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Gd+0HVdq52wpdUq6+a9/eByVgBfUR7p7zTcZjbc+yPyV0pJoJp1EV7kFvUdCa1Rfn
         6e6XpTWhWYbAQf8Pu6dhlPXnNk84cxwlgb2kvHYlsqTuoE4Xxh+PdTbGnBcnDhIgu6
         KYwdiwwI8Kj5HztyuuSw7gAUUVrz2xWQeI/p5t7c=
Received: by mail-io1-f41.google.com with SMTP id f19so13884292iog.5;
        Tue, 14 Apr 2020 09:35:54 -0700 (PDT)
X-Gm-Message-State: AGi0PuYVm1w10wEKYMqzvXSNM7tXzR+stnIA+5vZMi4c/ohDVVijFtxQ
        hMdzjkVAqDxiibbGty+vhHfzj2K0f4ZyDEnEV+g=
X-Google-Smtp-Source: APiQypKEUymaYVGzyU19WNpTfuxoJxKR5JcXxbfn4/yW0MOIADW8ku2Y9fFXDHocj0oRicKhmLLiQugDVgqQVYF0p3Q=
X-Received: by 2002:a02:7785:: with SMTP id g127mr21321483jac.134.1586882154307;
 Tue, 14 Apr 2020 09:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <CADDKRnBdM_T1W=iECrt89hmAmbRRyskGhS4d3ozTz1nWj_i_qQ@mail.gmail.com>
 <CAMj1kXGuMjHi=E6cVGGpwrKF_-KXcj0VRcvAdFS_vmwV7PudCQ@mail.gmail.com> <CADDKRnAvC7U6kWdiqmib40cJ7r41COyic4LTdO9utsp4GOJnvA@mail.gmail.com>
In-Reply-To: <CADDKRnAvC7U6kWdiqmib40cJ7r41COyic4LTdO9utsp4GOJnvA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 14 Apr 2020 18:35:43 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEDJ67oJJjKtDC--VXmr+z8-voPhHnRnaMCEfo5Pc6Sqg@mail.gmail.com>
Message-ID: <CAMj1kXEDJ67oJJjKtDC--VXmr+z8-voPhHnRnaMCEfo5Pc6Sqg@mail.gmail.com>
Subject: Re: Kernel V5.7-rc1 doesn't boot (EFI?)
To:     =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 14 Apr 2020 at 18:32, J=C3=B6rg Otte <jrg.otte@gmail.com> wrote:
>
> Am Di., 14. Apr. 2020 um 12:50 Uhr schrieb Ard Biesheuvel <ardb@kernel.or=
g>:
> >
> > On Tue, 14 Apr 2020 at 12:40, J=C3=B6rg Otte <jrg.otte@gmail.com> wrote=
:
> > >
> > > Booting my notebook with kernel V57-rc1 I get following
> > > display:
> > >
> > > exit_boot() failed!
> > > efi_main() failed!
> > > StartImage failed: Buffer Too Small
> > >
> > > Booting Kernel V5.6 works well.
> > >
> > > From dmesg (kernel V5.6):
> > > efi: EFI v2.31 by Phoenix Technologies Ltd.
> > > efi:  ACPI=3D0xdcffe000  ACPI 2.0=3D0xdcffe014  SMBIOS=3D0xdce80000  =
RNG=3D0xdc3cd198
> > > efi: seeding entropy pool
> > > efi: [Firmware Bug]: Invalid EFI memory map entries:
> > > efi: mem47: [Reserved           |   |  |  |  |  |  |  |  |   |  |  |
> > > |  ] range=3D[0x0000000000000000-0x0000000000000000] (invalid)
> > > efi: mem48: [Reserved           |   |  |  |  |  |  |  |  |   |  |  |
> > > |  ] range=3D[0x0000000000000000-0x0000000000000000] (invalid)
> > > efi: mem49: [Reserved           |   |  |  |  |  |  |  |  |   |  |  |
> > > |  ] range=3D[0x0000000000000000-0x0000000000000000] (invalid)
> > > efi: mem50: [Reserved           |   |  |  |  |  |  |  |  |   |  |  |
> > > |  ] range=3D[0x0000000000000000-0x0000000000000000] (invalid)
> > > efi: mem51: [Reserved           |   |  |  |  |  |  |  |  |   |  |  |
> > > |  ] range=3D[0x0000000000000000-0x0000000000000000] (invalid)
> > > efi: Removing 5 invalid memory map entries.
> > >
> >
> > Thanks for the report.
> >
> > Can you try booting with efi=3Dno_disable_early_pci_dma passed via the
> > kernel command line? [*]
> >
> Yes, that works!
>
> > If that does not help, can you try to reproduce with this branch?
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=3Def=
i/urgent
>
> Should I give that branch a try anyway?
>

Your test proves that BSS is not being cleared correctly, so I have
the answer I was looking for. However, I would appreciate it if you
could test that branch, just to double check.

Thanks,
Ard.
