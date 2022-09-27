Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444665EBDE2
	for <lists+linux-efi@lfdr.de>; Tue, 27 Sep 2022 10:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiI0I65 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 27 Sep 2022 04:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiI0I64 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 27 Sep 2022 04:58:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A957E303
        for <linux-efi@vger.kernel.org>; Tue, 27 Sep 2022 01:58:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D7C761750
        for <linux-efi@vger.kernel.org>; Tue, 27 Sep 2022 08:58:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA59C433C1;
        Tue, 27 Sep 2022 08:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664269134;
        bh=EUvMUA6prcrkqn0Th8aDLSdQCn7i50Mc6uVnZ1xVHho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QM87R5d5wZEF1i9bvPdmJd3VIskLaMFhgtMTwd96M/ZekACq1wQ3ciMgH4dRRBLFj
         F3GhfpZhgIjksIybsPOCnAByqMz0zQ6ujYeBS3dqGidFCV4nUfFVWzi684Q8KY7PdY
         o6wXAseb343tvwsBV3Hmdo/eVJdrnk3Frt8XTdTjTN2cdd6Ysv4dXC9D/gRcH6HFnx
         fXGOJY5Aq8zUjyTuqJ/NDjpvE96jG65d8vucbGUEceWMY92oFmIexSJMCOHskMXDKH
         wMPhJdjAlACTzZCZuzaqDJQDxcZoiIIAHYz/CKdOmoaTPg6DhEiiFQ3mHLU5T5+yJ1
         LkxmUln63ImnA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Atish Patra <atishp@atishpatra.org>,
        Lennart Poettering <lennart@poettering.net>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 1/4] efi: libstub: Implement devicepath support for initrd commandline loader
Date:   Tue, 27 Sep 2022 10:58:39 +0200
Message-Id: <20220927085842.2860715-2-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220927085842.2860715-1-ardb@kernel.org>
References: <20220927085842.2860715-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7551; i=ardb@kernel.org; h=from:subject; bh=EUvMUA6prcrkqn0Th8aDLSdQCn7i50Mc6uVnZ1xVHho=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjMrs+9poQAhTp1VrbueTY2LVcMrxX6r9ukppJt/J4 9Oth5mqJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYzK7PgAKCRDDTyI5ktmPJNmSDA CdA1TgjanE49wWechQXrIt6mapXhV1wgOGAXsBpDFn82VUXFzhDdmndSqYzPwUuTNJb4GzvmJ3YQ9Q K15Vr0oskk+uLAJDL11+sNokVrlzNmu5CwhTueYSCAhFcsVuunJPDmZd8SjwMYDOiWJheNsSoKQgtv 3GORNFpfOdnHIKgDYvsfEkXa8aBIruLTXlm+c+B9LJdKFxZxDjyu8oVm0/C+/JhjBUSjlWGJUGpEeo 5nxCI7yB48tyAICCbbVL3OhdcYwSdBkGrfZ3FN3afTRiUc7vfyY05XL5PKoPnjGWbV8BIfzLVv97FV 0W5yazk8xJhCEESwmNBTyD5OGsUpnG6qsiz9ctlYwQb31OVNth/Tqc+jZvxGobyFJ6MtQI/Wvtd/KB 7+Z7ONoe5JhnDxsCJPMjpl5DY6oQUOooUp5OdQzwQMDgQ8AEzg6AfVNK2TOs2gW9QtTGYZlyPXJ+/z q392sUOnjtPukBJFP6Dngksf/tZm9IPuHp0EncZJpAgOg=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Currently, the initrd= command line option to the EFI stub only supports
loading files that reside on the same volume as the loaded image, which
is not workable for loaders like GRUB that don't even implement the
volume abstraction (EFI_SIMPLE_FILE_SYSTEM_PROTOCOL), and load the
kernel from an anonymous buffer in memory. For this reason, another
method was devised that relies on the LoadFile2 protocol.

