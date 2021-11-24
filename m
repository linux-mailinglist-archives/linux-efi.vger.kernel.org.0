Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4FAB45BD5E
	for <lists+linux-efi@lfdr.de>; Wed, 24 Nov 2021 13:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244056AbhKXMhk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 24 Nov 2021 07:37:40 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:47372 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343970AbhKXMfj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 24 Nov 2021 07:35:39 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 04CE31FD37;
        Wed, 24 Nov 2021 12:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637757149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WMx2DbKWczd/x325/wPuDlb47o2aRpvRYL1jbmRxp4U=;
        b=XtiLihkDb6eeoAfHraRAwcdCsYNMSXwKaGW8Igk661heUgnyiqERfv5jckOTbwQVWwxuZk
        h0rzaChvB8D+oVWUlP1f6qZK3oa6w0U2tkK65mwmEVU03qGanT71cL2NzsJ+dGdlJxO//Z
        +dd0d9cSGLlB5TKKiDX9sPOfjSoBhjE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637757149;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WMx2DbKWczd/x325/wPuDlb47o2aRpvRYL1jbmRxp4U=;
        b=zhApKv6SFabxdG2CdPhw9iXZ0u4HkNeAilJ8rwMpxFOw+UpOsAT9Y9DAFPV78k/mCYSJI6
        iu7eD+6ayfdVAwAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E143413F19;
        Wed, 24 Nov 2021 12:32:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1tisNdwwnmErJwAAMHmgww
        (envelope-from <iivanov@suse.de>); Wed, 24 Nov 2021 12:32:28 +0000
Date:   Wed, 24 Nov 2021 14:32:28 +0200
From:   "Ivan T. Ivanov" <iivanov@suse.de>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] random: fix crash on multiple early calls to
 add_bootloader_randomness()
Message-ID: <20211124123228.tftk2x3uxoxetfhx@suse>
References: <20211012082708.121931-1-iivanov@suse.de>
 <YWVKAk4h5bsUA3b6@light.dominikbrodowski.net>
 <YYTJdLuuFAShnblb@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYTJdLuuFAShnblb@light.dominikbrodowski.net>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 11-05 07:04, Dominik Brodowski wrote:
> Date: Fri, 5 Nov 2021 07:04:36 +0100
> From: Dominik Brodowski <linux@dominikbrodowski.net>
> To: tytso@mit.edu
> Cc: "Ivan T. Ivanov" <iivanov@suse.de>, Ard Biesheuvel <ardb@kernel.org>,
>  linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
> Subject: [PATCH v3] random: fix crash on multiple early calls to
>  add_bootloader_randomness()
> Message-ID: <YYTJdLuuFAShnblb@light.dominikbrodowski.net>
Tags: all dt linux me watch
> 

Hi,

> If add_bootloader_randomness() or add_hwgenerator_randomness() is
> called for the first time during early boot, crng_init equals 0. Then,
> crng_fast_load() gets called -- which is safe to do even if the input
> pool is not yet properly set up.
> 
> If the added entropy suffices to increase crng_init to 1, future calls
> to add_bootloader_randomness() or add_hwgenerator_randomness() used to
> progress to credit_entropy_bits(). However, if the input pool is not yet
> properly set up, the cmpxchg call within that function can lead to an
> infinite recursion. This is not only a hypothetical problem, as qemu
> on arm64 may provide bootloader entropy via EFI and via devicetree.
> 
> As crng_global_init_time is set to != 0 once the input pool is properly
> set up, check (also) for this condition to determine which branch to take.
> 
> Calls to crng_fast_load() do not modify the input pool; therefore, the
> entropy_count for the input pool must not be modified at that early
> stage.
> 
> Reported-by: Ivan T. Ivanov <iivanov@suse.de>
> Fixes: 18b915ac6b0a ("efi/random: Treat EFI_RNG_PROTOCOL output as bootloader randomness")
> Tested-by: Ivan T. Ivanov <iivanov@suse.de>
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

What is the plan for this fix?

Regards,
Ivan

> ---
> v2->v3: onle one unlikely (Ard Biesheuvel)
> v1->v2: fix commit message; unmerge Reported-and-tested-by-tag (Ard Biesheuvel)
> 
>  drivers/char/random.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 605969ed0f96..18fe804c1bf8 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -1763,8 +1763,8 @@ static void __init init_std_data(struct entropy_store *r)
>  }
>  
>  /*
> - * Note that setup_arch() may call add_device_randomness()
> - * long before we get here. This allows seeding of the pools
> + * add_device_randomness() or add_bootloader_randomness() may be
> + * called long before we get here. This allows seeding of the pools
>   * with some platform dependent data very early in the boot
>   * process. But it limits our options here. We must use
>   * statically allocated structures that already have all
> @@ -2274,7 +2274,12 @@ void add_hwgenerator_randomness(const char *buffer, size_t count,
>  {
>  	struct entropy_store *poolp = &input_pool;
>  
> -	if (unlikely(crng_init == 0)) {
> +	/* We cannot do much with the input pool until it is set up in
> +	 * rand_initalize(); therefore just mix into the crng state.
> +	 * As this does not affect the input pool, we cannot credit
> +	 * entropy for this.
> +	 */
> +	if (unlikely(crng_init == 0 || crng_global_init_time == 0)) {
>  		crng_fast_load(buffer, count);
>  		return;
>  	}
