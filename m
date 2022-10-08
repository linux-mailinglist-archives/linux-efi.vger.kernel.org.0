Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5935F85EA
	for <lists+linux-efi@lfdr.de>; Sat,  8 Oct 2022 17:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiJHPmA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 8 Oct 2022 11:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJHPl7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 8 Oct 2022 11:41:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E153C4D83E;
        Sat,  8 Oct 2022 08:41:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A438260A10;
        Sat,  8 Oct 2022 15:41:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B32C433D6;
        Sat,  8 Oct 2022 15:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665243714;
        bh=pqdz3EMxHLx2klClLHAluO+zAB1gLQpkfWDMOnPcE2w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q8RhS+zPL+HsqvlVs1olK3Ld8fFmb4msg5xhM9038ZZ+hYf7/eP6T7cFhSGdLAQBe
         zeElTRN7xLfiyNoabJ6jg5oAXnER0mS0p8272M+uUNcX9o1emfL9L0H9bF6lJ57KT+
         Gcc8IpB05qXBLlVpXXeNSf793T+W3K4Bp/VGcPi1dCaE0MHcvxxDm/rONekko+eaua
         BAyswNIN8D6vwi+2/qba6k0M1SKMu1eyXqTeZ7Rv1MsSQ2hAppA/t7zG+r488dTWet
         cJfxQlOEhQIrVQbRSoiGzAN2KKXcRYH4zNdRGUhqVdLEiJFrD+DfWx/2lCKbbbtLJz
         PRWFxh63VbKLw==
Received: by mail-lj1-f182.google.com with SMTP id j23so8668679lji.8;
        Sat, 08 Oct 2022 08:41:53 -0700 (PDT)
X-Gm-Message-State: ACrzQf3TWnzBHf/DozEDuNOjVr3QpS8PshQEX/Fo86gqW+wgvapIoX/Z
        rtDbDjI9Zsld9UdAodee/c5/8+Ht7tWosNIv/6g=
X-Google-Smtp-Source: AMsMyM7FoZYIu1zw1iegPCfi6oREofjmEvD7Eh/ImyH2cnAj9FsXkWgQ/v3sq8c0wSjCVeHC98Tc6Lxz5khPtUpi+Ls=
X-Received: by 2002:a05:651c:b13:b0:26c:679f:ea66 with SMTP id
 b19-20020a05651c0b1300b0026c679fea66mr3818845ljr.516.1665243711945; Sat, 08
 Oct 2022 08:41:51 -0700 (PDT)
