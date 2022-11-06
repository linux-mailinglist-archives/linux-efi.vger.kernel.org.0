Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E4161E6E7
	for <lists+linux-efi@lfdr.de>; Sun,  6 Nov 2022 23:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiKFWgJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 6 Nov 2022 17:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiKFWgJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 6 Nov 2022 17:36:09 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5F5A462
        for <linux-efi@vger.kernel.org>; Sun,  6 Nov 2022 14:36:08 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id s20so6299970qkg.5
        for <linux-efi@vger.kernel.org>; Sun, 06 Nov 2022 14:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JmaISGMAvawdCHAzrPk0+k0eLH24dwLm+iVulP79Wk4=;
        b=SiUEz33mnS1qoB6lNqKt6aBavlztoUxxKlGf4O5DwJJ6moBuh/RyDIdvyRPHA2kjRc
         gMal5ze0Ngushd2k3cMExZ2V2FwBxN5UD8iqV6Bwf8aggCDSJ2IKBou8eeflXxvz0ss/
         TA8SKshoN6LFnmf2pOIBRQKZjALwd/do9AmCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JmaISGMAvawdCHAzrPk0+k0eLH24dwLm+iVulP79Wk4=;
        b=2ab3HUtzKvgpEkMGJhcwEbI/H+/tWpiev7Zv96sNeJ1eOfbP1KtSd99B4PypmaOBsa
         ICob0GpzgBP+4yYbV/uQxAdCzAPgbQK9RTjo94Ce9s7lfk/N8JvIj8gavBcFwZuDyk0r
         Hr08sashVHFXrk1BsCcwZ/QhOIfDAY3mEN5yPUtK3tXs974yLQZmIRax7nLQxM4Jbq9a
         n/aHVgkFslxSEFAa84D1LrcRyGRf4CykqUM7G7t4a9tOztaF/TjY9JmjvcMfshnWzT5s
         G8sxRxQxMCbLO0DObbuuN0KOVMJAuSPk5KtB2WwPfl2YWoBiVzZVURrrQbVwr8hahmLO
         700A==
X-Gm-Message-State: ACrzQf0+OuctBGWEsnXAo5NfCV1H2P0/6oZ4gD3r/nIoccH4DcI/GbXx
        OqihI8lBYPfwDebF/DS/uFb6CD9uZPhMMg==
X-Google-Smtp-Source: AMsMyM7h6VEArYaqymuwVhHvLNAk1AkEGJwAqgvzqGzLCiQqieBN0NFmskjB33uCT5dY7MOpEjOXBQ==
X-Received: by 2002:a05:620a:6001:b0:6fa:4d19:2406 with SMTP id dw1-20020a05620a600100b006fa4d192406mr22430510qkb.482.1667774167175;
        Sun, 06 Nov 2022 14:36:07 -0800 (PST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id z10-20020ac87caa000000b003a50d92f9b4sm4815989qtv.1.2022.11.06.14.36.05
        for <linux-efi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Nov 2022 14:36:06 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-370547b8ca0so89775187b3.0
        for <linux-efi@vger.kernel.org>; Sun, 06 Nov 2022 14:36:05 -0800 (PST)
X-Received: by 2002:a0d:ef07:0:b0:373:5257:f897 with SMTP id
 y7-20020a0def07000000b003735257f897mr25909680ywe.401.1667774165583; Sun, 06
 Nov 2022 14:36:05 -0800 (PST)
MIME-Version: 1.0
References: <20221106145354.3876410-1-ardb@kernel.org> <CAHk-=wgQaL8Xudo-yhr8WTn7KJy=xUBw9+va-6_K=fdOY5xuOw@mail.gmail.com>
 <CAMj1kXHunuPfWj=rCsxR4MzNBLtSyogUY57jqd7DZyZsJmitmw@mail.gmail.com>
In-Reply-To: <CAMj1kXHunuPfWj=rCsxR4MzNBLtSyogUY57jqd7DZyZsJmitmw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Nov 2022 14:35:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjxpQvJnp09capoysVevvB9y3vq+bF2tZA0C82Ak16Rqw@mail.gmail.com>
Message-ID: <CAHk-=wjxpQvJnp09capoysVevvB9y3vq+bF2tZA0C82Ak16Rqw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: efi: Fix handling of misaligned runtime regions
 and drop warning
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Nov 6, 2022 at 2:34 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> > So "Acked-by" on the patch, and I hope I'll see it with a future arm64
> > or EFI pull request (and I'll holler loudly if it actually causes any
> > issues on my M2, but I obviously don't expect it to)
>
> Thanks for the ack. I'll drop it in the EFI fixes branch and let it
> soak in -next for the week.

.. and I guess I might as well make it explicit that yes, my M2 is
happy with the patch, rather than just that implicit silence about it.

                 Linus
