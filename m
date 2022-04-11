Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0786F4FB82F
	for <lists+linux-efi@lfdr.de>; Mon, 11 Apr 2022 11:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344790AbiDKJvv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Apr 2022 05:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344751AbiDKJvW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Apr 2022 05:51:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEDD427C0
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 02:48:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68D4761179
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 09:48:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C91C385AD;
        Mon, 11 Apr 2022 09:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649670522;
        bh=5dlrVCuM0Ye/Lc4591H2bttplSfxAK9hblaYVtblALU=;
        h=From:To:Cc:Subject:Date:From;
        b=Mi6T13af+bzg8nXotJ+i6weQVp5mKeECxHpisyZNHm5i97zOMfTxtvW+GKOO7Q0yT
         AToAha7fXlZAFUeMUFxzjcNjUQwk8qNldQS/yTwE3zlciQQmysH4mfrysQ2AxwcQFx
         H8M0KnPlI+QH0oNj38PhVGKzfryDq3Q11C3zHITiMlJmgPU9Cq0a2HrC/Ay7SiW+1O
         hBG/Ufn/tgHhMT+YtwkuK/65HwxI1FfugPKRnrZ3WZV4w6t5ocH64qWLHywgFXRDK0
         FYuhXX3TgwJAajFKuoyhJoMVDlAoqn4dskd4ropha6cdOJQfPz/8mikYWkR5Rx7jwI
         LCX4PmsO1X16A==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 00/30] arm64: support WXN and entry with MMU enabled
Date:   Mon, 11 Apr 2022 11:47:54 +0200
Message-Id: <20220411094824.4176877-1-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7632; h=from:subject; bh=5dlrVCuM0Ye/Lc4591H2bttplSfxAK9hblaYVtblALU=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiU/k12s3pR4jlklXD4NA07YY/CnqJbSnyu3q9tXSD fO4TYhmJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYlP5NQAKCRDDTyI5ktmPJN2cC/ 9vrdFCglTMACwmHrSFNZ91YPnaY0YgaX/c5zerLPX31VfWnlRQqXRFB5pVj39nbOTQR3X3BBCJQwZr FE5GuYG0hlcQD75FLLYK7ls/m/jNW0hF0cz48V2AU4gFXnE1YYOtOzIjq0eO0qCCBRrXZmqtk/4Aa0 jySp5cp6+yKwX03YpPlLb8+a7PxbOZZ3HLEenM+tJ/cLQdZr75HydC5IxiHBQ+NtsZ5cffv5NK+g+z 54XlVkNdJQAnrk2b7evhgTS1K6YJQ7TgTzU3PoS9HUYunBuVDJ3a5esGcWwdA+UAqNjCTyvE0z75NF ZNGHBsyzaf3u42rX+DLOyExhP8uQs3hwq6RDlpdPbrbekWsamTBZFT0QMlzuhd/PScxzbfXB/AeNfF 64kg9QnjP8pa9uZzDNloJMrMsgWPLQDB0DM0zhsNiyS5BYxpB7+IsdxupmQP9xnm3lUK4bCM5D52M2 CmmN2rvdc47sJxD38fKcgDsNIeUtSzeymWITqwzTwaxzU=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

[ TL;DR this series does the following:
  - move variable definitions and assignments out of early asm code
    where possible, and get rid of explicit cache maintenance;
  - convert initial ID map so it covers the entire loaded image as well
    as the DT blob;
  - create the kernel mapping only once instead of twice (for KASLR),
    and do it with the MMU and caches on;
  - avoid mappings that are both writable and executable entirely;
  - avoid parsing the DT while the kernel text and rodata are still
    mapped writable;
  - allow WXN to be enabled (with an opt-out) so writable mappings are
    never executable;
  - create the initial ID map with the MMU and caches on if that is how
    we entered, and take advantage of this when doing EFI boot. ]

This is a followup to a previous series of mine [0][1], and it aims to
streamline the boot flow with respect to cache maintenance and redundant
copying of data in memory, as well as eliminate writable executable
mappings at any time during the boot.

Combined with my proof-of-concept firmware for QEMU/arm64 [2], this
results in a boot where both the kernel and the initrd are loaded
straight to their final locations in memory, while the physical
placement of the kernel image is still randomized by the loader. It also
removes all memory accesses performed with the MMU and caches off
(except for instruction fetches) that are done from the moment the VM
comes out of reset.

On the kernel side, this comes down to:
- increasing the ID map to cover the entire kernel image, so we can
  build the kernel page tables with the MMU and caches enabled;
- deal with the MMU already being on at boot, and keep it on while
  building the ID map;
- ensure all stores to memory that are now done with the MMU and caches
  on are not negated by the subsequent cache invalidation.

Additionally, this series removes the little dance we do to create a
kernel mapping, relocate the kernel, run the KASLR init code, tear down
the old mapping and create a new one, relocate the kernel again, and
finally enter the kernel proper. Instead, it invokes a minimal C
function 'kaslr_early_init()' while running from the ID map which
includes a temporary mapping of the FDT. This change represents a
substantial chunk of the diffstat, as it requires some work to
instantiate code that can run safely from an arbitrary load address.

