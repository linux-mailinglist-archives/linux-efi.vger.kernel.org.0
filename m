Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BF1500A78
	for <lists+linux-efi@lfdr.de>; Thu, 14 Apr 2022 11:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241771AbiDNJ47 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 14 Apr 2022 05:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiDNJ45 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 14 Apr 2022 05:56:57 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580B32DE6;
        Thu, 14 Apr 2022 02:54:31 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KfF9b4wyyzFppJ;
        Thu, 14 Apr 2022 17:52:03 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Apr 2022 17:54:29 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Apr 2022 17:54:28 +0800
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
Subject: [PATCH v2 1/9] efi: Make efi_print_memmap() public
Date:   Thu, 14 Apr 2022 18:13:06 +0800
Message-ID: <20220414101314.1250667-2-mawupeng1@huawei.com>
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

Make efi_print_memmap() public in preparation for adding fake memory
support for architecture with efi support, eg, arm64.

Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
---
 arch/x86/include/asm/efi.h    |  1 -
 arch/x86/platform/efi/efi.c   | 16 ----------------
 drivers/firmware/efi/memmap.c | 16 ++++++++++++++++
 include/linux/efi.h           |  1 +
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 98938a68251c..686968073f48 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -150,7 +150,6 @@ extern asmlinkage u64 __efi_call(void *fp, ...);
 #endif /* CONFIG_X86_32 */
 
 extern int __init efi_memblock_x86_reserve_range(void);
-extern void __init efi_print_memmap(void);
 extern void __init efi_map_region(efi_memory_desc_t *md);
 extern void __init efi_map_region_fixed(efi_memory_desc_t *md);
 extern void efi_sync_low_kernel_mappings(void);
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 147c30a81f15..7b130f39d841 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -323,22 +323,6 @@ static void __init efi_clean_memmap(void)
 	}
 }
 
-void __init efi_print_memmap(void)
-{
-	efi_memory_desc_t *md;
-	int i = 0;
-
-	for_each_efi_memory_desc(md) {
-		char buf[64];
-
-		pr_info("mem%02u: %s range=[0x%016llx-0x%016llx] (%lluMB)\n",
-			i++, efi_md_typeattr_format(buf, sizeof(buf), md),
-			md->phys_addr,
-			md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT) - 1,
-			(md->num_pages >> (20 - EFI_PAGE_SHIFT)));
-	}
-}
-
 static int __init efi_systab_init(unsigned long phys)
 {
 	int size = efi_enabled(EFI_64BIT) ? sizeof(efi_system_table_64_t)
diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
index 4df55a55da84..04cc1f2cdfa4 100644
--- a/drivers/firmware/efi/memmap.c
+++ b/drivers/firmware/efi/memmap.c
@@ -376,3 +376,19 @@ void __init efi_memmap_insert(struct efi_memory_map *old_memmap, void *buf,
 		}
 	}
 }
+
+void __init efi_print_memmap(void)
+{
+	efi_memory_desc_t *md;
+	int i = 0;
+
+	for_each_efi_memory_desc(md) {
+		char buf[64];
+
+		pr_info("mem%02u: %s range=[0x%016llx-0x%016llx] (%lluMB)\n",
+			i++, efi_md_typeattr_format(buf, sizeof(buf), md),
+			md->phys_addr,
+			md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT) - 1,
+			(md->num_pages >> (20 - EFI_PAGE_SHIFT)));
+	}
+}
diff --git a/include/linux/efi.h b/include/linux/efi.h
index ccd4d3f91c98..de05682b233b 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -684,6 +684,7 @@ extern int __init efi_memmap_split_count(efi_memory_desc_t *md,
 					 struct range *range);
 extern void __init efi_memmap_insert(struct efi_memory_map *old_memmap,
 				     void *buf, struct efi_mem_range *mem);
+extern void __init efi_print_memmap(void);
 
 #ifdef CONFIG_EFI_ESRT
 extern void __init efi_esrt_init(void);
-- 
2.18.0.huawei.25

