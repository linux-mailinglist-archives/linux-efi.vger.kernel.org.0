Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC4C601494
	for <lists+linux-efi@lfdr.de>; Mon, 17 Oct 2022 19:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiJQRSE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Oct 2022 13:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiJQRSD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Oct 2022 13:18:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C26E71BE5
        for <linux-efi@vger.kernel.org>; Mon, 17 Oct 2022 10:18:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3EA9611E7
        for <linux-efi@vger.kernel.org>; Mon, 17 Oct 2022 17:17:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D33DC433D7;
        Mon, 17 Oct 2022 17:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666027078;
        bh=DXIQNCW5GdAnX29OrZZkS59dzIruv53O5M7EytR4vu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IuL9yu/w0QQ8EcZqGv9aIv49zfSAkWZ9EuFWnxgPtuRgeVBivpSZ2vTUiLp4Yo6K3
         elXEEqWAKRhO+xtPej7J1eEOKXcoSEm32rxuK9an4y/90dQWQE948B7M/7YE9l7Buf
         NGJsT54K58u/dwrek/8VAEtJwmu5TU7FuayYLap9zYMrQJ89WFJbrSDkk1CVJdeNqj
         P93DXL18Cnqj/L2xxBjmjzohWmSbUGdFmVMIO4dNP+agSKUdfBFhuldcvLEwrfqeGU
         XgpJ4J8x7GLCQBJDyWyFYJvkh7ACCa6f/xPDHQDjfs3h4OZaN1novb4CMXieoahRrk
         7txrLg5OifrEw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     keescook@chromium.org, Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>,
        Lennart Poettering <lennart@poettering.net>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 12/21] efi: libstub: Move screen_info handling to common code
Date:   Mon, 17 Oct 2022 19:16:51 +0200
Message-Id: <20221017171700.3736890-13-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221017171700.3736890-1-ardb@kernel.org>
References: <20221017171700.3736890-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14954; i=ardb@kernel.org; h=from:subject; bh=DXIQNCW5GdAnX29OrZZkS59dzIruv53O5M7EytR4vu8=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjTY38xEtSfVL4vMmptox66xnMQK+DVhftM9awvH7G OGReyPqJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY02N/AAKCRDDTyI5ktmPJDDqDA Cl1m30QFP+BKJvjarWJ/dFbzEjxCKLSj+a97/WbPJmzgbw9ww3sPxCfERnL6YU0CTKGOA/qVCkSzcC 3bC6y6owI7X2h9lmlEHyI+GX6QG528E+HG9BVOT5KfAXTMoboY5qXH9CAjcWHi7gyP+KrNKotCu6uR NljryqtPTCltsWCg6+pvOLdqiKiQvqMlVN0RGVcdibZV+Em9l30c1TiZFrZhiKGj0CTkzWemQxJGtU ExQ6QbP1uiPqM1kUCnJgTXtJLIolfwUuNeNgXuKxOyKIaPhAuafobSSAaZrGvpbUHdZrlCRauoKjVO ZK/4kqjQ9wLBFUIqrIPfFTbT6TccM6AeG8XuopKU4YbYTuJCqamypShtgSYToRik7xEMay99OlqWlJ Sltb8VZaQos0xsGqQLIJOh0QB+YMKJo7QAjISS+FAlpZYxXoEz6CJb3xy/tcbaiZ1Ph0BntMamIZiC qmQGnkqVocQz/32JFUFy2yADJlto7w1P9zNJ4sDEUw8cM=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Currently, arm64, RISC-V and LoongArch rely on the fact that struct
screen_info can be accessed directly, due to the fact that the EFI stub
and the core kernel are part of the same image. This will change after a
future patch, so let's ensure that the screen_info handling is able to
deal with this, by adopting the arm32 approach of passing it as a
configuration table. While at it, switch to ACPI reclaim memory to hold
the screen_info data, which is more appropriate for this kind of
allocation.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/include/asm/efi.h                 |  3 --
 arch/arm/kernel/efi.c                      | 31 ++---------
 arch/arm64/include/asm/efi.h               |  6 ---
 arch/loongarch/include/asm/efi.h           |  9 ----
 arch/loongarch/kernel/efi.c                | 24 ++++++++-
 arch/riscv/include/asm/efi.h               |  6 ---
 drivers/firmware/efi/efi-init.c            | 21 ++++++--
 drivers/firmware/efi/efi.c                 |  5 ++
 drivers/firmware/efi/libstub/Makefile      |  3 +-
 drivers/firmware/efi/libstub/arm32-stub.c  | 37 -------------
 drivers/firmware/efi/libstub/efi-stub.c    |  9 ++++
 drivers/firmware/efi/libstub/efistub.h     |  3 ++
 drivers/firmware/efi/libstub/screen_info.c | 56 ++++++++++++++++++++
 include/linux/efi.h                        |  2 +-
 14 files changed, 121 insertions(+), 94 deletions(-)

diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
index 4bdd930167c0..b95241b1ca65 100644
--- a/arch/arm/include/asm/efi.h
+++ b/arch/arm/include/asm/efi.h
@@ -43,9 +43,6 @@ void efi_virtmap_unload(void);
 
 /* arch specific definitions used by the stub code */
 
-struct screen_info *alloc_screen_info(void);
-void free_screen_info(struct screen_info *si);
-
 /*
  * A reasonable upper bound for the uncompressed kernel size is 32 MBytes,
  * so we will reserve that amount of memory. We have no easy way to tell what
diff --git a/arch/arm/kernel/efi.c b/arch/arm/kernel/efi.c
index e50ad7eefc02..882104f43b3b 100644
--- a/arch/arm/kernel/efi.c
+++ b/arch/arm/kernel/efi.c
@@ -75,38 +75,13 @@ int __init efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md)
 	return 0;
 }
 
-static unsigned long __initdata screen_info_table = EFI_INVALID_TABLE_ADDR;
 static unsigned long __initdata cpu_state_table = EFI_INVALID_TABLE_ADDR;
 
 const efi_config_table_type_t efi_arch_tables[] __initconst = {
-	{LINUX_EFI_ARM_SCREEN_INFO_TABLE_GUID, &screen_info_table},
 	{LINUX_EFI_ARM_CPU_STATE_TABLE_GUID, &cpu_state_table},
 	{}
 };
 
-static void __init load_screen_info_table(void)
-{
-	struct screen_info *si;
-
-	if (screen_info_table != EFI_INVALID_TABLE_ADDR) {
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
-
-		if (memblock_is_map_memory(screen_info.lfb_base))
-			memblock_mark_nomap(screen_info.lfb_base,
-					    screen_info.lfb_size);
-	}
-}
-
 static void __init load_cpu_state_table(void)
 {
 	if (cpu_state_table != EFI_INVALID_TABLE_ADDR) {
@@ -145,7 +120,11 @@ void __init arm_efi_init(void)
 {
 	efi_init();
 
-	load_screen_info_table();
+	if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI) {
+		/* dummycon on ARM needs non-zero values for columns/lines */
+		screen_info.orig_video_cols = 80;
+		screen_info.orig_video_lines = 25;
+	}
 
 	/* ARM does not permit early mappings to persist across paging_init() */
 	efi_memmap_unmap();
diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 439e2bc5d5d8..af35ad671754 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -76,12 +76,6 @@ static inline unsigned long efi_get_max_initrd_addr(unsigned long image_addr)
 	return (image_addr & ~(SZ_1G - 1UL)) + (1UL << (VA_BITS_MIN - 1));
 }
 
