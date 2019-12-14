Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79A8B11F33C
	for <lists+linux-efi@lfdr.de>; Sat, 14 Dec 2019 18:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfLNR5u (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 14 Dec 2019 12:57:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:44212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfLNR5t (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 14 Dec 2019 12:57:49 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F95C24658;
        Sat, 14 Dec 2019 17:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576346268;
        bh=ClNPNQkcULHMe6x4ESqX9wm1W8QH2TUNVHmuKcuRwAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z2sMtPL4/onveciJrsEKn1D1YIew9yew5b6rdcxhhW9HklmpUYM65a+6ELwNZYviz
         UVzWsBkBZdWiBcSHcenRtlikdQN/xyw9LAQ+ExOr4YZza5jskeTPT79RmHKAMgFc+/
         KhHbKHg1h7p1gsVrOyGSPsywUAG96G6MeieRK+dQ=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH 03/10] efi/libstub: use a helper to iterate over a EFI handle array
Date:   Sat, 14 Dec 2019 18:57:28 +0100
Message-Id: <20191214175735.22518-4-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191214175735.22518-1-ardb@kernel.org>
References: <20191214175735.22518-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Iterating over a EFI handle array is a bit finicky, since we have
to take mixed mode into account, where handles are only 32-bit
while the native efi_handle_t type is 64-bit.

So introduce a helper, and replace the various occurrences of
this pattern.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/eboot.c   | 14 +++++---------
 drivers/firmware/efi/libstub/gop.c |  9 ++-------
 drivers/firmware/efi/libstub/pci.c |  9 +++------
 include/linux/efi.h                | 10 ++++++++++
 4 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 0f1edd2c49fc..34962f2f3337 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -135,6 +135,7 @@ static void setup_efi_pci(struct boot_params *params)
 	unsigned long size = 0;
 	unsigned long nr_pci;
 	struct setup_data *data;
+	efi_handle_t h;
 	int i;
 
 	efi_pci_disable_bridge_busmaster(sys_table);
@@ -166,14 +167,11 @@ static void setup_efi_pci(struct boot_params *params)
 	while (data && data->next)
 		data = (struct setup_data *)(unsigned long)data->next;
 
-	nr_pci = size / (efi_is_64bit() ? sizeof(u64) : sizeof(u32));
-	for (i = 0; i < nr_pci; i++) {
+	for_each_efi_handle(h, pci_handle, size, i) {
 		efi_pci_io_protocol_t *pci = NULL;
 		struct pci_setup_rom *rom;
 
-		status = efi_call_early(handle_protocol,
-					efi_is_64bit() ? ((u64 *)pci_handle)[i]
-						       : ((u32 *)pci_handle)[i],
+		status = efi_call_early(handle_protocol, h,
 					&pci_proto, (void **)&pci);
 		if (status != EFI_SUCCESS || !pci)
 			continue;
@@ -268,6 +266,7 @@ setup_uga(struct screen_info *si, efi_guid_t *uga_proto, unsigned long size)
 	void **uga_handle = NULL;
 	efi_uga_draw_protocol_t *uga = NULL, *first_uga;
 	unsigned long nr_ugas;
+	efi_handle_t handle;
 	int i;
 
 	status = efi_call_early(allocate_pool, EFI_LOADER_DATA,
@@ -285,13 +284,10 @@ setup_uga(struct screen_info *si, efi_guid_t *uga_proto, unsigned long size)
 	width = 0;
 
 	first_uga = NULL;
-	nr_ugas = size / (efi_is_64bit() ? sizeof(u64) : sizeof(u32));
-	for (i = 0; i < nr_ugas; i++) {
+	for_each_efi_handle(handle, uga_handle, size, i) {
 		efi_guid_t pciio_proto = EFI_PCI_IO_PROTOCOL_GUID;
 		u32 w, h, depth, refresh;
 		void *pciio;
-		unsigned long handle = efi_is_64bit() ? ((u64 *)uga_handle)[i]
-						      : ((u32 *)uga_handle)[i];
 
 		status = efi_call_early(handle_protocol, handle,
 					uga_proto, (void **)&uga);
diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index 94045ab7dd3d..5f4fbc2ac687 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -91,7 +91,6 @@ setup_gop(efi_system_table_t *sys_table_arg, struct screen_info *si,
 	  efi_guid_t *proto, unsigned long size, void **handles)
 {
 	efi_graphics_output_protocol_t *gop, *first_gop;
-	unsigned long nr_gops;
 	u16 width, height;
 	u32 pixels_per_scan_line;
 	u32 ext_lfb_base;
@@ -99,22 +98,18 @@ setup_gop(efi_system_table_t *sys_table_arg, struct screen_info *si,
 	efi_pixel_bitmask_t pixel_info;
 	int pixel_format;
 	efi_status_t status;
+	efi_handle_t h;
 	int i;
-	bool is64 = efi_is_64bit();
 
 	first_gop = NULL;
 	gop = NULL;
 
-	nr_gops = size / (is64 ? sizeof(u64) : sizeof(u32));
-	for (i = 0; i < nr_gops; i++) {
+	for_each_efi_handle(h, handles, size, i) {
 		efi_graphics_output_protocol_mode_t *mode;
 		efi_graphics_output_mode_info_t *info = NULL;
 		efi_guid_t conout_proto = EFI_CONSOLE_OUT_DEVICE_GUID;
 		bool conout_found = false;
 		void *dummy = NULL;
-		efi_handle_t h = (efi_handle_t)(unsigned long)
-				 (is64 ? ((u64 *)handles)[i]
-				       : ((u32 *)handles)[i]);
 		efi_physical_addr_t current_fb_base;
 
 		status = efi_call_early(handle_protocol, h,
diff --git a/drivers/firmware/efi/libstub/pci.c b/drivers/firmware/efi/libstub/pci.c
index f792b241383d..d144551e36eb 100644
--- a/drivers/firmware/efi/libstub/pci.c
+++ b/drivers/firmware/efi/libstub/pci.c
@@ -19,8 +19,8 @@ void efi_pci_disable_bridge_busmaster(efi_system_table_t *sys_table_arg)
 	void **pci_handle = NULL;
 	efi_guid_t pci_proto = EFI_PCI_IO_PROTOCOL_GUID;
 	unsigned long size = 0;
-	unsigned long nr_pci;
 	u16 class, command;
+	efi_handle_t handle;
 	int i;
 
 	if (!nobusmaster())
@@ -49,13 +49,10 @@ void efi_pci_disable_bridge_busmaster(efi_system_table_t *sys_table_arg)
 	if (status != EFI_SUCCESS)
 		goto free_handle;
 
-	nr_pci = size / (efi_is_64bit() ? sizeof(u64) : sizeof(u32));
-	for (i = 0; i < nr_pci; i++) {
+	for_each_efi_handle(handle, pci_handle, size, i) {
 		efi_pci_io_protocol_t *pci = NULL;
-		unsigned long handle = efi_is_64bit() ? ((u64 *)pci_handle)[i]
-						      : ((u32 *)pci_handle)[i];
 
-		status = efi_call_early(handle_protocol, (efi_handle_t)handle,
+		status = efi_call_early(handle_protocol, handle,
 					&pci_proto, (void **)&pci);
 		if (status != EFI_SUCCESS || !pci)
 			continue;
diff --git a/include/linux/efi.h b/include/linux/efi.h
index de2087149089..d7ca0b85b2b5 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -48,6 +48,16 @@ typedef u16 efi_char16_t;		/* UNICODE character */
 typedef u64 efi_physical_addr_t;
 typedef void *efi_handle_t;
 
+#define for_each_efi_handle(handle, array, size, i)			\
+	for (i = 1, handle = efi_is_64bit()				\
+		? (efi_handle_t)(unsigned long)((u64 *)(array))[0]	\
+		: (efi_handle_t)(unsigned long)((u32 *)(array))[0];	\
+	    i++ <= (size) / (efi_is_64bit() ? sizeof(efi_handle_t)	\
+					     : sizeof(u32));		\
+	    handle = efi_is_64bit()					\
+		? (efi_handle_t)(unsigned long)((u64 *)(array))[i]	\
+		: (efi_handle_t)(unsigned long)((u32 *)(array))[i])
+
 /*
  * The UEFI spec and EDK2 reference implementation both define EFI_GUID as
  * struct { u32 a; u16; b; u16 c; u8 d[8]; }; and so the implied alignment
-- 
2.17.1

