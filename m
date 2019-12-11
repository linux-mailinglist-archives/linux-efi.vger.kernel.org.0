Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4790511BAFE
	for <lists+linux-efi@lfdr.de>; Wed, 11 Dec 2019 19:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730197AbfLKSGc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 11 Dec 2019 13:06:32 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51351 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730328AbfLKSGc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 11 Dec 2019 13:06:32 -0500
Received: by mail-wm1-f66.google.com with SMTP id d73so4938223wmd.1
        for <linux-efi@vger.kernel.org>; Wed, 11 Dec 2019 10:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ov1TTtZbs1XTonAG1VeaM8LyoVH4q4i2GURTHZvjEsM=;
        b=yLmg2NTnHpQnAAkiJHmoxuT66tLWqnLuzviBUaa+aaYw+9cgUdp/asN3P8BQr/9Y17
         p/YT2GLORa2P7Roc9tqbY1manT74m/VipmRqAXwsU9p2LIQ1INKo1c2e/TPJPqvKiGLO
         mp6O7WOPVefows0JLYDe7gdVAb25KK/p5bTsPL5zNACN1V+Wkz1UaO+jjifRnzkJZqyM
         dI7l/UVTXa33zWCFq05Hp0ZpEZFVaQbIDkMjqFg0HvDgUCcc4lJCl1kKxX99GV2kE/CS
         FMzE3B6yXQfkXQ8MbfBhm6m/uva+4aaHwCwe529yscd4ta3rcZUkl7A0LnX2xOxqh7Y+
         +yVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ov1TTtZbs1XTonAG1VeaM8LyoVH4q4i2GURTHZvjEsM=;
        b=Y7TFEIwRc6IKieTn+fN5qXGZAxe23lVbOu6Ox8wfKRrRHDH60FxMgTa7RRN8eWCLlH
         3fDACYbRt+NvxDbeqBPhO09JSm5XB9daawvCJ2hMLWPi9EKfMnKSP6vsJUjtRUCkA53v
         +KMx1GS5w6kX+jI8Yw1VSpytjwad2Pa1iDl8l5SY7r1B5d6xJ6K8pRlk34tKOST+JL71
         50Gr1x2CLcCpx6A2DSeQPrLu+2cW6C7eOxvQhS4TKCXycOv+UuCkLc+nB+/EXMslzdli
         NRlPLNdrdW/0limzcXhjCv8LuxfDcl00GZ4feYvgIhr2UgStVB52dWZJ3HEjxD3nloUO
         oxdQ==
X-Gm-Message-State: APjAAAXdIVLLpSUYMmLU9fWkVZKIbizW9AJ4hucpv6Xh5KlDyx42AnYT
        1P7Jnmojg5KetkCKdV5x74CkY9UcnhSOwF0zNojyBLXiTKDBRg==
X-Google-Smtp-Source: APXvYqzBKro+EM/me+nXjAVTHMjJ5Y9QdIA3GclBGtPNbvR5ZUKIsNHnsZHUT8qeTENRhFykCKgxBS/e3znrIH8SCbw=
X-Received: by 2002:a1c:a795:: with SMTP id q143mr1206851wme.52.1576087590130;
 Wed, 11 Dec 2019 10:06:30 -0800 (PST)
MIME-Version: 1.0
References: <20191210232410.17890-1-nivedita@alum.mit.edu> <CAKv+Gu8s=kT_21WasEsTRh+6COQYD0mpzOT5n0qhD1Y+YdR3JQ@mail.gmail.com>
 <20191211110435.GP32742@smile.fi.intel.com> <20191211173746.GA220404@rani.riverdale.lan>
 <20191211180330.GZ32742@smile.fi.intel.com>
In-Reply-To: <20191211180330.GZ32742@smile.fi.intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 11 Dec 2019 18:06:28 +0000
Message-ID: <CAKv+Gu8TbPg_SGZvTc+ZHgTnAq9zYtei7ZgqpdHv=5nNpW4j1Q@mail.gmail.com>
Subject: Re: [PATCH] efi/earlycon: Fix write-combine mapping on x86
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 11 Dec 2019 at 19:03, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Dec 11, 2019 at 12:37:46PM -0500, Arvind Sankar wrote:
> > On Wed, Dec 11, 2019 at 01:04:35PM +0200, Andy Shevchenko wrote:
> > >
> > > Make sense.
> > > One comment below.
> > >
> > > > > -       if (pgprot_val(fb_prot) == pgprot_val(PAGE_KERNEL))
> > > > > -               efi_fb = memremap(fb_base, screen_info.lfb_size, MEMREMAP_WB);
> > > > > -       else
> > > > > -               efi_fb = memremap(fb_base, screen_info.lfb_size, MEMREMAP_WC);
> > > > > +       efi_fb = memremap(fb_base, screen_info.lfb_size,
> > > > > +                         fb_wb ? MEMREMAP_WB : MEMREMAP_WC);
> > >
> > > I would really like to keep the style with if-else.
> > >
> > I edited this back to the if/else and then realized why I chose the
> > ternary. It makes it easier for the reader to see that the only thing
> > that depends on fb_wb is the MEMREMAP_ flag that gets used, while with
> > the if/else the reader needs to compare both function invocations to see
> > that that's the only difference.
> >
> > It's not a big deal, so if you still prefer the if/else I'll revise the
> > patch.
>
> Perhaps comment near to if can explain this.
>

I'm fine with the ternary, actually. What do you feel is wrong with it?
