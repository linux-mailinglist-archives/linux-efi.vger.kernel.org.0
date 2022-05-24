Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABAA53242B
	for <lists+linux-efi@lfdr.de>; Tue, 24 May 2022 09:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbiEXHgZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 May 2022 03:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233812AbiEXHgY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 24 May 2022 03:36:24 -0400
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A3A41611;
        Tue, 24 May 2022 00:36:21 -0700 (PDT)
Received: by mail-qv1-f54.google.com with SMTP id cv1so1528713qvb.5;
        Tue, 24 May 2022 00:36:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hHz2dkZf9qf9PMGkX8HB6FwtvylKwYDKEt4PSRoOrRg=;
        b=5604KnZJRPq7BHqRN+r0CdJrgPevS3I0gpY5ik8NHtpYCAk2x0tZGmO/6o6T1W76Yn
         zV9Ua0cpCko3LoDH4MrsOF6DYfNCn9P4v9JvNInWeqn3ZZmT9/Q5v1KBEs3LujV8J4B4
         2j1Ge8pS2BNjxbbJy7J5x15bi94iA11YiM+0AXGdZwRntqoSxskvbGH/UhFTCLlNkb6G
         xbdTaKhdk9FMAVgmMPU85M49/p7R1wKK6owyNwJKkv55HbdOHmXfXGr0vh1uH6nugPmx
         zbFBVubmxrK3WdEeFIGEe2Iza/c+3iXt/Ofd1pbtJm7jncBFoQuVxHkymF5qbZoiqCwX
         XbDw==
X-Gm-Message-State: AOAM5307JJYuKKVr+/bn5BNtbaqlecYWqjfs1HWwFh1R/mn/qkp8BVFl
        63lB/AgivRGOeTaJMPowXafid0kyqKjohtRe
X-Google-Smtp-Source: ABdhPJyUl/U3qUC3xs1tPrxczkJco8UcbDi7mKK1iFwhrt2cm4sV5otciSDdm9mSlzIfJgfdjP9uIA==
X-Received: by 2002:ad4:5ba3:0:b0:462:1b10:e16e with SMTP id 3-20020ad45ba3000000b004621b10e16emr12994063qvq.40.1653377780983;
        Tue, 24 May 2022 00:36:20 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id ey18-20020a05622a4c1200b002f937991969sm3015467qtb.24.2022.05.24.00.36.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 00:36:20 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id p190so2517005ybg.4;
        Tue, 24 May 2022 00:36:20 -0700 (PDT)
X-Received: by 2002:a05:6902:120e:b0:634:6f29:6b84 with SMTP id
 s14-20020a056902120e00b006346f296b84mr25463870ybu.604.1653377780467; Tue, 24
 May 2022 00:36:20 -0700 (PDT)
MIME-Version: 1.0
References: <c7ccee444dbc50a61a703cabeffe28e73de4cda7.1653375268.git.geert@linux-m68k.org>
 <f8a95dcd-4a9f-ddd2-b322-96720f666b37@redhat.com>
In-Reply-To: <f8a95dcd-4a9f-ddd2-b322-96720f666b37@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 24 May 2022 09:36:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU+fFaKoK0RYjGrkwadafjZ9MTzA-LSzD6pZnoB26HAsg@mail.gmail.com>
Message-ID: <CAMuHMdU+fFaKoK0RYjGrkwadafjZ9MTzA-LSzD6pZnoB26HAsg@mail.gmail.com>
Subject: Re: [PATCH] efi: EFI_DISABLE_RUNTIME should depend on EFI
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Javier,

On Tue, May 24, 2022 at 9:22 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> On 5/24/22 08:54, Geert Uytterhoeven wrote:
> > The EFI_DISABLE_RUNTIME config option controls the use of Extensible
> > Firmware Interface (EFI) runtime services, which matters only if EFI
> > support is enabled.
> >
>
> Indeed. Sorry for forgetting that dependency when adding the symbol.
>
> > Hence add a dependency on EFI, to prevent asking the user about this
> > control knob when configuring a kernel with EFI support.
> >
>
> I think you wanted to write here "without EFI support" ?

Oops, sorry for that. Need... morning... coffee...

> > Fixes: a031651ff2144a3d ("efi: Allow to enable EFI runtime services by default on RT")
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
>
> Acked-by: Javier Martinez Canillas <javierm@redhat.com>

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
