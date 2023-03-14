Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28076B8F7D
	for <lists+linux-efi@lfdr.de>; Tue, 14 Mar 2023 11:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjCNKP4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Mar 2023 06:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjCNKPy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Mar 2023 06:15:54 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E96297FD0;
        Tue, 14 Mar 2023 03:15:13 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 5A1DC40737D3;
        Tue, 14 Mar 2023 10:14:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 5A1DC40737D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1678788840;
        bh=9SzAOcchTEg2AfMbtvtXBF1FJwf4qtt0ARBnHBjGoNU=;
        h=From:To:Cc:Subject:Date:From;
        b=TkC9VxqjdhZp6/XY4lxp13Zj5Mzp3vlbM2oaCP8jlaNIsLKw1QJtORS6f7DUQAJkp
         UXU2p5mNrCZwBvBeUpulRJTrOz1bPIaXo4iZO7CebYbhWdT4myL4OgIERwf2MVDtvo
         GXSeH2f0vQiDFATGkLRXboAREKbJbQdfrpwpmGck=
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Evgeniy Baskov <baskov@ispras.ru>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v5 00/27] x86_64: Improvements at compressed kernel stage
Date:   Tue, 14 Mar 2023 13:13:27 +0300
Message-Id: <cover.1678785672.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This patchset is aimed
* to improve UEFI compatibility of compressed kernel code for x86_64
* to setup proper memory access attributes for code and rodata sections
* to implement W^X protection policy throughout the whole execution 
  of compressed kernel for EFISTUB code path. 

Kernel is made to be more compatible with PE image specification [3],
allowing it to be successfully loaded by stricter PE loader
implementations like the one from [2]. There is at least one
known implementation that uses that loader in production [4].
There are also ongoing efforts to upstream these changes.

Also the patchset adds EFI_MEMORY_ATTTRIBUTE_PROTOCOL, included into
EFI specification since version 2.10, as a better alternative to
using DXE services for memory protection attributes manipulation,
since it is defined by the UEFI specification itself and not UEFI PI
specification. This protocol is not widely available so the code
using DXE services is kept in place as a fallback in case specific
implementation does not support the new protocol.
One of EFI implementations that already support
EFI_MEMORY_ATTTRIBUTE_PROTOCOL is Microsoft Project Mu [5].
 
Kernel image generation tool (tools/build.c) is refactored as a part
of changes that makes PE image more compatible.
   
The patchset implements memory protection for compressed kernel
code while executing both inside EFI boot services and outside of
them. For EFISTUB code path W^X protection policy is maintained
throughout the whole execution of compressed kernel. The latter
is achieved by extracting the kernel directly from EFI environment
and jumping to it's head immediately after exiting EFI boot services.
As a side effect of this change one page table rebuild and a copy of
the kernel image is removed.

Memory protection inside EFI environment is controlled by the
CONFIG_DXE_MEM_ATTRIBUTES option, although with these patches this
option also control the use EFI_MEMORY_ATTTRIBUTE_PROTOCOL and memory
protection attributes of PE sections and not only DXE services as the
name might suggest.

Changes in v2:
 * Fix spelling.
 * Rebase code to current master.
 * Split huge patches into smaller ones.
 * Remove unneeded forward declarations.
 * Make direct extraction unconditional.
   * Also make it work for x86_32.
   * Reduce lower limit of KASLR to 64M.
 * Make callback interface more logically consistent.
 * Actually declare callbacks structure before using it.
 * Mention effect on x86_32 in commit message of 
   "x86/build: Remove RWX sections and align on 4KB".
 * Clarify commit message of
   "x86/boot: Increase boot page table size".
 * Remove "startup32_" prefix on startup32_enable_nx_if_supported.
 * Move linker generated sections outside of function scope.
 * Drop some unintended changes.
 * Drop generating 2 reloc entries.
   (as I've misread the documentation and there's no need for this change.)
 * Set has_nx from enable_nx_if_supported correctly.
 * Move ELF header check to build time.
 * Set WP at the same time as PG in trampoline code,
   as it is more logically consistent.
 * Put x86-specific EFISTUB definitions in x86-stub.h header.
 * Catch presence of ELF segments violating W^X during build.
 * Move PE definitions from build.c to a new header file.
 * Fix generation of PE '.compat' section.

