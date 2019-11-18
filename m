Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD8211007E9
	for <lists+linux-efi@lfdr.de>; Mon, 18 Nov 2019 16:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfKRPLy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 Nov 2019 10:11:54 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51123 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfKRPLy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 Nov 2019 10:11:54 -0500
Received: by mail-wm1-f68.google.com with SMTP id l17so17761822wmh.0
        for <linux-efi@vger.kernel.org>; Mon, 18 Nov 2019 07:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z6qzPhno5GOM9cR7mVrv3JXyymVY2p28oe+Xin4J+zk=;
        b=PVb5uOW1edT+nVdjln8k95Ry0rubEefyPlH/HwoDB7ljIamYW98ts2QL4BIn5GRw9l
         0b48QzG6zAxyYG6E3Gax4pR4ZI2CPxLEqHLEbseCVBH9xs0txRyIIfzV+Ws/LgoZEvkX
         cX3hIYVX66qTdYSHTPbqwQCs9tgozOHsr3IMfcryasYYnlO40Xo+qDYyMaSYNK/sYREh
         OkR2IfHRSRCIIn8PTisCBmR916/FERQRxL9DPog/q33n4IbBFMawZ3lkQA00hsci+Nzb
         pzud2C1zC0QiJ8Gg3BFobomE5wn/AR9iaGqIlC+qJzkp/ofNo4BgOl/e0WDlgzHWumhB
         M12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z6qzPhno5GOM9cR7mVrv3JXyymVY2p28oe+Xin4J+zk=;
        b=QBFRuMrP39v51xpW9lCvZ1DOeKB7HlCEKhj47z8IFPEB6dj9MNcAfLrs6jkYQAYISF
         V3/GFnVFJjkxUMCRo0+NidUF0wEZfmCi0ny6iSftL4fyqgRp7+0FMOzi9e2CthsPt1Ik
         k1zKsgL0l49DmowaBLhBNGHx1TrYHgXsZlHSnxH9CvM4j8n8YC+NIYeZZGhVaem58QpZ
         QA/XP6ynYOOUC/P3//Cni0THVAEF7GM58i+B3XTMDGfNEUHd8KY42d/ywRC6A4BE7lCK
         8H7o1s30MVNW6JdRxooKdN3VLdAZHYZ24DwlrqVuZSgyvo6HMOnLrw9eYziQvX8Zzm19
         I4eg==
X-Gm-Message-State: APjAAAWPaW2rgzj8jc4S6tL5UboIoUqe6bo7wXU+BgDrhZZuVRzXkOyu
        5Yc0O5rUc+c7FqPI5/M94wfDCh2FJzduN9Y2nzBu32vwVKo=
X-Google-Smtp-Source: APXvYqwsEXHuQO6s4tIe5bUa3Dt7u69hQ0Lj1r1rmaNJG7317ohDNK3MWJoeJzkqgBHZ3q2dYXa3odXobEbtEpQ6hbQ=
X-Received: by 2002:a1c:64d6:: with SMTP id y205mr27611463wmb.136.1574089912283;
 Mon, 18 Nov 2019 07:11:52 -0800 (PST)
MIME-Version: 1.0
References: <20191115153102.51921-1-andriy.shevchenko@linux.intel.com>
 <CAKv+Gu9wKQ_yXjfkB6-6f8Tfu+cfpSNnxn04ZqExYxuPSQS-ww@mail.gmail.com> <20191118114538.GV32742@smile.fi.intel.com>
In-Reply-To: <20191118114538.GV32742@smile.fi.intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 18 Nov 2019 16:11:40 +0100
Message-ID: <CAKv+Gu8sL3nVgozM3VnMLSLzHST1SLFvX0q2LCoWuAkKBjafeg@mail.gmail.com>
Subject: Re: [PATCH v3] efi/earlycon: Remap entire framebuffer after page initialization
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

On Mon, 18 Nov 2019 at 12:45, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Nov 15, 2019 at 04:28:10PM +0000, Ard Biesheuvel wrote:
> > On Fri, 15 Nov 2019 at 15:31, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > When the commit 69c1f396f25b ("efi/x86: Convert x86 EFI earlyprintk
> > > into generic earlycon implementation") moved x86 specific EFI earlyprintk
> > > implementation to shared location it also tweaked the behaviour. In particular
> > > it dropped a trick with full framebuffer remapping after page initialization.
> > > This lead to two regressions:
> > > 1) very slow scrolling after page initialization;
> > > 2) kernel hang when keep_bootcon parameter is being provided.
> > >
> > > Returning the trick back fixes #2 and mitigates, i.e. reduces the window when
> > > slowness appears, #1 presumably due to eliminating heavy map()/unmap()
> > > operations per each pixel line on the screen.
>
> > > +/*
> > > + * efi earlycon needs to use early_memremap() to map the framebuffer.
> > > + * But early_memremap() is not usable for 'earlycon=efifb keep_bootcon',
> > > + * memremap() should be used instead. memremap() will be available after
> > > + * paging_init() which is earlier than initcall callbacks. Thus adding this
> > > + * early initcall function early_efi_map_fb() to map the whole efi framebuffer.
> > > + */
> > > +static int __init early_efi_map_fb(void)
> > > +{
> > > +       if (!fb_base || !fb_size)
> > > +               return NULL;
> > > +
> >
> > 'return 0' please.
>
> Ah, sorry. Though I think we rather return -ENOVEV here.
>

fb_base and fb_size will only be set if earlycon=efifb is passed, so
this is not an error condition, and so returning an error is
incorrect.

> > I'll test this on actual arm64 hardware somewhere next week, and queue
> > it if it doesn't break anything (no need to resend for the above)
>
> Thanks!
>

Works fine for me

Tested-by: Ard Biesheuvel <ardb@kernel.org> # arm64

> > > +       if (pgprot_val(fb_prot) == pgprot_val(PAGE_KERNEL))
> > > +               efi_fb = memremap(fb_base, fb_size, MEMREMAP_WB);
> > > +       else
> > > +               efi_fb = memremap(fb_base, fb_size, MEMREMAP_WC);
> > > +
> > > +       return efi_fb ? 0 : -ENOMEM;
> > > +}
> > > +early_initcall(early_efi_map_fb);
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
