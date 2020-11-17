Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E792B6732
	for <lists+linux-efi@lfdr.de>; Tue, 17 Nov 2020 15:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgKQOO5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Nov 2020 09:14:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:52016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbgKQOO4 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 17 Nov 2020 09:14:56 -0500
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9043221E2;
        Tue, 17 Nov 2020 14:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605622495;
        bh=JHKDFdVAM65VQv1M5oyNpRamQODWBhBgrKxGPnOefZM=;
        h=From:To:Cc:Subject:Date:From;
        b=KIS2keMc81ZmypyKhmKTl+VbR7ySN3HOgF+Lqa089fn16HpEVv1hV2f3qWRDm9jFY
         ljaEy3B0bzbmEi5D3p2N305Ly7T5xiwLXa80cOrHyO+qi+smXudzaIU5wgw+uhe3Uc
         Ce4uqlLJxUGyhTc5oiXmHHOEs7T94Ui5nG0ZEJUk=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     ardb@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] EFI updates for v5.11
Date:   Tue, 17 Nov 2020 15:14:49 +0100
Message-Id: <20201117141449.32674-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git efi-next-for-v5.11

for you to fetch changes up to b283477d394ac41ca59ee20eb9293ae9002eb1d7:

  efi: x86/xen: switch to efi_get_secureboot_mode helper (2020-11-17 15:09:32 +0100)

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>

----------------------------------------------------------------
EFI updates for v5.11:
- don't move BSS section around pointlessly (x86 decompressor)
- refactor helper for discovering the EFI secure boot mode
- wire up EFI secure boot to IMA for arm64

----------------------------------------------------------------
Ard Biesheuvel (1):
      efi: x86/xen: switch to efi_get_secureboot_mode helper

Arvind Sankar (1):
      efi/x86: Only copy the compressed kernel image in efi_relocate_kernel()

Chester Lin (3):
      efi: generalize efi_get_secureboot
      ima: generalize x86/EFI arch glue for other EFI architectures
      arm64/ima: add ima_arch support

Geert Uytterhoeven (1):
      efi/libstub: EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER should not default to yes

Heinrich Schuchardt (1):
      efi/libstub/x86: simplify efi_is_native()

 arch/arm64/Kconfig                                 |  1 +
 arch/x86/boot/compressed/Makefile                  |  2 +-
 arch/x86/include/asm/efi.h                         |  5 ++-
 arch/x86/kernel/Makefile                           |  2 -
 arch/x86/xen/efi.c                                 | 37 +++++-------------
 drivers/firmware/efi/Kconfig                       |  2 +-
 drivers/firmware/efi/libstub/efistub.h             |  2 +
 drivers/firmware/efi/libstub/secureboot.c          | 44 ++++++++-------------
 drivers/firmware/efi/libstub/x86-stub.c            |  5 ++-
 include/linux/efi.h                                | 23 ++++++++++-
 security/integrity/ima/Makefile                    |  4 ++
 .../ima_arch.c => security/integrity/ima/ima_efi.c | 45 ++++++----------------
 12 files changed, 74 insertions(+), 98 deletions(-)
 rename arch/x86/kernel/ima_arch.c => security/integrity/ima/ima_efi.c (60%)
