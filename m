Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A014B481D30
	for <lists+linux-efi@lfdr.de>; Thu, 30 Dec 2021 15:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbhL3OkW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Dec 2021 09:40:22 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52020 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbhL3OkW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 30 Dec 2021 09:40:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E315CB81C5C;
        Thu, 30 Dec 2021 14:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34DB6C36AED;
        Thu, 30 Dec 2021 14:40:19 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="RXdHN0Op"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1640875216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MzNV7SQ7psPPB0GDu1mCaoJSBE2Rx6BV8EzIdyhHHbo=;
        b=RXdHN0OpqdXtqrgKPj43w7+KIohJuyRSEA5zOuJ+789Q9v49Kvepfw3jZ6KfCbsohzt/Cd
        u5OEHKU6ZLaVDu/CMrAw6t6IV5jzfy1dH1UswkRlQntbluWLCmIEAUAQJ/EF8Bg4Qho/0H
        6XDsHQJlSxy7LiBYDuxfeyMJJRCjDYs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6b9a65e8 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 30 Dec 2021 14:40:16 +0000 (UTC)
Received: by mail-yb1-f173.google.com with SMTP id k69so57172106ybf.1;
        Thu, 30 Dec 2021 06:40:16 -0800 (PST)
X-Gm-Message-State: AOAM533TbF/7uVeyvCcYoGkYApdsNXHrW/MXIHrihO/zM39MgeHtL8yi
        QA1Aj6wad2z9aqOn7j2JkFKedPY9Qlb8CwYTAA0=
X-Google-Smtp-Source: ABdhPJzwdlHoqaLQBHQkuTcxpjumUC+xuzhYpIYHtzMxpcoXfxLfkW8ChrnxIONsU3LPMTO8QxdgFQBq8hygbJHAtR4=
X-Received: by 2002:a25:854f:: with SMTP id f15mr29103630ybn.121.1640875215633;
 Thu, 30 Dec 2021 06:40:15 -0800 (PST)
MIME-Version: 1.0
References: <20211228153826.448805-1-Jason@zx2c4.com> <20211229211009.108091-1-linux@dominikbrodowski.net>
 <20211229211009.108091-6-linux@dominikbrodowski.net>
In-Reply-To: <20211229211009.108091-6-linux@dominikbrodowski.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 30 Dec 2021 15:40:04 +0100
X-Gmail-Original-Message-ID: <CAHmME9ogFn8deTmVMfKLjQ727kgGzuWRgaNaDW2PF+KwyQw0uQ@mail.gmail.com>
Message-ID: <CAHmME9ogFn8deTmVMfKLjQ727kgGzuWRgaNaDW2PF+KwyQw0uQ@mail.gmail.com>
Subject: Re: [PATCH v8 6/7] random: early initialization of ChaCha constants
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Ivan T . Ivanov" <iivanov@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Thanks for the patch. Comments are inline below.

On Wed, Dec 29, 2021 at 10:13 PM Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
>  drivers/char/random.c   | 10 +++++++---
>  include/crypto/chacha.h | 15 +++++++++++----

For the next submission of this (which you can do standalone and call
a v2), please Cc linux-crypto and Herbert as part of the commit body.
I still intend to take this through the random tree, since that's the
purpose of it, but because it touches the lib/crypto code, they should
be in the loop.

>  static struct crng_state primary_crng = {
>         .lock = __SPIN_LOCK_UNLOCKED(primary_crng.lock),
> +       .state[0] = CHACHA_CONSTANT_EXPA, /* "expa" */
> +       .state[1] = CHACHA_CONSTANT_ND_3, /* "nd 3" */
> +       .state[2] = CHACHA_CONSTANT_2_BY, /* "2-by" */
> +       .state[3] = CHACHA_CONSTANT_TE_K, /* "te k" */
>  };

I don't think you need the comments here, since the constant is
already descriptive.

>
>  /*
> @@ -823,9 +827,9 @@ static void __maybe_unused crng_initialize_secondary(struct crng_state *crng)
>         crng->init_time = jiffies - CRNG_RESEED_INTERVAL - 1;
>  }
>
> -static void __init crng_initialize_primary(struct crng_state *crng)
> +static void __init crng_initialize_primary(void)
>  {
> +       struct crng_state *crng = &primary_crng;
> -       crng_initialize_primary(&primary_crng);
> +       crng_initialize_primary();

There are a bunch of places where we're passing around globals when we
could collapse them down. It probably makes sense to do that in a
separate cleanup series (please feel free!), rather than here, since
the init-time constants issue doesn't really change anything with
regards to this function signature.

>  static inline void chacha_init_consts(u32 *state)
>  {
> -       state[0]  = 0x61707865; /* "expa" */
> -       state[1]  = 0x3320646e; /* "nd 3" */
> -       state[2]  = 0x79622d32; /* "2-by" */
> -       state[3]  = 0x6b206574; /* "te k" */
> +       state[0]  = CHACHA_CONSTANT_EXPA; /* "expa" */
> +       state[1]  = CHACHA_CONSTANT_ND_3; /* "nd 3" */
> +       state[2]  = CHACHA_CONSTANT_2_BY; /* "2-by" */
> +       state[3]  = CHACHA_CONSTANT_TE_K; /* "te k" */
>  }

I don't think you need the comments here, since the constant is
already descriptive.
