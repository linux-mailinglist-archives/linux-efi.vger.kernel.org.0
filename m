Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5AE38DA93
	for <lists+linux-efi@lfdr.de>; Sun, 23 May 2021 11:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbhEWJFo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 23 May 2021 05:05:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231636AbhEWJFn (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 23 May 2021 05:05:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AEFA961151;
        Sun, 23 May 2021 09:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621760657;
        bh=k/5+WR11A7lFmmLmWj6+1f6l8hJoblmWQDq4UYZs7CQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Pfu1AdBU/KyvseRqwO6SAG4qcLfL1L9VfwxPzHdjr+Ql4/TQritUQi2eBRqjQ8q5f
         Slq45eP5kJ3FMK8l6psFRGgvI07vomyar1hXVUSjpa39lYVp7tx2qwD3kjzSTSzTpz
         5G5UBjplE9LGGSLLId3Fp88H8cAH9q8huqwV5AmvlOWbWkYCOCsPxSQEEg4e27nwo5
         vcsVlnuPfaz1Z7JyK4iiX0hxhNHI3YObiBXO49u6DwddhGYkN5vS1rZpWN69Txy2tq
         aUuPnYt20eMMDD3rCvSpKtMnP3aZU0FmmeN0DbaVI0eSyEjBukQ8MshTHRrCGyAA5D
         NcHnR5yA0veYw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] EFI fixes for v5.13-rc
Date:   Sun, 23 May 2021 11:04:12 +0200
Message-Id: <20210523090413.70225-1-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v5.13-rc2

for you to fetch changes up to 942859d969de7f6f7f2659a79237a758b42782da:

  efi: cper: fix snprintf() use in cper_dimm_err_location() (2021-05-22 14:05:37 +0200)

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>

----------------------------------------------------------------
EFI fixes for v5.13-rc

A handful of low urgency EFI fixes accumulated over the past couple of
months.

----------------------------------------------------------------
Changbin Du (1):
      efi/fdt: fix panic when no valid fdt found

Dan Carpenter (1):
      efi/libstub: prevent read overflow in find_file_option()

Heiner Kallweit (1):
      efi: Allow EFI_MEMORY_XP and EFI_MEMORY_RO both to be cleared

Rasmus Villemoes (1):
      efi: cper: fix snprintf() use in cper_dimm_err_location()

 drivers/firmware/efi/cper.c         | 4 +---
 drivers/firmware/efi/fdtparams.c    | 3 +++
 drivers/firmware/efi/libstub/file.c | 2 +-
 drivers/firmware/efi/memattr.c      | 5 -----
 4 files changed, 5 insertions(+), 9 deletions(-)
