Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D9075F5DA
	for <lists+linux-efi@lfdr.de>; Mon, 24 Jul 2023 14:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjGXMQB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-efi@lfdr.de>); Mon, 24 Jul 2023 08:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjGXMQA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 24 Jul 2023 08:16:00 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B63110E4;
        Mon, 24 Jul 2023 05:15:34 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6bb140cd5a5so2034274a34.3;
        Mon, 24 Jul 2023 05:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690200925; x=1690805725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9nNGOJzgymf6gQYpdxd2UIkw90HSJ+oAIVzOwuAShWk=;
        b=Uy62wyMg9w8t+mqXu0QFMNYQLHegY1Q65joGU4ncPvQPGwYptIiN2f6DmsYUouk6+7
         JtAWmLG197KYoHDOmAfg3ZxOMrjHz4xE3hYyT76AcEWP1/NbfEO6q8JRB5nr/BxAzOyg
         a7+QOuyPI2rhvw7/jP5F4BBg9IY8T8XHLcAMM5ohppGtr7R86x2IuaPjPO9X/nWI0OoX
         EtvgGcsk0r/ueEy3TzgJuT1uDqG0x03uxNtyt02jDdb+T8/6bg+fyCYc4tnNsnN92/Ld
         LEs75sY2hdIgCGspHVn8/auJuTwf5Te67YoZrN0CdTPjjYJTQVBra4cPZU4AkhkcKXZg
         UqmA==
X-Gm-Message-State: ABy/qLbLYusZCq828Ib/fOAikT1ZT1JurJbDna2ZiunMDfG28vkcu73f
        FuQTMKLHFf9zJHCLdakK0mBA/eVijJEt8w==
X-Google-Smtp-Source: APBJJlGibdh4VyCHZRuKbHeK83kZpT8FPuPgZrxRhKw6BlST+Wy1ddPXguufHTrmJ8wIiimetINKUg==
X-Received: by 2002:a05:6830:188:b0:6b9:91da:484f with SMTP id q8-20020a056830018800b006b991da484fmr8804468ota.27.1690200924916;
        Mon, 24 Jul 2023 05:15:24 -0700 (PDT)
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com. [209.85.161.50])
        by smtp.gmail.com with ESMTPSA id d9-20020a056830004900b006b8c6eb962esm3835164otp.52.2023.07.24.05.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 05:15:24 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-56368c40e8eso2620523eaf.0;
        Mon, 24 Jul 2023 05:15:24 -0700 (PDT)
X-Received: by 2002:a25:238e:0:b0:d05:abaf:9933 with SMTP id
 j136-20020a25238e000000b00d05abaf9933mr7019302ybj.36.1690200457350; Mon, 24
 Jul 2023 05:07:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230719123944.3438363-1-arnd@kernel.org> <20230719123944.3438363-2-arnd@kernel.org>
 <87pm4lj1w3.fsf@mail.lhotse> <19631e74-415e-4dcb-b79d-33dcf03d2dfc@app.fastmail.com>
In-Reply-To: <19631e74-415e-4dcb-b79d-33dcf03d2dfc@app.fastmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Jul 2023 14:07:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVszR+oZi8x8L0iXx=ydTiaNUZxToBSdf=2ZH5t85+D_Q@mail.gmail.com>
Message-ID: <CAMuHMdVszR+oZi8x8L0iXx=ydTiaNUZxToBSdf=2ZH5t85+D_Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] vgacon: rework Kconfig dependencies
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@kernel.org>, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dave Airlie <airlied@gmail.com>,
        Deepak Rawat <drawat.floss@gmail.com>,
        Dexuan Cui <decui@microsoft.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        guoren <guoren@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Khalid Aziz <khalid@gonehiking.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        WANG Xuerui <kernel@xen0n.name>, Wei Liu <wei.liu@kernel.org>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Arnd,

On Fri, Jul 21, 2023 at 10:29 AM Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Jul 21, 2023, at 06:59, Michael Ellerman wrote:
> > Arnd Bergmann <arnd@kernel.org> writes:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >>
> >> The list of dependencies here is phrased as an opt-out, but this is missing
> >> a lot of architectures that don't actually support VGA consoles, and some
> >> of the entries are stale:
> >>
> >>  - powerpc used to support VGA consoles in the old arch/ppc codebase, but
> >>    the merged arch/powerpc never did
> >
> > Not disputing this, but how did you come to that conclusion? I grepped
> > around and couldn't convince myself whether it can work on powerpc or
> > not. ie. currently it's possible to enable CONFIG_VGA_CONSOLE and
> > powerpc does have a struct screen_info defined which seems like it would
> > allow vgacon_startup() to complete.
>
> The VGA console needs both screen_info and vga_con to work. In arch/ppc
> we had both, but in arch/powerpc we only retained the screen_info:
>
> $ git grep vga_con v2.6.26 -- arch/ppc arch/ppc64 arch/powerpc
> v2.6.26:arch/ppc/platforms/pplus.c:     conswitchp = &vga_con;
> v2.6.26:arch/ppc/platforms/prep_setup.c:        conswitchp = &vga_con;
>
> so after arch/ppc was removed, this became impossible to use on both
> pplus and prep. These two platforms were also (as far as I can tell)
> the only ones to support vga16fb as an alternative to vgacon, but
> both platforms were removed later on.

I did use vgacon and vga16fb on CHRP on a second video card
(initialized using Gabriel Paubert's x86 BIOS emulator), but that was
definitely before the advent of arch/powerpc/.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
