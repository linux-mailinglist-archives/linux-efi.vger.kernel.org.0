Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DFE626089
	for <lists+linux-efi@lfdr.de>; Fri, 11 Nov 2022 18:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbiKKRg0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Nov 2022 12:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbiKKRgZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 11 Nov 2022 12:36:25 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1002E2E4
        for <linux-efi@vger.kernel.org>; Fri, 11 Nov 2022 09:36:24 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B47781FB;
        Fri, 11 Nov 2022 09:36:29 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.25.147])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AFED3F534;
        Fri, 11 Nov 2022 09:36:22 -0800 (PST)
Date:   Fri, 11 Nov 2022 17:36:19 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        keescook@chromium.org, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v5 0/7] arm64: efi: leave MMU and caches on at boot
Message-ID: <Y26IE5NEVhyId4KH@FVFF77S0Q05N.cambridge.arm.com>
References: <20221108182204.2447664-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108182204.2447664-1-ardb@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

Sorry for the late-in-the-day reply here...

On Tue, Nov 08, 2022 at 07:21:57PM +0100, Ard Biesheuvel wrote:
> The purpose of this series is to remove any explicit cache maintenance
> for coherency during early boot that becomes unnecessary if we simply
> retain the cacheable 1:1 mapping of all of system RAM provided by EFI,
> and use it to populate the ID map page tables. After setting up this
> preliminary ID map, we disable the MMU, drop to EL1, reprogram the MAIR,
> TCR and SCTLR registers as before, and proceed as usual, avoiding the
> need for any manipulations of memory while the MMU and caches are off.
> 
> The only properties of the firmware provided 1:1 map we rely on is that
> it does not require any explicit cache maintenance for coherency, and
> that it covers the entire memory footprint of the image, including the
> BSS and padding at the end - all else is under control of the kernel
> itself, as before.

As a high-level thing, I'm still very much not keen on entering the kernel with
the MMU on. Given that we have to support booting with the MMU off for !EFI
boot (including kexec when EFI is in use), I think this makes it harder to
reason about the boot code overall (e.g. due to the conditional maintenance
added to head.S), and adds more scope for error, even if it simplifies the EFI
stub itself.

I reckon that (sticking with entering with the MMU off), there's more that we
can do to split the table creation into more stages, and to minimize the early
portion of that which has to run with the MMU off. That would benefit non-EFI
boot and kexec, and retain the single-boot-flow that we currently have.

My rough thinking was:

1) Reduce the idmap down to a single page, such that we only need to clear
   NR_PAGETABLE_LEVELS pages to initialize this.

2) Create a small stub at a fixed TTBR1 VA which we use to create a new initial
   mapping of the kernel image (either in TTBR0 as with the currently idmap, or
   in TTBR1 directly). The stub logic could be small enough that it could be
   mapped at page granularity, and we'd only need to initialize
   NR_PAGETABLE_LEVELS pages before enabling the MMU.

   This would then bounce onto the next stage, either in TTBR0 directly, or
   bouncing through there as with the TTBR1 replacement logic.

   We could plausibly write that in C, and the early page table asm logic could
   be simplified.

Thanks,
Mark.

> Changes since v4:
> - add patch to align the callers of finalise_el2()
> - also clean HYP text to the PoC when booting at EL2 with the MMU on
> - add a warning and a taint when doing non-EFI boot with the MMU and
>   caches enabled
> - rebase onto zboot changes in efi/next - this means that patches #6 and
>   #7 will not apply onto arm64/for-next so a shared stable branch will
>   be needed if we want to queue this up for v6.2
> 
> Changes since v3:
> - drop EFI_LOADER_CODE memory type patch that has been queued in the
>   mean time
> - rebased onto [partial] series that moves efi-entry.S into the libstub/
>   source directory
> - fixed a correctness issue in patch #2
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> 
> Ard Biesheuvel (7):
>   arm64: head: Move all finalise_el2 calls to after __enable_mmu
>   arm64: kernel: move identity map out of .text mapping
>   arm64: head: record the MMU state at primary entry
>   arm64: head: avoid cache invalidation when entering with the MMU on
>   arm64: head: Clean the ID map and the HYP text to the PoC if needed
>   arm64: lds: reduce effective minimum image alignment to 64k
>   efi: arm64: enter with MMU and caches enabled
> 
>  arch/arm64/include/asm/efi.h               |  9 +-
>  arch/arm64/kernel/head.S                   | 93 +++++++++++++++-----
>  arch/arm64/kernel/image-vars.h             |  5 +-
>  arch/arm64/kernel/setup.c                  |  9 +-
>  arch/arm64/kernel/sleep.S                  |  6 +-
>  arch/arm64/kernel/vmlinux.lds.S            | 13 ++-
>  arch/arm64/mm/cache.S                      |  5 +-
>  arch/arm64/mm/proc.S                       |  2 -
>  drivers/firmware/efi/libstub/Makefile      |  4 +-
>  drivers/firmware/efi/libstub/arm64-entry.S | 67 --------------
>  drivers/firmware/efi/libstub/arm64-stub.c  | 26 ++++--
>  drivers/firmware/efi/libstub/arm64.c       | 41 +++++++--
>  include/linux/efi.h                        |  6 +-
>  13 files changed, 159 insertions(+), 127 deletions(-)
>  delete mode 100644 drivers/firmware/efi/libstub/arm64-entry.S
> 
> -- 
> 2.35.1
> 
