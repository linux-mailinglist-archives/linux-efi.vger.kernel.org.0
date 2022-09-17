Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D745BB971
	for <lists+linux-efi@lfdr.de>; Sat, 17 Sep 2022 18:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiIQQhA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 17 Sep 2022 12:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiIQQg6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 17 Sep 2022 12:36:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A1A2DA96;
        Sat, 17 Sep 2022 09:36:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09FA160D58;
        Sat, 17 Sep 2022 16:36:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FDEC4314B;
        Sat, 17 Sep 2022 16:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663432612;
        bh=i7R8+F7tYcsgLS7ZIj1yIcPrNdfwusF8ZYSygT5U8uk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rLQEvhX7hYeEuzt8+Z+E68Q2aoEApJMjljaxtp4izO6hK/wx7k2+zuRdc27XKI+NT
         sRPO/acreNpT6Tu4QvZZKlPQDC9jXZVMQ2TLmsxsFmMsnHA+Q54CN9I49YEx6iU/Zn
         SkWg4z3k1V8+E4bzaFT8x914UJxIsvLqCpn+hEas/3on1170/fk5hQkfFoR5Vb6byy
         GcyRu+cNpNH/YYCgSKdxWb44F1zca9ELZw0/mwZbTAK8r/H+PhdwmZPNlXcsRznRRi
         XYPAx3IyvWrfzyGT4IWJlbsRr7EHlFWPINabfQucKStTgdNUf7IIXIewsYtiutTO1X
         6pIG+PVih/3dA==
Received: by mail-lj1-f171.google.com with SMTP id bn9so29217986ljb.6;
        Sat, 17 Sep 2022 09:36:52 -0700 (PDT)
X-Gm-Message-State: ACrzQf3qhIPP1Ji2WO6aiMtCg8iFI6pXPo7xLjz4c41SfmFCcMauzYM/
        U0rDzYQ7/r+cZ+VMtpODHtUe+gQ385RmDqp03t4=
X-Google-Smtp-Source: AMsMyM6xmONHQzT9Zn/W+1q0oHQQ1zeAhyg36WV4Nzj1xV+AkhvpRnEtlacVohtkJ86kEpJm0ltaH8Q5JqIsaNu+mMI=
X-Received: by 2002:a2e:7314:0:b0:26a:ca18:60eb with SMTP id
 o20-20020a2e7314000000b0026aca1860ebmr2628614ljc.69.1663432610167; Sat, 17
 Sep 2022 09:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220910081152.2238369-1-ardb@kernel.org> <20220910081152.2238369-7-ardb@kernel.org>
In-Reply-To: <20220910081152.2238369-7-ardb@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 17 Sep 2022 18:36:38 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHFsSUHjyuwj3aThoq=oZdEJca9XSCu=Fbkhk+qTj6khQ@mail.gmail.com>
Message-ID: <CAMj1kXHFsSUHjyuwj3aThoq=oZdEJca9XSCu=Fbkhk+qTj6khQ@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] arm64: efi: enable generic EFI compressed boot
To:     linux-efi@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>,
        Lennart Poettering <lennart@poettering.net>,
        Jeremy Linton <jeremy.linton@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 10 Sept 2022 at 10:12, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Wire up the generic EFI zboot support for arm64.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

I've queued up most of this now for 6.1 - Catalin, Will, any
objections if I queue this one as well via the efi tree?

> ---
>  arch/arm64/Makefile        | 9 +++++++--
>  arch/arm64/boot/.gitignore | 1 +
>  arch/arm64/boot/Makefile   | 6 ++++++
>  3 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 6d9d4a58b898..a82bb3599094 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -151,12 +151,17 @@ libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
>
>  # Default target when executing plain make
>  boot           := arch/arm64/boot
> +
> +ifeq ($(CONFIG_EFI_ZBOOT),)
>  KBUILD_IMAGE   := $(boot)/Image.gz
> +else
> +KBUILD_IMAGE   := $(boot)/vmlinuz.efi
> +endif
>
> -all:   Image.gz
> +all:   $(notdir $(KBUILD_IMAGE))
>
>
> -Image: vmlinux
> +Image vmlinuz.efi: vmlinux
>         $(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
>
>  Image.%: Image
> diff --git a/arch/arm64/boot/.gitignore b/arch/arm64/boot/.gitignore
> index 9a7a9009d43a..af5dc61f8b43 100644
> --- a/arch/arm64/boot/.gitignore
> +++ b/arch/arm64/boot/.gitignore
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  Image
>  Image.gz
> +vmlinuz*
> diff --git a/arch/arm64/boot/Makefile b/arch/arm64/boot/Makefile
> index a0e3dedd2883..c65aee088410 100644
> --- a/arch/arm64/boot/Makefile
> +++ b/arch/arm64/boot/Makefile
> @@ -38,3 +38,9 @@ $(obj)/Image.lzo: $(obj)/Image FORCE
>
>  $(obj)/Image.zst: $(obj)/Image FORCE
>         $(call if_changed,zstd)
> +
> +EFI_ZBOOT_PAYLOAD      := Image
> +EFI_ZBOOT_BFD_TARGET   := elf64-littleaarch64
> +EFI_ZBOOT_MACH_TYPE    := ARM64
> +
> +include $(srctree)/drivers/firmware/efi/libstub/Makefile.zboot
> --
> 2.35.1
>
