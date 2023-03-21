Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B3A6C36CA
	for <lists+linux-efi@lfdr.de>; Tue, 21 Mar 2023 17:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjCUQSe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 21 Mar 2023 12:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjCUQSe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 21 Mar 2023 12:18:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6A94EE7
        for <linux-efi@vger.kernel.org>; Tue, 21 Mar 2023 09:18:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAB4861D1E
        for <linux-efi@vger.kernel.org>; Tue, 21 Mar 2023 16:18:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C326C4339B;
        Tue, 21 Mar 2023 16:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679415492;
        bh=dbtmv3DkDXA5APX5F+bxL0IQv0w/YWAqvuqPBppE7xY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WpjDV6Oa/Myw0nTLXggApJSUfMA9TmYOGUvIuQ4Tgta8H8FPakpEv4kaJPl/1VY2Y
         evDW5cT9vmnQie0KgMhzVNqyoy4DrTI2vUFIogsqx2xdJsHg/q1MBUoFbw3xx8MIhf
         H+aBhabW0wQSg4Dz2zbmVO7uq02lWljljWg/qmLk/ohu/MFFVjPSoVUnzvKYjdSTxX
         +FII3/Um3K8BVdZJd7BZODe0tcuM/BqgeGH6PlK4Zlw40R6B/vWFbyloGXvcDom5DH
         DYoh7pZV/zLnYQfFmfOLDhO89jCGTOYICnfy968tf9dWQ2kVDlsvwNHUQVUF0NiW6T
         nAHrMksr6J8Pw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Michael Brown <mcb30@ipxe.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2 3/3] efi/libstub: Look for initrd LoadFile2 protocol on image handle
Date:   Tue, 21 Mar 2023 17:18:03 +0100
Message-Id: <20230321161803.3289140-4-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230321161803.3289140-1-ardb@kernel.org>
References: <20230321161803.3289140-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6729; i=ardb@kernel.org; h=from:subject; bh=dbtmv3DkDXA5APX5F+bxL0IQv0w/YWAqvuqPBppE7xY=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUXyxu6rslbLewQv1L/QM509ifuN3oKSX7W8VmqqWz7f0 LtwYHlURykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjI9giGv+JXN8jWXFub1hGo m1z/iWWiOx/Po32nr6vHfYyU+jnnywyG/66hWdOdynkrlm+3y7Dp/pHHcfSZhfmDqD2Vgs8uZRV HsQEA
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

The use of a global singleton device path for describing the initrd to
be loaded by the kernel implies that only a single handle can exist that
carries the initrd LoadFile2 protocol implementation.

This avoids the need on the part of the EFI stub to reason about which
initrd is the preferred one when several are being provided - we already
have initrd loading via the setup header on x86 and via DT on other
architectures, in addition to the initrd= command line option, and so
having a single loader provided initrd that supersedes all of them was
deemed preferable over having multiple sources.

However, this means that intermediate loader stages cannot simply
install the LoadFile2 initrd device path, and will need to check for
failures and deal with them. It also means that such stages will have to
reason about whether or not the subsequent stage being loaded is the
final one, or whether it may attempt to install the initrd device path
itself.

We can solve this by associating the initrd LoadFile2 protocol with the
loaded image instead of with a global singleton device path. That way,
each stage can associate any initrd it provides with the image that it
is loading.

Tested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 53 ++++++++++++--------
 include/linux/efi.h                            |  1 +
 include/linux/pe.h                             |  2 +-
 3 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index d1026c6a544058b4..7ca993fd0e331637 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -482,37 +482,50 @@ static const struct {
 };
 
 /**
- * efi_load_initrd_dev_path() - load the initrd from the Linux initrd device path
- * @initrd:	pointer of struct to store the address where the initrd was loaded
- *		and the size of the loaded initrd
- * @max:	upper limit for the initrd memory allocation
+ * efi_load_initrd_lf2() - load the initrd either from the LoadFile2 initrd
+ *			   loading protocol installed on the loaded image
+ *			   handle, or from the Linux initrd device path
+ * @image_handle: EFI handle of the loaded image
+ * @initrd:	  pointer of struct to store the address where the initrd was
+ *                loaded and the size of the loaded initrd
+ * @max:	  upper limit for the initrd memory allocation
  *
  * Return:
- * * %EFI_SUCCESS if the initrd was loaded successfully, in which
- *   case @load_addr and @load_size are assigned accordingly
- * * %EFI_NOT_FOUND if no LoadFile2 protocol exists on the initrd device path
+ * * %EFI_SUCCESS if the initrd was loaded successfully, in which case the base
+ *   and size members of @initrd are assigned accordingly
+ * * %EFI_NOT_FOUND if no LoadFile2 protocol exists on the loaded image handle
+ *   or on the initrd device path
  * * %EFI_OUT_OF_RESOURCES if memory allocation failed
  * * %EFI_LOAD_ERROR in all other cases
  */
 static
