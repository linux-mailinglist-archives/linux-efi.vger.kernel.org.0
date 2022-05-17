Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76B752A6DC
	for <lists+linux-efi@lfdr.de>; Tue, 17 May 2022 17:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347502AbiEQPfH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 May 2022 11:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350039AbiEQPfE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 May 2022 11:35:04 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4974132D;
        Tue, 17 May 2022 08:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652801703; x=1684337703;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dQmG2pBx6efTJZuUSuJPwLK2pMKYkkt2bP5q7lj134c=;
  b=mTxRumeBfcGehnqj1vi9VexBvo91RtNVxQKL9Zr3BhWkELcY7bLenvyW
   TmEWbBR5fiNKU2HIF8/35o3v+MLoEFcfAVtuCMVHqod3zhSHyfl+rt9mV
   t9uq7khN0TL0kvxR6QWns5y+XFOx6Q3eqImMa6Q+vVrJGbXm6DxqUu264
   JKtHF2KA+wurr+Wl+vVZtt5anDDvNRuYdOKaPWSUaEiBQE54ox/6o017L
   agp+sS8LIxxENBzLEQ2Yn/VJMBOx0E0IwXzKx+Es6a9uDPLEj2vxJA+JW
   ioykPoHopERXben9LIfN5NMUivY/czS4ZRa5yWORFm5BWKlTQQqWG491p
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="271167668"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="271167668"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 08:34:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="713901584"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 17 May 2022 08:34:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 48B97159; Tue, 17 May 2022 18:34:50 +0300 (EEST)
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
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        x86@kernel.org, linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv6 00/15] mm, x86/cc: Implement support for unaccepted memory
Date:   Tue, 17 May 2022 18:34:29 +0300
Message-Id: <20220517153444.11195-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
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

The tree can be found here:

https://github.com/intel/tdx.git guest-unaccepted-memory

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
Kirill A. Shutemov (15):
  x86/boot: Centralize __pa()/__va() definitions
  mm: Add support for unaccepted memory
  efi/x86: Get full memory map in allocate_e820()
  x86/boot: Add infrastructure required for unaccepted memory support
  efi/x86: Implement support for unaccepted memory
  x86/boot/compressed: Handle unaccepted memory
  x86/mm: Reserve unaccepted memory bitmap
  x86/mm: Provide helpers for unaccepted memory
  x86/mm: Avoid load_unaligned_zeropad() stepping into unaccepted memory
  x86/mm: Report unaccepted memory in /proc/meminfo
  x86: Disable kexec if system has unaccepted memory
  x86/tdx: Make _tdx_hypercall() and __tdx_module_call() available in
    boot stub
  x86/tdx: Refactor try_accept_one()
  x86/tdx: Add unaccepted memory support
  mm/vmstat: Add counter for memory accepting

 Documentation/x86/zero-page.rst          |   1 +
 arch/x86/Kconfig                         |   1 +
 arch/x86/boot/bitops.h                   |  40 +++++++
 arch/x86/boot/compressed/Makefile        |   1 +
 arch/x86/boot/compressed/align.h         |  14 +++
 arch/x86/boot/compressed/bitmap.c        |  43 +++++++
 arch/x86/boot/compressed/bitmap.h        |  49 ++++++++
 arch/x86/boot/compressed/bits.h          |  36 ++++++
 arch/x86/boot/compressed/compiler.h      |   9 ++
 arch/x86/boot/compressed/efi.h           |   1 +
 arch/x86/boot/compressed/find.c          |  54 +++++++++
 arch/x86/boot/compressed/find.h          |  80 +++++++++++++
 arch/x86/boot/compressed/ident_map_64.c  |   8 --
 arch/x86/boot/compressed/kaslr.c         |  35 ++++--
 arch/x86/boot/compressed/math.h          |  37 ++++++
 arch/x86/boot/compressed/mem.c           | 111 +++++++++++++++++
 arch/x86/boot/compressed/minmax.h        |  61 ++++++++++
 arch/x86/boot/compressed/misc.c          |   6 +
 arch/x86/boot/compressed/misc.h          |  15 +++
 arch/x86/boot/compressed/pgtable_types.h |  25 ++++
 arch/x86/boot/compressed/sev.c           |   2 -
 arch/x86/boot/compressed/tdx.c           |  78 ++++++++++++
 arch/x86/coco/tdx/tdx.c                  |  94 +++++++--------
 arch/x86/include/asm/page.h              |   3 +
 arch/x86/include/asm/set_memory.h        |   2 +
 arch/x86/include/asm/shared/tdx.h        |  47 ++++++++
 arch/x86/include/asm/tdx.h               |  19 ---
 arch/x86/include/asm/unaccepted_memory.h |  25 ++++
 arch/x86/include/uapi/asm/bootparam.h    |   2 +-
 arch/x86/kernel/e820.c                   |  10 ++
 arch/x86/mm/Makefile                     |   2 +
 arch/x86/mm/init.c                       |   8 ++
 arch/x86/mm/pat/set_memory.c             |   2 +-
 arch/x86/mm/unaccepted_memory.c          | 144 +++++++++++++++++++++++
 drivers/firmware/efi/Kconfig             |  14 +++
 drivers/firmware/efi/efi.c               |   1 +
 drivers/firmware/efi/libstub/x86-stub.c  | 103 +++++++++++++---
 include/linux/efi.h                      |   3 +-
 include/linux/page-flags.h               |  31 +++++
 include/linux/vm_event_item.h            |   3 +
 mm/internal.h                            |  12 ++
 mm/memblock.c                            |   9 ++
 mm/page_alloc.c                          |  87 +++++++++++++-
 mm/vmstat.c                              |   3 +
 44 files changed, 1215 insertions(+), 116 deletions(-)
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
 create mode 100644 arch/x86/boot/compressed/pgtable_types.h
 create mode 100644 arch/x86/include/asm/unaccepted_memory.h
 create mode 100644 arch/x86/mm/unaccepted_memory.c

-- 
2.35.1

