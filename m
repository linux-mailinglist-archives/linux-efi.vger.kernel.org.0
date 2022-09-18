Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150945BC014
	for <lists+linux-efi@lfdr.de>; Sun, 18 Sep 2022 23:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiIRVgC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 18 Sep 2022 17:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIRVgA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 18 Sep 2022 17:36:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807FD13FA2
        for <linux-efi@vger.kernel.org>; Sun, 18 Sep 2022 14:35:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1ABCE6124F
        for <linux-efi@vger.kernel.org>; Sun, 18 Sep 2022 21:35:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34F5C433D6;
        Sun, 18 Sep 2022 21:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663536958;
        bh=fsZq7dM6ZsraQFfi9mS7IdGp2dKiL4+nKBMG5swWY9A=;
        h=From:To:Cc:Subject:Date:From;
        b=WCYaMIpwpXz2fSiQ6BU7fNcktSAec59brFlu7mfH9CwZnC0awZ56h7SZbLC9COoM1
         83T5SN5y53QkKXW0jeZHuXzQB6VLrOlp/5khtjOOtsS0ktPtkq900jV3O6gPc8k6xR
         deOub6yf/9XtfhBhRogblSLJWtRYF05ZiCktlzNLTF86XZvJ+DCfX4B05poeLzbGTT
         h8DQxeCZzJa2uxvJn826fIWgb6RgcE4XZZkEM4GVGRyk3p0u3tDjCmEsYGjHDGtSw6
         Gers6wDHCZWBx/nprGq0LGda2uZ8OjtLQOlvfPkT0uz02vYFRhrasaBKPzFwj/1tiL
         fzgbe1NFsDodw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     loongarch@lists.linux.dev, linux@armlinux.org.uk,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH 00/12] efi: disentangle the generic EFI stub from FDT
Date:   Sun, 18 Sep 2022 23:35:32 +0200
Message-Id: <20220918213544.2176249-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4225; i=ardb@kernel.org; h=from:subject; bh=fsZq7dM6ZsraQFfi9mS7IdGp2dKiL4+nKBMG5swWY9A=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjJ48ZWIMfXKguz2PBXfas2dC+q1bPS+hvJKOvIXqg KnxZX72JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYyePGQAKCRDDTyI5ktmPJDjLC/ 0YWWn4qfVPzUWl7rQu4uvWgQUElDalSsdL90z/7Sm7EJ1YM2pa3dKY6qosWO9MM/IWpenKP0uUW1bL b2FYYiEQhr1O9/s9vKSr421Eom8K2GLceokBcKFkHl2EuWer4Xu1heC2y0A+5855CVNAhvA3sNm9Zj yleJXk6/9uh3BDKPKRgV3gW1nwwvs1q6PWxa5Gz6VS+WJ5MrtUIF3RpE9JxpJkjfR+gErYFyYQYwk0 I/CGcgBFrTg1igzBLPJk33zPQ6ukQuDThNUKAlh25eJ0/pxD5x3noNiAfAIMsOY/w2mlW2WavjZL4V XTwmKkBk1QnX856bXbwpC7IHnuh6aj9nZeTa1kz5kZppTYVYN+M7fKl+WH031ZmVlbCXIe/0ZbNg73 g0gAQSY5kekJvsJo/MSCvss4oM7q/B0aIpTBZU38jFPHMn6DvO9cSz3et8xto6scMUAhi8/WNr5015 wBvK6EMjLWmMDoyablSAynbVUlIzBn4uW3EH079GwDK30=
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

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>
Cc: Xi Ruoyao <xry111@xry111.site>

Ard Biesheuvel (12):
  efi: libstub: drop pointless get_memory_map() call
  efi/arm: libstub: move ARM specific code out of generic routines
  efi: libstub: fix up the last remaining open coded boot service call
  efi: libstub: fix type confusion for load_options_size
  efi: libstub: avoid efi_get_memory_map() for allocating the virt map
  efi: libstub: simplify efi_get_memory_map() and struct efi_boot_memmap
  efi: libstub: unify initrd loading between architectures
  efi: libstub: remove DT dependency from generic stub
  efi: libstub: install boot-time memory map as config table
  efi: libstub: remove pointless goto kludge
  efi/loongarch: libstub: remove dependency on flattened DT
  efi: loongarch: add support for DT hardware descriptions

 Documentation/arm/uefi.rst                     |   4 -
 arch/arm/include/asm/efi.h                     |   3 +-
 arch/arm/kernel/efi.c                          |  79 +++++++++
 arch/arm/kernel/setup.c                        |   2 +-
 arch/loongarch/Kconfig                         |   1 -
 arch/loongarch/include/asm/bootinfo.h          |   2 +-
 arch/loongarch/kernel/efi.c                    |  44 ++++-
 arch/loongarch/kernel/env.c                    |  24 +--
 arch/loongarch/kernel/head.S                   |   2 +
 arch/loongarch/kernel/setup.c                  |   4 +-
 drivers/firmware/efi/efi-init.c                |  61 +------
 drivers/firmware/efi/efi.c                     |  15 ++
 drivers/firmware/efi/libstub/Makefile          |  13 +-
 drivers/firmware/efi/libstub/arm64-stub.c      |  19 +--
 drivers/firmware/efi/libstub/efi-stub-helper.c | 127 +++++++-------
 drivers/firmware/efi/libstub/efi-stub.c        |  94 ++++-------
 drivers/firmware/efi/libstub/efistub.h         |  32 +---
 drivers/firmware/efi/libstub/fdt.c             | 175 +++++++++++---------
 drivers/firmware/efi/libstub/loongarch-stub.c  |  56 ++++++-
 drivers/firmware/efi/libstub/mem.c             |  85 +++++-----
 drivers/firmware/efi/libstub/randomalloc.c     |  25 +--
 drivers/firmware/efi/libstub/relocate.c        |  21 +--
 drivers/firmware/efi/libstub/x86-stub.c        |  30 +---
 include/linux/efi.h                            |  15 ++
 24 files changed, 492 insertions(+), 441 deletions(-)

-- 
2.35.1

