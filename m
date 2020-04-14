Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903481A78C9
	for <lists+linux-efi@lfdr.de>; Tue, 14 Apr 2020 12:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438659AbgDNKuv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Apr 2020 06:50:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438461AbgDNKuo (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 14 Apr 2020 06:50:44 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D47E82072D;
        Tue, 14 Apr 2020 10:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586861443;
        bh=SCFQKQ2+KsksDjkQyaJ/w3FWPdJNs5RfQ6S7AJ/IuMY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IpvFf+PYRVvh4fog6K2iyj/wbIr7XU9OzG59u0U5WqOMpZXyYcKkFcAywRg2QrRnK
         mjDk/0JKqVX9q2jqPadcyRNRNkEf9MNHEFLigazWFkaQ2FvzQXpPewsUQ/aUxLzO37
         cidjqaJltptlwvhK9/+KrjBgCj9/hmlSXnJfKwbM=
Received: by mail-io1-f43.google.com with SMTP id n20so12725374ioa.4;
        Tue, 14 Apr 2020 03:50:43 -0700 (PDT)
X-Gm-Message-State: AGi0PuZ6gUyOcptoWaC6qzhQM/PMgXzdl9vCCSlrn+cgWcEbTVX3Yx31
        x7NCOzQetr4Tz/P0NfmLF4T5meShr7dgmStU5jg=
X-Google-Smtp-Source: APiQypLhb1gYaKvjdh3ZIDRwk5cyiCa1D0APheS5Szzao43o/DHZhcTwADjQkwfbPlHYl1Jnlsl/9+9Baa8+9EfcISw=
X-Received: by 2002:a5d:8b57:: with SMTP id c23mr20635087iot.161.1586861443310;
 Tue, 14 Apr 2020 03:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <CADDKRnBdM_T1W=iECrt89hmAmbRRyskGhS4d3ozTz1nWj_i_qQ@mail.gmail.com>
In-Reply-To: <CADDKRnBdM_T1W=iECrt89hmAmbRRyskGhS4d3ozTz1nWj_i_qQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 14 Apr 2020 12:50:32 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGuMjHi=E6cVGGpwrKF_-KXcj0VRcvAdFS_vmwV7PudCQ@mail.gmail.com>
Message-ID: <CAMj1kXGuMjHi=E6cVGGpwrKF_-KXcj0VRcvAdFS_vmwV7PudCQ@mail.gmail.com>
Subject: Re: Kernel V5.7-rc1 doesn't boot (EFI?)
To:     =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 14 Apr 2020 at 12:40, J=C3=B6rg Otte <jrg.otte@gmail.com> wrote:
>
> Booting my notebook with kernel V57-rc1 I get following
> display:
>
> exit_boot() failed!
> efi_main() failed!
> StartImage failed: Buffer Too Small
>
> Booting Kernel V5.6 works well.
>
> From dmesg (kernel V5.6):
> efi: EFI v2.31 by Phoenix Technologies Ltd.
> efi:  ACPI=3D0xdcffe000  ACPI 2.0=3D0xdcffe014  SMBIOS=3D0xdce80000  RNG=
=3D0xdc3cd198
> efi: seeding entropy pool
> efi: [Firmware Bug]: Invalid EFI memory map entries:
> efi: mem47: [Reserved           |   |  |  |  |  |  |  |  |   |  |  |
> |  ] range=3D[0x0000000000000000-0x0000000000000000] (invalid)
> efi: mem48: [Reserved           |   |  |  |  |  |  |  |  |   |  |  |
> |  ] range=3D[0x0000000000000000-0x0000000000000000] (invalid)
> efi: mem49: [Reserved           |   |  |  |  |  |  |  |  |   |  |  |
> |  ] range=3D[0x0000000000000000-0x0000000000000000] (invalid)
> efi: mem50: [Reserved           |   |  |  |  |  |  |  |  |   |  |  |
> |  ] range=3D[0x0000000000000000-0x0000000000000000] (invalid)
> efi: mem51: [Reserved           |   |  |  |  |  |  |  |  |   |  |  |
> |  ] range=3D[0x0000000000000000-0x0000000000000000] (invalid)
> efi: Removing 5 invalid memory map entries.
>

Thanks for the report.

Can you try booting with efi=3Dno_disable_early_pci_dma passed via the
kernel command line? [*]

If that does not help, can you try to reproduce with this branch?

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=3Defi/ur=
gent

If it still does not work, please share your exact kernel config, and
the version of your distro, GRUB, shim, systemd-boot, etc

[*] GRUB on x86 turns out not to zero initialize BSS when it invokes
the EFI stub as a PE/COFF executable, resulting in the 'disable early
PCI DMA' feature to get enabled spuriously, which breaks the boot on
buggy firmware. systemd-boot is even worse, as it ignores the PE/COFF
metadata entirely in some cases, and just assumes it can invoke the
PE/COFF entrypoint after copying the kernel image into memory.
