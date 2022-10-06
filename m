Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6C45F643C
	for <lists+linux-efi@lfdr.de>; Thu,  6 Oct 2022 12:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiJFKQb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Oct 2022 06:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiJFKQb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 6 Oct 2022 06:16:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF678F970
        for <linux-efi@vger.kernel.org>; Thu,  6 Oct 2022 03:16:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC345618F5
        for <linux-efi@vger.kernel.org>; Thu,  6 Oct 2022 10:16:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE02C433C1;
        Thu,  6 Oct 2022 10:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665051388;
        bh=9oVN2O1qt/4Rop3kgYi+VbyOfY6SxN09q3RQRWq02r0=;
        h=From:To:Cc:Subject:Date:From;
        b=V6K47ihWCw65hfVKf+MxIGFM7zvObr/SFhKccdyxHcrCS/hHK+VWofqnYBh8N+1X/
         kBBykImSCjsU93G9iRgp487O8rt3xX0aN4QxLVcCiLMmjEznaQtOrf9SGTdnud/laA
         Z5fCl6L/GumeBUzEE2fMegfzKYTGlyNYFY57yQw8TpxkkRs4nkXzc+q+3KZ0+tqb4L
         xWZOGwuw/RMt/hFf2FOpMf614s9MW2EfkimL8z85CgrQIzQl+6xQ/WTUTXgJgT61Jp
         GikBLi9dq+aaSXB2NJn0kfTAHuasVO2UH2oERgD1Zqehq8ZydrPpI+D/HsOdFNtTmm
         Fra55CUXMF8lA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Lennart Poettering <lennart@poettering.net>,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [RFC PATCH] efi: zboot: Expose decompressed image via EFI_FIRMWARE_VOLUME2 protocol
Date:   Thu,  6 Oct 2022 12:16:17 +0200
Message-Id: <20221006101617.1137551-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13760; i=ardb@kernel.org; h=from:subject; bh=9oVN2O1qt/4Rop3kgYi+VbyOfY6SxN09q3RQRWq02r0=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjPqrwXQTEzjcQOxZTBUGpFuRRiUqwDudKbIVCKOnF xnu4Fn+JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYz6q8AAKCRDDTyI5ktmPJIGYC/ 9hFB7BDPP7ZP6K0DzK88mdE6xIBFpGoCtZSUQtYqdGdFAuLHaGsdUApcQuhCa5BRziP/JVtqXOxTOm q+YGiVzEpmmJavMmDucSteBz3Y/187GxNbywuNQwyzZKdoLOYzrITx3++GcMfs4Dg5m+GXyeseC3e0 JJmkZ6zFwMHgDQt9aTIUz0FumN4pfKdbudvwIzBenciOd830tcM07L6vgi3agHF8DrooEg0cfK28VD XgmX0l99d9kT7/YbVz7cNv5WPEpDz4GeOqQu2SgtG1iNIh6SlVRJ1RDSpy5htwRZWj/xsnvJ2/CMBH JdtMWwM+CArgmGNdnkMhv8KfqjMFXuqV1D+HxVHSGvjYZ6UBnxahZIG1yS4ooG+RDsa0dEcV3RjIed OtJAoLbveK3k+0kfWCx80oq0fmthYjzySO2tMj9Vk35gcSiX95FenAAXay3ewLmZ5SauepMPd9YCCa PgowSd5y7jZvQE7Ae2EPmKVVEtc9FX6qI6WE6xLgYUv48=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In addition to exposing the decompressed payload to the LoadImage UEFI
boot service via the LoadFile2 protocol, which requires that the image
is signed if secure boot is enabled, let's expose it via the PI spec
protocol EFI_FIRMWARE_VOLUME2_PROTOCOL as well. This protocol is
typically exempt from secure boot checks on Tianocore PI/UEFI based
firmware implementations, removing the need to sign the inner image or
rely on hand-rolled LoadImage() implementations in cases where an
intermediate loader such as shim is being used.

