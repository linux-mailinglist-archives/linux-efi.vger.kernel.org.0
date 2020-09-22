Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCF2273D56
	for <lists+linux-efi@lfdr.de>; Tue, 22 Sep 2020 10:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgIVIcg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Sep 2020 04:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgIVIcg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Sep 2020 04:32:36 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B21C0613CF
        for <linux-efi@vger.kernel.org>; Tue, 22 Sep 2020 01:32:35 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id n25so13428700ljj.4
        for <linux-efi@vger.kernel.org>; Tue, 22 Sep 2020 01:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0sZixKi98uuYR+RpPxpD3GkII7rJqnzhYSAlaE8aUXk=;
        b=cRiZU82qri6RcBASRQSc4xVG+XM0j6ToIohVA5Vsv9KTwvOzmWqQdLaQvJdPR0lBF5
         c2ruv5hMer4VH2SfuU0yVsQc/d0zmCQ5zhhHAmS8LNn6a0z2KG/HndUdDi0mpcYrKpC2
         naCSrdmfPYJpA5DX1GcPhmRKXKTNuGxL+u18zl/rxQ9LIUz9vHUbWW68f6OIw7R0k17X
         IQpJvys4IUmOY8JTAFf2i6GtkvQKMdd3WfFLH2ZhwSNviWVrlFqkOvGlvnBYI7p32Mvg
         aw8myYG8exw9WnxHNl1ZRblp4TvBoXJa3IQCGCxcHWZWfCsXiSfQXLaNChibKU/7Ds16
         0bWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0sZixKi98uuYR+RpPxpD3GkII7rJqnzhYSAlaE8aUXk=;
        b=B8E2VaBySs8+Kj0ABCFprxA9dbjlzrEhIiGz8vmtf7RrT0ntdXnVBuqTQSz7TkN6HA
         FHfLiL9g+GAzVSr9Sx61CKz4X4FPEnSMgiRwWAfsrYNggzbjklD/OV7cStHXjAOl6e7a
         NgzzE9CCYQ+DYQ1Fafr9gEAFnENHtP01p+b7zPPeGNdqLB2jU5LSU/M9bDP2HtHz4ZTM
         D4/LuE9lRK53DcyFAaepEbLaaIZjdqBbiHszAqQI3WGjYUyRvJx2nB+d3fm2iKJFAT6u
         Q9xO8hRbGXjLfX8lgVbnwNZzYr4M+J624oHwY96cxpKDprAZg3ohmNnR6zEiA8DTDH5l
         A/3Q==
X-Gm-Message-State: AOAM5321lqJ/7agsyWOkmTdRv02a7B847Bm5cOqs7X6/5MYTGPTsWYMK
        e/e2rks8ELAV9Stie40aET0MJXldKJLYmnWDBuMiLw==
X-Google-Smtp-Source: ABdhPJzsQeWfuBAmxkScGPqjCVH1YU8tv5Zw3SZs8UvOWyP3TbjbpcFmHuL6Jli0IfbfuyDbzwpDwO4mWDGbEeSprMA=
X-Received: by 2002:a2e:9b15:: with SMTP id u21mr1195777lji.283.1600763554105;
 Tue, 22 Sep 2020 01:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200921154117.757-1-ardb@kernel.org> <20200921154117.757-3-ardb@kernel.org>
In-Reply-To: <20200921154117.757-3-ardb@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 22 Sep 2020 10:32:22 +0200
Message-ID: <CACRpkdY26H2dYQVM9gHfZqVvA_bBD7zEoxfJSL_7=kWPNZZ=8Q@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] ARM: assembler: introduce adr_l, ldr_l and str_l macros
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Sep 21, 2020 at 5:41 PM Ard Biesheuvel <ardb@kernel.org> wrote:

> Like arm64, ARM supports position independent code sequences that
> produce symbol references with a greater reach than the ordinary
> adr/ldr instructions. Since on ARM, the adrl pseudo-instruction is
> only supported in ARM mode (and not at all when using Clang), having
> a adr_l macro like we do on arm64 is useful, and increases symmetry
> as well.
>
> Currently, we use open coded instruction sequences involving literals
> and arithmetic operations. Instead, we can use movw/movt pairs on v7
> CPUs, circumventing the D-cache entirely.
>
> E.g., on v7+ CPUs, we can emit a PC-relative reference as follows:
>
>        movw         <reg>, #:lower16:<sym> - (1f + 8)
>        movt         <reg>, #:upper16:<sym> - (1f + 8)
>   1:   add          <reg>, <reg>, pc
>
> For older CPUs, we can emit the literal into a subsection, allowing it
> to be emitted out of line while retaining the ability to perform
> arithmetic on label offsets.
>
> E.g., on pre-v7 CPUs, we can emit a PC-relative reference as follows:
>
>        ldr          <reg>, 2f
>   1:   add          <reg>, <reg>, pc
>        .subsection  1
>   2:   .long        <sym> - (1b + 8)
>        .previous
>
> This is allowed by the assembler because, unlike ordinary sections,
> subsections are combined into a single section in the object file, and
> so the label references are not true cross-section references that are
> visible as relocations. (Subsections have been available in binutils
> since 2004 at least, so they should not cause any issues with older
> toolchains.)
>
> So use the above to implement the macros mov_l, adr_l, ldr_l and str_l,
> all of which will use movw/movt pairs on v7 and later CPUs, and use
> PC-relative literals otherwise.
>
> Reviewed-by: Nicolas Pitre <nico@fluxnic.net>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

That is obviously a very neat tool you have there.
I worry a bit that people reading the code might have to
issue git log/blame on it to get the commit message in
order to understand what is going on.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
