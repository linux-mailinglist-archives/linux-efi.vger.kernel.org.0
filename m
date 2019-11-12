Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D27E8F90B0
	for <lists+linux-efi@lfdr.de>; Tue, 12 Nov 2019 14:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfKLNb1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 12 Nov 2019 08:31:27 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39201 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfKLNb0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 12 Nov 2019 08:31:26 -0500
Received: by mail-wm1-f66.google.com with SMTP id t26so2956322wmi.4
        for <linux-efi@vger.kernel.org>; Tue, 12 Nov 2019 05:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hIfRT/bxy6U3hwAMr8bQiRC5zLG10vF3KKonDMr7m6Y=;
        b=lmH6Gqk76m5NlHoaQaj0nRlS77eVs7HSUEFf4wZaM/bQjv9iu90Ig5o4gcdS8Jk9rU
         GlLsgvZTom8LCEXl2hoewy/NWFzQFqsM+swV9RdBb6DIsE2vviakMffcW1wVQ+yRXrIS
         lgJ09eWeY//F7myg8Zr8dwGehqJlNaT5yCRkIxqmpkwOW1IW30ggcjpp2IeIZdyT9cSn
         hulhomTgujC6tcF2hvI4360vXd/fpti/uFh8jNbhbeLf5TmTygRuAgPypCRN2yXcxEed
         /VyK4muxoEH6l5rHTFOC2uaWCB2wIxy2KAxsJ/dPml15HSV9I5WvEv+TXmFvhzlGZ4ut
         Nllw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hIfRT/bxy6U3hwAMr8bQiRC5zLG10vF3KKonDMr7m6Y=;
        b=T6QA2uB984V7RddNcJIXebOsuWhniQPquymLBvxokI5/i7IJ9khP43ifSTmRmZ8CEx
         yK9Pd73yD6FA+WVw1qWU3jvvygZbVPzE0bA8GoJbcsN6bBIwLFF7BrIiYm90I2kwggMa
         uDUFLrA6Fh+5gWUqL2jVgQBUzlIA/YM4OOVzquiljh/dzfU3OXqnAk09QEz0rXQs6/ud
         mibECYBve5XuHJCkrh/yz1AlzjPK02O0eg+hmJqJh8LKFSeFnUMjNuJQReYrLHLUV7/p
         nE14cSMsMKux5aGuMWfE9a0W5gDVcah76ThY4kd/dCRVjh51NNyzC00CzQ3EtrvQrhHH
         xf+Q==
X-Gm-Message-State: APjAAAX4oRQ963iWNpbFzN0izRczVISSXvFvYtcUjSlAnd/dkUQpb753
        OqGp7LqyjQPqTpofZi5YfoaCEqnQ/6+Z40ztbCTewg==
X-Google-Smtp-Source: APXvYqwcQJzsO6e5D4y+7b8znbmrSTJcm34zqsnzDoXtss487ONpUPPkxZRU8yOcQdTid/hFg2a2D4xGnSAxHIRXi3k=
X-Received: by 2002:a1c:64d6:: with SMTP id y205mr3680017wmb.136.1573565483107;
 Tue, 12 Nov 2019 05:31:23 -0800 (PST)
MIME-Version: 1.0
References: <20191111154413.1505-1-andriy.shevchenko@linux.intel.com>
 <CAKv+Gu_R1mprDnYUS0HWR2XOWysZnO6AnEt_XkfwzZZVcg64XQ@mail.gmail.com>
 <20191112125754.GS32742@smile.fi.intel.com> <20191112125920.GT32742@smile.fi.intel.com>
In-Reply-To: <20191112125920.GT32742@smile.fi.intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 12 Nov 2019 13:31:11 +0000
Message-ID: <CAKv+Gu9opwMvtnOjw3kU0=xsBidrx4pp2B-JF-c_ij==LFnSEQ@mail.gmail.com>
Subject: Re: [PATCH v1] efi/earlycon: Remap entire framebuffer after page initialization
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Alexander Graf <agraf@suse.de>,
        Matt Fleming <matt@codeblueprint.co.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 12 Nov 2019 at 12:59, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Nov 12, 2019 at 02:57:54PM +0200, Andy Shevchenko wrote:
> > On Mon, Nov 11, 2019 at 05:59:42PM +0000, Ard Biesheuvel wrote:
> > > On Mon, 11 Nov 2019 at 15:44, Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > When the commit 69c1f396f25b ("efi/x86: Convert x86 EFI earlyprintk
> > > > into generic earlycon implementation") moved x86 specific EFI earlyprintk
> > > > implementation to shared location it also tweaked the behaviour. In particular
> > > > it dropped a trick with full framebuffer remapping after page initialization.
> > > > This lead to two regressions:
> > > > 1) very slow scrolling after page initialization;
> > > > 2) kernel hang when keep_bootcon parameter is being provided.
> > > >
> > > > Returning the trick back fixes #2 and mitigates, i.e. reduces the window when
> > > > slowness appears, #1 presumably due to eliminating heavy map()/unmap()
> > > > operations per each pixel line on the screen.
> >
> > > Thanks for fixing this. One question below.
> > >
> > > > +static __init int early_efi_map_fb(void)
> > > > +{
> > > > +       u32 size;
> > > > +
> > > > +       size = screen_info.lfb_size;
> > > > +       if (pgprot_val(fb_prot) == pgprot_val(PAGE_KERNEL))
> > > > +               efi_fb = memremap(fb_base, size, MEMREMAP_WB);
> > > > +       else
> > > > +               efi_fb = memremap(fb_base, size, MEMREMAP_WC);
> > > > +
> > > > +       return efi_fb ? 0 : -ENOMEM;
> > > > +}
> > > > +early_initcall(early_efi_map_fb);
> > > > +
> > > > +static __exit void early_efi_unmap_fb(void)
> > >
> > > Will there be a user for this routine? If not, can we just drop it?
> >
> > The same question can be applied to the driver core part(s), e.g.
> > deferred_probe_exit() in dd.c).
>
> I noted that I missed __exitcall() here. But will wait for your answer.
>

Ah ok, then it makes sense. Mind respinning with that added?


> > The above basically what Greg KH told people to do. While it is partially cargo
> > cult here I can imagine that in some environments (virtual or kexec) somebody
> > would like to get a picture of (post-mortem?) analysis where it would be
> > helpful. Also code looks symmetrical in order to resource management. So, if
> > you insist, I'll remove it, although I personally like my variant.
> >
> > > > +{
> > > > +       memunmap(efi_fb);
> > > > +}
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
> >
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
