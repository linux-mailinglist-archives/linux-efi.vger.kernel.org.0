Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 061F21957E9
	for <lists+linux-efi@lfdr.de>; Fri, 27 Mar 2020 14:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgC0NXY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Mar 2020 09:23:24 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36806 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgC0NXY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 27 Mar 2020 09:23:24 -0400
Received: by mail-oi1-f196.google.com with SMTP id k18so8749533oib.3
        for <linux-efi@vger.kernel.org>; Fri, 27 Mar 2020 06:23:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oesX5llhbV3L19TdgK9MBe+d6BuC3DO0rZ8FRuSs2k8=;
        b=ClVQB3sNIGTKMH04HWEoBCG2ns4VzqbbrgQ4BkyBxQgStLSW5QdnHrh5zbvT1bkBm9
         Mz/Yi8BjkCRbPclST+ijv1eLJkEVYKWaw0sjm7+QXhVISCE1S02sofIhFsoqCbLqVBbv
         gBLGpLtTBmYPQrpid1Cp7mbtZbemSCL/qIBEWVBPoRTRnHUZacNFPJvi5TWmLJCtj1TF
         PYPWooXTlbad++8D+u8uZ72DOzE6Raznecsr+x69zzfXShxzfOeiNJi2+x4VMEscERNh
         3ym7GBOxAVxK1x2d3xLLMXinL/QpQJUGiLAwqwKQ4slnPX4b8r7J/ZKDf17xLTje8dR4
         ot4w==
X-Gm-Message-State: ANhLgQ2oe1tnV30XN1hPTwvRHxmhcFskCBZiVkjlDyOZh9UphVlp3wal
        wdT3H/mMVOa83heapQGhCC///8YxtFKrJXG6vg8=
X-Google-Smtp-Source: ADFU+vsfBQo70NmHwmkKywfxwVpQtWDEuTwZl42kxXqi2Yel+RcB2RMlVWNuIwZmOvoX5zgdLrMENSMIQWa4mDE2Ors=
X-Received: by 2002:aca:4e57:: with SMTP id c84mr3745824oib.148.1585315403440;
 Fri, 27 Mar 2020 06:23:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200327105906.2665-1-ardb@kernel.org> <20200327105906.2665-2-ardb@kernel.org>
In-Reply-To: <20200327105906.2665-2-ardb@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 27 Mar 2020 14:23:12 +0100
Message-ID: <CAMuHMdWewhg9nDNrKw7F6f3uajxvw_mBZs17cZL64FQ8VrvrNA@mail.gmail.com>
Subject: Re: [PATCH 1/5] ARM: decompressor: move headroom variable out of LC0
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

Thanks for your patch!

On Fri, Mar 27, 2020 at 11:59 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> Before breaking up LC0 into different pieces, move out the variable
> that is already place relative (given that it subtracts 'restart' in

placed

> the expression) and so its value does not need to be added to the
> runtime address of the LC0 symbol itself.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
