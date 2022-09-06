Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDA25AE58B
	for <lists+linux-efi@lfdr.de>; Tue,  6 Sep 2022 12:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239460AbiIFKl7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 6 Sep 2022 06:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbiIFKlz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 6 Sep 2022 06:41:55 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCF65F205;
        Tue,  6 Sep 2022 03:41:43 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 19E1340D403E;
        Tue,  6 Sep 2022 10:41:38 +0000 (UTC)
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Evgeniy Baskov <baskov@ispras.ru>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 00/16] x86_64: Improvements at compressed kernel stage
Date:   Tue,  6 Sep 2022 13:41:04 +0300
Message-Id: <cover.1662459668.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

Direct extraction can be toggled using CONFIG_EFI_STUB_EXTRACT_DIRECT.
Memory protection inside EFI environment is controlled by the
CONFIG_DXE_MEM_ATTRIBUTES option, although with these patches this
option also control the use EFI_MEMORY_ATTTRIBUTE_PROTOCOL and memory
protection attributes of PE sections and not only DXE services as the
name might suggest.

[1] https://lkml.org/lkml/2022/8/1/1314
[2] https://github.com/acidanthera/audk/tree/secure_pe
[3] https://download.microsoft.com/download/9/c/5/9c5b2167-8017-4bae-9fde-d599bac8184a/pecoff_v83.docx
[4] https://www.ispras.ru/en/technologies/asperitas/
[5] https://github.com/microsoft/mu_tiano_platforms

Evgeniy Baskov (16):
  x86/boot: Align vmlinuz sections on page size
  x86/build: Remove RWX sections and align on 4KB
  x86/boot: Set cr0 to known state in trampoline
  x86/boot: Increase boot page table size
  x86/boot: Support 4KB pages for identity mapping
  x86/boot: Setup memory protection for bzImage code
  x86/boot: Map memory explicitly
  x86/boot: Remove mapping from page fault handler
  efi/libstub: Move helper function to related file
  x86/boot: Make console interface more abstract
  x86/boot: Split trampoline and pt init code
  x86/boot: Add EFI kernel extraction interface
  efi/x86: Support extracting kernel from libstub
  x86/build: Make generated PE more spec compliant
  efi/libstub: Add memory attribute protocol definitions
  efi/libstub: Use memory attribute protocol

 arch/x86/boot/Makefile                        |   2 +-
 arch/x86/boot/compressed/Makefile             |   2 +-
 arch/x86/boot/compressed/acpi.c               |  21 +-
 arch/x86/boot/compressed/efi.c                |  19 +-
 arch/x86/boot/compressed/head_32.S            |   9 +-
 arch/x86/boot/compressed/head_64.S            |  77 ++-
 arch/x86/boot/compressed/ident_map_64.c       | 129 ++--
 arch/x86/boot/compressed/kaslr.c              |   4 +
 arch/x86/boot/compressed/misc.c               | 255 ++++----
 arch/x86/boot/compressed/misc.h               |  25 +-
 arch/x86/boot/compressed/pgtable.h            |  20 -
 arch/x86/boot/compressed/pgtable_64.c         |  75 ++-
 arch/x86/boot/compressed/putstr.c             | 133 ++++
 arch/x86/boot/compressed/sev.c                |   6 +-
 arch/x86/boot/compressed/vmlinux.lds.S        |   6 +
 arch/x86/boot/header.S                        | 110 +---
 arch/x86/boot/tools/build.c                   | 575 ++++++++++++------
 arch/x86/include/asm/boot.h                   |  26 +-
 arch/x86/include/asm/efi.h                    |   7 +
 arch/x86/include/asm/init.h                   |   1 +
 arch/x86/include/asm/shared/extract.h         |  25 +
 arch/x86/include/asm/shared/pgtable.h         |  29 +
 arch/x86/kernel/vmlinux.lds.S                 |  15 +-
 arch/x86/mm/ident_map.c                       | 186 +++++-
 drivers/firmware/efi/Kconfig                  |  14 +
 drivers/firmware/efi/libstub/Makefile         |   1 +
 drivers/firmware/efi/libstub/efistub.h        |  31 +
 drivers/firmware/efi/libstub/mem.c            | 189 ++++++
 .../firmware/efi/libstub/x86-extract-direct.c | 220 +++++++
 drivers/firmware/efi/libstub/x86-stub.c       | 172 +++---
 include/linux/efi.h                           |   1 +
 31 files changed, 1701 insertions(+), 684 deletions(-)
 delete mode 100644 arch/x86/boot/compressed/pgtable.h
 create mode 100644 arch/x86/boot/compressed/putstr.c
 create mode 100644 arch/x86/include/asm/shared/extract.h
 create mode 100644 arch/x86/include/asm/shared/pgtable.h
 create mode 100644 drivers/firmware/efi/libstub/x86-extract-direct.c

-- 
2.35.1

