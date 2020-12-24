Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075872E2596
	for <lists+linux-efi@lfdr.de>; Thu, 24 Dec 2020 10:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgLXJEs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Dec 2020 04:04:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:33382 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbgLXJEq (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 24 Dec 2020 04:04:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 20357ACC4;
        Thu, 24 Dec 2020 09:04:04 +0000 (UTC)
Date:   Thu, 24 Dec 2020 10:04:06 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] efi/core for v5.11
Message-ID: <20201224090406.GA6169@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Linus,

please pull the EFI updates for v5.11. They got delayed due to a last
minute ia64 build issue which got fixed in the meantime:

https://lkml.kernel.org/r/87o8iwdtbj.fsf@nanos.tec.linutronix.de

and now the lot is all clear.

Thx.

---

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/efi_updates_for_v5.11

for you to fetch changes up to 3dcb8b53cbd2cc5618863b19ef00f8ea82f27e83:

  Merge tag 'efi-next-for-v5.11-3' of git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi into efi/core (2020-12-15 12:14:38 +0100)

----------------------------------------------------------------
EFI updates collected by Ard Biesheuvel:

 - Don't move BSS section around pointlessly in the x86 decompressor
 - Refactor helper for discovering the EFI secure boot mode
 - Wire up EFI secure boot to IMA for arm64
 - Some fixes for the capsule loader
 - Expose the RT_PROP table via the EFI test module
 - Relax DT and kernel placement restrictions on ARM

+ followup fixes:

 - fix the build breakage on IA64 caused by recent capsule loader changes
 - suppress a type mismatch build warning in the expansion of
       EFI_PHYS_ALIGN on ARM

----------------------------------------------------------------
Ard Biesheuvel (7):
      efi: x86/xen: switch to efi_get_secureboot_mode helper
      efi: capsule: use atomic kmap for transient sglist mappings
      efi: capsule: clean scatter-gather entries from the D-cache
      efi: arm: reduce minimum alignment of uncompressed kernel
      efi: stub: get rid of efi_get_max_fdt_addr()
      efi: ia64: disable the capsule loader
      efi: arm: force use of unsigned type for EFI_PHYS_ALIGN

Arvind Sankar (1):
      efi/x86: Only copy the compressed kernel image in efi_relocate_kernel()

Chester Lin (3):
      efi: generalize efi_get_secureboot
      ima: generalize x86/EFI arch glue for other EFI architectures
      arm64/ima: add ima_arch support

Geert Uytterhoeven (1):
      efi/libstub: EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER should not default to yes

Heinrich Schuchardt (2):
      efi/libstub/x86: simplify efi_is_native()
      efi/efi_test: read RuntimeServicesSupported

Thomas Gleixner (1):
      Merge tag 'efi-next-for-v5.11-3' of git://git.kernel.org/.../efi/efi into efi/core

 arch/arm/include/asm/efi.h                         | 24 ++++++------
 arch/arm64/Kconfig                                 |  1 +
 arch/arm64/include/asm/efi.h                       | 11 +++---
 arch/riscv/include/asm/efi.h                       |  6 ---
 arch/x86/boot/compressed/Makefile                  |  2 +-
 arch/x86/include/asm/efi.h                         |  5 ++-
 arch/x86/kernel/Makefile                           |  2 -
 arch/x86/xen/efi.c                                 | 37 +++++-------------
 drivers/firmware/efi/Kconfig                       |  4 +-
 drivers/firmware/efi/Makefile                      |  5 ++-
 drivers/firmware/efi/capsule.c                     | 16 +++++++-
 drivers/firmware/efi/libstub/efi-stub.c            |  1 -
 drivers/firmware/efi/libstub/efistub.h             |  3 +-
 drivers/firmware/efi/libstub/fdt.c                 |  3 +-
 drivers/firmware/efi/libstub/secureboot.c          | 44 ++++++++-------------
 drivers/firmware/efi/libstub/x86-stub.c            |  5 ++-
 drivers/firmware/efi/test/efi_test.c               | 16 ++++++++
 drivers/firmware/efi/test/efi_test.h               |  3 ++
 include/linux/efi.h                                | 33 ++++++++++++----
 security/integrity/ima/Makefile                    |  4 ++
 .../ima_arch.c => security/integrity/ima/ima_efi.c | 45 ++++++----------------
 21 files changed, 133 insertions(+), 137 deletions(-)
 rename arch/x86/kernel/ima_arch.c => security/integrity/ima/ima_efi.c (60%)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
