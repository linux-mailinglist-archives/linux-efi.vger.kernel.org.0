Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992DA77F760
	for <lists+linux-efi@lfdr.de>; Thu, 17 Aug 2023 15:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350227AbjHQNLp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 17 Aug 2023 09:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351382AbjHQNLe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 17 Aug 2023 09:11:34 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF08E30F6
        for <linux-efi@vger.kernel.org>; Thu, 17 Aug 2023 06:10:58 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-307d58b3efbso6654467f8f.0
        for <linux-efi@vger.kernel.org>; Thu, 17 Aug 2023 06:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1692277841; x=1692882641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzN7VvOx2pOtfSykr4IQN9EePpmfh/Zdn2JH7WehQ2o=;
        b=IHSO36skH/bMYgiJDH9KcoL19NQpaagMOUWh4c0+dhcp2tFiXiMCCz1gkDv2Iw16OW
         jCE0LqO6DuEScgqeLbF6VMmtPt7MLFUyVcjvpupP/8IPUBB1bTW08SrdPV6gvPKGyDHJ
         z22zUT3HeapF3yjCfiw2drxclyCQFexMi7XbW6Zwog43Xd8881pEwhyRWWLaC9G03Lr6
         l7dz8zHDhGaAHdoL/Q/u0GvGpkxNMEvD0hDZ1bId3LjddXUjGybzaY/HsyOAZzEYK+Vb
         /woi6gVqNQlqPLmDNXedmJfDvMfO56cY4pjZ1bDslEx783lOa3pmexadyJJQfa0E5lRM
         xJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692277841; x=1692882641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jzN7VvOx2pOtfSykr4IQN9EePpmfh/Zdn2JH7WehQ2o=;
        b=XoHvCKcAwcSBTo+5LSgiUCuhgvr3G1yxK/g+e5ppId6O754qHojnUV3T25AfmLqiv7
         8TfMe0TAcKR/6e2/2hx+c4IaWEWrHjHE9IlsWYiuJjuAdFOMKC7sCcRgfSGfNYvY04hw
         ym/y1uaiQkrwOJBuO3SwpNMC7A3ySnBnma6T8eafNBO2M7A+sEXh72s/NtmPQPGVj7z/
         lnBVzJReodUC8S04gAaMx3pnIuXsrbCUGUQ6ZEq+0Evo8caqudtDhYoBDMvzq5GWnzrY
         9af+RlpSGo3YAShtCp6c2bqYZAfxzp2ZxezwnAiFSP0QCUh3NbYXYzQyu9u/0lCQT9S4
         rMXQ==
X-Gm-Message-State: AOJu0YyScf/9NqFnJkWb9UtG8Lp8UHz24d2d6o4jVydHDMXO/LH2vI5z
        x1fJHE425IZJD9FqmOMeifRQn+FkOmO/1sCynT3TowtJTIrXmFck
X-Google-Smtp-Source: AGHT+IFhv2YZNQHMkPrHfKZ67eNLYD+0DLYyhEUdRhXGXP9pubmPKzBPoU6KC9pirkR92BjYQ/tVTC2Oxal1J/cCNhc=
X-Received: by 2002:adf:e78d:0:b0:317:e68f:e1b2 with SMTP id
 n13-20020adfe78d000000b00317e68fe1b2mr3559836wrm.28.1692277840899; Thu, 17
 Aug 2023 06:10:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230722123850.634544-1-alexghiti@rivosinc.com> <C172F31D25F5ED6E+034cc389-f02c-b681-a989-8592c5dac35e@tinylab.org>
In-Reply-To: <C172F31D25F5ED6E+034cc389-f02c-b681-a989-8592c5dac35e@tinylab.org>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Thu, 17 Aug 2023 15:10:30 +0200
Message-ID: <CAHVXubhD2r2OYQKRcBUfA+3h4SdejkUhVDD2Gx6WJ6pqBzSKpw@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] riscv: Introduce KASLR
To:     Song Shuai <songshuaishuai@tinylab.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Albert Ou <aou@eecs.berkeley.edu>, zong.li@sifive.com,
        conor.dooley@microchip.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Song,

On Tue, Aug 15, 2023 at 1:24=E2=80=AFPM Song Shuai <songshuaishuai@tinylab.=
org> wrote:
>
>
> Hi, Alex:
>
> =E5=9C=A8 2023/7/22 20:38, Alexandre Ghiti =E5=86=99=E9=81=93:
> > The following KASLR implementation allows to randomize the kernel mappi=
ng:
> >
> > - virtually: we expect the bootloader to provide a seed in the device-t=
ree
> > - physically: only implemented in the EFI stub, it relies on the firmwa=
re to
> >    provide a seed using EFI_RNG_PROTOCOL. arm64 has a similar implement=
ation
> >    hence the patch 3 factorizes KASLR related functions for riscv to ta=
ke
> >    advantage.
> >
> > The new virtual kernel location is limited by the early page table that=
 only
