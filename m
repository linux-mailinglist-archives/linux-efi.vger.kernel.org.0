Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C81B70B619
	for <lists+linux-efi@lfdr.de>; Mon, 22 May 2023 09:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjEVHPF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 22 May 2023 03:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbjEVHOh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 22 May 2023 03:14:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1563FDB;
        Mon, 22 May 2023 00:14:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 908D8611D8;
        Mon, 22 May 2023 07:14:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46544C433D2;
        Mon, 22 May 2023 07:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684739674;
        bh=CjSCvDWcQBxQkZsL21LxJVhDu4xITVayciFCwfaHC9Q=;
        h=From:To:Cc:Subject:Date:From;
        b=ZrWUNt+j/tYfHoD7I1yr1VjZ9ZoWzeQJ86QpXtgCcg5106JHsf1wmmg9dBfMOKy/L
         EEP84jrX/0VHwEtyr6MDmioPL0+8YNsbc2sE3jj17YE2ZoHGplOY3YW8queB/aVV5k
         o+1i7CeeINHa+GA4sySpgSlYWTNcJwMYWASQyoRgTxbt0Y+H2NLFnbauSag7FczEmI
         EDN6n4VNwLMDIIHbjAe+fdUofW6vXuTrx4qXOw9F1iEX7VT17Tj5YQJ6fgSxAILB2N
         WlrUGda6BOz0yPNi872TPcAHUMIEAkdezPcw8P/ixNiS9t6QOK7/5qi0knsZrkjuPe
         LoAGr0Hes4nBw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v3 00/21] efi/x86: Avoid bare metal decompressor during EFI boot
Date:   Mon, 22 May 2023 09:13:54 +0200
Message-Id: <20230522071415.501717-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7991; i=ardb@kernel.org; h=from:subject; bh=CjSCvDWcQBxQkZsL21LxJVhDu4xITVayciFCwfaHC9Q=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JISVbTPemslerNFPWvqW/Lk+tW65xWZjbrPLitMeTFxwyO iN3+ejDjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRJzMZ/grfPHl1zdzZR1SC irK/adq1XElty7Cw2aE0dd2RuJjdoRqMDL1yG0wmGB2KyE4OlT/jYnlPwfhQjpLlq8wzWTW54WZ /OQE=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Update the x86 boot path to avoid the bare metal decompressor when
booting via the EFI stub. The bare metal decompressor inherits the
loader's 1:1 mapping of DRAM when entering in 64-bit mode, and assumes
that all of it is mapped read/write/execute, which will no longer be the
case on systems built to comply with recently tightened logo
requirements (*).

Changes since v2 [4]:
- update prose style to comply with -tip guidelines
- rebased onto Kirill's unaccepted memory series [3]
- add Kirill's ack to 4/5-level paging changes
- perform SEV init and SNP feature check after ExitBootServices(), to
  avoid corrupting the firmware's own SEV state
