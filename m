Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF2611F345
	for <lists+linux-efi@lfdr.de>; Sat, 14 Dec 2019 18:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfLNR6E (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 14 Dec 2019 12:58:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:44546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727283AbfLNR6D (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 14 Dec 2019 12:58:03 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E09752465E;
        Sat, 14 Dec 2019 17:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576346282;
        bh=E+ODH1tNA1H+uHw7SgnE3Ikf13/PXAVJ/8fDpFKDCn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z7j8yHeKTWdQV8f0vFafQihw/FRbDfB7ppGlmC9bogxoGq2wZGIXp5dP8LU1Mr0Qq
         Canx398/WbuGT3Y8QynhNEEvIUe5079GCB8DT+1NoFRKfbNRBRCst/KQkvCOtPWV+c
         IAwebkrI8y5y3YcDnYYKfxrrqc36wa6rkhh6kbss=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH 08/10] efi/libstub: use stricter typing for firmware function pointers
Date:   Sat, 14 Dec 2019 18:57:33 +0100
Message-Id: <20191214175735.22518-9-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191214175735.22518-1-ardb@kernel.org>
References: <20191214175735.22518-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

We will soon remove another level of pointer casting, so let's make
sure all type handling involving firmware calls at boot time is correct.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/eboot.c               | 10 ++++++----
 arch/x86/boot/compressed/eboot.h               |  5 +++--
 drivers/firmware/efi/libstub/efi-stub-helper.c |  5 +++--
 drivers/firmware/efi/libstub/tpm.c             |  4 ++--
 include/linux/efi.h                            |  6 +++++-
 5 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 6d833f93a878..052852eaa076 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -64,7 +64,8 @@ preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
 
 	size = romsize + sizeof(*rom);
 
-	status = efi_call_early(allocate_pool, EFI_LOADER_DATA, size, &rom);
+	status = efi_call_early(allocate_pool, EFI_LOADER_DATA, size,
+				(void **)&rom);
 	if (status != EFI_SUCCESS) {
 		efi_printk(sys_table, "Failed to allocate memory for 'rom'\n");
 		return status;
@@ -191,9 +192,9 @@ static void retrieve_apple_device_properties(struct boot_params *boot_params)
 	struct setup_data *data, *new;
 	efi_status_t status;
 	u32 size = 0;
-	void *p;
+	apple_properties_protocol_t *p;
 
-	status = efi_call_early(locate_protocol, &guid, NULL, &p);
+	status = efi_call_early(locate_protocol, &guid, NULL, (void **)&p);
 	if (status != EFI_SUCCESS)
 		return;
 
@@ -208,7 +209,8 @@ static void retrieve_apple_device_properties(struct boot_params *boot_params)
 
 	do {
 		status = efi_call_early(allocate_pool, EFI_LOADER_DATA,
-					size + sizeof(struct setup_data), &new);
+					size + sizeof(struct setup_data),
+					(void **)&new);
 		if (status != EFI_SUCCESS) {
 			efi_printk(sys_table, "Failed to allocate memory for 'properties'\n");
 			return;
diff --git a/arch/x86/boot/compressed/eboot.h b/arch/x86/boot/compressed/eboot.h
index 1cf384ba1b0e..318531f128c2 100644
--- a/arch/x86/boot/compressed/eboot.h
+++ b/arch/x86/boot/compressed/eboot.h
@@ -18,8 +18,9 @@ typedef struct {
 	u32 blt;
 } efi_uga_draw_protocol_32_t;
 
-typedef struct {
-	void *get_mode;
+typedef struct efi_uga_draw_protocol {
+	efi_status_t (*get_mode)(struct efi_uga_draw_protocol *,
+				 u32*, u32*, u32*, u32*);
 	void *set_mode;
 	void *blt;
 } efi_uga_draw_protocol_t;
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index ff3266b9f673..5bb1715cb154 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -423,12 +423,13 @@ static efi_status_t efi_file_size(efi_system_table_t *sys_table_arg, void *__fh,
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
index 0354d35ebaa7..83cf204bfe8f 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -59,11 +59,11 @@ void efi_retrieve_tpm2_eventlog(efi_system_table_t *sys_table_arg)
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
index 87c2537b4543..7f1a99bd2c05 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -399,7 +399,11 @@ struct efi_pci_io_protocol {
 	void *allocate_buffer;
 	void *free_buffer;
 	void *flush;
-	void *get_location;
+	efi_status_t (*get_location)(struct efi_pci_io_protocol *,
+				     unsigned long *segment_nr,
+				     unsigned long *bus_nr,
+				     unsigned long *device_nr,
+				     unsigned long *function_nr);
 	void *attributes;
 	void *get_bar_attributes;
 	void *set_bar_attributes;
-- 
2.17.1

