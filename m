Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9961265DCF
	for <lists+linux-efi@lfdr.de>; Fri, 11 Sep 2020 12:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgIKK13 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Sep 2020 06:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgIKK11 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 11 Sep 2020 06:27:27 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A86C061573
        for <linux-efi@vger.kernel.org>; Fri, 11 Sep 2020 03:27:27 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 67so6315635pgd.12
        for <linux-efi@vger.kernel.org>; Fri, 11 Sep 2020 03:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iZukon98544uKMJxuSYOk+tTtmLWIDBAaxjb6julkA0=;
        b=gtPAJhHyaE+Y1Vl3eeuU3fp++hJQHPQ0ALhsXj5ATr8xe3IpcvXHGGq3NGNrwNUCEM
         b5m0CqrUwWjZf6DdtzZHTlad6T2240PuhfSSEiL01hCMsjl6gPh+OJ+VjV59nKv6uxbu
         CK95niZqq4na1EK6hcQpbXBS4+JZLBYfm3MnkqWnQx2VhgPUC2NSEI0KHwRpgY3h7ngV
         FfuP6o3eVs49RhUQ441tQZ8l+Gq6t6NHLW7PW03qhEODAV7Tpnw44Pfpt73kKJ42AfZo
         j3BxCDVnWPdrNXpSRwwjzbuZ/hbIcRWqK1SREFpODB0hQbCShLGEJ+DEc6d8m69/BtH0
         bhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iZukon98544uKMJxuSYOk+tTtmLWIDBAaxjb6julkA0=;
        b=da4QISvRCfEmYyQB/mb0Z4AfqKkS5hNlqUT0JczaDCgqkIATrR4112yQZwBLqndLRw
         r6HjV/9ibyR8aJAejRjUTNRHdbmVuh+5xKzfUF6vBBDu5r3Gy88koeTMiumNJa2kL4TD
         ol5mP6DTpyzHmqtJtw4mrTE3McVxfJzDqg/22JKmniQO9k5meBtrpZ82kY/GpuqZNgFp
         avJWqeMRZwQDXMCe7uxVkOMicOVp11DHMLv9wrgbOFivQCNc7CFUBdufEgpf2FGwNQ20
         MSSUUGvY9DPGL+aCk0GeIgGApX8blJAGpiufrsACxAG39uoToStXzPaHfFrJSRy9bwXw
         HLWg==
X-Gm-Message-State: AOAM5328pYiT5sJA1OlJQEV/tctmKIE0gtpOsOTz1fhWQDextIfW7vHB
        Bass8gzaWegl+cdNi+fcc16khbAS3b4z5L1eEsTxaw==
X-Google-Smtp-Source: ABdhPJyzjD+TUN0KJe7I5di5orbsKmFIizF3csoFZlUvf/fHDcTNJhUkiIrtoN8SQ6LK6N5mV0SSYhxcVrEZQR1QMAk=
X-Received: by 2002:a17:902:82c1:: with SMTP id u1mr1467390plz.38.1599820046560;
 Fri, 11 Sep 2020 03:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXG6VRXOPRhHmeyiPP06BVByEYsqYE001BZYyRDqtvyDBg@mail.gmail.com>
 <mhng-f3ca14fc-58f7-423e-8abe-a85de1a2d55b@palmerdabbelt-glaptop1> <CAMj1kXH5pA-9uWCRzvN2OKzxTr0mG8knZZnpuOPn+b5BBAn4dw@mail.gmail.com>
In-Reply-To: <CAMj1kXH5pA-9uWCRzvN2OKzxTr0mG8knZZnpuOPn+b5BBAn4dw@mail.gmail.com>
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
Date:   Fri, 11 Sep 2020 13:27:15 +0300
Message-ID: <CAD8XO3YQfWQv_WxWuJ0ur_chfK-iSjDwhWA4KWXP85VOYCi_qQ@mail.gmail.com>
Subject: Re: [PATCH RFC/RFT 0/3] efi/libstub: arm32: Remove dependency on dram_base
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Atish Patra <Atish.Patra@wdc.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        =?UTF-8?Q?Fran=C3=A7ois_Ozog?= <francois.ozog@linaro.org>,
        Etienne CARRIERE <etienne.carriere@st.com>,
        Takahiro Akashi <takahiro.akashi@linaro.org>,
        Patrice CHOTARD <patrice.chotard@st.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Grant Likely <Grant.Likely@arm.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Christophe Priouzeau <christophe.priouzeau@linaro.org>,
        Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        Patrick Delaunay <patrick.delaunay@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Changes look fine for and should fix booting, while I can test them in