> > has one PUD and with the PMD alignment constraint, the kernel can only =
take
> > < 512 positions.
> >
>
> I have gone through the code and tested this series with RiscVVirt edk2.
> All seems good to me, you can add :
>
> Tested-by: Song Shuai <songshuaishuai@tinylab.org>
>
> And a few questions about patch 2 ("riscv: Dump out kernel offset
> information on panic"):
>
> 1. The dump_kernel_offset() function would output "Kernel Offset: 0x0
> from 0xffffffff80000000" when booting with "nokaslr" option.
>
> How about disabling the registration of "kernel_offset_notifier" with
> "nokaslr" option?

I'd rather keep it as it shows the "nokaslr" flag was taken into account.

>
> 2. Inspired by patch 2, I added the Crash KASLR support based on this
> series [1].
> So is it necessary to keep this patch if we have Crash KASLR support?

I don't understand your question here

>
>
> [1]:
> https://lore.kernel.org/linux-riscv/20230815104800.705753-1-songshuaishua=
i@tinylab.org/T/#u
>
> > base-commit-tag: v6.5-rc1
> >
> > Changes in v6:
> >    * Fix reintroduced build failures by compiling kaslr.c only for arm6=
4
> >      and riscv, as suggested by Ard
> >
> > Changes in v5:
> >    * Renamed efi-stub-kaslr.c into kaslr.c and fix commit log of patch =
3,
> >      as suggested by Ard
> >    * Removed stubs since the kaslr functions were moved to their own fi=
le
> >      (and then does not trigger any build failure for architectures tha=
t do
> >      not call those functions since they are in their own compilation u=
nit)
> >
> > Changes in v4:
> >    * Fix efi_get_kimg macro that returned nothing
> >    * Moved new kaslr functions into their own files to avoid zboot link
> >      failures, as suggested by Ard
> >
> > Changes in v3:
> >    * Rebase on top of 6.4-rc2
> >    * Make RANDOMIZE_BASE depend on 64bit
> >    * Fix efi_icache_sync and efi_get_kimg_min_align which were undefine=
d
> >      in x86 (and certainly other archs)
> >    * Add patch 4 to fix warning on rv32
> >
> > Changes in v2:
> >    * Rebase on top of 6.3-rc1
> >    * Add a riscv cache sync after memcpying the kernel
> >    * Add kaslr_offset implementation for KCOV
> >    * Add forward declaration to quiet LLVM
> >
> > Alexandre Ghiti (5):
> >    riscv: Introduce virtual kernel mapping KASLR
> >    riscv: Dump out kernel offset information on panic
> >    arm64: libstub: Move KASLR handling functions to kaslr.c
> >    libstub: Fix compilation warning for rv32
> >    riscv: libstub: Implement KASLR by using generic functions
> >
> >   arch/arm64/include/asm/efi.h              |   2 +
> >   arch/riscv/Kconfig                        |  19 +++
> >   arch/riscv/include/asm/efi.h              |   2 +
> >   arch/riscv/include/asm/page.h             |   3 +
> >   arch/riscv/kernel/image-vars.h            |   1 +
> >   arch/riscv/kernel/pi/Makefile             |   2 +-
> >   arch/riscv/kernel/pi/cmdline_early.c      |  13 ++
> >   arch/riscv/kernel/pi/fdt_early.c          |  30 ++++
> >   arch/riscv/kernel/setup.c                 |  25 ++++
> >   arch/riscv/mm/init.c                      |  36 ++++-
> >   drivers/firmware/efi/libstub/Makefile     |   4 +-
> >   drivers/firmware/efi/libstub/arm64-stub.c | 117 ++--------------
> >   drivers/firmware/efi/libstub/efistub.h    |   8 ++
> >   drivers/firmware/efi/libstub/kaslr.c      | 159 +++++++++++++++++++++=
+
> >   drivers/firmware/efi/libstub/riscv-stub.c |  33 ++---
> >   15 files changed, 328 insertions(+), 126 deletions(-)
> >   create mode 100644 arch/riscv/kernel/pi/fdt_early.c
> >   create mode 100644 drivers/firmware/efi/libstub/kaslr.c
> >
>
> --
> Thanks
> Song Shuai

Thanks for testing this and your suggestions!

Alex
