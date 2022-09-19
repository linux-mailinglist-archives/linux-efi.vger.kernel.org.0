Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE145BD237
	for <lists+linux-efi@lfdr.de>; Mon, 19 Sep 2022 18:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiISQ26 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 19 Sep 2022 12:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiISQ25 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 19 Sep 2022 12:28:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93743BC7C
        for <linux-efi@vger.kernel.org>; Mon, 19 Sep 2022 09:28:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 527D561E58
        for <linux-efi@vger.kernel.org>; Mon, 19 Sep 2022 16:28:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727F1C433D7
        for <linux-efi@vger.kernel.org>; Mon, 19 Sep 2022 16:28:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Kys3tpbL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1663604933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zF7AOtjjaUzn3U/9Ikk7n+fsfYLTIg3VZnQLR9ZvWo8=;
        b=Kys3tpbLsqTRseSvnSYe/cOV3wYt3RXs42Rai7vHHUbc9r4YJUWNs8AHyUkow2GWLZK+WF
        43Gjqni/Nqf+TrhYXzFOTgKXEFB+kHIK93tM02UcBRPDBY9QvTFsdSJmLN+IMRcxOJSDOd
        9hdZLpJvpMLKLnGHHs6Gb8W1RBB1lTo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ece248a8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-efi@vger.kernel.org>;
        Mon, 19 Sep 2022 16:28:53 +0000 (UTC)
Received: by mail-vs1-f54.google.com with SMTP id u189so130980vsb.4
        for <linux-efi@vger.kernel.org>; Mon, 19 Sep 2022 09:28:52 -0700 (PDT)
X-Gm-Message-State: ACrzQf0O0oH1pfrRzvMWDVQmARzr4+SffP3XzmWnM5z75KVfwaHOSB+p
        bZCCMm2DJWtlTT5I4yZS/ANdplFLanceqD3T6HM=
X-Google-Smtp-Source: AMsMyM5LJVGGtJ2MOdBZAbSsp9Ay17dsmoeqwqhjEqNe9kN/qJ0QNbBRd87egHhh0gdlLgUXKshUoKfGAsJT5yFo2iE=
X-Received: by 2002:a67:c289:0:b0:398:cdc:c3ef with SMTP id
 k9-20020a67c289000000b003980cdcc3efmr6883763vsj.76.1663604932243; Mon, 19 Sep
 2022 09:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220919160931.2945427-1-ardb@kernel.org> <20220919160931.2945427-4-ardb@kernel.org>
In-Reply-To: <20220919160931.2945427-4-ardb@kernel.org>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 19 Sep 2022 18:28:41 +0200
X-Gmail-Original-Message-ID: <CAHmME9rLo2-gEpj3JBbK_PdL1K05_aiwcWSzGJTW6N_-YPGtrg@mail.gmail.com>
Message-ID: <CAHmME9rLo2-gEpj3JBbK_PdL1K05_aiwcWSzGJTW6N_-YPGtrg@mail.gmail.com>
Subject: Re: [PATCH 3/3] efi: random: combine bootloader provided RNG seed
 with RNG protocol output
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Lennart Poettering <lennart@poettering.net>,
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

On Mon, Sep 19, 2022 at 6:09 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Instead of blindly creating the EFI random seed configuration table if
> the RNG protocol is implemented and works, check whether such a EFI
> configuration table was provided by an earlier boot stage and if so,
> combine its contents with a Linux specific personalization string, and
> if available, mix in the output of the RNG protocol as well.
>
> This can be used for, e.g., systemd-boot, to pass an additional seed to
> Linux in a way that can be consumed by the kernel very early. In that
> case, the following definitions should be used to pass the seed to the
> EFI stub:
>
>   struct linux_efi_random_seed {
>           u32     size; // of the 'seed' array in bytes
>           u8      seed[];
>   };
>
> The memory for the struct must be allocated as EFI_ACPI_RECLAIM_MEMORY
> pool memory, and the address of the struct in memory should be installed
> as a EFI configuration table using the following GUID:
>
> LINUX_EFI_RANDOM_SEED_TABLE_GUID        1ce1e5bc-7ceb-42f2-81e5-8aadf180f57b
>
> Note that doing so is safe even on kernels that were built without this
> patch applied, but the seed will simply be overwritten with a seed
> derived from the EFI RNG protocol, if available. The recommended seed
> size is 32 bytes, anything beyond that is mixed in but not reflected in
> the final seed size.
>
> Suggested-by: "Jason A. Donenfeld" <Jason@zx2c4.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>

(And I suppose you can trim those quotation marks in the suggested-by
tag, since it's a git trailer rather than an email header.)
