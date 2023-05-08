Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19BF6FA06B
	for <lists+linux-efi@lfdr.de>; Mon,  8 May 2023 09:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjEHHDn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 8 May 2023 03:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbjEHHDn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 8 May 2023 03:03:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53071139;
        Mon,  8 May 2023 00:03:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD39661F86;
        Mon,  8 May 2023 07:03:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715C0C433D2;
        Mon,  8 May 2023 07:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683529420;
        bh=B2H6ikO6eA03jSankn0Mwcxu2D042jtg18LHSELfZS8=;
        h=From:To:Cc:Subject:Date:From;
        b=mZAGK2HxsfgEnC2AgZTjACQfusFi7tQ9ZoqkA7SPXvtOTTuolNHuasp7tA7xqVbu5
         J0VrzszjHzbVSWx8TGyiusGLIhe9D1bBypmurjWdrXeuqa3VpfJYvD10wDALPf/drJ
         xLK8JHg1dWOfmto37sKXBJCtMdvBg0qf4U4LQUGtVAbugMQXeLAMckOZ37YldimCNl
         Cidxa8yKZ2xsjcc5pKPnnQugmhJ0NJ1ICwMXgm2+sw9+6taMi96LxCaB6H2nURKnDy
         MW/N4j+qHm0dVoSj7RmXze4z994AXzWFYz3ufYfdlXHnAW/jAQpm3BqGqhj1PVHlgw
         lEPfVpod3pjvg==
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
Subject: [PATCH v2 00/20] efi/x86: Avoid bare metal decompressor during EFI boot
Date:   Mon,  8 May 2023 09:03:10 +0200
Message-Id: <20230508070330.582131-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7370; i=ardb@kernel.org; h=from:subject; bh=B2H6ikO6eA03jSankn0Mwcxu2D042jtg18LHSELfZS8=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JISVi3gpflYzXKTVqejHOPguvMO5KthJoZptx5vDr4CAvH RHl00kdpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCKKSxj+WWbzFK6caPatprDU LJ95X/alwynxzBNzMs7NYPoW1L7yBiPDrURpg53vr+6qmxtp/MmVfe1uzzU51jX71IQyb0ly58p zAgA=
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

This is v2 of [2], which updates the x86 boot path to avoid the legacy
decompressor when booting via the EFI stub.

TL;DR the bare metal decompressor inherits the loader's 1:1 mapping of
DRAM when entering in 64-bit mode, and assumes that all of it is mapped
read/write/execute, which will no longer be the case on hardware built
to comply with recently tightened logo requirements (*).

Changes since v1:
- streamline existing 4/5 level switching code and call it directly from
  the EFI stub - this is covered by the first 9 patches, which can be
  applied in isolation, if desired;
- deal with SEV/SNP init explicitly;
- clear BSS when booting via the 'handover protocol'
- switch to kernel CS before calling SEV init code in kernel proper.

Conceptually, this should not conflict with the memory acceptance work
which is being done by Kirill [3], but some lexical conlicts are not
unlikely. After applying this series, the allocations done by the EFI
stub for the trampoline and the decompressed kernel will use the EFI
page allocation APIs, and will therefore not need explicit acceptance. 

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
- OEMs only care about the Windows sticker, so they only boot test
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
[3] https://lore.kernel.org/all/20230507234618.18067-1-kirill.shutemov@linux.intel.com/

Ard Biesheuvel (20):
  x86: decompressor: Use proper sequence to take the address of the GOT
  x86: decompressor: Store boot_params pointer in callee save register
  x86: decompressor: Call trampoline as a normal function
  x86: decompressor: Use standard calling convention for trampoline
  x86: decompressor: Avoid the need for a stack in the 32-bit trampoline
  x86: decompressor: Call trampoline directly from C code
  x86: decompressor: Only call the trampoline when changing paging
    levels
  x86: decompressor: Merge trampoline cleanup with switching code
  x86: efistub: Perform 4/5 level paging switch from the stub
  x86: efistub: Prefer EFI memory attributes protocol over DXE services
  decompress: Use 8 byte alignment
  x86: decompressor: Move global symbol references to C code
  x86: decompressor: Factor out kernel decompression and relocation
  x86: head_64: Store boot_params pointer in callee-preserved register
  x86: head_64: Switch to kernel CS before enabling memory encryption
  efi: libstub: Add limit argument to efi_random_alloc()
  x86: efistub: Check SEV/SNP support while running in the firmware
  x86: efistub: Avoid legacy decompressor when doing EFI boot
  x86: efistub: Clear BSS in EFI handover protocol entrypoint
  x86: decompressor: Avoid magic offsets for EFI handover entrypoint

 arch/x86/boot/compressed/Makefile              |   5 +
 arch/x86/boot/compressed/efi_mixed.S           |  58 +---
 arch/x86/boot/compressed/head_32.S             |  34 +-
 arch/x86/boot/compressed/head_64.S             | 196 +++--------
 arch/x86/boot/compressed/misc.c                |  44 ++-
 arch/x86/boot/compressed/pgtable.h             |   6 +-
 arch/x86/boot/compressed/pgtable_64.c          |  72 ++--
 arch/x86/boot/compressed/sev.c                 |  12 +-
 arch/x86/include/asm/boot.h                    |   8 +
 arch/x86/include/asm/efi.h                     |   7 +-
 arch/x86/include/asm/sev.h                     |   4 +
 arch/x86/kernel/head_64.S                      |  33 +-
 drivers/firmware/efi/libstub/arm64-stub.c      |   2 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c |   4 +
 drivers/firmware/efi/libstub/efistub.h         |   2 +-
 drivers/firmware/efi/libstub/randomalloc.c     |  10 +-
 drivers/firmware/efi/libstub/x86-stub.c        | 353 +++++++++++++-------
 drivers/firmware/efi/libstub/zboot.c           |   2 +-
 include/linux/decompress/mm.h                  |   2 +-
 19 files changed, 400 insertions(+), 454 deletions(-)

-- 
2.39.2

