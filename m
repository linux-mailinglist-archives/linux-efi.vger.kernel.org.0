Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7198D12A2D7
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2019 16:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfLXPK7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Dec 2019 10:10:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:50860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbfLXPK6 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 24 Dec 2019 10:10:58 -0500
Received: from localhost.localdomain (aaubervilliers-681-1-7-6.w90-88.abo.wanadoo.fr [90.88.129.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 870812075E;
        Tue, 24 Dec 2019 15:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577200256;
        bh=qh/wFDw1SpskrhI3GtPRLq8DAoNGiUeXgNHrtaWwdB8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HSzMpc0gyuAephYKhYgvMSzcaGYgaQqDV2VZ1Kf6QTqvKJtNKxn8jRdcxL66PU/4T
         srrcgsBIaHR6XRDA97hKNwCKJdDmEPkzgu0/8F24LqGydrv7eobJbtkyPO4BQt21u9
         ktakC5KmTpLaXhtXk6vu4IaWRhmR87QOfIs8MUew=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH 07/25] efi/libstub: use a helper to iterate over a EFI handle array
Date:   Tue, 24 Dec 2019 16:10:07 +0100
Message-Id: <20191224151025.32482-8-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224151025.32482-1-ardb@kernel.org>
References: <20191224151025.32482-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 include/linux/efi.h                | 13 +++++++++++++
 3 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 72b08fde6de6..959bcdd8c1fe 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -135,6 +135,7 @@ static void setup_efi_pci(struct boot_params *params)
 	unsigned long size = 0;
 	unsigned long nr_pci;
 	struct setup_data *data;
+	efi_handle_t h;
 	int i;
 
 	status = efi_call_early(locate_handle,
@@ -164,14 +165,11 @@ static void setup_efi_pci(struct boot_params *params)
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
@@ -266,6 +264,7 @@ setup_uga(struct screen_info *si, efi_guid_t *uga_proto, unsigned long size)
 	void **uga_handle = NULL;
 	efi_uga_draw_protocol_t *uga = NULL, *first_uga;
 	unsigned long nr_ugas;
+	efi_handle_t handle;
 	int i;
 
 	status = efi_call_early(allocate_pool, EFI_LOADER_DATA,
@@ -283,13 +282,10 @@ setup_uga(struct screen_info *si, efi_guid_t *uga_proto, unsigned long size)
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
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 561db9deedae..8d267715ce22 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -48,6 +48,19 @@ typedef u16 efi_char16_t;		/* UNICODE character */
 typedef u64 efi_physical_addr_t;
 typedef void *efi_handle_t;
 
+#define efi_get_handle_at(array, idx)					\
+	(efi_is_64bit() ? (efi_handle_t)(unsigned long)((u64 *)(array))[idx] \
+		: (efi_handle_t)(unsigned long)((u32 *)(array))[idx])
+
+#define efi_get_handle_num(size)					\
+	((size) / (efi_is_64bit() ? sizeof(u64) : sizeof(u32)))
+
+#define for_each_efi_handle(handle, array, size, i)			\
+	for (i = 0;							\
+	     i < efi_get_handle_num(size) &&				\
+		((handle = efi_get_handle_at((array), i)) || true);	\
+	     i++)
+
 /*
  * The UEFI spec and EDK2 reference implementation both define EFI_GUID as
  * struct { u32 a; u16; b; u16 c; u8 d[8]; }; and so the implied alignment
-- 
2.20.1

