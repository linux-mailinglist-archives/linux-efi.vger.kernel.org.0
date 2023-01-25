Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3446F67B6F6
	for <lists+linux-efi@lfdr.de>; Wed, 25 Jan 2023 17:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjAYQc4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Jan 2023 11:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235253AbjAYQcz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 25 Jan 2023 11:32:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E26BB89
        for <linux-efi@vger.kernel.org>; Wed, 25 Jan 2023 08:32:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2AAE6B81AD8
        for <linux-efi@vger.kernel.org>; Wed, 25 Jan 2023 16:32:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52CC0C433EF;
        Wed, 25 Jan 2023 16:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674664370;
        bh=sIkNv0EVTfU4pG7havOzGvLT18+lxXUNUiBaoL6qViE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EiO4S1OGP5GZeAK99sCZCFTgb4zrdd+vZBtz/Ezj6/eNNmSaZ4dB6OEd/wDU2NypX
         ttNhXD6wzkUPZn+0Oue9eYQFSTDV3TjWrV3CmgqqI6q397dXLU4kkTiKebSjuOP5et
         hKcKs8KUBNYcuA7xZ6oS1W8tKkfs11AibrvSZ1iqZQYj8ylET2ZKHeNpR8LGL9cudT
         Wv5RROzzTwZQnMbYv4CTmHeqOk8grxSyuvLwz9Jlat1//1tjH3OlIEt56sql/gdmAF
         C//TSiEweX2fXLMKcYx7B2tCYDOcCIqrUIFf5ZDojWouIfUH88xTF2EA3G/qDh6w0F
         vB+H32B9QypIg==
Date:   Wed, 25 Jan 2023 09:32:48 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, llvm@lists.linux.dev
Subject: Re: [PATCH v7 4/6] arm64: head: avoid cache invalidation when
 entering with the MMU on
Message-ID: <Y9FZsBEu8hSVVIA8@dev-arch.thelio-3990X>
References: <20230111102236.1430401-1-ardb@kernel.org>
 <20230111102236.1430401-5-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111102236.1430401-5-ardb@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

On Wed, Jan 11, 2023 at 11:22:34AM +0100, Ard Biesheuvel wrote:
> If we enter with the MMU on, there is no need for explicit cache
> invalidation for stores to memory, as they will be coherent with the
> caches.
> 
> Let's take advantage of this, and create the ID map with the MMU still
> enabled if that is how we entered, and avoid any cache invalidation
> calls in that case.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/kernel/head.S | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index c3b898efd3b5288d..d75f419206451d07 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -89,9 +89,9 @@
>  SYM_CODE_START(primary_entry)
>  	bl	record_mmu_state
>  	bl	preserve_boot_args
> +	bl	create_idmap
>  	bl	init_kernel_el			// w0=cpu_boot_mode
>  	mov	x20, x0
> -	bl	create_idmap
>  
>  	/*
>  	 * The following calls CPU setup code, see arch/arm64/mm/proc.S for
> @@ -377,12 +377,13 @@ SYM_FUNC_START_LOCAL(create_idmap)
>  	 * accesses (MMU disabled), invalidate those tables again to
>  	 * remove any speculatively loaded cache lines.
>  	 */
> +	cbnz	x19, 0f				// skip cache invalidation if MMU is on
>  	dmb	sy
>  
>  	adrp	x0, init_idmap_pg_dir
>  	adrp	x1, init_idmap_pg_end
>  	bl	dcache_inval_poc
> -	ret	x28
> +0:	ret	x28
>  SYM_FUNC_END(create_idmap)
>  
>  SYM_FUNC_START_LOCAL(create_kernel_mapping)
> -- 
> 2.39.0
> 

Our CI started reporting a boot failure in QEMU with defconfig +
CONFIG_CPU_BIG_ENDIAN=y after this patch as commit 32b135a7fafe ("arm64:
head: avoid cache invalidation when entering with the MMU on") in the
arm64 tree (and now next-20230125).

https://github.com/ClangBuiltLinux/continuous-integration2/actions/runs/4001750912/jobs/6868612292

$ timeout --foreground 3m qemu-system-aarch64 \
-cpu max,pauth-impdef=true \
-machine virt,gic-version=max,virtualization=true \
-kernel Image.gz \
-append "console=ttyAMA0 earlycon" \
-display none \
-initrd rootfs.cpio
-m 512m \
-nodefaults \
-no-reboot \
-serial mon:stdio
qemu-system-aarch64: terminating on signal 15 from pid 389 (timeout)

defconfig is fine at the same change.

There is no output, which makes sense since this is pretty early in
boot. We are not booting via EFI, in case that matters. This does not
appear to be a toolchain problem, as I can reproduce it with the
kernel.org GCC toolchains.

If there is any more information I can provide or patches I can test, I
am more than happy to do so.

Cheers,
Nathan

# bad: [2e84eedb182e43a9113c2c83cc3373c2ae99ce19] Merge branch 'for-next/core' into for-kernelci
# good: [2241ab53cbb5cdb08a6b2d4688feb13971058f65] Linux 6.2-rc5
git bisect start '2e84eedb182e43a9113c2c83cc3373c2ae99ce19' 'v6.2-rc5'
# good: [3eb1b41fba97a1586e3ecca8c10547071f541567] kselftest/arm64: Add coverage of SME 2 and 2.1 hwcaps
git bisect good 3eb1b41fba97a1586e3ecca8c10547071f541567
# good: [daac835347a52d9d141be281e4657cc08a360e97] kselftest/arm64: Correct buffer size for SME ZA storage
git bisect good daac835347a52d9d141be281e4657cc08a360e97
# good: [baaf553d3bc330697c68a00f96cf11f4edfeac7e] arm64: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
git bisect good baaf553d3bc330697c68a00f96cf11f4edfeac7e
# good: [4f2c9bf16a4bc209a674e7b76d8e829b917c7f84] arm64: Add compat hwcap SSBS
git bisect good 4f2c9bf16a4bc209a674e7b76d8e829b917c7f84
# good: [1abf363d085cf6133ef44900334ddd0f61dc3276] KVM: arm64: Use symbolic definition for ISR_EL1.A
git bisect good 1abf363d085cf6133ef44900334ddd0f61dc3276
# bad: [61786170383093908e9f5f8fd8c5c3ff0c3bbe03] efi: arm64: enter with MMU and caches enabled
git bisect bad 61786170383093908e9f5f8fd8c5c3ff0c3bbe03
# good: [9d7c13e5dde31270eb48a34204a2e06b1a719546] arm64: head: record the MMU state at primary entry
git bisect good 9d7c13e5dde31270eb48a34204a2e06b1a719546
# bad: [3dcf60bbfd284e5ebfa40c56172222425d10abf0] arm64: head: Clean the ID map and the HYP text to the PoC if needed
git bisect bad 3dcf60bbfd284e5ebfa40c56172222425d10abf0
# bad: [32b135a7fafebe7843abe5425159fa081ae56b7c] arm64: head: avoid cache invalidation when entering with the MMU on
git bisect bad 32b135a7fafebe7843abe5425159fa081ae56b7c
# first bad commit: [32b135a7fafebe7843abe5425159fa081ae56b7c] arm64: head: avoid cache invalidation when entering with the MMU on
