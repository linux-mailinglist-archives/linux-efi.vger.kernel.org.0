Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22F559883C
	for <lists+linux-efi@lfdr.de>; Thu, 18 Aug 2022 18:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344521AbiHRQCG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Aug 2022 12:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245721AbiHRQCF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 Aug 2022 12:02:05 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E61BB690
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 09:02:04 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id y4so1886477plb.2
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 09:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=3Q9ipa0LbqYDAkps/A1qMcRSXnqz9OkfOFTOgyNixRg=;
        b=ae84SrXcnIcWp9jQx27sWNuDHKbRWTLVQgEp22etOqyD0xFH0Puj8PMMXnpYGv5j34
         is/omr8m352dMviVWe37JM59Ufcd5orZUuQYSUSmAd1Lu8Kh+HUjUQELaOjdlgibeTi9
         CB6DdaSADXr1mJBV3A0pZ6hQy8joUg2kP47rE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=3Q9ipa0LbqYDAkps/A1qMcRSXnqz9OkfOFTOgyNixRg=;
        b=QZ70rSy4/mHct9RcucoAOjifLGw6ScemIRh1bo64cNFMxRI92hSHj0j1Y3SKD1lqte
         OvRCtbdz0oayhOcnoajNf+c/7slFsMY6Wm7XbyMiYPjLnE8dACc0yYPnAq2LfL6DIskv
         o+FbGkIBP3NidXHtGFsloewtV9DEqUHWS1VN5ywJxef/EsLORRSH+/eFxdPidizQSBMF
         NKYabBpLUhtldr687GlJmHfoKMe9x8W0DyMi6v3xakOJaUCw/uloeeuayW75ZrfluaRB
         dA/lwPePy5RCE4nTV/1i/2oCCH7pg5jByUca9fAAb19kLB7Nh/e5xxJIYzUXxjnWzyUU
         /6Dg==
X-Gm-Message-State: ACgBeo1z3wERVpD40Rm5YYhG1ShwoQnDtyMKPOCZJ39MdWC57rEUly+O
        XwHjlbTIcOMLGmWhbotRx6BufezydtjQqg==
X-Google-Smtp-Source: AA6agR5jNm6p7WGS93qAO7N8AlMtachooE0Lhkp3KVdV56uwd7eVKG+oBzt9TnPlwsLbJt2FtnfdKQ==
X-Received: by 2002:a17:902:7e43:b0:170:cc72:5176 with SMTP id a3-20020a1709027e4300b00170cc725176mr3202334pln.1.1660838524371;
        Thu, 18 Aug 2022 09:02:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n28-20020aa7985c000000b0052e6854e665sm1816464pfq.109.2022.08.18.09.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 09:02:03 -0700 (PDT)
Date:   Thu, 18 Aug 2022 09:02:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Daniel Marth <daniel.marth@inso.tuwien.ac.at>,
        linux-efi@vger.kernel.org, clemens.hlauschek@inso.tuwien.ac.at
Subject: Re: [PATCH] efi/libstub: Disable RNG structure randomization
Message-ID: <202208180858.70C1B5A@keescook>
References: <20220818065635.243057-1-daniel.marth@inso.tuwien.ac.at>
 <CAMj1kXHEODYxkafLgTA83gYqJV+jFxOopWgJJNsURCVjbHR6Uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHEODYxkafLgTA83gYqJV+jFxOopWgJJNsURCVjbHR6Uw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Aug 18, 2022 at 09:10:23AM +0200, Ard Biesheuvel wrote:
> (cc Kees)
> 
> On Thu, 18 Aug 2022 at 08:58, Daniel Marth
> <daniel.marth@inso.tuwien.ac.at> wrote:
> >
> > Randstruct by default randomizes structures that consist entirely of
> > function pointers, even if they are not explicitly labeled for
> > randomization. efi_rng_protocol contains an anonymous structure that is
> > affected by this implicit selection process. Randomization of this
> > structure causes a data layout inconsistency between the kernel and the
> > EFI. In this scenario the Arm64 boot process fails with the following
> > output:
> >     EFI stub: Booting Linux Kernel...
> >     EFI stub: ERROR: efi_get_random_bytes() failed (0x8000000000000002)
> >     EFI stub: Using DTB from configuration table
> >     EFI stub: Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path
> >     Synchronous Exception at 0x0000000081310C90
> >     Synchronous Exception at 0x0000000081310C90
> >
> > efi_get_random_bytes() fails in handle_kernel_image (arm64-stub.c)
> > because it uses an incorrect structure layout for efi_call_proto. Add
> > the __no_randomize_layout annotation to the anonymous structure within
> > efi_rng_protocol to prevent its randomization and resolve this issue.
> >
> > This patch was tested for the Arm64 architecture using QEMU. In
> > addition to the current next branch of this subsystem, also minor
> > versions 4.16 to 5.1, 5.5 and 5.6 were tested successfully with a
> > (backported) version of this patch.
> >
> > Signed-off-by: Daniel Marth <daniel.marth@inso.tuwien.ac.at>
> 
> Thanks for the patch.
> 
> > ---
> >  drivers/firmware/efi/libstub/random.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/efi/libstub/random.c b/drivers/firmware/efi/libstub/random.c
> > index 24aa37535372..54fa980cf1af 100644
> > --- a/drivers/firmware/efi/libstub/random.c
> > +++ b/drivers/firmware/efi/libstub/random.c
> > @@ -18,7 +18,7 @@ union efi_rng_protocol {
> >                 efi_status_t (__efiapi *get_rng)(efi_rng_protocol_t *,
> >                                                  efi_guid_t *, unsigned long,
> >                                                  u8 *out);
> > -       };
> > +       } __no_randomize_layout;
> >         struct {
> >                 u32 get_info;
> >                 u32 get_rng;
> 
> This may work around the problem, but I'd like to fix this more
> thoroughly if we can. EFI protocols are not randomizable by nature, as
> they are a contract between the firmware and the OS, so struct
> randomization should just be disabled for the entire EFI stub, i.e.,
> everything below libstub/

So, yeah, any external interface that uses function pointer tables
needs to be marked as not randomized. I think disabling randstruct for
the entire subdirectory may run into a reverse problem, if anything gets
used in there that is randomized by the rest of the kernel. I'm not clear
where there boundaries are on that, though, so I leave it up to your
judgement. IMO, it seems cleanest to just mark any all-function-pointer
structs as __no_randomize_layout.

-Kees

-- 
Kees Cook
