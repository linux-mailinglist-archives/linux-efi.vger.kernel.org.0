Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7E27BF890
	for <lists+linux-efi@lfdr.de>; Tue, 10 Oct 2023 12:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjJJK03 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-efi@lfdr.de>); Tue, 10 Oct 2023 06:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjJJK01 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 10 Oct 2023 06:26:27 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E622BC1;
        Tue, 10 Oct 2023 03:26:25 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-59f4db9e11eso64637497b3.0;
        Tue, 10 Oct 2023 03:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696933585; x=1697538385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vbmON3xp7LlIs9AFrDaNfaYi2KFfIcOVngy3VzyA1Hk=;
        b=Y71D59HOyKqTrz43/4TlpQM92IH+gjAjomNB5WNQgIjBiVB4WFxad7LD4E64qsg1es
         Emft3alTmvw/bJ4bAW4kvhDOoN1rxuuakJTpLZp0IgmZTeYTXChockrv7UJf5roGeaMT
         AXhX6VHe+FzR6huPSDLTxNzyNQgGgmMN2kUBW6otG1bqxoNU96iRSPlxGsm7DU5ToD4L
         pENVbx92yZ9u5r/ZMDdTJAAox/eTZEKk3du1kZJfCIhIb+fSid2NnAjHwyrPOGJNld43
         szkCShBOfQTiSa+y4gQhxA24TmzamzT9WnsJnf4HRUmTZwtjJPHH1/tM7/Dj+H4AV6ll
         UKnQ==
X-Gm-Message-State: AOJu0YxchQSsaP8YIBsa2SXsyjd/p9LQJakx8JD8FEpcZI+xptt+N+1T
        OodIkpdpbHe/y22E9jZBvuIyyhmac2lo5Q==
X-Google-Smtp-Source: AGHT+IEgXVCRVf4KhZn6EXPz63NiFaC8BYKJvcVSh3HgBqtkdUqDtNlHVIAfWZ8UVaVnyYxSqAjG/Q==
X-Received: by 2002:a0d:d857:0:b0:5a7:ba00:6dd8 with SMTP id a84-20020a0dd857000000b005a7ba006dd8mr2042106ywe.8.1696933584892;
        Tue, 10 Oct 2023 03:26:24 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id c65-20020a0df344000000b005925765aa30sm4353903ywf.135.2023.10.10.03.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 03:26:24 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5a7c08b7744so5244777b3.3;
        Tue, 10 Oct 2023 03:26:24 -0700 (PDT)
X-Received: by 2002:a81:8647:0:b0:595:89b0:6b56 with SMTP id
 w68-20020a818647000000b0059589b06b56mr20014839ywf.28.1696933584327; Tue, 10
 Oct 2023 03:26:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231009211845.3136536-1-arnd@kernel.org> <20231009211845.3136536-2-arnd@kernel.org>
In-Reply-To: <20231009211845.3136536-2-arnd@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 10 Oct 2023 12:26:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU6MFLCOe4BSWr5oVC4JcLpBS+2PvQsoSEWMLRAFpvaGA@mail.gmail.com>
Message-ID: <CAMuHMdU6MFLCOe4BSWr5oVC4JcLpBS+2PvQsoSEWMLRAFpvaGA@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] vgacon: rework Kconfig dependencies
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Deepak Rawat <drawat.floss@gmail.com>,
        Dexuan Cui <decui@microsoft.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guo Ren <guoren@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Helge Deller <deller@gmx.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Khalid Aziz <khalid@gonehiking.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        WANG Xuerui <kernel@xen0n.name>, Wei Liu <wei.liu@kernel.org>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Arnd,

On Mon, Oct 9, 2023 at 11:19 PM Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The list of dependencies here is phrased as an opt-out, but this is missing
> a lot of architectures that don't actually support VGA consoles, and some
> of the entries are stale:
>
>  - powerpc used to support VGA consoles in the old arch/ppc codebase, but
>    the merged arch/powerpc never did
>
>  - arm lists footbridge, integrator and netwinder, but netwinder is actually
>    part of footbridge, and integrator does not appear to have an actual
>    VGA hardware, or list it in its ATAG or DT.
>
>  - mips has a few platforms (malta, sibyte, and sni) that initialize
>    screen_info, on everything else the console is selected but cannot
>    actually work.
>
>  - csky, hexgagon, loongarch, nios2, riscv and xtensa are not listed
>    in the opt-out table and declare a screen_info to allow building
>    vga_con, but this cannot work because the console is never selected.
>
> Replace this with an opt-in table that lists only the platforms that
> remain. This is effectively x86, plus a couple of historic workstation
> and server machines that reused parts of the x86 system architecture.
>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Khalid Aziz <khalid@gonehiking.org>
> Acked-by: Helge Deller <deller@gmx.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

A few suggestions for simplification below...

> --- a/drivers/video/console/Kconfig
> +++ b/drivers/video/console/Kconfig
> @@ -7,9 +7,9 @@ menu "Console display driver support"
>
>  config VGA_CONSOLE
>         bool "VGA text console" if EXPERT || !X86
> -       depends on !4xx && !PPC_8xx && !SPARC && !M68K && !PARISC &&  !SUPERH && \
> -               (!ARM || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER) && \
> -               !ARM64 && !ARC && !MICROBLAZE && !OPENRISC && !S390 && !UML
> +       depends on ALPHA || IA64 || X86 || \
> +               (ARM && ARCH_FOOTBRIDGE) || \

You can drop "ARM &&", as it is implied by ARCH_FOOTBRIDGE.

> +               (MIPS && (MIPS_MALTA || SIBYTE_BCM112X || SIBYTE_SB1250 || SIBYTE_BCM1x80 || SNI_RM))

Likewise for "MIPS &&".

The 3 SIBYTE dependencies can be replaced by SIBYTE_SB1xxx_SOC.

>         select APERTURE_HELPERS if (DRM || FB || VFIO_PCI_CORE)
>         default y
>         help

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
