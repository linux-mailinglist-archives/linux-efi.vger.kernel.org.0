Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402A436DC97
	for <lists+linux-efi@lfdr.de>; Wed, 28 Apr 2021 18:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240714AbhD1QBW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 28 Apr 2021 12:01:22 -0400
Received: from air.basealt.ru ([194.107.17.39]:40696 "EHLO air.basealt.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240643AbhD1QBV (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 28 Apr 2021 12:01:21 -0400
X-Greylist: delayed 389 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Apr 2021 12:01:20 EDT
Received: by air.basealt.ru (Postfix, from userid 490)
        id 1B7A1589849; Wed, 28 Apr 2021 15:54:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on
        sa.local.altlinux.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.1
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
        by air.basealt.ru (Postfix) with ESMTPSA id 655CD589885;
        Wed, 28 Apr 2021 15:53:59 +0000 (UTC)
Received: by mail-lf1-f48.google.com with SMTP id y4so59799698lfl.10;
        Wed, 28 Apr 2021 08:53:59 -0700 (PDT)
X-Gm-Message-State: AOAM530WI49Iq8rSB32KplMH3YIamXHO58HgPvlCKFt34uZdM8DIkKBL
        KcDKTauFlF52J4xPdX2J2gC78+Fi0dbJLp9bAj0=
X-Google-Smtp-Source: ABdhPJx5vGyFCavDZ0bGTHpchNBpFKoMmtZo4e8mFWs9KS+BByQzfj0cVI1vx+buY8ZWti7UPQn6YpWavDEjfHbuDVM=
X-Received: by 2002:a05:6512:10cb:: with SMTP id k11mr21304043lfg.84.1619625239082;
 Wed, 28 Apr 2021 08:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210427120607.2646166-1-arei@altlinux.org> <CAMj1kXGm9d7SdBoozEoOP4G6ETmNiZR8kum91RVc_4eUTroE2w@mail.gmail.com>
In-Reply-To: <CAMj1kXGm9d7SdBoozEoOP4G6ETmNiZR8kum91RVc_4eUTroE2w@mail.gmail.com>
From:   Nikita Ermakov <arei@altlinux.org>
Date:   Wed, 28 Apr 2021 18:53:23 +0300
X-Gmail-Original-Message-ID: <CANA1cBL0AiJBbZX6x3LjTLYJ7z2ueaDWDKJrM50Xd2AxNPO14g@mail.gmail.com>
Message-ID: <CANA1cBL0AiJBbZX6x3LjTLYJ7z2ueaDWDKJrM50Xd2AxNPO14g@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Relocate the kernel relative to a DRAM base.
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Nikita Ermakov <arei@altlinux.org>,
        linux-efi <linux-efi@vger.kernel.org>,
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

On Tue, 27 Apr 2021 at 15:43, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 27 Apr 2021 at 14:07, Nikita Ermakov <arei@altlinux.org> wrote:
> >
> > Try to get the base of the DRAM from a DTB to use it as a lowest address
> > in physical memory to relocate the kernel. If it is not possible to
> > obtain the base from a /memory node of the DTB let's make an assumption
> > that the DRAM base at the beginning of the memory.
> >
>
> Why?
>

You right, this patch is useless. I made it because I overlooked
efi_low_alloc_above() in libstub/relocate.c
Sorry for bothering.

I had an issue with booting a Linux kernel with EFI stub on a HiFive
Unleashed board.
My boot chain was as follows: ZSBL -> FSBL -> OpenSBI -> U-Boot
(bootefi) -> Linux
When I tried to boot the kernel, U-Boot throws an Store/AMO access
fault exception.
I checked the riscv-stub.c and libstub/relocate.c and I thought that
it tries to relocate the kernel at the 2 MiB.
With this patch the kernel started to boot and I thought that the
theory was right.
But, after further investigation I found out that U-Boot EFI does not
mark the first 4 KiB page of DRAM as EFI_BOOT_SERVICE_DATA on the
board and efi_low_alloc_above() allocates this region as conventional
memory. The lowest region of DRAM is protected and that is why I got
the exception when the kernel tries to relocate to the 0x80000000. The
reason why U-Boot EFI does not mark the first 4 KiB of DRAM as
EFI_BOOT_SERVICE_DATA was that there wasn't /reserved-memory node in a
DTB. I had the FSBL with a patch which enables an entire L2 cache and
it does not preserve a0, a1 registers before a jump to the OpenSBI.
So, OpenSBI didn't fixup the DTB where it adds the /reserved-memory
node.

> > Signed-off-by: Nikita Ermakov <arei@altlinux.org>
> > ---
> >  drivers/firmware/efi/libstub/riscv-stub.c | 39 ++++++++++++++++++++++-
> >  1 file changed, 38 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/efi/libstub/riscv-stub.c b/drivers/firmware/efi/libstub/riscv-stub.c
> > index 380e4e251399..1b5944276e1a 100644
> > --- a/drivers/firmware/efi/libstub/riscv-stub.c
> > +++ b/drivers/firmware/efi/libstub/riscv-stub.c
> > @@ -46,6 +46,39 @@ static u32 get_boot_hartid_from_fdt(void)
> >         return fdt32_to_cpu(*prop);
> >  }
> >
> > +static unsigned long get_dram_base_from_fdt(void)
> > +{
> > +       const void *fdt;
> > +       int node, len;
> > +       const fdt32_t *addr_cells;
> > +       const void *prop;
> > +
> > +       fdt = get_efi_config_table(DEVICE_TREE_GUID);
> > +       if (!fdt)
> > +               return ULONG_MAX;
> > +
> > +       node = fdt_path_offset(fdt, "/");
> > +       if (node < 0)
> > +               return ULONG_MAX;
> > +
> > +       addr_cells = fdt_getprop((void *)fdt, node, "#address-cells", &len);
> > +       if (!addr_cells)
> > +               return ULONG_MAX;
> > +
> > +       node = fdt_path_offset(fdt, "/memory");
> > +       if (node < 0)
> > +               return ULONG_MAX;
> > +
> > +       prop = fdt_getprop((void *)fdt, node, "reg", &len);
> > +       if (!prop)
> > +               return ULONG_MAX;
> > +
> > +       if (fdt32_to_cpu(*addr_cells) > 1)
> > +               return fdt64_to_cpu(*((fdt64_t *)prop));
> > +       else
> > +               return fdt32_to_cpu(*((fdt32_t *)prop));
> > +}
> > +
> >  efi_status_t check_platform_features(void)
> >  {
> >         hartid = get_boot_hartid_from_fdt();
> > @@ -97,7 +130,11 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
> >          * lowest possible memory region as long as the address and size meets
> >          * the alignment constraints.
> >          */
> > -       preferred_addr = MIN_KIMG_ALIGN;
> > +       preferred_addr = get_dram_base_from_fdt();
> > +       if (preferred_addr == ULONG_MAX)
> > +               preferred_addr = MIN_KIMG_ALIGN;
> > +       else
> > +               preferred_addr += MIN_KIMG_ALIGN;
> >         status = efi_relocate_kernel(image_addr, kernel_size, *image_size,
> >                                      preferred_addr, MIN_KIMG_ALIGN, 0x0);
> >
> > --
> > 2.29.3
> >



-- 
Thanks,
Nikita
B8 00 4C CD 21
