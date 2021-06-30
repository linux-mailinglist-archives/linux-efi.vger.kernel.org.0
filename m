Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB9303B7E10
	for <lists+linux-efi@lfdr.de>; Wed, 30 Jun 2021 09:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbhF3Hcy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Jun 2021 03:32:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232785AbhF3Hcy (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 30 Jun 2021 03:32:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E742361D0D;
        Wed, 30 Jun 2021 07:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625038225;
        bh=LgLwRlM2vgAjiWG1CvKhmKGXiZHELEvEd1+PAclEGZM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cbubElthuvDlQB1LHWO6FW8GGsopz4SX7tKIdQK0TxDO74KeBFtcx0/DPVOwyYQDN
         6qb8Mtw7D4qae4jShR9NApX3uTZoOyileMkHMDufA3sHz4RGhjJ+166IMMsRbDsvcn
         3pQydfyZiKTr/Uzg+22NwSIz9uVBxlJuiA1XJYcE9JOE8IOY1BPgoAs3EmS/SbGJyu
         rS/UpDJjN9vsTtspBOy37QpJ+j8W8XsuHa1dca/JWKB9TUIie2tB++xh+VebD6ncoZ
         wHWGUGbqvHFJE3vQQrLZw72st6Bo3oqY45O4hCr5tgZ4ii6ZOBc1IWF0uIvtEAVRqn
         qy64a4TG0mRjA==
Received: by mail-oi1-f180.google.com with SMTP id h9so2016368oih.4;
        Wed, 30 Jun 2021 00:30:25 -0700 (PDT)
X-Gm-Message-State: AOAM530wvzLu0gj2DCmN07z9bIoRZdVi8RpcCPV6jTX0wT25QsOJ66Lc
        JeYwF9tS5neBYGrT7UTXw7s+ytsrp3gfbV0Et8c=
X-Google-Smtp-Source: ABdhPJz4vMMdAJ6JJGe6ILpvyoclvoJOW/dpZm8I2fUqYOw2PoCl+WKEED/i5LKogGBU687vnmdSi3bTOuRd7B2gAf8=
X-Received: by 2002:aca:5a04:: with SMTP id o4mr24661915oib.33.1625038225214;
 Wed, 30 Jun 2021 00:30:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210629134018.62859-1-xypron.glpk@gmx.de> <CAOnJCUKuHGUZi-13PpnZGHKkXxhj3asVJgaNMTv3=830eVwi=g@mail.gmail.com>
In-Reply-To: <CAOnJCUKuHGUZi-13PpnZGHKkXxhj3asVJgaNMTv3=830eVwi=g@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 30 Jun 2021 09:30:14 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG-O5PLnEWGWXzYf2r471ng7j-jZ2ziTwLdSgdVFdJNaA@mail.gmail.com>
Message-ID: <CAMj1kXG-O5PLnEWGWXzYf2r471ng7j-jZ2ziTwLdSgdVFdJNaA@mail.gmail.com>
Subject: Re: [PATCH 1/1] RISC-V: load initrd wherever it fits into memory
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 30 Jun 2021 at 00:56, Atish Patra <atishp@atishpatra.org> wrote:
>
> On Tue, Jun 29, 2021 at 6:40 AM Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > Requiring that initrd is loaded below RAM start + 256 MiB led to failure
> > to boot SUSE Linux with GRUB on QEMU, cf.
> > https://lists.gnu.org/archive/html/grub-devel/2021-06/msg00037.html
> >
> > Remove the constraint.
> >
> > Reported-by: Andreas Schwab <schwab@linux-m68k.org>
> > Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > ---
> >  arch/riscv/include/asm/efi.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/efi.h b/arch/riscv/include/asm/efi.h
> > index 7542282f1141..649ab513dc99 100644
> > --- a/arch/riscv/include/asm/efi.h
> > +++ b/arch/riscv/include/asm/efi.h
> > @@ -33,10 +33,10 @@ static inline unsigned long efi_get_max_fdt_addr(unsigned long image_addr)
> >
> >  #define ARCH_EFI_IRQ_FLAGS_MASK (SR_IE | SR_SPIE)
> >
> > -/* Load initrd at enough distance from DRAM start */
> > +/* Load initrd anywhere in system RAM */
> >  static inline unsigned long efi_get_max_initrd_addr(unsigned long image_addr)
> >  {
> > -       return image_addr + SZ_256M;
> > +       return ULONG_MAX;
> >  }
> >
> >  #define alloc_screen_info(x...)                (&screen_info)
> > --
> > 2.30.2
> >
>
> LGTM
>
> Reviewed-by: Atish Patra <atish.patra@wdc.com>
>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

Please take this via the RISC-V tree.
