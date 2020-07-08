Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D84217F3A
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jul 2020 07:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbgGHFrx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Jul 2020 01:47:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:36646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgGHFrx (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 8 Jul 2020 01:47:53 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90A2E2078B;
        Wed,  8 Jul 2020 05:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594187272;
        bh=odr9trJsY+/VsC6Xosek0mSc+vQ6GbRDKEYdCCZMdSo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QdQj6NOXnMcIaEde9I8wnVhX5udKqmtjfCgAjEZarbwMx7wP1jDq6Mlf33L4TJqH4
         ZxcsR5Xjg4pSyqPWParZr08LHAL9T2pI+rblZ2uZt92Gwmq0vFbocy33ZYi3qpz2WD
         0FmZsuP+AWos9zMRlXTvxQ2FSgIiXfx4mRj7Wd5E=
Received: by mail-ot1-f46.google.com with SMTP id 18so36064611otv.6;
        Tue, 07 Jul 2020 22:47:52 -0700 (PDT)
X-Gm-Message-State: AOAM532U/NIKnUm46iSMfhx/bj6F41s1DsSX4ZBUM3DPO5X6iPe37S4w
        puFhB9MwTxiPSVZQPrZU6oodGvnFA6iuMrLAZp0=
X-Google-Smtp-Source: ABdhPJxVYM8G/B91PuoHI3iKlcsxr9nlkQXIwunWm/EyQD8zmmYal7JTvWLeKxe5TkUvrvVN48Cl7uzrWGntQzgKkMs=
X-Received: by 2002:a9d:6e85:: with SMTP id a5mr7858191otr.90.1594187271970;
 Tue, 07 Jul 2020 22:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200707185818.80177-1-ebiggers@kernel.org>
In-Reply-To: <20200707185818.80177-1-ebiggers@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 8 Jul 2020 08:47:40 +0300
X-Gmail-Original-Message-ID: <CAMj1kXHPazApxFDK9nz=1V+-dyu7dStiMOu=LdD=i9NXqxjY=g@mail.gmail.com>
Message-ID: <CAMj1kXHPazApxFDK9nz=1V+-dyu7dStiMOu=LdD=i9NXqxjY=g@mail.gmail.com>
Subject: Re: [PATCH 0/4] crypto: add sha256() function
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        ALSA development <alsa-devel@alsa-project.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        mptcp@lists.01.org, Tzung-Bi Shih <tzungbi@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 7 Jul 2020 at 21:59, Eric Biggers <ebiggers@kernel.org> wrote:
>
> This series adds a function sha256() to the sha256 library so that users
> who want to compute a hash in one step can just call sha256() instead of
> sha256_init() + sha256_update() + sha256_final().
>
> Patches 2-4 then convert some users to use it.
>
> Eric Biggers (4):
>   crypto: lib/sha256 - add sha256() function
>   efi: use sha256() instead of open coding
>   mptcp: use sha256() instead of open coding
>   ASoC: cros_ec_codec: use sha256() instead of open coding
>

For the series,

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

Feel free to take the EFI patch through the crypto tree.


>  drivers/firmware/efi/embedded-firmware.c |  9 +++-----
>  include/crypto/sha.h                     |  1 +
>  lib/crypto/sha256.c                      | 10 +++++++++
>  net/mptcp/crypto.c                       | 15 +++----------
>  sound/soc/codecs/cros_ec_codec.c         | 27 ++----------------------
>  5 files changed, 19 insertions(+), 43 deletions(-)
>
>
> base-commit: 57c8aa43b9f272c382c253573c82be5cb68fe22d
> --
> 2.27.0
>
