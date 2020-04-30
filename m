Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32CA31C04BC
	for <lists+linux-efi@lfdr.de>; Thu, 30 Apr 2020 20:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgD3S24 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Apr 2020 14:28:56 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43380 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgD3S2z (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 30 Apr 2020 14:28:55 -0400
Received: by mail-qt1-f194.google.com with SMTP id z90so5839018qtd.10;
        Thu, 30 Apr 2020 11:28:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+AunM+gttCR7cksHTvK3qaFSOCJMLkiLvYgI+dytkHk=;
        b=lFaqDDI420UVLQjbwFBUii084FzFhNi/vf8ly+5xln6EoVWRsRB8YlhwL9+sjaA+eZ
         ZHc3mesbxdJqAbXp1332fhxQjzMoLc4JrqKFZrh3a0u76ISAnzqxD2zDv8OZqUAIZqTh
         yRo9nqe9XoEx6PDRXN7iQJo/Elv/t+ryScpGFIKz162pcIJJ6zD8eUpMGXFDdpspoM5U
         ROgfagZpSxvVPlQtdTp0oGjo8uGbpE/209Hfw+UCJs1XaOVnzsuRTUQ3TF5zRoiVtjXF
         jbm4qelpHFfQH1nlYDOBPzwIgCYIPVJq2o0VCaF/lz/o6RTPl5XLIoQzCJbhlq73kfwx
         QPKQ==
X-Gm-Message-State: AGi0PuZTgdZuxgm+yPpiWSImAuPIwQ4nKLtaQqSwLorYKePOc55WvNM1
        pYOqpX6iidVcimf4+mH79Qg=
X-Google-Smtp-Source: APiQypIrMJPVy8EqErDWUxLCHZaX6zOAd+tRV68aucu+vPq20FPgVDuAfY5oHZFmk1z3toAC14Wwng==
X-Received: by 2002:ac8:27b4:: with SMTP id w49mr5263808qtw.111.1588271332445;
        Thu, 30 Apr 2020 11:28:52 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v27sm449785qtb.35.2020.04.30.11.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 11:28:51 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/11] efi/libstub: Unify initrd loading across architectures
Date:   Thu, 30 Apr 2020 14:28:41 -0400
Message-Id: <20200430182843.2510180-10-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200430182843.2510180-1-nivedita@alum.mit.edu>
References: <20200429174120.1497212-1-nivedita@alum.mit.edu>
 <20200430182843.2510180-1-nivedita@alum.mit.edu>
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
2.26.2

