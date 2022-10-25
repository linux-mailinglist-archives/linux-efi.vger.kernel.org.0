Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0929C60CEBF
	for <lists+linux-efi@lfdr.de>; Tue, 25 Oct 2022 16:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbiJYOPk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Oct 2022 10:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbiJYOOX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Oct 2022 10:14:23 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A38BE2D1;
        Tue, 25 Oct 2022 07:14:22 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id AEB1640737BF;
        Tue, 25 Oct 2022 14:14:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru AEB1640737BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1666707260;
        bh=tm+hOZOKEnb+VX8cmnhhjsXvyJIWq6CDKqxIhjxKO+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DqbHhUF9LxYJaRh3m78ioFrYYDnTe6Tqnm4eknPmFJAdM0BQ6ATBNmqGonw5vgpES
         0aYJeVeBDRNtnkGgLy451EBo4nni5wxLgefOJqHdp8a5rSbqgsqB2mK6DMtyaromeS
         Ku/w0+8gDNf8ctnR4o6AZWRpQoNFFlswVFljucBI=
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Evgeniy Baskov <baskov@ispras.ru>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2 23/23] efi/libstub: Use memory attribute protocol
Date:   Tue, 25 Oct 2022 17:13:01 +0300
Message-Id: <9b3c892dfc81a8b716abb75a7ce82edd2bf78a00.1666705333.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <cover.1666705333.git.baskov@ispras.ru>
References: <cover.1666705333.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add EFI_MEMORY_ATTRIBUTE_PROTOCOL as preferred alternative to DXE
services for changing memory attributes in the EFISTUB.

Use DXE services only as a fallback in case aforementioned protocol
is not supported by UEFI implementation.

Move DXE services initialization code closer to the place they are used
to match EFI_MEMORY_ATTRIBUTE_PROTOCOL initialization code.

Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
---
 drivers/firmware/efi/libstub/mem.c      | 168 ++++++++++++++++++------
 drivers/firmware/efi/libstub/x86-stub.c |  17 ---
 2 files changed, 128 insertions(+), 57 deletions(-)

diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
index cdf1e6fb6430..35acec241dd3 100644
--- a/drivers/firmware/efi/libstub/mem.c
+++ b/drivers/firmware/efi/libstub/mem.c
@@ -5,6 +5,9 @@
 
 #include "efistub.h"
 
