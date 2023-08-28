Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D76A78AE86
	for <lists+linux-efi@lfdr.de>; Mon, 28 Aug 2023 13:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbjH1LMz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 28 Aug 2023 07:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbjH1LMj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 28 Aug 2023 07:12:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A3AB0
        for <linux-efi@vger.kernel.org>; Mon, 28 Aug 2023 04:12:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BD0F6118F
        for <linux-efi@vger.kernel.org>; Mon, 28 Aug 2023 11:12:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A9CC433C7;
        Mon, 28 Aug 2023 11:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693221156;
        bh=LxY+jFnL+dqeUUoOxCSW0bAmgoq9YmhSBnju7998mVA=;
        h=From:To:Cc:Subject:Date:From;
        b=Q5ciJmB7GtxYaJA+wuieEf6y9ydKAzdbsJxt651SD3PuQZCBGSBqKs9O09T3khPae
         p7cXzyTWjj8de3UEa88vnseSl8sWuT52Pvkrd/Wn1nkT5oX3nJFL4sKJXx/G8Cjz5W
         WY7zqMYanU7sQOfU/9swA4b0rgBzO42wmzMJqqlksP52YZnLnrG9ouNJ82qAdg4ELL
         LHYTD9xFKcnBmu3C948GRTBbYRT43vbtbQeFb4I35rec6EhBpGeYIBSYkAT5j0SOGK
         Bil53mYNtk2QHb4qg2U+4H6zsoCilDNIKaLzFnISoIbZrLS1+PoKqGMnlRILfODuDv
         94B6j4LA2+VFw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [GIT PULL] EFI updates for v6.6
Date:   Mon, 28 Aug 2023 13:12:29 +0200
Message-Id: <20230828111229.107143-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3005; i=ardb@kernel.org; h=from:subject; bh=LxY+jFnL+dqeUUoOxCSW0bAmgoq9YmhSBnju7998mVA=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeVNo4xYieGxa83PYg1Marf5zIn4O4O9MMrz6yseI+dTm T6WS4w7SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwERCaxgZHrx+KKrCb2SXdv5n 2pHiXS3hEx4uClL5tOIcOxvr4sg6G4Z/6nuOxNtOneGiGfjbab4ZY52unzSH7NNM796zT8OO2bv wAwA=
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

Hello Linus,

Most of the EFI work this cycle will be arriving via the -tip tree, given that
it is closely tied to the x86 decompressor.

This PR primarily covers some cleanup work on the EFI runtime wrappers, which
are shared between all EFI architectures except Itanium, and which provide some
level of isolation to prevent faults occurring in the firmware code (which
runs at the same privilege level as the kernel) from bringing down the system.

Beyond that, there is a fix that did not make it into v6.5, and some doc fixes
and dead code cleanup.

Please pull.


The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.6

for you to fetch changes up to b691118f2c44d16b84fc65b8147b33620eb18cac:

  Merge remote-tracking branch 'linux-efi/urgent' into efi/next (2023-08-28 12:57:05 +0200)

----------------------------------------------------------------
EFI updates for v6.6

- one bugfix for x86 mixed mode that did not make it into v6.5
- first pass of cleanup for the EFI runtime wrappers
- some cosmetic touchups

----------------------------------------------------------------
Ard Biesheuvel (9):
      efi/arm64: Move EFI runtime call setup/teardown helpers out of line
      efi/riscv: Move EFI runtime call setup/teardown helpers out of line
      efi/runtime-wrappers: Use type safe encapsulation of call arguments
      efi/runtime-wrapper: Move workqueue manipulation out of line
      efi/runtime-wrappers: Remove duplicated macro for service returning void
      efi/runtime-wrappers: Don't duplicate setup/teardown code
      acpi/prmt: Use EFI runtime sandbox to invoke PRM handlers
      efi/runtime-wrappers: Clean up white space and add __init annotation
      Merge remote-tracking branch 'linux-efi/urgent' into efi/next

Mikel Rychliski (1):
      x86/efistub: Fix PCI ROM preservation in mixed mode

Xiao Wang (1):
      efi/riscv: libstub: Fix comment about absolute relocation

YueHaibing (1):
      efi: Remove unused extern declaration efi_lookup_mapped_addr()

Zhu Wang (1):
      efi: memmap: Remove kernel-doc warnings

 arch/arm64/include/asm/efi.h            |  18 +-
 arch/arm64/kernel/efi.c                 |  16 +-
 arch/riscv/include/asm/efi.h            |  10 +-
 arch/x86/include/asm/uv/bios.h          |   4 +-
 arch/x86/platform/efi/memmap.c          |   2 +-
 drivers/acpi/Kconfig                    |   2 +-
 drivers/acpi/prmt.c                     |   8 +-
 drivers/firmware/efi/libstub/Makefile   |   2 +-
 drivers/firmware/efi/libstub/x86-stub.c |   2 +-
 drivers/firmware/efi/riscv-runtime.c    |  15 +-
 drivers/firmware/efi/runtime-wrappers.c | 358 +++++++++++++++++++++-----------
 include/linux/efi.h                     |  53 ++---
 12 files changed, 299 insertions(+), 191 deletions(-)
