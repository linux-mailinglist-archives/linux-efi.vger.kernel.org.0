Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6060612DA76
	for <lists+linux-efi@lfdr.de>; Tue, 31 Dec 2019 18:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfLaRGq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Dec 2019 12:06:46 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52249 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbfLaRGq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Dec 2019 12:06:46 -0500
Received: by mail-wm1-f68.google.com with SMTP id p9so2269313wmc.2
        for <linux-efi@vger.kernel.org>; Tue, 31 Dec 2019 09:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZKOHD8y9R9a1x5ChuJOvrpNF1cfLEKY5jZtgibsYCQg=;
        b=AdVQIQf164mMRsfRZgGSMWZPaBg3zcc+4+Qb/owWfPGB7jSi3zxrqhBjycrwt9cz5e
         +JxxkfNHUGivgrxpY2t/BmmPGcQ7zGLNrD8gIbIz0tg5njfN8/LMGMQ4Bd0o90k0wX1X
         5QAvZLUItqDS4oDOgpqs+QZblQI7JJ/pd8kjdjhnZU2oPJuX8y26zixRmIibfpR/Fif8
         AXWWORa/LfVRzuSmoqEnr0dh8X6PIFfHJAHOQgNerkAIokbyKCzbStyn5EyTtLxbjg5F
         OWcOUmRKAYgJUmxnnyoGPEYJ/QsjjInhhL0LVSesYXyu4g4n/d8AiVTOtlt1UQPtoRGY
         CLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZKOHD8y9R9a1x5ChuJOvrpNF1cfLEKY5jZtgibsYCQg=;
        b=sVnj3bkPYENzQ9N0pHL87gbiRu+1rMYl2dXpM7JYR3Bz7VkwasgH0IUV44yjvniwXD
         M0HvsDgdj/vUmrKsDvFc8YFbO0ci19lQlncIqXvDD673RibuOeHIwBz1fmnj6q9hVMis
         TdiAAjVpV76UqYJjUd3nZ3F1dBqBG88aiAMfbXOCuaBchnl4+60UPLRH2oZFDvW/3H7R
         jq6FgW+E8gcRL4nu9cGYipzxXnErZDH4e62SoU8V6owA2boa/IOOdMG2Ak8cKS0s84eN
         oKrC0m5q23U9MtH2Umb3XC1wRx5msSWCAY3c6LWLnVIahYeH7YTJbMFDPzHMqeAoJ5Mq
         nwcA==
X-Gm-Message-State: APjAAAXnLeIc1UGNCuHpVn1t5ZOPAFwv7MpfrF2ElAfXHmHRMAHo+pmz
        74hKLM2INre8tbo9BAbIqjqwW470tVecptscOSVOhQ==
X-Google-Smtp-Source: APXvYqxSxA0mpJNvKFYjjff0rh2MCikVAmqNK27/B9rBbJHjSqt58yrE62yjsS9VHAXJV4WLA5ypi1Al5rAfLOD98Ys=
X-Received: by 2002:a1c:a795:: with SMTP id q143mr4993081wme.52.1577812004361;
 Tue, 31 Dec 2019 09:06:44 -0800 (PST)
MIME-Version: 1.0
References: <20191218170139.9468-1-ardb@kernel.org> <20191218170139.9468-19-ardb@kernel.org>
 <20191231165136.GA3978784@rani.riverdale.lan>
In-Reply-To: <20191231165136.GA3978784@rani.riverdale.lan>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 31 Dec 2019 18:06:33 +0100
Message-ID: <CAKv+Gu9yd83-gRp8zGx5A1AcXPMyteRd6oyqgMYv=h5zJjnAaw@mail.gmail.com>
Subject: Re: [PATCH v2 18/21] efi/libstub: use 'func' not 'f' as macro parameter
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 31 Dec 2019 at 17:51, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Wed, Dec 18, 2019 at 07:01:36PM +0200, Ard Biesheuvel wrote:
> > Use 'func' as the macro parameter name for the efi_call() macros
> > which is less likely to collide and cause weird build errors.
> >
>
> For my education, what are the possible collisions/build errors that might happen?
>

I was concerned about variables called 'f' being passed as one of the
arguments, but now that I think of it, I'm not sure how that could
break.

In any case, I'd like to keep this patch since it also increases legibility.

> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/arm64/include/asm/efi.h |  4 ++--
> >  arch/x86/include/asm/efi.h   | 12 ++++++------
> >  2 files changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
> > index 6f041ae446d2..d06305590ac5 100644
> > --- a/arch/arm64/include/asm/efi.h
> > +++ b/arch/arm64/include/asm/efi.h
> > @@ -93,8 +93,8 @@ static inline unsigned long efi_get_max_initrd_addr(unsigned long dram_base,
> >       return (image_addr & ~(SZ_1G - 1UL)) + (1UL << (VA_BITS_MIN - 1));
> >  }
> >
> > -#define efi_call_early(f, ...)               efi_system_table()->boottime->f(__VA_ARGS__)
> > -#define efi_call_runtime(f, ...)     efi_system_table()->runtime->f(__VA_ARGS__)
> > +#define efi_call_early(func, ...)    efi_system_table()->boottime->func(__VA_ARGS__)
> > +#define efi_call_runtime(func, ...)  efi_system_table()->runtime->func(__VA_ARGS__)
> >  #define efi_is_native()                      (true)
> >
> >  #define efi_table_attr(inst, attr)   (inst->attr)
> > diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
> > index 593a8cda8361..ba3f8a98e156 100644
> > --- a/arch/x86/include/asm/efi.h
> > +++ b/arch/x86/include/asm/efi.h
> > @@ -236,17 +236,17 @@ static inline bool efi_is_native(void)
> >               ? inst->func(inst, ##__VA_ARGS__)                       \
> >               : efi64_thunk(inst->mixed_mode.func, inst, ##__VA_ARGS__))
> >
> > -#define efi_call_early(f, ...)                                               \
> > +#define efi_call_early(func, ...)                                    \
> >       (efi_is_native()                                                \
> > -             ? efi_system_table()->boottime->f(__VA_ARGS__)          \
> > +             ? efi_system_table()->boottime->func(__VA_ARGS__)       \
> >               : efi64_thunk(efi_table_attr(efi_system_table(),        \
> > -                             boottime)->mixed_mode.f, __VA_ARGS__))
> > +                             boottime)->mixed_mode.func, __VA_ARGS__))
> >
> > -#define efi_call_runtime(f, ...)                                     \
> > +#define efi_call_runtime(func, ...)                                  \
> >       (efi_is_native()                                                \
> > -             ? efi_system_table()->runtime->f(__VA_ARGS__)           \
> > +             ? efi_system_table()->runtime->func(__VA_ARGS__)        \
> >               : efi64_thunk(efi_table_attr(efi_system_table(),        \
> > -                             runtime)->mixed_mode.f, __VA_ARGS__))
> > +                             runtime)->mixed_mode.func, __VA_ARGS__))
> >
> >  extern bool efi_reboot_required(void);
> >  extern bool efi_is_table_address(unsigned long phys_addr);
> > --
> > 2.17.1
> >