Changes since v2:
- create a separate, initial ID map that is discarded after boot, and
  create the permanent ID map from C code using the ordinary memory
  mapping code;
- refactor the extended ID map handling, and along with it, simplify the
  early memory mapping macros, so that we can deal with an extended ID
  map that requires multiple table entries at intermediate levels;
- eliminate all variable assignments with the MMU off from the happy
  flow;
- replace temporary FDT mapping in TTBR1 with a FDT mapping in the
  initial ID map;
- use read-only attributes for all code mappings, so we can boot with
  WXN enabled if we elect to do so.

Changes since v1:
- Remove the dodgy handling of the KASLR seed, which was necessary to
  avoid doing two iterations of the setup/teardown of the page tables.
  This is now dealt with by creating the TTBR1 page tables while
  executing from TTBR0, and so all memory manipulations are still done
  with the MMU and caches on.
- Only boot from EFI with the MMU and caches on if the image was not
  moved around in memory. Otherwise, we cannot rely on the firmware's ID
  map to have created an executable mapping for the copied code.

[0] https://lore.kernel.org/all/20220304175657.2744400-1-ardb@kernel.org/
[1] https://lore.kernel.org/all/20220330154205.2483167-1-ardb@kernel.org/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/ardb/efilite.git/

Cc: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Brown <broonie@kernel.org>

Ard Biesheuvel (30):
  arm64: head: move kimage_vaddr variable into C file
  arm64: mm: make vabits_actual a build time constant if possible
  arm64: head: move assignment of idmap_t0sz to C code
  arm64: head: drop idmap_ptrs_per_pgd
  arm64: head: simplify page table mapping macros (slightly)
  arm64: head: switch to map_memory macro for the extended ID map
  arm64: head: split off idmap creation code
  arm64: kernel: drop unnecessary PoC cache clean+invalidate
  arm64: head: pass ID map root table address to __enable_mmu()
  arm64: mm: provide idmap pointer to cpu_replace_ttbr1()
  arm64: head: add helper function to remap regions in early page tables
  arm64: head: cover entire kernel image in initial ID map
  arm64: head: use relative references to the RELA and RELR tables
  arm64: head: create a temporary FDT mapping in the initial ID map
  arm64: idreg-override: use early FDT mapping in ID map
  arm64: head: factor out TTBR1 assignment into a macro
  arm64: head: populate kernel page tables with MMU and caches on
  arm64: head: record CPU boot mode after enabling the MMU
  arm64: kaslr: deal with init called with VA randomization enabled
  arm64: head: relocate kernel only a single time if KASLR is enabled
  arm64: head: remap the kernel text/inittext region read-only
  arm64: setup: drop early FDT pointer helpers
  arm64: mm: move ro_after_init section into the data segment
  arm64: mm: add support for WXN memory translation attribute
  arm64: head: record the MMU state at primary entry
  arm64: head: avoid cache invalidation when entering with the MMU on
  arm64: head: clean the ID map page to the PoC
  efi: libstub: pass image handle to handle_kernel_image()
  efi/arm64: libstub: run image in place if randomized by the loader
  arm64: efi/libstub: enter with the MMU on if executing in place

 arch/arm64/Kconfig                        |  11 +
 arch/arm64/include/asm/assembler.h        |  14 +
 arch/arm64/include/asm/kernel-pgtable.h   |  18 +-
 arch/arm64/include/asm/memory.h           |   6 +
 arch/arm64/include/asm/mmu_context.h      |  47 +-
 arch/arm64/include/asm/setup.h            |   3 -
 arch/arm64/kernel/Makefile                |   2 +-
 arch/arm64/kernel/cpufeature.c            |   2 +-
 arch/arm64/kernel/efi-entry.S             |   4 +
 arch/arm64/kernel/head.S                  | 570 +++++++++++---------
 arch/arm64/kernel/idreg-override.c        |  33 +-
 arch/arm64/kernel/image-vars.h            |   4 +
 arch/arm64/kernel/kaslr.c                 |  83 +--
 arch/arm64/kernel/pi/Makefile             |  33 ++
 arch/arm64/kernel/pi/kaslr_early.c        | 128 +++++
 arch/arm64/kernel/setup.c                 |  27 +-
 arch/arm64/kernel/sleep.S                 |   1 +
 arch/arm64/kernel/suspend.c               |   2 +-
 arch/arm64/kernel/vmlinux.lds.S           |  60 ++-
 arch/arm64/mm/kasan_init.c                |   4 +-
 arch/arm64/mm/mmu.c                       |  84 ++-
 arch/arm64/mm/proc.S                      |   8 +-
 drivers/firmware/efi/libstub/arm32-stub.c |   3 +-
 drivers/firmware/efi/libstub/arm64-stub.c |  15 +-
 drivers/firmware/efi/libstub/efi-stub.c   |   2 +-
 drivers/firmware/efi/libstub/efistub.h    |   3 +-
 drivers/firmware/efi/libstub/riscv-stub.c |   3 +-
 include/linux/efi.h                       |  11 +
 28 files changed, 745 insertions(+), 436 deletions(-)
 create mode 100644 arch/arm64/kernel/pi/Makefile
 create mode 100644 arch/arm64/kernel/pi/kaslr_early.c

-- 
2.30.2

