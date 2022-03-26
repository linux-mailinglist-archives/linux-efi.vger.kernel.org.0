Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4284E7F59
	for <lists+linux-efi@lfdr.de>; Sat, 26 Mar 2022 07:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbiCZG3M (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 26 Mar 2022 02:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiCZG3M (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 26 Mar 2022 02:29:12 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC58127B;
        Fri, 25 Mar 2022 23:27:34 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KQTVY1fcfzfZgr;
        Sat, 26 Mar 2022 14:25:57 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 26 Mar 2022 14:27:32 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 26 Mar 2022 14:27:31 +0800
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
Subject: [PATCH 0/9] introduce mirrored memory support for arm64
Date:   Sat, 26 Mar 2022 14:46:23 +0800
Message-ID: <20220326064632.131637-1-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

Arm64 can support this too. So mirrored memory support is added to support
arm64.

Patch #1-#2 introduce efi_fake_mem support for arm64.
Patch #3-#4 introduce mirrored memory support form arm64.
Patch #5-#7 fix some bugs for arm64 if memory reliable is enabled.
Patch #8 disable mirror feature if kernelcore is not specified.
Patch #9 remove some redundant code in ia64 efi_init.

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

