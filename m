Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0984E7F64
	for <lists+linux-efi@lfdr.de>; Sat, 26 Mar 2022 07:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbiCZG3Q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 26 Mar 2022 02:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbiCZG3N (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 26 Mar 2022 02:29:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C4427B;
        Fri, 25 Mar 2022 23:27:37 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KQTVc4bgHzfZK4;
        Sat, 26 Mar 2022 14:26:00 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 26 Mar 2022 14:27:35 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 26 Mar 2022 14:27:34 +0800
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
Subject: [PATCH 2/9] arm64: efi: Add fake memory support
Date:   Sat, 26 Mar 2022 14:46:25 +0800
Message-ID: <20220326064632.131637-3-mawupeng1@huawei.com>
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

Fake memory map is used for faking memory's attribute values.
Commit 0f96a99dab36 ("efi: Add "efi_fake_mem" boot option") introduce the
efi_fake_mem function. Now it can support arm64 with this patch.
For example you can mark 0-6G memory as EFI_MEMORY_MORE_RELIABLE by adding
efi_fake_mem=6G@0:0x10000 in the bootarg. You find more info about
fake memmap in kernel-parameters.txt.

Variable memstart_addr is only confirmed after arm64_memblock_init(). So
efi_fake_memmap() is needed to add after arm64_memblock_init().

Otherwise:

efi_memmap_alloc
   memblock_phys_alloc
     kmemleak_alloc_phys
        kmemleak_alloc(__va(phys), size, min_count, gfp);

this __va() will convert phys to a fault va and lead to a kmemleak error.

Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 arch/arm64/kernel/setup.c                       | 2 ++
 drivers/firmware/efi/Kconfig                    | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b7ccaa2ea867..e064839895ee 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1357,7 +1357,7 @@
 			you are really sure that your UEFI does sane gc and
 			fulfills the spec otherwise your board may brick.
 
-	efi_fake_mem=	nn[KMG]@ss[KMG]:aa[,nn[KMG]@ss[KMG]:aa,..] [EFI; X86]
+	efi_fake_mem=	nn[KMG]@ss[KMG]:aa[,nn[KMG]@ss[KMG]:aa,..] [EFI; X86; ARM64]
 			Add arbitrary attribute to specific memory range by
 			updating original EFI memory map.
 			Region of memory which aa attribute is added to is
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 3505789cf4bd..daade64889ff 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -344,6 +344,8 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 
 	arm64_memblock_init();
 
+	efi_fake_memmap();
+
 	paging_init();
 
 	acpi_table_upgrade();
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 2c3dac5ecb36..3c91bbd4097a 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -50,7 +50,7 @@ config EFI_RUNTIME_MAP
 
 config EFI_FAKE_MEMMAP
 	bool "Enable EFI fake memory map"
-	depends on EFI && X86
+	depends on EFI && (X86 || ARM64)
 	default n
 	help
 	  Saying Y here will enable "efi_fake_mem" boot option.
-- 
2.18.0.huawei.25

