Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBA431B98D
	for <lists+linux-efi@lfdr.de>; Mon, 15 Feb 2021 13:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhBOMpJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Feb 2021 07:45:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:40960 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230307AbhBOMpF (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 15 Feb 2021 07:45:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C3C9FAC32;
        Mon, 15 Feb 2021 12:44:23 +0000 (UTC)
Date:   Mon, 15 Feb 2021 13:44:26 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, linux-efi <linux-efi@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EFI updates for v5.12
Message-ID: <20210215124426.GG7265@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Linus,

please pull the forwarded pile of EFI updates for v5.12.

Thx.

---

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/efi-next-for-v5.12

for you to fetch changes up to 1c761ee9da1ac6ba7e40d14457fac94c87eaff35:

  efi/arm64: Update debug prints to reflect other entropy sources (2021-01-21 10:54:08 +0100)

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

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
