Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4D868A8F5
	for <lists+linux-efi@lfdr.de>; Sat,  4 Feb 2023 09:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjBDIYF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 4 Feb 2023 03:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjBDIYE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 4 Feb 2023 03:24:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0243D91F
        for <linux-efi@vger.kernel.org>; Sat,  4 Feb 2023 00:24:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07DC060B01
        for <linux-efi@vger.kernel.org>; Sat,  4 Feb 2023 08:24:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6698BC433D2
        for <linux-efi@vger.kernel.org>; Sat,  4 Feb 2023 08:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675499042;
        bh=U40kZM+m/snO/w5YcRipSmI0rxtfeNW5CzUzh8x2FYI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LgR9zbT2W34PDIgssOtRvgyYOd6mLjUuFTfqqgXt1N/7S0dXS9xsW9VAWaJ3m4gy3
         a2xy4lcqV8JcZjH6wjwZ0MXraqC9zixdUo/US8Q6OmV0PMNf1WlT+Uy7DjIqzFHHPX
         ib/JM93uYCaSjXSVsumKsmcz2IzseF+F1s5CewzlO+BDADCUS25AEg1wghHU1IXck9
         k05CY2zHy3t2jQHj3wz9Oot2ZAHjmmUPqqAn64ym3NbC1V9M6hWlXTzj0C/yjUrt18
         Xy+PHMBnw+quEKmzuAgeO+fvT8e+kg1MMfNvsJFBMeeyF6NDDJpf/wDZSUNKn7Ntkx
         n8p8WgGCYakUQ==
Received: by mail-lj1-f174.google.com with SMTP id h4so7406587lja.2
        for <linux-efi@vger.kernel.org>; Sat, 04 Feb 2023 00:24:02 -0800 (PST)
X-Gm-Message-State: AO0yUKVuIjuj+Jsl4EZyaecrcy2IMjzCAQAp0aISTFXWZ1YRB2Ixa/nG
        B2C5TQyHRiorlhowV/svJcl24czEDkKZJP9mC6k=
X-Google-Smtp-Source: AK7set/Ko0UArUOdAj4CFUhdyifL2aWojI6sCxoj/E44VW57dbtFqnIGOYHYjo8JypRDmkeuTJ3xLVn0+JPwXnL/cDs=
X-Received: by 2002:a2e:aaa7:0:b0:28b:9149:6291 with SMTP id
 bj39-20020a2eaaa7000000b0028b91496291mr1898565ljb.142.1675499040434; Sat, 04
 Feb 2023 00:24:00 -0800 (PST)
MIME-Version: 1.0
References: <20230201132540.2196065-1-ardb@kernel.org> <63dbf4cd.a70a0220.d9b66.920b@mx.google.com>
In-Reply-To: <63dbf4cd.a70a0220.d9b66.920b@mx.google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 4 Feb 2023 09:23:49 +0100
X-Gmail-Original-Message-ID: <CAMj1kXECeHoE3ocxAe4w_WjVyC+=6Ze87x8OtBGw7yidN-8yrA@mail.gmail.com>
Message-ID: <CAMj1kXECeHoE3ocxAe4w_WjVyC+=6Ze87x8OtBGw7yidN-8yrA@mail.gmail.com>
Subject: Re: [PATCH 0/2] efi: Enable BTI for EFI runtimes services
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 2 Feb 2023 at 18:37, Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Feb 01, 2023 at 02:25:38PM +0100, Ard Biesheuvel wrote:
> > The EFI spec v2.10 introduces a global flag in the memory attributes
> > table that indicates whether the EFI runtime code regions were emitted
> > with BTI landing pads, and can therefore tolerate being mapped with BTI
> > enforcement enabled.
> >
> > Add the generic plumbing for this, and wire it up for arm64.
>
> Looks nice! :)
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>

Thanks

I've queued these up now in efi/next


> >
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> >
> > Ard Biesheuvel (2):
> >   efi: Discover BTI support in runtime services regions
> >   efi: arm64: Wire up BTI annotation in memory attributes table
> >
> >  arch/arm/include/asm/efi.h     |  2 +-
> >  arch/arm/kernel/efi.c          |  5 +++--
> >  arch/arm64/include/asm/efi.h   |  3 ++-
> >  arch/arm64/kernel/efi.c        | 18 +++++++++++++++---
> >  arch/riscv/include/asm/efi.h   |  2 +-
> >  arch/riscv/kernel/efi.c        |  3 ++-
> >  arch/x86/platform/efi/efi_64.c |  3 ++-
> >  drivers/firmware/efi/memattr.c |  9 +++++++--
> >  include/linux/efi.h            |  8 ++++++--
> >  9 files changed, 39 insertions(+), 14 deletions(-)
> >
> > --
> > 2.39.0
> >
>
> --
> Kees Cook
