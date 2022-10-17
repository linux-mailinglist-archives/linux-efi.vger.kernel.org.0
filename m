Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4176014A1
	for <lists+linux-efi@lfdr.de>; Mon, 17 Oct 2022 19:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiJQRSu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Oct 2022 13:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiJQRSf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Oct 2022 13:18:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B27972682
        for <linux-efi@vger.kernel.org>; Mon, 17 Oct 2022 10:18:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7DB58B816B3
        for <linux-efi@vger.kernel.org>; Mon, 17 Oct 2022 17:18:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE30C433C1;
        Mon, 17 Oct 2022 17:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666027108;
        bh=cVOgfITgifl6uiubaj82MpNlFcEzkqOyCMw5CiaL4Jw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HBvaNb3v6LgHOSkV2zcyS7ThenCRIljghvddEUBLSqb+c57WMTo3xko71miWrlQ1J
         FKizd5c2swnxPT4LNASpdqQtOBSfQ3DKzFo1j3OE+inB7bmDigUth2cDeZvy+6iL21
         G7F5QHhypT19o+BoWHfLQGAKww6kmIRHdDyx5iI9iEgaqsb/p62DSG8D0FmwS4PmP/
         F0YR865uKWFBY4WZHajbaKWjMX+shl7EOMX6/n67sVCY89tKLdiomsJEa2VSOUVqx2
         JcAiKLJYv2m2QFtc+oiom2JakQaq2bwMAxF6Knvtf2QPeHmTPOd9JzM4Cq8C9byPI8
         Cnh1NEOfYFEMw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     keescook@chromium.org, Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>,
        Lennart Poettering <lennart@poettering.net>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 21/21] efi: libstub: Merge zboot decompressor with the ordinary stub
Date:   Mon, 17 Oct 2022 19:17:00 +0200
Message-Id: <20221017171700.3736890-22-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221017171700.3736890-1-ardb@kernel.org>
References: <20221017171700.3736890-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14544; i=ardb@kernel.org; h=from:subject; bh=cVOgfITgifl6uiubaj82MpNlFcEzkqOyCMw5CiaL4Jw=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjTY4LzFzsunfP1IWtOLdg/jkr7K3yJWUkIWwooFkV L/LFMfCJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY02OCwAKCRDDTyI5ktmPJKpbC/ wLZ934D5yW+15dxp3Hwz6h1bSiSQM3ACYS3CGLATuDpxQjJYbxCzQ6zyvXIWy7UMl91TKoFAkso36S 5S0IpL9lqm3dVetuSLq7Cdz1edlVdP6r7TjBRPHusC0TTl9Wr5oni4dGbhDsTghBcHt7pZ4FPPj4gp R+lvNKmVALt7y5+zCczp6BfuS6P9TgWjf14izGwlrteFqUeVTTSq8fq1cFJMdiAqkcIsLhPT50SOIj RXJrJWxNznqmphpCiZErrfe8pn4BTHR+vGdWNc9DYxnHcZtMljUFKDFAKGOIECVh5yG3fes4IYMwyL RybREfBN25hhNN9OcH5W3nDoXk1Rkjk/6vwUmsnQWxj1Bq719+Y5qNGoZ53hY/rQi/p9eznPBkQWIx sXl7Y7EomZvXZBKYWp2LZ7Q9W4GSd1gEr2XLWBfxpuLTrpUiMBsDuQNePNwFsklK8iR3waUxb0knqp XVClwktN+BqH2HS6yiE68/MJsvhZT+3wu2NAq2lmoYd3E=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Even though our EFI zboot decompressor is pedantically spec compliant
and idiomatic for EFI image loaders, calling LoadImage() and
StartImage() for the nested image is a bit of a burden. Not only does it
create workflow issues for the distros (as both the inner and outer
PE/COFF images need to be signed for secure boot), it also copies the
image around in memory numerous times:
- first, the image is decompressed into a buffer;
- the buffer is consumed by LoadImage(), which copies the sections into
  a newly allocated memory region to hold the executable image;
- once the EFI stub is invoked by StartImage(), it will also move the
  image in memory in case of KASLR, mirrored memory or if the image must
  execute from a certain a priori defined address.