Cc: Peter Jones <pjones@redhat.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Lennart Poettering <lennart@poettering.net>
Cc: Jeremy Linton <jeremy.linton@arm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efistub.h |  34 +++-
 drivers/firmware/efi/libstub/file.c    |   3 +-
 drivers/firmware/efi/libstub/zboot.c   | 209 +++++++++++++++++++-
 include/linux/efi.h                    |   4 +
 4 files changed, 241 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 313647b1c196..5e8f0d694af9 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -286,7 +286,7 @@ union efi_boot_services {
 		efi_status_t (__efiapi *install_configuration_table)(efi_guid_t *,
 								     void *);
 		efi_status_t (__efiapi *load_image)(bool, efi_handle_t,
-						    efi_device_path_protocol_t *,
+						    const efi_device_path_protocol_t *,
 						    void *, unsigned long,
 						    efi_handle_t *);
 		efi_status_t (__efiapi *start_image)(efi_handle_t, unsigned long *,
@@ -878,6 +878,38 @@ union efi_load_file_protocol {
 	} mixed_mode;
 };
 
+typedef struct efi_firmware_volume2_protocol efi_firmware_volume2_protocol_t;
+
+struct efi_firmware_volume2_protocol {
+	efi_status_t (__efiapi *get_volume_attributes)
+		     (efi_firmware_volume2_protocol_t const *, u64 *);
+	efi_status_t (__efiapi *set_volume_attributes)
+		     (efi_firmware_volume2_protocol_t const *, u64 *);
+	efi_status_t (__efiapi *read_file)
+		     (efi_firmware_volume2_protocol_t const *,
+		      efi_guid_t const *, void **, unsigned long *, u8 *type,
+		      u64 *attr, u32 *auth_status);
+	efi_status_t (__efiapi *read_section)
+		     (efi_firmware_volume2_protocol_t const *,
+		      efi_guid_t const *, u8 type, unsigned long instance,
+		      void **, unsigned long *, u32 *auth_status);
+	efi_status_t (__efiapi *write_file)
+		     (efi_firmware_volume2_protocol_t const *, u32, u32, void *);
+	efi_status_t (__efiapi *get_next_file)
+		     (efi_firmware_volume2_protocol_t const *, void *, u8 *type,
+		      efi_guid_t *, u64 *, unsigned long *);
+
+	u32		keysize;
+	efi_handle_t	parent_handle;
+
+	efi_status_t (__efiapi *get_info)
+		     (efi_firmware_volume2_protocol_t const *,
+		      efi_guid_t const *, unsigned long *, void *);
+	efi_status_t (__efiapi *set_info)
+		     (efi_firmware_volume2_protocol_t const *,
+		      efi_guid_t const *, unsigned long, void *);
+};
+
 typedef struct {
 	u32 attributes;
 	u16 file_path_list_length;
diff --git a/drivers/firmware/efi/libstub/file.c b/drivers/firmware/efi/libstub/file.c
index 995d9d823519..21c01ab0a328 100644
--- a/drivers/firmware/efi/libstub/file.c
+++ b/drivers/firmware/efi/libstub/file.c
@@ -86,7 +86,8 @@ static efi_status_t efi_open_volume(efi_loaded_image_t *image,
 	    image->parent_handle != NULL &&
 	    dp != NULL &&
 	    dp->header.type == EFI_DEV_MEDIA &&
-	    dp->header.sub_type == EFI_DEV_MEDIA_VENDOR &&
+	    (dp->header.sub_type == EFI_DEV_MEDIA_VENDOR ||
+	     dp->header.sub_type == EFI_DEV_MEDIA_PIWG_FILE) &&
 	    !efi_guidcmp(dp->vendorguid, LINUX_EFI_ZBOOT_MEDIA_GUID)) {
 		status = efi_bs_call(handle_protocol, image->parent_handle,
 				     &li_proto, (void *)&image);
diff --git a/drivers/firmware/efi/libstub/zboot.c b/drivers/firmware/efi/libstub/zboot.c
index ea72c8f27da6..4b270546675d 100644
--- a/drivers/firmware/efi/libstub/zboot.c
+++ b/drivers/firmware/efi/libstub/zboot.c
@@ -159,6 +159,166 @@ static void append_end_node(efi_device_path_protocol_t **dp)
 	++*dp;
 }
 
+#define FV	EFI_GUID(0x397e3c73, 0x05a5, 0x432f, 0x94, 0x91, 0x6a, 0x2c, 0x0c, 0x3b, 0x5f, 0xa7)
+
+static const struct {
+	struct efi_vendor_dev_path	fv;
+	struct efi_generic_dev_path	end;
+} __packed fv_dp = {
+	{
+		{
+			EFI_DEV_MEDIA,
+			EFI_DEV_MEDIA_PIWG_VOLUME,
+			sizeof(struct efi_vendor_dev_path)
+		},
+		FV
+	}, {
+		EFI_DEV_END_PATH,
+		EFI_DEV_END_ENTIRE,
+		sizeof(struct efi_generic_dev_path)
+	}
+};
+
+static const struct {
+	struct efi_vendor_dev_path	fv;
+	struct efi_vendor_dev_path	fvfile;
+	struct efi_generic_dev_path	end;
+} __packed fvfile_dp = {
+	{
+		{
+			EFI_DEV_MEDIA,
+			EFI_DEV_MEDIA_PIWG_VOLUME,
+			sizeof(struct efi_vendor_dev_path)
+		},
+		FV
+	}, {
+		{
+			EFI_DEV_MEDIA,
+			EFI_DEV_MEDIA_PIWG_FILE,
+			sizeof(struct efi_vendor_dev_path)
+		},
+		LINUX_EFI_ZBOOT_MEDIA_GUID
+	}, {
+		EFI_DEV_END_PATH,
+		EFI_DEV_END_ENTIRE,
+		sizeof(struct efi_generic_dev_path)
+	}
+};
+
+/* Assorted PI definitions used below */
+#define EFI_SECTION_PE32		0x10
+#define EFI_AUTH_STATUS_IMAGE_SIGNED	0x02
+#define EFI_WARN_BUFFER_TOO_SMALL	0x04
+#define EFI_FV2_READ_STATUS		0x04
+#define EFI_FV2_LOCK_CAP		0x40
+#define EFI_FV2_LOCK_STATUS		0x80
+
+static efi_status_t __efiapi
+fwvol_get_volume_attributes(efi_firmware_volume2_protocol_t const *this,
+			    u64 *attr)
+{
+	*attr = EFI_FV2_READ_STATUS | EFI_FV2_LOCK_CAP | EFI_FV2_LOCK_STATUS;
+	return EFI_SUCCESS;
+}
+
+static efi_status_t __efiapi
+fwvol_set_volume_attributes(efi_firmware_volume2_protocol_t const *this,
+			    u64 *attr)
+{
+	return EFI_ACCESS_DENIED;
+}
+
+static efi_status_t __efiapi
+fwvol_read_section(efi_firmware_volume2_protocol_t const *this,
+		   efi_guid_t const *name, u8 type,
+		   unsigned long instance, void **buffer,
+		   unsigned long *buffer_size, u32 *auth_status)
+{
+	unsigned long uncompressed_size = get_unaligned_le32(_gzdata_end - 4);
+	unsigned long compressed_size = _gzdata_end - _gzdata_start;
+	efi_status_t status;
+	void *buf;
+	int ret;
+
+	if (type != EFI_SECTION_PE32 || instance != 0 ||
+	    !guids_eq(name, &LINUX_EFI_ZBOOT_MEDIA_GUID))
+		return EFI_NOT_FOUND;
+
+	if (!*buffer) {
+		status = efi_bs_call(allocate_pool, EFI_BOOT_SERVICES_DATA,
+				     uncompressed_size, &buf);
+		if (status != EFI_SUCCESS)
+			return status;
+		*buffer_size = uncompressed_size;
+	} else {
+		buf = *buffer;
+		if (*buffer_size < uncompressed_size)
+			status = EFI_WARN_BUFFER_TOO_SMALL;
+		else
+			status = EFI_SUCCESS;
+	}
+
+	ret = __decompress(_gzdata_start, compressed_size, NULL, NULL,
+			   buf, *buffer_size, NULL, error);
+	if (ret	< 0 && status == EFI_SUCCESS) {
+		log(L"Decompression failed");
+		if (!*buffer)
+			efi_bs_call(free_pool, *buffer);
+		return EFI_DEVICE_ERROR;
+	}
+
+	*auth_status = EFI_AUTH_STATUS_IMAGE_SIGNED;
+	*buffer = buf;
+
+	return status;
+}
+
+static efi_status_t __efiapi
+fwvol_read_file(efi_firmware_volume2_protocol_t const *this,
+	        efi_guid_t const *name, void **buffer,
+		unsigned long *buffer_size, u8 *type,
+	        u64 *attr, u32 *auth_status)
+{
+	if (!guids_eq(name, &LINUX_EFI_ZBOOT_MEDIA_GUID))
+		return EFI_NOT_FOUND;
+
+	*type = EFI_SECTION_PE32;
+	*attr = 0;
+	return fwvol_read_section(this, name, *type, 0, buffer, buffer_size,
+				  auth_status);
+}
+
+static efi_status_t __efiapi
+fwvol_write_file(efi_firmware_volume2_protocol_t const *this, u32 num_files,
+		 u32 write_policy, void *file_data)
+{
+	return EFI_WRITE_PROTECTED;
+}
+
+static efi_status_t __efiapi
+fwvol_get_next_file(efi_firmware_volume2_protocol_t const *this,
+		    void *key, u8 *type, efi_guid_t *name_guid,
+		    u64 *attributes, unsigned long *size)
+{
+	return EFI_NOT_FOUND;
+}
+
+static efi_status_t __efiapi
+fwvol_get_info(efi_firmware_volume2_protocol_t const *this,
+	       efi_guid_t const *info_type, unsigned long *buffer_size,
+	       void *buffer)
+{
+	return EFI_UNSUPPORTED;
+}
+
+static efi_status_t __efiapi
+fwvol_set_info(efi_firmware_volume2_protocol_t const *this,
+	       efi_guid_t const *info_type, unsigned long buffer_size,
+	       void *buffer)
+{
+	return EFI_WRITE_PROTECTED;
+}
+
 asmlinkage efi_status_t __efiapi
 efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
 {
@@ -168,11 +328,13 @@ efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
 		.header.length		= sizeof(struct efi_mem_mapped_dev_path)
 	};
 	efi_device_path_protocol_t *parent_dp, *dpp, *lf2_dp, *li_dp;
+	efi_firmware_volume2_protocol_t zboot_fwvol;
 	efi_load_file2_protocol_t zboot_load_file2;
 	efi_loaded_image_t *parent, *child;
 	unsigned long exit_data_size;
 	efi_handle_t child_handle;
-	efi_handle_t zboot_handle;
+	efi_handle_t fwvol_handle;
+	efi_handle_t lf2_handle;
 	efi_char16_t *exit_data;
 	efi_status_t status;
 	void *dp_alloc;
@@ -237,10 +399,11 @@ efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
 	append_ven_media_node(&dpp, &LINUX_EFI_ZBOOT_MEDIA_GUID);
 	append_end_node(&dpp);
 
-	zboot_handle = NULL;
 	zboot_load_file2.load_file = load_file;
+
+	lf2_handle = NULL;
 	status = efi_bs_call(install_multiple_protocol_interfaces,
-			     &zboot_handle,
+			     &lf2_handle,
 			     &EFI_DEVICE_PATH_PROTOCOL_GUID, lf2_dp,
 			     &EFI_LOAD_FILE2_PROTOCOL_GUID, &zboot_load_file2,
 			     NULL);
@@ -249,13 +412,38 @@ efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
 		goto free_dpalloc;
 	}
 
-	status = efi_bs_call(load_image, false, handle, li_dp, NULL, 0,
-			     &child_handle);
+	zboot_fwvol.get_volume_attributes	= fwvol_get_volume_attributes;
+	zboot_fwvol.set_volume_attributes	= fwvol_set_volume_attributes;
+	zboot_fwvol.read_section		= fwvol_read_section;
+	zboot_fwvol.read_file			= fwvol_read_file;
+	zboot_fwvol.write_file			= fwvol_write_file;
+	zboot_fwvol.get_next_file		= fwvol_get_next_file;
+	zboot_fwvol.keysize			= 4;
+	zboot_fwvol.parent_handle		= NULL;
+	zboot_fwvol.get_info			= fwvol_get_info;
+	zboot_fwvol.set_info			= fwvol_set_info;
+
+	fwvol_handle = NULL;
+	status = efi_bs_call(install_multiple_protocol_interfaces,
+			     &fwvol_handle,
+			     &EFI_DEVICE_PATH_PROTOCOL_GUID, fv_dp,
+			     &EFI_FIRMWARE_VOLUME2_PROTOCOL_GUID, &zboot_fwvol,
+			     NULL);
 	if (status != EFI_SUCCESS) {
-		log(L"Failed to load image");
+		log(L"Failed to install FirmwareVolume2 protocol and device path");
 		goto uninstall_lf2;
 	}
 
+	status = efi_bs_call(load_image, false, handle, &fvfile_dp.fv.header,
+			     NULL, 0, &child_handle);
+	if (status == EFI_NOT_FOUND)
+		status = efi_bs_call(load_image, false, handle, li_dp, NULL, 0,
+				     &child_handle);
+	if (status != EFI_SUCCESS) {
+		log(L"Failed to load image");
+		goto uninstall_fwvol;
+	}
+
 	status = efi_bs_call(handle_protocol, child_handle,
 			     &LOADED_IMAGE_PROTOCOL_GUID, (void **)&child);
 	if (status != EFI_SUCCESS) {
@@ -281,9 +469,16 @@ efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
 			efi_bs_call(unload_image, child_handle);
 	}
 
+uninstall_fwvol:
+	efi_bs_call(uninstall_multiple_protocol_interfaces,
+		    fwvol_handle,
+		    &EFI_DEVICE_PATH_PROTOCOL_GUID, fv_dp,
+		    &EFI_FIRMWARE_VOLUME2_PROTOCOL_GUID, &zboot_fwvol,
+		    NULL);
+
 uninstall_lf2:
 	efi_bs_call(uninstall_multiple_protocol_interfaces,
-		    zboot_handle,
+		    lf2_handle,
 		    &EFI_DEVICE_PATH_PROTOCOL_GUID, lf2_dp,
 		    &EFI_LOAD_FILE2_PROTOCOL_GUID, &zboot_load_file2,
 		    NULL);
diff --git a/include/linux/efi.h b/include/linux/efi.h
index be667c0919b2..66132795c87e 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -39,6 +39,7 @@
 #define EFI_WRITE_PROTECTED	( 8 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_OUT_OF_RESOURCES	( 9 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_NOT_FOUND		(14 | (1UL << (BITS_PER_LONG-1)))
+#define EFI_ACCESS_DENIED	(15 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_TIMEOUT		(18 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_ABORTED		(21 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_SECURITY_VIOLATION	(26 | (1UL << (BITS_PER_LONG-1)))
@@ -390,6 +391,7 @@ void efi_native_runtime_setup(void);
 #define EFI_LOAD_FILE2_PROTOCOL_GUID		EFI_GUID(0x4006c0c1, 0xfcb3, 0x403e,  0x99, 0x6d, 0x4a, 0x6c, 0x87, 0x24, 0xe0, 0x6d)
 #define EFI_RT_PROPERTIES_TABLE_GUID		EFI_GUID(0xeb66918a, 0x7eef, 0x402a,  0x84, 0x2e, 0x93, 0x1d, 0x21, 0xc3, 0x8a, 0xe9)
 #define EFI_DXE_SERVICES_TABLE_GUID		EFI_GUID(0x05ad34ba, 0x6f02, 0x4214,  0x95, 0x2e, 0x4d, 0xa0, 0x39, 0x8e, 0x2b, 0xb9)
+#define EFI_FIRMWARE_VOLUME2_PROTOCOL_GUID	EFI_GUID(0x220e73b6, 0x6bdb, 0x4413,  0x84, 0x05, 0xb9, 0x74, 0xb1, 0x08, 0x61, 0x9a)
 
 #define EFI_IMAGE_SECURITY_DATABASE_GUID	EFI_GUID(0xd719b2cb, 0x3d3a, 0x4596,  0xa3, 0xbc, 0xda, 0xd0, 0x0e, 0x67, 0x65, 0x6f)
 #define EFI_SHIM_LOCK_GUID			EFI_GUID(0x605dab50, 0xe046, 0x4300,  0xab, 0xb6, 0x3d, 0xd8, 0x10, 0xdd, 0x8b, 0x23)
@@ -950,6 +952,8 @@ extern int efi_status_to_err(efi_status_t status);
 #define   EFI_DEV_MEDIA_VENDOR			 3
 #define   EFI_DEV_MEDIA_FILE			 4
 #define   EFI_DEV_MEDIA_PROTOCOL		 5
+#define   EFI_DEV_MEDIA_PIWG_FILE		 6
+#define   EFI_DEV_MEDIA_PIWG_VOLUME		 7
 #define   EFI_DEV_MEDIA_REL_OFFSET		 8
 #define EFI_DEV_BIOS_BOOT		0x05
 #define EFI_DEV_END_PATH		0x7F
-- 
2.35.1

