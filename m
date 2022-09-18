Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7415BC017
	for <lists+linux-efi@lfdr.de>; Sun, 18 Sep 2022 23:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiIRVgG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 18 Sep 2022 17:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIRVgF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 18 Sep 2022 17:36:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D07A13FA2
        for <linux-efi@vger.kernel.org>; Sun, 18 Sep 2022 14:36:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BFEE6124F
        for <linux-efi@vger.kernel.org>; Sun, 18 Sep 2022 21:36:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49071C4347C;
        Sun, 18 Sep 2022 21:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663536963;
        bh=y3ippfakNziyrf/LXyt70wrU7kpfg7DaJewJBo4f+zA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y5tUNQ0AJ+N4eBRp0M81v+FxjAxdePU2CaXteQL1aWEmjQCnm5W/8yWFO4nYztMun
         TZ57K6Ddvxk6p9Aj+B+IzYsJoBPxFMNpFKmUT+pI2xrI7cLxG5kr2I12J3I+mW3oJ0
         35vPQqTmHaHQeQARkhdKTky3oKFy5FvmjoPdvvUM8nT7qhqvVz8Fno5oKIJVRysaYV
         GQO6v8DeFHO6bXK3MkZJ/MzftH/4quDO99DLCtsdCQ4YdDp0XlmkGD2SuvVX30ITTR
         4VnmXsT+yIi8tafrkQViMXoHPyUqn7i71DukrG3D348zQO5JrBtAok4AlK+M4/B1of
         UDd/s2zGnHnMA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     loongarch@lists.linux.dev, linux@armlinux.org.uk,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH 02/12] efi/arm: libstub: move ARM specific code out of generic routines
Date:   Sun, 18 Sep 2022 23:35:34 +0200
Message-Id: <20220918213544.2176249-3-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220918213544.2176249-1-ardb@kernel.org>
References: <20220918213544.2176249-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7577; i=ardb@kernel.org; h=from:subject; bh=y3ippfakNziyrf/LXyt70wrU7kpfg7DaJewJBo4f+zA=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjJ48dYtfo+7GQ6q0ijrKSkUAHnRY8FULUwMPZYMoS hU3l+YeJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYyePHQAKCRDDTyI5ktmPJALyC/ 9IMShjTAJ6ceHuIyWQl689tVJjMhtfjyKjht1SiNqoc+JhfWjYps/z5PukOHBnbCptyBeWoi8LkcGg Ty4chLjh/E37bkGSdrNsygT8q2zbL59+LUKMOgZc+gx/ijD9Q2uuKTcw7/L3Y4Ldxc9++BGscFJ3q1 0oUoe2wqJ8G7iMYdArQfK94O7yHTDizjlsuUCPyJCp3tmUx3Wwuw+CUpheJbtjBJBFnAdwgdS2L7h8 C7hb73L1DOf1uaL8CglBo5kUamRgT019LbRoDbd9wD1ntW/fSi9vMiDk+ENrg4nlhtR08eKbIHEJ14 rjFKBMr6LtSVhEXjMjjAYj5WJ8hcr7jdFvwUl9dLukZ+WDqplEmw8ndT9USqeX0eSZrMyEkSfB33F1 CtHgESUp/x/A5hziP28jv2qfDLZqnlt1IdET3l2nW9vH5q53pW/uRFZD5rDEHh7iXNeQZemjY1wGOw UWXYQEAiT0ivSJOePss3sDCZT8JIRS0dv0YG2q+StOWAA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Move some code that is only reachable when IS_ENABLED(CONFIG_ARM) into
the ARM EFI arch code.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/include/asm/efi.h      |  3 +-
 arch/arm/kernel/efi.c           | 79 ++++++++++++++++++++
 arch/arm/kernel/setup.c         |  2 +-
 drivers/firmware/efi/efi-init.c | 61 +--------------
 4 files changed, 84 insertions(+), 61 deletions(-)

diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
index 3088ef72704e..4bdd930167c0 100644
--- a/arch/arm/include/asm/efi.h
+++ b/arch/arm/include/asm/efi.h
@@ -17,6 +17,7 @@
 
 #ifdef CONFIG_EFI
 void efi_init(void);
