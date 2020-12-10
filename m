Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46142D58EF
	for <lists+linux-efi@lfdr.de>; Thu, 10 Dec 2020 12:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbgLJLIc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 10 Dec 2020 06:08:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:34012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728919AbgLJLI3 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 10 Dec 2020 06:08:29 -0500
From:   Ard Biesheuvel <ardb@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-efi@vger.kernel.org
Cc:     ardb@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] More EFI changes for v5.11
Date:   Thu, 10 Dec 2020 12:07:21 +0100
Message-Id: <20201210110721.27954-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

NOTE: the patch 'efi: stub: get rid of efi_get_max_fdt_addr()' soft-depends
on a patch in the ARM tree that is already in -next. So if at all possible,
please send this to Linus towards the end of the merge window.

The following changes since commit b283477d394ac41ca59ee20eb9293ae9002eb1d7:

  efi: x86/xen: switch to efi_get_secureboot_mode helper (2020-11-17 15:09:32 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v5.11-2

for you to fetch changes up to 54649911f31b6e7c2a79a1426ca98259139e4c35:

  efi: stub: get rid of efi_get_max_fdt_addr() (2020-12-09 08:37:27 +0100)

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>

----------------------------------------------------------------
A few more EFI updates for v5.11:
- some fixes for the capsule loader
- expose the RT_PROP table via the efi_test module
- relax DT and kernel placement restrictions on ARM

----------------------------------------------------------------
Ard Biesheuvel (4):
      efi: capsule: use atomic kmap for transient sglist mappings
      efi: capsule: clean scatter-gather entries from the D-cache
      efi: arm: reduce minimum alignment of uncompressed kernel
      efi: stub: get rid of efi_get_max_fdt_addr()

Heinrich Schuchardt (1):
      efi/efi_test: read RuntimeServicesSupported

 arch/arm/include/asm/efi.h              | 24 +++++++++++-------------
 arch/arm64/include/asm/efi.h            | 11 +++++------
 arch/riscv/include/asm/efi.h            |  6 ------
 drivers/firmware/efi/capsule.c          | 16 ++++++++++++++--
 drivers/firmware/efi/libstub/efi-stub.c |  1 -
 drivers/firmware/efi/libstub/efistub.h  |  1 -
 drivers/firmware/efi/libstub/fdt.c      |  3 +--
 drivers/firmware/efi/test/efi_test.c    | 16 ++++++++++++++++
 drivers/firmware/efi/test/efi_test.h    |  3 +++
 9 files changed, 50 insertions(+), 31 deletions(-)
