Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0107468A12E
	for <lists+linux-efi@lfdr.de>; Fri,  3 Feb 2023 19:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjBCSId (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Feb 2023 13:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjBCSIc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 3 Feb 2023 13:08:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35D0974E
        for <linux-efi@vger.kernel.org>; Fri,  3 Feb 2023 10:08:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E5D0B82B8C
        for <linux-efi@vger.kernel.org>; Fri,  3 Feb 2023 18:08:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DCBAC433EF;
        Fri,  3 Feb 2023 18:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675447708;
        bh=oMTdwh7PPeCYBp2fVXtk0qTJd+aFKDToeaUz9lLX1YU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VjfdlAA9TsRxJrfk5cFTgc39clfIIZ2yS5w6lXKU0vUI1wQVh2V1COCXjzNqQsnXf
         Y4jxPfvybGD0VCR/zHtTt8GE50cXjvpG47WzRlqeuyumD1AVFJGB5WQ3uZlOpWJozB
         Y9pGH61EWPoUV0OgikIlih4Lsaw7VSrNHYF66FRW5g5sWayelfNI6xVmxRcLDF6tvK
         4naWWvRXTCH2jYg4Fqd7L+NhyvPA09zrMK/UCJIUtFFMEeWaNKr+llFck8PZu8f2NJ
         P7/iFCNw5U35CxeM0yvTBLDI+CWYcJzpGPtTaL4KxiB3sQ1GCi3/3WPxkuVOI56y36
         w7Xzoi7U/8ZfQ==
Date:   Fri, 3 Feb 2023 11:08:25 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v7 2/6] arm64: kernel: move identity map out of .text
 mapping
Message-ID: <Y91NmZUEZWUCNXWz@dev-arch.thelio-3990X>
References: <20230111102236.1430401-1-ardb@kernel.org>
 <20230111102236.1430401-3-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111102236.1430401-3-ardb@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

On Wed, Jan 11, 2023 at 11:22:32AM +0100, Ard Biesheuvel wrote:
> Reorganize the ID map slightly so that only code that is executed with
> the MMU off or via the 1:1 mapping remains. This allows us to move the
> identity map out of the .text segment, as it will no longer need
> executable permissions via the kernel mapping.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/kernel/head.S        | 28 +++++++++++---------
>  arch/arm64/kernel/vmlinux.lds.S |  2 +-
>  arch/arm64/mm/proc.S            |  2 --
>  3 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index c4e12d466a5f35f0..bec97aad092c2b43 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -543,19 +543,6 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
>  	eret
>  SYM_FUNC_END(init_kernel_el)
>  
> -/*
> - * Sets the __boot_cpu_mode flag depending on the CPU boot mode passed
> - * in w0. See arch/arm64/include/asm/virt.h for more info.
> - */
> -SYM_FUNC_START_LOCAL(set_cpu_boot_mode_flag)
> -	adr_l	x1, __boot_cpu_mode
> -	cmp	w0, #BOOT_CPU_MODE_EL2
> -	b.ne	1f
> -	add	x1, x1, #4
> -1:	str	w0, [x1]			// Save CPU boot mode
> -	ret
> -SYM_FUNC_END(set_cpu_boot_mode_flag)
> -
>  	/*
>  	 * This provides a "holding pen" for platforms to hold all secondary
>  	 * cores are held until we're ready for them to initialise.
> @@ -599,6 +586,7 @@ SYM_FUNC_START_LOCAL(secondary_startup)
>  	br	x8
>  SYM_FUNC_END(secondary_startup)
>  
> +	.text
>  SYM_FUNC_START_LOCAL(__secondary_switched)
>  	mov	x0, x20
>  	bl	set_cpu_boot_mode_flag
> @@ -631,6 +619,19 @@ SYM_FUNC_START_LOCAL(__secondary_too_slow)
>  	b	__secondary_too_slow
>  SYM_FUNC_END(__secondary_too_slow)
>  
> +/*
> + * Sets the __boot_cpu_mode flag depending on the CPU boot mode passed
> + * in w0. See arch/arm64/include/asm/virt.h for more info.
> + */
> +SYM_FUNC_START_LOCAL(set_cpu_boot_mode_flag)
> +	adr_l	x1, __boot_cpu_mode
> +	cmp	w0, #BOOT_CPU_MODE_EL2
> +	b.ne	1f
> +	add	x1, x1, #4
> +1:	str	w0, [x1]			// Save CPU boot mode
> +	ret
> +SYM_FUNC_END(set_cpu_boot_mode_flag)
> +
>  /*
>   * The booting CPU updates the failed status @__early_cpu_boot_status,
>   * with MMU turned off.
> @@ -662,6 +663,7 @@ SYM_FUNC_END(__secondary_too_slow)
>   * Checks if the selected granule size is supported by the CPU.
>   * If it isn't, park the CPU
>   */
> +	.section ".idmap.text","awx"
>  SYM_FUNC_START(__enable_mmu)
>  	mrs	x3, ID_AA64MMFR0_EL1
>  	ubfx	x3, x3, #ID_AA64MMFR0_EL1_TGRAN_SHIFT, 4
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 4c13dafc98b8400f..407415a5163ab62f 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -179,7 +179,6 @@ SECTIONS
>  			LOCK_TEXT
>  			KPROBES_TEXT
>  			HYPERVISOR_TEXT
> -			IDMAP_TEXT
>  			*(.gnu.warning)
>  		. = ALIGN(16);
>  		*(.got)			/* Global offset table		*/
> @@ -206,6 +205,7 @@ SECTIONS
>  		TRAMP_TEXT
>  		HIBERNATE_TEXT
>  		KEXEC_TEXT
> +		IDMAP_TEXT
>  		. = ALIGN(PAGE_SIZE);
>  	}
>  
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 066fa60b93d24827..91410f48809000a0 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -110,7 +110,6 @@ SYM_FUNC_END(cpu_do_suspend)
>   *
>   * x0: Address of context pointer
>   */
> -	.pushsection ".idmap.text", "awx"
>  SYM_FUNC_START(cpu_do_resume)
>  	ldp	x2, x3, [x0]
>  	ldp	x4, x5, [x0, #16]
> @@ -166,7 +165,6 @@ alternative_else_nop_endif
>  	isb
>  	ret
>  SYM_FUNC_END(cpu_do_resume)
> -	.popsection
>  #endif
>  
>  	.pushsection ".idmap.text", "awx"
> -- 
> 2.39.0
> 

Sorry you have to keep hearing from me, I am starting to feel like a
nuisance :) apologies if this is already been reported, I did a search
of lore and did not find anything.

