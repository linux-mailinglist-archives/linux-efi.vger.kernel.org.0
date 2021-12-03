Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333DA467A73
	for <lists+linux-efi@lfdr.de>; Fri,  3 Dec 2021 16:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352655AbhLCPng (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Dec 2021 10:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245188AbhLCPng (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 3 Dec 2021 10:43:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17408C061751;
        Fri,  3 Dec 2021 07:40:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A527062B37;
        Fri,  3 Dec 2021 15:40:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F4FC53FD1;
        Fri,  3 Dec 2021 15:40:10 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="FcqUlTKc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1638546008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UGhio4QnX3x/UO4oG1imIpr3olIL5ddNsHdKAlUjEdI=;
        b=FcqUlTKcKR3GdrdsHcPObFnWm0C59/XQPhNtKeWgMKsqiY8Gec1ATxH4GPCY/w0ShV8633
        YoUatj5g/c/5E1fZuVdkF6oNeHq1w5m3umNq/albbRuBUIcp8h/MTd6OtISRXarmyydp9w
        jSTUJ0X9vS9Qq8Xyws/xED1Xp3IEPZM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4b508f95 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 3 Dec 2021 15:40:08 +0000 (UTC)
Received: by mail-yb1-f175.google.com with SMTP id d10so10504412ybe.3;
        Fri, 03 Dec 2021 07:40:08 -0800 (PST)
X-Gm-Message-State: AOAM532yCs2ouQNpikDJiG9dmqjwU1i23CKujnF6CADgKEEk7GYlLP39
        kU8MbRsPtS7A0CpjSIA/Ac6vozcaWN9MkYYep2c=
X-Google-Smtp-Source: ABdhPJxkkvNakIKUJQ4NIwzyEHKWVXP18fwqUxSRgy8I4AgCRdE6he6+4LBuFNKazRXexjS1+6UB57yM97b1r5oW7cI=
X-Received: by 2002:a25:2412:: with SMTP id k18mr23758724ybk.121.1638546006365;
 Fri, 03 Dec 2021 07:40:06 -0800 (PST)
MIME-Version: 1.0
References: <20211012082708.121931-1-iivanov@suse.de> <YWVKAk4h5bsUA3b6@light.dominikbrodowski.net>
 <YaivhAV8LouB0zGV@light.dominikbrodowski.net> <CAHmME9qxBeBzfKCjzfAFX9ZWAGKv1TKCQw3x22d_DmJtaAewLw@mail.gmail.com>
 <YanOIvAV1iPBEXR3@light.dominikbrodowski.net>
In-Reply-To: <YanOIvAV1iPBEXR3@light.dominikbrodowski.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 3 Dec 2021 16:39:55 +0100
X-Gmail-Original-Message-ID: <CAHmME9qGHo4n6QGxnE+O46pagOR0bA+9E8bi8ZLPAzMuMZpPwg@mail.gmail.com>
Message-ID: <CAHmME9qGHo4n6QGxnE+O46pagOR0bA+9E8bi8ZLPAzMuMZpPwg@mail.gmail.com>
Subject: Re: [PATCH v4] random: fix crash on multiple early calls to add_bootloader_randomness()
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        "Ivan T. Ivanov" <iivanov@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, hsinyi@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Dominik,

Thanks for your analysis. Some more questions:

On Fri, Dec 3, 2021 at 8:59 AM Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
> On subsequent calls to add_bootloader_randomness() and then to
> add_hwgenerator_randomness(), crng_fast_load() will be skipped. Instead,
> wait_event_interruptible() (which makes no sense for the init process)
> and then credit_entropy_bits() will be called. If the entropy count for
> that second seed is large enough, that proceeds to crng_reseed().
> However, crng_reseed() may depend on workqueues being available, which
> is not the case early during boot.

It sounds like *the* issue you've identified is that crng_reseed()
calls into workqueue functions too early in init, right? The bug is
about paths into crng_reseed() that might cause that?

If so, then specifically, are you referring to crng_reseed()'s call to
numa_crng_init()? In other words, the cause of the bug would be
6c1e851c4edc ("random: fix possible sleeping allocation from irq
context")? If that's the case, then I wonder if the problem you're
seeing goes away if you revert both 6c1e851c4edc ("random: fix
possible sleeping allocation from irq context") and its primary
predecessor, 8ef35c866f88 ("random: set up the NUMA crng instances
after the CRNG is fully initialized"). These fix an actual bug, so I'm
not suggesting we actually revert these in the tree, but for the
purpose of testing, I'm wondering if this is actually the root cause
of the bug you're seeing.

Also, if you have a nice way of reproducing this, please do tell - I'd
like to give it a spin if possible.

Regards,
Jason
