Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9DA17854C
	for <lists+linux-efi@lfdr.de>; Tue,  3 Mar 2020 23:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgCCWMN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Mar 2020 17:12:13 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36679 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbgCCWMM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Mar 2020 17:12:12 -0500
Received: by mail-qt1-f193.google.com with SMTP id t13so4176161qto.3;
        Tue, 03 Mar 2020 14:12:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y9ZUfBYU9k6PdrRDPkXq7obctTGrbSS1tg9LdI2Are4=;
        b=QXiBmcCGLb5DjlOO6pafUvZodbPjAzVIxc52fwNz1v22FfDnRRdKgbl+n2z9hlCLct
         9Ee8I2PVCih1SDGAv6NB3LiWz4nF0i3UzZMnzPwE/AsOBQXO07iF1fp1hP0EUGX+fkVJ
         OoyiiajPIUk21txh7m0sSERD22UsqNXxYs0QXrq+URgO06FwAT77ahUeNQjy7p4dd0Uw
         2Xshx1pVoK3nQUHzxEmEB6j1JM8BMScAEK83CzGCzeYi0iRzVMbHFmHXWM+PK3dFW2vg
         uUA9LEAyTzabK7fVgyGzBe/vtnQgEsesS4TUNZ+0sONaccAyjcUwTQc/I3fC4boMW+r0
         gwIA==
X-Gm-Message-State: ANhLgQ2OqzMrcWs0FYBQb3p8iMvAINvwBueN37LJVxv+VzEcE3hVq4P8
        usTeYyzNiFKoqR+5AEJM1FM7f2U2X0Q=
X-Google-Smtp-Source: ADFU+vtuvw7kFLYQpjB96pGtl57vnfa7Vz85lUKgsu1P/kPobOULRfCYE1RlXYKyG2XomJdm4M/sVw==
X-Received: by 2002:ac8:7210:: with SMTP id a16mr6679247qtp.167.1583273530010;
        Tue, 03 Mar 2020 14:12:10 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id i91sm13267378qtd.70.2020.03.03.14.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 14:12:09 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] efi/x86: Don't relocate the kernel unless necessary
Date:   Tue,  3 Mar 2020 17:12:05 -0500
Message-Id: <20200303221205.4048668-6-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200303221205.4048668-1-nivedita@alum.mit.edu>
References: <20200301230537.2247550-1-nivedita@alum.mit.edu>
 <20200303221205.4048668-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add alignment slack to the PE image size, so that we can realign the
decompression buffer within the space allocated for the image.

Only relocate the kernel if it has been loaded at an unsuitable address:
* Below LOAD_PHYSICAL_ADDR, or
* Above 64T for 64-bit and 512MiB for 32-bit

For 32-bit, the upper limit is conservative, but the exact limit can be
difficult to calculate.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/tools/build.c             | 16 +++++-------
 drivers/firmware/efi/libstub/x86-stub.c | 33 ++++++++++++++++++++++---
 2 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index 3d03ad753ed5..db528961c283 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -238,21 +238,17 @@ static void update_pecoff_text(unsigned int text_start, unsigned int file_sz,
 
 	pe_header = get_unaligned_le32(&buf[0x3c]);
 
-#ifdef CONFIG_EFI_MIXED
 	/*
-	 * In mixed mode, we will execute startup_32() at whichever offset in
-	 * memory it happened to land when the PE/COFF loader loaded the image,
-	 * which may be misaligned with respect to the kernel_alignment field
-	 * in the setup header.
+	 * The PE/COFF loader may load the image at an address which is
+	 * misaligned with respect to the kernel_alignment field in the setup
+	 * header.
 	 *
-	 * In order for startup_32 to safely execute in place at this offset,
-	 * we need to ensure that the CONFIG_PHYSICAL_ALIGN aligned allocation
-	 * it creates for the page tables does not extend beyond the declared
-	 * size of the image in the PE/COFF header. So add the required slack.
+	 * In order to avoid relocating the kernel to correct the misalignment,
+	 * add slack to allow the buffer to be aligned within the declared size
+	 * of the image.
 	 */
 	bss_sz	+= CONFIG_PHYSICAL_ALIGN;
 	init_sz	+= CONFIG_PHYSICAL_ALIGN;
-#endif
 
 	/*
 	 * Size of code: Subtract the size of the first sector (512 bytes)
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index e71b8421e088..fbc4354f534c 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -17,6 +17,9 @@
 
 #include "efistub.h"
 
+/* Maximum physical address for 64-bit kernel with 4-level paging */
+#define MAXMEM_X86_64_4LEVEL (1ull << 46)
+
 static efi_system_table_t *sys_table;
 extern const bool efi_is64;
 extern u32 image_offset;
@@ -717,6 +720,7 @@ unsigned long efi_main(efi_handle_t handle,
 			     struct boot_params *boot_params)
 {
 	unsigned long bzimage_addr = (unsigned long)startup_32;
+	unsigned long buffer_start, buffer_end;
 	struct setup_header *hdr = &boot_params->hdr;
 	efi_status_t status;
 	unsigned long cmdline_paddr;
@@ -728,10 +732,33 @@ unsigned long efi_main(efi_handle_t handle,
 		efi_exit(handle, EFI_INVALID_PARAMETER);
 
 	/*
-	 * If the kernel isn't already loaded at the preferred load
-	 * address, relocate it.
+	 * If the kernel isn't already loaded at a suitable address,
+	 * relocate it.
+	 *
+	 * It must be loaded above LOAD_PHYSICAL_ADDR.
+	 *
+	 * The maximum address for 64-bit is 1 << 46 for 4-level paging. This
+	 * is defined as the macro MAXMEM, but unfortunately that is not a
+	 * compile-time constant if 5-level paging is configured, so we instead
+	 * define our own macro for use here.
+	 *
+	 * For 32-bit, the maximum address is complicated to figure out, for
+	 * now use KERNEL_IMAGE_SIZE, which will be 512MiB, the same as what
+	 * KASLR uses.
+	 *
+	 * Also relocate it if image_offset is zero, i.e. we weren't loaded by
+	 * LoadImage, but we are not aligned correctly.
 	 */
-	if (bzimage_addr - image_offset != hdr->pref_address) {
+
+	buffer_start = ALIGN(bzimage_addr - image_offset,
+			     hdr->kernel_alignment);
+	buffer_end = buffer_start + hdr->init_size;
+
+	if ((buffer_start < LOAD_PHYSICAL_ADDR)				     ||
+	    (IS_ENABLED(CONFIG_X86_32) && buffer_end > KERNEL_IMAGE_SIZE)    ||
+	    (IS_ENABLED(CONFIG_X86_64) && buffer_end > MAXMEM_X86_64_4LEVEL) ||
+	    (image_offset == 0 && !IS_ALIGNED(bzimage_addr,
+					      hdr->kernel_alignment))) {
 		status = efi_relocate_kernel(&bzimage_addr,
 					     hdr->init_size, hdr->init_size,
 					     hdr->pref_address,
-- 
2.24.1

