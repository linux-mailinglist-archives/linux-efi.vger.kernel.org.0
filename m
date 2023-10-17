Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C597CC1DB
	for <lists+linux-efi@lfdr.de>; Tue, 17 Oct 2023 13:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbjJQLen (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Oct 2023 07:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjJQLen (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Oct 2023 07:34:43 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24E19F
        for <linux-efi@vger.kernel.org>; Tue, 17 Oct 2023 04:34:41 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-533c5d10dc7so9703849a12.3
        for <linux-efi@vger.kernel.org>; Tue, 17 Oct 2023 04:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697542480; x=1698147280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uNRXCDS+1kS04nSeQjDsAcopmjzX/BZFWRiFafVAFRQ=;
        b=F1Fgu6hH3LRm0YEUGMwb4y00bcOdKrLveoPtHwNKVMXIcqoiHtp8IOy4sK7voKvLNH
         TjZbKqk5JWhDCEysn6reeyHk9ucCk04fS7KM1HbWdFhllqO1pxrBMLY8UAo2D9DVrHZo
         i3qc9Cl6CgSLXoFqQ283rNXxfDHCT157VU9ObANCHg7j/byYMlTG2LL+2Bh6BN8ITFiw
         uZ3BhrZ4k7ekuIoOZ3VA7Fhpth8cOEzd+2Gr2HDCwpbiucYoBoPtz7A0PTKlbRXR1gcw
         Cc6A1hT15h8AjtE5gpZUpmGDsbkV2C8Nf2RC3H1OqENHNKZTqZIS5X2iq3YKoL+vBZDV
         l9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697542480; x=1698147280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uNRXCDS+1kS04nSeQjDsAcopmjzX/BZFWRiFafVAFRQ=;
        b=RlIECDCckd+O+WzpjcPSvt0MWX0RKCeiGJCu+jcud068dBdDnCPl+zP767DFVQsQ1s
         +CrFZo2cwd/6unpN1qPmpyXGdjLbA9sOUEMVTHJ57eO0Qb8hUfMdCipv7sRURunpsxGQ
         a+iAZK4CmraCO1rUONvPI0KwA0qIyy1hfQSpfPRkyAQXxFUZD/840tTVZTibhFTBdkD+
         aWE1gXQ4fd5IBSw5jX6giBwzzPs3To/W+tWHxsRnrJqbK5HY40F3CR0hUlmoZe4653iU
         pVCUKa9dGEcFVDGnfQy+FfLR2Rmz5cXh+/hX2o2RQQnCxuaWnlV+PIcV5vLh6c210qJ1
         kR6g==
X-Gm-Message-State: AOJu0YyjEPFKMq7FfG25LlC44k7s/XAxbTz8Kv2OkknFKX+BCORJHiQZ
        RJ16wHTYoCGoJHbz1OHYU1E=
X-Google-Smtp-Source: AGHT+IEAo/HZv062VBc10miBt7Q2Eq5w9iXzn6PEJYOMdrM2zYJT5131BeRxUFbbueEE7wMOC4Txxg==
X-Received: by 2002:a17:907:706:b0:9b2:be5e:7545 with SMTP id xb6-20020a170907070600b009b2be5e7545mr1448928ejb.36.1697542479983;
        Tue, 17 Oct 2023 04:34:39 -0700 (PDT)
Received: from gmail.com (1F2EF7B2.nat.pool.telekom.hu. [31.46.247.178])
        by smtp.gmail.com with ESMTPSA id lg24-20020a170906f89800b009c3f8f46c22sm1100580ejb.77.2023.10.17.04.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 04:34:39 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 17 Oct 2023 13:34:37 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Ard Biesheuvel <ardb@google.com>, linux-efi@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH] x86/boot: efistub: Assign global boot_params variable
Message-ID: <ZS5xTR/7jgUHZXb3@gmail.com>
References: <20231016164634.3514517-2-ardb@google.com>
 <CAMj1kXFootPaQJTYTFoRWido1Fn_trmT2u42hdPOjP+=8D0H_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFootPaQJTYTFoRWido1Fn_trmT2u42hdPOjP+=8D0H_g@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Ard Biesheuvel <ardb@kernel.org> wrote:

> On Mon, 16 Oct 2023 at 18:46, Ard Biesheuvel <ardb@google.com> wrote:
> >
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Now that the x86 EFI stub calls into some APIs exposed by the
> > decompressor (e.g., kaslr_get_random_long()), it is necessary to ensure
> > that the global boot_params variable is set correctly before doing so.
> >
> > Note that the decompressor and the kernel proper carry conflicting
> > declarations for the global variable 'boot_params' so refer to it via an
> > alias to work around this.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  drivers/firmware/efi/libstub/x86-stub.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> > index 3bfc59637dd1..51407207ded5 100644
> > --- a/drivers/firmware/efi/libstub/x86-stub.c
> > +++ b/drivers/firmware/efi/libstub/x86-stub.c
> > @@ -812,12 +812,15 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
> >                                efi_system_table_t *sys_table_arg,
> >                                struct boot_params *boot_params)
> >  {
> > +       extern struct boot_params *bpp asm("boot_params");
> 
> I am getting hatemail from the bots about this extern declaration, so
> I will move that into x86-stub.h.

Hm, it would be better if we moved all of x86-stub.h into 
arch/x86/include/asm/ or so. We don't really encourage "deep" driver-level 
exports like that, and there's little reason why this couldn't be in the 
x86 headers, right?

> Unless anyone minds, I'll queue this up and send it to Linus myself
> via the EFI fixes branch.

Other than the above:

  Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
