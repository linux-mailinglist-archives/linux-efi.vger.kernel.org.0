Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E87E602A80
	for <lists+linux-efi@lfdr.de>; Tue, 18 Oct 2022 13:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiJRLqI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Oct 2022 07:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiJRLqI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 18 Oct 2022 07:46:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26761BB064
        for <linux-efi@vger.kernel.org>; Tue, 18 Oct 2022 04:46:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05CDFB81EB0
        for <linux-efi@vger.kernel.org>; Tue, 18 Oct 2022 11:39:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B2BC433D7
        for <linux-efi@vger.kernel.org>; Tue, 18 Oct 2022 11:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666093150;
        bh=FAGF9RsGm3tyiaehrUD4NmP7f7Jw6+u+0UMPaY5HDDQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JdocnsMg0kIfucZ5p6eMl/Ji/4p1MOuIAcek+jetBDXWKqcriaJsPi6uq/uceUICz
         SWjBsmKpP8XI8pazdwjwB3UC1OLXFwW64W6V1I/lzZu8C8oISFOXmEo9/NUg086Zox
         8NaCTIc8w9Pq13W8Y9paT8yydfmlEmcphUgQXlTWD6iqKaWioOTFHkUmRAPSjqV8Z+
         CoRuCVGD+zzdmFtQqKhqX6sKDq5eN7dEcMlwxtwv7s4BBKljUCw+7USqG+Ds6lfSty
         qL7L7c5CnaQd9kPwD4qECvDPGyn98Wdk8ohqTDtJdoPO/d/SbztRuzg547Cyh1uFW7
         y2/thACopc5Kw==
Received: by mail-lj1-f170.google.com with SMTP id by36so17519552ljb.4
        for <linux-efi@vger.kernel.org>; Tue, 18 Oct 2022 04:39:10 -0700 (PDT)
X-Gm-Message-State: ACrzQf3kTtDOuOYZ8yUzL23cMq2vKIj4pOml2giKHOv5EaAEbAk/iyWJ
        R7/kmh48Ci4i5JdxwML/jV38lJU1eLII1fxHNUc=
X-Google-Smtp-Source: AMsMyM5AwFwAcqNiX2HWd6bBg2m1Zh06sxzYaurhS0nknqGbs9moTaNwgBFTgN+ejLfKDxoL302S8jRNpb+6HyCAxtg=
X-Received: by 2002:a2e:b621:0:b0:26e:535f:a90f with SMTP id
 s1-20020a2eb621000000b0026e535fa90fmr841919ljn.69.1666093148711; Tue, 18 Oct
 2022 04:39:08 -0700 (PDT)
MIME-Version: 1.0
References: <20221017171700.3736890-1-ardb@kernel.org> <20221017171700.3736890-2-ardb@kernel.org>
 <Y06Nvsji+NZkutTN@arm.com>
In-Reply-To: <Y06Nvsji+NZkutTN@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 18 Oct 2022 13:38:57 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH2_qd=BBiNjGj1-SdJ0_2K6s98kVd10Khb0wxQR=vM7w@mail.gmail.com>
Message-ID: <CAMj1kXH2_qd=BBiNjGj1-SdJ0_2K6s98kVd10Khb0wxQR=vM7w@mail.gmail.com>
Subject: Re: [PATCH 01/21] arm64: efi: Move dcache cleaning of loaded image
 out of efi_enter_kernel()
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-efi@vger.kernel.org, keescook@chromium.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>,
        Lennart Poettering <lennart@poettering.net>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 18 Oct 2022 at 13:28, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Mon, Oct 17, 2022 at 07:16:40PM +0200, Ard Biesheuvel wrote:
> > diff --git a/arch/arm64/kernel/efi-entry.S b/arch/arm64/kernel/efi-entry.S
> > index 61a87fa1c305..1c1be004a271 100644
> > --- a/arch/arm64/kernel/efi-entry.S
> > +++ b/arch/arm64/kernel/efi-entry.S
> > @@ -23,15 +23,6 @@ SYM_CODE_START(efi_enter_kernel)
> >       add     x19, x0, x2             // relocated Image entrypoint
> >       mov     x20, x1                 // DTB address
> >
> > -     /*
> > -      * Clean the copied Image to the PoC, and ensure it is not shadowed by
> > -      * stale icache entries from before relocation.
> > -      */
> > -     ldr     w1, =kernel_size
> > -     add     x1, x0, x1
> > -     bl      dcache_clean_poc
> > -     ic      ialluis
> > -
> >       /*
> >        * Clean the remainder of this routine to the PoC
> >        * so that we can safely disable the MMU and caches.
> [...]
> > diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
> > index 598c76c4bbaa..e767a5ac8c3d 100644
> > --- a/drivers/firmware/efi/libstub/arm64-stub.c
> > +++ b/drivers/firmware/efi/libstub/arm64-stub.c
> [...]
> > @@ -174,5 +174,13 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
> >       *image_addr = *reserve_addr;
> >       memcpy((void *)*image_addr, _text, kernel_size);
> >
> > +clean_image_to_poc:
> > +     /*
> > +      * Clean the copied Image to the PoC, and ensure it is not shadowed by
> > +      * stale icache entries from before relocation.
> > +      */
> > +     dcache_clean_poc(*image_addr, *image_addr + kernel_size);
> > +     asm("ic ialluis");
>
> Does this need some barriers, at least a DSB? The original code had DSB
> and ISB, though not immediately after the IC instruction.
>

We are still relying on the implicit DSB done by the subsequent call
to dcache_clean_to_poc() call in efi_enter_kernel(), which executes
much later than this code.
