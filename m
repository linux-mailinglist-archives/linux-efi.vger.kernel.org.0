Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DFF606658
	for <lists+linux-efi@lfdr.de>; Thu, 20 Oct 2022 18:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiJTQ4N (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Oct 2022 12:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiJTQ4K (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Oct 2022 12:56:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286EA1805BE
        for <linux-efi@vger.kernel.org>; Thu, 20 Oct 2022 09:56:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A10E261CAD
        for <linux-efi@vger.kernel.org>; Thu, 20 Oct 2022 16:56:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A84AC433D6;
        Thu, 20 Oct 2022 16:56:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=fail reason="signature verification failed" (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="PgYYZc1U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666284965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UaA39pk7lV8d6PpQ/5lefyiRbOV4l15TAGqfRL/K81c=;
        b=PgYYZc1UrTdlavTWm3BxEz/SK8grdVcEtd7ZI2EgZ6sFNvyyFf5W2yNrPV61JsVCJG4Nm/
        abWlVkg/WJbKuXzV46DFJYXNqgAe7koKJYfWPR00ArzTbCdUh+/kmY8T9lC4WHCUiTqNRx
        Od+0BR296krSI1uys6kNiPsJpwJbh7A=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3995bcd1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 20 Oct 2022 16:56:04 +0000 (UTC)
Date:   Thu, 20 Oct 2022 10:56:03 -0600
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Lennart Poettering <lennart@poettering.net>
Subject: Re: [PATCH v3 3/3] efi: random: combine bootloader provided RNG seed
 with RNG protocol output
Message-ID: <Y1F9oyE9QlJrzZNg@zx2c4.com>
References: <20221020083910.1902009-1-ardb@kernel.org>
 <20221020083910.1902009-4-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221020083910.1902009-4-ardb@kernel.org>
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

Thanks for doing this. Some comments below:

On Thu, Oct 20, 2022 at 10:39:10AM +0200, Ard Biesheuvel wrote:
> Instead of blindly creating the EFI random seed configuration table if
> the RNG protocol is implemented and works, check whether such a EFI
> configuration table was provided by an earlier boot stage and if so,
> concatenate the existing and the new seeds, leaving it up to the core
> code to mix it in and credit it the way it sees fit.
> 
> This can be used for, e.g., systemd-boot, to pass an additional seed to
> Linux in a way that can be consumed by the kernel very early. In that
> case, the following definitions should be used to pass the seed to the
> EFI stub:
> 
> struct linux_efi_random_seed {
>       u32     size; // of the 'seed' array in bytes
>       u8      seed[];
> };
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
> size is 32 bytes, anything beyond that is disregarded when the seeds are
> concatenated.

Since this commit message will be used by other implementers inevitably,
you might want to include something about forward secrecy, memzeroing
old allocations, etc.


> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

You can treat overwriting the old seed as an accidental bug, and Cc this
as stable like the rest of this series.

> +	/*
> +	 * Check whether a seed was provided by a prior boot stage. In that
> +	 * case, instead of overwriting it, let's create a new buffer that can
> +	 * hold both, and concatenate the existing and the new seeds.
> +	 */
> +	prev_seed = get_efi_config_table(LINUX_EFI_RANDOM_SEED_TABLE_GUID);
> +	if (prev_seed) {
> +		prev_seed_size = min(prev_seed->size, EFI_RANDOM_SEED_SIZE);
> +		seed_size += prev_seed_size;
> +	}

I think you can omit the min() here. If a bootloader passes a massive
seed such that allocations later fail, that's a bootloader problem, and
we should just complain loudly about it.

> +	seed->size = seed_size;
> +	if (prev_seed)
> +		memcpy(seed->bits + EFI_RANDOM_SEED_SIZE, prev_seed->bits,
> +		       prev_seed_size);

You memcpy here, but then:

> +
>  	status = efi_bs_call(install_configuration_table, &rng_table_guid, seed);
>  	if (status != EFI_SUCCESS)
>  		goto err_freepool;

If the installation here fails, you abort, leaving the memcpy'd seed in
memory without memzeroing.

>  
> +	if (prev_seed) {
> +		/* wipe and free the old seed if we managed to install the new one */
> +		memzero_explicit(prev_seed->bits, prev_seed_size);
> +		efi_bs_call(free_pool, prev_seed);
> +	}
>  	return EFI_SUCCESS;
>  
>  err_freepool:
> +	efi_warn("Failed to obtain seed from EFI_RNG_PROTOCOL%s\n",
> +		 prev_seed ? ", retaining bootloader supplied seed only" : "");

So maybe it makes sense to stick a memzero here too, just before
freeing?

Also, I don't think that efi_warn() makes sense. In the easy case, if
the bootloader provides a seed bu EFI doesn't have a RNG_PROTOCOL
implementation, then that's a firmware limitation the user likely can't
do anything about, in which case it's really good that systemd-boot is
providing something instead. So that's not something to worry about.
In the more complicated cases, you jump here when
install_configuration_table() fails, so that's something to warn about,
but perhaps just before goto. Then, you also return early from the
function up at the call to allocate_pool, so that'd be a place to warn
about too.

Not seen in this diff, but relevant too is that you currently exit early
from the function if locate_protocol fails. If there's a systemd-boot
seed already, this is premature. Instead, move the call to
locate_protocol down to just before the call to get_rng.

Jason

>  	efi_bs_call(free_pool, seed);
>  	return status;
>  }
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index cf96f8d5f15f..69454a7ccc6f 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1172,8 +1172,6 @@ void efi_check_for_embedded_firmwares(void);
>  static inline void efi_check_for_embedded_firmwares(void) { }
>  #endif
>  
> -efi_status_t efi_random_get_seed(void);
> -
>  #define arch_efi_call_virt(p, f, args...)	((p)->f(args))
>  
>  /*
> -- 
> 2.35.1
> 
