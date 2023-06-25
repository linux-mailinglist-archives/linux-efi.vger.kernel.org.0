Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE4373D37C
	for <lists+linux-efi@lfdr.de>; Sun, 25 Jun 2023 21:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjFYT6n (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 25 Jun 2023 15:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjFYT6n (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 25 Jun 2023 15:58:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3C3B8
        for <linux-efi@vger.kernel.org>; Sun, 25 Jun 2023 12:58:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90DE460C05
        for <linux-efi@vger.kernel.org>; Sun, 25 Jun 2023 19:58:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDEC0C433C9
        for <linux-efi@vger.kernel.org>; Sun, 25 Jun 2023 19:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687723121;
        bh=OAe2yDxRNHKzqyr71x7vf67fqPSSQU5Hk6MnI6VvuQs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=amB3HGjx2R52tYTMvnxpy9heYOb4wddnGi5T4xkEupZjeY4M0IZAn3ZhUdp8YzJav
         ztu7YgroZo34SCOyANHvNOa8NwStPG7jZ9ZdfQ4unyN9yaKsVYuSzixw0ELZx3FqEC
         o0sdwx8pADDtpVvyR0aBmP1rMeQ2nFXISCX7JX2qy2JxeQGcasjTvwxe0UrzY1Uwe0
         J16Nm6v5pWRksBBAt6Ma95Rat5/vwMMu5s7maGky0m85onsQiC6MBVKJCe3WhYqn8c
         OmrP8staJiFiIbDVtNcmQPSIf0jBdb46Kr4L4b8UWyNFbsgy7TaOf3bt07iY6pKG+P
         GqW3EHHMoTCIQ==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2b699a2fe86so11514261fa.3
        for <linux-efi@vger.kernel.org>; Sun, 25 Jun 2023 12:58:40 -0700 (PDT)
X-Gm-Message-State: AC+VfDwJg+VM+Vp40WgpQjpYDvlwotxYfPBrBibWgJYxjXG693L82Lre
        G664iOYpKw4VDBraiwERxxLBNFiB6k9vvvE5WMM=
X-Google-Smtp-Source: ACHHUZ7YRdN9GWWN51OKsHm5CcMiGMcC9FYW2Rioo3yuH9f1TqCboFTVxyDW0milZq0XlJmjyAsvPI6AeBpdg86fZuU=
X-Received: by 2002:ac2:5b0c:0:b0:4f8:666b:9de8 with SMTP id
 v12-20020ac25b0c000000b004f8666b9de8mr14270573lfn.13.1687723118991; Sun, 25
 Jun 2023 12:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230624180446.2048867-1-ardb@kernel.org> <ZJhSysqUcxOqh37n@zx2c4.com>
 <CAHk-=witNP7Ejgdk8YBZs5ujdxbjqYOVLdbtAsZC1NWoiPWkvA@mail.gmail.com>
In-Reply-To: <CAHk-=witNP7Ejgdk8YBZs5ujdxbjqYOVLdbtAsZC1NWoiPWkvA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 25 Jun 2023 21:58:27 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHkX_PfL5+VpP1EgE4AEG4jiUBYuJYtXmuXEx0y+e93Dw@mail.gmail.com>
Message-ID: <CAMj1kXHkX_PfL5+VpP1EgE4AEG4jiUBYuJYtXmuXEx0y+e93Dw@mail.gmail.com>
Subject: Re: [PATCH] efivarfs: Expose RandomSeed variable but with limited permissions
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Sami Korkalainen <sami.korkalainen@proton.me>,
        linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 25 Jun 2023 at 21:22, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
...
>
> Yes, those are presumably mostly old EFI setups, but that is kind of
> the basic problem here. Many of these EFI calls are much more tested
> and reliable in the context of EFI boot services, and *much* less
> reliable in the context of "runtime services".
>

Many of these systems shipped with Vista or older booting in BIOS
emulation mode (CSM), so the OS visible API surface was barely tested,
not even by booting Windows (which appears to be the gold standard for
EFI compliance testing according to the OEMs building Windows PCs)

> EFI runtime services have been a major PITA over the years. And it's
> possible that it's just entirely broken on Sami's laptop.
>

Agreed. The virtual remapping stuff is particularly nasty, and a
constant source of problems, also on arm64, even though it is
completely pointless on 64-bit architectures. So I'm generally not a
fan of wiring up more of the EFI runtime stuff, but I did not
anticipate issues like this one with the varstore API that we already
use in various other places.

> I'm not entirely sure which laptop it is, with laptop manufacturers
> often re-using model names over several years, but "HP 6730b" seems to
> be basically from July 2008 (going by the service manual I found). So
> we're talking 15 years ago, and yes, EFI was likely *much* less
> reliable back then.
>

Yeah. What we might consider is keying off of the UEFI revision field
at a certain cutoff value (e.g., only support this for ~v2.4 or
higher), but this would be somewhat arbitrary, of course. I'd rather
have an explicit opt-in, but that is policy, making user space a more
appropriate venue for this.
