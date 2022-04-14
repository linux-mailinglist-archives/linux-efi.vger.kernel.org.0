Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB08F500A8A
	for <lists+linux-efi@lfdr.de>; Thu, 14 Apr 2022 11:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242103AbiDNJ5M (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 14 Apr 2022 05:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242008AbiDNJ5D (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 14 Apr 2022 05:57:03 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50CC120BE;
        Thu, 14 Apr 2022 02:54:36 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KfFBN63JSzgYlp;
        Thu, 14 Apr 2022 17:52:44 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Apr 2022 17:54:34 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Apr 2022 17:54:33 +0800
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
Subject: [PATCH v2 5/9] mm: Ratelimited mirrored memory related warning messages
Date:   Thu, 14 Apr 2022 18:13:10 +0800
Message-ID: <20220414101314.1250667-6-mawupeng1@huawei.com>
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

If system has mirrored memory, memblock will try to allocate mirrored
memory firstly and fallback to non-mirrored memory when fails, but if with
limited mirrored memory or some numa node without mirrored memory, lots of
warning message about memblock allocation will occur.

This patch ratelimit the warning message to avoid a very long print during
bootup.

Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
---
 mm/memblock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index e4f03a6e8e56..b1d2a0009733 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -327,7 +327,7 @@ static phys_addr_t __init_memblock memblock_find_in_range(phys_addr_t start,
 					    NUMA_NO_NODE, flags);
 
 	if (!ret && (flags & MEMBLOCK_MIRROR)) {
-		pr_warn("Could not allocate %pap bytes of mirrored memory\n",
+		pr_warn_ratelimited("Could not allocate %pap bytes of mirrored memory\n",
 			&size);
 		flags &= ~MEMBLOCK_MIRROR;
 		goto again;
@@ -1384,7 +1384,7 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
 
 	if (flags & MEMBLOCK_MIRROR) {
 		flags &= ~MEMBLOCK_MIRROR;
-		pr_warn("Could not allocate %pap bytes of mirrored memory\n",
+		pr_warn_ratelimited("Could not allocate %pap bytes of mirrored memory\n",
 			&size);
 		goto again;
 	}
-- 
2.18.0.huawei.25

