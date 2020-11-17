Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7CA2B6730
	for <lists+linux-efi@lfdr.de>; Tue, 17 Nov 2020 15:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgKQOOu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Nov 2020 09:14:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:51906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbgKQOOt (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 17 Nov 2020 09:14:49 -0500
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7832920825;
        Tue, 17 Nov 2020 14:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605622489;
        bh=K5Ghttn9pPzQG/8PGLLlOvCWSs/uXX78C3SmGH7R21Q=;
        h=From:To:Cc:Subject:Date:From;
        b=QfV67aMCI/9vlw7VgKOG1RHNjBtrl4h8f6e7qokyknZtJ4vP2BARVEsKKqSA20Ojk
         42nLdPOEC2KgDILjhj880eB80ja0kpGz6vBTWFFS7d6EflfCb7HE2H88h4z9nMV1oS
         Aj25zEQdwZULRxAwjOkoUp17HXtMeB8H75KA72zk=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     ardb@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] EFI fixes for v5.10-rc
Date:   Tue, 17 Nov 2020 15:14:37 +0100
Message-Id: <20201117141437.32613-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v5.10-rc3

for you to fetch changes up to c2fe61d8be491ff8188edaf22e838f819999146b:

  efi/x86: Free efi_pgd with free_pages() (2020-11-10 19:18:11 +0100)

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>

----------------------------------------------------------------
Couple of EFI fixes for v5.10:
- fix memory leak in efivarfs driver
- fix HYP mode issue in 32-bit ARM version of the EFI stub when built in
  Thumb2 mode
- avoid leaking EFI pgd pages on allocation failure

----------------------------------------------------------------
Ard Biesheuvel (1):
      efi/arm: set HSCTLR Thumb2 bit correctly for HVC calls from HYP

Arvind Sankar (1):
      efi/x86: Free efi_pgd with free_pages()

Vamshi K Sthambamkadi (1):
      efivarfs: fix memory leak in efivarfs_create()

 arch/arm/boot/compressed/head.S |  3 +++
 arch/x86/platform/efi/efi_64.c  | 24 +++++++++++++-----------
 fs/efivarfs/super.c             |  1 +
 3 files changed, 17 insertions(+), 11 deletions(-)
