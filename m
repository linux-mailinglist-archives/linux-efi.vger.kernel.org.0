Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0E47CC3ED
	for <lists+linux-efi@lfdr.de>; Tue, 17 Oct 2023 15:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbjJQNGi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Oct 2023 09:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbjJQNGh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Oct 2023 09:06:37 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC4AED
        for <linux-efi@vger.kernel.org>; Tue, 17 Oct 2023 06:06:36 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53e84912038so4705443a12.1
        for <linux-efi@vger.kernel.org>; Tue, 17 Oct 2023 06:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697547994; x=1698152794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LLd/Lt5+7JcyD6vdZZ9npbQTexSJK5RB78HI3kLErS0=;
        b=YKVL3VG8BUPrvuKDzlndZEBCVSSCSWfhBFcoM7sobQ2d9aKCLY/kr/5pTYBPdlykL+
         cf8EpbEG5rdZ0jWWRCBIqjrC5iGjDiKH/DxoudZ4NBsFzJKICcxNOLmQoLAgG9KdcovG
         OMRT1J+KwYnNz4uynHPMUZBBJW8Bfb1ir7Xr0tkjSZ3wuKmw8149ba+XJh1SdGpkkOiZ
         mHc0+Xcf3lBs7LOiZvlAUyvMxnWf4QitVrNNVteua2uOt1UPkwPMKHf3PCyL8ZpDdIAz
         l2SqTH+LmOLCqEWVAxspbo9cmqMl94+BUOF+2G4cydsLY4Wa990/vqY6p9jyi+eMZWFr
         fimQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697547994; x=1698152794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LLd/Lt5+7JcyD6vdZZ9npbQTexSJK5RB78HI3kLErS0=;
        b=nfYV7MdLj2DDjoLJuZceArfYNzyt5CWrlzQS3gPzHKpTxEpIgZq5p3Rn+pRf4LN0Tn
         x+xRJpL+HF/QIXMugqichhYiJ4IyxmUzLJDyT82gHFE6OV0ptD9zZIFrLZqDPpw0DpJe
         h0F2TPQRqWfNfttVSw8pNnoafFvq2GYYzSbidB6L/Q+Z1eKyipmRxeplAGjRi80VubAy
         3dX9DBNcTSeiu1lRBTrAfyeoXcY9ua1G9eYi6anKzzTTVkmMTZYNqOpuN5dQJRYvQwGt
         IFHOl+4eroYIAfuSyh0rcRZTY3n7k+vOJWl+9KP6If4SRhpxDQ8C2SkDnMDJIocSv8Sp
         TecQ==
X-Gm-Message-State: AOJu0YwDfes/FGrDPG/O4TBEzv76P1fyv4exQuyzUZc+HvGo3Vgr9Qm6
        J1A6fhDkTOIVxwOsRX0HmSz/TwaiG88=
X-Google-Smtp-Source: AGHT+IHEqDmaGYTilCvvIdgjfFaZHhKfeV3zRwHPOyl8jZ32ZJidQyEfXWimJIMXSF5pe5EliVzB9g==
X-Received: by 2002:a17:907:9625:b0:9ad:7890:b4c0 with SMTP id gb37-20020a170907962500b009ad7890b4c0mr1829964ejc.56.1697547994313;
        Tue, 17 Oct 2023 06:06:34 -0700 (PDT)
Received: from gmail.com (1F2EF7B2.nat.pool.telekom.hu. [31.46.247.178])
        by smtp.gmail.com with ESMTPSA id a24-20020a17090640d800b0099297782aa9sm1186823ejk.49.2023.10.17.06.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 06:06:33 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 17 Oct 2023 15:06:31 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Ard Biesheuvel <ardb@google.com>, linux-efi@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH] x86/boot: efistub: Assign global boot_params variable
Message-ID: <ZS6G11WdoDeZTCgX@gmail.com>
References: <20231016164634.3514517-2-ardb@google.com>
 <CAMj1kXFootPaQJTYTFoRWido1Fn_trmT2u42hdPOjP+=8D0H_g@mail.gmail.com>
 <ZS5xTR/7jgUHZXb3@gmail.com>
 <CAMj1kXFcA+VgChYtWH+LW106hhotW60O_K406kEzO9jeVAd02A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFcA+VgChYtWH+LW106hhotW60O_K406kEzO9jeVAd02A@mail.gmail.com>
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

> On Tue, 17 Oct 2023 at 13:34, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > > On Mon, 16 Oct 2023 at 18:46, Ard Biesheuvel <ardb@google.com> wrote:
> > > >
> > > > From: Ard Biesheuvel <ardb@kernel.org>
> > > >
> > > > Now that the x86 EFI stub calls into some APIs exposed by the
> > > > decompressor (e.g., kaslr_get_random_long()), it is necessary to ensure
> > > > that the global boot_params variable is set correctly before doing so.
> > > >
> > > > Note that the decompressor and the kernel proper carry conflicting
> > > > declarations for the global variable 'boot_params' so refer to it via an
> > > > alias to work around this.
> > > >
> > > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > > ---
> > > >  drivers/firmware/efi/libstub/x86-stub.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> > > > index 3bfc59637dd1..51407207ded5 100644
> > > > --- a/drivers/firmware/efi/libstub/x86-stub.c
> > > > +++ b/drivers/firmware/efi/libstub/x86-stub.c
> > > > @@ -812,12 +812,15 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
> > > >                                efi_system_table_t *sys_table_arg,
> > > >                                struct boot_params *boot_params)
> > > >  {
> > > > +       extern struct boot_params *bpp asm("boot_params");
> > >
> > > I am getting hatemail from the bots about this extern declaration, so
> > > I will move that into x86-stub.h.
> >
> > Hm, it would be better if we moved all of x86-stub.h into
> > arch/x86/include/asm/ or so. We don't really encourage "deep" driver-level
> > exports like that, and there's little reason why this couldn't be in the
> > x86 headers, right?
> >
> 
> Yes, there is.
> 
> arch/x86/boot/compressed/misc.h:extern struct boot_params *boot_params;
> arch/x86/include/asm/setup.h:extern struct boot_params boot_params;
> 
> Ideally, we should get rid of the first one.
> 
> Happy to send a patch that replaces all conflicting uses in the
> decompressor, so we can just access the global pointer without these
> tricks.

Yeah, that would be lovely, thanks.

> But I'd like to get the fix in for v6.6 in any case.

Sure:

  Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
