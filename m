Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81EE48AC7E
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jan 2022 12:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349522AbiAKLdN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 11 Jan 2022 06:33:13 -0500
Received: from mga03.intel.com ([134.134.136.65]:45407 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349477AbiAKLdN (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 11 Jan 2022 06:33:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641900793; x=1673436793;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PYSoQ6fOmg24GZrM6oddDOb8F96ELYtu5wYu0sHkD1Y=;
  b=C/JydEO4Hb9yzIkQ7uKbgSrXwVu2NoNxDwaKLKpHrDP4cW+03Ov4XcFN
   jpvVX+fm9ryrsI7tC/qkwBj6rQtEkWY+ODHkFwmBTdNGozI/MiwHz7ghT
   DP/qR8F7ERTDua5K9wmQjnwN1rtS5mfvjdlP/WSJaAfjIwnEv0GTjZHiB
   MtmpQkqRFYV1XM06w5InOnv1VmepaCRPLq89NvJkMxD9tpqg6drMwaZ65
   BesG6k/6+nvpVN14IAP8lu1HjRj9eISSHNvyePhJFCI20wH7uD6U4HDgF
   4RxBlRwH97PoyqVraLfYFuU+a43oiXfa852f5tEk/ZJEBySM91ZAKaosU
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="243419233"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="243419233"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 03:33:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="515063269"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 11 Jan 2022 03:33:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 1015C16B; Tue, 11 Jan 2022 13:33:18 +0200 (EET)
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
        Dario Faggioli <dfaggioli@suse.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 0/7] Implement support for unaccepted memory
Date:   Tue, 11 Jan 2022 14:33:07 +0300
Message-Id: <20220111113314.27173-1-kirill.shutemov@linux.intel.com>
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
 arch/x86/boot/compressed/misc.c              |  9 ++
 arch/x86/boot/compressed/tdx.c               | 67 ++++++++++++++
 arch/x86/boot/compressed/unaccepted_memory.c | 64 +++++++++++++
 arch/x86/include/asm/page.h                  |  5 ++
 arch/x86/include/asm/tdx.h                   |  2 +
 arch/x86/include/asm/unaccepted_memory.h     | 17 ++++
 arch/x86/include/uapi/asm/bootparam.h        |  3 +-
 arch/x86/kernel/e820.c                       | 10 +++
 arch/x86/kernel/tdx.c                        |  7 ++
 arch/x86/mm/Makefile                         |  2 +
 arch/x86/mm/unaccepted_memory.c              | 94 ++++++++++++++++++++
 drivers/firmware/efi/Kconfig                 | 14 +++
 drivers/firmware/efi/efi.c                   |  1 +
 drivers/firmware/efi/libstub/x86-stub.c      | 86 ++++++++++++++----
 include/linux/efi.h                          |  3 +-
 include/linux/page-flags.h                   |  4 +
 mm/internal.h                                | 15 ++++
 mm/memblock.c                                |  1 +
 mm/page_alloc.c                              | 21 ++++-
 24 files changed, 508 insertions(+), 20 deletions(-)
 create mode 100644 arch/x86/boot/compressed/bitmap.c
 create mode 100644 arch/x86/boot/compressed/unaccepted_memory.c
 create mode 100644 arch/x86/include/asm/unaccepted_memory.h
 create mode 100644 arch/x86/mm/unaccepted_memory.c

-- 
2.34.1

