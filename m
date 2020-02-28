Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4BA11736F4
	for <lists+linux-efi@lfdr.de>; Fri, 28 Feb 2020 13:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgB1MOO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Feb 2020 07:14:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:45214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbgB1MOO (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Feb 2020 07:14:14 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 972682087F;
        Fri, 28 Feb 2020 12:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582892054;
        bh=OXTWApyngKLjZ0TZy/1RIFY4CBj24eE6zYDN66Iyua0=;
        h=From:To:Cc:Subject:Date:From;
        b=EsI4LRThbyAgJxLZTxN0VEQ4dPdF1pcgIakZxLfNgFEN+UkadTVBJlDHq2bfUheSz
         ctdjN11ON8hk0kP/LYZbbjs6Bis3fWKtdTYWo1Yh4fiD+0tURWpfQM6R9HlQJP+030
         AAe8srp3C1ZO6cCH//LQQtDvhsS2tsOWtVGRYKVQ=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [GIT PULL 0/6] More EFI updates for v5.7
Date:   Fri, 28 Feb 2020 13:14:02 +0100
Message-Id: <20200228121408.9075-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Ingo, Thomas,

A small set of EFI followup changes for v5.7. The last one fixes a boot
regression in linux-next on x86 machines booting without EFI but with
the IMA security subsystem enabled, which is why I am sending out the
next batch a bit earlier than intended.

Thanks,
Ard.


The following changes since commit e9765680a31b22ca6703936c000ce5cc46192e10:

  Merge tag 'efi-next' of git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi into efi/core (2020-02-26 15:21:22 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next

for you to fetch changes up to be15278269343ec0e4d0e41bab5f64b49b0edb6b:

  efi: mark all EFI runtime services as unsupported on non-EFI boot (2020-02-28 12:54:46 +0100)

----------------------------------------------------------------
More EFI updates for v5.7

A couple of followup fixes for the EFI changes queued for v5.7:
- a fix for a boot regression on x86 booting without UEFI
- memory encryption fixes for x86, so that the TPM tables and the RNG
  config table created by the stub are correctly identified as living
  in unencrypted memory
- style tweak from Heinrich
- followup to the ARM EFI entry code simplifications to ensure that we
  don't rely on EFI_LOADER_DATA memory being RWX

----------------------------------------------------------------
Ard Biesheuvel (3):
      efi/arm: clean EFI stub exit code from cache instead of avoiding it
      efi/arm64: clean EFI stub exit code from cache instead of avoiding it
      efi: mark all EFI runtime services as unsupported on non-EFI boot

Heinrich Schuchardt (1):
      efi: don't shadow i in efi_config_parse_tables()

Tom Lendacky (2):
      efi/x86: Add TPM related EFI tables to unencrypted mapping checks
      efi/x86: Add RNG seed EFI table to unencrypted mapping check

 arch/arm/boot/compressed/head.S | 18 ++++++++----------
 arch/arm64/kernel/efi-entry.S   | 26 +++++++++++++-------------
 arch/arm64/kernel/image-vars.h  |  4 ++--
 arch/x86/platform/efi/efi.c     |  3 +++
 drivers/firmware/efi/efi.c      | 25 +++++++++++++------------
 include/linux/efi.h             |  2 ++
 6 files changed, 41 insertions(+), 37 deletions(-)
