Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA8212D31C
	for <lists+linux-efi@lfdr.de>; Mon, 30 Dec 2019 19:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfL3SJW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 30 Dec 2019 13:09:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:37822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727318AbfL3SJW (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 30 Dec 2019 13:09:22 -0500
Received: from localhost.localdomain (91-167-84-221.subs.proxad.net [91.167.84.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 686CF206DB;
        Mon, 30 Dec 2019 18:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577729361;
        bh=fYP17rIYM9LAyvB4xxNgg4HCwtvh8TVBiZStXGg0g+Y=;
        h=From:To:Cc:Subject:Date:From;
        b=ldO9w6IOCDRvR0VBXlQd8UFkuPJpy40McKk08p5Z6PeG87PJDlrBsf6MKOVoFVI1i
         M+5lgwTPd557I/Vz8DVm40UarU2WA/D8GSDG1RbxLTIRFQ3kA396AmY2o+GH7NtdJV
         vdaeYrTCXnQ6YC71fL9Jg1fZZ57KbfZMX8bae0Yo=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 00/14] efi: more fixes and general cleanups for v5.6
Date:   Mon, 30 Dec 2019 19:08:20 +0100
Message-Id: <20191230180834.75601-1-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This is a combined v2 followup to the v1s of

efi: more fixes and general cleanups for v5.6 [0]
efi/x86: clean up and simplify runtime call wrappers [1]

sent out last week. I have some other changes pending regarding the
mapping of EFI runtime memory with restricted permissions [2], but
I will get back to those after finishing up with the changes below.

Changes since v1:
- Fix logic in #3 for running 64-bit kernels on 32-bit firmware when mixed
  mode support is not compiled in. In this case, we can still boot but we
  will not have access to runtime services.
- Refactor the C wrappers involved in calling SetVirtualAddressMap, which
  were kludgy and hard to follow (#6, #7)
- Incorporate review feedback from Arvind and Andy regarding the asm
  wrappers (#8, #9, #10), and simplify them a bit further,
- Drop efi_runtime_init32/64 entirely since they turned out to be
  unnecessary. (#11)
- Add another pair of cleanup patches for the runtime services code (#13, #14)

Branch can be found here:
https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-more-cleanup-for-v5.6-v2

[0] https://lore.kernel.org/linux-efi/20191228152109.6301-1-ardb@kernel.org/
[1] https://lore.kernel.org/linux-efi/20191226151407.29716-1-ardb@kernel.org/
[2] https://lore.kernel.org/linux-efi/20191227163418.16139-1-ardb@kernel.org/

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arvind Sankar <nivedita@alum.mit.edu>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>

Ard Biesheuvel (14):
  efi/libstub: fix boot argument handling in mixed mode entry code
  efi/libstub: use correct system table pointer in mixed mode efi_free()
  efi/x86: re-disable RT services for 32-bit kernels running on 64-bit
    EFI
  efi/x86: map the entire EFI vendor string before copying it
  efi/x86: avoid redundant cast of EFI firmware service pointer
  efi/x86: split off some old memmap handling into separate routines
  efi/x86: split SetVirtualAddresMap() wrappers into 32 and 64 bit
    versions
  efi/x86: simplify i386 efi_call_phys() firmware call wrapper
  efi/x86: simplify 64-bit EFI firmware call wrapper
  efi/x86: simplify mixed mode call wrapper
  efi/x86: drop two near identical versions of efi_runtime_init()
  efi/x86: clean up efi_systab_init() routine for legibility
  efi/x86: don't panic or BUG() on non-critical error conditions
  efi/x86: remove unreachable code in kexec_enter_virtual_mode()

 arch/x86/boot/compressed/eboot.c     |   3 +-
 arch/x86/boot/compressed/head_64.S   |  17 +-
 arch/x86/include/asm/efi.h           |  43 +--
 arch/x86/platform/efi/Makefile       |   1 -
 arch/x86/platform/efi/efi.c          | 354 +++++++-------------
 arch/x86/platform/efi/efi_32.c       |  22 +-
 arch/x86/platform/efi/efi_64.c       | 129 ++++---
 arch/x86/platform/efi/efi_stub_32.S  | 109 +-----
 arch/x86/platform/efi/efi_stub_64.S  |  39 +--
 arch/x86/platform/efi/efi_thunk_64.S | 121 ++-----
 arch/x86/platform/uv/bios_uv.c       |   7 +-
 include/linux/efi.h                  |  23 +-
 12 files changed, 288 insertions(+), 580 deletions(-)

-- 
2.20.1

