Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADBA59A87D
	for <lists+linux-efi@lfdr.de>; Sat, 20 Aug 2022 00:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241857AbiHSWXK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 19 Aug 2022 18:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241663AbiHSWXI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 19 Aug 2022 18:23:08 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2887210E967
        for <linux-efi@vger.kernel.org>; Fri, 19 Aug 2022 15:23:07 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so6127910pjl.0
        for <linux-efi@vger.kernel.org>; Fri, 19 Aug 2022 15:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=DiD4CnpJAqNu3hqPGqLHXBPJRdRKzJcEPRfsf06JCts=;
        b=C0XkBg5lC40VWkVP+ckZwjH7A4M2qY5jtWG3UWq2hux6RGM0Kska2H/PBT8sQ2YQzh
         jrJlCcgxHphGXj/1GF59/Zy71pqOP1s+ArzOefwSfj1+se9tseNvdUd80knbjmeQDwzk
         ZCnrbVhQ0H6eCP991aFgio7QjAj036jk8g5d4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=DiD4CnpJAqNu3hqPGqLHXBPJRdRKzJcEPRfsf06JCts=;
        b=RhzU9WOLomxaEgwYITu9E5iArvj6xKqFw5hKcmbjDw7MoeClVcDFmOMraD9xBaUMGM
         xXozPYzs2+XKF4ea7DaPpd16Ah0oNMrI7eOFkqFs2RvO30VteCfUELXu9Hfgg3hi2/Go
         07a+7TJOjXrLjAIjBV8iacWF9YTmp9UYvhrF/CDC18ptao4Na3M556rilSBtzi+qyjAA
         UAv1rRPRdljknXqxYlmVvHC7JQPtlUzYTtyq5Jj1ymtAcqfDT20TL8r5zwArL7rpW5yo
         wMO+TNMRWsFEf3Dz6u32TxKu07X6Zj9Vi++QxZKvBHOlYMwNzq/FCyOXciIp/sAKdp6X
         WGcg==
X-Gm-Message-State: ACgBeo0uttPdtbwJA6cROnvH81p0AbhpeSXtzXk8NN6GwJ9AAdXBEW/j
        rpzRfpOB1DRGbnGrgAuchQyk1NqBNHe9aA==
X-Google-Smtp-Source: AA6agR4xt1/JLnfBFhIhhTYwMX9CD+eAl4nblxQAkiFTGBaps9PRk5Wj3EobXD8t3+a694ymdUOiNw==
X-Received: by 2002:a17:902:b58a:b0:16e:f91a:486b with SMTP id a10-20020a170902b58a00b0016ef91a486bmr9816941pls.119.1660947786589;
        Fri, 19 Aug 2022 15:23:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v31-20020a63481f000000b004277f43b736sm3204677pga.92.2022.08.19.15.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 15:23:05 -0700 (PDT)
Date:   Fri, 19 Aug 2022 15:23:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Daniel Marth <daniel.marth@inso.tuwien.ac.at>,
        linux-efi@vger.kernel.org, clemens.hlauschek@inso.tuwien.ac.at
Subject: Re: [PATCH] efi/libstub: Disable RNG structure randomization
Message-ID: <202208191519.6C4804CA53@keescook>
References: <20220818065635.243057-1-daniel.marth@inso.tuwien.ac.at>
 <CAMj1kXHEODYxkafLgTA83gYqJV+jFxOopWgJJNsURCVjbHR6Uw@mail.gmail.com>
 <202208180858.70C1B5A@keescook>
 <CAMj1kXHyV1+ttxaWrsY1xitBRUfoXobv-Cv0+a6P=Zs9Rhsfag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHyV1+ttxaWrsY1xitBRUfoXobv-Cv0+a6P=Zs9Rhsfag@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Aug 18, 2022 at 06:12:55PM +0200, Ard Biesheuvel wrote:
