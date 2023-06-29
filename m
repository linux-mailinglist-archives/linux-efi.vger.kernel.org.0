Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD71742F9A
	for <lists+linux-efi@lfdr.de>; Thu, 29 Jun 2023 23:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjF2VnF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 29 Jun 2023 17:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjF2VnE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 29 Jun 2023 17:43:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDEF2D71;
        Thu, 29 Jun 2023 14:43:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BF9761642;
        Thu, 29 Jun 2023 21:43:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59FFC433C0;
        Thu, 29 Jun 2023 21:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688074982;
        bh=VltSwcc04VIEITjXt/NoqelYoJMc18hddRllfhvqNbA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SLKKhpEOdL+nNwBaXludEJn2g9r8oRQ2lGNm2Xnvg+zOsdB6Btsia7rfXMxgAKOSA
         mo0H4ha2UJOsuxiF90A1hbrik66VyO+DB1NNvlk88jcoML4fxY0brSyOQ8FgL4Kvf7
         fQfE2nfGnrStk1QB/T7s0dhEk51TIz2xqpIqn34/BClRGZukdtpydn81VXGhAl61qN
         UF5+QyKRd/pAKxAO9HpEl8d6AjdovTCFgEyStdOZpaYL1XrikHvRydH3strDSH+DsR
         MVxIfM/rXdNyuv9KHJlI6FehubILW1I29XJx38VdqdmDVSSAIZKRqpFaDMmn7YQTHq
         eK/DuLX/aXKDw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4fb7769f15aso1907950e87.0;
        Thu, 29 Jun 2023 14:43:02 -0700 (PDT)
X-Gm-Message-State: ABy/qLauCmi+PS1HqJoJGvV/8wt6kZ/XW2dl6ga4TFtvJfm/E8FQef3m
        QzJKMJ6aNkREZEUVQuw0HelXp+ti+4sbt3LMfPs=
X-Google-Smtp-Source: APBJJlHoBqBSBRb+rz+72XXT0uEXH9pMWvMlKJus56Oo+TViDZcMoPbB9Q11Dkbo3KDQLFxQ2zIJimZk4M/X7OHWVq8=
X-Received: by 2002:a05:6512:2211:b0:4fb:8948:2b2b with SMTP id
 h17-20020a056512221100b004fb89482b2bmr1124867lfu.48.1688074980708; Thu, 29
 Jun 2023 14:43:00 -0700 (PDT)
MIME-Version: 1.0
References: <87jzvm12q0.ffs@tglx>
In-Reply-To: <87jzvm12q0.ffs@tglx>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 29 Jun 2023 23:42:49 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG0GZ8K4kVux3zQ6TXGoeQ8bwHq7JXbx-YXFbLSbD-6Gg@mail.gmail.com>
Message-ID: <CAMj1kXG0GZ8K4kVux3zQ6TXGoeQ8bwHq7JXbx-YXFbLSbD-6Gg@mail.gmail.com>
Subject: Re: x86/efi: Make efi_set_virtual_address_map IBT safe
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?TmlrbMSBdnMgS2/EvGVzxYZpa292cw==?= 
        <pinkflames.linux@gmail.com>, linux-efi@vger.kernel.org,
        x86@kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 29 Jun 2023 at 21:35, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Nikl=C4=81vs reported a boot regression on an Alderlake machine and bisec=
ted it
> to commit 9df9d2f0471b ("init: Invoke arch_cpu_finalize_init() earlier").
>
> By moving the invocation of arch_cpu_finalize_init() further down he
> identified that efi_enter_virtual_mode() is the function which causes
> the boot hang.
>
> The main difference of the earlier invocation is that the boot CPU is
> already fully initialized and mitigations and alternatives are applied.
>
> But the only really interesting change turned out to be IBT, which is
> now enabled before efi_enter_virtual_mode(). "ibt=3Doff" on the kernel
> command line cured the problem.
>
> Inspection of the involved calls in efi_enter_virtual_mode() unearthed th=
at
> efi_set_virtual_address_map() is the only place in the kernel which invok=
es
> an EFI call without the IBT safe wrapper. This went obviously unnoticed s=
o
> far as IBT was enabled later.
>
> Use arch_efi_call_virt() instead of efi_call() to cure that.
>
> Fixes: fe379fa4d199 ("x86/ibt: Disable IBT around firmware")
> Fixes: 9df9d2f0471b ("init: Invoke arch_cpu_finalize_init() earlier")
> Reported-by: Nikl=C4=81vs Ko=C4=BCes=C5=86ikovs <pinkflames.linux@gmail.c=
om>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217602

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

I take it you'll send this straight to Linus?


> ---
> I put two fixes tags in as the IBT one missed that and the earlier
> invocation unearthed it and made it observable.
> ---
>  arch/x86/platform/efi/efi_64.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> --- a/arch/x86/platform/efi/efi_64.c
> +++ b/arch/x86/platform/efi/efi_64.c
> @@ -853,9 +853,9 @@ efi_set_virtual_address_map(unsigned lon
>
>         /* Disable interrupts around EFI calls: */
>         local_irq_save(flags);
> -       status =3D efi_call(efi.runtime->set_virtual_address_map,
> -                         memory_map_size, descriptor_size,
> -                         descriptor_version, virtual_map);
> +       status =3D arch_efi_call_virt(efi.runtime, set_virtual_address_ma=
p,
> +                                   memory_map_size, descriptor_size,
> +                                   descriptor_version, virtual_map);
>         local_irq_restore(flags);
>
>         efi_fpu_end();
