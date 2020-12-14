Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008FB2D93D3
	for <lists+linux-efi@lfdr.de>; Mon, 14 Dec 2020 09:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439073AbgLNIM4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Dec 2020 03:12:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:37456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439060AbgLNIMv (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 14 Dec 2020 03:12:51 -0500
From:   Ard Biesheuvel <ardb@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-efi@vger.kernel.org
Cc:     ardb@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] EFI updates for v5.11 (followup fixes)
Date:   Mon, 14 Dec 2020 09:12:00 +0100
Message-Id: <20201214081200.29720-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following changes since commit 54649911f31b6e7c2a79a1426ca98259139e4c35:

  efi: stub: get rid of efi_get_max_fdt_addr() (2020-12-09 08:37:27 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v5.11-3

for you to fetch changes up to f232134eddf6f61fc0912fcaa73c4baaf7a4c2e4:

  efi: arm: force use of unsigned type for EFI_PHYS_ALIGN (2020-12-14 09:03:18 +0100)

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>

----------------------------------------------------------------
Followup fixes for EFI:
- fix the build breakage on IA64 caused by recent capsule loader changes
- suppress a type mismatch build warning in the expansion of
  EFI_PHYS_ALIGN on ARM

----------------------------------------------------------------
Ard Biesheuvel (2):
      efi: ia64: disable the capsule loader
      efi: arm: force use of unsigned type for EFI_PHYS_ALIGN

 arch/arm/include/asm/efi.h    | 2 +-
 drivers/firmware/efi/Kconfig  | 2 +-
 drivers/firmware/efi/Makefile | 5 ++++-
 include/linux/efi.h           | 4 ++++
 4 files changed, 10 insertions(+), 3 deletions(-)
