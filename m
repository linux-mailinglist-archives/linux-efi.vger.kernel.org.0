Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA7611ACAD
	for <lists+linux-efi@lfdr.de>; Wed, 11 Dec 2019 15:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbfLKOA7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 11 Dec 2019 09:00:59 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41707 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbfLKOA7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 11 Dec 2019 09:00:59 -0500
Received: by mail-wr1-f66.google.com with SMTP id c9so24160629wrw.8
        for <linux-efi@vger.kernel.org>; Wed, 11 Dec 2019 06:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z8gDvmjU3iNeucypbW3xV/yVxO/wy18RT2kc50I93eE=;
        b=jUO3CTcUKgU1ulBxtJDtiVYQ2cS41ChDEccrhUis9PEU8oeIEMbhp+5y61Mkzdu0zq
         Qc5A92Tikqv9zGAT8rsND5TsykzHgFnini9uhS7TU8nn1nvM0XmCF/5LZNP7k2YKTzNx
         loPTR+6jYcE31BPPsay1MsYgfJKRb9Gq2tkPkQqm8l+o+mzNJxhlfLbZlxXtaQPDCRki
         NCemuFXYEZxzkGAEtJkZVj3XDfzSeiMCyTmmyi0Nt49VtEUEXc1gH+KNm5rYIMu91b2y
         I9nh0YthbOiVlKSDAhfGmMRGBr6ANCNvSppAyf7g/aiXjSSCAaefK4Edzj7JCrmoBSAE
         7YzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z8gDvmjU3iNeucypbW3xV/yVxO/wy18RT2kc50I93eE=;
        b=mNqPvcvL5IS3pnS2f2GpvSb3J2VpK5PcWQnBlWMePfIyU3aU6vmVHlky+/20V++1XW
         AIAXHvM/7GyJ86dNYSaNUP6KRHWRaQt1aXPlhqxE2wU/YbgHPX+VXWZEhQ3gne3JAGMg
         WOb5EzD0G4/vyiChd4KFSVguxAN5TxylI8kHKk6f0PrkigixTbnOuw7D36R9bd7vD0Sp
         bpoRXOeZGAaf91N/MtwU2+40kcdqxTcri/q4LmbT2oXCPoTkrsHuwMus38QPr5tsDI7M
         OYxtUMafyi4RgZf81w09MPxPjy2G2to0IWQTLvuZS3s1SmRWjOCnVH5cIsIU5gfQk0wn
         f6Eg==
X-Gm-Message-State: APjAAAXPM+wG3FM4IO3ImHjeoTP225oayyA9ut4bCwK+zehB4003BCEq
        Ki4XhkCGcTgk5dNvFmZdtTixenonyckMRKDkY0pZPA==
X-Google-Smtp-Source: APXvYqzjpHz2Xb/FizIMmcfS9Rm8vEWnRAAP4U8DPnbcKeEcc4gqjs7iAQWzbyj3Z8SCo14A3gM1+eykPWLRFQq+rw0=
X-Received: by 2002:a5d:6652:: with SMTP id f18mr4147261wrw.246.1576072857449;
 Wed, 11 Dec 2019 06:00:57 -0800 (PST)
MIME-Version: 1.0
References: <20191210232410.17890-1-nivedita@alum.mit.edu> <CAKv+Gu8s=kT_21WasEsTRh+6COQYD0mpzOT5n0qhD1Y+YdR3JQ@mail.gmail.com>
 <20191211110435.GP32742@smile.fi.intel.com>
In-Reply-To: <20191211110435.GP32742@smile.fi.intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 11 Dec 2019 15:00:46 +0100
Message-ID: <CAKv+Gu_=+nkcB3vEhYYBbD37UR4AJ-M2kTihAhXY+wc-Uwf=dQ@mail.gmail.com>
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

On Wed, 11 Dec 2019 at 12:04, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Dec 11, 2019 at 08:22:56AM +0000, Ard Biesheuvel wrote:
> > (+ Andy)
> >
> > On Wed, 11 Dec 2019 at 00:24, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > On x86, until PAT is initialized, WC translates into UC-. Since we
> > > calculate and store pgprot_writecombine(PAGE_KERNEL) when earlycon is
> > > initialized, this means we actually use UC- mappings instead of WC
> > > mappings, which makes scrolling very slow.
> > >
> > > Instead store a boolean flag to indicate whether we want to use
> > > writeback or write-combine mappings, and recalculate the actual pgprot_t
> > > we need on every mapping. Once PAT is initialized, we will start using
> > > write-combine mappings, which speeds up the scrolling considerably.
> > >
> > > Fixes: 69c1f396f25b ("efi/x86: Convert x86 EFI earlyprintk into generic earlycon implementation")
> > > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
>
> Make sense.
> One comment below.
>
> > > -       if (pgprot_val(fb_prot) == pgprot_val(PAGE_KERNEL))
> > > -               efi_fb = memremap(fb_base, screen_info.lfb_size, MEMREMAP_WB);
> > > -       else
> > > -               efi_fb = memremap(fb_base, screen_info.lfb_size, MEMREMAP_WC);
> > > +       efi_fb = memremap(fb_base, screen_info.lfb_size,
> > > +                         fb_wb ? MEMREMAP_WB : MEMREMAP_WC);
>
> I would really like to keep the style with if-else.
>

Can't we just set a global flag to MEMREMAP_WB or MEMREMAP_WC in the
init code, and use that directly?
