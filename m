Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42F24EED8B
	for <lists+linux-efi@lfdr.de>; Fri,  1 Apr 2022 14:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346014AbiDAM6f (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 1 Apr 2022 08:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346007AbiDAM6e (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 1 Apr 2022 08:58:34 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906B2276816
        for <linux-efi@vger.kernel.org>; Fri,  1 Apr 2022 05:56:44 -0700 (PDT)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E6DD53F816
        for <linux-efi@vger.kernel.org>; Fri,  1 Apr 2022 12:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1648817802;
        bh=oz27duE5Ryo8jJ1fge3md1VX7PuJsZs6ffNWaIrGhqo=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=mye6/+uva7C28e6zBCtTdHDCYypnz+A60648rsUU3TVSODh28V9H0pFQPmj6PfYUW
         xEe3DSe1QBBNSB5FmSgN/5xzo1zetb7J7ooqbyP0VKA0Bu3Tij1xzmdsmL+VML4SVk
         dW7AulY7J+RUx4xYF91lz9QJXBl3bKPoBqlK5T6rEwrGt74FyIaZfZHcKM/GvVomPU
         VPsYdCZtV2oEFJzJCPJiRYwbUODkrh51xYM0kxbN3MpeuOukO21NFIwMYxr4rBmGmg
         9qHZt7yZDNVFlmdtC1CTmmIbtPVsuTS1SJv3bMevX5YtIEww8B6o63ssSKb2+vDEsJ
         sKsXWY3WiKF/g==
Received: by mail-ej1-f69.google.com with SMTP id i14-20020a17090639ce00b006dabe6a112fso1515079eje.13
        for <linux-efi@vger.kernel.org>; Fri, 01 Apr 2022 05:56:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oz27duE5Ryo8jJ1fge3md1VX7PuJsZs6ffNWaIrGhqo=;
        b=XlV8Gn/feaO6hAkO+zb4qcVxzLOJCpvGqRpzCcaEXCB1yWmn6QLcAwMIAnh/40wuyU
         QWPjLtGnsSQ1jfbo43YM07aZitLqrzHD2T89w6Q1aRDP6SVKY9WsCVw049wEo2H6eDhi
         2ItGaA1SvoiPvrTNdB/pkd6UxLzWyuKoeTNTAySLxJiWJ1BZXPFuVo9D/gsoXw36JdxZ
         2r8ntLieQY3SMrb+NZqprSF7zVWBSYcvwTBxEO3t2fmuROybVCqfAG+BlS4jTQST/LqJ
         +G9WzaRZg+tLAm4pMn+ScURKByzqdmBJgQtHiJcdz1O/AOJ9JI2YR7c7+sY3KPJVRRWm
         YFyw==
X-Gm-Message-State: AOAM533tO0eMrh54znS0QWUN+mNoFaXyhsZiZ0fZoVeKVaJ2SxXSN08a
        xDkjNVCq9V0CRFdSct3a4XLzWy19Lsf7m9g1/VkDvrRNyFojTifZXN72Phcd3TJWg7nrlOrDbZr
        KUEY38RRDK3Evy99jZSeF6thJfPtS5d7xnb6FgDdY83rnPSXcWUXuKQ==
X-Received: by 2002:a17:907:6d90:b0:6e4:de0d:462 with SMTP id sb16-20020a1709076d9000b006e4de0d0462mr1479975ejc.297.1648817802126;
        Fri, 01 Apr 2022 05:56:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3UOVWoFjs/8J+LCeSjgOBZWMsxpLRT/MRpcKhhW7WGYKzTlQ7ENxIvkntR92kvsH+XxHiD2o6KQi3CkOW2X0=
X-Received: by 2002:a17:907:6d90:b0:6e4:de0d:462 with SMTP id
 sb16-20020a1709076d9000b006e4de0d0462mr1479957ejc.297.1648817801897; Fri, 01
 Apr 2022 05:56:41 -0700 (PDT)
MIME-Version: 1.0
References: <20211206104657.433304-1-alexandre.ghiti@canonical.com>
 <mhng-cdec292e-aea2-4b76-8853-b8465521e94f@palmer-ri-x1c9>
 <CA+zEjCuTSjOCmNExSN1jO50tsuXNzL9x6K6jWjG4+vVky5eWsw@mail.gmail.com>
 <CA+zEjCuTYmk-dLPhJ=9CkNrqf7VbCNyRDSZUGYkJSUWqZDWHpA@mail.gmail.com> <CA+zEjCt04OV++qK5ar+p8HwqOfEgkSN8YFfxwRiCFw1FeJv2rg@mail.gmail.com>
In-Reply-To: <CA+zEjCt04OV++qK5ar+p8HwqOfEgkSN8YFfxwRiCFw1FeJv2rg@mail.gmail.com>
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date:   Fri, 1 Apr 2022 14:56:30 +0200
Message-ID: <CA+zEjCuyEsB0cHoL=zepejcRbn9Rwg9nRXLMZCOXe_daSWbvig@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] Introduce sv48 support without relocatable kernel
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     corbet@lwn.net, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, zong.li@sifive.com, anup@brainfault.org,
        Atish.Patra@rivosinc.com, Christoph Hellwig <hch@lst.de>,
        ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, ardb@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        keescook@chromium.org, guoren@linux.alibaba.com,
        heinrich.schuchardt@canonical.com, mchitale@ventanamicro.com,
        panqinglin2020@iscas.ac.cn, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Feb 18, 2022 at 11:45 AM Alexandre Ghiti
<alexandre.ghiti@canonical.com> wrote:
>
> Hi Palmer,
>
> On Thu, Jan 20, 2022 at 11:05 AM Alexandre Ghiti
> <alexandre.ghiti@canonical.com> wrote:
> >
> > On Thu, Jan 20, 2022 at 8:30 AM Alexandre Ghiti
> > <alexandre.ghiti@canonical.com> wrote:
> > >
> > > On Thu, Jan 20, 2022 at 5:18 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> > > >
> > > > On Mon, 06 Dec 2021 02:46:44 PST (-0800), alexandre.ghiti@canonical.com wrote:
> > > > > * Please note notable changes in memory layouts and kasan population *
> > > > >
> > > > > This patchset allows to have a single kernel for sv39 and sv48 without
> > > > > being relocatable.
> > > > >
> > > > > The idea comes from Arnd Bergmann who suggested to do the same as x86,
> > > > > that is mapping the kernel to the end of the address space, which allows
> > > > > the kernel to be linked at the same address for both sv39 and sv48 and
> > > > > then does not require to be relocated at runtime.
> > > > >
> > > > > This implements sv48 support at runtime. The kernel will try to
> > > > > boot with 4-level page table and will fallback to 3-level if the HW does not
> > > > > support it. Folding the 4th level into a 3-level page table has almost no
> > > > > cost at runtime.
> > > > >
> > > > > Note that kasan region had to be moved to the end of the address space
> > > > > since its location must be known at compile-time and then be valid for
> > > > > both sv39 and sv48 (and sv57 that is coming).
> > > > >
> > > > > Tested on:
> > > > >   - qemu rv64 sv39: OK
> > > > >   - qemu rv64 sv48: OK
> > > > >   - qemu rv64 sv39 + kasan: OK
> > > > >   - qemu rv64 sv48 + kasan: OK
> > > > >   - qemu rv32: OK
> > > > >
> > > > > Changes in v3:
> > > > >   - Fix SZ_1T, thanks to Atish
> > > > >   - Fix warning create_pud_mapping, thanks to Atish
> > > > >   - Fix k210 nommu build, thanks to Atish
> > > > >   - Fix wrong rebase as noted by Samuel
> > > > >   - * Downgrade to sv39 is only possible if !KASAN (see commit changelog) *
> > > > >   - * Move KASAN next to the kernel: virtual layouts changed and kasan population *
> > > > >
> > > > > Changes in v2:
> > > > >   - Rebase onto for-next
> > > > >   - Fix KASAN
> > > > >   - Fix stack canary
> > > > >   - Get completely rid of MAXPHYSMEM configs
> > > > >   - Add documentation
> > > > >
> > > > > Alexandre Ghiti (13):
> > > > >   riscv: Move KASAN mapping next to the kernel mapping
> > > > >   riscv: Split early kasan mapping to prepare sv48 introduction
> > > > >   riscv: Introduce functions to switch pt_ops
> > > > >   riscv: Allow to dynamically define VA_BITS
> > > > >   riscv: Get rid of MAXPHYSMEM configs
> > > > >   asm-generic: Prepare for riscv use of pud_alloc_one and pud_free
> > > > >   riscv: Implement sv48 support
> > > > >   riscv: Use pgtable_l4_enabled to output mmu_type in cpuinfo
> > > > >   riscv: Explicit comment about user virtual address space size
> > > > >   riscv: Improve virtual kernel memory layout dump
> > > > >   Documentation: riscv: Add sv48 description to VM layout
> > > > >   riscv: Initialize thread pointer before calling C functions
> > > > >   riscv: Allow user to downgrade to sv39 when hw supports sv48 if !KASAN
> > > > >
> > > > >  Documentation/riscv/vm-layout.rst             |  48 ++-
> > > > >  arch/riscv/Kconfig                            |  37 +-
> > > > >  arch/riscv/configs/nommu_k210_defconfig       |   1 -
> > > > >  .../riscv/configs/nommu_k210_sdcard_defconfig |   1 -
> > > > >  arch/riscv/configs/nommu_virt_defconfig       |   1 -
> > > > >  arch/riscv/include/asm/csr.h                  |   3 +-
> > > > >  arch/riscv/include/asm/fixmap.h               |   1
> > > > >  arch/riscv/include/asm/kasan.h                |  11 +-
> > > > >  arch/riscv/include/asm/page.h                 |  20 +-
> > > > >  arch/riscv/include/asm/pgalloc.h              |  40 ++
> > > > >  arch/riscv/include/asm/pgtable-64.h           | 108 ++++-
> > > > >  arch/riscv/include/asm/pgtable.h              |  47 +-
> > > > >  arch/riscv/include/asm/sparsemem.h            |   6 +-
> > > > >  arch/riscv/kernel/cpu.c                       |  23 +-
> > > > >  arch/riscv/kernel/head.S                      |   4 +-
> > > > >  arch/riscv/mm/context.c                       |   4 +-
> > > > >  arch/riscv/mm/init.c                          | 408 ++++++++++++++----
> > > > >  arch/riscv/mm/kasan_init.c                    | 250 ++++++++---
> > > > >  drivers/firmware/efi/libstub/efi-stub.c       |   2
> > > > >  drivers/pci/controller/pci-xgene.c            |   2 +-
> > > > >  include/asm-generic/pgalloc.h                 |  24 +-
> > > > >  include/linux/sizes.h                         |   1
> > > > >  22 files changed, 833 insertions(+), 209 deletions(-)
> > > >
> > > > Sorry this took a while.  This is on for-next, with a bit of juggling: a
> > > > handful of trivial fixes for configs that were failing to build/boot and
> > > > some merge issues.  I also pulled out that MAXPHYSMEM fix to the top, so
> > > > it'd be easier to backport.  This is bigger than something I'd normally like to
> > > > take late in the cycle, but given there's a lot of cleanups, likely some fixes,
> > > > and it looks like folks have been testing this I'm just going to go with it.
> > > >
> > >
> > > Yes yes yes! That's fantastic news :)
> > >
> > > > Let me know if there's any issues with the merge, it was a bit hairy.
> > > > Probably best to just send along a fixup patch at this point.
> > >
> > > I'm going to take a look at that now, and I'll fix anything that comes
> > > up quickly :)
> >
> > I see in for-next that you did not take the following patches:
> >
> >   riscv: Improve virtual kernel memory layout dump
> >   Documentation: riscv: Add sv48 description to VM layout
> >   riscv: Initialize thread pointer before calling C functions
> >   riscv: Allow user to downgrade to sv39 when hw supports sv48 if !KASAN
> >
> > I'm not sure this was your intention. If it was, I believe that at
> > least the first 2 patches are needed in this series, the 3rd one is a
> > useful fix and we can discuss the 4th if that's an issue for you.
>
> Can you confirm that this was intentional and maybe explain the
> motivation behind it? Because I see value in those patches.

Palmer,

I read that you were still taking patches for 5.18, so I confirm again
that the patches above are needed IMO.

Maybe even the relocatable series?

Thanks,

Alex

>
> Thanks,
>
> Alex
>
> >
> > I tested for-next on both sv39 and sv48 successfully, I took a glance
> > at the code and noticed you fixed the PTRS_PER_PGD error, thanks for
> > that. Otherwise nothing obvious has popped.
> >
> > Thanks again,
> >
> > Alex
> >
> > >
> > > Thanks!
> > >
> > > Alex
> > >
> > > >
> > > > Thanks!
