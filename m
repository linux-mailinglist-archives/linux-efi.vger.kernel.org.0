Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15581DE79E
	for <lists+linux-efi@lfdr.de>; Fri, 22 May 2020 15:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbgEVNGf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 22 May 2020 09:06:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:46060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728898AbgEVNGe (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 22 May 2020 09:06:34 -0400
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46EFA20825;
        Fri, 22 May 2020 13:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590152793;
        bh=vjTmQw0BEnjuvo3CGKwGmgIAJmzCaayCTiJ5wxYbMsg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KyI0WSj4naqZfhMsfQ/SRzzEsQPFbfdOphOSoui+TLRiUJ+np9K3bJnN5DdMzWoEM
         CnOGrIhyLn4x7NAgqdr7SBZGcligzmcnSwKgOkoxEsVY42aSvu/YUO9rp71MNayN6J
         k+sycbum8ovl7BsceuWSe3PkYKXbLUtbbdVlFOfY=
Received: by mail-il1-f174.google.com with SMTP id b15so10555141ilq.12;
        Fri, 22 May 2020 06:06:33 -0700 (PDT)
X-Gm-Message-State: AOAM530ZggOmiajxMrJ0uZT2OSGC9mO8BqQdE7V+AJtTjzjD1ZSTQfMl
        Vn4XNOZh89WcYt/wuBtqDdmEtyQhwaf8kwQ71YA=
X-Google-Smtp-Source: ABdhPJx+t33PpWpnU28e1lAYt0t2+lAZpwZin3BFlts0fUSJB9fnFcamPhk2uejVRy6ikVFS9nsVPMHg+sP9psveAYQ=
X-Received: by 2002:a92:3556:: with SMTP id c83mr11937439ila.218.1590152792429;
 Fri, 22 May 2020 06:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200517125754.8934-1-ardb@kernel.org>
In-Reply-To: <20200517125754.8934-1-ardb@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 22 May 2020 15:06:20 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGUxPuQCv9KPezqpLf1qLTbJh_j9JeVnnYZ=HbnL65=AQ@mail.gmail.com>
Message-ID: <CAMj1kXGUxPuQCv9KPezqpLf1qLTbJh_j9JeVnnYZ=HbnL65=AQ@mail.gmail.com>
Subject: Re: [GIT PULL 0/7] EFI fixes for v5.7
To:     linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Benjamin Thiel <b.thiel@posteo.de>,
        Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Loic Yhuel <loic.yhuel@gmail.com>,
        Matthew Garrett <mjg59@google.com>,
        Mike Lothian <mike@fireburn.co.uk>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 17 May 2020 at 14:58, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> The following changes since commit a088b858f16af85e3db359b6c6aaa92dd3bc09=
21:
>
>   efi/x86: Revert struct layout change to fix kexec boot regression (2020=
-04-14 08:32:17 +0200)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urge=
nt
>
> for you to fetch changes up to b4f1874c62168159fdb419ced4afc77c1b51c475:
>
>   tpm: check event log version before reading final events (2020-05-17 11=
:46:50 +0200)
>
> ----------------------------------------------------------------
> EFI fixes for v5.7-rcX:
> - fix EFI framebuffer earlycon for wide fonts
> - avoid filling screen_info with garbage if the EFI framebuffer is not
>   available
> - fix a potential host tool build error due to a symbol clash on x86
> - work around a EFI firmware bug regarding the binary format of the TPM
>   final events table
> - fix a missing memory free by reworking the E820 table sizing routine to
>   not do the allocation in the first place
> - add CPER parsing for firmware errors
>
> ----------------------------------------------------------------
> Arvind Sankar (1):
>       x86/boot: Mark global variables as static
>
> Benjamin Thiel (1):
>       efi: Pull up arch-specific prototype efi_systab_show_arch()
>
> Dave Young (1):
>       efi/earlycon: Fix early printk for wider fonts
>
> Heinrich Schuchardt (1):
>       efi/libstub: Avoid returning uninitialized data from setup_graphics=
()
>
> Lenny Szubowicz (1):
>       efi/libstub/x86: Avoid EFI map buffer alloc in allocate_e820()
>
> Lo=C3=AFc Yhuel (1):
>       tpm: check event log version before reading final events
>
> Punit Agrawal (1):
>       efi: cper: Add support for printing Firmware Error Record Reference
>
>  arch/x86/boot/tools/build.c             | 16 ++++-----
>  drivers/firmware/efi/cper.c             | 62 +++++++++++++++++++++++++++=
++++++
>  drivers/firmware/efi/earlycon.c         | 14 ++++----
>  drivers/firmware/efi/efi.c              |  5 +--
>  drivers/firmware/efi/libstub/arm-stub.c |  6 +++-
>  drivers/firmware/efi/libstub/efistub.h  | 13 +++++++
>  drivers/firmware/efi/libstub/mem.c      |  2 --
>  drivers/firmware/efi/libstub/tpm.c      |  5 +--
>  drivers/firmware/efi/libstub/x86-stub.c | 24 +++++--------
>  drivers/firmware/efi/tpm.c              |  5 ++-
>  include/linux/cper.h                    |  9 +++++
>  include/linux/efi.h                     |  2 ++
>  12 files changed, 124 insertions(+), 39 deletions(-)

Ping?
