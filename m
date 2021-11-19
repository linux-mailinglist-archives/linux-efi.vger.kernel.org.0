Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2592456E73
	for <lists+linux-efi@lfdr.de>; Fri, 19 Nov 2021 12:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbhKSLvK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 19 Nov 2021 06:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhKSLvK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 19 Nov 2021 06:51:10 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D39C061574
        for <linux-efi@vger.kernel.org>; Fri, 19 Nov 2021 03:48:08 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id w29so17650939wra.12
        for <linux-efi@vger.kernel.org>; Fri, 19 Nov 2021 03:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ABfGpH73O9yZVHQSBed5M+fhfnMXynghFvTmjcQhZhg=;
        b=v5vrRjM+nhP1x7NZ9jqInHkUBabdkk5uvbyxdTQU6CKmlqw/0ncLgzPo42lvxde9/Q
         UVnBqHtNDTnwb3EVGdmYYvPM9lsJ3F+eVRcQyPzw0st/vvKU6atqcCVOwZYaTDJzHM93
         8XOogfjj9Fw1qxj7dVO2Asj3Kv1NJOp7O7DEvrh1PyGiw8qy3YB4wK+3Pg+uZT9qR7tK
         MkUxaKofqr/KXKz1N8GHzzdtmZrlTIJT7CmUm5z2FdHCeMD4xrWf1ghip/brCDpbcaC/
         BGI5/ESmUuPTE3PQ55qnMWLiwrnV9uYJfWmvMi1geQGEs/FGMcj1LUJ8yczwUa8Q7Tr+
         MQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ABfGpH73O9yZVHQSBed5M+fhfnMXynghFvTmjcQhZhg=;
        b=bazcQrpT2uSPSNu9aiRIWvRgZDE+bpGNSTUgan6MzUJS5tnJr3oBW5wjc3Zv+IjYCv
         RVswLKisZDq6rvOjbeTll5fgUF3GVYLBx7wdjMEZnjgulFilLcH+Vqu4/syrlICapc8C
         bL3BJneFN6Ut2rRovvni5MBsw0QL9ypc7F3Ap6KwkLdv1dqhW2wNPLRzjbcfkcUFck2x
         1vVpw1WfOBLBdQWER41kkBlRGcMCkfj5ZP6iVULHp2JrUzHiq6OOmDg5Y6QJoATE/jvl
         9L2OOBHIcf9D62yk+l5M4uqVynlQKuEo+SwqNbe0t6HBch1Vdivn8MasKkmYpgkP5RTu
         gCaQ==
X-Gm-Message-State: AOAM533YEgr4v50FHWeqLbE8UE7quIxhP7EmbXZk+1pV2CmMyx5PyQgv
        H5xGLV2j+nNq5XpgZJnlLHnm8N3tG/Y//w==
X-Google-Smtp-Source: ABdhPJz+0Nklr1k4oa3OYnu+Yu5yINXpcLknaSEr19XkvgyDDJnkRLJhCVMBW/U9vSQoYlgedWsTlg==
X-Received: by 2002:a5d:66cb:: with SMTP id k11mr6405940wrw.253.1637322487048;
        Fri, 19 Nov 2021 03:48:07 -0800 (PST)
Received: from apalos.home ([2a02:587:4627:18c0:2e56:dcff:fe9a:8f06])
        by smtp.gmail.com with ESMTPSA id c4sm2688039wrr.37.2021.11.19.03.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 03:48:06 -0800 (PST)
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     linux-efi@vger.kernel.org
Cc:     ardb@kernel.org, pjones@redhat.com, nivedita@alum.mit.edu,
        mjg59@google.com, daniel.kiper@oracle.com,
        James.Bottomley@hansenpartnership.com, leif@nuviainc.com,
        jroedel@suse.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 3/4 v3] efi/libstub: consolidate initrd handling across architectures
Date:   Fri, 19 Nov 2021 13:47:44 +0200
Message-Id: <20211119114745.1560453-4-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211119114745.1560453-1-ilias.apalodimas@linaro.org>
References: <20211119114745.1560453-1-ilias.apalodimas@linaro.org>
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
Changes since v1,2: 
- None
 .../firmware/efi/libstub/efi-stub-helper.c    | 13 +++++++---
 drivers/firmware/efi/libstub/efi-stub.c       | 10 ++-----
 drivers/firmware/efi/libstub/efistub.h        |  1 -
 drivers/firmware/efi/libstub/x86-stub.c       | 26 +++++++------------
 4 files changed, 21 insertions(+), 29 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index d489bdc645fe..01677181453d 100644
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
2.33.1

