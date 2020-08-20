Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF5B24C050
	for <lists+linux-efi@lfdr.de>; Thu, 20 Aug 2020 16:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgHTNxV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Aug 2020 09:53:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:59916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbgHTJYH (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 20 Aug 2020 05:24:07 -0400
Received: from localhost.localdomain (81-205-208-142.fixed.kpn.net [81.205.208.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8E8722CE3;
        Thu, 20 Aug 2020 09:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915446;
        bh=3jXYh42rZiK+7elW9NbjbJFsDtt0q3XFGg/85myzKOU=;
        h=From:To:Cc:Subject:Date:From;
        b=zHT4Xnlc7Y6NEoI8Hg8C9IaTVMqe4mHaPdyIt7MHIlpGwSGdvLj43l/QnZ0JXtmff
         y1GvDcOtpz4PYjm0eJmetPpag/NBA3RHJimGSjFAAUnRVGRnEsQao/T3Ys1hJF/asI
         x3sTtDYUelC1aThaBGvPYwNFlMxY0ae7f+1n7vv4=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] EFI fixes for v5.9-rc1
Date:   Thu, 20 Aug 2020 11:23:30 +0200
Message-Id: <20200820092330.18120-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v5.9-rc1

for you to fetch changes up to fb1201aececc59990b75ef59fca93ae4aa1e1444:

  Documentation: efi: remove description of efi=old_map (2020-08-20 11:18:36 +0200)

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>

----------------------------------------------------------------
EFI fixes for v5.9-rc1:
- Some followup fixes for the UV1 and EFI old_map removal
- EFI stub command line fixes from Arvind
- Stop mapping the kernel's .rodata executable in the mixed mode EFI page tables
- Add missing cleanup on the efisubsys_init() error path

----------------------------------------------------------------
Ard Biesheuvel (2):
      efi/x86: Move 32-bit code into efi_32.c
      Documentation: efi: remove description of efi=old_map

Arvind Sankar (4):
      efi/x86: Mark kernel rodata non-executable for mixed mode
      efi/libstub: Stop parsing arguments at "--"
      efi/libstub: Handle NULL cmdline
      efi/libstub: Handle unterminated cmdline

Li Heng (1):
      efi: add missed destroy_workqueue when efisubsys_init fails

 Documentation/admin-guide/kernel-parameters.txt |  5 +-
 arch/x86/include/asm/efi.h                      | 10 ----
 arch/x86/platform/efi/efi.c                     | 69 -------------------------
 arch/x86/platform/efi/efi_32.c                  | 44 +++++++++++++---
 arch/x86/platform/efi/efi_64.c                  |  2 +
 drivers/firmware/efi/efi.c                      |  2 +
 drivers/firmware/efi/libstub/efi-stub-helper.c  | 12 ++++-
 7 files changed, 52 insertions(+), 92 deletions(-)
