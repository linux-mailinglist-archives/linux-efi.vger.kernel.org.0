Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F66476D1A0
	for <lists+linux-efi@lfdr.de>; Wed,  2 Aug 2023 17:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbjHBPRb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Aug 2023 11:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbjHBPPs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Aug 2023 11:15:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CD03592;
        Wed,  2 Aug 2023 08:14:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C83E3619F7;
        Wed,  2 Aug 2023 15:14:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0CFC433C8;
        Wed,  2 Aug 2023 15:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690989276;
        bh=XfSU6iM72jxAI3h3l7DrR7eqMZzluEovcVBf1mWYoeM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RBg2obuZ4zyzAqv0xXhX6SHfCoTfRT9iHmGPDp3Y1QBc/FgGrwLxrKqLmrYVOztwY
         vviEaSDD/zwdzOLSyoz5Osulj6tE/YmNSHKoM4YwLQBAbPkbrQg5qAKtmn5wsY4Phn
         vbd0JlC7MNpdi0H5+nVThF4G3+rXM1Zehr6t6aBHW8VBc+zIcFiSBtblNjwOuCkUzK
         LT8n9TOcjqbLTrfQXmPABTMCuYlQxEmFOz/DPmaYFoM+jAPXNtaoSw1g+YoOwfEKSJ
         l6rKmST+GFA+hFgcsNElzM3fntwGGRzavJkx/KHMZjCv034vcligcS8ucqiwdn4O+l
         W+tD8kuS5/U4g==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4fe3678010eso5793049e87.3;
        Wed, 02 Aug 2023 08:14:36 -0700 (PDT)
X-Gm-Message-State: ABy/qLZBTrOY0IR/YzyLX2KM+FY+i3S6ENEv9OeJ95MAdCptvOiHpJ1F
        ONCoswUhAlrkq/oWZ+lr9AOVCitK5jfB3Cm7Gfk=
X-Google-Smtp-Source: APBJJlGyAjPZ3t4Djl2bd3Puem+X0BE7aF/aMcDnxKjt0sv49xBRYEWDNMFiRsXoi2MX8r9wXhR2Q/5MrOb/T/QBktg=
X-Received: by 2002:a19:e052:0:b0:4fb:8987:734e with SMTP id
 g18-20020a19e052000000b004fb8987734emr4902135lfj.68.1690989274245; Wed, 02
 Aug 2023 08:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230802133704.2146580-1-ardb@kernel.org> <20230802142523.t5o36uy3z366jh27@box.shutemov.name>
In-Reply-To: <20230802142523.t5o36uy3z366jh27@box.shutemov.name>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 2 Aug 2023 17:14:23 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEkbHjmkZuDD3NMi5r-D_kyi5LOSnpbYFTv=NjKHjahbw@mail.gmail.com>
Message-ID: <CAMj1kXEkbHjmkZuDD3NMi5r-D_kyi5LOSnpbYFTv=NjKHjahbw@mail.gmail.com>
Subject: Re: [PATCH] efi/x86: Ensure that EFI_RUNTIME_MAP is enabled for kexec
To:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 2 Aug 2023 at 16:26, Kirill A . Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Wed, Aug 02, 2023 at 03:37:04PM +0200, Ard Biesheuvel wrote:
> > CONFIG_EFI_RUNTIME_MAP needs to be enabled in order for kexec to be able
> > to provide the required information about the EFI runtime mappings to
> > the incoming kernel, regardless of whether kexec_load() or
> > kexec_file_load() is being used. Without this information, kexec boot in
> > EFI mode is not possible.
> >
> > The CONFIG_EFI_RUNTIME_MAP option is currently directly configurable if
> > CONFIG_EXPERT is enabled, so that it can be turned on for debugging
> > purposes even if KEXEC is. However, the upshot of this is that it can
> > also be disabled even when it shouldn't.
> >
> > So tweak the Kconfig declarations to avoid this situation.
> >
> > Reported-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> With the patch 'make oldconfig' updates config to enable
> EFI_NEED_RUNTIME_MAP.
>
> Tested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>
> Thanks.
> > ---
> >  arch/x86/Kconfig | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 7422db4097701c96..616498cdc91e8f01 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -2027,10 +2027,14 @@ config EFI_MAX_FAKE_MEM
> >         Ranges can be set up to this value using comma-separated list.
> >         The default value is 8.
> >
> > +config EFI_NEED_RUNTIME_MAP
> > +     def_bool y
> > +     depends on EFI && KEXEC_CORE
> > +     select EFI_RUNTIME_MAP
> > +
>
> Just curious, why not extend 'config EFI' with 'select EFI_RUNTIME_MAP if KEXEC_CORE'?
> It seems functionally equivalent, but more concise.
>

Yeah, agreed - I didn't realize every arch has its own 'config EFI' definition.

> >  config EFI_RUNTIME_MAP
> >       bool "Export EFI runtime maps to sysfs" if EXPERT
> >       depends on EFI
> > -     default KEXEC_CORE
> >       help
> >         Export EFI runtime memory regions to /sys/firmware/efi/runtime-map.
> >         That memory map is required by the 2nd kernel to set up EFI virtual
> > --
> > 2.39.2
> >
>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov
