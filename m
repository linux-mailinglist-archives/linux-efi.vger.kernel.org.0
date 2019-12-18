Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F71C124EAB
	for <lists+linux-efi@lfdr.de>; Wed, 18 Dec 2019 18:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfLRRCm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Dec 2019 12:02:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:53564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727368AbfLRRCl (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 18 Dec 2019 12:02:41 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAEC024676;
        Wed, 18 Dec 2019 17:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576688561;
        bh=VMf7iaANG+t8tMZObUMw3m28s6bToSmHy/xDI24tPM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rvHxEpibuX6lfLzhsFBPXqFKwZlTa1iECpu03W1+Rv9ydLiQ1a1cXrYpd4NNTenu+
         LqEI++Y/HV8GNbnBIJKUzBfjXdC8HL/GXyqkdZAlruAILg046sXpkGIPKbHLbqRW5+
         S2j08KBhRtsnFJnXxxrNFVQKK9Kckhd78rpssLIk=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH v2 08/21] efi/libstub: use stricter typing for firmware function pointers
Date:   Wed, 18 Dec 2019 19:01:26 +0200
Message-Id: <20191218170139.9468-9-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191218170139.9468-1-ardb@kernel.org>
References: <20191218170139.9468-1-ardb@kernel.org>
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
 drivers/firmware/efi/libstub/efi-stub-helper.c |  5 +++--
 drivers/firmware/efi/libstub/tpm.c             |  4 ++--
 include/linux/efi.h                            |  6 +++++-
 5 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index f9074f12e89f..4a965212ee64 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -63,7 +63,8 @@ preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
 
 	size = romsize + sizeof(*rom);
 
-	status = efi_call_early(allocate_pool, EFI_LOADER_DATA, size, &rom);
+	status = efi_call_early(allocate_pool, EFI_LOADER_DATA, size,
+				(void **)&rom);
 	if (status != EFI_SUCCESS) {
 		efi_printk(sys_table, "Failed to allocate memory for 'rom'\n");
 		return status;
@@ -188,9 +189,9 @@ static void retrieve_apple_device_properties(struct boot_params *boot_params)
 	struct setup_data *data, *new;
 	efi_status_t status;
 	u32 size = 0;
-	void *p;
+	apple_properties_protocol_t *p;
 
-	status = efi_call_early(locate_protocol, &guid, NULL, &p);
+	status = efi_call_early(locate_protocol, &guid, NULL, (void **)&p);
 	if (status != EFI_SUCCESS)
 		return;
 
@@ -205,7 +206,8 @@ static void retrieve_apple_device_properties(struct boot_params *boot_params)
 
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
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 489c4febc185..5eaf6ada960f 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -418,12 +418,13 @@ static efi_status_t efi_file_size(efi_system_table_t *sys_table_arg, void *__fh,
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
index d09ce1cea130..969eb06e780a 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -388,7 +388,11 @@ union efi_pci_io_protocol {
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
-- 
2.17.1

