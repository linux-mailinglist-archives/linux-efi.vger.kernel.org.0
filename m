Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5865BEB42
	for <lists+linux-efi@lfdr.de>; Tue, 20 Sep 2022 18:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiITQmA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Sep 2022 12:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiITQl7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 20 Sep 2022 12:41:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1478C69F5E
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 09:41:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C41362474
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 16:41:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE86EC433B5
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 16:41:47 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="BtUq8jQ5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1663692105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WZ7yI5ZMldD+cFtThwnrXVDTxyK6TpGifwjJN7Ykn4g=;
        b=BtUq8jQ5y0uLYVVxtGZ0ZwriFTnqUIB8M5QOHfy59ZI/h1wMpOQV4+MGKxvPsE3HKLGU9T
        MxLSKAOVtsNSWWuHHWO5QdYNBYZnTQuXNv5NpORxFFeT9cEoW3xvbHl9P/4NcghNMP8Sml
        l4lYY344bMK/AbeUqZMe9UOpcAQCPOA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b8e19c2f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-efi@vger.kernel.org>;
        Tue, 20 Sep 2022 16:41:45 +0000 (UTC)
Received: by mail-vk1-f176.google.com with SMTP id b15so1735990vkp.2
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 09:41:45 -0700 (PDT)
X-Gm-Message-State: ACrzQf1Zt/Q+UthjxJgwJpivOlQgRWf/YMpaRO9dJCgKV1wrSVsR+VxK
        nNFsFXKwob9hUqIid3JUaa26GSUeSIfulVxMuD8=
X-Google-Smtp-Source: AMsMyM70Tv7yZD1DdImba+n/l49ktXlNXM+K6EivA/ZdyjuZt+a/w+s/lcoOClhAXAWBv9ogucKc6ymgCtH0IbnKHEo=
X-Received: by 2002:a1f:24b:0:b0:3a3:ad4:a3b2 with SMTP id 72-20020a1f024b000000b003a30ad4a3b2mr7739017vkc.13.1663692104560;
 Tue, 20 Sep 2022 09:41:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220919160931.2945427-1-ardb@kernel.org> <20220919160931.2945427-4-ardb@kernel.org>
 <YynqHm//QwEBzBWr@gardel-login>
In-Reply-To: <YynqHm//QwEBzBWr@gardel-login>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 20 Sep 2022 18:41:33 +0200
X-Gmail-Original-Message-ID: <CAHmME9qvaAT4zyu7VbKEkrQDjqSVY3gHRk+xvZp+TCchod7d2A@mail.gmail.com>
Message-ID: <CAHmME9qvaAT4zyu7VbKEkrQDjqSVY3gHRk+xvZp+TCchod7d2A@mail.gmail.com>
Subject: Re: [PATCH 3/3] efi: random: combine bootloader provided RNG seed
 with RNG protocol output
To:     Lennart Poettering <lennart@poettering.net>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Sep 20, 2022 at 6:28 PM Lennart Poettering
<lennart@poettering.net> wrote:
> I was wondering though, shouldn't the memory the seed data is stored
> in be zeroed out when you dispose of it, just for safety?

I mentioned the same. I think Ard is gonna handle that for v2, in
addition to freeing the prior seed's allocation.

> > +     blake2s_final(&state, seed->bits);
>
> And here, shouldn't the state struct be zeroed out? (or does
> blake2s_final() do that implicitly?

In this case, blake2s_final does it implicitly.
