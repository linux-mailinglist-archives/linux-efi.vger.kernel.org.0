Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D2A1D928E
	for <lists+linux-efi@lfdr.de>; Tue, 19 May 2020 10:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgESIwN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 19 May 2020 04:52:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:37360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbgESIwN (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 19 May 2020 04:52:13 -0400
Received: from e123331-lin.nice.arm.com (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 439D0206C3;
        Tue, 19 May 2020 08:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589878332;
        bh=JoT/ZRwaRQbt8+g+anVSCeqYJIUtSc1JgUlSdKjB4bg=;
        h=From:To:Cc:Subject:Date:From;
        b=fODF9wfIJdc51pQRkej82n0uWz6YLn3ZskzmxfPmpdj2xXtMPpsI1Gu/NztDwhhU/
         ycjP13GicNT6Fi9MKA/3mi0yr62Hm7T+vwtU9XR/ekyi50tYp0ENWTPxLVcUTcTKYs
         pA50a4k+dzJGPWfIB+oza8c2gN4GvVivLLzBXx5s=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     nivedita@alum.mit.edu, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] efi/libstub: use pool allocation for the command line
Date:   Tue, 19 May 2020 10:52:04 +0200
Message-Id: <20200519085204.31153-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Now that we removed the memory limit for the allocation of the
command line, there is no longer a need to use the page based
allocator so switch to a pool allocation instead.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 6 +++---
 drivers/firmware/efi/libstub/efi-stub.c        | 4 ++--
 drivers/firmware/efi/libstub/efistub.h         | 3 +--
 drivers/firmware/efi/libstub/x86-stub.c        | 2 +-
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index a29226eca559..e7431ad328ae 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -210,8 +210,7 @@ efi_status_t efi_parse_options(char const *cmdline)
  * Size of memory allocated return in *cmd_line_len.
  * Returns NULL on error.
  */
-char *efi_convert_cmdline(efi_loaded_image_t *image,
-			  int *cmd_line_len, unsigned long max_addr)
+char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len)
 {
 	const u16 *s2;
 	unsigned long cmdline_addr = 0;
@@ -257,7 +256,8 @@ char *efi_convert_cmdline(efi_loaded_image_t *image,
 
 	options_bytes++;	/* NUL termination */
 
-	status = efi_allocate_pages(options_bytes, &cmdline_addr, max_addr);
+	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, options_bytes,
+			     (void **)&cmdline_addr);
 	if (status != EFI_SUCCESS)
 		return NULL;
 
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index c2484bf75c5d..cc8d6f510a89 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -198,7 +198,7 @@ efi_status_t efi_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg)
 	 * protocol. We are going to copy the command line into the
 	 * device tree, so this can be allocated anywhere.
 	 */
-	cmdline_ptr = efi_convert_cmdline(image, &cmdline_size, ULONG_MAX);
+	cmdline_ptr = efi_convert_cmdline(image, &cmdline_size);
 	if (!cmdline_ptr) {
 		efi_err("getting command line via LOADED_IMAGE_PROTOCOL\n");
 		status = EFI_OUT_OF_RESOURCES;
@@ -339,7 +339,7 @@ efi_status_t efi_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg)
 fail_free_screeninfo:
 	free_screen_info(si);
 fail_free_cmdline:
-	efi_free(cmdline_size, (unsigned long)cmdline_ptr);
+	efi_bs_call(free_pool, cmdline_ptr);
 fail:
 	return status;
 }
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index ad7e0406d0ba..1de8dc02529a 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -708,8 +708,7 @@ __printf(1, 2) int efi_printk(char const *fmt, ...);
 
 void efi_free(unsigned long size, unsigned long addr);
 
-char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len,
-			  unsigned long max_addr);
+char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len);
 
 efi_status_t efi_get_memory_map(struct efi_boot_memmap *map);
 
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 37154bb93c59..072b7cf40475 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -404,7 +404,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	hdr->type_of_loader = 0x21;
 
 	/* Convert unicode cmdline to ascii */
-	cmdline_ptr = efi_convert_cmdline(image, &options_size, ULONG_MAX);
+	cmdline_ptr = efi_convert_cmdline(image, &options_size);
 	if (!cmdline_ptr)
 		goto fail;
 
-- 
2.17.1