There are only two EFI spec compliant ways to load code into memory and
execute it:
- use LoadImage() and StartImage(),
- call ExitBootServices() and take ownership of the entire system, after
  which anything goes.

Given that the EFI zboot decompressor always invokes the EFI stub, and
given that both are built from the same set of objects, let's merge the
two, so that we can avoid LoadImage()/StartImage but still load our
image into memory without breaking the above rules.

This also means we can decompress the image directly into its final
location, which could be randomized or meet other platform specific
constraints that LoadImage() does not know how to adhere to. It also
means that, even if the encapsulated image still has the EFI stub
incorporated as well, it does not need to be signed for secure boot when
wrapping it in the EFI zboot decompressor.

In the future, we might decide to retire the EFI stub attached to the
decompressed image, but for the time being, they can happily coexist.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/file.c  |  18 --
 drivers/firmware/efi/libstub/zboot.c | 284 +++++---------------
 2 files changed, 74 insertions(+), 228 deletions(-)

diff --git a/drivers/firmware/efi/libstub/file.c b/drivers/firmware/efi/libstub/file.c
index 995d9d823519..d6a025df07dc 100644
--- a/drivers/firmware/efi/libstub/file.c
+++ b/drivers/firmware/efi/libstub/file.c
@@ -74,28 +74,10 @@ static efi_status_t efi_open_file(efi_file_protocol_t *volume,
 static efi_status_t efi_open_volume(efi_loaded_image_t *image,
 				    efi_file_protocol_t **fh)
 {
-	struct efi_vendor_dev_path *dp = efi_table_attr(image, file_path);
-	efi_guid_t li_proto = LOADED_IMAGE_PROTOCOL_GUID;
 	efi_guid_t fs_proto = EFI_FILE_SYSTEM_GUID;
 	efi_simple_file_system_protocol_t *io;
 	efi_status_t status;
 
-	// If we are using EFI zboot, we should look for the file system
-	// protocol on the parent image's handle instead
-	if (IS_ENABLED(CONFIG_EFI_ZBOOT) &&
-	    image->parent_handle != NULL &&
-	    dp != NULL &&
-	    dp->header.type == EFI_DEV_MEDIA &&
-	    dp->header.sub_type == EFI_DEV_MEDIA_VENDOR &&
-	    !efi_guidcmp(dp->vendorguid, LINUX_EFI_ZBOOT_MEDIA_GUID)) {
-		status = efi_bs_call(handle_protocol, image->parent_handle,
-				     &li_proto, (void *)&image);
-		if (status != EFI_SUCCESS) {
-			efi_err("Failed to locate parent image handle\n");
-			return status;
-		}
-	}
-
 	status = efi_bs_call(handle_protocol, efi_table_attr(image, device_handle),
 			     &fs_proto, (void **)&io);
 	if (status != EFI_SUCCESS) {
diff --git a/drivers/firmware/efi/libstub/zboot.c b/drivers/firmware/efi/libstub/zboot.c
index 5f41a5b17d6e..66be5fdc6b58 100644
--- a/drivers/firmware/efi/libstub/zboot.c
+++ b/drivers/firmware/efi/libstub/zboot.c
@@ -37,247 +37,111 @@ static void error(char *x)
 	efi_err("EFI decompressor: %s\n", x);
 }
 
-static efi_status_t __efiapi
-load_file(efi_load_file_protocol_t *this, efi_device_path_protocol_t *rem,
-	  bool boot_policy, unsigned long *bufsize, void *buffer)
+static unsigned long alloc_preferred_address(unsigned long alloc_size)
 {
-	unsigned long compressed_size = _gzdata_end - _gzdata_start;
-	struct efi_vendor_dev_path *vendor_dp;
-	bool decompress = false;
-	unsigned long size;
-	int ret;
-
-	if (rem == NULL || bufsize == NULL)
-		return EFI_INVALID_PARAMETER;
-
-	if (boot_policy)
-		return EFI_UNSUPPORTED;
-
-	// Look for our vendor media device node in the remaining file path
-	if (rem->type == EFI_DEV_MEDIA &&
-	    rem->sub_type == EFI_DEV_MEDIA_VENDOR) {
-		vendor_dp = container_of(rem, struct efi_vendor_dev_path, header);
-		if (efi_guidcmp(vendor_dp->vendorguid, LINUX_EFI_ZBOOT_MEDIA_GUID))
-			return EFI_NOT_FOUND;
-
-		decompress = true;
-		rem = (void *)(vendor_dp + 1);
-	}
-
-	if (rem->type != EFI_DEV_END_PATH ||
-	    rem->sub_type != EFI_DEV_END_ENTIRE)
-		return EFI_NOT_FOUND;
-
-	// The uncompressed size of the payload is appended to the raw bit
-	// stream, and may therefore appear misaligned in memory
-	size = decompress ? get_unaligned_le32(_gzdata_end - 4)
-			  : compressed_size;
-	if (buffer == NULL || *bufsize < size) {
-		*bufsize = size;
-		return EFI_BUFFER_TOO_SMALL;
-	}
-
-	if (decompress) {
-		ret = __decompress(_gzdata_start, compressed_size, NULL, NULL,
-				   buffer, size, NULL, error);
-		if (ret	< 0) {
-			error("Decompression failed");
-			return EFI_DEVICE_ERROR;
-		}
-	} else {
-		memcpy(buffer, _gzdata_start, compressed_size);
-	}
-
-	return EFI_SUCCESS;
-}
-
-// Return the length in bytes of the device path up to the first end node.
-static int device_path_length(const efi_device_path_protocol_t *dp)
-{
-	int len = 0;
-
-	while (dp->type != EFI_DEV_END_PATH) {
-		len += dp->length;
-		dp = (void *)((u8 *)dp + dp->length);
-	}
-	return len;
-}
-
-static void append_rel_offset_node(efi_device_path_protocol_t **dp,
-				   unsigned long start, unsigned long end)
-{
-	struct efi_rel_offset_dev_path *rodp = (void *)*dp;
-
-	rodp->header.type	= EFI_DEV_MEDIA;
-	rodp->header.sub_type	= EFI_DEV_MEDIA_REL_OFFSET;
-	rodp->header.length	= sizeof(struct efi_rel_offset_dev_path);
-	rodp->reserved		= 0;
-	rodp->starting_offset	= start;
-	rodp->ending_offset	= end;
-
-	*dp = (void *)(rodp + 1);
-}
-
-static void append_ven_media_node(efi_device_path_protocol_t **dp,
-				  efi_guid_t *guid)
-{
-	struct efi_vendor_dev_path *vmdp = (void *)*dp;
-
-	vmdp->header.type	= EFI_DEV_MEDIA;
-	vmdp->header.sub_type	= EFI_DEV_MEDIA_VENDOR;
-	vmdp->header.length	= sizeof(struct efi_vendor_dev_path);
-	vmdp->vendorguid	= *guid;
+#ifdef EFI_KIMG_PREFERRED_ADDRESS
+	efi_physical_addr_t efi_addr = EFI_KIMG_PREFERRED_ADDRESS;
 
-	*dp = (void *)(vmdp + 1);
+	if (efi_bs_call(allocate_pages, EFI_ALLOCATE_ADDRESS, EFI_LOADER_DATA,
+			alloc_size / EFI_PAGE_SIZE, &efi_addr) == EFI_SUCCESS)
+		return efi_addr;
+#endif
+	return ULONG_MAX;
 }
 
-static void append_end_node(efi_device_path_protocol_t **dp)
+void __weak efi_cache_sync_image(unsigned long image_base,
+				 unsigned long alloc_size,
+				 unsigned long code_size)
 {
-	(*dp)->type		= EFI_DEV_END_PATH;
-	(*dp)->sub_type		= EFI_DEV_END_ENTIRE;
-	(*dp)->length		= sizeof(struct efi_generic_dev_path);
-
-	++*dp;
+	// Provided by the arch to perform the cache maintenance necessary for
+	// executable code loaded into memory to be safe for execution.
 }
 
 asmlinkage efi_status_t __efiapi
 efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
 {
-	struct efi_mem_mapped_dev_path mmdp = {
-		.header.type		= EFI_DEV_HW,
-		.header.sub_type	= EFI_DEV_MEM_MAPPED,
-		.header.length		= sizeof(struct efi_mem_mapped_dev_path)
-	};
-	efi_device_path_protocol_t *parent_dp, *dpp, *lf2_dp, *li_dp;
-	efi_load_file2_protocol_t zboot_load_file2;
-	efi_loaded_image_t *parent, *child;
-	unsigned long exit_data_size;
-	efi_handle_t child_handle;
-	efi_handle_t zboot_handle;
-	efi_char16_t *exit_data;
+	unsigned long compressed_size = _gzdata_end - _gzdata_start;
+	unsigned long image_base, alloc_size, code_size;
+	efi_loaded_image_t *image;
 	efi_status_t status;
-	void *dp_alloc;
-	int dp_len;
+	char *cmdline_ptr;
+	int ret;
 
 	WRITE_ONCE(efi_system_table, systab);
 
 	free_mem_ptr = (unsigned long)&zboot_heap;
 	free_mem_end_ptr = free_mem_ptr + sizeof(zboot_heap);
 
-	exit_data = NULL;
-	exit_data_size = 0;
-
 	status = efi_bs_call(handle_protocol, handle,
-			     &LOADED_IMAGE_PROTOCOL_GUID, (void **)&parent);
+			     &LOADED_IMAGE_PROTOCOL_GUID, (void **)&image);
 	if (status != EFI_SUCCESS) {
 		error("Failed to locate parent's loaded image protocol");
 		return status;
 	}
 
-	status = efi_bs_call(handle_protocol, handle,
-			     &LOADED_IMAGE_DEVICE_PATH_PROTOCOL_GUID,
-			     (void **)&parent_dp);
-	if (status != EFI_SUCCESS || parent_dp == NULL) {
-		// Create a MemoryMapped() device path node to describe
-		// the parent image if no device path was provided.
-		mmdp.memory_type	= parent->image_code_type;
-		mmdp.starting_addr	= (unsigned long)parent->image_base;
-		mmdp.ending_addr	= (unsigned long)parent->image_base +
-					  parent->image_size - 1;
-		parent_dp = &mmdp.header;
-		dp_len = sizeof(mmdp);
-	} else {
-		dp_len = device_path_length(parent_dp);
-	}
-
-	// Allocate some pool memory for device path protocol data
-	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
-			     2 * (dp_len + sizeof(struct efi_rel_offset_dev_path) +
-			          sizeof(struct efi_generic_dev_path)) +
-			     sizeof(struct efi_vendor_dev_path),
-			     (void **)&dp_alloc);
-	if (status != EFI_SUCCESS) {
-		error("Failed to allocate device path pool memory");
+	status = efi_handle_cmdline(image, &cmdline_ptr);
+	if (status != EFI_SUCCESS)
 		return status;
-	}
-
-	// Create a device path describing the compressed payload in this image
-	// <...parent_dp...>/Offset(<start>, <end>)
-	lf2_dp = memcpy(dp_alloc, parent_dp, dp_len);
-	dpp = (void *)((u8 *)lf2_dp + dp_len);
-	append_rel_offset_node(&dpp,
-			       (unsigned long)(_gzdata_start - efi_zboot_header),
-			       (unsigned long)(_gzdata_end - efi_zboot_header - 1));
-	append_end_node(&dpp);
 
-	// Create a device path describing the decompressed payload in this image
-	// <...parent_dp...>/Offset(<start>, <end>)/VenMedia(ZBOOT_MEDIA_GUID)
-	dp_len += sizeof(struct efi_rel_offset_dev_path);
-	li_dp = memcpy(dpp, lf2_dp, dp_len);
-	dpp = (void *)((u8 *)li_dp + dp_len);
-	append_ven_media_node(&dpp, &LINUX_EFI_ZBOOT_MEDIA_GUID);
-	append_end_node(&dpp);
-
-	zboot_handle = NULL;
-	zboot_load_file2.load_file = load_file;
-	status = efi_bs_call(install_multiple_protocol_interfaces,
-			     &zboot_handle,
-			     &EFI_DEVICE_PATH_PROTOCOL_GUID, lf2_dp,
-			     &EFI_LOAD_FILE2_PROTOCOL_GUID, &zboot_load_file2,
-			     NULL);
-	if (status != EFI_SUCCESS) {
-		error("Failed to install LoadFile2 protocol and device path");
-		goto free_dpalloc;
-	}
-
-	status = efi_bs_call(load_image, false, handle, li_dp, NULL, 0,
-			     &child_handle);
-	if (status != EFI_SUCCESS) {
-		error("Failed to load image");
-		goto uninstall_lf2;
-	}
+	efi_info("Decompressing Linux Kernel...\n");
+
+	// SizeOfImage from the compressee's PE/COFF header
+	alloc_size = round_up(get_unaligned_le32(_gzdata_end - 4),
+			      EFI_ALLOC_ALIGN);
+
+	// SizeOfHeaders and SizeOfCode from the compressee's PE/COFF header
+	code_size = get_unaligned_le32(_gzdata_end - 8) +
+		    get_unaligned_le32(_gzdata_end - 12);
+
+	 // If the architecture has a preferred address for the image,
+	 // try that first.
+	image_base = alloc_preferred_address(alloc_size);
+	if (image_base == ULONG_MAX) {
+		unsigned long min_kimg_align = efi_get_kimg_min_align();
+		u32 seed = U32_MAX;
+
+		if (!IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
+			// Setting the random seed to 0x0 is the same as
+			// allocating as low as possible
+			seed = 0;
+		} else if (efi_nokaslr) {
+			efi_info("KASLR disabled on kernel command line\n");
+		} else {
+			status = efi_get_random_bytes(sizeof(seed), (u8 *)&seed);
+			if (status == EFI_NOT_FOUND) {
+				efi_info("EFI_RNG_PROTOCOL unavailable\n");
+				efi_nokaslr = true;
+			} else if (status != EFI_SUCCESS) {
+				efi_err("efi_get_random_bytes() failed (0x%lx)\n",
+					status);
+				efi_nokaslr = true;
+			}
+		}
 
-	status = efi_bs_call(handle_protocol, child_handle,
-			     &LOADED_IMAGE_PROTOCOL_GUID, (void **)&child);
-	if (status != EFI_SUCCESS) {
-		error("Failed to locate child's loaded image protocol");
-		goto unload_image;
+		status = efi_random_alloc(alloc_size, min_kimg_align, &image_base,
+					  seed, EFI_LOADER_CODE);
+		if (status != EFI_SUCCESS) {
+			efi_err("Failed to allocate memory\n");
+			goto free_cmdline;
+		}
 	}
 
-	// Copy the kernel command line
-	child->load_options = parent->load_options;
-	child->load_options_size = parent->load_options_size;
-
-	status = efi_bs_call(start_image, child_handle, &exit_data_size,
-			     &exit_data);
-	if (status != EFI_SUCCESS) {
-		error("StartImage() returned with error:");
-		if (exit_data_size > 0)
-			efi_err("%ls\n", exit_data);
-
-		// If StartImage() returns EFI_SECURITY_VIOLATION, the image is
-		// not unloaded so we need to do it by hand.
-		if (status == EFI_SECURITY_VIOLATION)
-unload_image:
-			efi_bs_call(unload_image, child_handle);
+	// Decompress the payload into the newly allocated buffer.
+	ret = __decompress(_gzdata_start, compressed_size, NULL, NULL,
+			   (void *)image_base, alloc_size, NULL, error);
+	if (ret	< 0) {
+		error("Decompression failed");
+		status = EFI_DEVICE_ERROR;
+		goto free_image;
 	}
 
-uninstall_lf2:
-	efi_bs_call(uninstall_multiple_protocol_interfaces,
-		    zboot_handle,
-		    &EFI_DEVICE_PATH_PROTOCOL_GUID, lf2_dp,
-		    &EFI_LOAD_FILE2_PROTOCOL_GUID, &zboot_load_file2,
-		    NULL);
-
-free_dpalloc:
-	efi_bs_call(free_pool, dp_alloc);
+	efi_cache_sync_image(image_base, alloc_size, code_size);
 
-	efi_bs_call(exit, handle, status, exit_data_size, exit_data);
+	status = efi_stub_common(handle, image, image_base, cmdline_ptr);
 
-	// Free ExitData in case Exit() returned with a failure code,
-	// but return the original status code.
-	error("Exit() returned with failure code");
-	if (exit_data != NULL)
-		efi_bs_call(free_pool, exit_data);
+free_image:
+	efi_free(alloc_size, image_base);
+free_cmdline:
+	efi_bs_call(free_pool, cmdline_ptr);
 	return status;
 }
-- 
2.35.1

