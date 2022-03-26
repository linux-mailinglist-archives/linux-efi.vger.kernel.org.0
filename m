Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB264E7F7A
	for <lists+linux-efi@lfdr.de>; Sat, 26 Mar 2022 07:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbiCZG36 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 26 Mar 2022 02:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiCZG3z (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 26 Mar 2022 02:29:55 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32BE171EE5;
        Fri, 25 Mar 2022 23:27:47 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KQTXP3XcCzcbQS;
        Sat, 26 Mar 2022 14:27:33 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 26 Mar 2022 14:27:45 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 26 Mar 2022 14:27:44 +0800
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
Subject: [PATCH 9/9] ia64/efi: Code simplification in efi_init
Date:   Sat, 26 Mar 2022 14:46:32 +0800
Message-ID: <20220326064632.131637-10-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20220326064632.131637-1-mawupeng1@huawei.com>
References: <20220326064632.131637-1-mawupeng1@huawei.com>
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

Since efi_print_memmap() was made public, print EFI memory map in
efi_init() can be simplified by using efi_print_memmap().

Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
---
 arch/ia64/kernel/efi.c | 37 +------------------------------------
 1 file changed, 1 insertion(+), 36 deletions(-)

diff --git a/arch/ia64/kernel/efi.c b/arch/ia64/kernel/efi.c
index 31149e41f9be..4b8209b8797d 100644
--- a/arch/ia64/kernel/efi.c
+++ b/arch/ia64/kernel/efi.c
@@ -557,42 +557,7 @@ efi_init (void)
 
 #if EFI_DEBUG
 	/* print EFI memory map: */
-	{
-		efi_memory_desc_t *md;
-		void *p;
-		unsigned int i;
-
-		for (i = 0, p = efi_map_start; p < efi_map_end;
-		     ++i, p += efi_desc_size)
-		{
-			const char *unit;
-			unsigned long size;
-			char buf[64];
-
-			md = p;
-			size = md->num_pages << EFI_PAGE_SHIFT;
-
-			if ((size >> 40) > 0) {
-				size >>= 40;
-				unit = "TB";
-			} else if ((size >> 30) > 0) {
-				size >>= 30;
-				unit = "GB";
-			} else if ((size >> 20) > 0) {
-				size >>= 20;
-				unit = "MB";
-			} else {
-				size >>= 10;
-				unit = "KB";
-			}
-
-			printk("mem%02d: %s "
-			       "range=[0x%016llx-0x%016llx) (%4lu%s)\n",
-			       i, efi_md_typeattr_format(buf, sizeof(buf), md),
-			       md->phys_addr,
-			       md->phys_addr + efi_md_size(md), size, unit);
-		}
-	}
+	efi_print_memmap();
 #endif
 
 	efi_map_pal_code();
-- 
2.18.0.huawei.25

