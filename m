Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18D64F53C1
	for <lists+linux-efi@lfdr.de>; Wed,  6 Apr 2022 06:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443377AbiDFEGa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 6 Apr 2022 00:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1850026AbiDFCqv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 5 Apr 2022 22:46:51 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37B9293E7D;
        Tue,  5 Apr 2022 16:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649202520; x=1680738520;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tsti2G/5iL+RgXBI2ZibkXK3KW/Q8xOXVOQ6AV2zHjs=;
  b=iS9JyyzEN14fQGeyVuL5VnxLtsPYhQmpWQRYYb5DF8Y+7ilvbd8oWIt2
   1WTn/fYcB/lXV1gl2+b1Ibrzh4PcvsLe5RFAdi+wp2Dhttv+VXeqcSe9E
   jZbxjcrf1szfMIeB2nkkRkQdXJa6bIBoWpubZhQcRkS26jT5fnlwl04R/
   H9if96JC+q6vphBz/7IPSIdqs00/jqQGWsTF7MzPj/RHT7bwMQQ8iXV+S
   1XNH+ckNta6WBnr7H/f2j91GQt7xgejVBIdYnaxk68Q/dIHVeSiMYYejn
   32DbbuFKrNKyIcwcaF7/6iSqvzG7hzvMHCANfjvpeToNGzGENtI8oQzeG
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="261068996"
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="261068996"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 16:48:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="620560765"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 05 Apr 2022 16:48:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 78046132; Wed,  6 Apr 2022 02:43:47 +0300 (EEST)
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
Subject: [PATCHv4 0/8] mm, x86/cc: Implement support for unaccepted memory
Date:   Wed,  6 Apr 2022 02:43:35 +0300
Message-Id: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
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

Patches 1-6/7 are generic and don't have any dependencies on TDX. They
should serve AMD SEV needs as well. TDX-specific code isolated in the
last patch. This patch requires the core TDX patchset which is currently
under review.

v4:
 - PageBuddyUnaccepted() -> PageUnaccepted;
 - Use separate page_type, not shared with offline;
 - Rework interface between core-mm and arch code;
 - Adjust commit messages;
 - Ack from Mike;
Kirill A. Shutemov (8):
  mm: Add support for unaccepted memory
  efi/x86: Get full memory map in allocate_e820()
  efi/x86: Implement support for unaccepted memory
  x86/boot/compressed: Handle unaccepted memory
  x86/mm: Reserve unaccepted memory bitmap
  x86/mm: Provide helpers for unaccepted memory
  x86/tdx: Unaccepted memory support
  mm/vmstat: Add counter for memory accepting

 Documentation/x86/zero-page.rst              |  1 +
 arch/x86/Kconfig                             |  1 +
 arch/x86/boot/compressed/Makefile            |  1 +
 arch/x86/boot/compressed/bitmap.c            | 86 +++++++++++++++++++
 arch/x86/boot/compressed/kaslr.c             | 14 +++-
 arch/x86/boot/compressed/misc.c              | 11 +++
 arch/x86/boot/compressed/tdx.c               | 41 +++++++++
 arch/x86/boot/compressed/unaccepted_memory.c | 88 ++++++++++++++++++++
 arch/x86/coco/tdx/tdx.c                      | 29 +++++--
 arch/x86/include/asm/page.h                  |  5 ++
 arch/x86/include/asm/shared/tdx.h            | 20 +++++
 arch/x86/include/asm/tdx.h                   | 19 -----
 arch/x86/include/asm/unaccepted_memory.h     | 15 ++++
 arch/x86/include/uapi/asm/bootparam.h        |  3 +-
 arch/x86/kernel/e820.c                       | 10 +++
 arch/x86/mm/Makefile                         |  2 +
 arch/x86/mm/unaccepted_memory.c              | 58 +++++++++++++
 drivers/firmware/efi/Kconfig                 | 15 ++++
 drivers/firmware/efi/efi.c                   |  1 +
 drivers/firmware/efi/libstub/x86-stub.c      | 88 ++++++++++++++++----
 include/linux/efi.h                          |  3 +-
 include/linux/page-flags.h                   | 24 ++++++
 include/linux/vm_event_item.h                |  3 +
 mm/internal.h                                | 11 +++
 mm/memblock.c                                |  9 ++
 mm/page_alloc.c                              | 57 ++++++++++++-
 mm/vmstat.c                                  |  3 +
 27 files changed, 569 insertions(+), 49 deletions(-)
 create mode 100644 arch/x86/boot/compressed/bitmap.c
 create mode 100644 arch/x86/boot/compressed/unaccepted_memory.c
 create mode 100644 arch/x86/include/asm/unaccepted_memory.h
 create mode 100644 arch/x86/mm/unaccepted_memory.c

-- 
2.35.1

