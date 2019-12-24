Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E23D512A2DA
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2019 16:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfLXPLE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Dec 2019 10:11:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:50992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727076AbfLXPLD (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 24 Dec 2019 10:11:03 -0500
Received: from localhost.localdomain (aaubervilliers-681-1-7-6.w90-88.abo.wanadoo.fr [90.88.129.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9FF820706;
        Tue, 24 Dec 2019 15:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577200263;
        bh=1SQCSvwuUVG8z96AKDBLUtCClBuvohWAIyRuGQEl9G8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LmfB0Fdy7af84kGnqCjYoG1RqwkWaaSEjHwrrvGr/xMIIWWHiR/WvBLtQQEQ5YQzZ
         VY1V7H6757xvi9p+D70ZGmUqcR8B7KAifZ48oNIAdcvEylZc5niXE4J6khOnth1wX1
         Lf3BmbSGGZ2oLQYwMzAIv783V6RcKKiCqa6teHj8=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH 11/25] efi/libstub: use stricter typing for firmware function pointers
Date:   Tue, 24 Dec 2019 16:10:11 +0100
Message-Id: <20191224151025.32482-12-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224151025.32482-1-ardb@kernel.org>
References: <20191224151025.32482-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

We will soon remove another level of pointer casting, so let's make
sure all type handling involving firmware calls at boot time is correct.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/eboot.c               | 10 ++++++----
 arch/x86/boot/compressed/eboot.h               |  9 ++++++---
 arch/x86/platform/efi/efi.c                    |  4 ++--
 arch/x86/xen/efi.c                             |  2 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c |  5 +++--
 drivers/firmware/efi/libstub/tpm.c             |  4 ++--
 include/linux/efi.h                            | 12 ++++++++----
 7 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 990b93379965..2733bc263c04 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -70,7 +70,8 @@ preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
 
 	size = romsize + sizeof(*rom);
 
-	status = efi_call_early(allocate_pool, EFI_LOADER_DATA, size, &rom);
+	status = efi_call_early(allocate_pool, EFI_LOADER_DATA, size,
+				(void **)&rom);
 	if (status != EFI_SUCCESS) {
 		efi_printk(sys_table, "Failed to allocate memory for 'rom'\n");
 		return status;
@@ -195,9 +196,9 @@ static void retrieve_apple_device_properties(struct boot_params *boot_params)
 	struct setup_data *data, *new;
 	efi_status_t status;
 	u32 size = 0;
-	void *p;
+	apple_properties_protocol_t *p;
 
-	status = efi_call_early(locate_protocol, &guid, NULL, &p);
+	status = efi_call_early(locate_protocol, &guid, NULL, (void **)&p);
 	if (status != EFI_SUCCESS)
 		return;
 
@@ -212,7 +213,8 @@ static void retrieve_apple_device_properties(struct boot_params *boot_params)
 
 	do {
 		status = efi_call_early(allocate_pool, EFI_LOADER_DATA,
-					size + sizeof(struct setup_data), &new);
+					size + sizeof(struct setup_data),
+					(void **)&new);
 		if (status != EFI_SUCCESS) {
 			efi_printk(sys_table, "Failed to allocate memory for 'properties'\n");
 			return;
diff --git a/arch/x86/boot/compressed/eboot.h b/arch/x86/boot/compressed/eboot.h
index de13865dc7d2..b8d11928f528 100644
--- a/arch/x86/boot/compressed/eboot.h
+++ b/arch/x86/boot/compressed/eboot.h
@@ -12,9 +12,12 @@
 
 #define DESC_TYPE_CODE_DATA	(1 << 0)
 
-typedef union {
+typedef union efi_uga_draw_protocol efi_uga_draw_protocol_t;
+
+union efi_uga_draw_protocol {
 	struct {
-		void *get_mode;
+		efi_status_t (*get_mode)(efi_uga_draw_protocol_t *,
+					 u32*, u32*, u32*, u32*);
 		void *set_mode;
 		void *blt;
 	};
@@ -23,6 +26,6 @@ typedef union {
 		u32 set_mode;
 		u32 blt;
 	} mixed_mode;
-} efi_uga_draw_protocol_t;
+};
 
 #endif /* BOOT_COMPRESSED_EBOOT_H */
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index e188b7ce0796..d96953d9d4e7 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -385,7 +385,7 @@ static int __init efi_systab_init(void *phys)
 		tmp |= systab64->con_in;
 		efi_systab.con_out_handle = systab64->con_out_handle;
 		tmp |= systab64->con_out_handle;
-		efi_systab.con_out = systab64->con_out;
+		efi_systab.con_out = (void *)(unsigned long)systab64->con_out;
 		tmp |= systab64->con_out;
 		efi_systab.stderr_handle = systab64->stderr_handle;
 		tmp |= systab64->stderr_handle;
@@ -427,7 +427,7 @@ static int __init efi_systab_init(void *phys)
 		efi_systab.con_in_handle = systab32->con_in_handle;
 		efi_systab.con_in = systab32->con_in;
 		efi_systab.con_out_handle = systab32->con_out_handle;
-		efi_systab.con_out = systab32->con_out;
+		efi_systab.con_out = (void *)(unsigned long)systab32->con_out;
 		efi_systab.stderr_handle = systab32->stderr_handle;
 		efi_systab.stderr = systab32->stderr;
 		efi_systab.runtime = (void *)(unsigned long)systab32->runtime;
diff --git a/arch/x86/xen/efi.c b/arch/x86/xen/efi.c
index a04551ee5568..1abe455d926a 100644
--- a/arch/x86/xen/efi.c
+++ b/arch/x86/xen/efi.c
@@ -31,7 +31,7 @@ static efi_system_table_t efi_systab_xen __initdata = {
 	.con_in_handle	= EFI_INVALID_TABLE_ADDR, /* Not used under Xen. */
 	.con_in		= EFI_INVALID_TABLE_ADDR, /* Not used under Xen. */
 	.con_out_handle	= EFI_INVALID_TABLE_ADDR, /* Not used under Xen. */
-	.con_out	= EFI_INVALID_TABLE_ADDR, /* Not used under Xen. */
+	.con_out	= NULL, 		  /* Not used under Xen. */
 	.stderr_handle	= EFI_INVALID_TABLE_ADDR, /* Not used under Xen. */
 	.stderr		= EFI_INVALID_TABLE_ADDR, /* Not used under Xen. */
 	.runtime	= (efi_runtime_services_t *)EFI_INVALID_TABLE_ADDR,
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 1a814dc235ba..f91f4fdbe553 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -413,12 +413,13 @@ static efi_status_t efi_file_size(efi_system_table_t *sys_table_arg, void *__fh,
 	return status;
 }
 
-static efi_status_t efi_file_read(void *handle, unsigned long *size, void *addr)
+static efi_status_t efi_file_read(efi_file_handle_t *handle,
+				  unsigned long *size, void *addr)
 {
 	return efi_call_proto(efi_file_handle, read, handle, size, addr);
 }
 
-static efi_status_t efi_file_close(void *handle)
+static efi_status_t efi_file_close(efi_file_handle_t *handle)
 {
 	return efi_call_proto(efi_file_handle, close, handle);
 }
diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index eb9af83e4d59..d270acd43de8 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -69,11 +69,11 @@ void efi_retrieve_tpm2_eventlog(efi_system_table_t *sys_table_arg)
 	size_t log_size, last_entry_size;
 	efi_bool_t truncated;
 	int version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_2;
-	void *tcg2_protocol = NULL;
+	efi_tcg2_protocol_t *tcg2_protocol = NULL;
 	int final_events_size = 0;
 
 	status = efi_call_early(locate_protocol, &tcg2_guid, NULL,
-				&tcg2_protocol);
+				(void **)&tcg2_protocol);
 	if (status != EFI_SUCCESS)
 		return;
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index d8e987910853..880077639113 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -382,7 +382,11 @@ union efi_pci_io_protocol {
 		void *allocate_buffer;
 		void *free_buffer;
 		void *flush;
-		void *get_location;
+		efi_status_t (*get_location)(efi_pci_io_protocol_t *,
+					     unsigned long *segment_nr,
+					     unsigned long *bus_nr,
+					     unsigned long *device_nr,
+					     unsigned long *function_nr);
 		void *attributes;
 		void *get_bar_attributes;
 		void *set_bar_attributes;
@@ -730,6 +734,8 @@ typedef struct {
 	u32 tables;
 } efi_system_table_32_t;
 
+typedef union efi_simple_text_output_protocol efi_simple_text_output_protocol_t;
+
 typedef union {
 	struct {
 		efi_table_hdr_t hdr;
@@ -738,7 +744,7 @@ typedef union {
 		unsigned long con_in_handle;
 		unsigned long con_in;
 		unsigned long con_out_handle;
-		unsigned long con_out;
+		efi_simple_text_output_protocol_t *con_out;
 		unsigned long stderr_handle;
 		unsigned long stderr;
 		efi_runtime_services_t *runtime;
@@ -1337,8 +1343,6 @@ struct efivar_entry {
 	bool deleting;
 };
 
-typedef union efi_simple_text_output_protocol efi_simple_text_output_protocol_t;
-
 union efi_simple_text_output_protocol {
 	struct {
 		void *reset;
-- 
2.20.1