> On Thu, 18 Aug 2022 at 18:02, Kees Cook <keescook@chromium.org> wrote:
> >
> > On Thu, Aug 18, 2022 at 09:10:23AM +0200, Ard Biesheuvel wrote:
> > > (cc Kees)
> > >
> > > On Thu, 18 Aug 2022 at 08:58, Daniel Marth
> > > <daniel.marth@inso.tuwien.ac.at> wrote:
> > > >
> > > > Randstruct by default randomizes structures that consist entirely of
> > > > function pointers, even if they are not explicitly labeled for
> > > > randomization. efi_rng_protocol contains an anonymous structure that is
> > > > affected by this implicit selection process. Randomization of this
> > > > structure causes a data layout inconsistency between the kernel and the
> > > > EFI. In this scenario the Arm64 boot process fails with the following
> > > > output:
> > > >     EFI stub: Booting Linux Kernel...
> > > >     EFI stub: ERROR: efi_get_random_bytes() failed (0x8000000000000002)
> > > >     EFI stub: Using DTB from configuration table
> > > >     EFI stub: Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path
> > > >     Synchronous Exception at 0x0000000081310C90
> > > >     Synchronous Exception at 0x0000000081310C90
> > > >
> > > > efi_get_random_bytes() fails in handle_kernel_image (arm64-stub.c)
> > > > because it uses an incorrect structure layout for efi_call_proto. Add
> > > > the __no_randomize_layout annotation to the anonymous structure within
> > > > efi_rng_protocol to prevent its randomization and resolve this issue.
> > > >
> > > > This patch was tested for the Arm64 architecture using QEMU. In
> > > > addition to the current next branch of this subsystem, also minor
> > > > versions 4.16 to 5.1, 5.5 and 5.6 were tested successfully with a
> > > > (backported) version of this patch.
> > > >
> > > > Signed-off-by: Daniel Marth <daniel.marth@inso.tuwien.ac.at>
> > >
> > > Thanks for the patch.
> > >
> > > > ---
> > > >  drivers/firmware/efi/libstub/random.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/firmware/efi/libstub/random.c b/drivers/firmware/efi/libstub/random.c
> > > > index 24aa37535372..54fa980cf1af 100644
> > > > --- a/drivers/firmware/efi/libstub/random.c
> > > > +++ b/drivers/firmware/efi/libstub/random.c
> > > > @@ -18,7 +18,7 @@ union efi_rng_protocol {
> > > >                 efi_status_t (__efiapi *get_rng)(efi_rng_protocol_t *,
> > > >                                                  efi_guid_t *, unsigned long,
> > > >                                                  u8 *out);
> > > > -       };
> > > > +       } __no_randomize_layout;
> > > >         struct {
> > > >                 u32 get_info;
> > > >                 u32 get_rng;
> > >
> > > This may work around the problem, but I'd like to fix this more
> > > thoroughly if we can. EFI protocols are not randomizable by nature, as
> > > they are a contract between the firmware and the OS, so struct
> > > randomization should just be disabled for the entire EFI stub, i.e.,
> > > everything below libstub/
> >
> > So, yeah, any external interface that uses function pointer tables
> > needs to be marked as not randomized. I think disabling randstruct for
> > the entire subdirectory may run into a reverse problem, if anything gets
> > used in there that is randomized by the rest of the kernel. I'm not clear
> > where there boundaries are on that, though, so I leave it up to your
> > judgement. IMO, it seems cleanest to just mark any all-function-pointer
> > structs as __no_randomize_layout.
> >
> 
> But there are *lots* of those, and this makes it a moving target as well.
> 
> The handover from EFI to the kernel proper passes very little state,
> so turning it off in the stub should not be an issue afaict.
> 
> What would be even better is a pragma push/pop that disables it for
> all type definitions in between, Did anyone ever look into that?

I don't know if that got looked at -- there wasn't a place where such a
mixture was needed before. Everywhere else just marks individual
structs. Places like vDSO do stuff like this for their Makefile:

KBUILD_CFLAGS := $(filter-out $(RANDSTRUCT_CFLAGS),$(KBUILD_CFLAGS))

-- 
Kees Cook