I decided to keep protection of compressed kernel blob and '.rodata'
separate from '.text' for now, since it does not really have a lot
of overhead.

Otherwise, all comments on v1 seems to be addressed. 
I have also included Peter's patches [6-7] into the series for simplicity.

Changes in v3:
 * Setup IDT before issuing cpuid so that AMD SEV #VC handler is set.
 * Replace memcpy with strncpy to prevent out-of-bounds reads in tools/build.c.
 * Zero BSS before entering efi_main(), since it can contain garbage
   when booting via EFI handover protocol.
 * When booting via EFI don't require init_size of RAM, since in-place
   unpacking is not used anyway with that interface. This saves ~40M of memory
   for debian .config.
 * Setup sections memory protection in efi_main() to cover EFI handover protocol,
   where EFI sections are likely not properly protected.

Changes in v4:
 * Add one missing identity mapping.
 * Include following patches improving the use of DXE services:
     - efi/x86: don't try to set page attributes on 0-sized regions.
     - efi/x86: don't set unsupported memory attributes

Changes in v5:
 * Fix some warnings reported by the build bot.
 * Clarify comments about initial page table buffer size and
   kernel extraction buffer allocation and some commit messages.
 * Fix make dependencies tracking for W^X compile time check.
 * Remove unneeded explicit identity mapping of struct efi_info in
   process_efi_entries() -- it is already mapped at the time of the
   function execution.
 * Fix 'nokaslr' command line option.
 * Remove memory attributes definition patch. It is already upstreamed.
 * Reduce diff size for "x86/build: Cleanup tools/build.c"
 * Clean up 32-bit EFISTUB assembly entry: use simpler relative offset
   expressions and remove unused instruction.
 * Don't set alignment flags for PE sections. They are only meant for
   object files.
 * Rework "x86/build: Make generated PE more spec compliant", so that
   it does not generate sections dynamically and is overall simpler.
 * Add Ard's patch removing DOS stub. And another one adding the local
   copy of boot_params from [8].
 * Revert to the old behavior of only relaxing memory attributes
   with DXE services. Only when EFI_MEMORY_ATTRIBUTE_PROTOCOL is
   available stricter memory attributes are set.

The reworked x86 kernel image build tool patches are based on
the ideas from the Ard's RFC patches at [8] and comments to v4 at [9].

Patch "x86/boot: Support 4KB pages for identity mapping" might need review
from x86/mm team.

Many thanks to Ard Biesheuvel <ardb@kernel.org> and
Andrew Cooper <Andrew.Cooper3@citrix.com> for reviewing the patches, and to
Peter Jones <pjones@redhat.com>, Mario Limonciello <mario.limonciello@amd.com> and
Joey Lee <jlee@suse.com> for additional testing!

[1] https://lore.kernel.org/lkml/893da11995f93a7ea8f7485d17bf356a@ispras.ru/
[2] https://github.com/acidanthera/audk/tree/secure_pe
[3] https://download.microsoft.com/download/9/c/5/9c5b2167-8017-4bae-9fde-d599bac8184a/pecoff_v83.docx
[4] https://www.ispras.ru/en/technologies/asperitas/
[5] https://github.com/microsoft/mu_tiano_platforms
[6] https://lore.kernel.org/lkml/20221018205118.3756594-1-pjones@redhat.com/
[7] https://lore.kernel.org/lkml/20221213180403.1308507-2-pjones@redhat.com/
[8] https://lore.kernel.org/linux-efi/20230308202209.2980947-1-ardb@kernel.org/
[9] https://lore.kernel.org/lkml/CAMj1kXGu0uFynyt=MostXo58A4f4Zu6cFFiSShFZChU5LWt1ZQ@mail.gmail.com/

Ard Biesheuvel (2):
  x86: decompressor: Remove the 'bugger off' message
  efi: x86: Use private copy of struct setup_header

