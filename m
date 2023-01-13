Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456D8669B57
	for <lists+linux-efi@lfdr.de>; Fri, 13 Jan 2023 16:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjAMPEI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Jan 2023 10:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjAMPDo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Jan 2023 10:03:44 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FE57ECBB;
        Fri, 13 Jan 2023 06:54:37 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id c17so31471289edj.13;
        Fri, 13 Jan 2023 06:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ga5oYmInOFxOEz+aesVQq9ac8RCMAFr0TlPHsExHWvg=;
        b=Id9RsVsNvgffyUdEi4OU+jw02ijTvGRDMsdS/p8pAqNks6VLDAaISB9oW2FSl5eHWv
         a0zexS/Wz1ZQvgrR1mGNBbTYgCTPte/DQFayJ/8c8vz0PcjOkRuYxR7oS/i6rVRJAfhi
         sRvSvgjQfA/ze2iUBoIGN52y7OAcpl+M/n4Z0OQ2H0mFdgGswTf2eug8lb9yxE7knLpM
         W/ADP1KJdqIpU+dST8tf9ffTiE1rB1I74KBwVHFDBcEoEL0IZZjZDJin9bkb9Gy1FzRa
         Y3vW6lJZ7JWDfqY99MBw7r2DFKxFZlRdBinPL4Kj7zV07JpIfcxijlHxsgPYxHaqUYn8
         2JQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ga5oYmInOFxOEz+aesVQq9ac8RCMAFr0TlPHsExHWvg=;
        b=zdi21QSki6Qt55OSEDU2KrqLjAwn+l6CbmvamqvZMv6iAdw71O43ovlplrYP/h+/Wc
         L3SBkHuYSejgJ2kbcvmff+NsInJN5NiTXNh9bL+2BGquMyY0Lhi0TX+a1wiJJCNSnSYo
         AopYnJfyTX7zshBmdcHtIUX93znbYi1HeXidtAeI99zHlHuLBC7MihPsGLgpVJY2pUdI
         WnFPSt5Lqczmj7mjP99Gaju08l1F/rH1Khv1+FG9huDis6Z9t1SV1F7C5IfSaWAp69EB
         HA0B+sAPqxSD+ZI3+JVvkPN+93EpYlMER0hToypXpEAFVDhxqphLwXAN8w0P9l06JRko
         Bg+A==
X-Gm-Message-State: AFqh2kqLY93BAs9dOMtBjKBbee4Dz48Rf4Hv9r9geoipZo47qpL8zsR6
        ZFPztbuQCCuTF4nHxElI/iP7mZxJQjih0KdgmKMRpz0N
X-Google-Smtp-Source: AMrXdXt8O1nf9b7H0r4AtIeQyBKjx3U+D3c5sgzuLWCTOvIlmRWwIbExXGsNu1oYXhIAaXHwwg5is2ghNbccPd62m2Y=
X-Received: by 2002:a05:6402:28c6:b0:485:f888:e1df with SMTP id
 ef6-20020a05640228c600b00485f888e1dfmr7722656edb.337.1673621675529; Fri, 13
 Jan 2023 06:54:35 -0800 (PST)
MIME-Version: 1.0
References: <CAKXUXMxNc4iObjL+8RyJN=Kcy5X1r21ez_05oAuy93J=gQ2gZw@mail.gmail.com>
 <CAMj1kXH3hoGWF=c7UVsWi3xoJsJ1VyFK74CV+L8SO8u2o2xdsQ@mail.gmail.com>
 <CAKXUXMyoUxKqxA3FSwFHitZkahbJqXZk4cb7LL7c9yFddFHw3Q@mail.gmail.com> <CAMj1kXFVv4UWb2NoptHJDNYAURgN2Ox2tQJAa6_ZEPXkboS8ow@mail.gmail.com>
In-Reply-To: <CAMj1kXFVv4UWb2NoptHJDNYAURgN2Ox2tQJAa6_ZEPXkboS8ow@mail.gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 13 Jan 2023 15:54:24 +0100
Message-ID: <CAKXUXMyvUXfOrqV_MZpmz+5R07q_WZ7yVN1CnaAx13CcuN73yg@mail.gmail.com>
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

