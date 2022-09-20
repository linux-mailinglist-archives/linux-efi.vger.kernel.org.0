Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4E85BEB29
	for <lists+linux-efi@lfdr.de>; Tue, 20 Sep 2022 18:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiITQfz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Sep 2022 12:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiITQfv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 20 Sep 2022 12:35:51 -0400
X-Greylist: delayed 451 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 20 Sep 2022 09:35:49 PDT
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE87659C8
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 09:35:49 -0700 (PDT)
Received: from gardel-login.0pointer.net (gardel-mail [85.214.157.71])
        by gardel.0pointer.net (Postfix) with ESMTP id BFFC4E801B5;
        Tue, 20 Sep 2022 18:28:14 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 37D65160090; Tue, 20 Sep 2022 18:28:14 +0200 (CEST)
Date:   Tue, 20 Sep 2022 18:28:14 +0200
From:   Lennart Poettering <lennart@poettering.net>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 3/3] efi: random: combine bootloader provided RNG seed
 with RNG protocol output
Message-ID: <YynqHm//QwEBzBWr@gardel-login>
References: <20220919160931.2945427-1-ardb@kernel.org>
 <20220919160931.2945427-4-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220919160931.2945427-4-ardb@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mo, 19.09.22 18:09, Ard Biesheuvel (ardb@kernel.org) wrote:

Heya!

Looks excellent!

I was wondering though, shouldn't the memory the seed data is stored
in be zeroed out when you dispose of it, just for safety?

> +	if (rng) {
> +		const int sz = EFI_RANDOM_SEED_SIZE;
> +		u8 bits[EFI_RANDOM_SEED_SIZE];
>
> -	if (status == EFI_UNSUPPORTED)
> -		/*
> -		 * Use whatever algorithm we have available if the raw algorithm
> -		 * is not implemented.
> -		 */
> -		status = efi_call_proto(rng, get_rng, NULL,
> -					EFI_RANDOM_SEED_SIZE, seed->bits);
> +		status = efi_call_proto(rng, get_rng, &rng_algo_raw, sz, bits);
> +		if (status == EFI_UNSUPPORTED)
> +			/*
> +			 * Use whatever algorithm we have available if the raw algorithm
> +			 * is not implemented.
> +			 */
> +			status = efi_call_proto(rng, get_rng, NULL, sz, bits);
>
> +		if (status == EFI_SUCCESS) {
> +			blake2s_update(&state, (void *)&sz, sizeof(sz));
> +			blake2s_update(&state, bits, sz);
So, here, shouldn't bitſ[] be zeroed out?

> -	seed->size = EFI_RANDOM_SEED_SIZE;
> +	blake2s_final(&state, seed->bits);

And here, shouldn't the state struct be zeroed out? (or does
blake2s_final() do that implicitly?

Looks excellent otherwise!

Will-be-used-by: systemd
Reviewed-by: Lennart Poettering <mzxreary@0pointer.net>