my environment next week.

Thanks,
Maxim.

On Fri, 11 Sep 2020 at 10:56, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 11 Sep 2020 at 05:16, Palmer Dabbelt <palmer@dabbelt.com> wrote:
> >
> > On Thu, 10 Sep 2020 07:08:07 PDT (-0700), ardb@kernel.org wrote:
> > > On Thu, 10 Sep 2020 at 13:04, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >>
> > >> On Thu, 10 Sep 2020 at 04:34, Atish Patra <atishp@atishpatra.org> wrote:
> > >> >
> > >> > On Wed, Sep 9, 2020 at 2:44 PM Atish Patra <atishp@atishpatra.org> wrote:
> > >> > >
> > >> > > On Wed, Sep 9, 2020 at 1:52 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> > >> > > >
> > >> > > > On Wed, 09 Sep 2020 08:16:20 PDT (-0700), ardb@kernel.org wrote:
> > >> > > > > Maxim reports boot failures on platforms that describe reserved memory
> > >> > > > > regions in DT that are disjoint from system DRAM, and which are converted
> > >> > > > > to EfiReservedMemory regions by the EFI subsystem in u-boot.
> > >> > > > >
> > >> > > > > As it turns out, the whole notion of discovering the base of DRAM is
> > >> > > > > problematic, and it would be better to simply rely on the EFI memory
> > >> > > > > allocation routines instead, and derive the FDT and initrd allocation
> > >> > > > > limits from the actual placement of the kernel (which is what defines
> > >> > > > > the start of the linear region anyway)
> > >> > > > >
> > >> > > > > Finally, we should be able to get rid of get_dram_base() entirely.
> > >> > > > > However, as RISC-V only just started using it, we will need to address
> > >> > > > > that at a later time.
> > >> > > >
> > >> > > > Looks like we're using dram_base to derive two argumets to
> > >> > > > efi_relocate_kernel(): the preferred load address and the minimum load address.
> > >> > > > I don't see any reason why we can't use the same PAGE_OFFSET-like logic that
> > >> > > > x86 uses for the minimum load address, but I don't think we have any mechanism
> > >> > > > like "struct boot_params" so we'd need to come up with something.
> > >> > > >
> > >> > >
> > >> > > As discussed in the other thread
> > >> > > (https://www.spinics.net/lists/linux-efi/msg20262.html),
> > >> > > we don't need to do anything special. efi_relocate_kernel can just
> > >> > > take preferred address as 0
> > >> > > so that efi_bs_alloc will fail and efi_low_alloc_above will be used to
> > >> > > allocate 2MB/4MB aligned address as per requirement.
> > >> > >
> > >> > > I don't think the other changes in this series will cause any issue
> > >> > > for RISC-V. I will test it and update anyways.
> > >> > >
> > >> > > > > Cc: Maxim Uvarov <maxim.uvarov@linaro.org>
> > >> > > > > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > >> > > > > Cc: Atish Patra <atish.patra@wdc.com>
> > >> > > > > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > >> > > > > Cc: Jens Wiklander <jens.wiklander@linaro.org>
> > >> > > > > Cc: Francois Ozog <francois.ozog@linaro.org>
> > >> > > > > Cc: Etienne CARRIERE <etienne.carriere@st.com>
> > >> > > > > Cc: Takahiro Akashi <takahiro.akashi@linaro.org>
> > >> > > > > Cc: Patrice CHOTARD <patrice.chotard@st.com>
> > >> > > > > Cc: Sumit Garg <sumit.garg@linaro.org>
> > >> > > > > Cc: Grant Likely <Grant.Likely@arm.com>
> > >> > > > > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > >> > > > > Cc: Christophe Priouzeau <christophe.priouzeau@linaro.org>
> > >> > > > > Cc: Rouven Czerwinski <r.czerwinski@pengutronix.de>
> > >> > > > > Cc: Patrick DELAUNAY <patrick.delaunay@st.com>
> > >> > > > >
> > >> > > > > Ard Biesheuvel (3):
> > >> > > > >   efi/libstub: Export efi_low_alloc_above() to other units
> > >> > > > >   efi/libstub: Use low allocation for the uncompressed kernel
> > >> > > > >   efi/libstub: base FDT and initrd placement on image address not DRAM
> > >> > > > >     base
> > >> > > > >
> > >> > > > >  arch/arm/include/asm/efi.h                |   6 +-
> > >> > > > >  arch/arm64/include/asm/efi.h              |   2 +-
> > >> > > > >  drivers/firmware/efi/libstub/arm32-stub.c | 177 ++++----------------
> > >> > > > >  drivers/firmware/efi/libstub/efi-stub.c   |   2 +-
> > >> > > > >  drivers/firmware/efi/libstub/efistub.h    |   3 +
> > >> > > > >  drivers/firmware/efi/libstub/relocate.c   |   4 +-
> > >> > > > >  6 files changed, 47 insertions(+), 147 deletions(-)
> > >> > >
> > >> >
> > >> > I verified the above patches along with the following RISC-V specific changes.
> > >> >
> > >> > diff --git a/arch/riscv/include/asm/efi.h b/arch/riscv/include/asm/efi.h
> > >> > index 93c305a638f4..dd6ceea9d548 100644
> > >> > --- a/arch/riscv/include/asm/efi.h
> > >> > +++ b/arch/riscv/include/asm/efi.h
> > >> > @@ -37,7 +37,7 @@ static inline unsigned long
> > >> > efi_get_max_fdt_addr(unsigned long dram_base)
> > >> >  static inline unsigned long efi_get_max_initrd_addr(unsigned long dram_base,
> > >> >                                                     unsigned long image_addr)
> > >> >  {
> > >> > -       return dram_base + SZ_256M;
> > >> > +       return image_addr + SZ_256M;
> > >> >  }
> > >> >
> > >>
> > >> Ah yes, we need this change as well - this is a bit unfortunate since
> > >> that creates a conflict with the RISC-V tree.
> > >>
> > >> > --- a/drivers/firmware/efi/libstub/riscv-stub.c
> > >> > +++ b/drivers/firmware/efi/libstub/riscv-stub.c
> > >> > @@ -100,7 +100,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
> > >> >          */
> > >> >         preferred_addr = round_up(dram_base, MIN_KIMG_ALIGN) + MIN_KIMG_ALIGN;
> > >> >         status = efi_relocate_kernel(image_addr, kernel_size, *image_size,
> > >> > -                                    preferred_addr, MIN_KIMG_ALIGN, dram_base);
> > >> > +                                    0, MIN_KIMG_ALIGN, 0);
> > >> >
> > >> > FWIW: Tested-by: Atish Patra <atish.patra@wdc.com>
> > >>
> > >> Thanks for confirming.
> > >
> > > OK,
> > >
> > > So, just to annoy Palmer and you more than I already have up to this
> > > point: any chance we could do a final respin of the RISC-V code on top
> > > of these changes? They are important for ARM, and I would prefer these
> > > to be merged in a way that makes it easy to backport them to -stable
> > > if needed.
> > >
> > > So what I would suggest is:
> > > - I will create a new 'shared-efi' tag/stable branch containing the
> > > existing two patches, as well as these changes (in a slightly updated
> > > form)
> > > - Palmer creates a new topic branch in the riscv repo based on this
> > > shared tag, and applies the [updated] RISC-V patches on top
> > > - Palmer drops the current version of the riscv patches from
> > > riscv/for-next, and merges the topic branch into it instead.
> > >
> > > Again, sorry to be a pain, but I think this is the cleanest way to get
> > > these changes queued up for v5.10 without painting ourselves into a
> > > corner too much when it comes to future follow-up changes.
> >
> > That's fine for me.
>
> Excellent.
>
> I have created a signed tag efi-riscv-shared-for-v5.10 in the EFI repo
> [0], which is based on v5.9-rc1. Please merge that at the start of
> your for-next/efi topic branch, and apply the reworked EFI for RISC-V
> series on top.
>
> I have created a preliminary version of that branch as 'riscv-tmp' on
> [1], incorporating some changes that are needed for the rebase. Note
> that I applied some other tweaks as well - one is in a separate patch
> on top, the other is that I omitted the Makefile rule for .stub.o
> objects under arch/riscv/Makefile, as it is not actually used.
>
> Atish - please pick whatever seems useful to you from that branch when
> you do the respin.
>
> Thanks,
> Ard.
>
>
>
> [0] git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
