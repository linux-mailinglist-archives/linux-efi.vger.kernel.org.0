Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A060654ACC0
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jun 2022 11:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242202AbiFNJBQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Jun 2022 05:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242481AbiFNJBO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Jun 2022 05:01:14 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212682C117;
        Tue, 14 Jun 2022 02:01:14 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LMj6V5WpdzgZCJ;
        Tue, 14 Jun 2022 16:59:14 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 14 Jun 2022 17:00:38 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 14 Jun 2022 17:00:36 +0800
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
        <linux-mm@kvack.org>, <linux-riscv@lists.infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v5 2/5] mm: Ratelimited mirrored memory related warning messages
Date:   Tue, 14 Jun 2022 17:21:53 +0800
Message-ID: <20220614092156.1972846-3-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220614092156.1972846-1-mawupeng1@huawei.com>
References: <20220614092156.1972846-1-mawupeng1@huawei.com>
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

If system has mirrored memory, memblock will try to allocate mirrored
memory firstly and fallback to non-mirrored memory when fails, but if with
limited mirrored memory or some numa node without mirrored memory, lots of
warning message about memblock allocation will occur.

This patch ratelimit the warning message to avoid a very long print during
bootup.

Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
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
2.25.1

