Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DBD6658ED
	for <lists+linux-efi@lfdr.de>; Wed, 11 Jan 2023 11:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237639AbjAKKXX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 11 Jan 2023 05:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237663AbjAKKXD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 11 Jan 2023 05:23:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627856560
        for <linux-efi@vger.kernel.org>; Wed, 11 Jan 2023 02:23:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00B4061BD4
        for <linux-efi@vger.kernel.org>; Wed, 11 Jan 2023 10:23:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9EDCC433D2;
        Wed, 11 Jan 2023 10:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673432581;
        bh=lcPj04+Wr5+wEEKeDtjqgdgglk+f5f98THqrHZCXLfw=;
        h=From:To:Cc:Subject:Date:From;
        b=lEEIS2OCwtq7rOze7LAu+BCBHF4b6c44Q6r43gfgeOhaxlzlz+gafu8q02A9MGT/P
         /P8lOQg4dBprgCVFr3OILmcWEyuH9iFYox/lnNJz6gg5tvqudzrNqu3oidOBP80p/U
         qBl3gxG3Lkx34YatiCbNKZQdM4fT6JkC2itMf+7jMQGJOw4N7nSwahUu5tHUdr6Slt
         w3EHR4kPZbLZWT+09otP15ZUKB/JQcmAbZZ+9jPxXoNAJ9Cn2ldI36HseoPrwQ9j3X
         OFLyPukbQL/lE4IOlrzGGGkMylZMYK2R7vgBdslAHvGLtzrXDWR2UyxZ5C7X4cpJis
         iOGsXGVLyUEcA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v7 0/6] arm64: Permit EFI boot with MMU and caches on
Date:   Wed, 11 Jan 2023 11:22:30 +0100
Message-Id: <20230111102236.1430401-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4076; i=ardb@kernel.org; h=from:subject; bh=lcPj04+Wr5+wEEKeDtjqgdgglk+f5f98THqrHZCXLfw=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjvo3izFCJ5ykydfm55U1knKsHomPpitnU5mMwdnGL GgPZFtWJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY76N4gAKCRDDTyI5ktmPJH+kC/ 4x7mH0+BwmngO7q41805u6xntiPI75VI+ekp0Q6DL5EbzYPFrkaWPF5nWUXcvheoHANgtHrsrCJM1I AMC1vsyddliXp/u+JkBdM28edDbhT4LmS0x7oqy2dy1UcFdKmg0KZ/I4IO0Mup/Lq7gr4IbN94hOxh HFsBWciTNtuQx+qhnVqLc7D2ZtkOtWyyfy/+psqPg1vk6gZbfEekKWEN9AB+73sj+urGEp5YYvQArr o+kzSksNLb4/1JLqZSLi6b6c/VnSAv/k5Te9jSH+Ejhd2n013RPtxtfz3OWjkj22EJKz03cgolTR5K Q9c3GR0tOd+2fbDiSdaJyACoLUhC22C5C0VL1a5xvIJX/vHqTsmZ5Bl4BXjh7z1UJxgQKUywm00e6e duJs7YR/pb76tfIDGzI1dq9RJCZ+3TWx3zE9JRLmIC+mgMdbh4AjATBL9QRdw7NagKprmuLcDdfPGx kJElQ1fUF7Hu4Fo0G2pMFvGqggk6kkhQjk+LSTd2ZI1G8=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The purpose of this series is to remove any explicit cache maintenance
for coherency during early boot. Software managed coherency is error
prone and tedious, and running with the MMU off is generally bad for
performance, and it becomes unnecessary if we simply retain the
cacheable 1:1 mapping of all of system RAM provided by EFI, and use it
to populate the initial ID map page tables. After setting up this
preliminary ID map, we disable the MMU, drop to EL1, reprogram the MAIR,
TCR and SCTLR registers as before, and proceed as usual, avoiding the
need for any manipulations of memory while the MMU and caches are off.

The only properties of the firmware provided 1:1 map we rely on is that
it does not require any explicit cache maintenance for coherency, and
that it covers the entire memory footprint of the image, including the
BSS and padding at the end - all else is under control of the kernel
itself, as before.

The final patch updates the EFI stub code so that it no longer disables
the MMU and caches or cleans the entire image to the PoC. Note that
some cache maintenace for I/D coherence may still be needed, in the
zboot case (which decompresses and boots a compressed kernel image) or
in cases where the image is moved in memory.

Changes since v6:
- drop the 64k alignment patch, which is not strictly a prerequisite,
  and will be revisited later if needed
- add back EFI stub changes now that all dependencies are in mainline
- panic() the kernel later in the boot if we detected a non-EFI boot
  occurring with the MMU and caches enabled

Changes since v5:
- add a special entry point into the boot sequence that is to be used by
  EFI only, and only permit booting with the MMU enabled when using that
  boot path;
- omit the final patch that would need to go via the EFI tree in any
  case - adding the new entrypoint specific for EFI makes it conflict
  even more badly, and I'll try to revisit this during the merge window
  or simply defer the final piece for the next release;

Changes since v4:
- add patch to align the callers of finalise_el2()
- also clean HYP text to the PoC when booting at EL2 with the MMU on
- add a warning and a taint when doing non-EFI boot with the MMU and
  caches enabled
- rebase onto zboot changes in efi/next - this means that patches #6 and
  #7 will not apply onto arm64/for-next so a shared stable branch will
  be needed if we want to queue this up for v6.2

Changes since v3:
- drop EFI_LOADER_CODE memory type patch that has been queued in the
  mean time
- rebased onto [partial] series that moves efi-entry.S into the libstub/
  source directory
- fixed a correctness issue in patch #2

Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>

Ard Biesheuvel (6):
  arm64: head: Move all finalise_el2 calls to after __enable_mmu
  arm64: kernel: move identity map out of .text mapping
  arm64: head: record the MMU state at primary entry
  arm64: head: avoid cache invalidation when entering with the MMU on
  arm64: head: Clean the ID map and the HYP text to the PoC if needed
  efi: arm64: enter with MMU and caches enabled

 arch/arm64/include/asm/efi.h               |  2 +
 arch/arm64/kernel/head.S                   | 89 +++++++++++++++-----
 arch/arm64/kernel/image-vars.h             |  5 +-
 arch/arm64/kernel/setup.c                  | 17 +++-
 arch/arm64/kernel/sleep.S                  |  6 +-
 arch/arm64/kernel/vmlinux.lds.S            |  2 +-
 arch/arm64/mm/cache.S                      |  1 +
 arch/arm64/mm/proc.S                       |  2 -
 drivers/firmware/efi/libstub/Makefile      |  4 +-
 drivers/firmware/efi/libstub/arm64-entry.S | 67 ---------------
 drivers/firmware/efi/libstub/arm64-stub.c  | 26 ++++--
 drivers/firmware/efi/libstub/arm64.c       | 41 +++++++--
 12 files changed, 151 insertions(+), 111 deletions(-)
 delete mode 100644 drivers/firmware/efi/libstub/arm64-entry.S

-- 
2.39.0

