Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6134D54ACB2
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jun 2022 11:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238355AbiFNJBJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Jun 2022 05:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241913AbiFNJBI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Jun 2022 05:01:08 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CD827B37;
        Tue, 14 Jun 2022 02:01:06 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LMj4q5qWfzRhtq;
        Tue, 14 Jun 2022 16:57:47 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 14 Jun 2022 17:00:35 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 14 Jun 2022 17:00:33 +0800
From:   Wupeng Ma <mawupeng1@huawei.com>
To:     <corbet@lwn.net>, <will@kernel.org>, <ardb@kernel.org>,
        <catalin.marinas@arm.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <dvhart@infradead.org>, <andy@infradead.org>, <rppt@kernel.org>,
        <akpm@linux-foundation.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <paulmck@kernel.org>, <keescook@chromium.org>,
        <songmuchun@bytedance.com>, <rdunlap@infradead.org>,
        <damien.lemoal@opensource.wdc.com>, <swboyd@chromium.org>,
        <wei.liu@kernel.org>, <robin.murphy@arm.com>, <david@redhat.com>,
        <mawupeng1@huawei.com>, <anshuman.khandual@arm.com>,
        <thunder.leizhen@huawei.com>, <wangkefeng.wang@huawei.com>,
        <gpiccoli@igalia.com>, <chenhuacai@kernel.org>,
        <geert@linux-m68k.org>, <vijayb@linux.microsoft.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-efi@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH v5 0/5] introduce mirrored memory support for arm64
Date:   Tue, 14 Jun 2022 17:21:51 +0800
Message-ID: <20220614092156.1972846-1-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Ma Wupeng <mawupeng1@huawei.com>

Commit b05b9f5f9dcf ("x86, mirror: x86 enabling - find mirrored memory ranges")
introduced mirrored memory support for x86. This support rely on UEFI to
report mirrored memory address ranges.  See UEFI 2.5 spec pages 157-158:

  http://www.uefi.org/sites/default/files/resources/UEFI%202_5.pdf

Memory mirroring is a technique used to separate memory into two separate
channels, usually on a memory device, like a server. In memory mirroring,
one channel is copied to another to create redundancy. This method makes
input/output (I/O) registers and memory appear with more than one address
range because the same physical byte is accessible at more than one
address. Using memory mirroring, higher memory reliability and a higher
level of memory consolidation are possible.

These EFI memory regions have various attributes, and the "mirrored"
attribute is one of them. The physical memory region whose descriptors
in EFI memory map has EFI_MEMORY_MORE_RELIABLE attribute (bit: 16) are
mirrored. The address range mirroring feature of the kernel arranges such
mirrored regions into normal zones and other regions into movable zones.

Arm64 can support this too. So mirrored memory support is added to support
arm64.

The main purpose of this patch set is to introduce mirrored support for
arm64 and we have already fixed the problems we had which is shown in
patch #5 to patch #8 and try to bring total isolation in patch #9 which
will disable mirror feature if kernelcore is not specified.

In order to test this support in arm64:
- patch this patch set
- add kernelcore=mirror in kernel parameter
- start you kernel

Patch #1 introduce mirrored memory support form arm64.
Patch #2-#4 fix some bugs for arm64 if memory reliable is enabled.
Patch #5 disable mirror feature if kernelcore is not specified.

Thanks to Ard Biesheuvel's hard work [1], now kernel will perfer mirrored
memory if kaslr is enabled.

[1] https://lore.kernel.org/linux-arm-kernel/CAMj1kXEPVEzMgOM4+Yj6PxHA-jFuDOAUdDJSiSxy_XaP4P7LSw@mail.gmail.com/T/

Changelog since v4:
- merge the first two patches into one
- change __initdata to __initdata_memblock in patch #5

Changelog since v3:
- limit warning message in vmemmap_verify via pr_warn_once()
- only clear memblock_nomap flags rather than bring the mirrored flag back
- disable mirrored feature in memblock_mark_mirror()

Changelog since v2:
- remove efi_fake_mem support
- remove Commit ("remove some redundant code in ia64 efi_init") since
  efi_print_memmap() is not public
- add mirror flag back on initrd memory

Changelog since v1:
- update changelog in cover letter
- use PHYS_PFN in patch #7

Ma Wupeng (5):
  efi: arm64: Introduce ability to find mirrored memory ranges
  mm: Ratelimited mirrored memory related warning messages
  mm: Limit warning message in vmemmap_verify() to once
  arm64: mm: Only remove nomap flag for initrd
  memblock: Disable mirror feature if kernelcore is not specified

 arch/arm64/mm/init.c            |  2 +-
 arch/x86/include/asm/efi.h      |  4 ----
 arch/x86/platform/efi/efi.c     | 23 -----------------------
 drivers/firmware/efi/efi-init.c |  1 +
 drivers/firmware/efi/efi.c      | 23 +++++++++++++++++++++++
 include/linux/efi.h             |  3 +++
 mm/internal.h                   |  2 ++
 mm/memblock.c                   |  7 +++++--
 mm/page_alloc.c                 |  2 +-
 mm/sparse-vmemmap.c             |  2 +-
 10 files changed, 37 insertions(+), 32 deletions(-)

-- 
2.25.1

