Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4C8911D2E8
	for <lists+linux-efi@lfdr.de>; Thu, 12 Dec 2019 17:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbfLLQ56 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Dec 2019 11:57:58 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39453 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbfLLQ55 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 Dec 2019 11:57:57 -0500
Received: by mail-wm1-f66.google.com with SMTP id d5so3333189wmb.4
        for <linux-efi@vger.kernel.org>; Thu, 12 Dec 2019 08:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nrhHmmWG6ZTX5+x4X3+AWEGGcmY8Wfs7R6zkQJKl2zU=;
        b=E+EayL/MsCj4TQDokvtlsT1HcSU5y8CAf3mu0ps6Uluh8/XlBca9HWCwWAVTGDKEj0
         01GvR0UP+/dthtjCR6xhAT+zgjTgjK1SwX9FiT96gDTamngl8F1TVKM+lf6LKqjot+0J
         s85xNeI598vNuv6rY41/zwnu3H/sA7Kykz8mYvLiEq18tOargex2fwOFSblLiZaXVD6N
         qG8UE2QC1K17eK5UmjDyW57Sl2JEmunPmycuu1mJGzXodi3C4HOMiWfi75t9yZTkQA6u
         o+CodHj+ZqQavZNfW/ny4KSiVDBIv50184VjB5cQCrv4Sd4uMxNQ2Gqo9IRQ2Eoobw4P
         OyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nrhHmmWG6ZTX5+x4X3+AWEGGcmY8Wfs7R6zkQJKl2zU=;
        b=lBFhutY3sf3lUgjZyzImDjQCjOzPWujLJsQ0EyIxuXHsFGdGsoPscwKWGsDT5i2qGY
         tpQtMKVL5eJXZIHJJ8BTIwqXpotKUVFsWGCLlc2a89eF3YHfLD4Mw7maSeCt5Zw9afBy
         FYjpdRh8hrxMWOe5ZugmgASSsTzKWm0ERuZUrV24TXx7GxBHyet63aSAKCyjHjQfssin
         6AuoiMwkbDTjEM7zf71eU63mM+VUBjDtRIytZrait/XEnmquITycGLtHsIum5P8mVunI
         PlnWmdYVU1Cish7PzHIsyOF3LrOYZTpvwlbpgTD5oRmAsQpjnm8WgFZ+QoJuHWojgbmV
         PQeA==
X-Gm-Message-State: APjAAAWh4lqzB9XDKbpehAQIJLNvIPYo4vyf5rVgPtY+2sbp32qeVuNX
        dl71FNXw+ExbdpWowCCWqHmHAF7AHH3mdLwzqth2Ow==
X-Google-Smtp-Source: APXvYqzc8FhDkJnVj/eoIPyG6FAyooTk4A4Ejx1+nyQc5vqwcwknY/JGRtN8uvGVgf/wC2xA0tRs/fpxWHlwbik2KS4=
X-Received: by 2002:a1c:7205:: with SMTP id n5mr8015316wmc.9.1576169875370;
 Thu, 12 Dec 2019 08:57:55 -0800 (PST)
MIME-Version: 1.0
References: <20191210232410.17890-1-nivedita@alum.mit.edu> <CAKv+Gu8s=kT_21WasEsTRh+6COQYD0mpzOT5n0qhD1Y+YdR3JQ@mail.gmail.com>
 <20191211110435.GP32742@smile.fi.intel.com> <20191211173746.GA220404@rani.riverdale.lan>
 <20191211180330.GZ32742@smile.fi.intel.com> <CAKv+Gu8TbPg_SGZvTc+ZHgTnAq9zYtei7ZgqpdHv=5nNpW4j1Q@mail.gmail.com>
 <20191211200007.GB32742@smile.fi.intel.com> <20191212165649.GA117958@rani.riverdale.lan>
In-Reply-To: <20191212165649.GA117958@rani.riverdale.lan>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 12 Dec 2019 17:57:44 +0100
Message-ID: <CAKv+Gu9v=oSyQL6hmxDBVgZb9tEq+LTtWaUDN7vRyViEKAxEgA@mail.gmail.com>
Subject: Re: [PATCH] efi/earlycon: Fix write-combine mapping on x86
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 12 Dec 2019 at 17:56, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Wed, Dec 11, 2019 at 10:00:07PM +0200, Andy Shevchenko wrote:
> > On Wed, Dec 11, 2019 at 06:06:28PM +0000, Ard Biesheuvel wrote:
> > > On Wed, 11 Dec 2019 at 19:03, Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Wed, Dec 11, 2019 at 12:37:46PM -0500, Arvind Sankar wrote:
> >
> > > > Perhaps comment near to if can explain this.
> >
> > > I'm fine with the ternary, actually. What do you feel is wrong with it?
> >
> > I don't like ternary when it takes more than one line. I found them hard to
> > follow.
> >
> > It's anyway style, so, go ahead with it.
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
> >
> Thanks.
> > > Can't we just set a global flag to MEMREMAP_WB or MEMREMAP_WC in the
> > > init code, and use that directly?
> > We can't use it directly in efi_earlycon_map though, so we still need to
> > translate there, and we'd need an if/else in the init code, so this
> > would just move the if/else from here to the init code.
>
> Ard, re your comment, does that cover it and the patch is ok as it
> stands then?

Yes.

I have queued it up and will send it out shortly.
