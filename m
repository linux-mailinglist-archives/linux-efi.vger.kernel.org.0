Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D864500A9A
	for <lists+linux-efi@lfdr.de>; Thu, 14 Apr 2022 11:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242096AbiDNJ5X (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 14 Apr 2022 05:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242089AbiDNJ5M (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 14 Apr 2022 05:57:12 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0506418376;
        Thu, 14 Apr 2022 02:54:41 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KfF7c0sJlzCqxc;
        Thu, 14 Apr 2022 17:50:20 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Apr 2022 17:54:39 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Apr 2022 17:54:37 +0800
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
Subject: [PATCH v2 8/9] efi: Disable mirror feature if kernelcore is not specified
Date:   Thu, 14 Apr 2022 18:13:13 +0800
Message-ID: <20220414101314.1250667-9-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20220414101314.1250667-1-mawupeng1@huawei.com>
References: <20220414101314.1250667-1-mawupeng1@huawei.com>
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

With this patch, kernel will check mirrored_kernelcore before calling
efi_find_mirror() which will enable basic mirrored feature.

If system have some mirrored memory and mirrored feature is not specified
in boot parameter, the basic mirrored feature will be enabled and this will
lead to the following situations:

- memblock memory allocation perfers mirrored region. This may have some
  unexpected influence on numa affinity.

- contiguous memory will be splited into several parts if parts of them
  is mirrored memory via memblock_mark_mirror().

Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
---
 drivers/firmware/efi/efi.c | 3 +++
 include/linux/mm.h         | 2 ++
 mm/page_alloc.c            | 2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index eb9ebf4efea1..18d86602424a 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -446,6 +446,9 @@ void __init efi_find_mirror(void)
 	if (!efi_enabled(EFI_MEMMAP))
 		return;
 
+	if (!mirrored_kernelcore)
+		return;
+
 	for_each_efi_memory_desc(md) {
 		unsigned long long start = md->phys_addr;
 		unsigned long long size = md->num_pages << EFI_PAGE_SHIFT;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index e34edb775334..544717cc7a75 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2536,6 +2536,8 @@ extern void get_pfn_range_for_nid(unsigned int nid,
 			unsigned long *start_pfn, unsigned long *end_pfn);
 extern unsigned long find_min_pfn_with_active_regions(void);
 
+extern bool mirrored_kernelcore;
+
 #ifndef CONFIG_NUMA
 static inline int early_pfn_to_nid(unsigned long pfn)
 {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 570d0ebf98df..909d5f7d97bb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -355,7 +355,7 @@ static unsigned long required_kernelcore_percent __initdata;
 static unsigned long required_movablecore __initdata;
 static unsigned long required_movablecore_percent __initdata;
 static unsigned long zone_movable_pfn[MAX_NUMNODES] __initdata;
-static bool mirrored_kernelcore __meminitdata;
+bool mirrored_kernelcore __meminitdata;
 
 /* movable_zone is the "real" zone pages in ZONE_MOVABLE are taken from */
 int movable_zone;
-- 
2.18.0.huawei.25

