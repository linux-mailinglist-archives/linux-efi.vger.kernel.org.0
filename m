Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E906A5763
	for <lists+linux-efi@lfdr.de>; Tue, 28 Feb 2023 12:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjB1LCC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Feb 2023 06:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjB1LCC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Feb 2023 06:02:02 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 265A625B85
        for <linux-efi@vger.kernel.org>; Tue, 28 Feb 2023 03:02:00 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2E93C14;
        Tue, 28 Feb 2023 03:02:43 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.17.252])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49DF53F881;
        Tue, 28 Feb 2023 03:01:59 -0800 (PST)
Date:   Tue, 28 Feb 2023 11:01:56 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, maz@kernel.org,
        broonie@kernel.org
Subject: Re: [PATCH] arm64: kaslr: don't pretend KASLR is enabled if offset <
 MIN_KIMG_ALIGN
Message-ID: <Y/3fJIROD69FBhAJ@FVFF77S0Q05N>
References: <20230223204101.1500373-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223204101.1500373-1-ardb@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Feb 23, 2023 at 09:41:01PM +0100, Ard Biesheuvel wrote:
> Our virtual KASLR displacement is a randomly chosen multiple of
> 2 MiB plus an offset that is equal to the physical placement modulo 2
> MiB. This arrangement ensures that we can always use 2 MiB block
> mappings (or contiguous PTE mappings for 16k or 64k pages) to map the
> kernel.
> 
> This means that a KASLR offset of less than 2 MiB is simply the product
> of this physical displacement, and no randomization has actually taken
> place. Currently, we use 'kaslr_offset() > 0' to decide whether or not
> randomization has occurred, and so we misidentify this case.

> Fix this, by correctly identifying the case where the virtual
> displacement is a result of the physical displacement only.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
> I have sent out the same patch with a much shorter commit log as part of
> my LPA2 series before, but I only realized today that this is likely to
> fix most occurrences of the issue where a single 10g vmalloc() call
> break subsequent module loading, so I am reposting it in isolation.
> 
>  arch/arm64/include/asm/memory.h | 11 +++++++++++
>  arch/arm64/kernel/cpufeature.c  |  2 +-
>  arch/arm64/kernel/kaslr.c       |  2 +-
>  3 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 9dd08cd339c3f028..78e5163836a0ab95 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -180,6 +180,7 @@
>  #include <linux/compiler.h>
>  #include <linux/mmdebug.h>
>  #include <linux/types.h>
> +#include <asm/boot.h>
>  #include <asm/bug.h>
>  
>  #if VA_BITS > 48
> @@ -203,6 +204,16 @@ static inline unsigned long kaslr_offset(void)
>  	return kimage_vaddr - KIMAGE_VADDR;
>  }
>  
> +static inline bool kaslr_enabled(void)
> +{
> +	/*
> +	 * The KASLR offset modulo MIN_KIMG_ALIGN is taken from the physical
> +	 * placement of the image rather than from the seed, so a displacement
> +	 * of less than MIN_KIMG_ALIGN means that no seed was provided.
> +	 */
> +	return kaslr_offset() >= MIN_KIMG_ALIGN;
> +}
> +
>  /*
>   * Allow all memory at the discovery stage. We will clip it later.
>   */
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 45a42cf2191c36c3..5643a9ca502af207 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1633,7 +1633,7 @@ bool kaslr_requires_kpti(void)
>  			return false;
>  	}
>  
> -	return kaslr_offset() > 0;
> +	return kaslr_enabled();
>  }
>  
>  static bool __meltdown_safe = true;
> diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
> index 325455d16dbcb31a..e7477f21a4c9d062 100644
> --- a/arch/arm64/kernel/kaslr.c
> +++ b/arch/arm64/kernel/kaslr.c
> @@ -41,7 +41,7 @@ static int __init kaslr_init(void)
>  		return 0;
>  	}
>  
> -	if (!kaslr_offset()) {
> +	if (!kaslr_enabled()) {
>  		pr_warn("KASLR disabled due to lack of seed\n");
>  		return 0;
>  	}
> -- 
> 2.39.1
> 
