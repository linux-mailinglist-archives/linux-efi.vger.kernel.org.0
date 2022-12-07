Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DA864516F
	for <lists+linux-efi@lfdr.de>; Wed,  7 Dec 2022 02:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiLGBty (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 6 Dec 2022 20:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiLGBtw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 6 Dec 2022 20:49:52 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A455289F;
        Tue,  6 Dec 2022 17:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670377791; x=1701913791;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mKZR8pGZr9YedBSYT9wia+N/Q+rEF5aGSppbNIVw7Ug=;
  b=ehbjZCf4c3OGOR84xoGt514DaicU/OCRKL7xwTH4O/Sl4ZZDpMnngmhd
   jzwh6QS95SxKIyrRhYn6I8XDASu5CZcim4PmtAuQwJ9htaFqEJhAT64qm
   PUrtiynlp5IN5oyK87pgPXAIsb0eIMshMtgrMdyspKo/O1kFjuuN54VCr
   0UgWHCaqCE6myC8dIOvkalDxM5l715GJSN/CCv17tFbt50xTqJFlsxmbH
   Dk+sBpYHDR61/gG4ZixNeMCIvZsfTOQ7Vmtq+zwrUK1xD/A+/3MoiGSSB
   PbmIi4PDxf3EPoTf8NsX/ih0IkAAABiqMBAsuQDVlN9eh5h4UtdDWkTMP
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="316794370"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="316794370"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 17:49:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="640082262"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="640082262"
Received: from puneets1-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.38.123])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 17:49:42 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 2CF7C109C84; Wed,  7 Dec 2022 04:49:39 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
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
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv8 00/14] mm, x86/cc: Implement support for unaccepted memory
Date:   Wed,  7 Dec 2022 04:49:19 +0300
Message-Id: <20221207014933.8435-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

The tree can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git unaccepted-memory

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
Kirill A. Shutemov (14):
  x86/boot: Centralize __pa()/__va() definitions
  mm: Add support for unaccepted memory
  mm: Report unaccepted memory in meminfo
  efi/x86: Get full memory map in allocate_e820()
  x86/boot: Add infrastructure required for unaccepted memory support
  efi/x86: Implement support for unaccepted memory
  x86/boot/compressed: Handle unaccepted memory
  x86/mm: Reserve unaccepted memory bitmap
  x86/mm: Provide helpers for unaccepted memory
  x86/mm: Avoid load_unaligned_zeropad() stepping into unaccepted memory
  x86: Disable kexec if system has unaccepted memory
  x86/tdx: Make _tdx_hypercall() and __tdx_module_call() available in
    boot stub
  x86/tdx: Refactor try_accept_one()
  x86/tdx: Add unaccepted memory support

 Documentation/x86/zero-page.rst          |   1 +
 arch/x86/Kconfig                         |   2 +
 arch/x86/boot/bitops.h                   |  40 ++++++++
 arch/x86/boot/compressed/Makefile        |   3 +-
 arch/x86/boot/compressed/align.h         |  14 +++
 arch/x86/boot/compressed/bitmap.c        |  43 ++++++++
 arch/x86/boot/compressed/bitmap.h        |  49 +++++++++
 arch/x86/boot/compressed/bits.h          |  36 +++++++
 arch/x86/boot/compressed/efi.h           |   1 +
 arch/x86/boot/compressed/error.c         |  19 ++++
 arch/x86/boot/compressed/error.h         |   1 +
 arch/x86/boot/compressed/find.c          |  54 ++++++++++
 arch/x86/boot/compressed/find.h          |  79 +++++++++++++++
 arch/x86/boot/compressed/ident_map_64.c  |   8 --
 arch/x86/boot/compressed/kaslr.c         |  35 ++++---
 arch/x86/boot/compressed/math.h          |  37 +++++++
 arch/x86/boot/compressed/mem.c           | 122 ++++++++++++++++++++++
 arch/x86/boot/compressed/minmax.h        |  61 +++++++++++
 arch/x86/boot/compressed/misc.c          |   6 ++
 arch/x86/boot/compressed/misc.h          |  15 +++
 arch/x86/boot/compressed/pgtable_types.h |  25 +++++
 arch/x86/boot/compressed/sev.c           |   2 -
 arch/x86/boot/compressed/tdx-shared.c    |   2 +
 arch/x86/boot/compressed/tdx.c           |  39 +++++++
 arch/x86/coco/tdx/Makefile               |   2 +-
 arch/x86/coco/tdx/tdx-shared.c           |  95 +++++++++++++++++
 arch/x86/coco/tdx/tdx.c                  | 113 +--------------------
 arch/x86/include/asm/kexec.h             |   5 +
 arch/x86/include/asm/page.h              |   3 +
 arch/x86/include/asm/shared/tdx.h        |  48 +++++++++
 arch/x86/include/asm/tdx.h               |  21 +---
 arch/x86/include/asm/unaccepted_memory.h |  16 +++
 arch/x86/include/uapi/asm/bootparam.h    |   2 +-
 arch/x86/kernel/e820.c                   |  17 ++++
 arch/x86/mm/Makefile                     |   2 +
 arch/x86/mm/unaccepted_memory.c          | 123 +++++++++++++++++++++++
 drivers/base/node.c                      |   7 ++
 drivers/firmware/efi/Kconfig             |  14 +++
 drivers/firmware/efi/efi.c               |   1 +
 drivers/firmware/efi/libstub/x86-stub.c  | 101 ++++++++++++++++---
 fs/proc/meminfo.c                        |   5 +
 include/linux/efi.h                      |   3 +-
 include/linux/kexec.h                    |   7 ++
 include/linux/mmzone.h                   |   8 ++
 include/linux/page-flags.h               |  24 +++++
 kernel/kexec.c                           |   4 +
 kernel/kexec_file.c                      |   4 +
 mm/internal.h                            |  12 +++
 mm/memblock.c                            |   9 ++
 mm/page_alloc.c                          | 121 ++++++++++++++++++++++
 mm/vmstat.c                              |   1 +
 51 files changed, 1291 insertions(+), 171 deletions(-)
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
2.38.0

