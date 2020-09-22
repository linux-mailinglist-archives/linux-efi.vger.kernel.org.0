Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6BC273DDF
	for <lists+linux-efi@lfdr.de>; Tue, 22 Sep 2020 11:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgIVJBD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Sep 2020 05:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgIVJBD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Sep 2020 05:01:03 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10CCC061755
        for <linux-efi@vger.kernel.org>; Tue, 22 Sep 2020 02:01:02 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id z19so17194743lfr.4
        for <linux-efi@vger.kernel.org>; Tue, 22 Sep 2020 02:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y63O6gV3AJzysrylN/6fMvECDY1FII9iBya/QvUBEBI=;
        b=bLIjThtfxjzhKa4DTuFoRjZwencxG7firp+rORYonQc3TDKNYjvTjW857jzU0PW6Zh
         sxCa6NHg3l+5+Y5sh3W4zfkQmN0cInOIzxmtMGgH5IL7xKPJyBG0SnHdWoRnOv5fgokQ
         sdtUY3CFm7sNydF81xfdIHCBviKiq925gZNytt7OJPa17jBLfTXoiFOHQKPlRSOKTLfI
         j5sLoXHntLv2reWP6HnLZRzUdh9RmLRfBz8va/w5692x0CW5O/mVgK37+rF/9M6/R4f7
         0bspfxEG6CSNLti2Ez0mAfHZrCoDGmmfzFAuYiMkxIqdAczPXtk4oXrGlFQbEd18FlAL
         r3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y63O6gV3AJzysrylN/6fMvECDY1FII9iBya/QvUBEBI=;
        b=SsoEHBX0S504j6mohzg9lvWPogOmf2N2JJMoSQZs6ryb7RO7GYOMzDYQDBIbTO2O0t
         ZEYU3qRG8NBEYOeLgYjghzXPPNICjLiy3a6PeQA4fOtz/PnYuJBdxKWR0DJf4fWgwqtn
         Wu5VwGshKp8mtMh774koquFwcR1ANSvaLJXOr9uNkWfM7DG9SyIFkTeHZpHxtb3tzbKw
         FFCvNZq8Q9zL+S5l10ZZ0v28Mv2wcaGOPE+nEYP19ro1fB54QiLnw0G9GeefJHGycgxU
         TVdvP3xKkN4uusI3jqwPo88j9ttUpyN6iMZFMC8mrsahxkaJXGdQD8sRRMlQ1wwUzcK3
         0k/w==
X-Gm-Message-State: AOAM5338ZKv3rEFpa7uAfS01Gptlr138W9qZ42sR6rEaDms7QjkXTaub
        X8RxFxGEGxOQjd7HC4/M0NQhv+9MAczizi1dznqwzA==
X-Google-Smtp-Source: ABdhPJwohisyehaxVO1A2aWlt+3mbr7iRGnMydxh2KbWKTaznxW6Wb2K9+xIg2LaE0AAAAL0AQ+x1L2x2cHfS+Xf7H0=
X-Received: by 2002:a05:6512:370b:: with SMTP id z11mr1215238lfr.571.1600765260966;
 Tue, 22 Sep 2020 02:01:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200921154117.757-1-ardb@kernel.org> <20200921154117.757-10-ardb@kernel.org>
In-Reply-To: <20200921154117.757-10-ardb@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 22 Sep 2020 11:00:50 +0200
Message-ID: <CACRpkdYKOw1fmGm0GqxREzN=zY9rvUsXsp=NJHbKeGCfGp60jg@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] ARM: p2v: switch to MOVW for Thumb2 and ARM/LPAE
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

> In preparation for reducing the phys-to-virt minimum relative alignment
> from 16 MiB to 2 MiB, switch to patchable sequences involving MOVW
> instructions that can more easily be manipulated to carry a 12-bit
> immediate. Note that the non-LPAE ARM sequence is not updated: MOVW
> may not be supported on non-LPAE platforms, and the sequence itself
> can be updated more easily to apply the 12 bits of displacement.
>
> For Thumb2, which has many more versions of opcodes, switch to a sequence
> that can be patched by the same patching code for both versions. Note
> that the Thumb2 opcodes for MOVW and MVN are unambiguous, and have no
> rotation bits in their immediate fields, so there is no need to use
> placeholder constants in the asm blocks.
>
> While at it, drop the 'volatile' qualifiers from the asm blocks: the
> code does not have any side effects that are invisible to the compiler,
> so it is free to omit these sequences if the outputs are not used.
>
> Suggested-by: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Already the nice comments explaining what is going on
here makes the patch highly valuable. It was opaque to
me until I read the comments in this patch. Now it is
just hard to understand instead of hopeless to understand
(for my limited intellect):
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
