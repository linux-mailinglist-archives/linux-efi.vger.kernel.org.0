Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35CA30590A
	for <lists+linux-efi@lfdr.de>; Wed, 27 Jan 2021 12:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236243AbhA0K7M (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 27 Jan 2021 05:59:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:56044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236193AbhA0K4w (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 27 Jan 2021 05:56:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11DE02076E;
        Wed, 27 Jan 2021 10:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611744970;
        bh=5DebxzWfu5gdy0+dY/mNz5BUARY7uWkGBXTj5WJORF4=;
        h=From:To:Cc:Subject:Date:From;
        b=bKg/eZhKlWJEjW7u3x/0QZcGplbg53ogzh+2KGTekF4xS4NVzuZjZvbnVLJjnEpyZ
         50cDdV2c903h7P/EP9R5Jxqob5o/1uhFb70mvE+tKn+X5dZQ04Sy6rUjvML6HQczJC
         7jaM7Oao9XKuz4j96HeCGqaF2S3LXpf7bQFtkFUw4JSWwVH6UPOs3Jjmk2/OkpO5aJ
         FYkkX6/CCijNWZsjils/KBP4jjwgQaQVhFzB68BWeoKRaBW8EuahcrH8XMG0425qFO
         eNXkQoTA/4DMDDn6CE1EzqGZXLeylook+IZHf1+YxwtXuPxov9DP5ZVGXQWMc8OEIC
         KNBNtYl/o3ciw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     ardb@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] EFI changes for v5.12
Date:   Wed, 27 Jan 2021 11:56:04 +0100
Message-Id: <20210127105604.37790-1-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v5.12

for you to fetch changes up to 1c761ee9da1ac6ba7e40d14457fac94c87eaff35:

  efi/arm64: Update debug prints to reflect other entropy sources (2021-01-21 10:54:08 +0100)

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>

----------------------------------------------------------------
EFI updates for v5.12

A few cleanups left and right, some of which were part of a initrd
measured boot series that needs some more work, and so only the cleanup
patches have been included for this release.

----------------------------------------------------------------
Ard Biesheuvel (6):
      efi: ia64: move IA64-only declarations to new asm/efi.h header
      efi/libstub: whitespace cleanup
      efi/libstub: fix prototype of efi_tcg2_protocol::get_event_log()
      efi/libstub: move TPM related prototypes into efistub.h
      efi: x86: move mixed mode stack PA variable out of 'efi_scratch'
      efi: x86: clean up previous struct mm switching

Mark Brown (1):
      efi/arm64: Update debug prints to reflect other entropy sources

 arch/ia64/include/asm/efi.h               | 13 +++++++++++++
 arch/ia64/kernel/efi.c                    |  1 +
 arch/ia64/kernel/machine_kexec.c          |  1 +
 arch/ia64/kernel/mca.c                    |  1 +
 arch/ia64/kernel/smpboot.c                |  1 +
 arch/ia64/kernel/time.c                   |  1 +
 arch/ia64/kernel/uncached.c               |  4 +---
 arch/ia64/mm/contig.c                     |  1 +
 arch/ia64/mm/discontig.c                  |  1 +
 arch/ia64/mm/init.c                       |  1 +
 arch/x86/include/asm/efi.h                | 20 ++++++--------------
 arch/x86/platform/efi/efi_64.c            | 29 ++++++++++++++++-------------
 arch/x86/platform/efi/efi_thunk_64.S      |  6 +++++-
 drivers/firmware/efi/libstub/arm64-stub.c |  4 ++--
 drivers/firmware/efi/libstub/efistub.h    | 11 ++++++++++-
 include/linux/efi.h                       | 19 ++-----------------
 16 files changed, 63 insertions(+), 51 deletions(-)
 create mode 100644 arch/ia64/include/asm/efi.h
