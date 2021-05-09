Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38E937767D
	for <lists+linux-efi@lfdr.de>; Sun,  9 May 2021 13:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhEILqN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 9 May 2021 07:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhEILqN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 9 May 2021 07:46:13 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCC6C061573
        for <linux-efi@vger.kernel.org>; Sun,  9 May 2021 04:45:10 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id o26-20020a1c4d1a0000b0290146e1feccdaso8401939wmh.0
        for <linux-efi@vger.kernel.org>; Sun, 09 May 2021 04:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X//EfKNG/JXgT7eprwoHweO50xjUkMsHD1BIDnk0dog=;
        b=k+UMoVGJTcn6jeQGponxOiUb88fptFYg/B6C+VWWxTaZbgK3F5fOqjUsUumel0NbsN
         avoYmLOgT5vVmnGDJGqxRemUs78LijJTcXn573C7cCGI3+TjcgksumcAX3evPPyBZFlB
         Ml2Jdp7ymujCimLcdF3eznpsr9fFaAE9Z/A8eDFBEo82qSW475LIvJWeHOIken3EIfg3
         /ZJgUwY025MeRn/gxHmGNdPbRZ7kxqkPfVxV6HYAijYoeueo9D5hi4r09YCEKcr7iFV4
         KYbtQlRBZWWwCAo71kIWmAGbaWEtSRG7TQjHVAWSM1iR1ZFmCwxWa1x/gOQfj1VGv36D
         W+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X//EfKNG/JXgT7eprwoHweO50xjUkMsHD1BIDnk0dog=;
        b=fSm6dQmu9UIAu9d1ZD212T6KHj9sqzIMeUeyz9bpuTIXRnMOtE/rLNZF1xQqmqsjdG
         +vOJuG+6vAr02LRYl2+8hTBX+pxeuI7Hc9NJX+kPfRwlgq1F5WGX86sVtuHlR92r2a35
         WfBpX9pxEekXd8t+Rd+yNqf3txND3znF3RXHegWjIHg5dofv3ofME/NBSNJB9p+RPG+X
         TYmjvMlkSegnSbAXGr0tek4/1SaD8KYAy+clR02b5NSKoPYZAi+eX7UlVZmfxYV9FPs9
         auTaDih2sxAnocBi2KgIp7nMierZzEmXlD/AC67teyutXOHR6/z3beCjpnDt2TMMDXgw
         N3MQ==
X-Gm-Message-State: AOAM531D3e9riwgi6+JgoZz6jUQrolg5EOb70+8k34lS0xZ/yANvnx57
        Abev3nYSXGXTn7i3LHDZBpiAKoC5hXLAbQ==
X-Google-Smtp-Source: ABdhPJzMX4W7GoN+F/h5bRPjw1rmtw7kRUxHBL3v81KQkRLSZfiqtBPdnlIvOksJiS8KDgwHcF+LTA==
X-Received: by 2002:a05:600c:4642:: with SMTP id n2mr20504325wmo.103.1620560708960;
        Sun, 09 May 2021 04:45:08 -0700 (PDT)
Received: from apalos.home ([2a02:587:466e:1389:2e56:dcff:fe9a:8f06])
        by smtp.gmail.com with ESMTPSA id c8sm17650244wrx.4.2021.05.09.04.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 04:45:08 -0700 (PDT)
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     linux-efi@vger.kernel.org
Cc:     ardb@kernel.org, pjones@redhat.com, nivedita@alum.mit.edu,
        mjg59@google.com, daniel.kiper@oracle.com,
        James.Bottomley@hansenpartnership.com, leif@nuviainc.com,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [RFC PATCH 3/4] efi/libstub: consolidate initrd handling across architectures
Date:   Sun,  9 May 2021 14:44:53 +0300
Message-Id: <20210509114454.185583-4-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210509114454.185583-1-ilias.apalodimas@linaro.org>
References: <20210509114454.185583-1-ilias.apalodimas@linaro.org>
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

