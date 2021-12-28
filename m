Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345694809D0
	for <lists+linux-efi@lfdr.de>; Tue, 28 Dec 2021 15:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbhL1OGW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Dec 2021 09:06:22 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45360 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbhL1OGV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Dec 2021 09:06:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 869206120B;
        Tue, 28 Dec 2021 14:06:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6159C36AE8;
        Tue, 28 Dec 2021 14:06:20 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="nmjVFMYC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1640700378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JCnRXacLhMlITNkmUnJxWexg4OJiJS91riEkz6/i8ZE=;
        b=nmjVFMYCaquZ9/Y7p7HDXk1eisGXD+W11sfsa2FHqJKg6xwOqpYvfwxbl7fZ2MCT5yYX5D
        oewASSvWw6tpT6D53xiZjeBawCmEOa24+FGoXvzJ5xnVxQB5E9NdjnrRpNAfflOB5cpHNa
        HdkUHA7nvnBu/jM34QP9ODBP/e1+KfY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 036db282 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 28 Dec 2021 14:06:18 +0000 (UTC)
Received: by mail-yb1-f179.google.com with SMTP id j83so35513424ybg.2;
        Tue, 28 Dec 2021 06:06:17 -0800 (PST)
X-Gm-Message-State: AOAM532RmZbM3euKBrAG6KJ0ESvgQ+ybAAQMUbM9EbWf7QHYd6vBdw/r
        8WSIt8Hf4ppR0pMVsEtobEP4hMleF+61UoZTi+E=
X-Google-Smtp-Source: ABdhPJxRQD+FL/QGhASL4oa0sY15DOVcn9SLxdvLN283YUr2MBQHWGARB6KFbqpE80ytTICehqJLV/HKfT13S6i56R8=
X-Received: by 2002:a25:854f:: with SMTP id f15mr17186357ybn.121.1640700376442;
 Tue, 28 Dec 2021 06:06:16 -0800 (PST)
MIME-Version: 1.0
References: <YcTIM+MWEbMGLpRa@light.dominikbrodowski.net>
In-Reply-To: <YcTIM+MWEbMGLpRa@light.dominikbrodowski.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 28 Dec 2021 15:06:05 +0100
X-Gmail-Original-Message-ID: <CAHmME9qC2iX5EvDLj5YBZBdDJ_n8xTUYZT73qonsEhbKCwizFw@mail.gmail.com>
Message-ID: <CAHmME9qC2iX5EvDLj5YBZBdDJ_n8xTUYZT73qonsEhbKCwizFw@mail.gmail.com>
Subject: Re: [PATCH v6] random: fix crash on multiple early calls to add_bootloader_randomness()
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Ivan T. Ivanov" <iivanov@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Dominik,

Thanks. I like where this is going. It seems like we can tackle this
problem and the other one separately like this as you've done. It'd be
helpful though if you could send the patches for all the problems in
one patchset so that I'm not left wondering, "hey what about this
other thing; did you forget it?" Since these issues are kind of
intermingled, it'd be nice to see how the puzzle pieces fit together.

One question about this patch:
- If crng_reseed is called early, before system_wq is non-NULL, that
block will be skipped. When will it be called again?
- There's no call to it in crng_initialize_primary/rand_initialize
when not trusting the CPU and such, and that block there isn't quite
the same as crng_reseed either.

Also, something I noticed when looking at this, which I'm not sure has
come up yet in the various problems identified:
- If crng_reseed is called early, but not too early, and that block is
called, we'll set crng_init=2 and do various things and print, "crng
init done\n".
- Later, when rand_initialize is called, if we're trusting the CPU and
such, we'll re-initialize it and print, "crng done (trusting CPU's
manufacturer)\n".
That seems like a problem, though I assume we haven't hit that yet
because the race window is pretty small, so we've mostly been crashing
on a NULL system_wq instead, or having crng_reseed called _after_
crng_initialize_primary/rand_initialize anyway.

Thanks a lot for working on this. If you get tired of this back and
forth, by the way, and want me to start proposing patches for you to
look at instead, we can trade off. I'm also happy to keep looking at
what you send; it's just that as we're already on v6 here, I'm hoping
you won't get too frustrated.

Jason
