Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91124C306A
	for <lists+linux-efi@lfdr.de>; Thu, 24 Feb 2022 16:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236551AbiBXPz2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Feb 2022 10:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236434AbiBXPz1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Feb 2022 10:55:27 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FE517C426;
        Thu, 24 Feb 2022 07:54:56 -0800 (PST)
Received: from localhost.localdomain (unknown [80.240.223.29])
        by mail.ispras.ru (Postfix) with ESMTPSA id DC8BF40755DB;
        Thu, 24 Feb 2022 15:44:53 +0000 (UTC)
From:   Baskov Evgeniy <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Baskov Evgeniy <baskov@ispras.ru>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC v2 2/2] libstub: ensure allocated memory to be executable
Date:   Thu, 24 Feb 2022 18:43:30 +0300
Message-Id: <20220224154330.26564-3-baskov@ispras.ru>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220224154330.26564-1-baskov@ispras.ru>
References: <20220224154330.26564-1-baskov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

There are UEFI versions that restrict execution of memory regions,
preventing the kernel from booting. Parts that needs to be executable
are:

* Area used for trampoline placement.
* All memory regions that the kernel may be relocated before
  and during extraction.

Use DXE services to ensure aforementioned address ranges
to be executable.

Signed-off-by: Baskov Evgeniy <baskov@ispras.ru>

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 01ddd4502e28..ca7d5379b480 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -22,6 +22,7 @@
 #define MAXMEM_X86_64_4LEVEL (1ull << 46)
 
 const efi_system_table_t *efi_system_table;
+const efi_dxe_services_table_t *efi_dxe_table;
 extern u32 image_offset;
 static efi_loaded_image_t *image = NULL;
 
@@ -211,9 +212,41 @@ static void retrieve_apple_device_properties(struct boot_params *boot_params)
 	}
 }
 
+
+static void unprotect_memory_range(unsigned long base, unsigned long size)
+{
+	unsigned long rounded_base, rounded_size;
+	efi_status_t res;
+
+	if (efi_dxe_table == NULL)
+		return;
+
+	rounded_base = rounddown(base, EFI_PAGE_SIZE);
+	rounded_size = roundup(base + size, EFI_PAGE_SIZE) - rounded_base;
+
+	res = efi_dxe_call(set_memory_space_attributes,
+			   rounded_base, rounded_size, EFI_MEMORY_WB);
+	if (res != EFI_SUCCESS) {
+		efi_warn("Unable to unprotect memory range [%08lx,%08lx]: %d\n",
+			 base, size + base, (int)res);
+	}
+}
+
+/*
+ * Trampoline takes 2 pages and can be loaded in first megabyte of memory
+ * with its end placed between 128k and 640k where BIOS might start
+ */
+
+#define TRAMPOLINE_PLACEMENT_BASE ((128 - 8)*1024)
+#define TRAMPOLINE_PLACEMENT_SIZE (640*1024 - (128 - 8)*1024)
+
+void startup_32(struct boot_params *boot_params);
+
 static const efi_char16_t apple[] = L"Apple";
 
-static void setup_quirks(struct boot_params *boot_params)
+static void setup_quirks(struct boot_params *boot_params,
+			 unsigned long image_base,
+			 unsigned long image_size)
 {
 	efi_char16_t *fw_vendor = (efi_char16_t *)(unsigned long)
 		efi_table_attr(efi_system_table, fw_vendor);
@@ -222,6 +255,31 @@ static void setup_quirks(struct boot_params *boot_params)
 		if (IS_ENABLED(CONFIG_APPLE_PROPERTIES))
 			retrieve_apple_device_properties(boot_params);
 	}
+
+	/*
+	 * Allow execution of possible trampoline used
+	 * for switching between 4- and 5-level page tables
+	 * and relocated kernel image.
+	 */
+
+	unprotect_memory_range(TRAMPOLINE_PLACEMENT_BASE,
+	                       TRAMPOLINE_PLACEMENT_SIZE);
+
+#ifdef CONFIG_64BIT
+	if (image_base != (unsigned long)startup_32)
+		unprotect_memory_range(image_base, image_size);
+#else
+	/*
+	 * Clear protection flags on a whole range of possible
+	 * addresses used for KASLR. We don't need to do that
+	 * on x86_64, since KASLR/extraction is performed after
+	 * dedicated identity page tables are built and we only
+	 * need to remove possible protection on relocated image
+	 * itself disregarding further relocations.
+	 */
+	unprotect_memory_range(LOAD_PHYSICAL_ADDR,
+			       KERNEL_IMAGE_SIZE - LOAD_PHYSICAL_ADDR);
+#endif
 }
 
 /*
@@ -341,8 +399,6 @@ static void __noreturn efi_exit(efi_handle_t handle, efi_status_t status)
 		asm("hlt");
 }
 
-void startup_32(struct boot_params *boot_params);
-
 void __noreturn efi_stub_entry(efi_handle_t handle,
 			       efi_system_table_t *sys_table_arg,
 			       struct boot_params *boot_params);
@@ -677,11 +733,18 @@ unsigned long efi_main(efi_handle_t handle,
 	efi_status_t status;
 
 	efi_system_table = sys_table_arg;
-
 	/* Check if we were booted by the EFI firmware */
 	if (efi_system_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
 		efi_exit(handle, EFI_INVALID_PARAMETER);
 
+	efi_dxe_table = get_efi_config_table(EFI_DXE_SERVICES_TABLE_GUID);
+
+	if (efi_dxe_table == NULL ||
+	    efi_dxe_table->hdr.signature != EFI_DXE_SERVICES_TABLE_SIGNATURE) {
+		efi_warn("Unable to locate EFI DXE services table\n");
+		efi_dxe_table = NULL;
+	}
+
 	/*
 	 * If the kernel isn't already loaded at a suitable address,
 	 * relocate it.
@@ -791,7 +854,7 @@ unsigned long efi_main(efi_handle_t handle,
 
 	setup_efi_pci(boot_params);
 
-	setup_quirks(boot_params);
+	setup_quirks(boot_params, bzimage_addr, buffer_end - buffer_start);
 
 	status = exit_boot(boot_params, handle);
 	if (status != EFI_SUCCESS) {
-- 
2.35.1

