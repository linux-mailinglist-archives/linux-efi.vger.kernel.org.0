Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 306E04A0266
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 21:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242647AbiA1U7H (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 15:59:07 -0500
Received: from mga11.intel.com ([192.55.52.93]:37556 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241786AbiA1U7F (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Jan 2022 15:59:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643403545; x=1674939545;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yBU3sLS+Lgz2kPgXMhsfbKdvUBXEv9uGAAkeVU4p2WI=;
  b=XFM+newj4UBzbnXeHIuMwmBZb9v55IGgGMesFRW98pIWGyk2Yf+0LSV6
   y5/YJpME4iaqheZRZf7bg70JmHOfnWYgMo+9RBeEInsb3/LSAp1oh48V/
   VY7rBoIyxg6YmgJfnDbk8xAV0TEU15Nhqstm7pe15Na4ZJGOjh2OK41o9
   vxR8o7DqjGr1/kL4MR+BqoXKY8QD3ZVzwgzcqWM3Pwo7q/KQGofV7Zy16
   j0PFwBPgVPbgRJYGIgiZ/cCrK3YBd0MPbxuXl/GK0HQdHUq33Sr4K2gDh
   kMr+YDy5sDegYWh2aVND86G/Ttvnml59holXqdGyQwCM8+OY+y3Th4qen
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="244796840"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="244796840"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 12:59:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="564315491"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 28 Jan 2022 12:58:55 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 7CDD594; Fri, 28 Jan 2022 22:59:09 +0200 (EET)
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
Subject: [PATCHv3 0/7] Implement support for unaccepted memory
Date:   Fri, 28 Jan 2022 23:58:59 +0300
Message-Id: <20220128205906.27503-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

UEFI Specification version 2.9 introduces the concept of memory
acceptance: Some Virtual Machine platforms, such as Intel TDX or AMD
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

Patches 1-6/7 are generic and don't have any dependencies on TDX. They
should serve AMD SEV needs as well. TDX-specific code isolated in the
last patch. This patch requires the core TDX patchset which is currently
under review.

Kirill A. Shutemov (7):
  mm: Add support for unaccepted memory
  efi/x86: Get full memory map in allocate_e820()
  efi/x86: Implement support for unaccepted memory
  x86/boot/compressed: Handle unaccepted memory
  x86/mm: Reserve unaccepted memory bitmap
  x86/mm: Provide helpers for unaccepted memory
  x86/tdx: Unaccepted memory support

 Documentation/x86/zero-page.rst              |  1 +
 arch/x86/Kconfig                             |  1 +
 arch/x86/boot/compressed/Makefile            |  1 +
 arch/x86/boot/compressed/bitmap.c            | 86 ++++++++++++++++++
 arch/x86/boot/compressed/kaslr.c             | 14 ++-
 arch/x86/boot/compressed/misc.c              | 11 +++
 arch/x86/boot/compressed/tdx.c               | 27 ++++++
 arch/x86/boot/compressed/unaccepted_memory.c | 75 ++++++++++++++++
 arch/x86/include/asm/page.h                  |  5 ++
 arch/x86/include/asm/shared/tdx.h            | 21 +++++
 arch/x86/include/asm/tdx.h                   | 19 ----
 arch/x86/include/asm/unaccepted_memory.h     | 17 ++++
 arch/x86/include/uapi/asm/bootparam.h        |  3 +-
 arch/x86/kernel/e820.c                       | 10 +++
 arch/x86/kernel/tdx.c                        |  6 ++
 arch/x86/mm/Makefile                         |  2 +
 arch/x86/mm/unaccepted_memory.c              | 94 ++++++++++++++++++++
 drivers/firmware/efi/Kconfig                 | 15 ++++
 drivers/firmware/efi/efi.c                   |  1 +
 drivers/firmware/efi/libstub/x86-stub.c      | 88 ++++++++++++++----
 include/linux/efi.h                          |  3 +-
 include/linux/page-flags.h                   | 27 ++++++
 mm/internal.h                                | 15 ++++
 mm/memblock.c                                |  8 ++
 mm/page_alloc.c                              | 23 ++++-
 25 files changed, 534 insertions(+), 39 deletions(-)
 create mode 100644 arch/x86/boot/compressed/bitmap.c
 create mode 100644 arch/x86/boot/compressed/unaccepted_memory.c
 create mode 100644 arch/x86/include/asm/unaccepted_memory.h
 create mode 100644 arch/x86/mm/unaccepted_memory.c

-- 
2.34.1

