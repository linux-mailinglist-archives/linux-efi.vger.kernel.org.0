Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE7E1CB68D
	for <lists+linux-efi@lfdr.de>; Fri,  8 May 2020 20:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgEHSCp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 May 2020 14:02:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727969AbgEHSCo (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 May 2020 14:02:44 -0400
Received: from e123331-lin.nice.arm.com (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 630172496A;
        Fri,  8 May 2020 18:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588960963;
        bh=9GQqudEWUBCOMWUK/Yrr60j8wk04aNZCx5h1b7U9Y7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ch0MFLgA1iK/GHC1Xu4Lo38wKVKEt79bcYLypl2JsctGSCUrgOBViXAgzIVKeGxUU
         8gsCB6MqRHltjOdTTZYP4lu3lViaDVmGsYKpdw9gUaLw42UgRkwLwRCML/L54OAuA5
         YY/2nI+cXR4wyy2/Wki7qz8MAY8MGbSVCocuXAqU=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Guenter Roeck <linux@roeck-us.net>,
        Joe Perches <joe@perches.com>
Subject: [PATCH 09/15] efi/libstub: Unify initrd loading across architectures
Date:   Fri,  8 May 2020 20:01:51 +0200
Message-Id: <20200508180157.1816-10-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508180157.1816-1-ardb@kernel.org>
References: <20200508180157.1816-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

Factor out the initrd loading into a common function that can be called
both from the generic efi-stub.c and the x86-specific x86-stub.c.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://lore.kernel.org/r/20200430182843.2510180-10-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 .../firmware/efi/libstub/efi-stub-helper.c    | 46 +++++++++++++++++--
 drivers/firmware/efi/libstub/efi-stub.c       | 12 +----
 drivers/firmware/efi/libstub/efistub.h        | 21 ++-------
 drivers/firmware/efi/libstub/x86-stub.c       | 13 +-----
 4 files changed, 52 insertions(+), 40 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 1c92ac231f94..7aac89e928ec 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -331,6 +331,7 @@ static const struct {
  *		%EFI_OUT_OF_RESOURCES if memory allocation failed
  *		%EFI_LOAD_ERROR in all other cases
  */
+static
 efi_status_t efi_load_initrd_dev_path(unsigned long *load_addr,
 				      unsigned long *load_size,
 				      unsigned long max)
@@ -343,9 +344,6 @@ efi_status_t efi_load_initrd_dev_path(unsigned long *load_addr,
 	efi_handle_t handle;
 	efi_status_t status;
 
-	if (!load_addr || !load_size)
-		return EFI_INVALID_PARAMETER;
-
 	dp = (efi_device_path_protocol_t *)&initrd_dev_path;
 	status = efi_bs_call(locate_device_path, &lf2_proto_guid, &dp, &handle);
 	if (status != EFI_SUCCESS)
@@ -375,3 +373,45 @@ efi_status_t efi_load_initrd_dev_path(unsigned long *load_addr,
 	*load_size = initrd_size;
 	return EFI_SUCCESS;
 }
+
+static
+efi_status_t efi_load_initrd_cmdline(efi_loaded_image_t *image,
+				     unsigned long *load_addr,
+				     unsigned long *load_size,
+				     unsigned long soft_limit,
+				     unsigned long hard_limit)
+{
+	if (!IS_ENABLED(CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER) ||
+	    (IS_ENABLED(CONFIG_X86) && (!efi_is_native() || image == NULL))) {
+		*load_addr = *load_size = 0;
+		return EFI_SUCCESS;
+	}
+
+	return handle_cmdline_files(image, L"initrd=", sizeof(L"initrd=") - 2,
+				    soft_limit, hard_limit,
+				    load_addr, load_size);
+}
+
+efi_status_t efi_load_initrd(efi_loaded_image_t *image,
+			     unsigned long *load_addr,
+			     unsigned long *load_size,
+			     unsigned long soft_limit,
+			     unsigned long hard_limit)
+{
+	efi_status_t status;
+
+	if (!load_addr || !load_size)
+		return EFI_INVALID_PARAMETER;
+
+	status = efi_load_initrd_dev_path(load_addr, load_size, hard_limit);
+	if (status == EFI_SUCCESS) {
+		efi_info("Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path\n");
+	} else if (status == EFI_NOT_FOUND) {
+		status = efi_load_initrd_cmdline(image, load_addr, load_size,
+						 soft_limit, hard_limit);
+		if (status == EFI_SUCCESS && *load_size > 0)
+			efi_info("Loaded initrd from command line option\n");
+	}
+
+	return status;
+}
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index cb02e8bb6b44..63541c2440ef 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -265,16 +265,8 @@ efi_status_t efi_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg)
 
 	if (!efi_noinitrd) {
 		max_addr = efi_get_max_initrd_addr(dram_base, image_addr);
-		status = efi_load_initrd_dev_path(&initrd_addr, &initrd_size,
-						  max_addr);
-		if (status == EFI_SUCCESS) {
-			efi_info("Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path\n");
-		} else if (status == EFI_NOT_FOUND) {
-			status = efi_load_initrd(image, &initrd_addr, &initrd_size,
-						 ULONG_MAX, max_addr);
-			if (status == EFI_SUCCESS && initrd_size > 0)
-				efi_info("Loaded initrd from command line option\n");
-		}
+		status = efi_load_initrd(image, &initrd_addr, &initrd_size,
+					 ULONG_MAX, max_addr);
 		if (status != EFI_SUCCESS)
 			efi_err("Failed to load initrd!\n");
 	}
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 8c905a1be1b4..874233cf8820 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -677,21 +677,10 @@ static inline efi_status_t efi_load_dtb(efi_loaded_image_t *image,
 				    ULONG_MAX, ULONG_MAX, load_addr, load_size);
 }
 
-static inline efi_status_t efi_load_initrd(efi_loaded_image_t *image,
-					   unsigned long *load_addr,
-					   unsigned long *load_size,
-					   unsigned long soft_limit,
-					   unsigned long hard_limit)
-{
-	if (!IS_ENABLED(CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER))
-		return EFI_SUCCESS;
-
-	return handle_cmdline_files(image, L"initrd=", sizeof(L"initrd=") - 2,
-				    soft_limit, hard_limit, load_addr, load_size);
-}
-
-efi_status_t efi_load_initrd_dev_path(unsigned long *load_addr,
-				      unsigned long *load_size,
-				      unsigned long max);
+efi_status_t efi_load_initrd(efi_loaded_image_t *image,
+			     unsigned long *load_addr,
+			     unsigned long *load_size,
+			     unsigned long soft_limit,
+			     unsigned long hard_limit);
 
 #endif
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index defeb6035109..f1a134596b53 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -755,17 +755,8 @@ unsigned long efi_main(efi_handle_t handle,
 	if (!efi_noinitrd) {
 		unsigned long addr, size;
 
-		status = efi_load_initrd_dev_path(&addr, &size, ULONG_MAX);
-		if (status == EFI_NOT_FOUND) {
-			if (efi_is_native() && image != NULL) {
-				status = efi_load_initrd(image, &addr, &size,
-							 hdr->initrd_addr_max,
-							 ULONG_MAX);
-			} else {
-				addr = size = 0;
-				status = EFI_SUCCESS;
-			}
-		}
+		status = efi_load_initrd(image, &addr, &size,
+					 hdr->initrd_addr_max, ULONG_MAX);
 
 		if (status != EFI_SUCCESS) {
 			efi_err("Failed to load initrd!\n");
-- 
2.17.1

