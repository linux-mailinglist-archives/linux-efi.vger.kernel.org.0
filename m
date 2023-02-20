Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3B269D32D
	for <lists+linux-efi@lfdr.de>; Mon, 20 Feb 2023 19:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbjBTStg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 20 Feb 2023 13:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbjBTStS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 20 Feb 2023 13:49:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AB821963
        for <linux-efi@vger.kernel.org>; Mon, 20 Feb 2023 10:48:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6FBE8B80DC2
        for <linux-efi@vger.kernel.org>; Mon, 20 Feb 2023 18:47:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FD2C433EF;
        Mon, 20 Feb 2023 18:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676918858;
        bh=3ms93vsBOessP/xSP4dhzJulcJNg2kBuWBhNm6yley0=;
        h=From:To:Cc:Subject:Date:From;
        b=Bgf0mJn7hztKYA7qAHASgXN9VmfIQSyo9YVSa5hh7PJisEYLVv+GVeMYagJ3BRA33
         cfCi7lN1BCXKWYEih7LQE3QJ6z/VN9KVSoHK+jOtHOkItK4tYJvUfcSg/DuXQFvRbp
         6CVQs5JafeAGqEkRzciNvSvDNms1tqhnkE7D17tfXu9zchnbpDagL86jvPSH3s6UNU
         mPM6N4DIOO1S9VzENDhAXsRQz+RDfkrxEw4H59Gz9zdn/ZAlqZA8VHYCmXkC8qZuEV
         shqBADvZRnK/PHpWgVkq56InKcXoaIl6fIIOUihKGK9QSxqTpmYmu5ytu9S7m0vqeN
         x7TOn0vDJnmdQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [GIT PULL] EFI updates for v6.3
Date:   Mon, 20 Feb 2023 19:47:29 +0100
Message-Id: <20230220184729.344373-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5728; i=ardb@kernel.org; h=from:subject; bh=3ms93vsBOessP/xSP4dhzJulcJNg2kBuWBhNm6yley0=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBj88BAQq+t6/GzCHcpXu0de3tkjO+7ReRnacYBS T0MPttQxkaJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY/PAQAAKCRDDTyI5ktmP JBL2C/9sIgtVPZ5RwgE1Y7pTSCMaOCaOhtwYBor7h0x2xer2ZQRrKgFlOyyk3GjNsaGxT1ZFMb9 yRuXVgKJBCmj2+3Dvbsrj7hdmTywWh8i8bnvVa5aBjUsTLcWRX9X4Wfd616CSs48hrpEWoCyXry SLX0pg27/P5AeNzRFlq+RilyQlAQmtS5mqLdoMZOgphSgIvYbFPfOkuk/tE19YLmsrQkG+3Nttt YMHjWIWLqRsCVOc/gNVUQMcfM8zQRhTXrFSY6kmK7ocG1j6bwRGQCG/AaTzv/0IHfJsu9io/37Q sU3pC+3FW5iFpQ9drCRYJve7WnShKMsx/rAyS0QHZye7gz7es5hAs18CKAemDOcNjV1GbXZ6YW1 esExsNQ+33qz5NENN3FX02bUvl+q+ATxrSRpd4MEOG1Mx18dq+dJZ5yn514+iqGv0Twf6YHqCGN 695JE79d1nnrqkOS8pyJFLbiShYnBhsyZ+ETHFnZsBD/HGABpqgilAvjjtVwAmh8TJpqc=
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

Please pull the EFI updates below.

There is one minor conflict [0] in arch/arm64/include/asm/efi.h against a fix
that went into -rc8, but not worth the hassle of merging back the EFI fixes
branch, so you'll have to fix that up (if you don't mind).

Thanks,
Ard.


The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.3

for you to fetch changes up to e1d447157f232c650e6f32c9fb89ff3d0207c69a:

  firmware/efi sysfb_efi: Add quirk for Lenovo IdeaPad Duet 3 (2023-02-19 14:41:33 +0100)

[0] https://lore.kernel.org/all/20230220135844.73e9dcae@canb.auug.org.au/

----------------------------------------------------------------
A healthy mix of EFI contributions this time:

- Performance tweaks for efifb earlycon by Andy

- Preparatory refactoring and cleanup work in the efivar layer by Johan,
  which is needed to accommodate the Snapdragon arm64 laptops that
  expose their EFI variable store via a TEE secure world API.

- Enhancements to the EFI memory map handling so that Xen dom0 can
  safely access EFI configuration tables (Demi Marie)

