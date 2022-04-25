Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B69F50D7A5
	for <lists+linux-efi@lfdr.de>; Mon, 25 Apr 2022 05:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240682AbiDYDmr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 24 Apr 2022 23:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240680AbiDYDmq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 24 Apr 2022 23:42:46 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F416D2F01A;
        Sun, 24 Apr 2022 20:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650857981; x=1682393981;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YE2m7vjbBEAvaTYRxGOmnaa0fOqIRylP+ci0sDothHE=;
  b=b1k6Rs8EP7ks94me+l53+2ANDCVpbbR312wcaa8qim8btbFWaGULT1+S
   JdJhjLWU+v/q1O2N0jzAhViS/9MLaD3WAh9DaP8eE84Tq11irl7TWqBDG
   3MPFlLepza8OpZSmWNzZrCFTw0ycLaWtPdX4e0jsxcZiRHqZkI3L4+wIv
   1Lw8JHX5X5jVaDfgMiekwvixSlQpmOurOECDsBZPIE/BM77buA2LhuSKo
   LwbzVrbU3BLCHwUGESoOP9fNYwlXwKrNfkOtHTFgIoYnxl/EO83NcDcul
   KL7cTaYmS6xgHwzooyFSTpKeATXbkKMcF4BKfxhZPYhC+tVoSCePaJQLI
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="245055670"
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="245055670"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2022 20:39:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="563911364"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 24 Apr 2022 20:39:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 7E6D1120; Mon, 25 Apr 2022 06:39:35 +0300 (EEST)
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
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv5 00/12] mm, x86/cc: Implement support for unaccepted memory
Date:   Mon, 25 Apr 2022 06:39:22 +0300
Message-Id: <20220425033934.68551-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
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

https://github.com/intel/tdx.git guest-unaccepted-memory

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

Kirill A. Shutemov (12):
  x86/boot/: Centralize __pa()/__va() definitions
  mm: Add support for unaccepted memory
  efi/x86: Get full memory map in allocate_e820()
  x86/boot: Add infrastructure required for unaccepted memory support
  efi/x86: Implement support for unaccepted memory
  x86/boot/compressed: Handle unaccepted memory
  x86/mm: Reserve unaccepted memory bitmap
  x86/mm: Provide helpers for unaccepted memory
  x86/tdx: Make _tdx_hypercall() and __tdx_module_call() available in
    boot stub
  x86/tdx: Unaccepted memory support
  mm/vmstat: Add counter for memory accepting
  x86/mm: Report unaccepted memory in /proc/meminfo

 Documentation/x86/zero-page.rst          |   1 +
 arch/x86/Kconfig                         |   1 +
 arch/x86/boot/bitops.h                   |  40 ++++++++
 arch/x86/boot/compressed/Makefile        |   1 +
 arch/x86/boot/compressed/align.h         |  14 +++
 arch/x86/boot/compressed/bitmap.c        |  43 +++++++++
 arch/x86/boot/compressed/bitmap.h        |  49 ++++++++++
 arch/x86/boot/compressed/bits.h          |  36 ++++++++
 arch/x86/boot/compressed/compiler.h      |   9 ++
 arch/x86/boot/compressed/find.c          |  54 +++++++++++
 arch/x86/boot/compressed/find.h          |  80 ++++++++++++++++
 arch/x86/boot/compressed/ident_map_64.c  |   8 --
 arch/x86/boot/compressed/kaslr.c         |  14 ++-
 arch/x86/boot/compressed/math.h          |  37 ++++++++
 arch/x86/boot/compressed/mem.c           | 111 +++++++++++++++++++++++
 arch/x86/boot/compressed/minmax.h        |  61 +++++++++++++
 arch/x86/boot/compressed/misc.c          |   9 ++
 arch/x86/boot/compressed/misc.h          |   9 ++
 arch/x86/boot/compressed/sev.c           |   2 -
 arch/x86/boot/compressed/tdx.c           |  85 +++++++++++++++++
 arch/x86/coco/tdx/tdx.c                  |  57 +++++-------
 arch/x86/include/asm/page.h              |   3 +
 arch/x86/include/asm/set_memory.h        |   2 +
 arch/x86/include/asm/shared/tdx.h        |  47 ++++++++++
 arch/x86/include/asm/tdx.h               |  19 ----
 arch/x86/include/asm/unaccepted_memory.h |  25 +++++
 arch/x86/include/uapi/asm/bootparam.h    |   2 +-
 arch/x86/kernel/e820.c                   |  10 ++
 arch/x86/mm/Makefile                     |   2 +
 arch/x86/mm/init.c                       |   8 ++
 arch/x86/mm/pat/set_memory.c             |   2 +-
 arch/x86/mm/unaccepted_memory.c          |  98 ++++++++++++++++++++
 drivers/firmware/efi/Kconfig             |  15 +++
 drivers/firmware/efi/efi.c               |   1 +
 drivers/firmware/efi/libstub/x86-stub.c  |  97 +++++++++++++++++---
 include/linux/efi.h                      |   3 +-
 include/linux/page-flags.h               |  31 +++++++
 include/linux/vm_event_item.h            |   3 +
 mm/internal.h                            |  11 +++
 mm/memblock.c                            |   9 ++
 mm/page_alloc.c                          |  77 +++++++++++++++-
 mm/vmstat.c                              |   3 +
 42 files changed, 1103 insertions(+), 86 deletions(-)
 create mode 100644 arch/x86/boot/compressed/align.h
 create mode 100644 arch/x86/boot/compressed/bitmap.c
 create mode 100644 arch/x86/boot/compressed/bitmap.h
 create mode 100644 arch/x86/boot/compressed/bits.h
 create mode 100644 arch/x86/boot/compressed/compiler.h
 create mode 100644 arch/x86/boot/compressed/find.c
 create mode 100644 arch/x86/boot/compressed/find.h
 create mode 100644 arch/x86/boot/compressed/math.h
 create mode 100644 arch/x86/boot/compressed/mem.c
 create mode 100644 arch/x86/boot/compressed/minmax.h
 create mode 100644 arch/x86/include/asm/unaccepted_memory.h
 create mode 100644 arch/x86/mm/unaccepted_memory.c

-- 
2.35.1

