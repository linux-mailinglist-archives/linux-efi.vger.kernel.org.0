Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 699591545B7
	for <lists+linux-efi@lfdr.de>; Thu,  6 Feb 2020 15:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgBFOFB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Feb 2020 09:05:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:49898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbgBFOFB (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 6 Feb 2020 09:05:01 -0500
Received: from e123331-lin.cambridge.arm.com (fw-tnat-cam2.arm.com [217.140.106.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60A6521927;
        Thu,  6 Feb 2020 14:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580997900;
        bh=jwcptciGiLK2xtm+5FiJWeT4TrG5htU5W5nyjXf37Oo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=irTH+DUYcyHpBwWiL6AIocy1UMXFpUeTWMhxJQaZNZvzGbOqqcRmQWYkaUZ1OlvLO
         juPIBLhU1EJe0nqyKAlkwUveJfrTFL+h0RjtphgH2lgrbHU7TZsILo1X+YarHBVngc
         HFv7fZweatAtNZKHTlciAM9QEOiuxfF/W8MhtOck=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>, lersek@redhat.com,
        leif@nuviainc.com, pjones@redhat.com, mjg59@google.com,
        agraf@csgraf.de, ilias.apalodimas@linaro.org, xypron.glpk@gmx.de,
        daniel.kiper@oracle.com
Subject: [PATCH 2/2] efi/libstub: take noinitrd cmdline argument into account for devpath initrd
Date:   Thu,  6 Feb 2020 14:03:52 +0000
Message-Id: <20200206140352.6300-3-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200206140352.6300-1-ardb@kernel.org>
References: <20200206140352.6300-1-ardb@kernel.org>
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
forces the PCR that covers the initrd to assume a different value when
noinitrd is passed, allowing an attestation policy to disregard the
command line if there is no need to take its measurement into account
for other reasons.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/arm-stub.c        | 23 +++++-----
 drivers/firmware/efi/libstub/efi-stub-helper.c |  9 ++++
 drivers/firmware/efi/libstub/efistub.h         |  1 +
 drivers/firmware/efi/libstub/x86-stub.c        | 45 +++++++++++---------
 4 files changed, 47 insertions(+), 31 deletions(-)

diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index 1db943c1ba2b..5e8f16cf016e 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -256,18 +256,21 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table_arg,
 	if (!fdt_addr)
 		pr_efi("Generating empty DTB\n");
 
-	max_addr = efi_get_max_initrd_addr(dram_base, *image_addr);
-	status = efi_load_initrd_devpath(&initrd_addr, &initrd_size, max_addr);
-	if (status == EFI_SUCCESS)
-		pr_efi("Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path\n");
-	else if (status == EFI_NOT_FOUND) {
-		status = efi_load_initrd(image, ULONG_MAX, max_addr,
-					 &initrd_addr, &initrd_size);
+	if (!noinitrd()) {
+		max_addr = efi_get_max_initrd_addr(dram_base, *image_addr);
+		status = efi_load_initrd_devpath(&initrd_addr, &initrd_size,
+						 max_addr);
 		if (status == EFI_SUCCESS)
-			pr_efi("Loaded initrd from command line option\n");
+			pr_efi("Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path\n");
+		else if (status == EFI_NOT_FOUND) {
+			status = efi_load_initrd(image, ULONG_MAX, max_addr,
+						 &initrd_addr, &initrd_size);
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
index eaf45ea749b3..367575fb8424 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -11,6 +11,7 @@
 
 static bool __efistub_global efi_nochunk;
 static bool __efistub_global efi_nokaslr;
+static bool __efistub_global efi_noinitrd;
 static bool __efistub_global efi_quiet;
 static bool __efistub_global efi_novamap;
 static bool __efistub_global efi_nosoftreserve;
@@ -25,6 +26,10 @@ bool __pure nokaslr(void)
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
@@ -71,6 +76,10 @@ efi_status_t efi_parse_options(char const *cmdline)
 	if (str == cmdline || (str && str > cmdline && *(str - 1) == ' '))
 		efi_nokaslr = true;
 
+	str = strstr(cmdline, "noinitrd");
+	if (str == cmdline || (str && str > cmdline && *(str - 1) == ' '))
+		efi_noinitrd = true;
+
 	str = strstr(cmdline, "quiet");
 	if (str == cmdline || (str && str > cmdline && *(str - 1) == ' '))
 		efi_quiet = true;
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index fbf9f9442eed..29a5d0e9554a 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -44,6 +44,7 @@
 
 extern bool __pure nochunk(void);
 extern bool __pure nokaslr(void);
+extern bool __pure noinitrd(void);
 extern bool __pure is_quiet(void);
 extern bool __pure novamap(void);
 
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 7f38f95676dd..9d86c0949b3c 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -419,26 +419,28 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	if (status != EFI_SUCCESS)
 		goto fail2;
 
-	/*
-	 * The initrd loaded from the Linux initrd vendor device
-	 * path should take precedence, as we don't want the
-	 * [unverified] command line to override the initrd
-	 * supplied by the [potentially verified] firmware.
-	 */
-	status = efi_load_initrd_devpath(&ramdisk_addr, &ramdisk_size,
-					 above4g ? ULONG_MAX
-						 : hdr->initrd_addr_max);
-	if (status == EFI_NOT_FOUND)
-		status = efi_load_initrd(image, hdr->initrd_addr_max,
-					 above4g ? ULONG_MAX
-						 : hdr->initrd_addr_max,
-					 &ramdisk_addr, &ramdisk_size);
-	if (status != EFI_SUCCESS)
-		goto fail2;
-	hdr->ramdisk_image = ramdisk_addr & 0xffffffff;
-	hdr->ramdisk_size  = ramdisk_size & 0xffffffff;
-	boot_params->ext_ramdisk_image = (u64)ramdisk_addr >> 32;
-	boot_params->ext_ramdisk_size  = (u64)ramdisk_size >> 32;
+	if (!noinitrd()) {
+		/*
+		 * The initrd loaded from the Linux initrd vendor device
+		 * path should take precedence, as we don't want the
+		 * [unverified] command line to override the initrd
+		 * supplied by the [potentially verified] firmware.
+		 */
+		status = efi_load_initrd_devpath(&ramdisk_addr, &ramdisk_size,
+						 above4g ? ULONG_MAX
+							 : hdr->initrd_addr_max);
+		if (status == EFI_NOT_FOUND)
+			status = efi_load_initrd(image, hdr->initrd_addr_max,
+						 above4g ? ULONG_MAX
+							 : hdr->initrd_addr_max,
+						 &ramdisk_addr, &ramdisk_size);
+		if (status != EFI_SUCCESS)
+			goto fail2;
+		hdr->ramdisk_image = ramdisk_addr & 0xffffffff;
+		hdr->ramdisk_size  = ramdisk_size & 0xffffffff;
+		boot_params->ext_ramdisk_image = (u64)ramdisk_addr >> 32;
+		boot_params->ext_ramdisk_size  = (u64)ramdisk_size >> 32;
+	}
 
 	efi_stub_entry(handle, sys_table, boot_params);
 	/* not reached */
@@ -743,7 +745,8 @@ struct boot_params *efi_main(efi_handle_t handle,
 			 ((u64)boot_params->ext_cmd_line_ptr << 32));
 	efi_parse_options((char *)cmdline_paddr);
 
-	if (!hdr->ramdisk_size && !boot_params->ext_ramdisk_size) {
+	if (!hdr->ramdisk_size && !boot_params->ext_ramdisk_size &&
+	    !noinitrd()) {
 		unsigned long max = hdr->initrd_addr_max;
 		unsigned long addr, size;
 
-- 
2.17.1

