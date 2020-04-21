Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83631B30D4
	for <lists+linux-efi@lfdr.de>; Tue, 21 Apr 2020 21:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgDUT4h (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 21 Apr 2020 15:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgDUT4g (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 21 Apr 2020 15:56:36 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA44C061BD3
        for <linux-efi@vger.kernel.org>; Tue, 21 Apr 2020 12:56:36 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x18so18030976wrq.2
        for <linux-efi@vger.kernel.org>; Tue, 21 Apr 2020 12:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nxA7LOrhaVraXBvW5EZQDf5sP2568aby3NQgKi/rtEk=;
        b=g3DXoPxFMzhq1js1o55SKsQkqQSARbVSnyDXZ5baDq2noMfiMb0GQHjiVLsutX6j1f
         z7rsNNHM787luX/ZkJUQMi2X8iedk/MZ4T8rzk/C6blaU1JF2P8TeZrX7KFEZwpn7J9I
         vwcl8gHhvkyGv8zT4rwpeGB+kb794hpbuP4UzXCqgzCxgIpEzlGx2719wSnnPG2F+o2z
         3Rmo0R+4B3UgRvcr/qcPvFWAy5bx8hOjHhjAFFO1J/iBFyALuNoI9dRSX9lsC3RPSKvs
         z8aSkZo2iEnccymVC1H0XF9veHEsx8qkJYNGr0G2TGvQ6vhL1L6WtgqfT4JSUz4xo9Y+
         2btQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nxA7LOrhaVraXBvW5EZQDf5sP2568aby3NQgKi/rtEk=;
        b=dlujUPbBMBhdlwiMbKWQJlNgFUfDc5Y5G8x6ImXDBQJ40/8wGxd59K0gqpFv0Aqr6L
         lF9aohtFKCKsOQI3I2FPY+h5A2DnZp0beXbpmuTsWCIU+6gh4lz92F68f9s/nUSwxyIl
         dARY5hBdYiNjneuSTh8rbCoXtjlNPTtz9HXTuPV3FwTp0+6pIQ+l7pD0/KpESHIv1upv
         cU4r479tVxJnTlxJrWsKe+EX3LE9HJqPMfQwXHre9P3y/7ZuS5ZRKm7FvH7qCM+5vOsJ
         1TEpj0YE2bxddCVfVHjsZ7bNG74ckLQoqSNOfkvqlz+jCMw37OCA4GNLjDcnahk6+PMk
         9jmw==
X-Gm-Message-State: AGi0Pua14DScQLHeAuOslrP2fdEVFbnSTH5UGlwm+hy1sQenD40mLYMn
        BuLjEGItAXGPaNATXeaKp9jPQbIdq7RJGFd4+a7lZ+g=
X-Google-Smtp-Source: APiQypKas+dWx33766cSGaK14/R+FoQPMy+nBjdmp3DiOU6GsuXahuVTjA+kS/uiDTaE2acwrptTZmiawRpgmkiV2Zg=
X-Received: by 2002:a5d:544f:: with SMTP id w15mr27562877wrv.77.1587498994797;
 Tue, 21 Apr 2020 12:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200421033336.9663-2-atish.patra@wdc.com> <mhng-613ec31b-83df-4a01-998c-e2d682787c1b@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-613ec31b-83df-4a01-998c-e2d682787c1b@palmerdabbelt-glaptop1>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 21 Apr 2020 12:56:23 -0700
Message-ID: <CAOnJCUKTYTb9_PbPzx26RrmAZojEucOCfpaCOQ6fo6mGOytStQ@mail.gmail.com>
Subject: Re: [v4 PATCH 1/3] RISC-V: Define fixmap bindings for generic early
 ioremap support
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Atish Patra <Atish.Patra@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Apr 21, 2020 at 12:52 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> I missed that there's a v4 now, so I'm jumping over here
>

Thanks. Just FYI: Ard has already pulled the patches 1 & 2 into efi-next.
So the v4 will only have 3 patches, mostly riscv specific stuff.

> On Mon, 20 Apr 2020 20:33:34 PDT (-0700), Atish Patra wrote:
> > UEFI uses early IO or memory mappings for runtime services before
> > normal ioremap() is usable. This patch only adds minimum necessary
> > fixmap bindings and headers for generic ioremap support to work.
> >
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > Acked-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/riscv/Kconfig              |  1 +
> >  arch/riscv/include/asm/Kbuild   |  1 +
> >  arch/riscv/include/asm/fixmap.h | 18 ++++++++++++++++++
> >  arch/riscv/include/asm/io.h     |  1 +
> >  4 files changed, 21 insertions(+)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index a197258595ef..f39e326a7a42 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -68,6 +68,7 @@ config RISCV
> >       select ARCH_HAS_GCOV_PROFILE_ALL
> >       select HAVE_COPY_THREAD_TLS
> >       select HAVE_ARCH_KASAN if MMU && 64BIT
> > +     select GENERIC_EARLY_IOREMAP
> >
> >  config ARCH_MMAP_RND_BITS_MIN
> >       default 18 if 64BIT
> > diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
> > index 3d9410bb4de0..59dd7be55005 100644
> > --- a/arch/riscv/include/asm/Kbuild
> > +++ b/arch/riscv/include/asm/Kbuild
> > @@ -1,4 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0
> > +generic-y += early_ioremap.h
> >  generic-y += extable.h
> >  generic-y += flat.h
> >  generic-y += kvm_para.h
> > diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
> > index 2368d49eb4ef..ba5096d65fb0 100644
> > --- a/arch/riscv/include/asm/fixmap.h
> > +++ b/arch/riscv/include/asm/fixmap.h
> > @@ -30,6 +30,24 @@ enum fixed_addresses {
> >       FIX_TEXT_POKE1,
> >       FIX_TEXT_POKE0,
> >       FIX_EARLYCON_MEM_BASE,
> > +     /*
> > +      * Make sure that it is 2MB aligned.
> > +      */
> > +#define NR_FIX_SZ_2M (SZ_2M / PAGE_SIZE)
> > +     FIX_THOLE = NR_FIX_SZ_2M - FIX_PMD - 1,
> > +
> > +     __end_of_permanent_fixed_addresses,
> > +     /*
> > +      * Temporary boot-time mappings, used by early_ioremap(),
> > +      * before ioremap() is functional.
> > +      */
> > +#define NR_FIX_BTMAPS                (SZ_256K / PAGE_SIZE)
> > +#define FIX_BTMAPS_SLOTS     7
> > +#define TOTAL_FIX_BTMAPS     (NR_FIX_BTMAPS * FIX_BTMAPS_SLOTS)
> > +
> > +     FIX_BTMAP_END = __end_of_permanent_fixed_addresses,
> > +     FIX_BTMAP_BEGIN = FIX_BTMAP_END + TOTAL_FIX_BTMAPS - 1,
> > +
> >       __end_of_fixed_addresses
> >  };
> >
> > diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
> > index 0f477206a4ed..047f414b6948 100644
> > --- a/arch/riscv/include/asm/io.h
> > +++ b/arch/riscv/include/asm/io.h
> > @@ -14,6 +14,7 @@
> >  #include <linux/types.h>
> >  #include <asm/mmiowb.h>
> >  #include <asm/pgtable.h>
> > +#include <asm/early_ioremap.h>
> >
> >  /*
> >   * MMIO access functions are separated out to break dependency cycles
>
> Just so it doesn't get lost (the patch is the same)
>
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>



-- 
Regards,
Atish
