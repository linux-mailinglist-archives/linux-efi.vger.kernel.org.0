Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2DF7CC1E4
	for <lists+linux-efi@lfdr.de>; Tue, 17 Oct 2023 13:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbjJQLi0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Oct 2023 07:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbjJQLiZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Oct 2023 07:38:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB809B0
        for <linux-efi@vger.kernel.org>; Tue, 17 Oct 2023 04:38:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52AD7C433C8
        for <linux-efi@vger.kernel.org>; Tue, 17 Oct 2023 11:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697542704;
        bh=a6D+vVIjtPGGx/qPwLloAsxsEfysf8nmXEbK95qgMCs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KQwTdei/gujCLO1ECvVx14q+AwI4gVqYPsSk/3El1aIZ4MzGCt2UQFKJrqjagkEkJ
         CJepFfvOsuv7XjZs6RT35Bxef873mecX9fEsdHjpzX7jX2HYxfgfbWhJ7VYcu0kCEc
         77C58aU39b8V5ntR/QlEn+CjpLaVKO61pdaH7mQ7lCTKh6LfNqeG2IijC7A8qklXZr
         jzTGledvbJS57oCrLNtrg/+gWXlN9x2t+rujUsEoBNdXxbFJe3X0pevns07CoZCvSC
         T1NnYKOaFdMNHAAUuqxqiAGIVFYjoGVnJGB1LUvN5tHJuA2FIL28LgaELp2IeHW+1V
         cpiW+locBylmw==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2c5071165d5so42781621fa.0
        for <linux-efi@vger.kernel.org>; Tue, 17 Oct 2023 04:38:24 -0700 (PDT)
X-Gm-Message-State: AOJu0YxFT4WcG7dBhT5LeO0O7lN1EEIUapGzXst9Xnp5cSvIRZwZCbXc
        C9qQ4RL4ju1yuSE7F9HnZ1THy3aceIgN2PBr90w=
X-Google-Smtp-Source: AGHT+IHA5JFcCW5qOD/kn+RcMpum+WgBntTTIXBeKr825TxxqyK4ktKA7u4+fTQbpIanIlAAk/QiuRb13eCqH3srHDI=
X-Received: by 2002:a2e:a7ca:0:b0:2b9:3684:165 with SMTP id
 x10-20020a2ea7ca000000b002b936840165mr1776675ljp.8.1697542702569; Tue, 17 Oct
 2023 04:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231016164634.3514517-2-ardb@google.com> <CAMj1kXFootPaQJTYTFoRWido1Fn_trmT2u42hdPOjP+=8D0H_g@mail.gmail.com>
 <ZS5xTR/7jgUHZXb3@gmail.com>
In-Reply-To: <ZS5xTR/7jgUHZXb3@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 17 Oct 2023 13:38:11 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFcA+VgChYtWH+LW106hhotW60O_K406kEzO9jeVAd02A@mail.gmail.com>
Message-ID: <CAMj1kXFcA+VgChYtWH+LW106hhotW60O_K406kEzO9jeVAd02A@mail.gmail.com>
Subject: Re: [PATCH] x86/boot: efistub: Assign global boot_params variable
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Ard Biesheuvel <ardb@google.com>, linux-efi@vger.kernel.org,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 17 Oct 2023 at 13:34, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ard Biesheuvel <ardb@kernel.org> wrote:
>
> > On Mon, 16 Oct 2023 at 18:46, Ard Biesheuvel <ardb@google.com> wrote:
> > >
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > Now that the x86 EFI stub calls into some APIs exposed by the
> > > decompressor (e.g., kaslr_get_random_long()), it is necessary to ensure
> > > that the global boot_params variable is set correctly before doing so.
> > >
> > > Note that the decompressor and the kernel proper carry conflicting
> > > declarations for the global variable 'boot_params' so refer to it via an
> > > alias to work around this.
> > >
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  drivers/firmware/efi/libstub/x86-stub.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> > > index 3bfc59637dd1..51407207ded5 100644
> > > --- a/drivers/firmware/efi/libstub/x86-stub.c
> > > +++ b/drivers/firmware/efi/libstub/x86-stub.c
> > > @@ -812,12 +812,15 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
> > >                                efi_system_table_t *sys_table_arg,
> > >                                struct boot_params *boot_params)
> > >  {
> > > +       extern struct boot_params *bpp asm("boot_params");
> >
> > I am getting hatemail from the bots about this extern declaration, so
> > I will move that into x86-stub.h.
>
> Hm, it would be better if we moved all of x86-stub.h into
> arch/x86/include/asm/ or so. We don't really encourage "deep" driver-level
> exports like that, and there's little reason why this couldn't be in the
> x86 headers, right?
>

Yes, there is.

arch/x86/boot/compressed/misc.h:extern struct boot_params *boot_params;
arch/x86/include/asm/setup.h:extern struct boot_params boot_params;

Ideally, we should get rid of the first one.

Happy to send a patch that replaces all conflicting uses in the
decompressor, so we can just access the global pointer without these
tricks. But I'd like to get the fix in for v6.6 in any case.


> > Unless anyone minds, I'll queue this up and send it to Linus myself
> > via the EFI fixes branch.
>
> Other than the above:
>
>   Acked-by: Ingo Molnar <mingo@kernel.org>
>