+void arm_efi_init(void);
 
 int efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md);
 int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md);
@@ -37,7 +38,7 @@ void efi_virtmap_load(void);
 void efi_virtmap_unload(void);
 
 #else
-#define efi_init()
+#define arm_efi_init()
 #endif /* CONFIG_EFI */
 
 /* arch specific definitions used by the stub code */
diff --git a/arch/arm/kernel/efi.c b/arch/arm/kernel/efi.c
index e57dbcc89123..e50ad7eefc02 100644
--- a/arch/arm/kernel/efi.c
+++ b/arch/arm/kernel/efi.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/efi.h>
+#include <linux/memblock.h>
 #include <asm/efi.h>
 #include <asm/mach/map.h>
 #include <asm/mmu_context.h>
@@ -73,3 +74,81 @@ int __init efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md)
 		return efi_set_mapping_permissions(mm, md);
 	return 0;
 }
+
+static unsigned long __initdata screen_info_table = EFI_INVALID_TABLE_ADDR;
+static unsigned long __initdata cpu_state_table = EFI_INVALID_TABLE_ADDR;
+
+const efi_config_table_type_t efi_arch_tables[] __initconst = {
+	{LINUX_EFI_ARM_SCREEN_INFO_TABLE_GUID, &screen_info_table},
+	{LINUX_EFI_ARM_CPU_STATE_TABLE_GUID, &cpu_state_table},
+	{}
+};
+
+static void __init load_screen_info_table(void)
+{
+	struct screen_info *si;
+
+	if (screen_info_table != EFI_INVALID_TABLE_ADDR) {
+		si = early_memremap_ro(screen_info_table, sizeof(*si));
+		if (!si) {
+			pr_err("Could not map screen_info config table\n");
+			return;
+		}
+		screen_info = *si;
+		early_memunmap(si, sizeof(*si));
+
+		/* dummycon on ARM needs non-zero values for columns/lines */
+		screen_info.orig_video_cols = 80;
+		screen_info.orig_video_lines = 25;
+
+		if (memblock_is_map_memory(screen_info.lfb_base))
+			memblock_mark_nomap(screen_info.lfb_base,
+					    screen_info.lfb_size);
+	}
+}
+
+static void __init load_cpu_state_table(void)
+{
+	if (cpu_state_table != EFI_INVALID_TABLE_ADDR) {
+		struct efi_arm_entry_state *state;
+		bool dump_state = true;
+
+		state = early_memremap_ro(cpu_state_table,
+					  sizeof(struct efi_arm_entry_state));
+		if (state == NULL) {
+			pr_warn("Unable to map CPU entry state table.\n");
+			return;
+		}
+
+		if ((state->sctlr_before_ebs & 1) == 0)
+			pr_warn(FW_BUG "EFI stub was entered with MMU and Dcache disabled, please fix your firmware!\n");
+		else if ((state->sctlr_after_ebs & 1) == 0)
+			pr_warn(FW_BUG "ExitBootServices() returned with MMU and Dcache disabled, please fix your firmware!\n");
+		else
+			dump_state = false;
+
+		if (dump_state || efi_enabled(EFI_DBG)) {
+			pr_info("CPSR at EFI stub entry        : 0x%08x\n",
+				state->cpsr_before_ebs);
+			pr_info("SCTLR at EFI stub entry       : 0x%08x\n",
+				state->sctlr_before_ebs);
+			pr_info("CPSR after ExitBootServices() : 0x%08x\n",
+				state->cpsr_after_ebs);
+			pr_info("SCTLR after ExitBootServices(): 0x%08x\n",
+				state->sctlr_after_ebs);
+		}
+		early_memunmap(state, sizeof(struct efi_arm_entry_state));
+	}
+}
+
+void __init arm_efi_init(void)
+{
+	efi_init();
+
+	load_screen_info_table();
+
+	/* ARM does not permit early mappings to persist across paging_init() */
+	efi_memmap_unmap();
+
+	load_cpu_state_table();
+}
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 1e8a50a97edf..cb88c6e69377 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1141,7 +1141,7 @@ void __init setup_arch(char **cmdline_p)
 #endif
 	setup_dma_zone(mdesc);
 	xen_early_init();
