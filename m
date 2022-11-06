Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F4161E598
	for <lists+linux-efi@lfdr.de>; Sun,  6 Nov 2022 20:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiKFTiy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 6 Nov 2022 14:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiKFTiv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 6 Nov 2022 14:38:51 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CA51054C
        for <linux-efi@vger.kernel.org>; Sun,  6 Nov 2022 11:38:48 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id k2so6140339qkk.7
        for <linux-efi@vger.kernel.org>; Sun, 06 Nov 2022 11:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SISh0Ofb6RajnQB94iVE1gjbi56FR2WzKoc6JFSaVu8=;
        b=MKt6VGgORIMefON6JVcR9enMrEuCy/gngOiIurncc0yS2HV2RcR4RJUj4mCf4wDZpu
         kUVRg202IujM6WXG+gClW9n2BfRXHQo/TqbWmNumElhrpOT0moZpKPWd4xkCHO7+JsGh
         HrmsJFEapRUMbxKGRqOo/dCsiqgJGnMVs5jSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SISh0Ofb6RajnQB94iVE1gjbi56FR2WzKoc6JFSaVu8=;
        b=xKfMNnM1FEHothh2mFya7F5iBb6qRTrMusGSdkvb8qOOyAmxJiGUC9RYlrXIc3a4x1
         Q/piMpQcU3xX6cqSHnn+Spi9ETkxJl7kA/Q1IECkbuR0RGm+xmxE/2nrs0pee0eQxUxM
         QCMuuYnGj6QaRX6y+eBKTA2XyAS9a/1VTcUW3Vs2JEuqpj/uQ5dpE8tf2foZc0o02V38
         bbpFCa+iiV8c6HldXhtiaJFIxTmrotOgkzKsrUwxOVMw/U+Yw+/3Dg0WF5Z5byTLMMvY
         P2MPgUXfRjGx1AJctx0hVQpO+LW/ok0Z+Mexu2YZ/HTJhdDWvcoyfOe9vmDb5IChCF8W
         7lfA==
X-Gm-Message-State: ACrzQf1uSU8iFDHyut+mbDLmLAi247B6hNJB7EDZqqqqJN4FFcrILmkw
        S9EKKQ0Nfj6/6IWUnEReqrR9PM3bRguYCg==
X-Google-Smtp-Source: AMsMyM6pZ6KWNkNxviLZk+B4veYZ7BCH/Zne5WRpJW8ap5fbZTOjB+WgpUx2acM2eAgQYf42TUalPA==
X-Received: by 2002:a05:620a:1256:b0:6fa:4c67:4d9c with SMTP id a22-20020a05620a125600b006fa4c674d9cmr21452553qkl.713.1667763527259;
        Sun, 06 Nov 2022 11:38:47 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id m2-20020a05620a24c200b006ea7f9d8644sm4740223qkn.96.2022.11.06.11.38.45
        for <linux-efi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Nov 2022 11:38:45 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-36a4b86a0abso87017647b3.7
        for <linux-efi@vger.kernel.org>; Sun, 06 Nov 2022 11:38:45 -0800 (PST)
X-Received: by 2002:a81:114e:0:b0:36a:fc80:fa62 with SMTP id
 75-20020a81114e000000b0036afc80fa62mr45494000ywr.58.1667763524973; Sun, 06
 Nov 2022 11:38:44 -0800 (PST)
MIME-Version: 1.0
References: <20221106145354.3876410-1-ardb@kernel.org>
In-Reply-To: <20221106145354.3876410-1-ardb@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Nov 2022 11:38:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgQaL8Xudo-yhr8WTn7KJy=xUBw9+va-6_K=fdOY5xuOw@mail.gmail.com>
Message-ID: <CAHk-=wgQaL8Xudo-yhr8WTn7KJy=xUBw9+va-6_K=fdOY5xuOw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: efi: Fix handling of misaligned runtime regions
 and drop warning
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

[ Note: in quoting the patch below, I removed the '-' lines, so the
quoted part is really just all that remains after the patch ]

On Sun, Nov 6, 2022 at 6:54 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> +       if (region_is_misaligned(md)) {
> +               static bool __initdata code_is_misaligned;
> +
>                 /*
> +                * Regions that are not aligned to the OS page size cannot be
> +                * mapped with strict permissions, as those might interfere
> +                * with the permissions that are needed by the adjacent
> +                * region's mapping. However, if we haven't encountered any
> +                * misaligned runtime code regions so far, we can safely use
> +                * non-executable permissions for non-code regions.
>                  */
> +               code_is_misaligned |= (type == EFI_RUNTIME_SERVICES_CODE);
> +
> +               return code_is_misaligned ? pgprot_val(PAGE_KERNEL_EXEC)
> +                                         : pgprot_val(PAGE_KERNEL);
> +       }

Ok, this seems like a nice improvement, in how it only does
PAGE_KERNEL_EXEC if any of the regions end up being code.

At the same time this is a much bigger change than just changing the
WARN_ONCE() to pr_warn_once(), so rather than me applying it directly
to my tree, I think I'd prefer it to go through the proper channels
and the usual way.

I'll still apply it to my private "this is the tree I actually boot on
my M2" testing tree, since that has all the other Asahi patches too.
That way I won't see the warning myself on that machine.

So "Acked-by" on the patch, and I hope I'll see it with a future arm64
or EFI pull request (and I'll holler loudly if it actually causes any
issues on my M2, but I obviously don't expect it to)

Thanks,
               Linus
