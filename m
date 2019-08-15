Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F90F8EB5C
	for <lists+linux-efi@lfdr.de>; Thu, 15 Aug 2019 14:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbfHOMRz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 15 Aug 2019 08:17:55 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40031 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfHOMRz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 15 Aug 2019 08:17:55 -0400
Received: by mail-oi1-f194.google.com with SMTP id h21so1639126oie.7
        for <linux-efi@vger.kernel.org>; Thu, 15 Aug 2019 05:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qiHPGjT4mneYMl3fD4nR1DVCXwT+QkrTDhpYEK2suuY=;
        b=Pz8jPn2ssah6wDKBoYBYUccQCuMtseV2gmbUSR6owqpMBWN9Cty3HMjyGGotgLgLpq
         XSnGPLII2A2MPPyieBaIv8hHgVLz59J3n0vMZlXJA/BDDaf2wATg4HGr6/jaraUdndmY
         CtyEZXuX6H/ijAdh1hJe9AJDNJSz2Jo2HKWpsKpQB0C4QvhsyqBc9u9s69n+uHTfGRbu
         eCILRmSuPu9PJ24WpQcs0zik7YzGfBXAFO8sdFn9Spte+xICXto+IAes3vyL6kv5L7fc
         0cbil574Wm0Az4sAx48AeWTiY7Sey4k7y4ySWPK+FyBlNHk3DHIPDFcH/B5hvMfsiVWu
         YZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qiHPGjT4mneYMl3fD4nR1DVCXwT+QkrTDhpYEK2suuY=;
        b=mrNpl+vNhaNjkYqTBeM0pHz8zWkJXxDvov3xpfXR9YAmEohEYSJCVEwOqYahODgIxj
         h8M4HhyIg+Wgr7lNfxrtuHV4avjXA6VnDZbV8LW4M/g1zvEsfUi4iFVudyFpsQ1rmGL5
         ssFbKmgEvJFw8Ah/tVXZgvkwkjSK2rCDH+VyqHWCfgo2OBb7Z3uU+ZEP5yYOQepMC+4T
         eQyJfb+IvL5AKX2UI+lhwosa9T9whsv7sAOD1zr7ZN/12h5H1gUpZ1gPcgWoJU9R1ZJW
         GyIGQ7+gJsIoIy/CvrK4peaKl5z/xUb7ZuOvVonaCiFz4yvClUmr3qv/gpOF8Qwfr0B9
         pPkA==
X-Gm-Message-State: APjAAAUH56h+gGrKwGC6nCb23vZq3F1FOP4S4qRsPoK9B2dUphneWxRo
        uviXq5vGKa8inJ2CvL60pkhGBKghAzu+Cu8IBRHLZTvY
X-Google-Smtp-Source: APXvYqyTHlBfanB0RcgyIq8wqbHngOvK8tDZPm/Kf0+Fa9l9pm3GZxeqZYAEWxknIpv56rEilGUWk9kH61mwxvsOIDk=
X-Received: by 2002:aca:b254:: with SMTP id b81mr1351818oif.53.1565871474876;
 Thu, 15 Aug 2019 05:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAJrUJt_HV+8MCGxv4=bq97JFiKqPtgN4ntfei0TmxGhDT-bCQg@mail.gmail.com>
 <20190815110308.GA22153@lakrids.cambridge.arm.com> <CAKv+Gu-OoFZRy_fv1z3GmTH3rp=TKviO7rEeFXwqqiWzbgJf3A@mail.gmail.com>
In-Reply-To: <CAKv+Gu-OoFZRy_fv1z3GmTH3rp=TKviO7rEeFXwqqiWzbgJf3A@mail.gmail.com>
From:   skodde <skodde@gmail.com>
Date:   Thu, 15 Aug 2019 08:17:43 -0400
Message-ID: <CAJrUJt_hJJChKviBG5jvkUhv=OJrGPWpxF9aBB=S8-mL4URFOA@mail.gmail.com>
Subject: Re: arm64/efistub boot error with CONFIG_GCC_PLUGIN_STACKLEAK
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Aug 15, 2019 at 7:21 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On Thu, 15 Aug 2019 at 14:03, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Thu, Aug 15, 2019 at 05:56:27AM -0400, skodde wrote:
> > > The kernel boots fine with that option disabled, but strangely
> > > presents the same error when disabling only CONFIG_RANDOMIZE_BASE.
> >
> > That shouldn't be possible, given the IS_ENABLED(CONFIG_RANDOMIZE_BASE)
> > guard around the efi_get_random_bytes() call, so something sounds wrong.
> >
> > Maybe there's a problem with stale objects. If you're not doing so
> > already, could you try a clean build with CONFIG_RANDOMIZE_BASE
> > deselected?
> >
> Also, can you try booting with the nokaslr command line option added?

You were right, I haven't tried with nokaslr, but it worked fine by
rebuilding the kernel after a distclean with CONFIG_RANDOMIZE_BASE
disabled and CONFIG_GCC_PLUGIN_STACKLEAK enabled. That's what I was
expecting the first time and this is the reason why I mentioned it.
I've been recompiling too many times, sorry about that.

Anyhow, the main issue is the efi_get_random_bytes() fail with
CONFIG_GCC_PLUGIN_STACKLEAK enabled, and that's still valid.


Thanks
