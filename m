Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350D973E738
	for <lists+linux-efi@lfdr.de>; Mon, 26 Jun 2023 20:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjFZSKM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 26 Jun 2023 14:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjFZSKL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 26 Jun 2023 14:10:11 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF1A106
        for <linux-efi@vger.kernel.org>; Mon, 26 Jun 2023 11:10:10 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f122ff663eso4739408e87.2
        for <linux-efi@vger.kernel.org>; Mon, 26 Jun 2023 11:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687803008; x=1690395008;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GEmhtPeUuBTNw1wJ10wbdi6R1iuqa5Zv9dqEbDqZ6a0=;
        b=gQE703zfB0xFP9vTWopal2tbzAO+ZKzoTBTAGctb52bPLxW9krEvrZA0oqXMnCDb2l
         su77uJfCPAnoONEiv/MnoyK1AAzvK6t2jvPv+RmoQbLCmDnXO8hyMuCqWjzZXhtQdvQ6
         BZwieJPTJUVGVaIbZvgdK15RuJr805YQom6ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687803008; x=1690395008;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GEmhtPeUuBTNw1wJ10wbdi6R1iuqa5Zv9dqEbDqZ6a0=;
        b=BqO11ucQLSCeZstWmcuKq1roQZoY7nGil19JifMW/vA9fXG/UnPbRwZA+gHpwzQhN1
         ZelgPCesFctvJWHz/HMV+s/dPNPQ02wV8kmUGvyE342oR8/Wee+uRyg+bjXZbYZv9Cf2
         Dz+gtWoFpvYIRGFuCbj4RvF7AuI8mlOvH8qVGdmijB+VebR3AYtYOjRCsjAoDsWhZ3Sj
         /ILsT9kdrDuxwviLzz1aAn8FjMUeSePuLQ7e7ugcFhICkXkR9cbnCwq+35aVYq8+ArZw
         KPcGT/uDR684IS/XH+4qAulRwDDAcDu2YSwDgy9eONd2UO+w9yrfLk/jonzdBQrsTnu5
         agNQ==
X-Gm-Message-State: AC+VfDz73lVglG7OQO0u+144vmONjUxFDMhEvq/4ICt7lFIKTDabRSG0
        +Va0GWYdSukNhs4EQK5WBmtJdCaH91m7WSAiTqlPKUxX
X-Google-Smtp-Source: ACHHUZ4GthY/6ImO7ug/sm5haF3lNaVy5idJL2idMa68TBce7rG/XAxb3NqAZUDfRsrXqsMC+rkUzw==
X-Received: by 2002:a19:641e:0:b0:4f9:556b:93c5 with SMTP id y30-20020a19641e000000b004f9556b93c5mr11059628lfb.40.1687803008567;
        Mon, 26 Jun 2023 11:10:08 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id v12-20020ac2560c000000b004fb76438a83sm474890lfd.171.2023.06.26.11.10.07
        for <linux-efi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 11:10:07 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-4fb7589b187so1846190e87.1
        for <linux-efi@vger.kernel.org>; Mon, 26 Jun 2023 11:10:07 -0700 (PDT)
X-Received: by 2002:a19:670f:0:b0:4f8:7528:50b5 with SMTP id
 b15-20020a19670f000000b004f8752850b5mr12811760lfc.14.1687803007422; Mon, 26
 Jun 2023 11:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230626140836.299395-1-Jason@zx2c4.com>
In-Reply-To: <20230626140836.299395-1-Jason@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 26 Jun 2023 11:09:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=whNNTiytxveZay46jOaS_vOG7QV8gq=nW0vCjMzcVJFDA@mail.gmail.com>
Message-ID: <CAHk-=whNNTiytxveZay46jOaS_vOG7QV8gq=nW0vCjMzcVJFDA@mail.gmail.com>
Subject: Re: [PATCH] efi: random: refresh random seed on modern EFI only
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Sami Korkalainen <sami.korkalainen@proton.me>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 26 Jun 2023 at 07:08, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> EFI has a rather unique benefit that it has access to some limited
> non-volatile storage, where the kernel can store a random seed. Register
> a notification for when the RNG is initialized, and at that point, store
> a new random seed.

No.

We DO NOT DO THIS DURING EARLY BOOT.

Christ.

Stop the craziness. We already know that the machine that had problems
with this seems to literally have been problematic due to boot-time
issues, but worked after boot.

Now, I had hoped that Sami's test would have uncovered some smoking
gun actually explaining it, but that was not to be.

There's quite possibly some random ordering thing, but the fundamental
facts here are

 (a) early boot is hard to debug

 (b) there is absolutely no reason to do it during boot

 (c) entropy is at its weakest during boot

so there is no way in hell we are doing this thing during bootup, and
absolutely none of that has changed by checking some minimum EFI
version.

Don't ever re-send this crap again, ok?

               Linus
