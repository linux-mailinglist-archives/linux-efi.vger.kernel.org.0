Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBC9669896
	for <lists+linux-efi@lfdr.de>; Fri, 13 Jan 2023 14:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241296AbjAMNdp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Jan 2023 08:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241411AbjAMNcy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Jan 2023 08:32:54 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA161C421;
        Fri, 13 Jan 2023 05:25:30 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id tz12so52319536ejc.9;
        Fri, 13 Jan 2023 05:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UOllpG0+Dl5G/9qIkXzHpwBMNf8SENLbMSdjFtdgPg4=;
        b=PR/TRLOjKwTt0dfXTfmtHqU/QGU2Y1BwrnZAF3q5lkPA8wtAkbQiaVxnccS3IK9juN
         ZtbWY/Hp6PccMsWTQz41H/SlpAdk7sHHjK2ZXeuXowROukD6sNnploQYWaSb5eWG0AMK
         CAudJzXuqvELN1JUazhboI/kyuHcJzoUG2fwh4+qeXKkXCUg5kz0Qb3WPUVYjAbO4rZw
         yjM8ociyqWAJV+mR5gMFdUUjnN+X2xJn1KfvGaQHwosutrZwsbFChUdWxld+zW900Sxg
         tWAeEI2md0Hqge162UJdJOt3+B2DCCcsoZbAIozTFCYN5CuEqEj5O1bs4FTEh9csYyvN
         qwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UOllpG0+Dl5G/9qIkXzHpwBMNf8SENLbMSdjFtdgPg4=;
        b=R4wH7LB/R98ib0tTcEW5vEwq3QC6dme04Z2Rydt6LFO/ZOOxiKG29Xs7vLyuB+bCOL
         Gdwa62PhaCMjaGV/DZrZYoAhltyy3cbumjGr+BWZHv2QE+OLnTWQ8kf0da4CbP+3CCMH
         D3wF77R2C/kK09FvxB5DOH9yM8rVYOYK2x+VG1QJsLx0hk81IViiu0p0UahXSAtiTQ54
         k2Yg2+hYzHX2kE/QdDzfRU5r5ezoQnfdDHOB6+EohrgsEe6yQinueUcrjTD5L9UeQmrm
         74TfqFbBSAoOmBGlOAjalltLMFxIbdV6Du247beTErINgfrhzUh8BaBor7jOSPJ583Kv
         UOPg==
X-Gm-Message-State: AFqh2kp4VFco7tWbHCs74DFgUELW/fSyeDk+yFGIxozmrflTomUQXgrs
        02OY8x2d1iVHUKPWKUt8rVV2gIm+DgkFuyb01lE=
X-Google-Smtp-Source: AMrXdXtvUT/ihPdUmS8OJfyvASCv1Is4rEjgNwD/WZcCjONxgISROcy/9/mCABAXkOCWC/PHgzqDafrpgL2bJi5zvIs=
X-Received: by 2002:a17:906:c0c2:b0:836:9bcf:16e5 with SMTP id
 bn2-20020a170906c0c200b008369bcf16e5mr4548613ejb.439.1673616328722; Fri, 13
 Jan 2023 05:25:28 -0800 (PST)
MIME-Version: 1.0
References: <CAKXUXMxNc4iObjL+8RyJN=Kcy5X1r21ez_05oAuy93J=gQ2gZw@mail.gmail.com>
 <CAMj1kXH3hoGWF=c7UVsWi3xoJsJ1VyFK74CV+L8SO8u2o2xdsQ@mail.gmail.com>
In-Reply-To: <CAMj1kXH3hoGWF=c7UVsWi3xoJsJ1VyFK74CV+L8SO8u2o2xdsQ@mail.gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 13 Jan 2023 14:25:17 +0100
Message-ID: <CAKXUXMyoUxKqxA3FSwFHitZkahbJqXZk4cb7LL7c9yFddFHw3Q@mail.gmail.com>
Subject: Re: linker problem with Ubuntu 18.04 tool chain: unknown architecture
 of input file `arch/arm64/boot/vmlinuz.o' is incompatible with aarch64 output
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 13, 2023 at 12:58 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 13 Jan 2023 at 12:50, Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> >
> > Dear Ard,
> >
> > with my Ubuntu 18.04 arm gcc tool chain, I encounter this linker error
> > in my allyesconfig build:
> >
> >  LD      arch/arm64/boot/vmlinuz.efi.elf
> > aarch64-linux-gnu-ld: unknown architecture of input file
> > `arch/arm64/boot/vmlinuz.o' is incompatible with aarch64 output
> > drivers/firmware/efi/libstub/Makefile.zboot:41: recipe for target
> > 'arch/arm64/boot/vmlinuz.efi.elf' failed
> > make[1]: *** [arch/arm64/boot/vmlinuz.efi.elf] Error 1
> > arch/arm64/Makefile:173: recipe for target 'vmlinuz.efi' failed
> > make: *** [vmlinuz.efi] Error 2
> >
> > I bisected it back to happen since commit c37b830fef13 ("arm64: efi:
> > enable generic EFI compressed boot"), and it still appears with the
> > latest next-20230113 (on linux-next, I have to remove DRM_MSM as it
> > currently comes with a build error).
> >
> > The specific compiler and linker versions on my system are:
> >
> > $ aarch64-linux-gnu-ld --version
> > GNU ld (GNU Binutils for Ubuntu) 2.30
> >
> > $ aarch64-linux-gnu-gcc --version
> > aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0
> >
> >
> > IMHO, I run pretty standard commands:
> > make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j 32 mrproper
> > make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j 32 allyesconfig
> > make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j 32 all
> >
> > Let me know if you need more information.
> >
>
> Hello Lukas,
>
> This seems to mean that AArch64 ld.bfd 2.30 is not able to combine
> generic ELF objects with AArch64 ELF objects. vmlinuz.o only contains
> a compressed blob in an ELF data section, and more modern toolchains
> have no issue with this at all.
>
> Given that building allyesconfig with fairly outdated toolchains is
> not something anyone is likely to obsess about, I don't have a strong
> preference as to how we work around this, put perhaps the easiest
> approach would be for CONFIG_EFI_ZBOOT to depend on !CONFIG_LD_IS_BFD
> || CONFIG_LD_VERSION >= 23xxx here? (We'll need to check the exact
> version)

That sounds reasonable to me.

Thanks,

Lukas
