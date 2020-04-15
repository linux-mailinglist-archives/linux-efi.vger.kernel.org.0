Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771E21A99BF
	for <lists+linux-efi@lfdr.de>; Wed, 15 Apr 2020 11:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408495AbgDOJ67 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Apr 2020 05:58:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405824AbgDOJ65 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 15 Apr 2020 05:58:57 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7D6120775;
        Wed, 15 Apr 2020 09:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586944737;
        bh=Lr/I7Gh1dL+CTUVk0eKSJ4t1qqpK0Gyhn+u3fnbV7Ik=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Lv/JNaSd5VO5HG5XJDnc84SAIxxkr8Wtttlr+F42/7lTHb+8CIYFh4OlDSpDSfVvI
         y9H3lTneuO0Qw4pW6yrf2xWyOHY1wEZir1cqfcNjjbwWBPaG66w4Due4zzgjqtyVWV
         GvXCHQG8WrNav+C13dkec0vAqxyHY8LJ6ZN1zP/I=
Received: by mail-io1-f49.google.com with SMTP id h6so16417749iok.11;
        Wed, 15 Apr 2020 02:58:56 -0700 (PDT)
X-Gm-Message-State: AGi0PuaIujf0vcujGWojlOF080EIjqBCe7Mn/BvCYbdoZXAM8EXDIvEO
        3dA0vv6fiVJVC5Z5dB7ojgebrxn+1ffX8z+E5Ps=
X-Google-Smtp-Source: APiQypL1wZ7TQifTwSwS0MmPR0pnyRKxEtlIe582FtHvbSPq6+H/wcseQO6cwICMwR49iv2elopSASCXMQC9d8j0ns0=
X-Received: by 2002:a05:6602:1550:: with SMTP id h16mr25614401iow.171.1586944736300;
 Wed, 15 Apr 2020 02:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <CADDKRnBdM_T1W=iECrt89hmAmbRRyskGhS4d3ozTz1nWj_i_qQ@mail.gmail.com>
 <CAMj1kXGuMjHi=E6cVGGpwrKF_-KXcj0VRcvAdFS_vmwV7PudCQ@mail.gmail.com>
 <CADDKRnAvC7U6kWdiqmib40cJ7r41COyic4LTdO9utsp4GOJnvA@mail.gmail.com>
 <CAMj1kXEDJ67oJJjKtDC--VXmr+z8-voPhHnRnaMCEfo5Pc6Sqg@mail.gmail.com> <CADDKRnBzMPw8cj5CQv93rxydx8LcNVyfs4mfrLvqxBEtH_r3zQ@mail.gmail.com>
In-Reply-To: <CADDKRnBzMPw8cj5CQv93rxydx8LcNVyfs4mfrLvqxBEtH_r3zQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 15 Apr 2020 11:58:45 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEh9z6QJDyKicCE6enPrQt8emxXee1NjQQknfV0_KL0kQ@mail.gmail.com>
Message-ID: <CAMj1kXEh9z6QJDyKicCE6enPrQt8emxXee1NjQQknfV0_KL0kQ@mail.gmail.com>
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

On Wed, 15 Apr 2020 at 10:35, J=C3=B6rg Otte <jrg.otte@gmail.com> wrote:
>
> Am Di., 14. Apr. 2020 um 18:35 Uhr schrieb Ard Biesheuvel <ardb@kernel.or=
g>:
> >
> > On Tue, 14 Apr 2020 at 18:32, J=C3=B6rg Otte <jrg.otte@gmail.com> wrote=
:
> > >
> > > Am Di., 14. Apr. 2020 um 12:50 Uhr schrieb Ard Biesheuvel <ardb@kerne=
l.org>:
> > > >
> > > > On Tue, 14 Apr 2020 at 12:40, J=C3=B6rg Otte <jrg.otte@gmail.com> w=
rote:
> > > > >
> > > > > Booting my notebook with kernel V57-rc1 I get following
> > > > > display:
> > > > >
> > > > > exit_boot() failed!
> > > > > efi_main() failed!
> > > > > StartImage failed: Buffer Too Small
> > > > >
> > > > > Booting Kernel V5.6 works well.
> > > > >
> > > > > From dmesg (kernel V5.6):
> > > > > efi: EFI v2.31 by Phoenix Technologies Ltd.
> > > > > efi:  ACPI=3D0xdcffe000  ACPI 2.0=3D0xdcffe014  SMBIOS=3D0xdce800=
00  RNG=3D0xdc3cd198
> > > > > efi: seeding entropy pool
> > > > > efi: [Firmware Bug]: Invalid EFI memory map entries:
> > > > > efi: mem47: [Reserved           |   |  |  |  |  |  |  |  |   |  |=
  |
> > > > > |  ] range=3D[0x0000000000000000-0x0000000000000000] (invalid)
> > > > > efi: mem48: [Reserved           |   |  |  |  |  |  |  |  |   |  |=
  |
> > > > > |  ] range=3D[0x0000000000000000-0x0000000000000000] (invalid)
> > > > > efi: mem49: [Reserved           |   |  |  |  |  |  |  |  |   |  |=
  |
> > > > > |  ] range=3D[0x0000000000000000-0x0000000000000000] (invalid)
> > > > > efi: mem50: [Reserved           |   |  |  |  |  |  |  |  |   |  |=
  |
> > > > > |  ] range=3D[0x0000000000000000-0x0000000000000000] (invalid)
> > > > > efi: mem51: [Reserved           |   |  |  |  |  |  |  |  |   |  |=
  |
> > > > > |  ] range=3D[0x0000000000000000-0x0000000000000000] (invalid)
> > > > > efi: Removing 5 invalid memory map entries.
> > > > >
> > > >
> > > > Thanks for the report.
> > > >
> > > > Can you try booting with efi=3Dno_disable_early_pci_dma passed via =
the
> > > > kernel command line? [*]
> > > >
> > > Yes, that works!
> > >
> > > > If that does not help, can you try to reproduce with this branch?
> > > >
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=
=3Defi/urgent
> > >
> > > Should I give that branch a try anyway?
> > >
> >
> > Your test proves that BSS is not being cleared correctly, so I have
> > the answer I was looking for. However, I would appreciate it if you
> > could test that branch, just to double check.
> >
> > Thanks,
> > Ard.
>
> The branch works for me too!
>

Thanks for testing!
