Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12E04EDD9A
	for <lists+linux-efi@lfdr.de>; Thu, 31 Mar 2022 17:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbiCaPoQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 31 Mar 2022 11:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239571AbiCaPnE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 31 Mar 2022 11:43:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88C60210286
        for <linux-efi@vger.kernel.org>; Thu, 31 Mar 2022 08:37:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B619013D5;
        Thu, 31 Mar 2022 08:37:36 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.21.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B5773F73B;
        Thu, 31 Mar 2022 08:37:35 -0700 (PDT)
Date:   Thu, 31 Mar 2022 16:37:28 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        keescook@chromium.org, catalin.marinas@arm.com,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [RFC PATCH v2 00/18] arm64: efi: leave MMU and caches on at boot
Message-ID: <YkXKuIChPg4xBReW@FVFF77S0Q05N>
References: <20220330154205.2483167-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330154205.2483167-1-ardb@kernel.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

On Wed, Mar 30, 2022 at 05:41:47PM +0200, Ard Biesheuvel wrote:
> This is a followup to a previous series of mine [0], and it aims to
> streamline the boot flow with respect to cache maintenance and redundant
> copying of data in memory.
> 
> Combined with my proof-of-concept firmware for QEMU/arm64 [1], this
> results in a boot where both the kernel and the initrd are loaded
> straight to their final locations in memory, while the physical
> placement of the kernel image is still randomized by the loader. It also
> removes all memory accesses performed with the MMU and caches off
> (except for instruction fetches) that are done from the moment the VM
> comes out of reset.
> 
> On the kernel side, this comes down to:
> - increasing the ID map to cover the entire kernel image, so we can
>   build the kernel page tables with the MMU and caches enabled;
> - deal with the MMU already being on at boot, and keep it on while
>   building the ID map;
> - ensure all stores to memory that are now done with the MMU and caches
>   on are not negated by the subsequent cache invalidation.

This is on my queue to review in detail, but for now I have a couple of
high-level thoughts:

1) I like the idea of deferring/staging some work until after the MMU is on,
   and I'm in favour of doing so where we can do so in all cases. If we end up
   with infrastructure to run some MMU-on TTBR0 stub environment(s), that could
   be useful elsewhere, e.g. idmap_kpti_install_ng_mappings().

2) I do not think that we should support entering the kernel with the MMU on.

   I think that consistently using the same MMU-off boot code has saved us a
   great deal of pain thus far, and the more I think about booting with the MMU
   on, I think it opens us up to a lot of potential pain, both in the short term
   and longer term as the architecture evolves. For example, as rhetoricals
   from the top of my head:

  * How do we safely inherit whatever VMSA state the loader has left us with?
    e.g. what do we require w.r.t. TCRs, MAIRS?
    e.g. what to do when the loader uses a different granule size from the
         kernel?

  * What can we expect is mapped, and with which specific attributes and
    permissions?

  * What do we document here for loaders other than the EFI stub?
    ... and what about kexec?

  ... and generally this is another complication for maintenance and testing
  that I'd rather not open the door to.

In other words, my view is that we should *minimize* what we do with the MMU
off, but only where we can do that consistently, and we should still
consistently enter with the MMU off such that we can consistently and safely
initialize the VMSA state.

Thanks,
Mark.

> Additionally, this series removes the little dance we do to create a
> kernel mapping, relocate the kernel, run the KASLR init code, tear down
> the old mapping and creat a new one, relocate the kernel again, and
> finally enter the kernel proper. Instead, it invokes a minimal C
> function 'kaslr_early_init()' while running from the ID map with a
> temporary mapping of the FDT in TTBR1. This change represents a
> substantial of the diffstat, as it requires some work to instantiate
> code that can run safely from the wrong address. It is also the most
> likely to raise objections, so it can be dropped from this series if
> desired (patch #9 is the meat, and #8 is a prerequisite patch that could
> be dropped in that case as well)
> 
> Changes since v1:
> - Remove the dodgy handling of the KASLR seed, which was necessary to
>   avoid doing two iterations of the setup/teardown of the page tables.
>   This is now dealt with by creating the TTBR1 page tables while
>   executing from TTBR0, and so all memory manipulations are still done
>   with the MMU and caches on. (This is also the reason patch #9 is
>   optional now)
> - Only boot from EFI with the MMU and caches on if the image was not
>   moved around in memory. Otherwise, we cannot rely on the firmware's ID
>   map to have created an executable mapping for the copied code.
> 
> [0] https://lore.kernel.org/all/20220304175657.2744400-1-ardb@kernel.org/
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/ardb/efilite.git/
> 
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> 
> Ard Biesheuvel (18):
>   arm64: head: drop idmap_ptrs_per_pgd
>   arm64: head: split off idmap creation code
>   arm64: kernel: drop unnecessary PoC cache clean+invalidate
>   arm64: head: cover entire kernel image in ID map
>   arm64: head: factor out TTBR1 assignment into a macro
>   arm64: head: populate kernel page tables with MMU and caches on
>   arm64: kaslr: deal with init called with VA randomization enabled
>   arm64: setup: defer R/O remapping of FDT
>   arm64: head: relocate kernel only a single time if KASLR is enabled
>   arm64: head: record the MMU state at primary entry
>   arm64: mm: make vabits_actual a build time constant if possible
>   arm64: head: avoid cache invalidation when entering with the MMU on
>   arm64: head: record CPU boot mode after enabling the MMU
>   arm64: head: clean the ID map page to the PoC
>   arm64: lds: move idmap_pg_dir out of .rodata
>   efi: libstub: pass image handle to handle_kernel_image()
>   efi/arm64: libstub: run image in place if randomized by the loader
>   arm64: efi/libstub: enter with the MMU on if executing in place
> 
>  arch/arm64/include/asm/kernel-pgtable.h   |   2 +-
>  arch/arm64/include/asm/memory.h           |   6 +
>  arch/arm64/include/asm/mmu_context.h      |   1 -
>  arch/arm64/kernel/Makefile                |   2 +-
>  arch/arm64/kernel/efi-entry.S             |   4 +
>  arch/arm64/kernel/head.S                  | 276 +++++++++++---------
>  arch/arm64/kernel/kaslr.c                 |  86 +-----
>  arch/arm64/kernel/pi/Makefile             |  33 +++
>  arch/arm64/kernel/pi/kaslr_early.c        | 128 +++++++++
>  arch/arm64/kernel/setup.c                 |   8 +-
>  arch/arm64/kernel/vmlinux.lds.S           |   9 +-
>  arch/arm64/mm/mmu.c                       |  15 +-
>  drivers/firmware/efi/libstub/arm32-stub.c |   3 +-
>  drivers/firmware/efi/libstub/arm64-stub.c |  15 +-
>  drivers/firmware/efi/libstub/efi-stub.c   |   2 +-
>  drivers/firmware/efi/libstub/efistub.h    |   3 +-
>  drivers/firmware/efi/libstub/riscv-stub.c |   3 +-
>  include/linux/efi.h                       |  11 +
>  18 files changed, 380 insertions(+), 227 deletions(-)
>  create mode 100644 arch/arm64/kernel/pi/Makefile
>  create mode 100644 arch/arm64/kernel/pi/kaslr_early.c
> 
> -- 
> 2.30.2
> 
