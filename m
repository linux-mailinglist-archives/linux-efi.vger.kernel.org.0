Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0D3500A74
	for <lists+linux-efi@lfdr.de>; Thu, 14 Apr 2022 11:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241445AbiDNJ47 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 14 Apr 2022 05:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbiDNJ45 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 14 Apr 2022 05:56:57 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F86CEA;
        Thu, 14 Apr 2022 02:54:30 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KfF9Z22C9zFpvV;
        Thu, 14 Apr 2022 17:52:02 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Apr 2022 17:54:28 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Apr 2022 17:54:26 +0800
From:   Wupeng Ma <mawupeng1@huawei.com>
To:     <akpm@linux-foundation.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <corbet@lwn.net>
CC:     <ardb@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <hpa@zyccr.com>, <dvhart@infradead.org>, <andy@infradead.org>,
        <rppt@kernel.org>, <paulmck@kernel.org>, <peterz@infradead.org>,
        <jroedel@suse.de>, <songmuchun@bytedance.com>, <macro@orcam.me.uk>,
        <frederic@kernel.org>, <W_Armin@gmx.de>, <john.garry@huawei.com>,
        <seanjc@google.com>, <tsbogend@alpha.franken.de>,
        <anshuman.khandual@arm.com>, <chenhuacai@kernel.org>,
        <david@redhat.com>, <gpiccoli@igalia.com>, <mark.rutland@arm.com>,
        <wangkefeng.wang@huawei.com>, <mawupeng1@huawei.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-efi@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH v2 0/9] introduce mirrored memory support for arm64
Date:   Thu, 14 Apr 2022 18:13:05 +0800
Message-ID: <20220414101314.1250667-1-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Arm64 can support this too. So mirrored memory support is added to support
arm64.

Efi_fake_mem is used for testing mirrored features and will not be used in
production environment. This test features can fake memory's attribute
values.

The reason why efi_fake_mem support is put first is that memory's attribute
is reported by BIOS which is hard to simulate. With this support, any arm64
machines with efi support can easily test mirrored features.

The main purpose of this patchset is to introduce mirrored support for
arm64 and we have already fixed the problems we had which is shown in
patch #5 to patch #7 and try to bring total isolation in patch #8 which
will disable mirror feature if kernelcore is not specified.

In order to test this support in arm64:
- patch this patchset
- add efi_fake_mem=8G@0:0x10000 in kernel parameter to simulate mirrored
  memroy between phy addr 0-8G.
- add kernelcore=mirror in kernel parameter
- start you kernel

Patch #1-#2 introduce efi_fake_mem support for arm64.
Patch #3-#4 introduce mirrored memory support form arm64.
Patch #5-#7 fix some bugs for arm64 if memory reliable is enabled.
Patch #8 disable mirror feature if kernelPHYS_PFNcore is not specified.
Patch #9 remove some redundant code in ia64 efi_init.

Changelog since v1:
- update changelog in cover letter
- use PHYS_PFN in patch #7 

Ma Wupeng (9):
  efi: Make efi_print_memmap() public
  arm64: efi: Add fake memory support
  efi: Make efi_find_mirror() public
  arm64/mirror: arm64 enabling - find mirrored memory ranges
  mm: Ratelimited mirrored memory related warning messages
  mm: Demote warning message in vmemmap_verify() to debug level
  mm: Calc the right pfn if page size is not 4K
  efi: Disable mirror feature if kernelcore is not specified
  ia64/efi: Code simplification in efi_init

 .../admin-guide/kernel-parameters.txt         |  4 +-
 arch/arm64/kernel/setup.c                     |  3 ++
 arch/ia64/kernel/efi.c                        | 37 +-----------------
 arch/x86/include/asm/efi.h                    |  5 ---
 arch/x86/platform/efi/efi.c                   | 39 -------------------
 drivers/firmware/efi/Kconfig                  |  2 +-
 drivers/firmware/efi/efi.c                    | 26 +++++++++++++
 drivers/firmware/efi/memmap.c                 | 16 ++++++++
 include/linux/efi.h                           |  4 ++
 include/linux/mm.h                            |  2 +
 mm/memblock.c                                 |  4 +-
 mm/page_alloc.c                               |  4 +-
 mm/sparse-vmemmap.c                           |  2 +-
 13 files changed, 60 insertions(+), 88 deletions(-)

-- 
2.18.0.huawei.25

