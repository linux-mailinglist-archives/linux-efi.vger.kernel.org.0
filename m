Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4A1D12A2DC
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2019 16:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfLXPLK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Dec 2019 10:11:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:51106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727156AbfLXPLI (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 24 Dec 2019 10:11:08 -0500
Received: from localhost.localdomain (aaubervilliers-681-1-7-6.w90-88.abo.wanadoo.fr [90.88.129.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82ADE2071E;
        Tue, 24 Dec 2019 15:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577200267;
        bh=OZpCklLPne7g1i5x7e1Z2ZKguigGZtO5Aw8mBZEF+2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sTBlgmT7jaKABPeLJUUeVtb3/rUruPHBvSvnB1vg2ou9gV/vemhxWM95q3kyIuYpQ
         igjeDraxk/3FZryhmBJrRfLvuGYwwWIRjFyCVfS4JbgHbvqx7iqvuQgiWhmz3Bqed8
         Vhr3QEJkuEC1l2YylX2eVZufNkn3CUDdA+ZDJmEM=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH 14/25] efi/libstub: avoid protocol wrapper for file I/O routines
Date:   Tue, 24 Dec 2019 16:10:14 +0100
Message-Id: <20191224151025.32482-15-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224151025.32482-1-ardb@kernel.org>
References: <20191224151025.32482-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The EFI file I/O routines built on top of the file I/O firmware
services are incompatible with mixed mode, so there is no need
to obfuscate them by using protocol wrappers whose only purpose
is to hide the mixed mode handling. So let's switch to plain
indirect calls instead.

This also means we can drop the mixed_mode aliases from the various
types involved.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 .../firmware/efi/libstub/efi-stub-helper.c    |  17 ++-
 include/linux/efi.h                           | 118 ++++++------------
 2 files changed, 46 insertions(+), 89 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index f91f4fdbe553..9bb74ad4b7fe 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -370,8 +370,7 @@ static efi_status_t efi_file_size(efi_system_table_t *sys_table_arg, void *__fh,
 	efi_guid_t info_guid = EFI_FILE_INFO_ID;
 	unsigned long info_sz;
 
-	status = efi_call_proto(efi_file_handle, open, fh, &h, filename_16,
-				EFI_FILE_MODE_READ, (u64)0);
+	status = fh->open(fh, &h, filename_16, EFI_FILE_MODE_READ, 0);
 	if (status != EFI_SUCCESS) {
 		efi_printk(sys_table_arg, "Failed to open file: ");
 		efi_char16_printk(sys_table_arg, filename_16);
@@ -382,8 +381,7 @@ static efi_status_t efi_file_size(efi_system_table_t *sys_table_arg, void *__fh,
 	*handle = h;
 
 	info_sz = 0;
-	status = efi_call_proto(efi_file_handle, get_info, h, &info_guid,
-				&info_sz, NULL);
+	status = h->get_info(h, &info_guid, &info_sz, NULL);
 	if (status != EFI_BUFFER_TOO_SMALL) {
 		efi_printk(sys_table_arg, "Failed to get file info size\n");
 		return status;
@@ -397,8 +395,7 @@ static efi_status_t efi_file_size(efi_system_table_t *sys_table_arg, void *__fh,
 		return status;
 	}
 
-	status = efi_call_proto(efi_file_handle, get_info, h, &info_guid,
-				&info_sz, info);
+	status = h->get_info(h, &info_guid, &info_sz, info);
 	if (status == EFI_BUFFER_TOO_SMALL) {
 		efi_call_early(free_pool, info);
 		goto grow;
@@ -416,12 +413,12 @@ static efi_status_t efi_file_size(efi_system_table_t *sys_table_arg, void *__fh,
 static efi_status_t efi_file_read(efi_file_handle_t *handle,
 				  unsigned long *size, void *addr)
 {
-	return efi_call_proto(efi_file_handle, read, handle, size, addr);
+	return handle->read(handle, size, addr);
 }
 
 static efi_status_t efi_file_close(efi_file_handle_t *handle)
 {
-	return efi_call_proto(efi_file_handle, close, handle);
+	return handle->close(handle);
 }
 
 static efi_status_t efi_open_volume(efi_system_table_t *sys_table_arg,
@@ -432,7 +429,7 @@ static efi_status_t efi_open_volume(efi_system_table_t *sys_table_arg,
 	efi_file_handle_t *fh;
 	efi_guid_t fs_proto = EFI_FILE_SYSTEM_GUID;
 	efi_status_t status;
-	void *handle = efi_table_attr(efi_loaded_image, device_handle, image);
+	efi_handle_t handle = image->device_handle;
 
 	status = efi_call_early(handle_protocol, handle,
 				&fs_proto, (void **)&io);
@@ -441,7 +438,7 @@ static efi_status_t efi_open_volume(efi_system_table_t *sys_table_arg,
 		return status;
 	}
 
-	status = efi_call_proto(efi_file_io_interface, open_volume, io, &fh);
+	status = io->open_volume(io, &fh);
 	if (status != EFI_SUCCESS)
 		efi_printk(sys_table_arg, "Failed to open volume\n");
 	else
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 2074b737aa17..14dd08ecf8a7 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -806,40 +806,21 @@ struct efi_fdt_params {
 	u32 desc_ver;
 };
 
-typedef union efi_loaded_image efi_loaded_image_t;
-
-union efi_loaded_image {
-	struct {
-		u32 revision;
-		efi_handle_t parent_handle;
-		efi_system_table_t *system_table;
-		efi_handle_t device_handle;
-		void *file_path;
-		void *reserved;
-		u32 load_options_size;
-		void *load_options;
-		void *image_base;
-		__aligned_u64 image_size;
-		unsigned int image_code_type;
-		unsigned int image_data_type;
-		efi_status_t ( __efiapi *unload)(efi_handle_t image_handle);
-	};
-	struct {
-		u32 revision;
-		u32 parent_handle;
-		u32 system_table;
-		u32 device_handle;
-		u32 file_path;
-		u32 reserved;
-		u32 load_options_size;
-		u32 load_options;
-		u32 image_base;
-		__aligned_u64 image_size;
-		unsigned int image_code_type;
-		unsigned int image_data_type;
-		u32 unload;
-	} mixed_mode;
-};
+typedef struct {
+	u32 revision;
+	efi_handle_t parent_handle;
+	efi_system_table_t *system_table;
+	efi_handle_t device_handle;
+	void *file_path;
+	void *reserved;
+	u32 load_options_size;
+	void *load_options;
+	void *image_base;
+	__aligned_u64 image_size;
+	unsigned int image_code_type;
+	unsigned int image_data_type;
+	efi_status_t ( __efiapi *unload)(efi_handle_t image_handle);
+} efi_loaded_image_t;
 
 typedef struct {
 	u64 size;
@@ -852,54 +833,33 @@ typedef struct {
 	efi_char16_t filename[1];
 } efi_file_info_t;
 
-typedef union efi_file_handle efi_file_handle_t;
-
-union efi_file_handle {
-	struct {
-		u64 revision;
-		efi_status_t (__efiapi *open)(efi_file_handle_t *,
-					      efi_file_handle_t **,
-					      efi_char16_t *, u64, u64);
-		efi_status_t (__efiapi *close)(efi_file_handle_t *);
-		void *delete;
-		efi_status_t (__efiapi *read)(efi_file_handle_t *,
-					      unsigned long *, void *);
-		void *write;
-		void *get_position;
-		void *set_position;
-		efi_status_t (__efiapi *get_info)(efi_file_handle_t *,
-						  efi_guid_t *, unsigned long *,
-						  void *);
-		void *set_info;
-		void *flush;
-	};
-	struct {
-		u64 revision;
-		u32 open;
-		u32 close;
-		u32 delete;
-		u32 read;
-		u32 write;
-		u32 get_position;
-		u32 set_position;
-		u32 get_info;
-		u32 set_info;
-		u32 flush;
-	} mixed_mode;
+typedef struct efi_file_handle efi_file_handle_t;
+
+struct efi_file_handle {
+	u64 revision;
+	efi_status_t (__efiapi *open)(efi_file_handle_t *,
+				      efi_file_handle_t **,
+				      efi_char16_t *, u64, u64);
+	efi_status_t (__efiapi *close)(efi_file_handle_t *);
+	void *delete;
+	efi_status_t (__efiapi *read)(efi_file_handle_t *,
+				      unsigned long *, void *);
+	void *write;
+	void *get_position;
+	void *set_position;
+	efi_status_t (__efiapi *get_info)(efi_file_handle_t *,
+					  efi_guid_t *, unsigned long *,
+					  void *);
+	void *set_info;
+	void *flush;
 };
 
-typedef union efi_file_io_interface efi_file_io_interface_t;
+typedef struct efi_file_io_interface efi_file_io_interface_t;
 
-union efi_file_io_interface {
-	struct {
-		u64 revision;
-		int (__efiapi *open_volume)(efi_file_io_interface_t *,
-					    efi_file_handle_t **);
-	};
-	struct {
-		u64 revision;
-		u32 open_volume;
-	} mixed_mode;
+struct efi_file_io_interface {
+	u64 revision;
+	int (__efiapi *open_volume)(efi_file_io_interface_t *,
+				    efi_file_handle_t **);
 };
 
 #define EFI_FILE_MODE_READ	0x0000000000000001
-- 
2.20.1

