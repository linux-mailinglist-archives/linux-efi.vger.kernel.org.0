Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FF1598073
	for <lists+linux-efi@lfdr.de>; Thu, 18 Aug 2022 10:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243060AbiHRI6x (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Aug 2022 04:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239820AbiHRI6w (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 Aug 2022 04:58:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A144979DE
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 01:58:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03D5161313
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 08:58:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566F4C433D6
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 08:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660813130;
        bh=sw6/pPEbBo90CaEqv4LYs6u6hnDnLNAC1v165Yx2L0g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N5K+pBUAdrbul1KxRlydh4g056scXT/LJJCd3U4BbMxPa0X/TVoxDsq+SCwdVdcJ+
         U3eQ/93+LdPkOBs2iszzVEP7/ajjZAOsR0Tf4A4kTUVpugEfFF69qiJIw0yhF+yILO
         SN5PYcEO27yHL/cY2HGWe8Sol/5TLl4fEzo2P4tQmGsYdxSE0WWCkRTn/tlD8iPKWl
         I6yYjoanvA5W1FNB36zbyuexTBqE9gNsZnm3i/mhUVcAwgnFPDARg0A/Xy7BfEv5vJ
         FnOWGOCZHqIYCr3Q4ANJkHNvhlFfr99PZ8PewYM5YiQ26IUVXHOBm6wGmrjF4b2Mvm
         yjWKuBIBA+FZQ==
Received: by mail-wr1-f50.google.com with SMTP id j7so960033wrh.3
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 01:58:50 -0700 (PDT)
X-Gm-Message-State: ACgBeo3haig4mbasyO06LwO6+5yytfusQezRW/5o5rKv6llw1ahja6pJ
        GCeUpSv5fuuGyOekW6HTsBdMiWghQG5hGdtKa0Q=
X-Google-Smtp-Source: AA6agR5UFw+9XrEiqw/YIjnIdJsMJ9CAYnwl6pJjPMFdeaXZvn/v3b21kExP611KnyKnVVAdqmU/CkrPv7Rp/cifTUg=
X-Received: by 2002:a5d:64e9:0:b0:220:7dd7:63eb with SMTP id
 g9-20020a5d64e9000000b002207dd763ebmr1044097wri.590.1660813128596; Thu, 18
 Aug 2022 01:58:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220818085540.2075028-1-ardb@kernel.org>
In-Reply-To: <20220818085540.2075028-1-ardb@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 18 Aug 2022 10:58:36 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEwnR-iTJGy6Yxxmt_tJM22Z57GBVKHqTcRTMAQS1PqgA@mail.gmail.com>
Message-ID: <CAMj1kXEwnR-iTJGy6Yxxmt_tJM22Z57GBVKHqTcRTMAQS1PqgA@mail.gmail.com>
Subject: Re: [PATCH resend 0/9] linux: implement LoadFile2 initrd loading
To:     grub-devel@nongnu.org
Cc:     linux-efi@vger.kernel.org, grub-devel@gnu.org,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Nikita Ermakov <arei@altlinux.org>,
        Atish Patra <atishp@atishpatra.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        dann frazier <dann.frazier@canonical.com>,
        Julian Andres Klode <julian.klode@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 18 Aug 2022 at 10:55, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> This implements the LoadFile2 initrd loading protocol, which is
> essentially a callback interface into the bootloader to load the initrd
> data into a caller provided buffer. This means the bootloader no longer
> has to contain any policy regarding where to load the initrd (which
> differs between architectures and kernel versions) and no longer has to
> manipulate arch specific data structures such as DT or struct bootparams
> to inform the OS where the initrd resides in memory. This is especially
> relevant for the upcoming LoongArch support, which does not use either
> DT or struct bootparams, and would have to rely on the initrd= command
> line interface, which is deprecated and of limited utility [0].
>
> Sample output from booting a recent Linux/arm64 kernel:
>
>   grub> insmod part_msdos
>   grub> linux (hd0,msdos1)/Image
>   grub> initrd (hd0,msdos1)/initrd.img
>   grub> boot
>   EFI stub: Booting Linux Kernel...
>   EFI stub: EFI_RNG_PROTOCOL unavailable, KASLR will be disabled
>   EFI stub: Generating empty DTB
>   EFI stub: Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path
>   EFI stub: Exiting boot services and installing virtual address map...
>   [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x411fd070]
>
> This is mostly a resend of my original v2 [1], although I did
> cherry-pick Nikita's version of the first patch, which incorporates
> Heinrich's suggestion to simply drop the argv[] argument from
> grub_initrd_load(). I also included the patch I sent out the other day
> to remove the pointless header magic number check, and included a fix
> for the PXE boot issue reported by dann [2].
>
> [0] The initrd= command line loader can only access files that reside on
> the same volume as the loaded image, which means GRUB would have to
> present this volume abstraction in order to serve the initrd file.
> Another reason why this method is problematic is generic EFI zboot,
> which is being added to Linux, and which calls loadimage on another,
> embedded PE/COFF image which would also need to expose this volume
> abstraction.
>
> [1] https://lists.gnu.org/archive/html/grub-devel/2020-10/msg00124.html
> [2] https://lists.gnu.org/archive/html/grub-devel/2022-04/msg00055.html
>
> Cc: grub-devel@gnu.org

When cc'ing to this series, please note that i included an incorrect
grub-devel@ address too - please remove.

> Cc: Daniel Kiper <daniel.kiper@oracle.com>
> Cc: Nikita Ermakov <arei@altlinux.org>
> Cc: Atish Patra <atishp@atishpatra.org>
> Cc: Huacai Chen <chenhuacai@loongson.cn>
> Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Cc: dann frazier <dann.frazier@canonical.com>
> Cc: Julian Andres Klode <julian.klode@canonical.com>
>
> Ard Biesheuvel (8):
>   efi: move MS-DOS stub out of generic PE header definition
>   arm64/linux: Remove magic number header field check
>   linux/arm: unify ARM/arm64 vs Xen PE/COFF header handling
>   linux/arm: account for COFF headers appearing at unexpected offsets
>   efi: add definition of LoadFile2 protocol
>   efi/efinet: Don't close connections at fini_hw() time
>   efi: implement LoadFile2 initrd loading protocol for Linux
>   linux: ignore FDT unless we need to modify it
>
> Nikita Ermakov (1):
>   loader: drop argv[] argument in grub_initrd_load()
>
>  grub-core/commands/efi/lsefi.c            |   1 +
>  grub-core/kern/efi/efi.c                  |   5 +-
>  grub-core/loader/arm/linux.c              |   2 +-
>  grub-core/loader/arm64/linux.c            | 181 +++++++++++++++++---
>  grub-core/loader/arm64/xen_boot.c         |  23 +--
>  grub-core/loader/efi/fdt.c                |   7 +-
>  grub-core/loader/i386/linux.c             |   2 +-
>  grub-core/loader/i386/pc/linux.c          |   2 +-
>  grub-core/loader/i386/xen.c               |   3 +-
>  grub-core/loader/ia64/efi/linux.c         |   2 +-
>  grub-core/loader/linux.c                  |   4 +-
>  grub-core/loader/mips/linux.c             |   2 +-
>  grub-core/loader/powerpc/ieee1275/linux.c |   2 +-
>  grub-core/loader/sparc64/ieee1275/linux.c |   2 +-
>  grub-core/net/drivers/efi/efinet.c        |  10 +-
>  grub-core/net/net.c                       |   2 +-
>  include/grub/arm/linux.h                  |   7 +-
>  include/grub/arm64/linux.h                |   5 +-
>  include/grub/efi/api.h                    |  15 ++
>  include/grub/efi/efi.h                    |   4 +-
>  include/grub/efi/pe32.h                   |   5 +-
>  include/grub/linux.h                      |   2 +-
>  include/grub/net.h                        |   3 +-
>  23 files changed, 226 insertions(+), 65 deletions(-)
>
> --
> 2.35.1
>
