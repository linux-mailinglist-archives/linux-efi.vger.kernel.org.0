Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C734668B6
	for <lists+linux-efi@lfdr.de>; Thu,  2 Dec 2021 17:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359780AbhLBQ6u (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Dec 2021 11:58:50 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59378 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359757AbhLBQ6u (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Dec 2021 11:58:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E530FB82426;
        Thu,  2 Dec 2021 16:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481F9C00446;
        Thu,  2 Dec 2021 16:55:25 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="DIB1VVOy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1638464123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zCSJuZT9xG/m6fOsrS14dS2EhlTLMTqBnP7Ru/8SiFs=;
        b=DIB1VVOyNJUriekkQKhBZwxqv1aSh920XRFeLQaiPIKFLOYSnWYto+PJnpRiSWG3Zn+XIU
        A8VgPHfzEkLjfnCWRDNFxvHVSbEGJvOMd6gYLpGV3PVSoELnrOkx4xTUEdbIA4CIgu/ysh
        Jc0MyhsXWnREm0yWP3nreRnmdQpz04k=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 662d737d (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 2 Dec 2021 16:55:23 +0000 (UTC)
Received: by mail-yb1-f174.google.com with SMTP id v203so1312659ybe.6;
        Thu, 02 Dec 2021 08:55:22 -0800 (PST)
X-Gm-Message-State: AOAM533OOrZB0teM6fgwaM3lsEAbd0NN4O42CEPFwQeKQuPes8s5t2ad
        yFAHomxWk7N3t+SPLxj/A904fCidjduf+KmPvss=
X-Google-Smtp-Source: ABdhPJygWM6mGI+l8bNmakpGTLBI8trpMfaXH6dTgyFui3+jUjA565iJNl6gPqKRmDmW4YSUaWmuzYe8KPE2nXE9+Uw=
X-Received: by 2002:a25:ab86:: with SMTP id v6mr15989913ybi.457.1638464121596;
 Thu, 02 Dec 2021 08:55:21 -0800 (PST)
MIME-Version: 1.0
References: <20211012082708.121931-1-iivanov@suse.de> <YWVKAk4h5bsUA3b6@light.dominikbrodowski.net>
 <YaivhAV8LouB0zGV@light.dominikbrodowski.net>
In-Reply-To: <YaivhAV8LouB0zGV@light.dominikbrodowski.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 2 Dec 2021 11:55:10 -0500
X-Gmail-Original-Message-ID: <CAHmME9qxBeBzfKCjzfAFX9ZWAGKv1TKCQw3x22d_DmJtaAewLw@mail.gmail.com>
Message-ID: <CAHmME9qxBeBzfKCjzfAFX9ZWAGKv1TKCQw3x22d_DmJtaAewLw@mail.gmail.com>
Subject: Re: [PATCH v3, resend] random: fix crash on multiple early calls to add_bootloader_randomness()
To:     linux@dominikbrodowski.net
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        "Ivan T. Ivanov" <iivanov@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Dominik,

Thanks for the patch. One trivial nit and one question:

On Thu, Dec 2, 2021 at 6:35 AM Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
> +       /* We cannot do much with the input pool until it is set up in
> +        * rand_initalize(); therefore just mix into the crng state.

I think you meant "rand_initialize()" here (missing 'i').

> If the added entropy suffices to increase crng_init to 1, future calls
> to add_bootloader_randomness() or add_hwgenerator_randomness() used to
> progress to credit_entropy_bits(). However, if the input pool is not yet
> properly set up, the cmpxchg call within that function can lead to an
> infinite recursion.

I see what this patch does with crng_global_init_time, and that seems
probably sensible, but I didn't understand this part of the reasoning
in the commit message; I might just be a bit slow here. Where's the
recursion exactly? Or even an infinite loop?

As far as I can tell, that portion of credit_entropy_bits() breaks down as:

retry:
        entropy_count = orig = READ_ONCE(r->entropy_count);
   [ ... do some arithmetic on entropy_count ... ]
        if (cmpxchg(&r->entropy_count, orig, entropy_count) != orig)
                goto retry;

Why would this be infinite? Why wouldn't the cmpxchg eventually
converge to a stable value? I don't see any call that modifies
r->entropy_count or orig from inside that block. Is there some other
super-spinny concurrent operation?

Thanks,
Jason
