Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF1A53F959
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jun 2022 11:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239240AbiFGJQ6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Jun 2022 05:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239236AbiFGJQz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Jun 2022 05:16:55 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4978215D;
        Tue,  7 Jun 2022 02:16:52 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LHPqj4SWXzpXwZ;
        Tue,  7 Jun 2022 17:16:33 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 7 Jun 2022 17:16:51 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 7 Jun 2022 17:16:49 +0800
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
        <geert@linux-m68k.org>, <chenzhou10@huawei.com>,
        <vijayb@linux.microsoft.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-efi@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH v3 5/6] mm: Add mirror flag back on initrd memory
Date:   Tue, 7 Jun 2022 17:38:04 +0800
Message-ID: <20220607093805.1354256-6-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220607093805.1354256-1-mawupeng1@huawei.com>
References: <20220607093805.1354256-1-mawupeng1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Initrd memory will be removed and then added in arm64_memblock_init() and this
will cause it to lose all of its memblock flags. The lost of MEMBLOCK_MIRROR
flag will lead to error log printed by find_zone_movable_pfns_for_nodes if
the lower 4G range has some non-mirrored memory.

In order to solve this problem, the lost MEMBLOCK_MIRROR flag will be
reinstalled if the origin memblock has this flag.

Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
---
 arch/arm64/mm/init.c     |  9 +++++++++
 include/linux/memblock.h |  1 +
 mm/memblock.c            | 20 ++++++++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 339ee84e5a61..11641f924d08 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -350,9 +350,18 @@ void __init arm64_memblock_init(void)
 			"initrd not fully accessible via the linear mapping -- please check your bootloader ...\n")) {
 			phys_initrd_size = 0;
 		} else {
+			int flags, ret;
+
+			ret = memblock_get_flags(base, &flags);
+			if (ret)
+				flags = 0;
+
 			memblock_remove(base, size); /* clear MEMBLOCK_ flags */
 			memblock_add(base, size);
 			memblock_reserve(base, size);
+
+			if (flags & MEMBLOCK_MIRROR)
+				memblock_mark_mirror(base, size);
 		}
 	}
 
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 50ad19662a32..3d6a382ac9c8 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -487,6 +487,7 @@ bool memblock_is_map_memory(phys_addr_t addr);
 bool memblock_is_region_memory(phys_addr_t base, phys_addr_t size);
 bool memblock_is_reserved(phys_addr_t addr);
 bool memblock_is_region_reserved(phys_addr_t base, phys_addr_t size);
+int memblock_get_flags(phys_addr_t base, int *flags);
 
 void memblock_dump_all(void);
 
diff --git a/mm/memblock.c b/mm/memblock.c
index b1d2a0009733..0c5b5699af6e 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1796,6 +1796,26 @@ int __init_memblock memblock_search_pfn_nid(unsigned long pfn,
 	return memblock_get_region_node(&type->regions[mid]);
 }
 
+/**
+ * memblock_get_flags - get a single memblock flags
+ * @base: base of memeblock to get
+ *
+ * Get the flags of memeblock with base: @base
+ *
+ * Return:
+ * 0 if ok, non-zero if fail
+ */
+int __init_memblock memblock_get_flags(phys_addr_t base, int *flags)
+{
+	int idx = memblock_search(&memblock.memory, base);
+
+	if (idx == -1)
+		return -EINVAL;
+
+	*flags = memblock.memory.regions[idx].flags;
+	return 0;
+}
+
 /**
  * memblock_is_region_memory - check if a region is a subset of memory
  * @base: base of region to check
-- 
2.25.1

