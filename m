Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5ED145C61
	for <lists+linux-efi@lfdr.de>; Wed, 22 Jan 2020 20:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgAVTWx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 22 Jan 2020 14:22:53 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54647 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgAVTWx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 22 Jan 2020 14:22:53 -0500
Received: by mail-wm1-f68.google.com with SMTP id b19so264185wmj.4
        for <linux-efi@vger.kernel.org>; Wed, 22 Jan 2020 11:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xWpBHT4hqMde43eyJwKJtDhZYAonZRKx3iAocjQUyYo=;
        b=FKteuqhg5IqrDdKVJUufetZplTyyIq1xOfIAB6ZhlcoAH82hqhzC1zPZG2O1j95Pke
         kudDVShcKHguDFB5zWZ97aa+vPOmu1FPqii65xvZ6RNlyuEIrpr72s2jo7mFmuaEgT19
         Vnw5kdo9TvOplFc1H2IrQSsTchWIBTFu70WIyw8xufiucG2keaVlBFd5XssvZA4RLBUY
         oXNSE0pqYQ9g8FlNr88uIJlX3zqdyQrqBDgNOEipKe8u8DJkfIdINunBXHZ5KpWKWP+F
         bHlDfNXtspy/u8qc5zsO5D40d8j7mlvk5/i87z38kCeEKuW1dro6HgCDEH4niM+Z+kTD
         lVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xWpBHT4hqMde43eyJwKJtDhZYAonZRKx3iAocjQUyYo=;
        b=QQY0TfXM507xaMskIk35A0cqHWv80OPeBoUrZxfa0EQUS2ESxeua5uB/aLnL3YddcV
         r1uyLzvCo3Ig3pg3ABJLPDPExzntKjriTJggtwXII9x4DAvy22AnspoQSJnYb+E8RKPQ
         f9Ngynu4qO5AIEX3Eb+oKtGIvFScik6yZuoIMr3KO9QqRYle7oPkL+s1I4oC/dtg+Lbe
         onpiJEy2Wb45wliZN6bR6xKSaKJ3QiqlD4jrpvZ2TmHUFnseCsUo9a2UlF78F1hlVRIk
         +isOiB4ugptVUCztMW9EbgkioxrPcQSlSJdz14sPzDd51UFc0E+rxd/UoVppc3szH04Z
         h7jw==
X-Gm-Message-State: APjAAAVWz30adi2k4Q1o64dGlANECm8ABYduJLdADi8lzkvdM7kTJIC0
        /fGtJRQvM8htTKCwCJb6FPVgtIDn1RkZpNiiSPiBGtT17mg=
X-Google-Smtp-Source: APXvYqwRW+EwzVj5UEPQoOlpO6wziKAlvxhI+CJC5G6xAtmvKCWwe6S4Vibgd8gpmiqNy43iw1yV/iqL2dF22WnIZHU=
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr4766627wmk.68.1579720970736;
 Wed, 22 Jan 2020 11:22:50 -0800 (PST)
MIME-Version: 1.0
References: <20200122191430.4888-1-cai@lca.pw> <CAKv+Gu_snhTpsM4cjZ38UhH02v151NW4cJdQu9QVqCWu4rFVZw@mail.gmail.com>
In-Reply-To: <CAKv+Gu_snhTpsM4cjZ38UhH02v151NW4cJdQu9QVqCWu4rFVZw@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 22 Jan 2020 20:22:40 +0100
Message-ID: <CAKv+Gu9R40uywfPkq02AGtKAWqvq+63EEOrhGJf5_gY1xfHkNQ@mail.gmail.com>
Subject: Re: [PATCH -next] efi/libstub/x86: fix an EFI server boot failure
To:     Qian Cai <cai@lca.pw>, Ingo Molnar <mingo@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 22 Jan 2020 at 20:17, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Wed, 22 Jan 2020 at 20:15, Qian Cai <cai@lca.pw> wrote:
> >
> > x86_64 EFI systems are unable to boot due to a typo in the recent commit.
> >
> > EFI config tables not found.
> >  -- System halted
> >
> > Fixes: 796eb8d26a57 ("efi/libstub/x86: Use const attribute for efi_is_64bit()")
> > Signed-off-by: Qian Cai <cai@lca.pw>
> > ---
> >  arch/x86/boot/compressed/eboot.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
> > index 82e26d0ff075..287393d725f0 100644
> > --- a/arch/x86/boot/compressed/eboot.c
> > +++ b/arch/x86/boot/compressed/eboot.c
> > @@ -32,7 +32,7 @@ __attribute_const__ bool efi_is_64bit(void)
> >  {
> >         if (IS_ENABLED(CONFIG_EFI_MIXED))
> >                 return efi_is64;
> > -       return IS_ENABLED(CONFIG_X64_64);
> > +       return IS_ENABLED(CONFIG_X86_64);
> >  }
> >
> >  static efi_status_t
>
> Apologies for the breakage - your fix is obviously correct. But I did
> test this code, so I am curious why I didn't see this problem. Are you
> booting via GRUB or from the UEFI shell? Can you share your .config
> please?

Hmm, I guess it is simply the absence of CONFIG_EFI_MIXED=y ...

Acked-by: Ard Biesheuvel <ardb@kernel.org>

Ingo, Thomas, could you drop this into efi/core directly please? Thanks.
