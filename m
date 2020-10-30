Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E272A0157
	for <lists+linux-efi@lfdr.de>; Fri, 30 Oct 2020 10:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgJ3JYd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 30 Oct 2020 05:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgJ3JYd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 30 Oct 2020 05:24:33 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006B4C0613CF;
        Fri, 30 Oct 2020 02:24:32 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id s89so4535296ybi.12;
        Fri, 30 Oct 2020 02:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AT9nl2GUPzLTlSYpK+8OlDbwytVPpP6cQwtdlWueTMI=;
        b=uR+S+1eTfx+3pO8Uvenz/xK8TAAFzoqm70Rsc+ppSdSEzc8y8lxO31iAaA9jqqUmfh
         4p2NGu5wTyzD//yFvoWivRS3w8cJHVLtJfkcQWrwW85x8HDG0lnVA0snK+bHJc+Dlh52
         oq4hYkU0TVqs3EBkfJ2hwvhH4+TkhcdkvycSoH3C2W0yu4hFUGLTKsmxI3cYCMZN+HQT
         l27DFu/bKPJUup/5xFt2vOo5RMs3YjYHMmYRsO3OdVcMFh8DxHnMg6ZPlhrMJliIyGXJ
         FuKBxM/9paKGjLVzQ40c3nbQpmYAAE7W4y/G/5M26RKT45bvtVjraY9TyOFPsWuRE+mX
         2W+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AT9nl2GUPzLTlSYpK+8OlDbwytVPpP6cQwtdlWueTMI=;
        b=gTG8uY2O62tMBkabs2dCvbuZSDGjnKFH8ks/gybKjfCyvJ7WZHYhir19JnyMC55vXh
         SfFaYlz+CeXElMjEB2V4BpOAqxXsuwLuFMe0CISCHIbO+TmSCzwhtlDy/vQcIC1vgTM/
         ZbZUP5k3+woVQI+GgO2dGHLT7HzY5lG9+TFNDesRyB/ODBPHNX8RbaL1VJsupbPmxoMh
         bGAd/JBLV2kIvUyBP+5RF5HaBH3ViZidAP0BKP2OXNQBGlDQiaTo2OG97O5SwF6rZgBe
         AYS4mpNIPINQUJKjYYNwIuR++fPutznlcTgmlcFH4VrACNNKXaeejiZ2PxIXeH20j+/S
         q2+g==
X-Gm-Message-State: AOAM5308SfR+ppBqpcRkI/LmurVwoKXip0RtBJUeYhRYNtX+NWUcwTYk
        suQ0sig646olIhXxmxQBc0po5FOxV34RydBYODk=
X-Google-Smtp-Source: ABdhPJyp2BYrU/SfS6yYO922RYV9IromEZZ0HI5Zqxn9ErDh20M7nXRBUP63MxRwLbNa3FVzjUTV5P9jYilOaZio0S8=
X-Received: by 2002:a25:d441:: with SMTP id m62mr2320037ybf.422.1604049872377;
 Fri, 30 Oct 2020 02:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <8451df41359b52f048780d19e07b6fa4445b6392.1604026698.git.joe@perches.com>
In-Reply-To: <8451df41359b52f048780d19e07b6fa4445b6392.1604026698.git.joe@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 30 Oct 2020 10:24:21 +0100
Message-ID: <CANiq72nXkHeF26vY7EK5u0h8pFXwWq5YUUcSHDULvgh1caCNGA@mail.gmail.com>
Subject: Re: [PATCH] treewide: Remove stringification from __alias macro definition
To:     Joe Perches <joe@perches.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Oct 30, 2020 at 4:07 AM Joe Perches <joe@perches.com> wrote:
>
> Like the old __section macro, the __alias macro uses macro # stringification
> to create quotes around the symbol name used in the __attribute__.

Hmm... isn't this V2? It seems none of the Acks/Reviews were picked
up, did something major change?

Cheers,
Miguel
