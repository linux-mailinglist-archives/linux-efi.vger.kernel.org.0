Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 239961750CD
	for <lists+linux-efi@lfdr.de>; Mon,  2 Mar 2020 00:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgCAXFo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 1 Mar 2020 18:05:44 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46332 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgCAXFn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 1 Mar 2020 18:05:43 -0500
Received: by mail-qt1-f196.google.com with SMTP id i14so6212737qtv.13;
        Sun, 01 Mar 2020 15:05:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TmFYuzkHLJ+9f+n2eD9AkXx/hb/8ewiBrSbG+YWInKU=;
        b=o5futjXflWk6FYfg4ZotfR3My9uS6UWiksgyuvm3U2rN8VMoXMzHcJRmFrwl8GUsdR
         3UJumQXIqn2hb4Pwt0wdZMRzHoSHW3gKI/h7qpEhLhegAC/SSlgOuAntggyGbvhC4aIp
         L6y/o06UZfqec1FLO2Omxwijujik1bxTUMRlXVZqYZkDP5cLM+LioojPQFquW6tLXana
         7P7A4RGWAMd/VwbAG0QcnphXSJjXAwl07wYE98xH1WmOgsyQGmt2Qp2km9OQJMO1sibT
         eKewm1kUlM/iQoXByQEUknyxYix5ED/axD6E75zAiH82j/w8soHUqNrnPaijYRNYxLfI
         X30g==
X-Gm-Message-State: APjAAAXG3Fv5gc+CAh/ya4G/5uiSUNq9+rBv0+mQKP+iCZKsMHASxiOR
        0W9fTo2ImQVcf4dZzqLOLu8SNqNEG5I=
X-Google-Smtp-Source: APXvYqz/ZnQmNXnaD3opX5tIEqGHyNHgrpjw244GOuT120Ygti5FJZKl4SumZxSBIr2iwO0v8SCeAA==
X-Received: by 2002:ac8:4e91:: with SMTP id 17mr13884767qtp.133.1583103942086;
        Sun, 01 Mar 2020 15:05:42 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id x131sm8923906qka.1.2020.03.01.15.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 15:05:41 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] efi/x86: Don't relocate the kernel unless necessary
Date:   Sun,  1 Mar 2020 18:05:37 -0500
Message-Id: <20200301230537.2247550-6-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200301230537.2247550-1-nivedita@alum.mit.edu>
References: <20200301230537.2247550-1-nivedita@alum.mit.edu>
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
 arch/x86/boot/tools/build.c             | 16 ++++++----------
 drivers/firmware/efi/libstub/x86-stub.c | 22 +++++++++++++++++++---
 2 files changed, 25 insertions(+), 13 deletions(-)

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
index 0c4a6352cfd3..957feeacdd8f 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -717,6 +717,7 @@ unsigned long efi_main(efi_handle_t handle,
 			     struct boot_params *boot_params)
 {
 	unsigned long bzimage_addr = (unsigned long)startup_32;
+	unsigned long buffer_start, buffer_end;
 	struct setup_header *hdr = &boot_params->hdr;
 	efi_status_t status;
 	unsigned long cmdline_paddr;
@@ -728,10 +729,25 @@ unsigned long efi_main(efi_handle_t handle,
 		efi_exit(handle, EFI_INVALID_PARAMETER);
 
 	/*
-	 * If the kernel isn't already loaded at the preferred load
-	 * address, relocate it.
+	 * If the kernel isn't already loaded at a suitable address,
+	 * relocate it.
+	 * It must be loaded above LOAD_PHYSICAL_ADDR.
+	 * The maximum address for 64-bit is 1 << 46 for 4-level paging.
+	 * For 32-bit, the maximum address is complicated to figure out, for
+	 * now use KERNEL_IMAGE_SIZE, which will be 512MiB, the same as what
+	 * KASLR uses.
+	 * Also relocate it if image_offset is zero, i.e. we weren't loaded by
+	 * LoadImage, but we are not aligned correctly.
 	 */
-	if (bzimage_addr - image_offset != hdr->pref_address) {
+	buffer_start = ALIGN(bzimage_addr - image_offset,
+			     hdr->kernel_alignment);
+	buffer_end = buffer_start + hdr->init_size;
+
+	if (buffer_start < LOAD_PHYSICAL_ADDR
+	    || IS_ENABLED(CONFIG_X86_32) && buffer_end > KERNEL_IMAGE_SIZE
+	    || IS_ENABLED(CONFIG_X86_64) && buffer_end > 1ull << 46
+	    || image_offset == 0 && !IS_ALIGNED(bzimage_addr,
+						hdr->kernel_alignment)) {
 		status = efi_relocate_kernel(&bzimage_addr,
 					     hdr->init_size, hdr->init_size,
 					     hdr->pref_address,
-- 
2.24.1

