Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7AA157F5E
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2020 17:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgBJQDN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Feb 2020 11:03:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:52754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727435AbgBJQDN (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 10 Feb 2020 11:03:13 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 813DF2168B;
        Mon, 10 Feb 2020 16:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581350591;
        bh=fR1MLajy12VAkBQ+CZ5rb2XrJWUYT3T4nVepKlgAaIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2B3baBq5taQgHkKNPC/MMqcamQZVjTrqBbkQOVzocSvYSUc8ugahQyD0fhd7MwRze
         98iRdwAj90RQ9TkgvEUQLruo7nUQgm0six4LpfX/3GfOOLsZ/koQurDDLUOgk2MY9d
         DdHLFnZgsFuZdD4TKxrGuFhulqtxh/ZzwstJDauY=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, nivedita@alum.mit.edu,
        mingo@kernel.org, lukas@wunner.de, atish.patra@wdc.com
Subject: [PATCH 08/19] efi/libstub: Use consistent type names for file I/O protocols
Date:   Mon, 10 Feb 2020 17:02:37 +0100
Message-Id: <20200210160248.4889-9-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210160248.4889-1-ardb@kernel.org>
References: <20200210160248.4889-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Align the naming of efi_file_io_interface_t and efi_file_handle_t with
the UEFI spec, and call them efi_simple_file_system_protocol_t and
efi_file_protocol_t, respectively, using the same convention we use
for all other type definitions that originate in the UEFI spec.

While at it, move the definitions to efistub.h, so they are only seen
by code that needs them.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 16 ++---
 drivers/firmware/efi/libstub/efistub.h         | 63 ++++++++++++++++++++
 include/linux/efi.h                            | 60 +------------------
 3 files changed, 72 insertions(+), 67 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 7afe31357df3..6db91655c743 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -54,7 +54,7 @@ bool __pure __efi_soft_reserve_enabled(void)
 }
 
 struct file_info {
-	efi_file_handle_t *handle;
+	efi_file_protocol_t *handle;
 	u64 size;
 };
 
