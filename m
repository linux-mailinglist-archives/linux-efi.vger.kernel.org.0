Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E301D27D5B2
	for <lists+linux-efi@lfdr.de>; Tue, 29 Sep 2020 20:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgI2SYN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 29 Sep 2020 14:24:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727605AbgI2SYL (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 29 Sep 2020 14:24:11 -0400
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7671E208B8;
        Tue, 29 Sep 2020 18:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601403850;
        bh=6lduulYFraRHs/1LQJ/Vl3zGXyqQMTPuf2V084eAFm8=;
        h=From:To:Cc:Subject:Date:From;
        b=u832ybqpug0O15ld/h4ZEGhP7r0hSmzAxy2bcF1Pm3d8jiy4EjD8YCjA7LtUlyMMU
         OBolKLc36ik7e65xmwTBZUPOMOE2KYEM/tTKiRxeKpDzJduTx6rFwPeK6LIMNZ7t3H
         jcwqv8Ga9VbboubNG1QIpuSoKVfguxYN1yRo2goI=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     ardb@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] More EFI changes for v5.10
Date:   Tue, 29 Sep 2020 20:24:05 +0200
Message-Id: <20200929182405.31809-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following changes since commit 612b5d506d066cdf0a739963e7cd28642d500ec1:

  cper,edac,efi: Memory Error Record: bank group/address and chip id (2020-09-17 10:19:52 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v5.10-2

for you to fetch changes up to 963fabf37f6a94214a823df0a785e653cb8ad6ea:

  efi: efivars: limit availability to X86 builds (2020-09-29 19:40:57 +0200)

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>

----------------------------------------------------------------
Second batch of EFI updates for v5.10:
- followup fix for the new MOKvar table code
- split efi-pstore from the deprecated efivars sysfs code, so we can
  disable the latter on !x86

----------------------------------------------------------------
Ard Biesheuvel (7):
      efi: mokvar-table: fix some issues in new code
      efi: pstore: disentangle from deprecated efivars module
      efi: pstore: move workqueue handling out of efivars
      efi: efivars: un-export efivars_sysfs_init()
      efi: gsmi: fix false dependency on CONFIG_EFI_VARS
      efi: remove some false dependencies on CONFIG_EFI_VARS
      efi: efivars: limit availability to X86 builds

 Documentation/arm/uefi.rst          |  2 +-
 drivers/firmware/efi/Kconfig        | 18 +++-----
 drivers/firmware/efi/efi-pstore.c   | 83 ++++++++++++++++++++++++++++++++++---
 drivers/firmware/efi/efivars.c      | 45 +-------------------
 drivers/firmware/efi/mokvar-table.c | 25 +++++------
 drivers/firmware/efi/vars.c         | 21 ----------
 drivers/firmware/google/Kconfig     |  2 +-
 drivers/firmware/google/gsmi.c      |  8 ++--
 include/linux/efi.h                 | 11 -----
 9 files changed, 102 insertions(+), 113 deletions(-)
