Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D292C607B
	for <lists+linux-efi@lfdr.de>; Fri, 27 Nov 2020 08:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392693AbgK0H2j (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Nov 2020 02:28:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:54556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392692AbgK0H2i (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 27 Nov 2020 02:28:38 -0500
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED39E21D93;
        Fri, 27 Nov 2020 07:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606462118;
        bh=XtR0O2o/rCj1e8TvQtAVZRKoQVhyWQyqr8d8rB2YESA=;
        h=From:To:Cc:Subject:Date:From;
        b=VLVpQSPIa5bT6A01tGxy6EXkuL54oGc2fHvs/Czfb96M0ElH99z76qZsskaShS54H
         sSJ/E/V969C9jVte87UAYmDxd92aD6x9rPUlK1crGWVrPbNQBSG0AU9188vMP8tLmD
         LIV2yiji41mUDVDWSb7QizTPgmAxWqRTH/3bbcjc=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     ardb@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] EFI fixes for v5.10-rc5
Date:   Fri, 27 Nov 2020 08:28:27 +0100
Message-Id: <20201127072827.18308-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Please pull the changes below. The efivarfs patch fixes a regression that
was introduced by a 'bug fix' last week, but this turned out to result in
double frees that trigger BUG()s when CONFIG_SLAB_FREELIST_HARDENED is
enabled.

The following changes since commit c2fe61d8be491ff8188edaf22e838f819999146b:

  efi/x86: Free efi_pgd with free_pages() (2020-11-10 19:18:11 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v5.10-rc5

for you to fetch changes up to 36a237526cd81ff4b6829e6ebd60921c6f976e3b:

  efi: EFI_EARLYCON should depend on EFI (2020-11-25 16:55:02 +0100)

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>

----------------------------------------------------------------
More EFI fixes for v5.10-rc:
- revert efivarfs kmemleak fix again - it was a false positive;
- make CONFIG_EFI_EARLYCON depend on CONFIG_EFI explicitly so it does not
  pull in other dependencies unnecessarily if CONFIG_EFI is not set
- defer attempts to load SSDT overrides from EFI vars until after the
  efivar layer is up.

----------------------------------------------------------------
Amadeusz Sławiński (1):
      efi/efivars: Set generic ops before loading SSDT

Ard Biesheuvel (1):
      efivarfs: revert "fix memory leak in efivarfs_create()"

Geert Uytterhoeven (1):
      efi: EFI_EARLYCON should depend on EFI

 drivers/firmware/efi/Kconfig | 2 +-
 drivers/firmware/efi/efi.c   | 2 +-
 fs/efivarfs/inode.c          | 2 ++
 fs/efivarfs/super.c          | 1 -
 4 files changed, 4 insertions(+), 3 deletions(-)