MIME-Version: 1.0
References: <20221007172918.3131811-1-ardb@kernel.org> <Y0GOKnD89SOjGzCf@nazgul.tnic>
In-Reply-To: <Y0GOKnD89SOjGzCf@nazgul.tnic>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 8 Oct 2022 17:41:40 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHK_9iDT8CSHnZ15yB+Z=+haZXjbQ99m20jQUr0NScK4Q@mail.gmail.com>
Message-ID: <CAMj1kXHK_9iDT8CSHnZ15yB+Z=+haZXjbQ99m20jQUr0NScK4Q@mail.gmail.com>
Subject: Re: [PATCH] efi: x86: Make the deprecated EFI handover protocol optional
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 8 Oct 2022 at 16:51, Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Oct 07, 2022 at 07:29:18PM +0200, Ard Biesheuvel wrote:
> > Given that loaders such as GRUB already carried the bootparams handling
> > in order to implement non-EFI boot, retaining that code and just passing
> > bootparams to the EFI stub was a reasonable choice (although defining an
> > alternate entrypoint could have been avoided.) However, the GRUB side
> > changes never made it upstream, and are only shipped by some of the
>           ^^^^^^^^^^^^^^^^^^^^^^^
>
> > distros in their downstream versions.
>
> Gotta love that bit particularly. :-(
>

Yeah most distros have ~100 ore more patches against GRUB, but this
isn't actually their fault. GRUB maintainership was defunct for a
number of years, which is why we were stuck on GRUB version 2.02-beta3
for such a long time. But in recent years, things have been getting
better, and there is an agreement with the current maintainer not to
merge the EFI handover protocol, and merge the new EFI protocol based
initrd loading method instead, which works on all architectures
instead of only on x86.

> > In the meantime, EFI support has been added to other Linux architecture
> > ports, as well as to U-boot and systemd, including arch-agnostic methods
> > for passing initrd images in memory [1], and for doing mixed mode boot
> > [2], none of them requiring anything like the EFI handover protocol. So
> > given that only out-of-tree distro GRUB relies on this, let's permit it
> > to be omitted from the build, in preparation for retiring it completely
> > at a later date. (Note that systemd-boot does have an implementation as
> > well, but only uses it as a fallback for booting images that do not
> > implement the LoadFile2 based initrd loading method, i.e., v5.8 or older)
> >
> > [0] https://lore.kernel.org/all/20220927085842.2860715-1-ardb@kernel.org/
> > [1] ec93fc371f01 ("efi/libstub: Add support for loading the initrd ...")
> > [2] 97aa276579b2 ("efi/x86: Add true mixed mode entry point into ...")
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/Kconfig                   | 12 ++++++++++++
> >  arch/x86/boot/compressed/head_64.S |  4 +++-
> >  arch/x86/boot/header.S             |  2 +-
> >  arch/x86/boot/tools/build.c        |  2 ++
> >  4 files changed, 18 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index f9920f1341c8..0c8fcb090232 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -1964,6 +1964,18 @@ config EFI_STUB
> >
> >         See Documentation/admin-guide/efi-stub.rst for more information.
> >
> > +config EFI_HANDOVER_PROTOCOL
> > +     bool "EFI handover protocol (DEPRECATED)"
> > +     depends on EFI_STUB
> > +     default y
>
> I'd say "default n" here.
>

I'd rather not - see below.

> > +     help
> > +       Whether to include support for the deprecated EFI handover protocol,
>
> "Select this in order to include..."
>

OK

> > +       which defines alternative entry points into the EFI stub. This is a
> > +       practice that has no basis in the UEFI specification, and requires
> > +       a priori knowledge on the part of the bootloader about Linux/x86
> > +       specific ways of passing the command line and initrd, and where in
> > +       memory those assets may be loaded.
>
>         "If in doubt, say N. This option and accompanying code will disappear
>         in some future kernel as the corresponding GRUB support is not even
>         present in upstream GRUB but only in some distros' versions."
>

I'll adopt some of that thanks.

> > +
> >  config EFI_MIXED
> >       bool "EFI mixed-mode support"
> >       depends on EFI_STUB && X86_64
> > diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> > index 6ba2c2142c33..7bcc50c6cdcc 100644
> > --- a/arch/x86/boot/compressed/head_64.S
> > +++ b/arch/x86/boot/compressed/head_64.S
> > @@ -286,7 +286,7 @@ SYM_FUNC_START(startup_32)
> >       lret
> >  SYM_FUNC_END(startup_32)
> >
> > -#ifdef CONFIG_EFI_MIXED
> > +#if defined(CONFIG_EFI_MIXED) && defined(CONFIG_EFI_HANDOVER_PROTOCOL)
>
> ...
>
> Can we use IS_ENABLED() in all that instead, in order to improve
> readability?
>

Never tried that in .S files but I guess it should just work.

> In any case, looks good. I'm thinking I'll take it into tip after -rc1
> and see who cries and why...
>

I'd venture a guess that this will break the boot even your own x86
boxes, given that almost nobody uses plain upstream GRUB..

I can work with the distros directly to start disabling this in their
downstream configs once their GRUB builds are up to date with the new
changes, so we can phase this out in a controlled manner. But
disabling tthis right now by default is going to affect everyone who
builds their own kernels and runs them on a distro Linux install.
