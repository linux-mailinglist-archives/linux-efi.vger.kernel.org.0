Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634065BECD8
	for <lists+linux-efi@lfdr.de>; Tue, 20 Sep 2022 20:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiITSgI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Sep 2022 14:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiITSgH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 20 Sep 2022 14:36:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507A65E32B
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 11:36:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0665EB81FAD
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 18:36:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294B8C433C1;
        Tue, 20 Sep 2022 18:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663698963;
        bh=ivCPc2oHxWWAe6CNvYUP2QQtDZ8+uBcU6Jmrj8llr00=;
        h=From:To:Cc:Subject:Date:From;
        b=BiGUNS9DJewIPpDFa34XrUXARiBY/iCXbKrBGn9XyTYdgJHUvBud1K4RF/9Yta3zD
         cboFwUFqyWXuTC7Jxc8lSTpcDXtWhyfk6E5wJAaSVGWoYGb6ytVWCra0kg/xOnYK/y
         H0GCUh3FpKG70C7rXFnEkfzKdXv1EO/26FxmSr6rKFBrixDvqAkRMFOzCvygvzrXEJ
         tBQOckxnn8bi7tHvvnH6fsgYE7HGkS/aTqMLftoCl4CDMTXOpNWE7vFy1iog0gU+Fm
         By2B6rfR+YQPeOv2vqFO+/E7iWXLQkFZwsPYsAA+UQGbPrOHMg4FaRttIEdWXEcPGc
         B0NOUES+DdGeA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     loongarch@lists.linux.dev, Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH v2 0/8] efi: disentangle the generic EFI stub from FDT
Date:   Tue, 20 Sep 2022 20:35:46 +0200
Message-Id: <20220920183554.3870247-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4108; i=ardb@kernel.org; h=from:subject; bh=ivCPc2oHxWWAe6CNvYUP2QQtDZ8+uBcU6Jmrj8llr00=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjKgf7CM7UM1z6wd5d+o/ryMIH+A2JYPPINfGBa3QA KwEXhZ2JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYyoH+wAKCRDDTyI5ktmPJECyC/ 940HrvVelLQEfMobP99d/5GHD+jUX9KAbZhZ/fZrf3wvbUFsjN/vjAGsK/MlUW9XB0kbYRN7ViEeVh rv2wcJSN1pO5ClbRb7ySk+DWj45CP0OqbMhW5wEmQd8nBOG5Xy8bYrEHoIRVJ1mhcLD/nPOpUN2eAU 0dKgMVwHzo5SbI/XUaBzE3WQsiZdCEY/42HIeRRMHh548UM5F3X7RNBD9wactIbbsUoThd0SPL8vFk xNhFF+LqtPI+TBg9b7IKD8B6x9uG5GtVqAqV3sw+qx1sdU0Inyb6XtDC2hS4AnFJxJL0wOPx+cTuW6 dWlUhPFAs0WplUhIhto3bvBpTquiCxpzFPBdfgZILF4k/du0DKT0UAAYhGIjPm1r4bwf7OLagvqWgU yNrPLtoMOo/sOpQvpcopxGznG3JipgoKakTwLb72mDoK6tnytqIS3O4FNdl2NWSiYr3RuwEdPYrsI9 81iFAdn53jWrl53pzF9lH9zw5ItiajE4TPped14PRCtfQ=
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

EFI architectures other than x86 rely on FDT to pass information between
the stub and the core kernel. In hindsight, this is probably a mistake,
given the issues around abuse of the internal ABI, and potential
inconsistencies between two sources of information that both originate
in the firmware (memory map, command line, etc)

Another reason for avoiding updates to the DT is the fact that it
interferes with secure boot and measured boot. Even if we measure the
original firmware provided DT into the TPM, the DT that the kernel
receives is a completely different blob, and verifying it against the
TPM event log is currently impossible.

So let's start hacking away at this, and refactor the generic stub so
that all the FDT pieces are isolated in a singe source file, and rely on
generic EFI config tables for passing the initrd base and size.
Ultimately, this should permit all EFI architectures doing DT boot to
perform the handover to the core kernel in a different way, and pass on
the firmware provided DT unmodified, but this requires some future work
for ARM/arm64 and RISC-V.

However, we can easily convert the newly added LoongArch code to adopt
this approach, and to consume the DT strictly for hardware descriptions
(if not doing ACPI boot), and pass the initrd, memory map and everything
else via EFI config tables. Generating empty DTBs on ACPI platforms will
no longer be needed.

The first six patches as well as patch #10 are general cleanup, and can
be merged separately. The remaining patches refactor the FDT code in the
EFI stub so that we can avoid it on platforms that don't need it for
other reasons. Finally, LoongArch is updated to use DT only for hardware
descriptions when doing EFI boot.

Changes since v1:
- to ease merging this with the loongarch tree, drop unrelated cleanup
  changes, which will be merged separately;
- drop the patch to enable DT for hw descriptions - it will be picked up
  again later
- avoid creating the INITRD table if no initrd was actually loaded;
- incorporate feedback from Huacai on the arch/loongarch changes;
- other minor tweaks.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>
Cc: Xi Ruoyao <xry111@xry111.site>

Ard Biesheuvel (8):
  efi: libstub: drop pointless get_memory_map() call
  efi: libstub: avoid efi_get_memory_map() for allocating the virt map
  efi: libstub: simplify efi_get_memory_map() and struct efi_boot_memmap
  efi: libstub: remove pointless goto kludge
  efi: libstub: unify initrd loading between architectures
  efi: libstub: remove DT dependency from generic stub
  efi: libstub: install boot-time memory map as config table
  efi/loongarch: libstub: remove dependency on flattened DT

 Documentation/arm/uefi.rst                     |   4 -
 arch/loongarch/Kconfig                         |   3 -
 arch/loongarch/include/asm/bootinfo.h          |   2 +-
 arch/loongarch/kernel/efi.c                    |  30 +++-
 arch/loongarch/kernel/env.c                    |  13 +-
 arch/loongarch/kernel/head.S                   |   2 +
 arch/loongarch/kernel/setup.c                  |   4 +-
 drivers/firmware/efi/efi.c                     |  15 ++
 drivers/firmware/efi/libstub/Makefile          |  13 +-
 drivers/firmware/efi/libstub/arm64-stub.c      |  19 +--
 drivers/firmware/efi/libstub/efi-stub-helper.c | 139 ++++++++--------
 drivers/firmware/efi/libstub/efi-stub.c        |  90 ++++------
 drivers/firmware/efi/libstub/efistub.h         |  28 +---
 drivers/firmware/efi/libstub/fdt.c             | 176 +++++++++++---------
 drivers/firmware/efi/libstub/loongarch-stub.c  |  56 ++++++-
 drivers/firmware/efi/libstub/mem.c             |  93 +++++------
 drivers/firmware/efi/libstub/randomalloc.c     |  25 +--
 drivers/firmware/efi/libstub/relocate.c        |  21 +--
 drivers/firmware/efi/libstub/x86-stub.c        |  30 +---
 include/linux/efi.h                            |  15 ++
 20 files changed, 395 insertions(+), 383 deletions(-)

-- 
2.35.1

