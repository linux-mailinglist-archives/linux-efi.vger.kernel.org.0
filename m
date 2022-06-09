Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBF95447BD
	for <lists+linux-efi@lfdr.de>; Thu,  9 Jun 2022 11:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238888AbiFIJjs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Jun 2022 05:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiFIJjr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 9 Jun 2022 05:39:47 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B5E43EDD
        for <linux-efi@vger.kernel.org>; Thu,  9 Jun 2022 02:39:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CB6ABCE2D6A
        for <linux-efi@vger.kernel.org>; Thu,  9 Jun 2022 09:39:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5DEBC34114
        for <linux-efi@vger.kernel.org>; Thu,  9 Jun 2022 09:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654767581;
        bh=J5V+wXbHWlMvf1mJbqOSCqP3zjZUCtW6hlqzLnFQp3M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HiQnWEKcDjqcKPEHDODMv2iT2MYov0eBJk9tEmTH/0gSt1IrErFczDttKMAhyvMMw
         QZ2PuPL4UjRGsxAOZ4aTSnUm/AVet7cpUAE2zd1Px6uprd4cyshXGCrHfajG+PHqiG
         mqxiWy3wPIq+/+vBw8uwOFiV8rsU1CQ4wt/RsBEsCl8AKajHe/VvpTDjzlwf1LN2Hy
         Rzb8adfl5z1VlSFdfvcs4C+94OymHAFu+Q+oTs6zZ8y+3a8+KNwnXmUyYbo6GqhZXf
         CENcx+IFwK+KSBNMoZf+NpZx3ON2mn2605D1tZVQPJdTR+V0qVxYxOJVYtVCkwPdRX
         Fgq7siGeFvgqw==
Received: by mail-ot1-f41.google.com with SMTP id 93-20020a9d02e6000000b0060c252ee7a4so737143otl.13
        for <linux-efi@vger.kernel.org>; Thu, 09 Jun 2022 02:39:41 -0700 (PDT)
X-Gm-Message-State: AOAM531cOiW/lvF4GFnSTydNnxcyAPxhJ6VWfOKe9Z7gJgyn/Nf5nWDw
        6TiieMY7pVdr1/hoHF4J4Y85qtnEAtYJLA21iCw=
X-Google-Smtp-Source: ABdhPJzVinqozw8Jx4aNT5vRE4FlQ5mPdo4oHE7TJIlLmNgPGJKlNzP/PT2zx/KwI0u37QAbfa+srXI/z57OZMV1IX4=
X-Received: by 2002:a05:6830:9c2:b0:606:1e0a:cc8d with SMTP id
 y2-20020a05683009c200b006061e0acc8dmr16470296ott.265.1654767581013; Thu, 09
 Jun 2022 02:39:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220608153216.1480073-1-ardb@kernel.org> <YqG3QRovkHQ0TJib@zx2c4.com>
In-Reply-To: <YqG3QRovkHQ0TJib@zx2c4.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 9 Jun 2022 11:39:26 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF95qX-jMUqPtXYzKZMVzRj0zo7fERx1Cchi_SFSG0+CQ@mail.gmail.com>
Message-ID: <CAMj1kXF95qX-jMUqPtXYzKZMVzRj0zo7fERx1Cchi_SFSG0+CQ@mail.gmail.com>
Subject: Re: [PATCH] efi: random: wait for CRNG to become ready before
 refreshing the seed
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 9 Jun 2022 at 11:03, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi Ard,
>
> I'm trying to break the analysis down a bit to figure out what should be
> done here. Can you tell me if any of these points are incorrect?
>
> Case 0) EFI fails to provide any randomness at all.
>         Result: nothing happens on kexec; add_bootloader_randomness() is
>         used by nobody.
>
> Case 1) EFI provides randomness. Parent kernel is trust_bootloader=y.
>         Child kernel is trust_bootloader=y.
>         Result: parent makes new seed for child, and everything works fine.
>
> Case 2) EFI provides randomness. Parent kernel is trust_bootloader=y.
>         Child kernel is trust_bootloader=n.
>         Result: parent makes new seed for child, which child doesn't
>         credit, but everything still works fine.
>
> Case 3) EFI provides randomness. Parent kernel is trust_bootloader=n.
>         Child kernel is trust_bootloader=n.
>         Result: parent makes new seed for child using a technically
>         uninitialized RNG that is still of EFI-quality, which child
>         doesn't credit, so everything still works fine.
>
> Case 4) EFI provides randomness. Parent kernel is trust_bootloader=n.
>         Child kernel is trust_bootloader=y.
>         Result: parent makes new seed for child using a technically
>         uninitialized RNG that is still of EFI-quality, which child then
>         credits. On the surface, this seems bad. But actually, the
>         randomness here is still at least as good as what EFI provided,
>         which is what trust_bootloader=y means anyway. So I think this
>         case is actually fine.
>
> Since all cases are fine, I don't think this patch is actually needed.
> The interesting thing about this exercise, though, is that the thing
> that enables this conclusion is the base case 0, where we notice that
> kexec doesn't pass a seed if EFI isn't passing any randomness in the
> first place. Were that not so, then case 4 would be dangerous.
>

Indeed.

> The question I have is whether the same holds for how device tree is
> doing things. There, they check rng_is_initialized(), which means the
> worst is avoided, I suppose, but doing so precludes the nice properties
> that EFI has for cases 3 and 4. Is there a way to do things better
> there, or not really?
>

I suppose we could zero the existing rng-seed property instead of
dropping it entirely, and only repopulate it if it existed in the
first place.

The only problem here is that the kernel itself is not in charge of
instantiating the original rng-seed property - it is whatever the DT
contained and DTs are often kept in files. But this just boils down to
whether or not the DT seed can be trusted to begin with.