@@ -113,7 +113,7 @@ unsigned long get_dram_base(void)
 static efi_status_t efi_file_size(void *__fh, efi_char16_t *filename_16,
 				  void **handle, u64 *file_sz)
 {
-	efi_file_handle_t *h, *fh = __fh;
+	efi_file_protocol_t *h, *fh = __fh;
 	efi_file_info_t *info;
 	efi_status_t status;
 	efi_guid_t info_guid = EFI_FILE_INFO_ID;
@@ -159,22 +159,22 @@ static efi_status_t efi_file_size(void *__fh, efi_char16_t *filename_16,
 	return status;
 }
 
-static efi_status_t efi_file_read(efi_file_handle_t *handle,
+static efi_status_t efi_file_read(efi_file_protocol_t *handle,
 				  unsigned long *size, void *addr)
 {
 	return handle->read(handle, size, addr);
 }
 
-static efi_status_t efi_file_close(efi_file_handle_t *handle)
+static efi_status_t efi_file_close(efi_file_protocol_t *handle)
 {
 	return handle->close(handle);
 }
 
 static efi_status_t efi_open_volume(efi_loaded_image_t *image,
-				    efi_file_handle_t **__fh)
+				    efi_file_protocol_t **__fh)
 {
-	efi_file_io_interface_t *io;
-	efi_file_handle_t *fh;
+	efi_simple_file_system_protocol_t *io;
+	efi_file_protocol_t *fh;
 	efi_guid_t fs_proto = EFI_FILE_SYSTEM_GUID;
 	efi_status_t status;
 	efi_handle_t handle = image->device_handle;
@@ -282,7 +282,7 @@ efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
 	struct file_info *files;
 	unsigned long file_addr;
 	u64 file_size_total;
-	efi_file_handle_t *fh = NULL;
+	efi_file_protocol_t *fh = NULL;
 	efi_status_t status;
 	int nr_files;
 	char *str;
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 55de118e8267..79cdb219f439 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -106,4 +106,67 @@ union efi_uga_draw_protocol {
 	} mixed_mode;
 };
 
+typedef struct efi_loaded_image {
+	u32			revision;
+	efi_handle_t		parent_handle;
+	efi_system_table_t	*system_table;
+	efi_handle_t		device_handle;
+	void			*file_path;
+	void			*reserved;
+	u32			load_options_size;
+	void			*load_options;
+	void			*image_base;
+	__aligned_u64		image_size;
+	unsigned int		image_code_type;
+	unsigned int		image_data_type;
+	efi_status_t		(__efiapi *unload)(efi_handle_t image_handle);
+} efi_loaded_image_t;
+
+typedef struct {
+	u64			size;
+	u64			file_size;
+	u64			phys_size;
+	efi_time_t		create_time;
+	efi_time_t		last_access_time;
+	efi_time_t		modification_time;
+	__aligned_u64		attribute;
+	efi_char16_t		filename[1];
+} efi_file_info_t;
+
+typedef struct efi_file_protocol efi_file_protocol_t;
+
+struct efi_file_protocol {
+	u64		revision;
+	efi_status_t	(__efiapi *open)	(efi_file_protocol_t *,
+						 efi_file_protocol_t **,
+						 efi_char16_t *, u64, u64);
+	efi_status_t	(__efiapi *close)	(efi_file_protocol_t *);
+	efi_status_t	(__efiapi *delete)	(efi_file_protocol_t *);
+	efi_status_t	(__efiapi *read)	(efi_file_protocol_t *,
+						 unsigned long *, void *);
+	efi_status_t	(__efiapi *write)	(efi_file_protocol_t *,
+						 unsigned long, void *);
+	efi_status_t	(__efiapi *get_position)(efi_file_protocol_t *, u64 *);
+	efi_status_t	(__efiapi *set_position)(efi_file_protocol_t *, u64);
+	efi_status_t	(__efiapi *get_info)	(efi_file_protocol_t *,
+						 efi_guid_t *, unsigned long *,
+						 void *);
+	efi_status_t	(__efiapi *set_info)	(efi_file_protocol_t *,
+						 efi_guid_t *, unsigned long,
+						 void *);
+	efi_status_t	(__efiapi *flush)	(efi_file_protocol_t *);
+};
+
+typedef struct efi_simple_file_system_protocol efi_simple_file_system_protocol_t;
+
+struct efi_simple_file_system_protocol {
+	u64	revision;
+	int	(__efiapi *open_volume)(efi_simple_file_system_protocol_t *,
+					efi_file_protocol_t **);
+};
+
+#define EFI_FILE_MODE_READ	0x0000000000000001
+#define EFI_FILE_MODE_WRITE	0x0000000000000002
+#define EFI_FILE_MODE_CREATE	0x8000000000000000
+
 #endif
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 7e231c3cfb6f..2b228df18407 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -796,65 +796,7 @@ struct efi_fdt_params {
 	u32 desc_ver;
 };
 
-typedef struct {
-	u32 revision;
-	efi_handle_t parent_handle;
-	efi_system_table_t *system_table;
-	efi_handle_t device_handle;
-	void *file_path;
-	void *reserved;
-	u32 load_options_size;
-	void *load_options;
-	void *image_base;
-	__aligned_u64 image_size;
-	unsigned int image_code_type;
-	unsigned int image_data_type;
-	efi_status_t ( __efiapi *unload)(efi_handle_t image_handle);
-} efi_loaded_image_t;
-
-typedef struct {
-	u64 size;
-	u64 file_size;
-	u64 phys_size;
-	efi_time_t create_time;
-	efi_time_t last_access_time;
-	efi_time_t modification_time;
-	__aligned_u64 attribute;
-	efi_char16_t filename[1];
-} efi_file_info_t;
-
-typedef struct efi_file_handle efi_file_handle_t;
-
-struct efi_file_handle {
-	u64 revision;
-	efi_status_t (__efiapi *open)(efi_file_handle_t *,
-				      efi_file_handle_t **,
-				      efi_char16_t *, u64, u64);
-	efi_status_t (__efiapi *close)(efi_file_handle_t *);
-	void *delete;
-	efi_status_t (__efiapi *read)(efi_file_handle_t *,
-				      unsigned long *, void *);
-	void *write;
-	void *get_position;
-	void *set_position;
-	efi_status_t (__efiapi *get_info)(efi_file_handle_t *,
-					  efi_guid_t *, unsigned long *,
-					  void *);
-	void *set_info;
-	void *flush;
-};
-
-typedef struct efi_file_io_interface efi_file_io_interface_t;
-
-struct efi_file_io_interface {
-	u64 revision;
-	int (__efiapi *open_volume)(efi_file_io_interface_t *,
-				    efi_file_handle_t **);
-};
-
-#define EFI_FILE_MODE_READ	0x0000000000000001
-#define EFI_FILE_MODE_WRITE	0x0000000000000002
-#define EFI_FILE_MODE_CREATE	0x8000000000000000
+typedef struct efi_loaded_image efi_loaded_image_t;
 
 typedef struct {
 	u32 version;
-- 
2.17.1

