Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BECB598867
	for <lists+linux-efi@lfdr.de>; Thu, 18 Aug 2022 18:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245254AbiHRQNP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Aug 2022 12:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245298AbiHRQNO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 Aug 2022 12:13:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4072A1E0
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 09:13:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00BF2B821CE
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 16:13:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCCF3C433C1
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 16:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660839188;
        bh=XcpBXwwl4SOGotnFjEbVIV3MoDP6U+Fevr0OINGNPsg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ezww04zJT4YGXzl5TUYbOdDfD5i65Kz3X8WPw/L4papga3IsiiNIeagpDv6452twK
         JJLIJ18373Wd0nJWlL+tJEJZmhFG0adzJ+xU1p+UogMcHVhHphvrBUuWKZ0alzZy+w
         /7+4mRIPQpk2rHkYV04ywOzrWa/XnyvG+1UaXE0hGFu+3c8MikFR3Rn04dvJy5iYLY
         mCfkobO3kiE6Hw728F29eZ1zq5S8QnmshdkuZBq5SaqmVanMLDdNkDz/owB1jO005M
         ck0k0m+cFcauCm3aB4yFHP0PArGa1ctaC7lupsnmYQ/B33eB37A5g3lXzYjO7Ep74T
         8wvrDc/9cbudA==
Received: by mail-wm1-f51.google.com with SMTP id v7-20020a1cac07000000b003a6062a4f81so2835432wme.1
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 09:13:08 -0700 (PDT)
X-Gm-Message-State: ACgBeo3BWWapkyvjnqzMKcfFblZGLlYeahEMDGasvDvBE9FrJpr9rHcN
        xn8MnUU4qizPPKClz/flG3rq4lW3SlPPB7A2dMQ=
X-Google-Smtp-Source: AA6agR6zrv9FHDtJGsSehNeGK4bN1YxXAJ6Ik4rL5pktD1nCj9ULRcIsst6u93yjmjhcRodYOcpHmo/F7x/D/PNJ6aY=
X-Received: by 2002:a1c:a3c4:0:b0:3a5:512f:717a with SMTP id
 m187-20020a1ca3c4000000b003a5512f717amr5572232wme.192.1660839186990; Thu, 18
 Aug 2022 09:13:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220818065635.243057-1-daniel.marth@inso.tuwien.ac.at>
 <CAMj1kXHEODYxkafLgTA83gYqJV+jFxOopWgJJNsURCVjbHR6Uw@mail.gmail.com> <202208180858.70C1B5A@keescook>
In-Reply-To: <202208180858.70C1B5A@keescook>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 18 Aug 2022 18:12:55 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHyV1+ttxaWrsY1xitBRUfoXobv-Cv0+a6P=Zs9Rhsfag@mail.gmail.com>
Message-ID: <CAMj1kXHyV1+ttxaWrsY1xitBRUfoXobv-Cv0+a6P=Zs9Rhsfag@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: Disable RNG structure randomization
To:     Kees Cook <keescook@chromium.org>
Cc:     Daniel Marth <daniel.marth@inso.tuwien.ac.at>,
        linux-efi@vger.kernel.org, clemens.hlauschek@inso.tuwien.ac.at
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 18 Aug 2022 at 18:02, Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Aug 18, 2022 at 09:10:23AM +0200, Ard Biesheuvel wrote:
> > (cc Kees)
> >
> > On Thu, 18 Aug 2022 at 08:58, Daniel Marth
> > <daniel.marth@inso.tuwien.ac.at> wrote:
> > >
> > > Randstruct by default randomizes structures that consist entirely of
> > > function pointers, even if they are not explicitly labeled for
> > > randomization. efi_rng_protocol contains an anonymous structure that is
> > > affected by this implicit selection process. Randomization of this
> > > structure causes a data layout inconsistency between the kernel and the
> > > EFI. In this scenario the Arm64 boot process fails with the following
> > > output:
> > >     EFI stub: Booting Linux Kernel...
> > >     EFI stub: ERROR: efi_get_random_bytes() failed (0x8000000000000002)
> > >     EFI stub: Using DTB from configuration table
> > >     EFI stub: Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path
> > >     Synchronous Exception at 0x0000000081310C90
> > >     Synchronous Exception at 0x0000000081310C90
> > >
> > > efi_get_random_bytes() fails in handle_kernel_image (arm64-stub.c)
> > > because it uses an incorrect structure layout for efi_call_proto. Add
> > > the __no_randomize_layout annotation to the anonymous structure within
> > > efi_rng_protocol to prevent its randomization and resolve this issue.
> > >
> > > This patch was tested for the Arm64 architecture using QEMU. In
> > > addition to the current next branch of this subsystem, also minor
> > > versions 4.16 to 5.1, 5.5 and 5.6 were tested successfully with a
> > > (backported) version of this patch.
> > >
> > > Signed-off-by: Daniel Marth <daniel.marth@inso.tuwien.ac.at>
> >
> > Thanks for the patch.
> >
> > > ---
> > >  drivers/firmware/efi/libstub/random.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/firmware/efi/libstub/random.c b/drivers/firmware/efi/libstub/random.c
> > > index 24aa37535372..54fa980cf1af 100644
> > > --- a/drivers/firmware/efi/libstub/random.c
> > > +++ b/drivers/firmware/efi/libstub/random.c
> > > @@ -18,7 +18,7 @@ union efi_rng_protocol {
> > >                 efi_status_t (__efiapi *get_rng)(efi_rng_protocol_t *,
> > >                                                  efi_guid_t *, unsigned long,
> > >                                                  u8 *out);
> > > -       };
> > > +       } __no_randomize_layout;
> > >         struct {
> > >                 u32 get_info;
> > >                 u32 get_rng;
> >
> > This may work around the problem, but I'd like to fix this more
> > thoroughly if we can. EFI protocols are not randomizable by nature, as
> > they are a contract between the firmware and the OS, so struct
> > randomization should just be disabled for the entire EFI stub, i.e.,
> > everything below libstub/
>
> So, yeah, any external interface that uses function pointer tables
> needs to be marked as not randomized. I think disabling randstruct for
> the entire subdirectory may run into a reverse problem, if anything gets
> used in there that is randomized by the rest of the kernel. I'm not clear
> where there boundaries are on that, though, so I leave it up to your
> judgement. IMO, it seems cleanest to just mark any all-function-pointer
> structs as __no_randomize_layout.
>

But there are *lots* of those, and this makes it a moving target as well.

The handover from EFI to the kernel proper passes very little state,
so turning it off in the stub should not be an issue afaict.

What would be even better is a pragma push/pop that disables it for
all type definitions in between, Did anyone ever look into that?
