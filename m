Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2A037290F
	for <lists+linux-efi@lfdr.de>; Tue,  4 May 2021 12:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhEDK3p (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 4 May 2021 06:29:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:43428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230283AbhEDK3n (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 4 May 2021 06:29:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F4E2613BE;
        Tue,  4 May 2021 10:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620124127;
        bh=dgb9VLbXx2tiQjiliX2CVp3l/xl303Qwf2JBJdlh0SQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OMlThanMroC7t/Y160W99ZocuyAr4w8fXQ07/HQtVO2nbS6VEXkS8GLyn2j+t/xER
         0sTYqMSJKR416yXOMtSo3SIbgiNtEIN2eFgl20plWso0fzHiNdGPNSWA10YzfJ9K4D
         y2Ii+tJihSFeKWZeX5iEj763No0vjdlAqEQfJartr2q95ms0uG8Y5vi4pHD7iqD3Yq
         cb6kDvleh4bzBIteD0qIFaVN6y+Jjrnx24+R7aTyawcb/rhepCULzhtyS/o42RlUfi
         PtnjEPyceVpuvS3Qvpc3Q8ecI5izMGBHs8HxUXaLD1Bud7985ojfcPBUBkaMLPJ5OK
         x2X9H2ehcnQUQ==
Received: by mail-oi1-f182.google.com with SMTP id i26so8289475oii.3;
        Tue, 04 May 2021 03:28:47 -0700 (PDT)
X-Gm-Message-State: AOAM530NnGAwBOmX6qoab4UrNKz+Yt+v4tHbb86EXS6SZdg1iwAh88d+
        eHEV244GshWD3G2e+JlLY3m/8vS/d1OxN5hNRk8=
X-Google-Smtp-Source: ABdhPJwWs+8lBECoghrn0jMvooaSkPWY3QfZNpDmHd7lBZl4tsIEGqtAm4chefB94vOZj78+zIHb30u5CHLOgE1IpDw=
X-Received: by 2002:aca:4056:: with SMTP id n83mr2521838oia.47.1620124126620;
 Tue, 04 May 2021 03:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210427120607.2646166-1-arei@altlinux.org> <CAMj1kXGm9d7SdBoozEoOP4G6ETmNiZR8kum91RVc_4eUTroE2w@mail.gmail.com>
 <CANA1cBL0AiJBbZX6x3LjTLYJ7z2ueaDWDKJrM50Xd2AxNPO14g@mail.gmail.com>
In-Reply-To: <CANA1cBL0AiJBbZX6x3LjTLYJ7z2ueaDWDKJrM50Xd2AxNPO14g@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 4 May 2021 12:28:35 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGhwXsVrjqSMCzkQ83MWh0W=63x5_+fyuugyewkB=xAXw@mail.gmail.com>
Message-ID: <CAMj1kXGhwXsVrjqSMCzkQ83MWh0W=63x5_+fyuugyewkB=xAXw@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Relocate the kernel relative to a DRAM base.
To:     Nikita Ermakov <arei@altlinux.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 28 Apr 2021 at 18:00, Nikita Ermakov <arei@altlinux.org> wrote:
>
> On Tue, 27 Apr 2021 at 15:43, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Tue, 27 Apr 2021 at 14:07, Nikita Ermakov <arei@altlinux.org> wrote:
> > >
> > > Try to get the base of the DRAM from a DTB to use it as a lowest address
> > > in physical memory to relocate the kernel. If it is not possible to
> > > obtain the base from a /memory node of the DTB let's make an assumption
> > > that the DRAM base at the beginning of the memory.
> > >
> >
> > Why?
> >
>
> You right, this patch is useless. I made it because I overlooked
> efi_low_alloc_above() in libstub/relocate.c
> Sorry for bothering.
>
> I had an issue with booting a Linux kernel with EFI stub on a HiFive
> Unleashed board.
> My boot chain was as follows: ZSBL -> FSBL -> OpenSBI -> U-Boot
> (bootefi) -> Linux
> When I tried to boot the kernel, U-Boot throws an Store/AMO access
> fault exception.
> I checked the riscv-stub.c and libstub/relocate.c and I thought that
> it tries to relocate the kernel at the 2 MiB.
> With this patch the kernel started to boot and I thought that the
> theory was right.
> But, after further investigation I found out that U-Boot EFI does not
> mark the first 4 KiB page of DRAM as EFI_BOOT_SERVICE_DATA on the
> board and efi_low_alloc_above() allocates this region as conventional
> memory. The lowest region of DRAM is protected and that is why I got
> the exception when the kernel tries to relocate to the 0x80000000. The
> reason why U-Boot EFI does not mark the first 4 KiB of DRAM as
> EFI_BOOT_SERVICE_DATA was that there wasn't /reserved-memory node in a
> DTB. I had the FSBL with a patch which enables an entire L2 cache and
> it does not preserve a0, a1 registers before a jump to the OpenSBI.
> So, OpenSBI didn't fixup the DTB where it adds the /reserved-memory
> node.
>

OK, thanks for the explanation. I will disregard this patch then.
