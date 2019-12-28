Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2525212BDE4
	for <lists+linux-efi@lfdr.de>; Sat, 28 Dec 2019 16:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfL1PVw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 28 Dec 2019 10:21:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:32832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfL1PVw (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 28 Dec 2019 10:21:52 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CB7220838;
        Sat, 28 Dec 2019 15:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577546511;
        bh=lwiPF3FtYuk+RVnAw6BOk/1MZscA7P94m3At2N2iUA8=;
        h=From:To:Cc:Subject:Date:From;
        b=ZG3kH65HFvruTRGnsq7KmiJ0zJOBOMx13geZ0Ihybj3vCo5NOdKlnebJ9jBNGbcfO
         rpJXTZcteHggUB7gMCTZOvzOQd+UIz6U/1p3Obj+uBD9MkeCR1qVOX2LbA80w+ZRuM
         yUmRRkxSS/ENiwhnlTXdLbN1H9KubdUCFs7MthjU=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/7] efi: more fixes and general cleanups for v5.6
Date:   Sat, 28 Dec 2019 16:21:02 +0100
Message-Id: <20191228152109.6301-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In addition to two other series that are in flight, regarding the EFI
runtime call assembly wrappers [0], and the use of restricted memory
permissions for mapping EFI runtime service memory regions [1], here's
another batch of fixes and cleanups for the early EFI code.

Patches #1 .. #3 are fixes for the code that is currently queued in
tip/efi/core.

Patch #4 fixes an ancient issue in the EFI boot code where it doesn't
map the memory containing the EFI vendor name string correctly.

Patch #5 redefines the macro __efiapi to __attribute__((regparm(0)))
on 32-bit x86 so we no longer have to cast every function pointer
that requires that annotation.

Patch #6 refactors efi_runtime_init() so we no longer have two mostly
identical copies of the same code for 32-bit and 64-bit.

Patch #7 cleans up efi_systab_init() and also gets rid of the 'efi_phys'
data structure that exists for no good reason.

Branch can be found here:
https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-more-cleanup-for-v5.6

[0] https://lore.kernel.org/linux-efi/20191226151407.29716-1-ardb@kernel.org/
[1] https://lore.kernel.org/linux-efi/20191227163418.16139-1-ardb@kernel.org/

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arvind Sankar <nivedita@alum.mit.edu>
Cc: Hans de Goede <hdegoede@redhat.com>

Ard Biesheuvel (7):
  efi/libstub: fix boot argument handling in mixed mode entry code
  efi/libstub: use correct system table pointer in mixed mode efi_free()
  efi/x86: re-disable RT services for 32-bit kernels running on 64-bit
    EFI
  efi/x86: map the entire EFI vendor string before copying it
  efi/x86: avoid redundant cast of EFI firmware service pointer
  efi/x86: merge two near identical versions of efi_runtime_init()
  efi/x86: clean up efi_systab_init() routine for legibility

 arch/x86/boot/compressed/eboot.c   |   3 +-
 arch/x86/boot/compressed/head_64.S |  17 +-
 arch/x86/include/asm/efi.h         |  25 +-
 arch/x86/platform/efi/efi.c        | 262 +++++++++-----------
 arch/x86/platform/efi/efi_64.c     |   5 +
 include/linux/efi.h                |  23 +-
 6 files changed, 135 insertions(+), 200 deletions(-)

-- 
2.17.1

