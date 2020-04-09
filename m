Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4641A3483
	for <lists+linux-efi@lfdr.de>; Thu,  9 Apr 2020 15:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgDINEz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Apr 2020 09:04:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbgDINEy (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 9 Apr 2020 09:04:54 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94BA92082D;
        Thu,  9 Apr 2020 13:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586437495;
        bh=p5ntWWkMKxdy8i4k3Qc1Hwi8VIJz5rcSTUP6kwqvsOs=;
        h=From:To:Cc:Subject:Date:From;
        b=NLQuZvobiDcu4GyFzC8Ou9at5pwBndLoho/o3dkRyxOEKr+cLMvjrm1c+g2MoYaZI
         nD137xB667FRI3ZuqSwBgKXcZlqxvuaCRQY62FamjY3V0rPyuGRkyacUhGeotBrYL4
         dFAW8hXtqdcba4iMB7lX1KWnWLPvIqYWngEw+R2U=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>,
        Colin Ian King <colin.king@canonical.com>,
        Gary Lin <glin@suse.com>, Jiri Slaby <jslaby@suse.cz>,
        Sergey Shatunov <me@prok.pw>, Takashi Iwai <tiwai@suse.de>
Subject: [GIT PULL 0/9] EFI fixes for v5.7-rc
Date:   Thu,  9 Apr 2020 15:04:25 +0200
Message-Id: <20200409130434.6736-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following changes since commit 594e576d4b93b8cda3247542366b47e1b2ddc4dc:

  efi/libstub/arm: Fix spurious message that an initrd was loaded (2020-03-29 12:08:18 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent

for you to fetch changes up to 55a3cad6df4bff67280c4722ceb2a5ff4375eff9:

  efi/x86: Don't remap text<->rodata gap read-only for mixed mode (2020-04-09 14:50:21 +0200)

----------------------------------------------------------------
EFI fixes for v5.7-rcX:
- a couple of mixed mode fixes for the changes made in v5.6
- a couple of fixes from Arvind to deal with buggy firmware that does not
  load the PE/COFF kernel image based on the description in the PE/COFF
  header, but simply copies it to memory
- add a clarification to the x86 boot protocol documentation regarding the
  previous issue
- reduce the stack footprint of the new file I/O code, to suppress a
  compiler warning
- use the right sprintf() flavor in the CPER code to prevent a potential
  out of bounds write
- prevent a symbol reference from going out of range in the ARM startup code
- cosmetic fix for an issue reported by Coverity

----------------------------------------------------------------
Ard Biesheuvel (4):
      efi/arm: Deal with ADR going out of range in efi_enter_kernel()
      Documentation: efi/x86: clarify EFI handover protocol and its requirements
      efi/libstub/file: merge filename buffers to reduce stack usage
      efi/x86: Don't remap text<->rodata gap read-only for mixed mode

Arvind Sankar (2):
      efi/x86: Move efi stub globals from .bss to .data
      efi/x86: Always relocate the kernel for EFI handover entry

Colin Ian King (1):
      efi/libstub/x86: remove redundant assignment to pointer hdr

Gary Lin (1):
      efi/x86: Fix the deletion of variables in mixed mode

Takashi Iwai (1):
      efi/cper: Use scnprintf() for avoiding potential buffer overflow

 Documentation/x86/boot.rst              | 21 ++++++++++++++++++---
 arch/arm/boot/compressed/head.S         |  3 ++-
 arch/x86/platform/efi/efi_64.c          | 16 ++++++++++++----
 drivers/firmware/efi/cper.c             |  2 +-
 drivers/firmware/efi/libstub/efistub.h  |  2 +-
 drivers/firmware/efi/libstub/file.c     | 27 ++++++++++++++-------------
 drivers/firmware/efi/libstub/x86-stub.c | 18 +++++++++++-------
 7 files changed, 59 insertions(+), 30 deletions(-)