- split out preparatory refactor of handover entry code and BSS clearing
  (patches #1 to #4)

Changes since v1 [2]:
- streamline existing 4/5 level switching code and call it directly from
  the EFI stub - this is covered by the first 9 patches, which can be
  applied in isolation, if desired;
- deal with SEV/SNP init explicitly;
- clear BSS when booting via the 'handover protocol'
- switch to kernel CS before calling SEV init code in kernel proper.

---- v1 cover letter follows ----

This series is conceptually a combination of Evgeny's series [0] and
mine [1], both of which attempt to make the early decompressor code more
amenable to executing in the EFI environment with stricter handling of
memory permissions.

My series [1] implemented zboot for x86, by getting rid of the entire
x86 decompressor, and replacing it with existing EFI code that does the
same but in a generic way. The downside of this is that only EFI boot is
supported, making it unviable for distros, which need to support BIOS
boot and hybrid EFI boot modes that omit the EFI stub.

Evgeny's series [0] adapted the entire decompressor code flow to allow
it to execute in the EFI context as well as the bare metal context, and
this involves changes to the 1:1 mapping code and the page fault
handlers etc, none of which are really needed when doing EFI boot in the
first place.

So this series attempts to occupy the middle ground here: it makes
minimal changes to the existing decompressor so some of it can be called
from the EFI stub. Then, it reimplements the EFI boot flow to decompress
the kernel and boot it directly, without relying on the trampoline
allocation code, page table code or page fault handling code. This
allows us to get rid of quite a bit of unsavory EFI stub code, and
replace it with two clear invocations of the EFI firmware APIs to clear
NX restrictions from allocations that have been populated with
executable code.

The only code that is being reused is the decompression library itself,
along with the minimal ELF parsing that is required to copy the ELF
segments in place, and the relocation processing that fixes up absolute
symbol references to refer to the correct virtual addresses.

Note that some of Evgeny's changes to clean up the PE/COFF header
generation will still be needed, but I've omitted those here for
brevity.

(*) IMHO the following developments are likely to occur:
- the Windows boot chain (along with 3rd party drivers) is cleaned up so
  that it never relies on memory being writable and executable at the
  same time when running under the EFI boot services;
- the EFI reference implementation gets updated to map all memory NX by
  default, and to require read-only permissions for executable mappings;
- BIOS vendors incorporate these changes into their codebases, and
  deploy it more widely than just the 'secure' SKUs;
- OEMs only care about the Windows sticker [5], so they only boot test
  Windows, which works fine in this more restricted context;
- Linux boot no longer works reliably on new hardware built for Windows
  unless we clean up our boot chain as well.

Cc: Evgeniy Baskov <baskov@ispras.ru>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Peter Jones <pjones@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>

[0] https://lore.kernel.org/all/cover.1678785672.git.baskov@ispras.ru/
[1] https://lore.kernel.org/all/20230416120729.2470762-1-ardb@kernel.org/
[2] https://lore.kernel.org/all/20230424165726.2245548-1-ardb@kernel.org/
[3] https://lore.kernel.org/all/20230518231434.26080-1-kirill.shutemov@linux.intel.com/
[4] https://lore.kernel.org/all/20230508070330.582131-1-ardb@kernel.org/
[5] https://techcommunity.microsoft.com/t5/hardware-dev-center/new-uefi-ca-memory-mitigation-requirements-for-signing/ba-p/3608714

Ard Biesheuvel (21):
  x86/efistub: Branch straight to kernel entry point from C code
  x86/efistub: Simplify and clean up handover entry code
  x86/decompressor: Avoid magic offsets for EFI handover entrypoint
  x86/efistub: Clear BSS in EFI handover protocol entrypoint
  x86/decompressor: Use proper sequence to take the address of the GOT
  x86/decompressor: Store boot_params pointer in callee save register
  x86/decompressor: Call trampoline as a normal function
  x86/decompressor: Use standard calling convention for trampoline
  x86/decompressor: Avoid the need for a stack in the 32-bit trampoline
  x86/decompressor: Call trampoline directly from C code
  x86/decompressor: Only call the trampoline when changing paging levels
  x86/decompressor: Merge trampoline cleanup with switching code
  x86/efistub: Perform 4/5 level paging switch from the stub
  x86/efistub: Prefer EFI memory attributes protocol over DXE services
  decompress: Use 8 byte alignment
  x86/decompressor: Move global symbol references to C code
  x86/decompressor: Factor out kernel decompression and relocation
  x86/head_64: Store boot_params pointer in callee-preserved register
  efi/libstub: Add limit argument to efi_random_alloc()
  x86/efistub: Check SEV/SNP support while running in the firmware
  x86/efistub: Avoid legacy decompressor when doing EFI boot

 Documentation/arch/x86/boot.rst                |   2 +-
 arch/x86/boot/compressed/Makefile              |   5 +
 arch/x86/boot/compressed/efi_mixed.S           | 107 +++-----
 arch/x86/boot/compressed/head_32.S             |  34 +--
 arch/x86/boot/compressed/head_64.S             | 219 ++++------------
 arch/x86/boot/compressed/misc.c                |  44 +++-
 arch/x86/boot/compressed/pgtable.h             |   6 +-
 arch/x86/boot/compressed/pgtable_64.c          |  72 +++---
 arch/x86/boot/compressed/sev.c                 |  19 +-
 arch/x86/include/asm/boot.h                    |   8 +
 arch/x86/include/asm/efi.h                     |   7 +-
 arch/x86/include/asm/sev.h                     |   6 +
 arch/x86/kernel/head_64.S                      |  15 +-
 drivers/firmware/efi/libstub/Makefile          |   1 +
 drivers/firmware/efi/libstub/arm64-stub.c      |   2 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c |   2 +
 drivers/firmware/efi/libstub/efistub.h         |   3 +-
 drivers/firmware/efi/libstub/randomalloc.c     |  10 +-
 drivers/firmware/efi/libstub/x86-5lvl.c        |  94 +++++++
 drivers/firmware/efi/libstub/x86-stub.c        | 269 +++++++++++---------
 drivers/firmware/efi/libstub/x86-stub.h        |  12 +
 drivers/firmware/efi/libstub/zboot.c           |   2 +-
 include/linux/decompress/mm.h                  |   2 +-
 23 files changed, 468 insertions(+), 473 deletions(-)
 create mode 100644 drivers/firmware/efi/libstub/x86-5lvl.c
 create mode 100644 drivers/firmware/efi/libstub/x86-stub.h

-- 
2.39.2