However, the command line loader is rather useful when using the UEFI
shell or other generic loaders that have no awareness of Linux specific
protocols so let's make it a bit more flexible, by permitting textual
device paths to be provided to initrd= as well, provided that they refer
to a file hosted on a EFI_SIMPLE_FILE_SYSTEM_PROTOCOL volume. E.g.,

  initrd=PciRoot(0x0)/Pci(0x3,0x0)/HD(1,MBR,0xBE1AFDFA,0x3F,0xFBFC1)/rootfs.cpio.gz

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efistub.h | 15 ++++
 drivers/firmware/efi/libstub/file.c    | 77 +++++++++++++++++---
 include/linux/efi.h                    |  6 ++
 3 files changed, 87 insertions(+), 11 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 7e619f7ad438..f403aebf0182 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -179,6 +179,21 @@ union efi_device_path_to_text_protocol {
 
 typedef union efi_device_path_to_text_protocol efi_device_path_to_text_protocol_t;
 
+union efi_device_path_from_text_protocol {
+	struct {
+		efi_device_path_protocol_t *
+			(__efiapi *convert_text_to_device_node)(const efi_char16_t *);
+		efi_device_path_protocol_t *
+			(__efiapi *convert_text_to_device_path)(const efi_char16_t *);
+	};
+	struct {
+		u32 convert_text_to_device_node;
+		u32 convert_text_to_device_path;
+	} mixed_mode;
+};
+
+typedef union efi_device_path_from_text_protocol efi_device_path_from_text_protocol_t;
+
 typedef void *efi_event_t;
 /* Note that notifications won't work in mixed mode */
 typedef void (__efiapi *efi_event_notify_t)(efi_event_t, void *);
diff --git a/drivers/firmware/efi/libstub/file.c b/drivers/firmware/efi/libstub/file.c
index bf133d39a543..972ecc97b1d1 100644
--- a/drivers/firmware/efi/libstub/file.c
+++ b/drivers/firmware/efi/libstub/file.c
@@ -43,6 +43,13 @@ static efi_status_t efi_open_file(efi_file_protocol_t *volume,
 	efi_file_protocol_t *fh;
 	unsigned long info_sz;
 	efi_status_t status;
+	efi_char16_t *c;
+
+	/* Replace UNIX dir separators with EFI standard ones */
+	for (c = fi->filename; *c != L'\0'; c++) {
+		if (*c == L'/')
+			*c = L'\\';
+	}
 
 	status = volume->open(volume, &fh, fi->filename, EFI_FILE_MODE_READ, 0);
 	if (status != EFI_SUCCESS) {
@@ -129,16 +136,61 @@ static int find_file_option(const efi_char16_t *cmdline, int cmdline_len,
 
 		if (c == L'\0' || c == L'\n' || c == L' ')
 			break;
-		else if (c == L'/')
-			/* Replace UNIX dir separators with EFI standard ones */
-			*result++ = L'\\';
-		else
-			*result++ = c;
+		*result++ = c;
 	}
 	*result = L'\0';
 	return i;
 }
 
+static efi_status_t efi_open_device_path(efi_file_protocol_t **volume,
+					 struct finfo *fi)
+{
+	efi_guid_t text_to_dp_guid = EFI_DEVICE_PATH_FROM_TEXT_PROTOCOL_GUID;
+	static efi_device_path_from_text_protocol_t *text_to_dp = NULL;
+	efi_guid_t fs_proto = EFI_FILE_SYSTEM_GUID;
+	efi_device_path_protocol_t *initrd_dp;
+	efi_simple_file_system_protocol_t *io;
+	struct efi_file_path_dev_path *fpath;
+	efi_handle_t handle;
+	efi_status_t status;
+
+	/* See if the text to device path protocol exists */
+	if (!text_to_dp &&
+	    efi_bs_call(locate_protocol, &text_to_dp_guid, NULL,
+			(void **)&text_to_dp) != EFI_SUCCESS)
+		return EFI_UNSUPPORTED;
+
+
+	/* Convert the filename wide string into a device path */
+	initrd_dp = text_to_dp->convert_text_to_device_path(fi->filename);
+
+	/* Check whether the device path in question implements simple FS */
+	if ((efi_bs_call(locate_device_path, &fs_proto, &initrd_dp, &handle) ?:
+	     efi_bs_call(handle_protocol, handle, &fs_proto, (void **)&io))
+	    != EFI_SUCCESS)
+		return EFI_NOT_FOUND;
+
+	/* Check whether the remaining device path is a file device path */
+	if (initrd_dp->type != EFI_DEV_MEDIA ||
+	    initrd_dp->sub_type != EFI_DEV_MEDIA_FILE) {
+		efi_warn("Unexpected device path node type: (%x, %x)\n",
+			 initrd_dp->type, initrd_dp->sub_type);
+		return EFI_LOAD_ERROR;
+	}
+
+	/* Copy the remaining file path into the fi structure */
+	fpath = (struct efi_file_path_dev_path *)initrd_dp;
+	memcpy(fi->filename, fpath->filename,
+	       min(sizeof(fi->filename),
+		   fpath->header.length - sizeof(fpath->header)));
+
+	status = io->open_volume(io, volume);
+	if (status != EFI_SUCCESS)
+		efi_err("Failed to open volume\n");
+
+	return status;
+}
+
 /*
  * Check the cmdline for a LILO-style file= arguments.
  *
@@ -188,11 +240,13 @@ efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
 		cmdline += offset;
 		cmdline_len -= offset;
 
-		if (!volume) {
+		status = efi_open_device_path(&volume, &fi);
+		if (status == EFI_UNSUPPORTED || status == EFI_NOT_FOUND)
+			/* try the volume that holds the kernel itself */
 			status = efi_open_volume(image, &volume);
-			if (status != EFI_SUCCESS)
-				return status;
-		}
+
+		if (status != EFI_SUCCESS)
+			goto err_free_alloc;
 
 		status = efi_open_file(volume, &fi, &file, &size);
 		if (status != EFI_SUCCESS)
@@ -249,13 +303,12 @@ efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
 			size -= chunksize;
 		}
 		file->close(file);