On Fri, Jan 13, 2023 at 3:30 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 13 Jan 2023 at 14:25, Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> >
> > On Fri, Jan 13, 2023 at 12:58 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Fri, 13 Jan 2023 at 12:50, Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> > > >
> > > > Dear Ard,
> > > >
> > > > with my Ubuntu 18.04 arm gcc tool chain, I encounter this linker error
> > > > in my allyesconfig build:
> > > >
> > > >  LD      arch/arm64/boot/vmlinuz.efi.elf
> > > > aarch64-linux-gnu-ld: unknown architecture of input file
> > > > `arch/arm64/boot/vmlinuz.o' is incompatible with aarch64 output
> > > > drivers/firmware/efi/libstub/Makefile.zboot:41: recipe for target
> > > > 'arch/arm64/boot/vmlinuz.efi.elf' failed
> > > > make[1]: *** [arch/arm64/boot/vmlinuz.efi.elf] Error 1
> > > > arch/arm64/Makefile:173: recipe for target 'vmlinuz.efi' failed
> > > > make: *** [vmlinuz.efi] Error 2
> > > >
> > > > I bisected it back to happen since commit c37b830fef13 ("arm64: efi:
> > > > enable generic EFI compressed boot"), and it still appears with the
> > > > latest next-20230113 (on linux-next, I have to remove DRM_MSM as it
> > > > currently comes with a build error).
> > > >
> > > > The specific compiler and linker versions on my system are:
> > > >
> > > > $ aarch64-linux-gnu-ld --version
> > > > GNU ld (GNU Binutils for Ubuntu) 2.30
> > > >
> > > > $ aarch64-linux-gnu-gcc --version
> > > > aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0
> > > >
> > > >
> > > > IMHO, I run pretty standard commands:
> > > > make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j 32 mrproper
> > > > make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j 32 allyesconfig
> > > > make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j 32 all
> > > >
> > > > Let me know if you need more information.
> > > >
> > >
> > > Hello Lukas,
> > >
> > > This seems to mean that AArch64 ld.bfd 2.30 is not able to combine
> > > generic ELF objects with AArch64 ELF objects. vmlinuz.o only contains
> > > a compressed blob in an ELF data section, and more modern toolchains
> > > have no issue with this at all.
> > >
> > > Given that building allyesconfig with fairly outdated toolchains is
> > > not something anyone is likely to obsess about, I don't have a strong
> > > preference as to how we work around this, put perhaps the easiest
> > > approach would be for CONFIG_EFI_ZBOOT to depend on !CONFIG_LD_IS_BFD
> > > || CONFIG_LD_VERSION >= 23xxx here? (We'll need to check the exact
> > > version)
> >
> > That sounds reasonable to me.
> >
>
> This is not reproducible with ld.bfd built from the upstream sources
>
> $ ~/build/binutils-build-aarch64/ld/ld-new -v
> GNU ld (GNU Binutils) 2.30
>
> $ ~/build/binutils-build-aarch64/ld/ld-new -EL  -maarch64elf -z
> noexecstack -T /usr/local/google/home/ardb/linux/drivers/firmware/efi/libstub/zboot.lds
> arch/arm64/boot/vmlinuz.o arch/arm64/boot/zboot-header.o
> drivers/firmware/efi/libstub/lib.a -o arch/arm64/boot/vmlinuz.efi.elf
>
> $ file arch/arm64/boot/vmlinuz.efi.elf
> arch/arm64/boot/vmlinuz.efi.elf: ELF 64-bit LSB executable, ARM
> aarch64, version 1 (SYSV), statically linked, with debug_info, not
> stripped
>
> So this could be an issue in Ubuntu's downstream fork, in which case I
> don't think we should do anything about it.

Thanks, I will follow up and check if this is really something
specific in the Ubuntu fork or if it appears only with very selected
binutils versions.

Lukas