-#define alloc_screen_info(x...)		&screen_info
-
-static inline void free_screen_info(struct screen_info *si)
-{
-}
-
 #define EFI_ALLOC_ALIGN		SZ_64K
 
 /*
diff --git a/arch/loongarch/include/asm/efi.h b/arch/loongarch/include/asm/efi.h
index 174567b00ddb..60d6a170c18d 100644
--- a/arch/loongarch/include/asm/efi.h
+++ b/arch/loongarch/include/asm/efi.h
@@ -19,15 +19,6 @@ void efifb_setup_from_dmi(struct screen_info *si, const char *opt);
 #define EFI_ALLOC_ALIGN		SZ_64K
 #define EFI_RT_VIRTUAL_OFFSET	CSR_DMW0_BASE
 
-static inline struct screen_info *alloc_screen_info(void)
-{
-	return &screen_info;
-}
-
-static inline void free_screen_info(struct screen_info *si)
-{
-}
-
 static inline unsigned long efi_get_max_initrd_addr(unsigned long image_addr)
 {
 	return ULONG_MAX;
diff --git a/arch/loongarch/kernel/efi.c b/arch/loongarch/kernel/efi.c
index a31329971133..d75ce73e8ff8 100644
--- a/arch/loongarch/kernel/efi.c
+++ b/arch/loongarch/kernel/efi.c
@@ -52,6 +52,27 @@ void __init efi_runtime_init(void)
 	set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
 }
 
+unsigned long __initdata screen_info_table = EFI_INVALID_TABLE_ADDR;
+
+static void __init init_screen_info(void)
+{
+	struct screen_info *si;
+
+	if (screen_info_table == EFI_INVALID_TABLE_ADDR)
+		return;
+
+	si = early_memremap(screen_info_table, sizeof(*si));
+	if (!si) {
+		pr_err("Could not map screen_info config table\n");
+		return;
+	}
+	screen_info = *si;
+	memset(si, 0, sizeof(*si));
+	early_memunmap(si, sizeof(*si));
+
+	memblock_reserve(screen_info.lfb_base, screen_info.lfb_size);
+}
+
 void __init efi_init(void)
 {
 	int size;
@@ -80,8 +101,7 @@ void __init efi_init(void)
 
 	set_bit(EFI_CONFIG_TABLES, &efi.flags);
 
-	if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI)
-		memblock_reserve(screen_info.lfb_base, screen_info.lfb_size);
+	init_screen_info();
 
 	if (boot_memmap == EFI_INVALID_TABLE_ADDR)
 		return;
diff --git a/arch/riscv/include/asm/efi.h b/arch/riscv/include/asm/efi.h
index f74879a8f1ea..d0570936cb8c 100644
--- a/arch/riscv/include/asm/efi.h
+++ b/arch/riscv/include/asm/efi.h
@@ -31,12 +31,6 @@ static inline unsigned long efi_get_max_initrd_addr(unsigned long image_addr)
 	return ULONG_MAX;
 }
 
-#define alloc_screen_info(x...)		(&screen_info)
-
-static inline void free_screen_info(struct screen_info *si)
-{
-}
-
 void efi_virtmap_load(void);
 void efi_virtmap_unload(void);
 
diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
index 2fd770b499a3..1639159493e3 100644
--- a/drivers/firmware/efi/efi-init.c
+++ b/drivers/firmware/efi/efi-init.c
@@ -22,6 +22,8 @@
 
 #include <asm/efi.h>
 
+unsigned long __initdata screen_info_table = EFI_INVALID_TABLE_ADDR;
+
 static int __init is_memory(efi_memory_desc_t *md)
 {
 	if (md->attribute & (EFI_MEMORY_WB|EFI_MEMORY_WT|EFI_MEMORY_WC))
@@ -55,9 +57,22 @@ extern __weak const efi_config_table_type_t efi_arch_tables[];
 
 static void __init init_screen_info(void)
 {
-	if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI &&
-	    memblock_is_map_memory(screen_info.lfb_base))
-		memblock_mark_nomap(screen_info.lfb_base, screen_info.lfb_size);
+	struct screen_info *si;
+
+	if (screen_info_table != EFI_INVALID_TABLE_ADDR) {
+		si = early_memremap(screen_info_table, sizeof(*si));
+		if (!si) {
+			pr_err("Could not map screen_info config table\n");
+			return;
+		}
+		screen_info = *si;
+		memset(si, 0, sizeof(*si));
+		early_memunmap(si, sizeof(*si));
+
+		if (memblock_is_map_memory(screen_info.lfb_base))
+			memblock_mark_nomap(screen_info.lfb_base,
+					    screen_info.lfb_size);
+	}
 }
 
 static int __init uefi_init(u64 efi_system_table)
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 9624735f1575..84a3e52fe888 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -58,6 +58,8 @@ static unsigned long __initdata mem_reserve = EFI_INVALID_TABLE_ADDR;
 static unsigned long __initdata rt_prop = EFI_INVALID_TABLE_ADDR;
 static unsigned long __initdata initrd = EFI_INVALID_TABLE_ADDR;
 
+extern unsigned long screen_info_table;
+
 struct mm_struct efi_mm = {
 	.mm_mt			= MTREE_INIT_EXT(mm_mt, MM_MT_FLAGS, efi_mm.mmap_lock),
 	.mm_users		= ATOMIC_INIT(2),
@@ -544,6 +546,9 @@ static const efi_config_table_type_t common_tables[] __initconst = {
 #endif
 #ifdef CONFIG_EFI_COCO_SECRET
 	{LINUX_EFI_COCO_SECRET_AREA_GUID,	&efi.coco_secret,	"CocoSecret"	},
+#endif
+#ifdef CONFIG_EFI_GENERIC_STUB
+	{LINUX_EFI_SCREEN_INFO_TABLE_GUID,	&screen_info_table			},
 #endif
 	{},
 };
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index cb600c7a14de..53304e9c6778 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -77,7 +77,8 @@ lib-$(CONFIG_EFI_PARAMS_FROM_FDT) += fdt.o \
 $(obj)/lib-%.o: $(srctree)/lib/%.c FORCE
 	$(call if_changed_rule,cc_o_c)
 
-lib-$(CONFIG_EFI_GENERIC_STUB)	+= efi-stub.o string.o intrinsics.o systable.o
+lib-$(CONFIG_EFI_GENERIC_STUB)	+= efi-stub.o string.o intrinsics.o systable.o \
+				   screen_info.o
 
 lib-$(CONFIG_ARM)		+= arm32-stub.o
 lib-$(CONFIG_ARM64)		+= arm64-stub.o arm64-entry.o
diff --git a/drivers/firmware/efi/libstub/arm32-stub.c b/drivers/firmware/efi/libstub/arm32-stub.c
index 0131e3aaa605..1073dd947516 100644
--- a/drivers/firmware/efi/libstub/arm32-stub.c
+++ b/drivers/firmware/efi/libstub/arm32-stub.c
@@ -76,43 +76,6 @@ void efi_handle_post_ebs_state(void)
 		      &efi_entry_state->sctlr_after_ebs);
 }
 
-static efi_guid_t screen_info_guid = LINUX_EFI_ARM_SCREEN_INFO_TABLE_GUID;
-
-struct screen_info *alloc_screen_info(void)
-{
-	struct screen_info *si;
-	efi_status_t status;
-
-	/*
-	 * Unlike on arm64, where we can directly fill out the screen_info
-	 * structure from the stub, we need to allocate a buffer to hold
-	 * its contents while we hand over to the kernel proper from the
-	 * decompressor.
-	 */
-	status = efi_bs_call(allocate_pool, EFI_RUNTIME_SERVICES_DATA,
-			     sizeof(*si), (void **)&si);
-
-	if (status != EFI_SUCCESS)
-		return NULL;
-
-	status = efi_bs_call(install_configuration_table,
-			     &screen_info_guid, si);
-	if (status == EFI_SUCCESS)
-		return si;
-
-	efi_bs_call(free_pool, si);
-	return NULL;
-}
-
-void free_screen_info(struct screen_info *si)
-{
-	if (!si)
-		return;
-
-	efi_bs_call(install_configuration_table, &screen_info_guid, NULL);
-	efi_bs_call(free_pool, si);
-}
-
 efi_status_t handle_kernel_image(unsigned long *image_addr,
 				 unsigned long *image_size,
 				 unsigned long *reserve_addr,
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index b55d1009d4c8..8521dc09c6ae 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -47,6 +47,15 @@
 static u64 virtmap_base = EFI_RT_VIRTUAL_BASE;
 static bool flat_va_mapping = (EFI_RT_VIRTUAL_OFFSET != 0);
 
+struct screen_info * __weak alloc_screen_info(void)
+{
+	return &screen_info;
+}
+
+void __weak free_screen_info(struct screen_info *si)
+{
+}
+
 static struct screen_info *setup_graphics(void)
 {
 	efi_guid_t gop_proto = EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID;
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 313647b1c196..215186a29ab9 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -1027,4 +1027,7 @@ efi_enable_reset_attack_mitigation(void) { }
 
 void efi_retrieve_tpm2_eventlog(void);
 
+struct screen_info *alloc_screen_info(void);
+void free_screen_info(struct screen_info *si);
+
 #endif
diff --git a/drivers/firmware/efi/libstub/screen_info.c b/drivers/firmware/efi/libstub/screen_info.c
new file mode 100644
index 000000000000..8e76a8b384ba
--- /dev/null
+++ b/drivers/firmware/efi/libstub/screen_info.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/efi.h>
+#include <asm/efi.h>
+
+#include "efistub.h"
+
+/*
+ * There are two ways of populating the core kernel's struct screen_info via the stub:
+ * - using a configuration table, like below, which relies on the EFI init code
+ *   to locate the table and copy the contents;
+ * - by linking directly to the core kernel's copy of the global symbol.
+ *
+ * The latter is preferred because it makes the EFIFB earlycon available very
+ * early, but it only works if the EFI stub is part of the core kernel image
+ * itself. The zboot decompressor can only use the configuration table
+ * approach.
+ *
+ * In order to support both methods from the same build of the EFI stub
+ * library, provide this dummy global definition of struct screen_info. If it
+ * is required to satisfy a link dependency, it means we need to override the
+ * __weak alloc and free methods with the ones below, and those will be pulled
+ * in as well.
+ */
+struct screen_info screen_info;
+
+static efi_guid_t screen_info_guid = LINUX_EFI_SCREEN_INFO_TABLE_GUID;
+
+struct screen_info *alloc_screen_info(void)
+{
+	struct screen_info *si;
+	efi_status_t status;
+
+	status = efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
+			     sizeof(*si), (void **)&si);
+
+	if (status != EFI_SUCCESS)
+		return NULL;
+
+	status = efi_bs_call(install_configuration_table,
+			     &screen_info_guid, si);
+	if (status == EFI_SUCCESS)
+		return si;
+
+	efi_bs_call(free_pool, si);
+	return NULL;
+}
+
+void free_screen_info(struct screen_info *si)
+{
+	if (!si)
+		return;
+
+	efi_bs_call(install_configuration_table, &screen_info_guid, NULL);
+	efi_bs_call(free_pool, si);
+}
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 256e70e42114..ca3278077670 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -404,7 +404,7 @@ void efi_native_runtime_setup(void);
  * structure that was populated by the stub based on the GOP protocol instance
  * associated with ConOut
  */
-#define LINUX_EFI_ARM_SCREEN_INFO_TABLE_GUID	EFI_GUID(0xe03fc20a, 0x85dc, 0x406e,  0xb9, 0x0e, 0x4a, 0xb5, 0x02, 0x37, 0x1d, 0x95)
+#define LINUX_EFI_SCREEN_INFO_TABLE_GUID	EFI_GUID(0xe03fc20a, 0x85dc, 0x406e,  0xb9, 0x0e, 0x4a, 0xb5, 0x02, 0x37, 0x1d, 0x95)
 #define LINUX_EFI_ARM_CPU_STATE_TABLE_GUID	EFI_GUID(0xef79e4aa, 0x3c3d, 0x4989,  0xb9, 0x02, 0x07, 0xa9, 0x43, 0xe5, 0x50, 0xd2)
 #define LINUX_EFI_LOADER_ENTRY_GUID		EFI_GUID(0x4a67b082, 0x0a4c, 0x41cf,  0xb6, 0xc7, 0x44, 0x0b, 0x29, 0xbb, 0x8c, 0x4f)
 #define LINUX_EFI_RANDOM_SEED_TABLE_GUID	EFI_GUID(0x1ce1e5bc, 0x7ceb, 0x42f2,  0x81, 0xe5, 0x8a, 0xad, 0xf1, 0x80, 0xf5, 0x7b)
-- 
2.35.1

