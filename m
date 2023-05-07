Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3109A6F9CD6
	for <lists+linux-efi@lfdr.de>; Mon,  8 May 2023 01:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjEGXqx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 7 May 2023 19:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbjEGXqt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 7 May 2023 19:46:49 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B46124B3;
        Sun,  7 May 2023 16:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683503203; x=1715039203;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=o5qhJzkLL1BJ2sMgx0IFpRVhlur9B7635wAjF+xuoPA=;
  b=Ph+L4ozEXiXN6VDbGL8zDkgplygXLpQRLzm1yrCxoyHFQmmi5V5dYx7g
   K2tIF3R7+koiZd9f2G/LVkqLf8YDEWNvdt+NJSKKIYl8O8zIneOoYStCR
   0rqlvtWlB3wqBEcVFdmUAYFNn/87bdK/hda38s/0fzk6h69kiuLkIy2cS
   Gh4ffoCjHQxZu8bYqB6ERIgKgcVO0EJHDFKrz3N66nsHEeqwmtLDL0cML
   LEhRI6BJ1C8gcVXi3MC1MhwgulukGecq+Bki/CP7FSBjrr0Mgx3D+Xk2c
   XUnLoShAHV6n6AGrMAxAT7QGs6BlRCzx/2iBvGIHFF8aboI+5X2naYqCl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="349550228"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="349550228"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2023 16:46:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="701222786"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="701222786"
Received: from dancaspi-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.61.73])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2023 16:46:22 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 08E5410D1E6; Mon,  8 May 2023 02:46:20 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv10 00/11] mm, x86/cc: Implement support for unaccepted memory
Date:   Mon,  8 May 2023 02:46:07 +0300
Message-Id: <20230507234618.18067-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

UEFI Specification version 2.9 introduces the concept of memory
acceptance: some Virtual Machine platforms, such as Intel TDX or AMD
SEV-SNP, requiring memory to be accepted before it can be used by the
guest. Accepting happens via a protocol specific for the Virtual
Machine platform.

Accepting memory is costly and it makes VMM allocate memory for the
accepted guest physical address range. It's better to postpone memory
acceptance until memory is needed. It lowers boot time and reduces
memory overhead.

The kernel needs to know what memory has been accepted. Firmware
communicates this information via memory map: a new memory type --
EFI_UNACCEPTED_MEMORY -- indicates such memory.

Range-based tracking works fine for firmware, but it gets bulky for
the kernel: e820 has to be modified on every page acceptance. It leads
to table fragmentation, but there's a limited number of entries in the
e820 table

Another option is to mark such memory as usable in e820 and track if the
range has been accepted in a bitmap. One bit in the bitmap represents
2MiB in the address space: one 4k page is enough to track 64GiB or
physical address space.

In the worst-case scenario -- a huge hole in the middle of the
address space -- It needs 256MiB to handle 4PiB of the address
space.

Any unaccepted memory that is not aligned to 2M gets accepted upfront.

The approach lowers boot time substantially. Boot to shell is ~2.5x
faster for 4G TDX VM and ~4x faster for 64G.

TDX-specific code isolated from the core of unaccepted memory support. It
supposed to help to plug-in different implementation of unaccepted memory
such as SEV-SNP.

-- Fragmentation study --

Vlastimil and Mel were concern about effect of unaccepted memory on
fragmentation prevention measures in page allocator. I tried to evaluate
it, but it is tricky. As suggested I tried to run multiple parallel kernel
builds and follow how often kmem:mm_page_alloc_extfrag gets hit.

See results in the v9 of the patchset[1][2]

[1] https://lore.kernel.org/all/20230330114956.20342-1-kirill.shutemov@linux.intel.com
[2] https://lore.kernel.org/all/20230416191940.ex7ao43pmrjhru2p@box.shutemov.name

--

The tree can be found here:

https://github.com/intel/tdx.git guest-unaccepted-memory

v10:
 - Rebased v6.4-rc1;
 - Restructure code around zones_with_unaccepted_pages static brach to avoid
   unnecessary function calls (Suggested by Vlastimil);
 - Drop mentions of PageUnaccepted();
 - Drop patches that add fake unaccepted memory support and sysfs handle to
   accept memory manually;
 - Add Reviewed-by from Vlastimil;
v9:
 - Accept memory up to high watermark when kernel runs out of free memory;
 - Treat unaccepted memory as unusable in __zone_watermark_unusable_free();
 - Per-zone unaccepted memory accounting;
 - All pages on unaccepted list are MAX_ORDER now;
 - accept_memory=eager in cmdline to pre-accept memory during the boot;
 - Implement fake unaccepted memory;
 - Sysfs handle to accept memory manually;
 - Drop PageUnaccepted();
 - Rename unaccepted_pages static key to zones_with_unaccepted_pages;
v8:
 - Rewrite core-mm support for unaccepted memory (patch 02/14);
 - s/UnacceptedPages/Unaccepted/ in meminfo;
 - Drop arch/x86/boot/compressed/compiler.h;
 - Fix build errors;
 - Adjust commit messages and comments;
 - Reviewed-bys from Dave and Borislav;
 - Rebased to tip/master.
v7:
 - Rework meminfo counter to use PageUnaccepted() and move to generic code;
 - Fix range_contains_unaccepted_memory() on machines without unaccepted memory;
 - Add Reviewed-by from David;
v6:
 - Fix load_unaligned_zeropad() on machine with unaccepted memory;
 - Clear PageUnaccepted() on merged pages, leaving it only on head;
 - Clarify error handling in allocate_e820();
 - Fix build with CONFIG_UNACCEPTED_MEMORY=y, but without TDX;
 - Disable kexec at boottime instead of build conflict;
 - Rebased to tip/master;
 - Spelling fixes;
 - Add Reviewed-by from Mike and David;