+const efi_dxe_services_table_t *efi_dxe_table;
+efi_memory_attribute_protocol_t *efi_mem_attrib_proto;
+
 /**
  * efi_get_memory_map() - get memory map
  * @map:		pointer to memory map pointer to which to assign the
@@ -126,66 +129,47 @@ void efi_free(unsigned long size, unsigned long addr)
 	efi_bs_call(free_pages, addr, nr_pages);
 }
 
-/**
- * efi_adjust_memory_range_protection() - change memory range protection attributes
- * @start:	memory range start address
- * @size:	memory range size
- *
- * Actual memory range for which memory attributes are modified is
- * the smallest ranged with start address and size aligned to EFI_PAGE_SIZE
- * that includes [start, start + size].
- *
- * @return: status code
- */
-efi_status_t efi_adjust_memory_range_protection(unsigned long start,
-						unsigned long size,
-						unsigned long attributes)
+static void retrieve_dxe_table(void)
+{
+	efi_dxe_table = get_efi_config_table(EFI_DXE_SERVICES_TABLE_GUID);
+	if (efi_dxe_table &&
+	    efi_dxe_table->hdr.signature != EFI_DXE_SERVICES_TABLE_SIGNATURE) {
+		efi_warn("Ignoring DXE services table: invalid signature\n");
+		efi_dxe_table = NULL;
+	}
+}
+
+static efi_status_t adjust_mem_attrib_dxe(efi_physical_addr_t rounded_start,
+					  efi_physical_addr_t rounded_end,
+					  unsigned long attributes)
 {
 	efi_status_t status;
 	efi_gcd_memory_space_desc_t desc;
-	efi_physical_addr_t end, next;
-	efi_physical_addr_t rounded_start, rounded_end;
+	efi_physical_addr_t end, next, start;
 	efi_physical_addr_t unprotect_start, unprotect_size;
 
-	if (efi_dxe_table == NULL)
-		return EFI_UNSUPPORTED;
+	if (!efi_dxe_table) {
+		retrieve_dxe_table();
 
-	/*
-	 * This function should not be used to modify attributes
-	 * other than writable/executable.
-	 */
-
-	if ((attributes & ~(EFI_MEMORY_RO | EFI_MEMORY_XP)) != 0)
-		return EFI_INVALID_PARAMETER;
-
-	/*
-	 * Disallow simultaniously executable and writable memory
-	 * to inforce W^X policy if direct extraction code is enabled.
-	 */
-
-	if ((attributes & (EFI_MEMORY_RO | EFI_MEMORY_XP)) == 0) {
-		efi_warn("W^X violation at [%08lx,%08lx]\n",
-			 (unsigned long)rounded_start,
-			 (unsigned long)rounded_end);
+		if (!efi_dxe_table)
+			return EFI_UNSUPPORTED;
 	}
 
-	rounded_start = rounddown(start, EFI_PAGE_SIZE);
-	rounded_end = roundup(start + size, EFI_PAGE_SIZE);
-
 	/*
 	 * Don't modify memory region attributes, they are
 	 * already suitable, to lower the possibility to
 	 * encounter firmware bugs.
 	 */
 
-	for (end = start + size; start < end; start = next) {
+
+	for (start = rounded_start, end = rounded_end; start < end; start = next) {
 
 		status = efi_dxe_call(get_memory_space_descriptor,
 				      start, &desc);
 
 		if (status != EFI_SUCCESS) {
 			efi_warn("Unable to get memory descriptor at %lx\n",
-				 start);
+				 (unsigned long)start);
 			return status;
 		}
 
@@ -227,3 +211,107 @@ efi_status_t efi_adjust_memory_range_protection(unsigned long start,
 
 	return EFI_SUCCESS;
 }
+
+static void retrieve_memory_attributes_proto(void)
+{
+	efi_status_t status;
+	efi_guid_t guid = EFI_MEMORY_ATTRIBUTE_PROTOCOL_GUID;
+
+	status = efi_bs_call(locate_protocol, &guid, NULL,
+			     (void **)&efi_mem_attrib_proto);
+	if (status != EFI_SUCCESS)
+		efi_mem_attrib_proto = NULL;
+}
+
+/**
+ * efi_adjust_memory_range_protection() - change memory range protection attributes
+ * @start:	memory range start address
+ * @size:	memory range size
+ *
+ * Actual memory range for which memory attributes are modified is
+ * the smallest ranged with start address and size aligned to EFI_PAGE_SIZE
+ * that includes [start, start + size].
+ *
+ * This function first attempts to use EFI_MEMORY_ATTRIBUTE_PROTOCOL,
+ * that is a part of UEFI Specification since version 2.10.
+ * If the protocol is unavailable it falls back to DXE services functions.
+ *
+ * @return: status code
+ */
+efi_status_t efi_adjust_memory_range_protection(unsigned long start,
+						unsigned long size,
+						unsigned long attributes)
+{
+	efi_status_t status;
+	efi_physical_addr_t rounded_start, rounded_end;
+	unsigned long attr_clear;
+
+	/*
+	 * This function should not be used to modify attributes
+	 * other than writable/executable.
+	 */
+
+	if ((attributes & ~(EFI_MEMORY_RO | EFI_MEMORY_XP)) != 0)
+		return EFI_INVALID_PARAMETER;
+
+	/*
+	 * Warn if requested to make memory simultaneously
+	 * executable and writable to enforce W^X policy.
+	 */
+
+	if ((attributes & (EFI_MEMORY_RO | EFI_MEMORY_XP)) == 0) {
+		efi_warn("W^X violation at  [%08lx,%08lx]",
+			 (unsigned long)rounded_start,
+			 (unsigned long)rounded_end);
+	}
+
+	rounded_start = rounddown(start, EFI_PAGE_SIZE);
+	rounded_end = roundup(start + size, EFI_PAGE_SIZE);
+
+	if (!efi_mem_attrib_proto) {
+		retrieve_memory_attributes_proto();
+
+		/* Fall back to DXE services if unsupported */
+		if (!efi_mem_attrib_proto) {
+			return adjust_mem_attrib_dxe(rounded_start,
+						     rounded_end,
+						     attributes);
+		}
+	}
+
+	/*
+	 * Unlike DXE services functions, EFI_MEMORY_ATTRIBUTE_PROTOCOL
+	 * does not clear unset protection bit, so it needs to be cleared
+	 * explcitly
+	 */
+
+	attr_clear = ~attributes &
+		     (EFI_MEMORY_RO | EFI_MEMORY_XP | EFI_MEMORY_RP);
+
+	status = efi_call_proto(efi_mem_attrib_proto,
+				clear_memory_attributes,
+				rounded_start,
+				rounded_end - rounded_start,
+				attr_clear);
+	if (status != EFI_SUCCESS) {
+		efi_warn("Failed to clear memory attributes at [%08lx,%08lx]: %lx",
+			 (unsigned long)rounded_start,
+			 (unsigned long)rounded_end,
+			 status);
+		return status;
+	}
+
+	status = efi_call_proto(efi_mem_attrib_proto,
+				set_memory_attributes,
+				rounded_start,
+				rounded_end - rounded_start,
+				attributes);
+	if (status != EFI_SUCCESS) {
+		efi_warn("Failed to set memory attributes at [%08lx,%08lx]: %lx",
+			 (unsigned long)rounded_start,
+			 (unsigned long)rounded_end,
+			 status);
+	}
+
+	return status;
+}
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index d9bb9125d518..95a69c37518e 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -23,7 +23,6 @@
 #define MAXMEM_X86_64_4LEVEL (1ull << 46)
 
 const efi_system_table_t *efi_system_table;
-const efi_dxe_services_table_t *efi_dxe_table;
 extern u32 image_offset;
 static efi_loaded_image_t *image = NULL;
 
@@ -358,15 +357,6 @@ static void setup_sections_memory_protection(void *image_base,
 					     unsigned long init_size)
 {
 #ifdef CONFIG_EFI_DXE_MEM_ATTRIBUTES
-	efi_dxe_table = get_efi_config_table(EFI_DXE_SERVICES_TABLE_GUID);
-
-	if (!efi_dxe_table ||
-	    efi_dxe_table->hdr.signature != EFI_DXE_SERVICES_TABLE_SIGNATURE) {
-		efi_warn("Unable to locate EFI DXE services table\n");
-		efi_dxe_table = NULL;
-		return;
-	}
-
 	/* .setup [image_base, _head] */
 	efi_adjust_memory_range_protection((unsigned long)image_base,
 					   (unsigned long)_head - (unsigned long)image_base,
@@ -736,13 +726,6 @@ asmlinkage unsigned long efi_main(efi_handle_t handle,
 	if (efi_system_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
 		efi_exit(handle, EFI_INVALID_PARAMETER);
 
-	efi_dxe_table = get_efi_config_table(EFI_DXE_SERVICES_TABLE_GUID);
-	if (efi_dxe_table &&
-	    efi_dxe_table->hdr.signature != EFI_DXE_SERVICES_TABLE_SIGNATURE) {
-		efi_warn("Ignoring DXE services table: invalid signature\n");
-		efi_dxe_table = NULL;
-	}
-
 #ifdef CONFIG_CMDLINE_BOOL
 	status = efi_parse_options(CONFIG_CMDLINE);
 	if (status != EFI_SUCCESS) {
-- 
2.37.4

