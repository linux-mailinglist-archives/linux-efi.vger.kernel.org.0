Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80EAE4EC88E
	for <lists+linux-efi@lfdr.de>; Wed, 30 Mar 2022 17:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239913AbiC3Pn7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Mar 2022 11:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239041AbiC3Pn6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Mar 2022 11:43:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4D033E3E
        for <linux-efi@vger.kernel.org>; Wed, 30 Mar 2022 08:42:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 370AD6171D
        for <linux-efi@vger.kernel.org>; Wed, 30 Mar 2022 15:42:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE313C340F0;
        Wed, 30 Mar 2022 15:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648654932;
        bh=FfIHUPw313dgijYyagy3cC8L+xYJoOvpFSuf4zUzgbk=;
        h=From:To:Cc:Subject:Date:From;
        b=NUfS7j1nsp+oGxxE7iZLfJR2tY/zNJ0i6sF18jwuK0XRSnKfIqt3PLKp0SCP8Mzzr
         ZdU5rcDXVS26Nr6/Jd/MIggGWSXZrR8AYbhKk7pNW44uM9Ikj2S2E1nGYAglDs+nX5
         ORay3XaiYgEeKV1Rd6W4wuvbpsdfeAEMiYuLYCHLzFVEamrSErcJhiu1roB8xvPHv4
         Q08RfNObtHuDULAfKmUVG6rw/YxB4EKvPoZnFtiW/vWC3mqtMA7kfot3b0oeWVAHRE
         RwEJeHaIhcwu9XIP75lGR3Cho0ZG2IQgpumFLQnJUYn6r4PP61qthDohYATqHzYO0e
         rdA4a+b/50VPA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, keescook@chromium.org,
        mark.rutland@arm.com, catalin.marinas@arm.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Subject: [RFC PATCH v2 00/18] arm64: efi: leave MMU and caches on at boot
Date:   Wed, 30 Mar 2022 17:41:47 +0200
Message-Id: <20220330154205.2483167-1-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4795; h=from:subject; bh=FfIHUPw313dgijYyagy3cC8L+xYJoOvpFSuf4zUzgbk=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiRHouqHCwt5dstAymQcTjzn6EDKKywbPVKiXC2ls4 1YJFU0eJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYkR6LgAKCRDDTyI5ktmPJCZLC/ wNH8+SxgPF1FScZe1bZdSvHGqZ2BeB+QvJWIzxZ/tXJh1YGE5JF1osfj/UINUQoUcEh3JnPwrMe/hW 5Im9rv7SxjN2AQPG8HSM658fPgB7H9gC6zFYvf7c5nLawCb2oydCrDnbh18YPut9RpQMFfGWy1K7H1 5mdmguNGzQC0Z2W5eEs4kLwOLe7Acs7dyDKys0Uj/X8SHXZCxyii8WiWq0fMbpScctBKJY+VSEHoj2 Yqsqn6LhPIOJexT2hL1kNiK5yckCaf0V0rSmXGH8miewfVZWZ1aDbRfer007gWNU98aBe8iS5CqLue 3HRPCld9pLD7zI8ZVr8AeCB2+kcnZ36ys3N8fuhDRhoPC9ePcu1abK6pxfk2qUDgvQOJnUyQxLjjtU STJAZOiRrJ5vQL2MyQEymBkawR4J13h4fSFN23I/7J8XL/Bzl2H3FEaQJ4HCTijxxsjM7Fvox8I7me AbaIQQHv4DblakjTKlDoA9pg8fQSWUukeByT5goIQrvYA=
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

This is a followup to a previous series of mine [0], and it aims to
streamline the boot flow with respect to cache maintenance and redundant
copying of data in memory.

Combined with my proof-of-concept firmware for QEMU/arm64 [1], this
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
the old mapping and creat a new one, relocate the kernel again, and
finally enter the kernel proper. Instead, it invokes a minimal C
function 'kaslr_early_init()' while running from the ID map with a
temporary mapping of the FDT in TTBR1. This change represents a
substantial of the diffstat, as it requires some work to instantiate
code that can run safely from the wrong address. It is also the most
likely to raise objections, so it can be dropped from this series if
desired (patch #9 is the meat, and #8 is a prerequisite patch that could
be dropped in that case as well)

Changes since v1:
- Remove the dodgy handling of the KASLR seed, which was necessary to
  avoid doing two iterations of the setup/teardown of the page tables.
  This is now dealt with by creating the TTBR1 page tables while
  executing from TTBR0, and so all memory manipulations are still done
  with the MMU and caches on. (This is also the reason patch #9 is
  optional now)
- Only boot from EFI with the MMU and caches on if the image was not
  moved around in memory. Otherwise, we cannot rely on the firmware's ID
  map to have created an executable mapping for the copied code.

[0] https://lore.kernel.org/all/20220304175657.2744400-1-ardb@kernel.org/
[1] https://git.kernel.org/pub/scm/linux/kernel/git/ardb/efilite.git/

Cc: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>

Ard Biesheuvel (18):
  arm64: head: drop idmap_ptrs_per_pgd
  arm64: head: split off idmap creation code
  arm64: kernel: drop unnecessary PoC cache clean+invalidate
  arm64: head: cover entire kernel image in ID map
  arm64: head: factor out TTBR1 assignment into a macro
  arm64: head: populate kernel page tables with MMU and caches on
  arm64: kaslr: deal with init called with VA randomization enabled
  arm64: setup: defer R/O remapping of FDT
  arm64: head: relocate kernel only a single time if KASLR is enabled
  arm64: head: record the MMU state at primary entry
  arm64: mm: make vabits_actual a build time constant if possible
  arm64: head: avoid cache invalidation when entering with the MMU on
  arm64: head: record CPU boot mode after enabling the MMU
  arm64: head: clean the ID map page to the PoC
  arm64: lds: move idmap_pg_dir out of .rodata
  efi: libstub: pass image handle to handle_kernel_image()
  efi/arm64: libstub: run image in place if randomized by the loader
  arm64: efi/libstub: enter with the MMU on if executing in place

 arch/arm64/include/asm/kernel-pgtable.h   |   2 +-
 arch/arm64/include/asm/memory.h           |   6 +
 arch/arm64/include/asm/mmu_context.h      |   1 -
 arch/arm64/kernel/Makefile                |   2 +-
 arch/arm64/kernel/efi-entry.S             |   4 +
 arch/arm64/kernel/head.S                  | 276 +++++++++++---------
 arch/arm64/kernel/kaslr.c                 |  86 +-----
 arch/arm64/kernel/pi/Makefile             |  33 +++
 arch/arm64/kernel/pi/kaslr_early.c        | 128 +++++++++
 arch/arm64/kernel/setup.c                 |   8 +-
 arch/arm64/kernel/vmlinux.lds.S           |   9 +-
 arch/arm64/mm/mmu.c                       |  15 +-
 drivers/firmware/efi/libstub/arm32-stub.c |   3 +-
 drivers/firmware/efi/libstub/arm64-stub.c |  15 +-
 drivers/firmware/efi/libstub/efi-stub.c   |   2 +-
 drivers/firmware/efi/libstub/efistub.h    |   3 +-
 drivers/firmware/efi/libstub/riscv-stub.c |   3 +-
 include/linux/efi.h                       |  11 +
 18 files changed, 380 insertions(+), 227 deletions(-)
 create mode 100644 arch/arm64/kernel/pi/Makefile
 create mode 100644 arch/arm64/kernel/pi/kaslr_early.c

-- 
2.30.2