v5:
 - Updates comments and commit messages;
   + Explain options for unaccepted memory handling;
 - Expose amount of unaccepted memory in /proc/meminfo
 - Adjust check in page_expected_state();
 - Fix error code handling in allocate_e820();
 - Centralize __pa()/__va() definitions in the boot stub;
 - Avoid includes from the main kernel in the boot stub;
 - Use an existing hole in boot_param for unaccepted_memory, instead of adding
   to the end of the structure;
 - Extract allocate_unaccepted_memory() form allocate_e820();
 - Complain if there's unaccepted memory, but kernel does not support it;
 - Fix vmstat counter;
 - Split up few preparatory patches;
 - Random readability adjustments;
v4:
 - PageBuddyUnaccepted() -> PageUnaccepted;
 - Use separate page_type, not shared with offline;
 - Rework interface between core-mm and arch code;
 - Adjust commit messages;
 - Ack from Mike;

Kirill A. Shutemov (11):
  mm: Add support for unaccepted memory
  efi/x86: Get full memory map in allocate_e820()
  x86/boot: Add infrastructure required for unaccepted memory support
  efi/x86: Implement support for unaccepted memory
  x86/boot/compressed: Handle unaccepted memory
  x86/mm: Reserve unaccepted memory bitmap
  x86/mm: Provide helpers for unaccepted memory
  x86/mm: Avoid load_unaligned_zeropad() stepping into unaccepted memory
  x86/tdx: Make _tdx_hypercall() and __tdx_module_call() available in
    boot stub
  x86/tdx: Refactor try_accept_one()
  x86/tdx: Add unaccepted memory support

 Documentation/arch/x86/zero-page.rst     |   1 +
 arch/x86/Kconfig                         |   2 +
 arch/x86/boot/bitops.h                   |  40 ++++++
 arch/x86/boot/compressed/Makefile        |   3 +-
 arch/x86/boot/compressed/align.h         |  14 ++
 arch/x86/boot/compressed/bitmap.c        |  43 ++++++
 arch/x86/boot/compressed/bitmap.h        |  49 +++++++
 arch/x86/boot/compressed/bits.h          |  36 +++++
 arch/x86/boot/compressed/efi.h           |   1 +
 arch/x86/boot/compressed/error.c         |  19 +++
 arch/x86/boot/compressed/error.h         |   1 +
 arch/x86/boot/compressed/find.c          |  54 +++++++
 arch/x86/boot/compressed/find.h          |  79 +++++++++++
 arch/x86/boot/compressed/kaslr.c         |  35 +++--
 arch/x86/boot/compressed/math.h          |  37 +++++
 arch/x86/boot/compressed/mem.c           | 122 ++++++++++++++++
 arch/x86/boot/compressed/minmax.h        |  61 ++++++++
 arch/x86/boot/compressed/misc.c          |   6 +
 arch/x86/boot/compressed/misc.h          |   6 +
 arch/x86/boot/compressed/pgtable_types.h |  25 ++++
 arch/x86/boot/compressed/tdx-shared.c    |   2 +
 arch/x86/boot/compressed/tdx.c           |  39 +++++
 arch/x86/coco/tdx/Makefile               |   2 +-
 arch/x86/coco/tdx/tdx-shared.c           |  95 +++++++++++++
 arch/x86/coco/tdx/tdx.c                  | 118 +---------------
 arch/x86/include/asm/page.h              |   3 +
 arch/x86/include/asm/shared/tdx.h        |  53 +++++++
 arch/x86/include/asm/tdx.h               |  21 +--
 arch/x86/include/asm/unaccepted_memory.h |  16 +++
 arch/x86/include/uapi/asm/bootparam.h    |   2 +-
 arch/x86/kernel/e820.c                   |  17 +++
 arch/x86/mm/Makefile                     |   2 +
 arch/x86/mm/unaccepted_memory.c          | 101 +++++++++++++
 drivers/base/node.c                      |   7 +
 drivers/firmware/efi/Kconfig             |  14 ++
 drivers/firmware/efi/efi.c               |   1 +
 drivers/firmware/efi/libstub/x86-stub.c  |  98 +++++++++++--
 fs/proc/meminfo.c                        |   5 +
 include/linux/efi.h                      |   3 +-
 include/linux/mmzone.h                   |   8 ++
 mm/internal.h                            |  13 ++
 mm/memblock.c                            |   9 ++
 mm/mm_init.c                             |   7 +
 mm/page_alloc.c                          | 173 +++++++++++++++++++++++
 mm/vmstat.c                              |   3 +
 45 files changed, 1280 insertions(+), 166 deletions(-)
 create mode 100644 arch/x86/boot/compressed/align.h
 create mode 100644 arch/x86/boot/compressed/bitmap.c
 create mode 100644 arch/x86/boot/compressed/bitmap.h
 create mode 100644 arch/x86/boot/compressed/bits.h
 create mode 100644 arch/x86/boot/compressed/find.c
 create mode 100644 arch/x86/boot/compressed/find.h
 create mode 100644 arch/x86/boot/compressed/math.h
 create mode 100644 arch/x86/boot/compressed/mem.c
 create mode 100644 arch/x86/boot/compressed/minmax.h
 create mode 100644 arch/x86/boot/compressed/pgtable_types.h
 create mode 100644 arch/x86/boot/compressed/tdx-shared.c
 create mode 100644 arch/x86/coco/tdx/tdx-shared.c
 create mode 100644 arch/x86/include/asm/unaccepted_memory.h
 create mode 100644 arch/x86/mm/unaccepted_memory.c

-- 
2.39.3

