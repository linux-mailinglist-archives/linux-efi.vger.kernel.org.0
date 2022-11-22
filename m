Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2FC633AD8
	for <lists+linux-efi@lfdr.de>; Tue, 22 Nov 2022 12:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbiKVLM6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Nov 2022 06:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbiKVLMr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Nov 2022 06:12:47 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B331133;
        Tue, 22 Nov 2022 03:12:44 -0800 (PST)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 07840419E9E1;
        Tue, 22 Nov 2022 11:12:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 07840419E9E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1669115560;
        bh=6Gr0r6LovJvsaNNVxVRgH6+58cjeOwj+hTEfeESkPis=;
        h=From:To:Cc:Subject:Date:From;
        b=CaN2YwTDfu29fQne5jc8VNBg9BWvkOgIyGOFM1yMCMeC0sx53w15hmy8qH2QfRl3v
         EdeovZLQ9gh1KUz9qmexUD3FK1T2C4isseX8IyLMG/m841JJAcV3vQHdJtnIxfMwOg
         LToHZwC3dDuq4+YZpLypmTJpeXiHyKtmXE8lomY8=
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
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v3 00/24] x86_64: Improvements at compressed kernel stage
Date:   Tue, 22 Nov 2022 14:12:09 +0300
Message-Id: <cover.1668958803.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

Patch "x86/boot: Support 4KB pages for identity mapping" needs review
from x86/mm team.

I have also included Peter's patch [6] into the series for simplicity.

Many thanks to Ard Biesheuvel <ardb@kernel.org> and
Andrew Cooper <Andrew.Cooper3@citrix.com> for reviewing the patches, and to
Peter Jones <pjones@redhat.com>, Mario Limonciello <mario.limonciello@amd.com> and
Joey Lee <jlee@suse.com> for additional testing!

[1] https://lkml.org/lkml/2022/8/1/1314
[2] https://github.com/acidanthera/audk/tree/secure_pe
[3] https://download.microsoft.com/download/9/c/5/9c5b2167-8017-4bae-9fde-d599bac8184a/pecoff_v83.docx
[4] https://www.ispras.ru/en/technologies/asperitas/
[5] https://github.com/microsoft/mu_tiano_platforms
[6] https://lkml.org/lkml/2022/10/18/1178

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
  x86/boot: Reduce size of the DOS stub
  tools/include: Add simplified version of pe.h
  x86/build: Cleanup tools/build.c
  x86/build: Make generated PE more spec compliant
  efi/x86: Explicitly set sections memory attributes
  efi/libstub: Add memory attribute protocol definitions
  efi/libstub: Use memory attribute protocol

Peter Jones (1):
  efi/libstub: Make memory protection warnings include newlines

 arch/x86/boot/Makefile                        |   2 +-
 arch/x86/boot/compressed/Makefile             |   8 +-
 arch/x86/boot/compressed/acpi.c               |  21 +-
 arch/x86/boot/compressed/efi.c                |  19 +-
 arch/x86/boot/compressed/head_32.S            |  53 +-
 arch/x86/boot/compressed/head_64.S            |  89 ++-
 arch/x86/boot/compressed/ident_map_64.c       | 122 ++--
 arch/x86/boot/compressed/kaslr.c              |   8 +-
 arch/x86/boot/compressed/misc.c               | 278 ++++-----
 arch/x86/boot/compressed/misc.h               |  23 +-
 arch/x86/boot/compressed/pgtable.h            |  20 -
 arch/x86/boot/compressed/pgtable_64.c         |  75 ++-
 arch/x86/boot/compressed/putstr.c             | 130 ++++
 arch/x86/boot/compressed/sev.c                |   6 +-
 arch/x86/boot/compressed/vmlinux.lds.S        |   6 +
 arch/x86/boot/header.S                        | 110 +---
 arch/x86/boot/tools/build.c                   | 569 +++++++++++-------
 arch/x86/include/asm/boot.h                   |  26 +-
 arch/x86/include/asm/efi.h                    |   7 +
 arch/x86/include/asm/init.h                   |   1 +
 arch/x86/include/asm/shared/extract.h         |  26 +
 arch/x86/include/asm/shared/pgtable.h         |  29 +
 arch/x86/kernel/vmlinux.lds.S                 |  15 +-
 arch/x86/mm/ident_map.c                       | 185 +++++-
 drivers/firmware/efi/Kconfig                  |   2 +
 drivers/firmware/efi/libstub/Makefile         |   2 +-
 drivers/firmware/efi/libstub/efistub.h        |  26 +
 drivers/firmware/efi/libstub/mem.c            | 190 ++++++
 .../firmware/efi/libstub/x86-extract-direct.c | 208 +++++++
 drivers/firmware/efi/libstub/x86-stub.c       | 231 ++-----
 drivers/firmware/efi/libstub/x86-stub.h       |  14 +
 include/linux/efi.h                           |   1 +
 tools/include/linux/pe.h                      | 150 +++++
 33 files changed, 1852 insertions(+), 800 deletions(-)
 delete mode 100644 arch/x86/boot/compressed/pgtable.h
 create mode 100644 arch/x86/boot/compressed/putstr.c
 create mode 100644 arch/x86/include/asm/shared/extract.h
 create mode 100644 arch/x86/include/asm/shared/pgtable.h
 create mode 100644 drivers/firmware/efi/libstub/x86-extract-direct.c
 create mode 100644 drivers/firmware/efi/libstub/x86-stub.h
 create mode 100644 tools/include/linux/pe.h

-- 
2.37.4

