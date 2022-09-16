Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112AE5BA74B
	for <lists+linux-efi@lfdr.de>; Fri, 16 Sep 2022 09:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiIPHQR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Sep 2022 03:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiIPHQO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 16 Sep 2022 03:16:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F892A4B30;
        Fri, 16 Sep 2022 00:16:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2E16B81DFB;
        Fri, 16 Sep 2022 07:16:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9214C43141;
        Fri, 16 Sep 2022 07:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663312568;
        bh=Cm3UUEytVx7XDzbf0hJ5HKk8CiH8g7t8ofke1E2XWrc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qWmUmV+A7/P8Ln3LOXbjaaGE4k3SCjf6jK7Nei3vZtscCdy9JhMKff8tkF7bIdi3Q
         MYdL9Rpx6zrLrQkNrcX8F3tvF2khUs9pfBQk30QKrh7Z3DgQcncHzta0bmcnqDH2wd
         hPh0swoI8pM492D2UF9GbiyBE1UydRyzk3FFzA6fwqXUaT87mOl6O/VX8aIYpRbrv1
         12ds2NWQgJPTfSdZjz4IPWwBDCbECwVmOwLgD2qaHudCg/ARpqqmNSJY9Vli96uABN
         4aK5DyLouHu3ujWAGpLp6rtb/RdvUruQXTRi8fiRnzbao9uDVPfkpFNz9w44S3wZiO
         +YuIUINh50pkA==
Received: by mail-lj1-f179.google.com with SMTP id l12so24959690ljg.9;
        Fri, 16 Sep 2022 00:16:08 -0700 (PDT)
X-Gm-Message-State: ACrzQf1xK6/yyt3M3sp6bN63EQG1ofvr/x7dsa60raAzKv38aUd7ByhH
        sn117z03/o5qgT+eYfdeQrhujjczBpygqgQ7CZc=
X-Google-Smtp-Source: AMsMyM6MHtk3FAh90aHUMvlzeqW5Nt5muYWOe4OHGFyJuWLiL5wDceMK/NnXokHw9577z/hjVIPW3KdMEz1+dcF4l3Q=
X-Received: by 2002:a2e:7314:0:b0:26a:ca18:60eb with SMTP id
 o20-20020a2e7314000000b0026aca1860ebmr954677ljc.69.1663312566687; Fri, 16 Sep
 2022 00:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220910081152.2238369-1-ardb@kernel.org> <20220910081152.2238369-8-ardb@kernel.org>
 <13de0332-df33-f13c-bed8-334b0cb84214@microchip.com>
In-Reply-To: <13de0332-df33-f13c-bed8-334b0cb84214@microchip.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 16 Sep 2022 09:15:55 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHvAuqyEr-W1hTyxxG_wdUbXny1f95uwsAOMMc5UEXMAA@mail.gmail.com>
Message-ID: <CAMj1kXHvAuqyEr-W1hTyxxG_wdUbXny1f95uwsAOMMc5UEXMAA@mail.gmail.com>
Subject: Re: [PATCH v5 7/8] riscv: efi: enable generic EFI compressed boot
To:     Conor.Dooley@microchip.com
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        James.Bottomley@hansenpartnership.com, mjg59@srcf.ucam.org,
        pjones@redhat.com, ilias.apalodimas@linaro.org,
        heinrich.schuchardt@canonical.com, takahiro.akashi@linaro.org,
        palmer@dabbelt.com, atishp@atishpatra.org, arnd@arndb.de,
        chenhuacai@loongson.cn, xry111@xry111.site, lennart@poettering.net,
        jeremy.linton@arm.com, will@kernel.org, catalin.marinas@arm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 16 Sept 2022 at 09:09, <Conor.Dooley@microchip.com> wrote:
>
> On 10/09/2022 09:11, Ard Biesheuvel wrote:
> >
> > Wire up the generic EFI zboot support for RISC-V.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> As promised:
> Tested-by: Conor Dooley <conor.dooley@microchip.com>
>

Thanks a lot!

> > ---
> >   arch/riscv/Makefile        | 6 +++++-
> >   arch/riscv/boot/.gitignore | 1 +
> >   arch/riscv/boot/Makefile   | 6 ++++++
> >   3 files changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> > index 3fa8ef336822..d63295e21373 100644
> > --- a/arch/riscv/Makefile
> > +++ b/arch/riscv/Makefile
> > @@ -136,10 +136,14 @@ ifneq ($(CONFIG_XIP_KERNEL),y)
> >   ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_SOC_CANAAN),yy)
> >   KBUILD_IMAGE := $(boot)/loader.bin
> >   else
> > +ifeq ($(CONFIG_EFI_ZBOOT),)
> >   KBUILD_IMAGE := $(boot)/Image.gz
> > +else
> > +KBUILD_IMAGE := $(boot)/vmlinuz.efi
> > +endif
> >   endif
> >   endif
> > -BOOT_TARGETS := Image Image.gz loader loader.bin xipImage
> > +BOOT_TARGETS := Image Image.gz loader loader.bin xipImage vmlinuz.efi
> >
> >   all:   $(notdir $(KBUILD_IMAGE))
> >
> > diff --git a/arch/riscv/boot/.gitignore b/arch/riscv/boot/.gitignore
> > index 0cea9f7fa9d5..e1bc507e8cb2 100644
> > --- a/arch/riscv/boot/.gitignore
> > +++ b/arch/riscv/boot/.gitignore
> > @@ -4,4 +4,5 @@ Image.*
> >   loader
> >   loader.lds
> >   loader.bin
> > +vmlinuz*
> >   xipImage
> > diff --git a/arch/riscv/boot/Makefile b/arch/riscv/boot/Makefile
> > index becd0621071c..d1a49adcb1d7 100644
> > --- a/arch/riscv/boot/Makefile
> > +++ b/arch/riscv/boot/Makefile
> > @@ -58,3 +58,9 @@ $(obj)/Image.lzo: $(obj)/Image FORCE
> >
> >   $(obj)/loader.bin: $(obj)/loader FORCE
> >          $(call if_changed,objcopy)
> > +
> > +EFI_ZBOOT_PAYLOAD      := Image
> > +EFI_ZBOOT_BFD_TARGET   := elf$(BITS)-littleriscv
> > +EFI_ZBOOT_MACH_TYPE    := RISCV$(BITS)
> > +
> > +include $(srctree)/drivers/firmware/efi/libstub/Makefile.zboot
> > --
> > 2.35.1
> >
>
