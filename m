Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39837586C26
	for <lists+linux-efi@lfdr.de>; Mon,  1 Aug 2022 15:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbiHANld (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 1 Aug 2022 09:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiHANlc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 1 Aug 2022 09:41:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836BEBC39
        for <linux-efi@vger.kernel.org>; Mon,  1 Aug 2022 06:41:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44DDAB811FE
        for <linux-efi@vger.kernel.org>; Mon,  1 Aug 2022 13:41:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED261C433B5;
        Mon,  1 Aug 2022 13:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659361289;
        bh=GT2/eqO48zHlN+Lpd5wrh+z4tBVfFRIRNEhveSM9j98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EN0ZCl2kHsORTmHqPqAiv4BLhb6fxu8nknxA5Oa1vUKnkCdGaL8xG6Z1eORaaOQb6
         IQETmPA6i+xBGyZe4I7exSJAPsWwqnApHXHpQ9UZjsoYeuMXEbtwNINdo4PgE0ZGok
         4FhDMxHK/tfq+Y7FHBHm3ekjJq/jEeuyoNDSXANdMrTJFiMq+dJIvERnz695Tr7wNC
         JG/xE12dbtufEg5L84yUDdFvEMsdGuWz3aE3jhVwOWvmfiiFXBlYg3sC2eUpfsz6ex
         Z/EBKtnvxhoqgtmTELj5fewFBLDCQPLCYdLoRFvffsx4Zu4npFKIez5/V0rnGW/k/z
         rm/IGTA0ZBu1w==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-efi@vger.kernel.org, keescook@chromium.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [GIT PULL 1/2] EFI updates for v5.20
Date:   Mon,  1 Aug 2022 15:41:16 +0200
Message-Id: <20220801134117.1605678-2-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220801134117.1605678-1-ardb@kernel.org>
References: <20220801134117.1605678-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4457; i=ardb@kernel.org; h=from:subject; bh=GT2/eqO48zHlN+Lpd5wrh+z4tBVfFRIRNEhveSM9j98=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBi59f45MyBgsDbo29ARWbCQCG1TtaY1pRr15wYkQ5g xRkK/DKJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYufX+AAKCRDDTyI5ktmPJGL4DA CVKCpcLBZcMTLOeNOQhLQ0sAyjCFBT1JF2jf1f3DMGVUtDCbUPk43k6eoyW4MAf9sIcJdPlEhFiuDh c2sW+9eh8WMLVMxSM/3vqMRtjCGf8KdwTO/T9vpz7NUkV9DB/au0rAE7bTQlm6bESX0JPU78uYHwKA orK96GS/2c0e7k5n14WOmKyqswFgOrU0g/sgcVHd+IXKyvgW4o8skxBjh8xHYS3hhjwL4nidZuu18K yc9HOIUh1eypv+R3G5jvN9uAph/eKJ5O0jz6tRNB7ThBbgKxPbi/+nC8bNMXwpleNUhJz2BAj0K5G8 uymq2pLWNskxRB4oPPs3velQ09/gJI/tLbCQOLIg5ocXJUQEE3N7E0fLwh82uNc9meyL37FEuEHX2l bhN3VF63lquLHydfGbb0zi/3pVEPXsL1C0R0AgS4fsVrUjsJ5YZiaEFykjgvBR8blQ2tQIhr/DT2F8 1jbz/CUpa5FcC1BUtHLXBFJHGTSXyke7feGkgA5AdVO2s=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v5.20

for you to fetch changes up to e3435fff6ae03ca3ec1279299664f968478067e2:

  ACPI: Move PRM config option under the main ACPI config (2022-06-30 17:36:03 +0200)

----------------------------------------------------------------
EFI updates for v5.20

- Enable mirrored memory for arm64
- Fix up several abuses of the efivar API
- Refactor the efivar API in preparation for moving the 'business logic'
  part of it into efivarfs
- Enable ACPI PRM on arm64

----------------------------------------------------------------
Ard Biesheuvel (13):
      efi: avoid efivars layer when loading SSDTs from variables
      efi: efibc: avoid efivar API for setting variables
      media: atomisp_gmin_platform: stop abusing efivar API
      iwlwifi: Switch to proper EFI variable store interface
      brcmfmac: Switch to appropriate helper to load EFI variable contents
      selftests/kexec: remove broken EFI_VARS secure boot fallback check
      Input: applespi - avoid efivars API and invoke EFI services directly
      pstore: Add priv field to pstore_record for backend specific use
      efi: vars: Don't drop lock in the middle of efivar_init()
      efi: vars: Add thin wrapper around EFI get/set variable interface
      efi: pstore: Omit efivars caching EFI varstore access layer
      efi: vars: Use locking version to iterate over efivars linked lists
      efi: vars: Drop __efivar_entry_iter() helper which is no longer used

Liu Zixian (1):
      efi: Correct comment on efi_memmap_alloc

Ma Wupeng (5):
      efi: Make code to find mirrored memory ranges generic
      mm: Ratelimited mirrored memory related warning messages
      mm: Limit warning message in vmemmap_verify() to once
      arm64: mm: Only remove nomap flag for initrd
      memblock: Disable mirror feature if kernelcore is not specified

Sudeep Holla (4):
      efi: Simplify arch_efi_call_virt() macro
      ACPI: PRM: Change handler_addr type to void pointer
      ACPI: Enable Platform Runtime Mechanism(PRM) support on ARM64
      ACPI: Move PRM config option under the main ACPI config

Zheng Zhi Yuan (1):
      drivers: fix typo in firmware/efi/memmap.c

 arch/arm/include/asm/efi.h                         |   7 -
 arch/arm64/include/asm/efi.h                       |   7 +-
 arch/arm64/mm/init.c                               |   2 +-
 arch/loongarch/include/asm/efi.h                   |  16 +-
 arch/riscv/include/asm/efi.h                       |   2 -
 arch/x86/include/asm/efi.h                         |   7 +-
 arch/x86/platform/efi/efi.c                        |  23 --
 drivers/acpi/Kconfig                               |  30 +-
 drivers/acpi/prmt.c                                |   4 +-
 drivers/firmware/efi/Kconfig                       |   2 +
 drivers/firmware/efi/efi-init.c                    |   1 +
 drivers/firmware/efi/efi-pstore.c                  | 377 +++++----------------
 drivers/firmware/efi/efi.c                         | 126 +++----
 drivers/firmware/efi/efibc.c                       |  76 ++---
 drivers/firmware/efi/efivars.c                     |  25 +-
 drivers/firmware/efi/memmap.c                      |   5 +-
 drivers/firmware/efi/vars.c                        | 258 +++++++++-----
 drivers/input/keyboard/applespi.c                  |  42 +--
 .../broadcom/brcm80211/brcmfmac/firmware.c         |  25 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c       |  96 ++----
 .../media/atomisp/pci/atomisp_gmin_platform.c      |  27 +-
 fs/efivarfs/super.c                                |  15 +-
 fs/pstore/inode.c                                  |   1 +
 fs/pstore/platform.c                               |   1 +
 include/linux/efi.h                                |  33 +-
 include/linux/pstore.h                             |   4 +
 mm/internal.h                                      |   2 +
 mm/memblock.c                                      |   7 +-
 mm/page_alloc.c                                    |   2 +-
 mm/sparse-vmemmap.c                                |   2 +-
 tools/testing/selftests/kexec/kexec_common_lib.sh  |  36 +-
 31 files changed, 486 insertions(+), 775 deletions(-)
