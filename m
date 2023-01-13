Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E8A669AAF
	for <lists+linux-efi@lfdr.de>; Fri, 13 Jan 2023 15:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjAMOkL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Jan 2023 09:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjAMOiL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Jan 2023 09:38:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9051106;
        Fri, 13 Jan 2023 06:30:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A54C361EEC;
        Fri, 13 Jan 2023 14:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D498C433EF;
        Fri, 13 Jan 2023 14:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673620212;
        bh=AI2qdhzHQYOZvVj31h9iyayFJ6oNC14+vrLCGTM4y/8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Iz9bGQLQ+rR01Y7++VZtP7Qf9j6Xd7kLDAOo2+vjva71dijUp+AFPQmTm+S8Sjl6r
         sAJM/x9BpRrP5rYrTwqgLltMCQn0ycwmuSqzLbuiFc9mzkygIC2vSIGSK/jeIRZ9ET
         E60ZLgZG9l4n9BNJ8H5CjTRnC+OlcqL0FfZr+lfRYFsXB+06bgIKUKiJJEKfUiqDOp
         PIfKw8R7iTcc6laG7eFOgjfeOqrJjZmAPeTLkDg0G0ZdX+Gt5ynjt5o8+SeV8jRtSF
         nZjk8xJvvDScsz1wiMXt0+6xZeprQfaqGdmy0p4AGGgyKL7BfmQ2NyHET7FwWGUGKb
         w/53J/oOFkWdg==
Received: by mail-lj1-f177.google.com with SMTP id n5so22089118ljc.9;
        Fri, 13 Jan 2023 06:30:11 -0800 (PST)
X-Gm-Message-State: AFqh2kqwLwwmYRL3Q5EV3VUFxh/ghVFDw9ACrRKukLHnmWaB/Um6tJtG
        ZY3z6aeSVPbk4QmbZqx1sZ7ZeCFB0RtICeHZ3NQ=
X-Google-Smtp-Source: AMrXdXtTvXcZJh3ejTfavbutrOqjzExcuOc0xJBYrPgi+NnXb9sSaNN+gYb/kwidUcMlHogDn5qlnp4ZQdBUoS4wrVM=
X-Received: by 2002:a2e:98d2:0:b0:289:7fc6:e1d with SMTP id
 s18-20020a2e98d2000000b002897fc60e1dmr360534ljj.69.1673620209975; Fri, 13 Jan
 2023 06:30:09 -0800 (PST)
MIME-Version: 1.0
References: <CAKXUXMxNc4iObjL+8RyJN=Kcy5X1r21ez_05oAuy93J=gQ2gZw@mail.gmail.com>
 <CAMj1kXH3hoGWF=c7UVsWi3xoJsJ1VyFK74CV+L8SO8u2o2xdsQ@mail.gmail.com> <CAKXUXMyoUxKqxA3FSwFHitZkahbJqXZk4cb7LL7c9yFddFHw3Q@mail.gmail.com>
In-Reply-To: <CAKXUXMyoUxKqxA3FSwFHitZkahbJqXZk4cb7LL7c9yFddFHw3Q@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 13 Jan 2023 15:29:58 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFVv4UWb2NoptHJDNYAURgN2Ox2tQJAa6_ZEPXkboS8ow@mail.gmail.com>
Message-ID: <CAMj1kXFVv4UWb2NoptHJDNYAURgN2Ox2tQJAa6_ZEPXkboS8ow@mail.gmail.com>
Subject: Re: linker problem with Ubuntu 18.04 tool chain: unknown architecture
 of input file `arch/arm64/boot/vmlinuz.o' is incompatible with aarch64 output
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-efi@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 13 Jan 2023 at 14:25, Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> On Fri, Jan 13, 2023 at 12:58 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Fri, 13 Jan 2023 at 12:50, Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> > >
> > > Dear Ard,
> > >
> > > with my Ubuntu 18.04 arm gcc tool chain, I encounter this linker error
> > > in my allyesconfig build:
> > >
> > >  LD      arch/arm64/boot/vmlinuz.efi.elf
> > > aarch64-linux-gnu-ld: unknown architecture of input file
> > > `arch/arm64/boot/vmlinuz.o' is incompatible with aarch64 output
> > > drivers/firmware/efi/libstub/Makefile.zboot:41: recipe for target
> > > 'arch/arm64/boot/vmlinuz.efi.elf' failed
> > > make[1]: *** [arch/arm64/boot/vmlinuz.efi.elf] Error 1
> > > arch/arm64/Makefile:173: recipe for target 'vmlinuz.efi' failed
> > > make: *** [vmlinuz.efi] Error 2
> > >
> > > I bisected it back to happen since commit c37b830fef13 ("arm64: efi:
> > > enable generic EFI compressed boot"), and it still appears with the
> > > latest next-20230113 (on linux-next, I have to remove DRM_MSM as it
> > > currently comes with a build error).
> > >
> > > The specific compiler and linker versions on my system are:
> > >
> > > $ aarch64-linux-gnu-ld --version
> > > GNU ld (GNU Binutils for Ubuntu) 2.30
> > >
> > > $ aarch64-linux-gnu-gcc --version
> > > aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0
> > >
> > >
> > > IMHO, I run pretty standard commands:
> > > make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j 32 mrproper
> > > make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j 32 allyesconfig
> > > make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j 32 all
> > >
> > > Let me know if you need more information.
> > >
> >
> > Hello Lukas,
> >
> > This seems to mean that AArch64 ld.bfd 2.30 is not able to combine
> > generic ELF objects with AArch64 ELF objects. vmlinuz.o only contains
> > a compressed blob in an ELF data section, and more modern toolchains
> > have no issue with this at all.
> >
> > Given that building allyesconfig with fairly outdated toolchains is
> > not something anyone is likely to obsess about, I don't have a strong
> > preference as to how we work around this, put perhaps the easiest
> > approach would be for CONFIG_EFI_ZBOOT to depend on !CONFIG_LD_IS_BFD
> > || CONFIG_LD_VERSION >= 23xxx here? (We'll need to check the exact
> > version)
>
> That sounds reasonable to me.
>

This is not reproducible with ld.bfd built from the upstream sources

$ ~/build/binutils-build-aarch64/ld/ld-new -v
GNU ld (GNU Binutils) 2.30

$ ~/build/binutils-build-aarch64/ld/ld-new -EL  -maarch64elf -z
noexecstack -T /usr/local/google/home/ardb/linux/drivers/firmware/efi/libstub/zboot.lds
arch/arm64/boot/vmlinuz.o arch/arm64/boot/zboot-header.o
drivers/firmware/efi/libstub/lib.a -o arch/arm64/boot/vmlinuz.efi.elf

$ file arch/arm64/boot/vmlinuz.efi.elf
arch/arm64/boot/vmlinuz.efi.elf: ELF 64-bit LSB executable, ARM
aarch64, version 1 (SYSV), statically linked, with debug_info, not
stripped

So this could be an issue in Ubuntu's downstream fork, in which case I
don't think we should do anything about it.
