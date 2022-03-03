Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5634CBFE6
	for <lists+linux-efi@lfdr.de>; Thu,  3 Mar 2022 15:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbiCCOWX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Mar 2022 09:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbiCCOWW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 3 Mar 2022 09:22:22 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772FF18DAA2;
        Thu,  3 Mar 2022 06:21:36 -0800 (PST)
Received: from localhost.localdomain (unknown [80.240.223.29])
        by mail.ispras.ru (Postfix) with ESMTPSA id 2C9AF40755C9;
        Thu,  3 Mar 2022 14:21:34 +0000 (UTC)
From:   Baskov Evgeniy <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Baskov Evgeniy <baskov@ispras.ru>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] libstub: ensure allocated memory to be executable
Date:   Thu,  3 Mar 2022 17:21:20 +0300
Message-Id: <20220303142120.1975-3-baskov@ispras.ru>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220303142120.1975-1-baskov@ispras.ru>
References: <20220303142120.1975-1-baskov@ispras.ru>
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
to be executable. Only modify attributes that does not
have appropriate attributes.

Signed-off-by: Baskov Evgeniy <baskov@ispras.ru>

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 2c3dac5ecb36..f44f8b746e42 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -91,6 +91,18 @@ config EFI_SOFT_RESERVE
 
 	  If unsure, say Y.
 
+config EFI_DXE_MEM_ATTRIBUTES
+	bool "Adjust memory attributes in EFISTUB"
+	depends on EFI && EFI_STUB && X86
+	default y
+	help
+	  UEFI specification does not guarantee all memory to be
+	  accessible for both write and execute as the kernel expects
+	  it to be.
+	  Use DXE services to check and alter memory protection
+	  attributes during boot via EFISTUB to ensure that memory
+	  ranges used by the kernel are writable and executable.
+
 config EFI_PARAMS_FROM_FDT
 	bool
 	help
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 47fa1c8e7f40..6e6b80884d6a 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -212,9 +212,110 @@ static void retrieve_apple_device_properties(struct boot_params *boot_params)
 	}
 }
 
+static void
+adjust_memory_range_protection(unsigned long start, unsigned long size)
+{
+	efi_status_t status;
+	efi_gcd_memory_space_desc_t desc;
+	unsigned long end, next;
+	unsigned long rounded_start, rounded_end;
+	unsigned long unprotect_start, unprotect_size;
+	int has_system_memory = 0;
+
+	if (efi_dxe_table == NULL)
+		return;
+
+	rounded_start = rounddown(start, EFI_PAGE_SIZE);
+	rounded_end = roundup(start + size, EFI_PAGE_SIZE);
+
+	/*
+	 * Don't modify memory region attributes, they are
+	 * already suitable, to lower the possibility to
+	 * encounter firmware bugs.
+	 */
+
+	for (end = start + size; start < end; start = next) {
+
+		status = efi_dxe_call(get_memory_space_descriptor, start, &desc);
+
+		if (status != EFI_SUCCESS)
+			return;
+
+		next = desc.base_address + desc.length;
+
+		/*
+		 * Only system memory is suitable for trampoline/kernel image placement,
+		 * so only this type of memory needs its attributes to be modified.
+		 */
+
+		if (desc.gcd_memory_type != EfiGcdMemoryTypeSystemMemory ||
+		    (desc.attributes & (EFI_MEMORY_RO | EFI_MEMORY_XP)) == 0)
+			continue;
+
+		unprotect_start = max(rounded_start, (unsigned long)desc.base_address);
+		unprotect_size = min(rounded_end, next) - unprotect_start;
+
+		status = efi_dxe_call(set_memory_space_attributes,
+				      unprotect_start, unprotect_size,
+				      EFI_MEMORY_WB);
+
+		if (status != EFI_SUCCESS) {
+			efi_warn("Unable to unprotect memory range [%08lx,%08lx]: %d\n",
+				 unprotect_start,
+				 unprotect_start + unprotect_size,
+				 (int)status);
+		}
+	}
+}
+
+/*
+ * Trampoline takes 2 pages and can be loaded in first megabyte of memory
+ * with its end placed between 128k and 640k where BIOS might start.
+ * (see arch/x86/boot/compressed/pgtable_64.c)
+ *
+ * We cannot find exact trampoline placement since memory map
+ * can be modified by UEFI, and it can alter the computed address.
+ */
+
+#define TRAMPOLINE_PLACEMENT_BASE ((128 - 8)*1024)
+#define TRAMPOLINE_PLACEMENT_SIZE (640*1024 - (128 - 8)*1024)
+
+void startup_32(struct boot_params *boot_params);
+
+static void
+setup_memory_protection(unsigned long image_base, unsigned long image_size)
+{
+	/*
+	 * Allow execution of possible trampoline used
+	 * for switching between 4- and 5-level page tables
+	 * and relocated kernel image.
+	 */
+
+	adjust_memory_range_protection(TRAMPOLINE_PLACEMENT_BASE,
+				       TRAMPOLINE_PLACEMENT_SIZE);
+
+#ifdef CONFIG_64BIT
+	if (image_base != (unsigned long)startup_32)
+		adjust_memory_range_protection(image_base, image_size);
+#else
+	/*
+	 * Clear protection flags on a whole range of possible
+	 * addresses used for KASLR. We don't need to do that
+	 * on x86_64, since KASLR/extraction is performed after
+	 * dedicated identity page tables are built and we only
+	 * need to remove possible protection on relocated image
+	 * itself disregarding further relocations.
+	 */
+	adjust_memory_range_protection(LOAD_PHYSICAL_ADDR,
+				       KERNEL_IMAGE_SIZE - LOAD_PHYSICAL_ADDR);
+#endif
+}
+
 static const efi_char16_t apple[] = L"Apple";
 
-static void setup_quirks(struct boot_params *boot_params)
+static void setup_quirks(struct boot_params *boot_params,
+			 unsigned long image_base,
+			 unsigned long image_size)
 {
 	efi_char16_t *fw_vendor = (efi_char16_t *)(unsigned long)
 		efi_table_attr(efi_system_table, fw_vendor);
@@ -223,6 +324,9 @@ static void setup_quirks(struct boot_params *boot_params)
 		if (IS_ENABLED(CONFIG_APPLE_PROPERTIES))
 			retrieve_apple_device_properties(boot_params);
 	}
+
+	if (IS_ENABLED(CONFIG_EFI_DXE_MEM_ATTRIBUTES))
+		setup_memory_protection(image_base, image_size);
 }
 
 /*
@@ -342,8 +446,6 @@ static void __noreturn efi_exit(efi_handle_t handle, efi_status_t status)
 		asm("hlt");
 }
 
-void startup_32(struct boot_params *boot_params);
-
 void __noreturn efi_stub_entry(efi_handle_t handle,
 			       efi_system_table_t *sys_table_arg,
 			       struct boot_params *boot_params);
@@ -799,7 +901,7 @@ unsigned long efi_main(efi_handle_t handle,
 
 	setup_efi_pci(boot_params);
 
-	setup_quirks(boot_params);
+	setup_quirks(boot_params, bzimage_addr, buffer_end - buffer_start);
 
 	status = exit_boot(boot_params, handle);
 	if (status != EFI_SUCCESS) {
-- 
2.35.1

