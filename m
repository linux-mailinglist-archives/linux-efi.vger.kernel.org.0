Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E295EBDE5
	for <lists+linux-efi@lfdr.de>; Tue, 27 Sep 2022 10:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbiI0I7F (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 27 Sep 2022 04:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbiI0I7C (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 27 Sep 2022 04:59:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78ED77E33A
        for <linux-efi@vger.kernel.org>; Tue, 27 Sep 2022 01:59:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E876B81A9C
        for <linux-efi@vger.kernel.org>; Tue, 27 Sep 2022 08:59:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D11BC433C1;
        Tue, 27 Sep 2022 08:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664269138;
        bh=m+x57A0P1GfwYS7XLRrN6i3hk+eSrpUKLsEtMpPA90s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y4S37wp5iQ6nhNqXy/6RpF+aNV2gdEgiKPOFYVRLcWwT0EiDM++L5KN3RGsI3zfa3
         +sScj2nsxycN6iOunlhwYhbfW+419y78zgYd6v1yrVmxM8wmlU5Onf8V5/L414LO7P
         bRiJSyeM2/MZFKM5SUdXeHV2Q1GJBiPOvdNfyBCO/E4Pc3pa3gF7sAAot0MLdf/Eau
         0EzKtq0Z+BL/9WdOzzfAAy0spZAT2NGhi90A7tEZQEPgQsFMKtrK/170ILxTmd1Orf
         RnAVo+0+ACqSK+OYd9fWHbC6ELA6qxkuuiKjNk6A3hM0JQrLjjA3qrwmwV0U7MESmD
         Rfy8OH3XaX1Vg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Atish Patra <atishp@atishpatra.org>,
        Lennart Poettering <lennart@poettering.net>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 3/4] efi: libstub: Add mixed mode support to command line initrd loader
Date:   Tue, 27 Sep 2022 10:58:41 +0200
Message-Id: <20220927085842.2860715-4-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220927085842.2860715-1-ardb@kernel.org>
References: <20220927085842.2860715-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9611; i=ardb@kernel.org; h=from:subject; bh=m+x57A0P1GfwYS7XLRrN6i3hk+eSrpUKLsEtMpPA90s=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjMrtALcOPOqpyKufl6npYzc4ubyLBaVrTcPAz5xEe G8t2kVmJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYzK7QAAKCRDDTyI5ktmPJD+XC/ 9m6XSJ1JzWyPJqGE4BaLLILpqjImNksJvFZwH9QoQQfXNIcEVY2AnPW2Y58/5NNglkJVExecZudYcq uY9CXAqufqMjj/DzKxa6j8PLK/5M+gk9P7H40LCrjifeLY1YqUXasRTLa3/e2EoMXV2ny5ImF7+jxy Y4laQyhCKnV6W6WunpCeSxN/toQyCwuUllKg9N8gu9MIRxaBIqWdBqd34PI6qoPNXDuEuMfkvS//GO NnibDqgOZZKOGqbl3yjn3ufiC6E9xL5/DmPEm/wCs+A3vTphD6AOoYlJfLIQng89tMl3AJz1slj466 HyovXy+Vxf/Amd3RlivK/ND/D8WE3s+j3xmgk2NvHsPszw2a7Wya3/Bf9r2FwV4XNihBHqGjRRwSy4 IxN7MxVUDRtc3CRoOPmkojSdNtnXhuq1VH/PGPSUMVw4XjSLnCCd8WPLCCA/CVJk+th+UKQ16HBYe1 tCPYbcpNDKu+Z5gsicyUZF4Ds7XqFJ/ujTyzhBfcy9UIQ=
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

Now that we have support for calling protocols that need additional
marshalling for mixed mode, wire up the initrd command line loader.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/efi.h                     | 11 +++
 drivers/firmware/efi/libstub/efi-stub-helper.c |  2 +-
 drivers/firmware/efi/libstub/efistub.h         | 81 +++++++++++++-------
 drivers/firmware/efi/libstub/file.c            | 34 ++++----
 4 files changed, 84 insertions(+), 44 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 8edead8568ec..9e56bd489b29 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -325,6 +325,17 @@ static inline u32 efi64_convert_status(efi_status_t status)
 #define __efi64_argmap_set_memory_space_attributes(phys, size, flags) \
 	(__efi64_split(phys), __efi64_split(size), __efi64_split(flags))
 
+/* file protocol */
+#define __efi64_argmap_open(prot, newh, fname, mode, attr) \
+	((prot), efi64_zero_upper(newh), (fname), __efi64_split(mode), \
+	 __efi64_split(attr))
+
+#define __efi64_argmap_set_position(pos) (__efi64_split(pos))
+
+/* file system protocol */
+#define __efi64_argmap_open_volume(prot, file) \
+	((prot), efi64_zero_upper(file))
+
 /*
  * The macros below handle the plumbing for the argument mapping. To add a
  * mapping for a specific EFI method, simply define a macro
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 3249d7927c88..37f42a1d1777 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -682,7 +682,7 @@ efi_status_t efi_load_initrd_cmdline(efi_loaded_image_t *image,
 				     unsigned long hard_limit)
 {
 	if (!IS_ENABLED(CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER) ||
-	    (IS_ENABLED(CONFIG_X86) && (!efi_is_native() || image == NULL)))
+	    (IS_ENABLED(CONFIG_X86) && image == NULL))
 		return EFI_UNSUPPORTED;
 
 	return handle_cmdline_files(image, L"initrd=", sizeof(L"initrd=") - 2,
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index d26d3d7b99c0..23b7880be11a 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -593,36 +593,63 @@ typedef struct {
 	efi_char16_t		filename[];
 } efi_file_info_t;
 
-typedef struct efi_file_protocol efi_file_protocol_t;
-
-struct efi_file_protocol {
-	u64		revision;
-	efi_status_t	(__efiapi *open)	(efi_file_protocol_t *,
-						 efi_file_protocol_t **,
-						 efi_char16_t *, u64, u64);
-	efi_status_t	(__efiapi *close)	(efi_file_protocol_t *);
-	efi_status_t	(__efiapi *delete)	(efi_file_protocol_t *);
-	efi_status_t	(__efiapi *read)	(efi_file_protocol_t *,
-						 unsigned long *, void *);
-	efi_status_t	(__efiapi *write)	(efi_file_protocol_t *,
-						 unsigned long, void *);
-	efi_status_t	(__efiapi *get_position)(efi_file_protocol_t *, u64 *);
-	efi_status_t	(__efiapi *set_position)(efi_file_protocol_t *, u64);
-	efi_status_t	(__efiapi *get_info)	(efi_file_protocol_t *,
-						 efi_guid_t *, unsigned long *,
-						 void *);
-	efi_status_t	(__efiapi *set_info)	(efi_file_protocol_t *,
-						 efi_guid_t *, unsigned long,
-						 void *);
-	efi_status_t	(__efiapi *flush)	(efi_file_protocol_t *);
+typedef union efi_file_protocol efi_file_protocol_t;
+
+union efi_file_protocol {
+	struct {
+		u64		revision;
+		efi_status_t	(__efiapi *open)	(efi_file_protocol_t *,
+							 efi_file_protocol_t **,
+							 efi_char16_t *, u64,
+							 u64);
+		efi_status_t	(__efiapi *close)	(efi_file_protocol_t *);
+		efi_status_t	(__efiapi *delete)	(efi_file_protocol_t *);
+		efi_status_t	(__efiapi *read)	(efi_file_protocol_t *,
+							 unsigned long *,
+							 void *);
+		efi_status_t	(__efiapi *write)	(efi_file_protocol_t *,
+							 unsigned long, void *);
+		efi_status_t	(__efiapi *get_position)(efi_file_protocol_t *,
+							 u64 *);
+		efi_status_t	(__efiapi *set_position)(efi_file_protocol_t *,
+							 u64);
+		efi_status_t	(__efiapi *get_info)	(efi_file_protocol_t *,
+							 efi_guid_t *,
+							 unsigned long *,
+							 void *);
+		efi_status_t	(__efiapi *set_info)	(efi_file_protocol_t *,
+							 efi_guid_t *,
+							 unsigned long,
+							 void *);
+		efi_status_t	(__efiapi *flush)	(efi_file_protocol_t *);
+	};
+	struct {
+		u64 revision;
+		u32 open;
+		u32 close;
+		u32 delete;
+		u32 read;
+		u32 write;
+		u32 get_position;
+		u32 set_position;
+		u32 get_info;
+		u32 set_info;
+		u32 flush;
+	} mixed_mode;
 };
 
-typedef struct efi_simple_file_system_protocol efi_simple_file_system_protocol_t;
+typedef union efi_simple_file_system_protocol efi_simple_file_system_protocol_t;
 
-struct efi_simple_file_system_protocol {
-	u64	revision;
-	int	(__efiapi *open_volume)(efi_simple_file_system_protocol_t *,
-					efi_file_protocol_t **);
+union efi_simple_file_system_protocol {
+	struct {
+		u64		revision;
+		efi_status_t	(__efiapi *open_volume)(efi_simple_file_system_protocol_t *,
+							efi_file_protocol_t **);
+	};
+	struct {
+		u64 revision;
+		u32 open_volume;
+	} mixed_mode;
 };
 
 #define EFI_FILE_MODE_READ	0x0000000000000001
diff --git a/drivers/firmware/efi/libstub/file.c b/drivers/firmware/efi/libstub/file.c
index 972ecc97b1d1..b16c6bdc9359 100644
--- a/drivers/firmware/efi/libstub/file.c
+++ b/drivers/firmware/efi/libstub/file.c
@@ -51,17 +51,18 @@ static efi_status_t efi_open_file(efi_file_protocol_t *volume,
 			*c = L'\\';
 	}
 
-	status = volume->open(volume, &fh, fi->filename, EFI_FILE_MODE_READ, 0);
+	status = efi_call_proto(volume, open, &fh, fi->filename,
+				EFI_FILE_MODE_READ, 0);
 	if (status != EFI_SUCCESS) {
 		efi_err("Failed to open file: %ls\n", fi->filename);
 		return status;
 	}
 
 	info_sz = sizeof(struct finfo);
-	status = fh->get_info(fh, &info_guid, &info_sz, fi);
+	status = efi_call_proto(fh, get_info, &info_guid, &info_sz, fi);
 	if (status != EFI_SUCCESS) {
 		efi_err("Failed to get file info\n");
-		fh->close(fh);
+		efi_call_proto(fh, close);
 		return status;
 	}
 
@@ -73,7 +74,7 @@ static efi_status_t efi_open_file(efi_file_protocol_t *volume,
 static efi_status_t efi_open_volume(efi_loaded_image_t *image,
 				    efi_file_protocol_t **fh)
 {
-	struct efi_vendor_dev_path *dp = image->file_path;
+	struct efi_vendor_dev_path *dp = efi_table_attr(image, file_path);
 	efi_guid_t li_proto = LOADED_IMAGE_PROTOCOL_GUID;
 	efi_guid_t fs_proto = EFI_FILE_SYSTEM_GUID;
 	efi_simple_file_system_protocol_t *io;
@@ -95,14 +96,14 @@ static efi_status_t efi_open_volume(efi_loaded_image_t *image,
 		}
 	}
 
-	status = efi_bs_call(handle_protocol, image->device_handle, &fs_proto,
-			     (void **)&io);
+	status = efi_bs_call(handle_protocol, efi_table_attr(image, device_handle),
+			     &fs_proto, (void **)&io);
 	if (status != EFI_SUCCESS) {
 		efi_err("Failed to handle fs_proto\n");
 		return status;
 	}
 
-	status = io->open_volume(io, fh);
+	status = efi_call_proto(io, open_volume, fh);
 	if (status != EFI_SUCCESS)
 		efi_err("Failed to open volume\n");
 
@@ -162,7 +163,8 @@ static efi_status_t efi_open_device_path(efi_file_protocol_t **volume,
 
 
 	/* Convert the filename wide string into a device path */
-	initrd_dp = text_to_dp->convert_text_to_device_path(fi->filename);
+	initrd_dp = efi_fn_call(text_to_dp, convert_text_to_device_path,
+				fi->filename);
 
 	/* Check whether the device path in question implements simple FS */
 	if ((efi_bs_call(locate_device_path, &fs_proto, &initrd_dp, &handle) ?:
@@ -184,7 +186,7 @@ static efi_status_t efi_open_device_path(efi_file_protocol_t **volume,
 	       min(sizeof(fi->filename),
 		   fpath->header.length - sizeof(fpath->header)));
 
-	status = io->open_volume(io, volume);
+	status = efi_call_proto(io, open_volume, volume);
 	if (status != EFI_SUCCESS)
 		efi_err("Failed to open volume\n");
 
@@ -205,8 +207,8 @@ efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
 				  unsigned long *load_addr,
 				  unsigned long *load_size)
 {
-	const efi_char16_t *cmdline = image->load_options;
-	u32 cmdline_len = image->load_options_size;
+	const efi_char16_t *cmdline = efi_table_attr(image, load_options);
+	u32 cmdline_len = efi_table_attr(image, load_options_size);
 	unsigned long efi_chunk_size = ULONG_MAX;
 	efi_file_protocol_t *volume = NULL;
 	efi_file_protocol_t *file;
@@ -294,7 +296,7 @@ efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
 		while (size) {
 			unsigned long chunksize = min(size, efi_chunk_size);
 
-			status = file->read(file, &chunksize, addr);
+			status = efi_call_proto(file, read, &chunksize, addr);
 			if (status != EFI_SUCCESS) {
 				efi_err("Failed to read file\n");
 				goto err_close_file;
@@ -302,8 +304,8 @@ efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
 			addr += chunksize;
 			size -= chunksize;
 		}
-		file->close(file);
-		volume->close(volume);
+		efi_call_proto(file, close);
+		efi_call_proto(volume, close);
 	} while (offset > 0);
 
 	*load_addr = alloc_addr;
@@ -312,10 +314,10 @@ efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
 	return EFI_SUCCESS;
 
 err_close_file:
-	file->close(file);
+	efi_call_proto(file, close);
 
 err_close_volume:
-	volume->close(volume);
+	efi_call_proto(volume, close);
 
 err_free_alloc:
 	efi_free(alloc_size, alloc_addr);
-- 
2.35.1

