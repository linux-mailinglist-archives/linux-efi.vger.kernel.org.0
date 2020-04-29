Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530181BE577
	for <lists+linux-efi@lfdr.de>; Wed, 29 Apr 2020 19:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgD2Rla (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Apr 2020 13:41:30 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44266 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbgD2Rl3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Apr 2020 13:41:29 -0400
Received: by mail-qk1-f195.google.com with SMTP id h124so2846984qke.11;
        Wed, 29 Apr 2020 10:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=17khpAR6nkDRxD5BLjB1TLshrcrm8CQXqW4S+007WC0=;
        b=e4hkMRX36wCSBXDbOwrAHlQ0+3+UzKDaDoQlDEal0TDtXSL2ktd/gwMf2tOa+BKvq2
         AnNrtXk1r3uDJeivjypEbnVKF6jDrt8fjskJQaa9MjkqBeauKjFT5GRFrK4ySW3BPKLB
         BXXTOzvTnMqU7WCcm8ilIm/gozPrOo7kyD0PS9aug3UZqqv4x7Ftk8UXfhNH+1v09Aa7
         +8cVI42w1P/wdm32OaV4De1xv8Da8Sqiy3rS2BqFSuhNeyQnEcE26mk6U+QvY4oU2y16
         tcyLfoQAWKJQTkightZZfLavrwCgt/qkk8Me4e/O69Km5JlW9m3KQ+D2JANNW93Yrcft
         Rg8Q==
X-Gm-Message-State: AGi0PubnZPMcdCMsFG8pLorJlRuQ7GjWvI4EuqTev5Db+TTxDwGALa+z
        Eb0JVMhUcKvL2fQhaPyNejFXJtpE0pY=
X-Google-Smtp-Source: APiQypId6FRdVQ5rgZXwMpyyulkPIOzJTkZLhESAX7kwc7wuAwALRTKjXYLTR2upv59PaLhOzDs7yw==
X-Received: by 2002:a37:ad0d:: with SMTP id f13mr13462804qkm.7.1588182087926;
        Wed, 29 Apr 2020 10:41:27 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id z1sm14766448qkz.3.2020.04.29.10.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 10:41:27 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] efi/libstub: Unify initrd loading across architectures
Date:   Wed, 29 Apr 2020 13:41:17 -0400
Message-Id: <20200429174120.1497212-9-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200429174120.1497212-1-nivedita@alum.mit.edu>
References: <20200429174120.1497212-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Factor out the initrd loading into a common function that can be called
both from the generic efi-stub.c and the x86-specific x86-stub.c.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 .../firmware/efi/libstub/efi-stub-helper.c    | 46 +++++++++++++++++--
 drivers/firmware/efi/libstub/efi-stub.c       | 12 +----
 drivers/firmware/efi/libstub/efistub.h        | 21 ++-------
 drivers/firmware/efi/libstub/x86-stub.c       | 13 +-----
 4 files changed, 52 insertions(+), 40 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 1c92ac231f94..2c0c2c34b4cc 100644
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
+		pr_efi("Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path\n");
+	} else if (status == EFI_NOT_FOUND) {
+		status = efi_load_initrd_cmdline(image, load_addr, load_size,
+						 soft_limit, hard_limit);
+		if (status == EFI_SUCCESS && *load_size > 0)
+			pr_efi("Loaded initrd from command line option\n");
+	}
+
+	return status;
+}
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index ee225b323687..d8f24f5c91bd 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -265,16 +265,8 @@ efi_status_t efi_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg)
 
 	if (!efi_noinitrd) {
 		max_addr = efi_get_max_initrd_addr(dram_base, image_addr);
-		status = efi_load_initrd_dev_path(&initrd_addr, &initrd_size,
-						  max_addr);
-		if (status == EFI_SUCCESS) {
-			pr_efi("Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path\n");
-		} else if (status == EFI_NOT_FOUND) {
-			status = efi_load_initrd(image, &initrd_addr, &initrd_size,
-						 ULONG_MAX, max_addr);
-			if (status == EFI_SUCCESS && initrd_size > 0)
-				pr_efi("Loaded initrd from command line option\n");
-		}
+		status = efi_load_initrd(image, &initrd_addr, &initrd_size,
+					 ULONG_MAX, max_addr);
 		if (status != EFI_SUCCESS)
 			pr_efi_err("Failed to load initrd!\n");
 	}
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index e8aa70ba08d5..dfdd7954bf58 100644
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
index ee4241df4f29..1d3f94f1dafa 100644
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
 			pr_efi_err("Failed to load initrd!\n");
-- 
2.26.2

