Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A388E8E46
	for <lists+linux-efi@lfdr.de>; Tue, 29 Oct 2019 18:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfJ2RjC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 29 Oct 2019 13:39:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:52974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbfJ2RjC (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 29 Oct 2019 13:39:02 -0400
Received: from e123331-lin.home (lfbn-mar-1-643-104.w90-118.abo.wanadoo.fr [90.118.215.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4650920679;
        Tue, 29 Oct 2019 17:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572370741;
        bh=TZP5RGLTh46FKw2IHMHKaCfLhrDgBMwi+Av69vqWVBI=;
        h=From:To:Cc:Subject:Date:From;
        b=xI/+BecBR5HnXNvy8BbJdxAEdOyoAxaUe6muUdJJM9yVStcxohIbweKxu1OlpumIl
         pyquMZCS2cdeQViNLLKqF5YTPMZm8x1fgKVykCXm2uXesKHHH0UsHy3yex+NsYlBuL
         rgzZ/rypjQ2EmSB39WLO8+mRVsRy0kWA1u7UmXuM=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Chester Lin <clin@suse.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guillaume Gardet <Guillaume.Gardet@arm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Kairui Song <kasong@redhat.com>,
        Laszlo Ersek <lersek@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Narendra K <Narendra.K@dell.com>
Subject: [GIT PULL v2 0/6] EFI fixes for v5.4
Date:   Tue, 29 Oct 2019 18:37:49 +0100
Message-Id: <20191029173755.27149-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Ingo, Thomas,

The v1 of this pull request/series was sent out last Wednesday, and
appears to have slipped through the cracks. This is actually for the
better, given that I had overlooked a patch that I had queued in the
wrong place, so I have included it now for this v2.

Thanks,
Ard.


The following changes since commit 7d194c2100ad2a6dded545887d02754948ca5241:

  Linux 5.4-rc4 (2019-10-20 15:56:22 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent

for you to fetch changes up to 8a1022da89857a21556eb04f53d281eda94ef02d:

  efi/efi_test: lock down /dev/efi_test and require CAP_SYS_ADMIN (2019-10-29 10:30:18 +0100)

----------------------------------------------------------------
Some more fixes for the EFI subsystem:
- Prevent boot problems on HyperV due to incorrect placement of the kernel
- Classify UEFI randomness as bootloader randomness
- Fix EFI boot for the Raspberry Pi2 running U-boot
- A capability/lockdown fix for the efi_test module.
- Some more odd fixes.

----------------------------------------------------------------
Ard Biesheuvel (1):
      efi: libstub/arm: account for firmware reserved memory at the base of RAM

Dominik Brodowski (1):
      efi/random: treat EFI_RNG_PROTOCOL output as bootloader randomness

Javier Martinez Canillas (1):
      efi/efi_test: lock down /dev/efi_test and require CAP_SYS_ADMIN

Jerry Snitselaar (1):
      efi/tpm: return -EINVAL when determining tpm final events log size fails

Kairui Song (1):
      x86, efi: never relocate kernel below lowest acceptable address

Narendra K (1):
      efi: Make CONFIG_EFI_RCI2_TABLE selectable on x86 only

 arch/x86/boot/compressed/eboot.c               |  4 +++-
 drivers/firmware/efi/Kconfig                   |  1 +
 drivers/firmware/efi/efi.c                     |  2 +-
 drivers/firmware/efi/libstub/Makefile          |  1 +
 drivers/firmware/efi/libstub/arm32-stub.c      | 16 +++++++++++++---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 24 ++++++++++--------------
 drivers/firmware/efi/test/efi_test.c           |  8 ++++++++
 drivers/firmware/efi/tpm.c                     |  1 +
 include/linux/efi.h                            | 18 ++++++++++++++++--
 include/linux/security.h                       |  1 +
 security/lockdown/lockdown.c                   |  1 +
 11 files changed, 56 insertions(+), 21 deletions(-)
