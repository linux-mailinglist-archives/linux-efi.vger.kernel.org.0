Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 479C1157F66
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2020 17:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgBJQDY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Feb 2020 11:03:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:52894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727800AbgBJQDY (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 10 Feb 2020 11:03:24 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D3E22467E;
        Mon, 10 Feb 2020 16:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581350603;
        bh=ac5NfOdBzesmBve6t3TUb76oi3njZPcq60Xj6VDgeTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u8IAc+Jbqs26N+kvaVLI3GKqkz+yP1u7zZQL+k1HCQxwPH5RGoUUoG1FPn/Up7jXH
         I2V7ZYKVc68ngUUfpDxIxhhI/LJQOtyBbALoxmPubkMXcze07BnrhX1jRN4IdR/vMS
         OIJUTjASAPPQGySVWDed7eANpKzlF9J+p6lXDk/8=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, nivedita@alum.mit.edu,
        mingo@kernel.org, lukas@wunner.de, atish.patra@wdc.com
Subject: [PATCH 15/19] efi/libstub: Rewrite file I/O routine
Date:   Mon, 10 Feb 2020 17:02:44 +0100
Message-Id: <20200210160248.4889-16-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210160248.4889-1-ardb@kernel.org>
References: <20200210160248.4889-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The file I/O routine that is used to load initrd or dtb files from
the EFI system partition suffers from a few issues:
- it converts the u8[] command line back to a UTF-16 string, which is
  pointless since we only handle initrd or dtb arguments provided via
  the loaded image protocol anyway, which is where we got the command
  line from in the first place when booting via the PE entry point,
- in the far majority of cases, only a single initrd= option is present,
  but it optimizes for multiple options, by going over the command line
  twice, allocating heap buffers for dynamically sized arrays, etc.
- the coding style is hard to follow, with few comments, and all logic
  including string parsing etc all conbined in a single routine.

Let's fix this by rewriting most of it, based on the idea that in the
case of multiple initrds, we can just allocate a new, bigger buffer
and copy over the data before freeing the old one.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/arm-stub.c |  12 +-
 drivers/firmware/efi/libstub/efistub.h  |  17 +-
 drivers/firmware/efi/libstub/file.c     | 356 +++++++++-----------
 drivers/firmware/efi/libstub/x86-stub.c |  12 +-
 4 files changed, 169 insertions(+), 228 deletions(-)

diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index fb5b2b35d3be..9b12f9b19533 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -148,7 +148,7 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table_arg,
 	unsigned long dram_base;
 	/* addr/point and size pairs for memory management*/
 	unsigned long initrd_addr;
-	u64 initrd_size = 0;
+	unsigned long initrd_size = 0;
 	unsigned long fdt_addr = 0;  /* Original DTB */
 	unsigned long fdt_size = 0;
 	char *cmdline_ptr = NULL;
@@ -238,8 +238,7 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table_arg,
 		if (strstr(cmdline_ptr, "dtb="))
 			pr_efi("Ignoring DTB from command line.\n");
 	} else {
-		status = handle_cmdline_files(image, cmdline_ptr, "dtb=",
-					      ~0UL, &fdt_addr, &fdt_size);
+		status = efi_load_dtb(image, &fdt_addr, &fdt_size);
 
 		if (status != EFI_SUCCESS) {
 			pr_efi_err("Failed to load device tree!\n");
@@ -259,11 +258,8 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table_arg,
 	if (!fdt_addr)
 		pr_efi("Generating empty DTB\n");
 
-	status = handle_cmdline_files(image, cmdline_ptr, "initrd=",
-				      efi_get_max_initrd_addr(dram_base,
-							      *image_addr),
-				      (unsigned long *)&initrd_addr,
-				      (unsigned long *)&initrd_size);
+	status = efi_load_initrd(image, &initrd_addr, &initrd_size,
+				 efi_get_max_initrd_addr(dram_base, *image_addr));
 	if (status != EFI_SUCCESS)
 		pr_efi_err("Failed initrd from command line!\n");
 
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index e057d509d5d8..60d929469b8b 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -327,7 +327,7 @@ typedef struct {
 	efi_time_t		last_access_time;
 	efi_time_t		modification_time;
 	__aligned_u64		attribute;
-	efi_char16_t		filename[1];
+	efi_char16_t		filename[];
 } efi_file_info_t;
 
 typedef struct efi_file_protocol efi_file_protocol_t;
@@ -607,15 +607,18 @@ efi_status_t efi_relocate_kernel(unsigned long *image_addr,
 				 unsigned long alignment,
 				 unsigned long min_addr);
 
-efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
-				  char *cmd_line, char *option_string,
-				  unsigned long max_addr,
-				  unsigned long *load_addr,
-				  unsigned long *load_size);
-
 efi_status_t efi_parse_options(char const *cmdline);
 
 efi_status_t efi_setup_gop(struct screen_info *si, efi_guid_t *proto,
 			   unsigned long size);
 
+efi_status_t efi_load_dtb(efi_loaded_image_t *image,
+			  unsigned long *load_addr,
+			  unsigned long *load_size);
+
+efi_status_t efi_load_initrd(efi_loaded_image_t *image,
+			     unsigned long *load_addr,
+			     unsigned long *load_size,
+			     unsigned long max_addr);
+
 #endif
diff --git a/drivers/firmware/efi/libstub/file.c b/drivers/firmware/efi/libstub/file.c
index e0302f340962..0d67432ed067 100644
--- a/drivers/firmware/efi/libstub/file.c
+++ b/drivers/firmware/efi/libstub/file.c
@@ -12,6 +12,8 @@
 
 #include "efistub.h"
 
+#define MAX_FILENAME_SIZE	256
+
 /*
  * Some firmware implementations have problems reading files in one go.
  * A read chunk size of 1MB seems to work for most platforms.
@@ -27,277 +29,221 @@
  */
 #define EFI_READ_CHUNK_SIZE	SZ_1M
 
-struct file_info {
-	efi_file_protocol_t *handle;
-	u64 size;
-};
-
-static efi_status_t efi_file_size(void *__fh, efi_char16_t *filename_16,
-				  void **handle, u64 *file_sz)
+static efi_status_t efi_open_file(efi_file_protocol_t *volume,
+				  efi_char16_t *filename_16,
+				  efi_file_protocol_t **handle,
+				  unsigned long *file_size)
 {
-	efi_file_protocol_t *h, *fh = __fh;
-	efi_file_info_t *info;
-	efi_status_t status;
+	struct {
+		efi_file_info_t info;
+		efi_char16_t	filename[MAX_FILENAME_SIZE];
+	} finfo;
 	efi_guid_t info_guid = EFI_FILE_INFO_ID;
+	efi_file_protocol_t *fh;
 	unsigned long info_sz;
+	efi_status_t status;
 
-	status = fh->open(fh, &h, filename_16, EFI_FILE_MODE_READ, 0);
+	status = volume->open(volume, &fh, filename_16, EFI_FILE_MODE_READ, 0);
 	if (status != EFI_SUCCESS) {
-		efi_printk("Failed to open file: ");
+		pr_efi_err("Failed to open file: ");
 		efi_char16_printk(filename_16);
 		efi_printk("\n");
 		return status;
 	}
 
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
+	info_sz = sizeof(finfo);
+	status = fh->get_info(fh, &info_guid, &info_sz, &finfo);
 	if (status != EFI_SUCCESS) {
-		efi_printk("Failed to alloc mem for file info\n");
+		pr_efi_err("Failed to get file info\n");
+		fh->close(fh);
 		return status;
 	}
 
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
+	*handle = fh;
+	*file_size = finfo.info.file_size;
+	return EFI_SUCCESS;
 }
 
 static efi_status_t efi_open_volume(efi_loaded_image_t *image,
-				    efi_file_protocol_t **__fh)
+				    efi_file_protocol_t **fh)
 {
-	efi_simple_file_system_protocol_t *io;
-	efi_file_protocol_t *fh;
 	efi_guid_t fs_proto = EFI_FILE_SYSTEM_GUID;
+	efi_simple_file_system_protocol_t *io;
 	efi_status_t status;
-	efi_handle_t handle = image->device_handle;
 
-	status = efi_bs_call(handle_protocol, handle, &fs_proto, (void **)&io);
+	status = efi_bs_call(handle_protocol, image->device_handle, &fs_proto,
+			     (void **)&io);
 	if (status != EFI_SUCCESS) {
-		efi_printk("Failed to handle fs_proto\n");
+		pr_efi_err("Failed to handle fs_proto\n");
 		return status;
 	}
 
-	status = io->open_volume(io, &fh);
+	status = io->open_volume(io, fh);
 	if (status != EFI_SUCCESS)
-		efi_printk("Failed to open volume\n");
-	else
-		*__fh = fh;
+		pr_efi_err("Failed to open volume\n");
 
 	return status;
 }
 
