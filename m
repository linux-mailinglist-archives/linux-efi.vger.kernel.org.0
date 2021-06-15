Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C703A7A5C
	for <lists+linux-efi@lfdr.de>; Tue, 15 Jun 2021 11:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhFOJXT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 15 Jun 2021 05:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbhFOJXT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 15 Jun 2021 05:23:19 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EF0C061574
        for <linux-efi@vger.kernel.org>; Tue, 15 Jun 2021 02:21:14 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id o3so17497133wri.8
        for <linux-efi@vger.kernel.org>; Tue, 15 Jun 2021 02:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X//EfKNG/JXgT7eprwoHweO50xjUkMsHD1BIDnk0dog=;
        b=Ij6u9A+wEItGajtOHn2femzJ6DNgNpzhQn94iSykOTlnWRIWWhoFCPVGL0ysdfiS0i
         nzAQ6n5de/Lr5RIsaSuDO1g6aaRb9936gxJ1CUKWtMwG/a6Fh8MVvrpNDslX7sH2zQm0
         vQ3ndP1BA0qbL2ExhzTd3sw0OLHDvkfmWpsSpaySRrlOe+jYhzoGl1zwiZQLjWqssh0l
         ALX1cU5TtfHZTuOSTGc198MkDHnEXe1rrUdg7d9P69tDqovwmmaVjVNO6fAEI1lfl4f7
         AUTnVNgYPzfAtbrWXB7LtVbJIUaQIBno7hkCzRgwcUl85feHHndcyPNNgCQzNEpwH1Zz
         oRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X//EfKNG/JXgT7eprwoHweO50xjUkMsHD1BIDnk0dog=;
        b=Ien9rW16V89FTekKmiO9LNeFOpdTRTld41KmtLBrqLbov/wSZubcTuGJS+qqOSI8MD
         Y1Hr0exR9k3TndUDPJcs3xs+tp6Su1Fxo4VfLC273qgbl77DbdCmTjlo2BIY/hvJo6aj
         IzTckNc45bGnswQCl9/zS4yFePQuPSfGJnEfSkyiE+2XLXY4XEECGQjU7OvQmtA1u+tn
         R+OtrTl4YL5DXsvqauvyKIi1PTKOfUnWoYByWlVE0gxFyULlIvooTfJbqLzRrTqQd1c/
         pihVI3+ljkrqAq5hRnDFIHDCNAw4BUyUb/IYqxatD7XHW9r5iFkStMJuwpYdMCSuJRtF
         YYKw==
X-Gm-Message-State: AOAM530Zd0MteUV+g+C+sgBpLPDpp7MktQZRBwIk+mNHE1OFqnvQxXQ9
        /tSBd4iI1VrL83ZS2dOkJTcJInr44aU1Mg==
X-Google-Smtp-Source: ABdhPJxQ/rtC/a/mBrlSAtrhTowMPDuCyiRhiLyt/allaLMw9yEcTdl+DLmES7PSVM/YVaXFkZnTaw==
X-Received: by 2002:adf:ec43:: with SMTP id w3mr23291096wrn.270.1623748873577;
        Tue, 15 Jun 2021 02:21:13 -0700 (PDT)
Received: from apalos.home ([2a02:587:4680:7ec2:2e56:dcff:fe9a:8f06])
        by smtp.gmail.com with ESMTPSA id h15sm18280113wrq.88.2021.06.15.02.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 02:21:13 -0700 (PDT)
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     linux-efi@vger.kernel.org
Cc:     ardb@kernel.org, pjones@redhat.com, nivedita@alum.mit.edu,
        mjg59@google.com, daniel.kiper@oracle.com,
        James.Bottomley@hansenpartnership.com, leif@nuviainc.com,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 3/4] efi/libstub: consolidate initrd handling across architectures
Date:   Tue, 15 Jun 2021 12:21:04 +0300
Message-Id: <20210615092105.288331-4-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210615092105.288331-1-ilias.apalodimas@linaro.org>
References: <20210615092105.288331-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

Before adding TPM measurement of the initrd contents, refactor the
initrd handling slightly to be more self-contained and consistent.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 .../firmware/efi/libstub/efi-stub-helper.c    | 13 +++++++---
 drivers/firmware/efi/libstub/efi-stub.c       | 10 ++-----
 drivers/firmware/efi/libstub/efistub.h        |  1 -
 drivers/firmware/efi/libstub/x86-stub.c       | 26 +++++++------------
 4 files changed, 21 insertions(+), 29 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index aa8da0a49829..72a7e7c4d403 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -20,10 +20,10 @@
 
 bool efi_nochunk;
 bool efi_nokaslr = !IS_ENABLED(CONFIG_RANDOMIZE_BASE);
