Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF14500A92
	for <lists+linux-efi@lfdr.de>; Thu, 14 Apr 2022 11:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbiDNJ5N (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 14 Apr 2022 05:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242046AbiDNJ5E (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 14 Apr 2022 05:57:04 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AA614018;
        Thu, 14 Apr 2022 02:54:39 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KfF9m0WzxzFprV;
        Thu, 14 Apr 2022 17:52:12 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Apr 2022 17:54:37 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Apr 2022 17:54:36 +0800
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
Subject: [PATCH v2 7/9] mm: Calc the right pfn if page size is not 4K
Date:   Thu, 14 Apr 2022 18:13:12 +0800
Message-ID: <20220414101314.1250667-8-mawupeng1@huawei.com>
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

Previous 0x100000 is used to check the 4G limit in
find_zone_movable_pfns_for_nodes(). This is right in x86 because
the page size can only be 4K. But 16K and 64K are available in
arm64. So replace it with PHYS_PFN(SZ_4G).

Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6e5b4488a0c5..570d0ebf98df 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7870,7 +7870,7 @@ static void __init find_zone_movable_pfns_for_nodes(void)
 
 			usable_startpfn = memblock_region_memory_base_pfn(r);
 
-			if (usable_startpfn < 0x100000) {
+			if (usable_startpfn < PHYS_PFN(SZ_4G)) {
 				mem_below_4gb_not_mirrored = true;
 				continue;
 			}
-- 
2.18.0.huawei.25