Evgeniy Baskov (23):
  x86/boot: Align vmlinuz sections on page size
  x86/build: Remove RWX sections and align on 4KB
  x86/boot: Set cr0 to known state in trampoline
  x86/boot: Increase boot page table size
  x86/boot: Support 4KB pages for identity mapping
  x86/boot: Setup memory protection for bzImage code
  x86/build: Check W^X of vmlinux during build
  x86/boot: Map memory explicitly
  x86/boot: Remove mapping from page fault handler
  efi/libstub: Move helper function to related file
  x86/boot: Make console interface more abstract
  x86/boot: Make kernel_add_identity_map() a pointer
  x86/boot: Split trampoline and pt init code
  x86/boot: Add EFI kernel extraction interface
  efi/x86: Support extracting kernel from libstub
  x86/boot: Reduce lower limit of physical KASLR
  tools/include: Add simplified version of pe.h
  x86/build: Cleanup tools/build.c
  x86/build: Add SETUP_HEADER_OFFSET constant
  x86/build: set type_of_loader for EFISTUB
  efi/libstub: Don't set ramdisk_image/ramdisk_size
  x86/build: Make generated PE more spec compliant
  efi/libstub: Use memory attribute protocol

Peter Jones (2):
  efi/libstub: make memory protection warnings include newlines.
  efi/x86: don't try to set page attributes on 0-sized regions.

 arch/x86/boot/Makefile                        |   2 +-
 arch/x86/boot/compressed/Makefile             |   9 +-
 arch/x86/boot/compressed/acpi.c               |  21 +-
 arch/x86/boot/compressed/efi.c                |  19 +-
 arch/x86/boot/compressed/head_32.S            |  43 +-
 arch/x86/boot/compressed/head_64.S            |  89 +++-
 arch/x86/boot/compressed/ident_map_64.c       | 123 +++--
 arch/x86/boot/compressed/kaslr.c              |   6 +-
 arch/x86/boot/compressed/misc.c               | 284 ++++++-----
 arch/x86/boot/compressed/misc.h               |  23 +-
 arch/x86/boot/compressed/pgtable.h            |  20 -
 arch/x86/boot/compressed/pgtable_64.c         |  71 +--
 arch/x86/boot/compressed/putstr.c             | 130 +++++
 arch/x86/boot/compressed/sev.c                |   6 +-
 arch/x86/boot/compressed/vmlinux.lds.S        |  16 +-
 arch/x86/boot/header.S                        | 109 ++--
 arch/x86/boot/setup.ld                        |   7 +-
 arch/x86/boot/tools/build.c                   | 475 +++++++++++-------
 arch/x86/include/asm/boot.h                   |  28 +-
 arch/x86/include/asm/init.h                   |   8 +-
 arch/x86/include/asm/shared/extract.h         |  26 +
 arch/x86/include/asm/shared/pgtable.h         |  29 ++
 arch/x86/kernel/vmlinux.lds.S                 |  15 +-
 arch/x86/mm/ident_map.c                       | 185 +++++--
 drivers/firmware/efi/Kconfig                  |   2 +
 drivers/firmware/efi/libstub/Makefile         |   2 +-
 drivers/firmware/efi/libstub/efistub.h        |   9 +-
 drivers/firmware/efi/libstub/mem.c            | 194 +++++++
 .../firmware/efi/libstub/x86-extract-direct.c | 217 ++++++++
 drivers/firmware/efi/libstub/x86-stub.c       | 227 +--------
 drivers/firmware/efi/libstub/x86-stub.h       |  14 +
 tools/include/linux/pe.h                      | 150 ++++++
 32 files changed, 1753 insertions(+), 806 deletions(-)
 delete mode 100644 arch/x86/boot/compressed/pgtable.h
 create mode 100644 arch/x86/boot/compressed/putstr.c
 create mode 100644 arch/x86/include/asm/shared/extract.h
 create mode 100644 arch/x86/include/asm/shared/pgtable.h
 create mode 100644 drivers/firmware/efi/libstub/x86-extract-direct.c
 create mode 100644 drivers/firmware/efi/libstub/x86-stub.h
 create mode 100644 tools/include/linux/pe.h

-- 
2.39.2