I have noticed the following message on my arm64 machines recently and I
had some time to bisect it down to this change in -next (log below):

  [    0.029481] kprobes: Failed to populate blacklist (error -22), kprobes not restricted, be careful using them!

I can trivially reproduce it with defconfig + CONFIG_KPROBES=y in QEMU.
If there is any other information I can provide or patches I can test, I
am more than happy to do so.

Cheers,
Nathan

# bad: [ea4dabbb4ad7eb52632a2ca0b8f89f0ea7c55dcf] Add linux-next specific files for 20230202
# good: [9f266ccaa2f5228bfe67ad58a94ca4e0109b954a] Merge tag 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost
git bisect start 'ea4dabbb4ad7eb52632a2ca0b8f89f0ea7c55dcf' '9f266ccaa2f5228bfe67ad58a94ca4e0109b954a'
# bad: [1212e8a2ede5d43ffa423f6bb15dc128bc442c17] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
git bisect bad 1212e8a2ede5d43ffa423f6bb15dc128bc442c17
# bad: [61a09f7913443728509eaba2b10566372e39f4fc] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git
git bisect bad 61a09f7913443728509eaba2b10566372e39f4fc
# good: [642eb331c5eddadf2a9b0ea171c0605788627dae] soc: document merges
git bisect good 642eb331c5eddadf2a9b0ea171c0605788627dae
# bad: [8c08bee280c147d47db13297c5f4d11fdc915fec] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
git bisect bad 8c08bee280c147d47db13297c5f4d11fdc915fec
# good: [ab0a5c9e8c2649f43e6d49b65785189e208df506] Merge branch 'perf/core' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
git bisect good ab0a5c9e8c2649f43e6d49b65785189e208df506
# bad: [706652c32b3d2a55b52f1e33ee1d2f98a0eafed0] Merge branch 'asahi-soc/for-next' of https://github.com/AsahiLinux/linux.git
git bisect bad 706652c32b3d2a55b52f1e33ee1d2f98a0eafed0
# bad: [13c0a41d2cb2265661c7178cbe986592c906ef0b] Merge branches 'for-next/sysreg', 'for-next/sme', 'for-next/kselftest', 'for-next/misc', 'for-next/sme2', 'for-next/tpidr2', 'for-next/scs', 'for-next/compat-hwcap', 'for-next/ftrace', 'for-next/efi-boot-mmu-on', 'for-next/ptrauth' and 'for-next/pseudo-nmi' into for-next/core
git bisect bad 13c0a41d2cb2265661c7178cbe986592c906ef0b
# good: [b2ab432bcf65e6fa3ec3fef6dd08796404b009d0] kselftest/arm64: Remove redundant _start labels from zt-test
git bisect good b2ab432bcf65e6fa3ec3fef6dd08796404b009d0
# good: [a7db82f18cd3d85ea8ef70fca5946b441187ed6d] kselftest/arm64: Fix enumeration of systems without 128 bit SME for SSVE+ZA
git bisect good a7db82f18cd3d85ea8ef70fca5946b441187ed6d
# good: [dc4824faa265db1bc93449e8ec386a0245404fa6] arm64: avoid executing padding bytes during kexec / hibernation
git bisect good dc4824faa265db1bc93449e8ec386a0245404fa6
# good: [004fc58f917cfea5d7190139e3ed1b7a13e39c25] arm64/mm: Intercept pfn changes in set_pte_at()
git bisect good 004fc58f917cfea5d7190139e3ed1b7a13e39c25
# good: [4f2c9bf16a4bc209a674e7b76d8e829b917c7f84] arm64: Add compat hwcap SSBS
git bisect good 4f2c9bf16a4bc209a674e7b76d8e829b917c7f84
# bad: [2ced0f30a426c7301350681f838344d5aea711e3] arm64: head: Switch endianness before populating the ID map
git bisect bad 2ced0f30a426c7301350681f838344d5aea711e3
# bad: [9d7c13e5dde31270eb48a34204a2e06b1a719546] arm64: head: record the MMU state at primary entry
git bisect bad 9d7c13e5dde31270eb48a34204a2e06b1a719546
# bad: [af7249b317e4d0b3d5a0ebbb7ee7a0f336ca7bca] arm64: kernel: move identity map out of .text mapping
git bisect bad af7249b317e4d0b3d5a0ebbb7ee7a0f336ca7bca
# good: [82e4958800c01daa7662362ee9543065bd14c852] arm64: head: Move all finalise_el2 calls to after __enable_mmu
git bisect good 82e4958800c01daa7662362ee9543065bd14c852
# first bad commit: [af7249b317e4d0b3d5a0ebbb7ee7a0f336ca7bca] arm64: kernel: move identity map out of .text mapping