+		volume->close(volume);
 	} while (offset > 0);
 
 	*load_addr = alloc_addr;
 	*load_size = alloc_size;
 
-	if (volume)
-		volume->close(volume);
 	return EFI_SUCCESS;
 
 err_close_file:
@@ -263,6 +316,8 @@ efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
 
 err_close_volume:
 	volume->close(volume);
+
+err_free_alloc:
 	efi_free(alloc_size, alloc_addr);
 	return status;
 }
diff --git a/include/linux/efi.h b/include/linux/efi.h
index da3974bf05d3..e739196ce9b2 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -371,6 +371,7 @@ void efi_native_runtime_setup(void);
 #define LOADED_IMAGE_DEVICE_PATH_PROTOCOL_GUID	EFI_GUID(0xbc62157e, 0x3e33, 0x4fec,  0x99, 0x20, 0x2d, 0x3b, 0x36, 0xd7, 0x50, 0xdf)
 #define EFI_DEVICE_PATH_PROTOCOL_GUID		EFI_GUID(0x09576e91, 0x6d3f, 0x11d2,  0x8e, 0x39, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b)
 #define EFI_DEVICE_PATH_TO_TEXT_PROTOCOL_GUID	EFI_GUID(0x8b843e20, 0x8132, 0x4852,  0x90, 0xcc, 0x55, 0x1a, 0x4e, 0x4a, 0x7f, 0x1c)
+#define EFI_DEVICE_PATH_FROM_TEXT_PROTOCOL_GUID	EFI_GUID(0x05c99a21, 0xc70f, 0x4ad2,  0x8a, 0x5f, 0x35, 0xdf, 0x33, 0x43, 0xf5, 0x1e)
 #define EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID	EFI_GUID(0x9042a9de, 0x23dc, 0x4a38,  0x96, 0xfb, 0x7a, 0xde, 0xd0, 0x80, 0x51, 0x6a)
 #define EFI_UGA_PROTOCOL_GUID			EFI_GUID(0x982c298b, 0xf4fa, 0x41cb,  0xb8, 0x38, 0x77, 0xaa, 0x68, 0x8f, 0xb8, 0x39)
 #define EFI_PCI_IO_PROTOCOL_GUID		EFI_GUID(0x4cf5b200, 0x68b8, 0x4ca5,  0x9e, 0xec, 0xb2, 0x3e, 0x3f, 0x50, 0x02, 0x9a)
@@ -1011,6 +1012,11 @@ struct efi_mem_mapped_dev_path {
 	u64				ending_addr;
 } __packed;
 
+struct efi_file_path_dev_path {
+	struct efi_generic_dev_path	header;
+	efi_char16_t			filename[];
+} __packed;
+
 struct efi_dev_path {
 	union {
 		struct efi_generic_dev_path	header;
-- 
2.35.1

