Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF69160442
	for <lists+linux-efi@lfdr.de>; Sun, 16 Feb 2020 15:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgBPOMA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 16 Feb 2020 09:12:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:36646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbgBPOMA (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 16 Feb 2020 09:12:00 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1D912086A;
        Sun, 16 Feb 2020 14:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581862319;
        bh=cuH/oieqCmUEjv1cGx+dzIaI0rTABpdFIA+RFrLgqko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gHpSxYqFkfhSXH2MQvkxOwYX4Zlltt1b8gqe4i4aJcFVlW8LQkWAT37MIXYxtEds0
         JzA7eeXosJ+qF1XHKGSDX9uuuRDfC/h6Fqi83M1+v+MvBIbvFYcDk7s34WipythlqH
         2QaqgRAh3u/xtStPSxBlJ+Ls/+a+et4z1NgMxOiE=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        lersek@redhat.com, leif@nuviainc.com, pjones@redhat.com,
        mjg59@google.com, agraf@csgraf.de, ilias.apalodimas@linaro.org,
        xypron.glpk@gmx.de, daniel.kiper@oracle.com, nivedita@alum.mit.edu,
        James.Bottomley@hansenpartnership.com, lukas@wunner.de
Subject: [PATCH v2 3/3] efi/libstub: Take noinitrd cmdline argument into account for devpath initrd
Date:   Sun, 16 Feb 2020 15:11:04 +0100
Message-Id: <20200216141104.21477-4-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200216141104.21477-1-ardb@kernel.org>
References: <20200216141104.21477-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

One of the advantages of using what basically amounts to a callback
interface into the bootloader for loading the initrd is that it provides
a natural place for the bootloader or firmware to measure the initrd
contents while they are being passed to the kernel.

Unfortunately, this is not a guarantee that the initrd will in fact be
loaded and its /init invoked by the kernel, since the command line may
contain the 'noinitrd' option, in which case the initrd is ignored, but
this will not be reflected in the PCR that covers the initrd measurement.

This could be addressed by measuring the command line as well, and
including that PCR in the attestation policy, but this locks down the
command line completely, which may be too restrictive.

So let's take the noinitrd argument into account in the stub, too. This
forces any PCR that covers the initrd to assume a different value when
noinitrd is passed, allowing an attestation policy to disregard the
command line if there is no need to take its measurement into account
for other reasons.

As Peter points out, this would still require the agent that takes the
measurements to measure a separator event into the PCR in question at
ExitBootServices() time, to prevent replay attacks using the known
measurement from the TPM log.

Cc: Peter Jones <pjones@redhat.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/arm-stub.c        | 25 +++++-----
 drivers/firmware/efi/libstub/efi-stub-helper.c |  7 +++
 drivers/firmware/efi/libstub/efistub.h         |  1 +
 drivers/firmware/efi/libstub/x86-stub.c        | 52 +++++++++++---------
 4 files changed, 51 insertions(+), 34 deletions(-)

diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index 4bae620b95b9..56e475c1aa55 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -259,18 +259,21 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table_arg,
 	if (!fdt_addr)
 		pr_efi("Generating empty DTB\n");
 
-	max_addr = efi_get_max_initrd_addr(dram_base, *image_addr);
-	status = efi_load_initrd_dev_path(&initrd_addr, &initrd_size, max_addr);
-	if (status == EFI_SUCCESS) {
-		pr_efi("Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path\n");
-	} else if (status == EFI_NOT_FOUND) {
-		status = efi_load_initrd(image, &initrd_addr, &initrd_size,
-					 ULONG_MAX, max_addr);
-		if (status == EFI_SUCCESS)
-			pr_efi("Loaded initrd from command line option\n");
+	if (!noinitrd()) {
+		max_addr = efi_get_max_initrd_addr(dram_base, *image_addr);
+		status = efi_load_initrd_dev_path(&initrd_addr, &initrd_size,
+						  max_addr);
+		if (status == EFI_SUCCESS) {
+			pr_efi("Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path\n");
+		} else if (status == EFI_NOT_FOUND) {
+			status = efi_load_initrd(image, &initrd_addr, &initrd_size,
+						 ULONG_MAX, max_addr);
+			if (status == EFI_SUCCESS)
+				pr_efi("Loaded initrd from command line option\n");
+		}
+		if (status != EFI_SUCCESS)
+			pr_efi_err("Failed to load initrd!\n");
 	}
-	if (status != EFI_SUCCESS)
-		pr_efi_err("Failed to load initrd!\n");
 
 	efi_random_get_seed();
 
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index e37afe2c752e..c5d04147ed17 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -14,6 +14,7 @@
 
 static bool __efistub_global efi_nochunk;
 static bool __efistub_global efi_nokaslr;
+static bool __efistub_global efi_noinitrd;
 static bool __efistub_global efi_quiet;
 static bool __efistub_global efi_novamap;
 static bool __efistub_global efi_nosoftreserve;
@@ -28,6 +29,10 @@ bool __pure nokaslr(void)
 {
 	return efi_nokaslr;
 }
+bool __pure noinitrd(void)
+{
+	return efi_noinitrd;
+}
 bool __pure is_quiet(void)
 {
 	return efi_quiet;
@@ -87,6 +92,8 @@ efi_status_t efi_parse_options(char const *cmdline)
 			efi_nokaslr = true;
 		} else if (!strcmp(param, "quiet")) {
 			efi_quiet = true;
+		} else if (!strcmp(param, "noinitrd")) {
+			efi_noinitrd = true;
 		} else if (!strcmp(param, "efi") && val) {
 			efi_nochunk = parse_option_str(val, "nochunk");
 			efi_novamap = parse_option_str(val, "novamap");
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index b58cb2c4474e..2e5e79edb4d7 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -33,6 +33,7 @@
 
 extern bool __pure nochunk(void);
 extern bool __pure nokaslr(void);
+extern bool __pure noinitrd(void);
 extern bool __pure is_quiet(void);
 extern bool __pure novamap(void);
 
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 16bf4ed21f1f..7d4866471f86 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -421,15 +421,18 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	if (status != EFI_SUCCESS)
 		goto fail2;
 
-	status = efi_load_initrd(image, &ramdisk_addr, &ramdisk_size,
-				 hdr->initrd_addr_max,
-				 above4g ? ULONG_MAX : hdr->initrd_addr_max);
-	if (status != EFI_SUCCESS)
-		goto fail2;
-	hdr->ramdisk_image = ramdisk_addr & 0xffffffff;
-	hdr->ramdisk_size  = ramdisk_size & 0xffffffff;
-	boot_params->ext_ramdisk_image = (u64)ramdisk_addr >> 32;
-	boot_params->ext_ramdisk_size  = (u64)ramdisk_size >> 32;
+	if (!noinitrd()) {
+		status = efi_load_initrd(image, &ramdisk_addr, &ramdisk_size,
+					 hdr->initrd_addr_max,
+					 above4g ? ULONG_MAX
+						 : hdr->initrd_addr_max);
+		if (status != EFI_SUCCESS)
+			goto fail2;
+		hdr->ramdisk_image = ramdisk_addr & 0xffffffff;
+		hdr->ramdisk_size  = ramdisk_size & 0xffffffff;
+		boot_params->ext_ramdisk_image = (u64)ramdisk_addr >> 32;
+		boot_params->ext_ramdisk_size  = (u64)ramdisk_size >> 32;
+	}
 
 	efi_stub_entry(handle, sys_table, boot_params);
 	/* not reached */
@@ -699,14 +702,9 @@ struct boot_params *efi_main(efi_handle_t handle,
 {
 	unsigned long bzimage_addr = (unsigned long)startup_32;
 	struct setup_header *hdr = &boot_params->hdr;
-	unsigned long max_addr = hdr->initrd_addr_max;
-	unsigned long initrd_addr, initrd_size;
 	efi_status_t status;
 	unsigned long cmdline_paddr;
 
-	if (hdr->xloadflags & XLF_CAN_BE_LOADED_ABOVE_4G)
-		max_addr = ULONG_MAX;
-
 	sys_table = sys_table_arg;
 
 	/* Check if we were booted by the EFI firmware */
@@ -746,15 +744,23 @@ struct boot_params *efi_main(efi_handle_t handle,
 	 * permit an initrd loaded from the LINUX_EFI_INITRD_MEDIA_GUID device
 	 * path to supersede it.
 	 */
-	status = efi_load_initrd_dev_path(&initrd_addr, &initrd_size, max_addr);
-	if (status == EFI_SUCCESS) {
-		hdr->ramdisk_image		= (u32)initrd_addr;
-		hdr->ramdisk_size 		= (u32)initrd_size;
-		boot_params->ext_ramdisk_image	= (u64)initrd_addr >> 32;
-		boot_params->ext_ramdisk_size 	= (u64)initrd_size >> 32;
-	} else if (status != EFI_NOT_FOUND) {
-		efi_printk("efi_load_initrd_dev_path() failed!\n");
-		goto fail;
+	if (!noinitrd()) {
+		unsigned long addr, size;
+		unsigned long max_addr = hdr->initrd_addr_max;
+
+		if (hdr->xloadflags & XLF_CAN_BE_LOADED_ABOVE_4G)
+			max_addr = ULONG_MAX;
+
+		status = efi_load_initrd_dev_path(&addr, &size, max_addr);
+		if (status == EFI_SUCCESS) {
+			hdr->ramdisk_image		= (u32)addr;
+			hdr->ramdisk_size 		= (u32)size;
+			boot_params->ext_ramdisk_image	= (u64)addr >> 32;
+			boot_params->ext_ramdisk_size 	= (u64)size >> 32;
+		} else if (status != EFI_NOT_FOUND) {
+			efi_printk("efi_load_initrd_dev_path() failed!\n");
+			goto fail;
+		}
 	}
 
 	/*
-- 
2.17.1