+static int find_file_option(const efi_char16_t *cmdline, int cmdline_len,
+			    const efi_char16_t *prefix, int prefix_size,
+			    efi_char16_t *result, int result_len)
+{
+	int prefix_len = prefix_size / 2;
+	bool found = false;
+	int i;
+
+	for (i = prefix_len; i < cmdline_len; i++) {
+		if (!memcmp(&cmdline[i - prefix_len], prefix, prefix_size)) {
+			found = true;
+			break;
+		}
+	}
+
+	if (!found)
+		return 0;
+
+	while (--result_len > 0 && i < cmdline_len) {
+		if (cmdline[i] == L'\0' ||
+		    cmdline[i] == L'\n' ||
+		    cmdline[i] == L' ')
+			break;
+		*result++ = cmdline[i++];
+	}
+	*result = L'\0';
+	return i;
+}
+
 /*
  * Check the cmdline for a LILO-style file= arguments.
  *
  * We only support loading a file from the same filesystem as
  * the kernel image.
  */
-efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
-				  char *cmd_line, char *option_string,
-				  unsigned long max_addr,
-				  unsigned long *load_addr,
-				  unsigned long *load_size)
+static efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
+					 const efi_char16_t *optstr,
+					 int optstr_size,
+					 unsigned long max_addr,
+					 unsigned long *load_addr,
+					 unsigned long *load_size)
 {
+	const efi_char16_t *cmdline = image->load_options;
+	int cmdline_len = image->load_options_size / 2;
 	unsigned long efi_chunk_size = ULONG_MAX;
-	struct file_info *files;
-	unsigned long file_addr;
-	u64 file_size_total;
-	efi_file_protocol_t *fh = NULL;
+	efi_file_protocol_t *volume = NULL;
+	efi_file_protocol_t *file;
+	unsigned long alloc_addr;
+	unsigned long alloc_size;
 	efi_status_t status;
-	int nr_files;
-	char *str;
-	int i, j, k;
-
-	if (IS_ENABLED(CONFIG_X86) && !nochunk())
-		efi_chunk_size = EFI_READ_CHUNK_SIZE;
-
-	file_addr = 0;
-	file_size_total = 0;
-
-	str = cmd_line;
-
-	j = 0;			/* See close_handles */
+	int offset;
 
 	if (!load_addr || !load_size)
 		return EFI_INVALID_PARAMETER;
 
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
+	if (IS_ENABLED(CONFIG_X86) && !nochunk())
+		efi_chunk_size = EFI_READ_CHUNK_SIZE;
 
-	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
-			     nr_files * sizeof(*files), (void **)&files);
-	if (status != EFI_SUCCESS) {
-		pr_efi_err("Failed to alloc mem for file handle list\n");
-		goto fail;
-	}
+	alloc_addr = alloc_size = 0;
+	do {
+		efi_char16_t filename[MAX_FILENAME_SIZE];
+		unsigned long size;
+		void *addr;
 
-	str = cmd_line;
-	for (i = 0; i < nr_files; i++) {
-		struct file_info *file;
-		efi_char16_t filename_16[256];
-		efi_char16_t *p;
+		offset = find_file_option(cmdline, cmdline_len,
+					  optstr, optstr_size,
+					  filename, ARRAY_SIZE(filename));
 
-		str = strstr(str, option_string);
-		if (!str)
+		if (!offset)
 			break;
 
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
+		cmdline += offset;
+		cmdline_len -= offset;
 
-		/* Only open the volume once. */
-		if (!i) {
-			status = efi_open_volume(image, &fh);
+		if (!volume) {
+			status = efi_open_volume(image, &volume);
 			if (status != EFI_SUCCESS)
-				goto free_files;
+				return status;
 		}
 
-		status = efi_file_size(fh, filename_16, (void **)&file->handle,
-				       &file->size);
+		status = efi_open_file(volume, filename, &file, &size);
 		if (status != EFI_SUCCESS)
-			goto close_handles;
-
-		file_size_total += file->size;
-	}
-
-	if (file_size_total) {
-		unsigned long addr;
+			goto err_close_volume;
 
 		/*
-		 * Multiple files need to be at consecutive addresses in memory,
-		 * so allocate enough memory for all the files.  This is used
-		 * for loading multiple files.
+		 * Check whether the existing allocation can contain the next
+		 * file. This condition will also trigger naturally during the
+		 * first (and typically only) iteration of the loop, given that
+		 * alloc_size == 0 in that case.
 		 */
-		status = efi_allocate_pages(file_size_total, &file_addr, max_addr);
-		if (status != EFI_SUCCESS) {
-			pr_efi_err("Failed to alloc highmem for files\n");
-			goto close_handles;
-		}
+		if (round_up(alloc_size + size, EFI_ALLOC_ALIGN) >
+		    round_up(alloc_size, EFI_ALLOC_ALIGN)) {
+			unsigned long old_addr = alloc_addr;
+
+			status = efi_allocate_pages(alloc_size + size, &alloc_addr,
+						    max_addr);
+			if (status != EFI_SUCCESS) {
+				pr_efi_err("Failed to reallocate memory for files\n");
+				goto err_close_file;
+			}
 
-		/* We've run out of free low memory. */
-		if (file_addr > max_addr) {
-			pr_efi_err("We've run out of free low memory\n");
-			status = EFI_INVALID_PARAMETER;
-			goto free_file_total;
+			if (old_addr != 0) {
+				/*
+				 * This is not the first time we've gone
+				 * around this loop, and so we are loading
+				 * multiple files that need to be concatenated
+				 * and returned in a single buffer.
+				 */
+				memcpy((void *)alloc_addr, (void *)old_addr, alloc_size);
+				efi_free(alloc_size, old_addr);
+			}
 		}
 
-		addr = file_addr;
-		for (j = 0; j < nr_files; j++) {
-			unsigned long size;
-
-			size = files[j].size;
-			while (size) {
-				unsigned long chunksize;
-
-				if (size > efi_chunk_size)
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
+		addr = (void *)alloc_addr + alloc_size;
+		alloc_size += size;
 
-			efi_file_close(files[j].handle);
+		while (size) {
+			unsigned long chunksize = min(size, efi_chunk_size);
+
+			status = file->read(file, &chunksize, addr);
+			if (status != EFI_SUCCESS) {
+				pr_efi_err("Failed to read file\n");
+				goto err_close_file;
+			}
+			addr += chunksize;
+			size -= chunksize;
 		}
+		file->close(file);
+	} while (offset > 0);
 
-	}
+	*load_addr = alloc_addr;
+	*load_size = alloc_size;
 
-	efi_bs_call(free_pool, files);
+	if (volume)
+		volume->close(volume);
+	return EFI_SUCCESS;
 
-	*load_addr = file_addr;
-	*load_size = file_size_total;
+err_close_file:
+	file->close(file);
 
+err_close_volume:
+	volume->close(volume);
+	efi_free(alloc_size, alloc_addr);
 	return status;
+}
 
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
+efi_status_t efi_load_dtb(efi_loaded_image_t *image,
+			  unsigned long *load_addr,
+			  unsigned long *load_size)
+{
+	return handle_cmdline_files(image, L"dtb=", sizeof(L"dtb=") - 2,
+				    ULONG_MAX, load_addr, load_size);
+}
 
-	return status;
+efi_status_t efi_load_initrd(efi_loaded_image_t *image,
+			     unsigned long *load_addr,
+			     unsigned long *load_size,
+			     unsigned long max_addr)
+{
+	return handle_cmdline_files(image, L"initrd=", sizeof(L"initrd=") - 2,
+				    max_addr, load_addr, load_size);
 }
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index f2dbf119837c..39d04735f1c5 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -421,18 +421,14 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	if (status != EFI_SUCCESS)
 		goto fail2;
 
-	status = handle_cmdline_files(image,
-				      (char *)(unsigned long)hdr->cmd_line_ptr,
-				      "initrd=", hdr->initrd_addr_max,
-				      &ramdisk_addr, &ramdisk_size);
+	status = efi_load_initrd(image, &ramdisk_addr, &ramdisk_size,
+				 hdr->initrd_addr_max);
 
 	if (status != EFI_SUCCESS &&
 	    hdr->xloadflags & XLF_CAN_BE_LOADED_ABOVE_4G) {
 		efi_printk("Trying to load files to higher address\n");
-		status = handle_cmdline_files(image,
-				      (char *)(unsigned long)hdr->cmd_line_ptr,
-				      "initrd=", -1UL,
-				      &ramdisk_addr, &ramdisk_size);
+		status = efi_load_initrd(image, &ramdisk_addr, &ramdisk_size,
+					 ULONG_MAX);
 	}
 
 	if (status != EFI_SUCCESS)
-- 
2.17.1

