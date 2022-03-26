Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2464E7F5E
	for <lists+linux-efi@lfdr.de>; Sat, 26 Mar 2022 07:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbiCZG3O (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 26 Mar 2022 02:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbiCZG3M (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 26 Mar 2022 02:29:12 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919DF395;
        Fri, 25 Mar 2022 23:27:36 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KQTRq4N6Sz9sv9;
        Sat, 26 Mar 2022 14:23:35 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 26 Mar 2022 14:27:34 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 26 Mar 2022 14:27:32 +0800
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
Subject: [PATCH 1/9] efi: Make efi_print_memmap() public
Date:   Sat, 26 Mar 2022 14:46:24 +0800
Message-ID: <20220326064632.131637-2-mawupeng1@huawei.com>
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
index 03cb12775043..f0cc7766f53c 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -145,7 +145,6 @@ extern asmlinkage u64 __efi_call(void *fp, ...);
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

