Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51E41157F65
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2020 17:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgBJQDX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Feb 2020 11:03:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:52880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727800AbgBJQDX (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 10 Feb 2020 11:03:23 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAF032467D;
        Mon, 10 Feb 2020 16:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581350602;
        bh=Wv2epy5uJDKaPUyO5YZkE/QUitwk/0ZiVw7rVBrfAMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aJGuV9wyXAhOpUx9IedobC2X5F80g3WY5uLu3onprBUfWJOssv/F04t5wDJPC67eT
         +1l/0NRBeu5YoDNCmA34Paw16edUj64/dn06H6IxtIiP9Ftg8exFaGQ9J5T8QeyH4s
         oNRFsdHcfH73Y4n5jxW2PpunQQJrF9iKS+18Oxds=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, nivedita@alum.mit.edu,
        mingo@kernel.org, lukas@wunner.de, atish.patra@wdc.com
Subject: [PATCH 14/19] efi/libstub: Move file I/O support code into separate file
Date:   Mon, 10 Feb 2020 17:02:43 +0100
Message-Id: <20200210160248.4889-15-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210160248.4889-1-ardb@kernel.org>
References: <20200210160248.4889-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Split off the file I/O support code into a separate source file so
it ends up in a separate object file in the static library, allowing
the linker to omit it if the routines are not used.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/Makefile          |   2 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c | 294 +------------------
 drivers/firmware/efi/libstub/efistub.h         |   1 +
 drivers/firmware/efi/libstub/file.c            | 303 ++++++++++++++++++++
 4 files changed, 311 insertions(+), 289 deletions(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index ac0d0e1ef32d..74a097ef1780 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -39,7 +39,7 @@ OBJECT_FILES_NON_STANDARD	:= y
 KCOV_INSTRUMENT			:= n
 
 lib-y				:= efi-stub-helper.o gop.o secureboot.o tpm.o \
-				   mem.o random.o randomalloc.o pci.o
+				   file.o mem.o random.o randomalloc.o pci.o
 
 # include the stub's generic dependencies from lib/ when building for ARM/arm64
 arm-deps-y := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c fdt_empty_tree.c fdt_sw.c
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 1a8f2cf5a2bd..db23be5dc69b 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -12,23 +12,7 @@
 
 #include "efistub.h"
 
-/*
- * Some firmware implementations have problems reading files in one go.
- * A read chunk size of 1MB seems to work for most platforms.
- *
- * Unfortunately, reading files in chunks triggers *other* bugs on some
- * platforms, so we provide a way to disable this workaround, which can
- * be done by passing "efi=nochunk" on the EFI boot stub command line.
- *
- * If you experience issues with initrd images being corrupt it's worth
- * trying efi=nochunk, but chunking is enabled by default because there
- * are far more machines that require the workaround than those that
- * break with it enabled.
- */
-#define EFI_READ_CHUNK_SIZE	(1024 * 1024)
-
-static unsigned long efi_chunk_size = EFI_READ_CHUNK_SIZE;
-
+static bool __efistub_global efi_nochunk;
 static bool __efistub_global efi_nokaslr;
 static bool __efistub_global efi_quiet;
 static bool __efistub_global efi_novamap;
@@ -36,6 +20,10 @@ static bool __efistub_global efi_nosoftreserve;
 static bool __efistub_global efi_disable_pci_dma =
 					IS_ENABLED(CONFIG_EFI_DISABLE_PCI_DMA);
 
+bool __pure nochunk(void)
+{
+	return efi_nochunk;
+}
 bool __pure nokaslr(void)
 {
 	return efi_nokaslr;
@@ -53,11 +41,6 @@ bool __pure __efi_soft_reserve_enabled(void)
 	return !efi_nosoftreserve;
 }
 
-struct file_info {
-	efi_file_protocol_t *handle;
-	u64 size;
-};
-
 void efi_printk(char *str)
 {
 	char *s8;
@@ -75,90 +58,6 @@ void efi_printk(char *str)
 	}
 }
 
-static efi_status_t efi_file_size(void *__fh, efi_char16_t *filename_16,
-				  void **handle, u64 *file_sz)
-{
-	efi_file_protocol_t *h, *fh = __fh;
-	efi_file_info_t *info;
-	efi_status_t status;
-	efi_guid_t info_guid = EFI_FILE_INFO_ID;
-	unsigned long info_sz;
-
-	status = fh->open(fh, &h, filename_16, EFI_FILE_MODE_READ, 0);
-	if (status != EFI_SUCCESS) {
-		efi_printk("Failed to open file: ");
-		efi_char16_printk(filename_16);
-		efi_printk("\n");
-		return status;
-	}
-
-	*handle = h;
-
-	info_sz = 0;
-	status = h->get_info(h, &info_guid, &info_sz, NULL);
-	if (status != EFI_BUFFER_TOO_SMALL) {
-		efi_printk("Failed to get file info size\n");
-		return status;
-	}
-
-grow:
-	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, info_sz,
-			     (void **)&info);
-	if (status != EFI_SUCCESS) {
-		efi_printk("Failed to alloc mem for file info\n");
-		return status;
-	}
-
-	status = h->get_info(h, &info_guid, &info_sz, info);
-	if (status == EFI_BUFFER_TOO_SMALL) {
-		efi_bs_call(free_pool, info);
-		goto grow;
-	}
-
-	*file_sz = info->file_size;
-	efi_bs_call(free_pool, info);
-
-	if (status != EFI_SUCCESS)
-		efi_printk("Failed to get initrd info\n");
-
-	return status;
-}
-
-static efi_status_t efi_file_read(efi_file_protocol_t *handle,
-				  unsigned long *size, void *addr)
-{
-	return handle->read(handle, size, addr);
-}
-
-static efi_status_t efi_file_close(efi_file_protocol_t *handle)
-{
-	return handle->close(handle);
-}
-
-static efi_status_t efi_open_volume(efi_loaded_image_t *image,
-				    efi_file_protocol_t **__fh)
-{
-	efi_simple_file_system_protocol_t *io;
-	efi_file_protocol_t *fh;
-	efi_guid_t fs_proto = EFI_FILE_SYSTEM_GUID;
-	efi_status_t status;
-	efi_handle_t handle = image->device_handle;
-
-	status = efi_bs_call(handle_protocol, handle, &fs_proto, (void **)&io);
-	if (status != EFI_SUCCESS) {
-		efi_printk("Failed to handle fs_proto\n");
-		return status;
-	}
-
-	status = io->open_volume(io, &fh);
-	if (status != EFI_SUCCESS)
-		efi_printk("Failed to open volume\n");
-	else
-		*__fh = fh;
-
-	return status;
-}
-
 /*
  * Parse the ASCII string 'cmdline' for EFI options, denoted by the efi=
  * option, e.g. efi=nochunk.
@@ -197,7 +96,7 @@ efi_status_t efi_parse_options(char const *cmdline)
 	while (*str && *str != ' ') {
 		if (!strncmp(str, "nochunk", 7)) {
 			str += strlen("nochunk");
-			efi_chunk_size = -1UL;
+			efi_nochunk = true;
 		}
 
 		if (!strncmp(str, "novamap", 7)) {
@@ -232,187 +131,6 @@ efi_status_t efi_parse_options(char const *cmdline)
 	return EFI_SUCCESS;
 }
 
-/*
- * Check the cmdline for a LILO-style file= arguments.
- *
- * We only support loading a file from the same filesystem as
- * the kernel image.
- */
-efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
-				  char *cmd_line, char *option_string,
-				  unsigned long max_addr,
-				  unsigned long *load_addr,
-				  unsigned long *load_size)
-{
-	struct file_info *files;
-	unsigned long file_addr;
-	u64 file_size_total;
-	efi_file_protocol_t *fh = NULL;
-	efi_status_t status;
-	int nr_files;
-	char *str;
-	int i, j, k;
-
-	file_addr = 0;
-	file_size_total = 0;
-
-	str = cmd_line;
-
-	j = 0;			/* See close_handles */
-
-	if (!load_addr || !load_size)
-		return EFI_INVALID_PARAMETER;
-
-	*load_addr = 0;
-	*load_size = 0;
-
-	if (!str || !*str)
-		return EFI_SUCCESS;
-
-	for (nr_files = 0; *str; nr_files++) {
-		str = strstr(str, option_string);
-		if (!str)
-			break;
-
-		str += strlen(option_string);
-
-		/* Skip any leading slashes */
-		while (*str == '/' || *str == '\\')
-			str++;
-
-		while (*str && *str != ' ' && *str != '\n')
-			str++;
-	}
-
-	if (!nr_files)
-		return EFI_SUCCESS;
-
-	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
-			     nr_files * sizeof(*files), (void **)&files);
-	if (status != EFI_SUCCESS) {
-		pr_efi_err("Failed to alloc mem for file handle list\n");
-		goto fail;
-	}
-
-	str = cmd_line;
-	for (i = 0; i < nr_files; i++) {
-		struct file_info *file;
-		efi_char16_t filename_16[256];
-		efi_char16_t *p;
-
-		str = strstr(str, option_string);
-		if (!str)
-			break;
-
-		str += strlen(option_string);
-
-		file = &files[i];
-		p = filename_16;
-
-		/* Skip any leading slashes */
-		while (*str == '/' || *str == '\\')
-			str++;
-
-		while (*str && *str != ' ' && *str != '\n') {
-			if ((u8 *)p >= (u8 *)filename_16 + sizeof(filename_16))
-				break;
-
-			if (*str == '/') {
-				*p++ = '\\';
-				str++;
-			} else {
-				*p++ = *str++;
-			}
-		}
-
-		*p = '\0';
-
-		/* Only open the volume once. */
-		if (!i) {
-			status = efi_open_volume(image, &fh);
-			if (status != EFI_SUCCESS)
-				goto free_files;
-		}
-
-		status = efi_file_size(fh, filename_16, (void **)&file->handle,
-				       &file->size);
-		if (status != EFI_SUCCESS)
-			goto close_handles;
-
-		file_size_total += file->size;
-	}
-
-	if (file_size_total) {
-		unsigned long addr;
-
-		/*
-		 * Multiple files need to be at consecutive addresses in memory,
-		 * so allocate enough memory for all the files.  This is used
-		 * for loading multiple files.
-		 */
-		status = efi_allocate_pages(file_size_total, &file_addr, max_addr);
-		if (status != EFI_SUCCESS) {
-			pr_efi_err("Failed to alloc highmem for files\n");
-			goto close_handles;
-		}
-
-		/* We've run out of free low memory. */
-		if (file_addr > max_addr) {
-			pr_efi_err("We've run out of free low memory\n");
-			status = EFI_INVALID_PARAMETER;
-			goto free_file_total;
-		}
-
-		addr = file_addr;
-		for (j = 0; j < nr_files; j++) {
-			unsigned long size;
-
-			size = files[j].size;
-			while (size) {
-				unsigned long chunksize;
-
-				if (IS_ENABLED(CONFIG_X86) && size > efi_chunk_size)
-					chunksize = efi_chunk_size;
-				else
-					chunksize = size;
-
-				status = efi_file_read(files[j].handle,
-						       &chunksize,
-						       (void *)addr);
-				if (status != EFI_SUCCESS) {
-					pr_efi_err("Failed to read file\n");
-					goto free_file_total;
-				}
-				addr += chunksize;
-				size -= chunksize;
-			}
-
-			efi_file_close(files[j].handle);
-		}
-
-	}
-
-	efi_bs_call(free_pool, files);
-
-	*load_addr = file_addr;
-	*load_size = file_size_total;
-
-	return status;
-
-free_file_total:
-	efi_free(file_size_total, file_addr);
-
-close_handles:
-	for (k = j; k < i; k++)
-		efi_file_close(files[k].handle);
-free_files:
-	efi_bs_call(free_pool, files);
-fail:
-	*load_addr = 0;
-	*load_size = 0;
-
-	return status;
-}
 /*
  * Get the number of UTF-8 bytes corresponding to an UTF-16 character.
  * This overestimates for surrogates, but that is okay.
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 5123def761e9..e057d509d5d8 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -31,6 +31,7 @@
 #define __efistub_global
 #endif
 
+extern bool __pure nochunk(void);
 extern bool __pure nokaslr(void);
 extern bool __pure is_quiet(void);
 extern bool __pure novamap(void);
diff --git a/drivers/firmware/efi/libstub/file.c b/drivers/firmware/efi/libstub/file.c
new file mode 100644
index 000000000000..e0302f340962
--- /dev/null
+++ b/drivers/firmware/efi/libstub/file.c
@@ -0,0 +1,303 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Helper functions used by the EFI stub on multiple
+ * architectures. This should be #included by the EFI stub
+ * implementation files.
+ *
+ * Copyright 2011 Intel Corporation; author Matt Fleming
+ */
+
+#include <linux/efi.h>
+#include <asm/efi.h>
+
+#include "efistub.h"
+
+/*
+ * Some firmware implementations have problems reading files in one go.
+ * A read chunk size of 1MB seems to work for most platforms.
+ *
+ * Unfortunately, reading files in chunks triggers *other* bugs on some
+ * platforms, so we provide a way to disable this workaround, which can
+ * be done by passing "efi=nochunk" on the EFI boot stub command line.
+ *
+ * If you experience issues with initrd images being corrupt it's worth
+ * trying efi=nochunk, but chunking is enabled by default on x86 because
+ * there are far more machines that require the workaround than those that
+ * break with it enabled.
+ */
+#define EFI_READ_CHUNK_SIZE	SZ_1M
+
+struct file_info {
+	efi_file_protocol_t *handle;
+	u64 size;
+};
+
+static efi_status_t efi_file_size(void *__fh, efi_char16_t *filename_16,
+				  void **handle, u64 *file_sz)
+{
+	efi_file_protocol_t *h, *fh = __fh;
+	efi_file_info_t *info;
+	efi_status_t status;
+	efi_guid_t info_guid = EFI_FILE_INFO_ID;
+	unsigned long info_sz;
+
+	status = fh->open(fh, &h, filename_16, EFI_FILE_MODE_READ, 0);
+	if (status != EFI_SUCCESS) {
+		efi_printk("Failed to open file: ");
+		efi_char16_printk(filename_16);
+		efi_printk("\n");
+		return status;
+	}
+
+	*handle = h;
+
+	info_sz = 0;
+	status = h->get_info(h, &info_guid, &info_sz, NULL);
+	if (status != EFI_BUFFER_TOO_SMALL) {
+		efi_printk("Failed to get file info size\n");
+		return status;
+	}
+
+grow:
+	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, info_sz,
+			     (void **)&info);
+	if (status != EFI_SUCCESS) {
+		efi_printk("Failed to alloc mem for file info\n");
+		return status;
+	}
+
+	status = h->get_info(h, &info_guid, &info_sz, info);
+	if (status == EFI_BUFFER_TOO_SMALL) {
+		efi_bs_call(free_pool, info);
+		goto grow;
+	}
+
+	*file_sz = info->file_size;
+	efi_bs_call(free_pool, info);
+
+	if (status != EFI_SUCCESS)
+		efi_printk("Failed to get initrd info\n");
+
+	return status;
+}
+
+static efi_status_t efi_file_read(efi_file_protocol_t *handle,
+				  unsigned long *size, void *addr)
+{
+	return handle->read(handle, size, addr);
+}
+
+static efi_status_t efi_file_close(efi_file_protocol_t *handle)
+{
+	return handle->close(handle);
+}
+
+static efi_status_t efi_open_volume(efi_loaded_image_t *image,
+				    efi_file_protocol_t **__fh)
+{
+	efi_simple_file_system_protocol_t *io;
+	efi_file_protocol_t *fh;
+	efi_guid_t fs_proto = EFI_FILE_SYSTEM_GUID;
+	efi_status_t status;
+	efi_handle_t handle = image->device_handle;
+
+	status = efi_bs_call(handle_protocol, handle, &fs_proto, (void **)&io);
+	if (status != EFI_SUCCESS) {
+		efi_printk("Failed to handle fs_proto\n");
+		return status;
+	}
+
+	status = io->open_volume(io, &fh);
+	if (status != EFI_SUCCESS)
+		efi_printk("Failed to open volume\n");
+	else
+		*__fh = fh;
+
+	return status;
+}
+
+/*
+ * Check the cmdline for a LILO-style file= arguments.
+ *
+ * We only support loading a file from the same filesystem as
+ * the kernel image.
+ */
+efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
+				  char *cmd_line, char *option_string,
+				  unsigned long max_addr,
+				  unsigned long *load_addr,
+				  unsigned long *load_size)
+{
+	unsigned long efi_chunk_size = ULONG_MAX;
+	struct file_info *files;
+	unsigned long file_addr;
+	u64 file_size_total;
+	efi_file_protocol_t *fh = NULL;
+	efi_status_t status;
+	int nr_files;
+	char *str;
+	int i, j, k;
+
+	if (IS_ENABLED(CONFIG_X86) && !nochunk())
+		efi_chunk_size = EFI_READ_CHUNK_SIZE;
+
+	file_addr = 0;
+	file_size_total = 0;
+
+	str = cmd_line;
+
+	j = 0;			/* See close_handles */
+
+	if (!load_addr || !load_size)
+		return EFI_INVALID_PARAMETER;
+
+	*load_addr = 0;
+	*load_size = 0;
+
+	if (!str || !*str)
+		return EFI_SUCCESS;
+
+	for (nr_files = 0; *str; nr_files++) {
+		str = strstr(str, option_string);
+		if (!str)
+			break;
+
+		str += strlen(option_string);
+
+		/* Skip any leading slashes */
+		while (*str == '/' || *str == '\\')
+			str++;
+
+		while (*str && *str != ' ' && *str != '\n')
+			str++;
+	}
+
+	if (!nr_files)
+		return EFI_SUCCESS;
+
+	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
+			     nr_files * sizeof(*files), (void **)&files);
+	if (status != EFI_SUCCESS) {
+		pr_efi_err("Failed to alloc mem for file handle list\n");
+		goto fail;
+	}
+
+	str = cmd_line;
+	for (i = 0; i < nr_files; i++) {
+		struct file_info *file;
+		efi_char16_t filename_16[256];
+		efi_char16_t *p;
+
+		str = strstr(str, option_string);
+		if (!str)
+			break;
+
+		str += strlen(option_string);
+
+		file = &files[i];
+		p = filename_16;
+
+		/* Skip any leading slashes */
+		while (*str == '/' || *str == '\\')
+			str++;
+
+		while (*str && *str != ' ' && *str != '\n') {
+			if ((u8 *)p >= (u8 *)filename_16 + sizeof(filename_16))
+				break;
+
+			if (*str == '/') {
+				*p++ = '\\';
+				str++;
+			} else {
+				*p++ = *str++;
+			}
+		}
+
+		*p = '\0';
+
+		/* Only open the volume once. */
+		if (!i) {
+			status = efi_open_volume(image, &fh);
+			if (status != EFI_SUCCESS)
+				goto free_files;
+		}
+
+		status = efi_file_size(fh, filename_16, (void **)&file->handle,
+				       &file->size);
+		if (status != EFI_SUCCESS)
+			goto close_handles;
+
+		file_size_total += file->size;
+	}
+
+	if (file_size_total) {
+		unsigned long addr;
+
+		/*
+		 * Multiple files need to be at consecutive addresses in memory,
+		 * so allocate enough memory for all the files.  This is used
+		 * for loading multiple files.
+		 */
+		status = efi_allocate_pages(file_size_total, &file_addr, max_addr);
+		if (status != EFI_SUCCESS) {
+			pr_efi_err("Failed to alloc highmem for files\n");
+			goto close_handles;
+		}
+
+		/* We've run out of free low memory. */
+		if (file_addr > max_addr) {
+			pr_efi_err("We've run out of free low memory\n");
+			status = EFI_INVALID_PARAMETER;
+			goto free_file_total;
+		}
+
+		addr = file_addr;
+		for (j = 0; j < nr_files; j++) {
+			unsigned long size;
+
+			size = files[j].size;
+			while (size) {
+				unsigned long chunksize;
+
+				if (size > efi_chunk_size)
+					chunksize = efi_chunk_size;
+				else
+					chunksize = size;
+
+				status = efi_file_read(files[j].handle,
+						       &chunksize,
+						       (void *)addr);
+				if (status != EFI_SUCCESS) {
+					pr_efi_err("Failed to read file\n");
+					goto free_file_total;
+				}
+				addr += chunksize;
+				size -= chunksize;
+			}
+
+			efi_file_close(files[j].handle);
+		}
+
+	}
+
+	efi_bs_call(free_pool, files);
+
+	*load_addr = file_addr;
+	*load_size = file_size_total;
+
+	return status;
+
+free_file_total:
+	efi_free(file_size_total, file_addr);
+
+close_handles:
+	for (k = j; k < i; k++)
+		efi_file_close(files[k].handle);
+free_files:
+	efi_bs_call(free_pool, files);
+fail:
+	*load_addr = 0;
+	*load_size = 0;
+
+	return status;
+}
-- 
2.17.1

