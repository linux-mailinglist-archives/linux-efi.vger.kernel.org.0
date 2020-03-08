Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8C317D281
	for <lists+linux-efi@lfdr.de>; Sun,  8 Mar 2020 09:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgCHIKP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 8 Mar 2020 04:10:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbgCHIKO (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 8 Mar 2020 04:10:14 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06B81222C3;
        Sun,  8 Mar 2020 08:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583655014;
        bh=4ipDn/3aECRab2dGz92cr6IfDiukXbrhk8j6xGQ9xo0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rmzy0iyzQD+Dss5WVTcfZakIu1YeBVmYSj/6+oPO1RuSLc+azr7BTfmPke2FMNxWx
         hW8oWvcV33E5ROsg6RQekILdDIXjeNL1re1dmGbwpBK1Xe8+b41bN17hbONM3FpAQm
         TuUNDpijchtHCTFhLMN1T9yVr7AvRWGma2XhifaQ=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nikolai Merinov <n.merinov@inango-systems.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Vladis Dronov <vdronov@redhat.com>
Subject: [PATCH 19/28] efi/x86: Don't relocate the kernel unless necessary
Date:   Sun,  8 Mar 2020 09:08:50 +0100
Message-Id: <20200308080859.21568-20-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200308080859.21568-1-ardb@kernel.org>
References: <20200308080859.21568-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

Add alignment slack to the PE image size, so that we can realign the
decompression buffer within the space allocated for the image.

Only relocate the kernel if it has been loaded at an unsuitable address:
* Below LOAD_PHYSICAL_ADDR, or
* Above 64T for 64-bit and 512MiB for 32-bit

For 32-bit, the upper limit is conservative, but the exact limit can be
difficult to calculate.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://lore.kernel.org/r/20200303221205.4048668-6-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
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
index 96bc4a8733c8..064941ecc36f 100644
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
@@ -718,6 +721,7 @@ unsigned long efi_main(efi_handle_t handle,
 			     struct boot_params *boot_params)
 {
 	unsigned long bzimage_addr = (unsigned long)startup_32;
+	unsigned long buffer_start, buffer_end;
 	struct setup_header *hdr = &boot_params->hdr;
 	efi_status_t status;
 	unsigned long cmdline_paddr;
@@ -729,10 +733,33 @@ unsigned long efi_main(efi_handle_t handle,
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
2.17.1