-	efi_init();
+	arm_efi_init();
 	/*
 	 * Make sure the calculation for lowmem/highmem is set appropriately
 	 * before reserving/allocating any memory
diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
index 3928dbff76d0..2fd770b499a3 100644
--- a/drivers/firmware/efi/efi-init.c
+++ b/drivers/firmware/efi/efi-init.c
@@ -51,34 +51,10 @@ static phys_addr_t __init efi_to_phys(unsigned long addr)
 	return addr;
 }
 
-static __initdata unsigned long screen_info_table = EFI_INVALID_TABLE_ADDR;
-static __initdata unsigned long cpu_state_table = EFI_INVALID_TABLE_ADDR;
-
-static const efi_config_table_type_t arch_tables[] __initconst = {
-	{LINUX_EFI_ARM_SCREEN_INFO_TABLE_GUID, &screen_info_table},
-	{LINUX_EFI_ARM_CPU_STATE_TABLE_GUID, &cpu_state_table},
-	{}
-};
+extern __weak const efi_config_table_type_t efi_arch_tables[];
 
 static void __init init_screen_info(void)
 {
-	struct screen_info *si;
-
-	if (IS_ENABLED(CONFIG_ARM) &&
-	    screen_info_table != EFI_INVALID_TABLE_ADDR) {
-		si = early_memremap_ro(screen_info_table, sizeof(*si));
-		if (!si) {
-			pr_err("Could not map screen_info config table\n");
-			return;
-		}
-		screen_info = *si;
-		early_memunmap(si, sizeof(*si));
-
-		/* dummycon on ARM needs non-zero values for columns/lines */
-		screen_info.orig_video_cols = 80;
-		screen_info.orig_video_lines = 25;
-	}
-
 	if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI &&
 	    memblock_is_map_memory(screen_info.lfb_base))
 		memblock_mark_nomap(screen_info.lfb_base, screen_info.lfb_size);
@@ -119,8 +95,7 @@ static int __init uefi_init(u64 efi_system_table)
 		goto out;
 	}
 	retval = efi_config_parse_tables(config_tables, systab->nr_tables,
-					 IS_ENABLED(CONFIG_ARM) ? arch_tables
-								: NULL);
+					 efi_arch_tables);
 
 	early_memunmap(config_tables, table_size);
 out:
@@ -248,36 +223,4 @@ void __init efi_init(void)
 			 PAGE_ALIGN(data.size + (data.phys_map & ~PAGE_MASK)));
 
 	init_screen_info();
-
-#ifdef CONFIG_ARM
-	/* ARM does not permit early mappings to persist across paging_init() */
-	efi_memmap_unmap();
-
-	if (cpu_state_table != EFI_INVALID_TABLE_ADDR) {
-		struct efi_arm_entry_state *state;
-		bool dump_state = true;
-
-		state = early_memremap_ro(cpu_state_table,
-					  sizeof(struct efi_arm_entry_state));
-		if (state == NULL) {
-			pr_warn("Unable to map CPU entry state table.\n");
-			return;
-		}
-
-		if ((state->sctlr_before_ebs & 1) == 0)
-			pr_warn(FW_BUG "EFI stub was entered with MMU and Dcache disabled, please fix your firmware!\n");
-		else if ((state->sctlr_after_ebs & 1) == 0)
-			pr_warn(FW_BUG "ExitBootServices() returned with MMU and Dcache disabled, please fix your firmware!\n");
-		else
-			dump_state = false;
-
-		if (dump_state || efi_enabled(EFI_DBG)) {
-			pr_info("CPSR at EFI stub entry        : 0x%08x\n", state->cpsr_before_ebs);
-			pr_info("SCTLR at EFI stub entry       : 0x%08x\n", state->sctlr_before_ebs);
-			pr_info("CPSR after ExitBootServices() : 0x%08x\n", state->cpsr_after_ebs);
-			pr_info("SCTLR after ExitBootServices(): 0x%08x\n", state->sctlr_after_ebs);
-		}
-		early_memunmap(state, sizeof(struct efi_arm_entry_state));
-	}
-#endif
 }
-- 
2.35.1