-efi_status_t efi_load_initrd_dev_path(struct linux_efi_initrd *initrd,
-				      unsigned long max)
+efi_status_t efi_load_initrd_lf2(efi_handle_t image_handle,
+				 struct linux_efi_initrd *initrd,
+				 unsigned long max)
 {
 	efi_guid_t lf2_proto_guid = EFI_LOAD_FILE2_PROTOCOL_GUID;
-	const efi_device_path_protocol_t *dp;
+	efi_guid_t initrd_lf2_proto_guid = LINUX_EFI_INITRD_LF2_PROTOCOL_GUID;
+	const efi_device_path_protocol_t *dp = &initrd_dev_path.end;
 	efi_load_file2_protocol_t *lf2;
 	efi_handle_t handle;
 	efi_status_t status;
 
-	dp = &initrd_dev_path.vendor.header;
-	status = efi_bs_call(locate_device_path, &lf2_proto_guid, &dp, &handle);
-	if (status != EFI_SUCCESS)
-		return status;
-
-	status = efi_bs_call(handle_protocol, handle, &lf2_proto_guid,
+	/* first look for a initrd loading protocol specific to this image */
+	status = efi_bs_call(handle_protocol, image_handle, &initrd_lf2_proto_guid,
 			     (void **)&lf2);
-	if (status != EFI_SUCCESS)
-		return status;
+	if (status != EFI_SUCCESS) {
+		/* look for the global singleton initrd loading protocol */
+		dp = &initrd_dev_path.vendor.header;
+		status = efi_bs_call(locate_device_path, &lf2_proto_guid, &dp,
+				     &handle);
+		if (status != EFI_SUCCESS)
+			return status;
+
+		status = efi_bs_call(handle_protocol, handle, &lf2_proto_guid,
+				     (void **)&lf2);
+		if (status != EFI_SUCCESS)
+			return status;
+	}
 
 	initrd->size = 0;
 	status = efi_call_proto(lf2, load_file, dp, false, &initrd->size, NULL);
@@ -567,9 +580,9 @@ efi_status_t efi_load_initrd(efi_handle_t handle,
 	if (!IS_ENABLED(CONFIG_BLK_DEV_INITRD) || efi_noinitrd)
 		return EFI_SUCCESS;
 
-	status = efi_load_initrd_dev_path(&initrd, hard_limit);
+	status = efi_load_initrd_lf2(handle, &initrd, hard_limit);
 	if (status == EFI_SUCCESS) {
-		efi_info("Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path\n");
+		efi_info("Loaded initrd using LoadFile2 protocol\n");
 		if (initrd.size > 0 &&
 		    efi_measure_tagged_event(initrd.base, initrd.size,
 					     EFISTUB_EVT_INITRD) == EFI_SUCCESS)
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 04a733f0ba956211..08a1518de0fb4921 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -417,6 +417,7 @@ void efi_native_runtime_setup(void);
 #define LINUX_EFI_MOK_VARIABLE_TABLE_GUID	EFI_GUID(0xc451ed2b, 0x9694, 0x45d3,  0xba, 0xba, 0xed, 0x9f, 0x89, 0x88, 0xa3, 0x89)
 #define LINUX_EFI_COCO_SECRET_AREA_GUID		EFI_GUID(0xadf956ad, 0xe98c, 0x484c,  0xae, 0x11, 0xb5, 0x1c, 0x7d, 0x33, 0x64, 0x47)
 #define LINUX_EFI_BOOT_MEMMAP_GUID		EFI_GUID(0x800f683f, 0xd08b, 0x423a,  0xa2, 0x93, 0x96, 0x5c, 0x3c, 0x6f, 0xe2, 0xb4)
+#define LINUX_EFI_INITRD_LF2_PROTOCOL_GUID	EFI_GUID(0xf9e3378e, 0xb3b1, 0x423a,  0xbd, 0x9a, 0x2d, 0x08, 0x60, 0x28, 0x7f, 0x72)
 
 #define RISCV_EFI_BOOT_PROTOCOL_GUID		EFI_GUID(0xccd15fec, 0x6f73, 0x4eec,  0x83, 0x95, 0x3e, 0x69, 0xe4, 0xb9, 0x40, 0xbf)
 
diff --git a/include/linux/pe.h b/include/linux/pe.h
index 6ffabf1e6d039e67..934e3a15ea7ddc07 100644
--- a/include/linux/pe.h
+++ b/include/linux/pe.h
@@ -29,7 +29,7 @@
  * handover_offset and xloadflags fields in the bootparams structure.
  */
 #define LINUX_EFISTUB_MAJOR_VERSION		0x1
-#define LINUX_EFISTUB_MINOR_VERSION		0x1
+#define LINUX_EFISTUB_MINOR_VERSION		0x2
 
 /*
  * LINUX_PE_MAGIC appears at offset 0x38 into the MS-DOS header of EFI bootable
-- 
2.39.2

