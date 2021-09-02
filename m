Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 874293FEA5F
	for <lists+linux-efi@lfdr.de>; Thu,  2 Sep 2021 10:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243834AbhIBIGL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Sep 2021 04:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243881AbhIBIFi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Sep 2021 04:05:38 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBDBC061757
        for <linux-efi@vger.kernel.org>; Thu,  2 Sep 2021 01:04:40 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id h9so2354021ejs.4
        for <linux-efi@vger.kernel.org>; Thu, 02 Sep 2021 01:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=18nH28vGnxJ4QKA30bgcGFqPpjpwglz++tL/h7U6UkM=;
        b=oLHM9Sc7pSG710u3govuiUTVZb+WGiFvUIpnKaLa8whEVq9oU4UXYh4FdAwBsLmeJ8
         LkjPsbG8GvcyFF5RR6G7h4sZFU2/H3eatl2NgEYS8z8pj1GPdEIw2bKmlyP5H44nYaE+
         JdadjWbGb40gsQCeHmRR9Pe9NeHcep8zU90TnaaAmoO+gyRHRo9K8N/O+c77iYEbMAyH
         /E5DnBuSuzp3cPk1LkI9hyxtAFeL2tbSMznqDvc27Q55reKIQUby2Jf+PyxlJyXvtvtf
         StuEhKY6xcD2Gia/kBvOZUvkNzBHd3Q2UJX+Ug0IIuFKR4cxeIOesVPqIoMox9Wj1Tuk
         z9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=18nH28vGnxJ4QKA30bgcGFqPpjpwglz++tL/h7U6UkM=;
        b=WbBZ2nSu9Jb3mFwJXinwCfiWJ01SQID4Y8jO30rM/t8Ltvo5dpU4JsHj8EEVjg7Xkz
         kcU0rJ6g8yfHTuvqKASeNjLWf4B6nEZTUXCrnnRb8gn9mtARPvpGkQVEhUBsqDjIfwbo
         0PuWbtIXGjl4j4QTPNZ5IeDhZefAiGCvyaLNkoh7pO2B0wZ2dmce+NkZSOSSwdYPCOj5
         J6AoHOJu92skGx7Viz74OSjwyy09P3Mfh5uBLKbk9ZD5tq7SQtOrUrU3bAOaHx3Pv4Kc
         XjyZGk4i7KqrMieM5+B4i+cCBvMTJmyPH0hCC7Cef89RqLFQz73J43ncIisedQbPLviM
         Hlcw==
X-Gm-Message-State: AOAM530mLGeGQDi8QLU7py9EWfAX+qNpilmV4GJxOB4S3/u4nhTIRN8F
        mPUo/NADcJQRJQDJ9au2/SWAOoaMIasAVQ==
X-Google-Smtp-Source: ABdhPJwhDk0ivz3IxihAVzhn1+jNgL67jYHwqouVpjY33qelogc9HyAtTloAaDi+HbRPtP7q6fu0DA==
X-Received: by 2002:a17:907:923:: with SMTP id au3mr2409454ejc.482.1630569879297;
        Thu, 02 Sep 2021 01:04:39 -0700 (PDT)
Received: from localhost.localdomain (ppp-94-66-220-137.home.otenet.gr. [94.66.220.137])
        by smtp.gmail.com with ESMTPSA id m12sm537105ejd.21.2021.09.02.01.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 01:04:39 -0700 (PDT)
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     linux-efi@vger.kernel.org, ardb@kernel.org,
        James.Bottomley@hansenpartnership.com
Cc:     pjones@redhat.com, nivedita@alum.mit.edu, mjg59@google.com,
        daniel.kiper@oracle.com, leif@nuviainc.com,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 3/4 v2] efi/libstub: consolidate initrd handling across architectures
Date:   Thu,  2 Sep 2021 11:04:15 +0300
Message-Id: <20210902080416.5461-4-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210902080416.5461-1-ilias.apalodimas@linaro.org>
References: <20210902080416.5461-1-ilias.apalodimas@linaro.org>
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
2.32.0.rc0