-bool efi_noinitrd;
 int efi_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
 bool efi_novamap;
 
+static bool efi_noinitrd;
 static bool efi_nosoftreserve;
 static bool efi_disable_pci_dma = IS_ENABLED(CONFIG_EFI_DISABLE_PCI_DMA);
 
@@ -643,8 +643,10 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
 {
 	efi_status_t status;
 
-	if (!load_addr || !load_size)
-		return EFI_INVALID_PARAMETER;
+	if (efi_noinitrd) {
+		*load_addr = *load_size = 0;
+		return EFI_SUCCESS;
+	}
 
 	status = efi_load_initrd_dev_path(load_addr, load_size, hard_limit);
 	if (status == EFI_SUCCESS) {
@@ -655,7 +657,10 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
 		if (status == EFI_SUCCESS && *load_size > 0)
 			efi_info("Loaded initrd from command line option\n");
 	}
-
+	if (status != EFI_SUCCESS) {
+		efi_err("Failed to load initrd: 0x%lx\n", status);
+		*load_addr = *load_size = 0;
+	}
 	return status;
 }
 
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 26e69788f27a..e87e7f1b1a33 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -134,7 +134,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	enum efi_secureboot_mode secure_boot;
 	struct screen_info *si;
 	efi_properties_table_t *prop_tbl;
-	unsigned long max_addr;
 
 	efi_system_table = sys_table_arg;
 
@@ -240,13 +239,8 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	if (!fdt_addr)
 		efi_info("Generating empty DTB\n");
 
-	if (!efi_noinitrd) {
-		max_addr = efi_get_max_initrd_addr(image_addr);
-		status = efi_load_initrd(image, &initrd_addr, &initrd_size,
-					 ULONG_MAX, max_addr);
-		if (status != EFI_SUCCESS)
-			efi_err("Failed to load initrd!\n");
-	}
+	efi_load_initrd(image, &initrd_addr, &initrd_size, ULONG_MAX,
+			efi_get_max_initrd_addr(image_addr));
 
 	efi_random_get_seed();
 
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index a2825c435158..edb77b0621ea 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -31,7 +31,6 @@
 
 extern bool efi_nochunk;
 extern bool efi_nokaslr;
-extern bool efi_noinitrd;
 extern int efi_loglevel;
 extern bool efi_novamap;
 
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index f14c4ff5839f..01ddd4502e28 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -673,6 +673,7 @@ unsigned long efi_main(efi_handle_t handle,
 	unsigned long bzimage_addr = (unsigned long)startup_32;
 	unsigned long buffer_start, buffer_end;
 	struct setup_header *hdr = &boot_params->hdr;
+	unsigned long addr, size;
 	efi_status_t status;
 
 	efi_system_table = sys_table_arg;
@@ -761,22 +762,15 @@ unsigned long efi_main(efi_handle_t handle,
 	 * arguments will be processed only if image is not NULL, which will be
 	 * the case only if we were loaded via the PE entry point.
 	 */
-	if (!efi_noinitrd) {
-		unsigned long addr, size;
-
-		status = efi_load_initrd(image, &addr, &size,
-					 hdr->initrd_addr_max, ULONG_MAX);
-
-		if (status != EFI_SUCCESS) {
-			efi_err("Failed to load initrd!\n");
-			goto fail;
-		}
-		if (size > 0) {
-			efi_set_u64_split(addr, &hdr->ramdisk_image,
-					  &boot_params->ext_ramdisk_image);
-			efi_set_u64_split(size, &hdr->ramdisk_size,
-					  &boot_params->ext_ramdisk_size);
-		}
+	status = efi_load_initrd(image, &addr, &size, hdr->initrd_addr_max,
+				 ULONG_MAX);
+	if (status != EFI_SUCCESS)
+		goto fail;
+	if (size > 0) {
+		efi_set_u64_split(addr, &hdr->ramdisk_image,
+				  &boot_params->ext_ramdisk_image);
+		efi_set_u64_split(size, &hdr->ramdisk_size,
+				  &boot_params->ext_ramdisk_size);
 	}
 
 	/*
-- 
2.31.0