- Wire up the newly introduced IBT/BTI flag in the EFI memory attributes
  table, so that firmware that is generated with ENDBR/BTI landing pads
  will be mapped with enforcement enabled.

- Clean up how we check and print the EFI revision exposed by the
  firmware.

- Incorporate EFI memory attributes protocol definition contributed by
  Evgeniy and wire it up in the EFI zboot code. This ensures that these
  images can execute under new and stricter rules regarding the default
  memory permissions for EFI page allocations. (More work is in progress
  here)

- CPER header cleanup by Dan Williams

- Use a raw spinlock to protect the EFI runtime services stack on arm64
  to ensure the correct semantics under -rt. (Pierre)

- EFI framebuffer quirk for Lenovo Ideapad by Darrell.

----------------------------------------------------------------
Andy Shevchenko (2):
      efi/earlycon: Replace open coded strnchrnul()
      efi/earlycon: Speed up scrolling by disregarding empty space

Ard Biesheuvel (7):
      efi: zboot: Use EFI protocol to remap code/data with the right attributes
      efi: Drop minimum EFI version check at boot
      efi: Use standard format for printing the EFI revision
      efi: Discover BTI support in runtime services regions
      efi: arm64: Wire up BTI annotation in memory attributes table
      efi: x86: Wire up IBT annotation in memory attributes table
      efi: Add mixed-mode thunk recipe for GetMemoryAttributes

Dan Williams (1):
      efi/cper, cxl: Remove cxl_err.h

Darrell Kavanagh (1):
      firmware/efi sysfb_efi: Add quirk for Lenovo IdeaPad Duet 3

Demi Marie Obenour (5):
      efi: memmap: Disregard bogus entries instead of returning them
      efi: xen: Implement memory descriptor lookup based on hypercall
      efi: Apply allowlist to EFI configuration tables when running under Xen
      efi: Actually enable the ESRT under Xen
      efi: Warn if trying to reserve memory under Xen

Evgeniy Baskov (1):
      efi/libstub: Add memory attribute protocol definitions

Johan Hovold (6):
      efi: efivars: drop kobject from efivars_register()
      efi: efivars: make efivar_supports_writes() return bool
      efi: efivars: add efivars printk prefix
      efivarfs: always register filesystem
      efi: verify that variable services are supported
      efi: efivars: prevent double registration

Pierre Gondois (1):
      arm64: efi: Make efi_rt_lock a raw_spinlock

 arch/arm/include/asm/efi.h                     |  2 +-
 arch/arm/kernel/efi.c                          |  5 +-
 arch/arm64/include/asm/efi.h                   |  9 ++--
 arch/arm64/kernel/efi.c                        | 20 +++++--
 arch/arm64/kernel/traps.c                      |  6 +++
 arch/ia64/kernel/efi.c                         |  2 +-
 arch/riscv/include/asm/efi.h                   |  2 +-
 arch/riscv/kernel/efi.c                        |  3 +-
 arch/x86/include/asm/efi.h                     | 14 ++++-
 arch/x86/include/asm/ibt.h                     |  4 +-
 arch/x86/kernel/apm_32.c                       |  4 +-
 arch/x86/kernel/cpu/common.c                   |  5 +-
 arch/x86/platform/efi/efi.c                    |  2 +-
 arch/x86/platform/efi/efi_64.c                 |  8 ++-
 drivers/firmware/efi/cper_cxl.c                | 12 ++++-
 drivers/firmware/efi/earlycon.c                | 41 ++++++++++----
 drivers/firmware/efi/efi-init.c                |  2 +-
 drivers/firmware/efi/efi.c                     | 74 ++++++++++++++++++++------
 drivers/firmware/efi/esrt.c                    | 15 ++----
 drivers/firmware/efi/libstub/efi-stub-helper.c | 67 +++++++++++++++++++++++
 drivers/firmware/efi/libstub/efistub.h         | 23 ++++++++
 drivers/firmware/efi/libstub/zboot.c           |  2 +
 drivers/firmware/efi/memattr.c                 |  7 ++-
 drivers/firmware/efi/sysfb_efi.c               |  8 +++
 drivers/firmware/efi/vars.c                    | 38 +++++++------
 drivers/firmware/google/gsmi.c                 |  2 +-
 drivers/xen/efi.c                              | 61 +++++++++++++++++++++
 fs/efivarfs/super.c                            |  9 ++--
 include/linux/cxl_err.h                        | 22 --------
 include/linux/efi.h                            | 36 +++++++++----
 30 files changed, 389 insertions(+), 116 deletions(-)
 delete mode 100644 include/linux/cxl_err.h
