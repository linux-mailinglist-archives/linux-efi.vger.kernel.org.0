Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877017245DD
	for <lists+linux-efi@lfdr.de>; Tue,  6 Jun 2023 16:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbjFFO04 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 6 Jun 2023 10:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbjFFO0z (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 6 Jun 2023 10:26:55 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF5E186;
        Tue,  6 Jun 2023 07:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686061613; x=1717597613;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yCyeevrAPGrKs0IeczleoTFmMXXlre9n39I0RmirbKA=;
  b=n8TV7mvLfWwDsUyzd33YsdkWPY/J7BpPxKaSOipq8Zs54SJFg9H5JOzx
   ZHC+RioWPkzfh+qUJbnPasETLVwD0rUw9X1x9dOI2ejIeHMhw/olsLfl/
   3iUNT6byCaqvU00kKz9gbRaQAZCPU6B8us5z8olan7x63c0Sa8QJRngEb
   rFITWhDonZQ1xN6mzdgyeIXnY7N6ibzHBLEio+o/RHFXh3ZWUOQ+f5MoO
   E7DZN4du+5gj4X6XEBdrKPRP0Ca/7N+SnuMU3ka2zJ7qop2Wa2pNS3mdJ
   EzKg2zHlBYxdU3G0SowmiT26rTZith3BO3oRqtCKrnzWSWZYxFFiPbeDB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="359147067"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="359147067"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 07:26:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="659543339"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="659543339"
Received: from rgraefe-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.58.173])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 07:26:44 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 1FB4510CFD2; Tue,  6 Jun 2023 17:26:42 +0300 (+03)
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
Subject: [PATCHv14 0/9] mm, x86/cc, efi: Implement support for unaccepted memory
Date:   Tue,  6 Jun 2023 17:26:28 +0300
Message-Id: <20230606142637.5171-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

v14:
 - Fix error handling in arch_accept_memory() (Tom);
 - Address Borislav's feedback:
   + code restructure;
   + added/adjusted comments;
v13:
 - Fix few boot issues discovered by 0day;
 - Simplify tdx_accept_memory(): no need in MAP_GPA hypercall;
 - Update commit message for the first patch;
 - Add Reviewed-bys from Tom and Ard;
v12:
 - Re-initialize 'unaccepted_table' variable from decompressor to cover some
   boot scenarios;
 - Add missing memblock_reserve() for the unaccepted memory configuration
   table (Mika);
 - Add efi.unaccepted into efi_tables (Tom);
 - Do not build tdx-shared.o for !TDX (Tom);
 - Typo fix (Liam)
 - Whitespace fix;
 - Reviewed-bys from Liam, Tom and Ard;
v11:
 - Restructure the code to make it less x86-specific (suggested by Ard):
   + use EFI configuration table instead of zero-page to pass down bitmap;
   + do not imply 1bit == 2M in bitmap;
   + move bulk of the code under driver/firmware/efi;
 - The bitmap only covers unaccpeted memory now. All memory that is not covered
   by the bitmap assumed accepted;
 - Reviewed-by from Ard;
v10:
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
Kirill A. Shutemov (9):
  mm: Add support for unaccepted memory
  efi/x86: Get full memory map in allocate_e820()
  efi/libstub: Implement support for unaccepted memory
  x86/boot/compressed: Handle unaccepted memory
  efi: Add unaccepted memory support
  efi/unaccepted: Avoid load_unaligned_zeropad() stepping into
    unaccepted memory
  x86/tdx: Make _tdx_hypercall() and __tdx_module_call() available in
    boot stub
  x86/tdx: Refactor try_accept_one()
  x86/tdx: Add unaccepted memory support

 arch/x86/Kconfig                              |   2 +
 arch/x86/boot/compressed/Makefile             |   3 +-
 arch/x86/boot/compressed/efi.h                |  10 +
 arch/x86/boot/compressed/error.c              |  19 ++
 arch/x86/boot/compressed/error.h              |   1 +
 arch/x86/boot/compressed/kaslr.c              |  40 +++-
 arch/x86/boot/compressed/mem.c                |  83 +++++++
 arch/x86/boot/compressed/misc.c               |   6 +
 arch/x86/boot/compressed/misc.h               |  10 +
 arch/x86/boot/compressed/tdx-shared.c         |   2 +
 arch/x86/coco/tdx/Makefile                    |   2 +-
 arch/x86/coco/tdx/tdx-shared.c                |  71 ++++++
 arch/x86/coco/tdx/tdx.c                       | 102 +-------
 arch/x86/include/asm/efi.h                    |   2 +
 arch/x86/include/asm/shared/tdx.h             |  53 +++++
 arch/x86/include/asm/tdx.h                    |  19 --
 arch/x86/include/asm/unaccepted_memory.h      |  24 ++
 arch/x86/platform/efi/efi.c                   |   3 +
 drivers/base/node.c                           |   7 +
 drivers/firmware/efi/Kconfig                  |  14 ++
 drivers/firmware/efi/Makefile                 |   1 +
 drivers/firmware/efi/efi.c                    |  26 ++
 drivers/firmware/efi/libstub/Makefile         |   2 +
 drivers/firmware/efi/libstub/bitmap.c         |  41 ++++
 drivers/firmware/efi/libstub/efistub.h        |   6 +
 drivers/firmware/efi/libstub/find.c           |  43 ++++
 .../firmware/efi/libstub/unaccepted_memory.c  | 222 ++++++++++++++++++
 drivers/firmware/efi/libstub/x86-stub.c       |  39 +--
 drivers/firmware/efi/unaccepted_memory.c      | 147 ++++++++++++
 fs/proc/meminfo.c                             |   5 +
 include/linux/efi.h                           |  13 +-
 include/linux/mm.h                            |  19 ++
 include/linux/mmzone.h                        |   8 +
 mm/memblock.c                                 |   9 +
 mm/mm_init.c                                  |   7 +
 mm/page_alloc.c                               | 173 ++++++++++++++
 mm/vmstat.c                                   |   3 +
 37 files changed, 1089 insertions(+), 148 deletions(-)
 create mode 100644 arch/x86/boot/compressed/mem.c
 create mode 100644 arch/x86/boot/compressed/tdx-shared.c
 create mode 100644 arch/x86/coco/tdx/tdx-shared.c
 create mode 100644 arch/x86/include/asm/unaccepted_memory.h
 create mode 100644 drivers/firmware/efi/libstub/bitmap.c
 create mode 100644 drivers/firmware/efi/libstub/find.c
 create mode 100644 drivers/firmware/efi/libstub/unaccepted_memory.c
 create mode 100644 drivers/firmware/efi/unaccepted_memory.c

-- 
2.39.3

