Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6FD157F62
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2020 17:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgBJQDS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Feb 2020 11:03:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:52824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727697AbgBJQDR (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 10 Feb 2020 11:03:17 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B261924671;
        Mon, 10 Feb 2020 16:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581350597;
        bh=Cepk/k8bKcaKlAL3ca/zu91U00fg1KUR8Ol1LqSStC4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1ItTB89umgZaQ3IyTAPbH9sK7YXgKQ7GpQTuK3NEeFApRqDWq8QmYnfiWua7og+G3
         BKKut9ME+4bzZrsTODa5Edw7LjCOZR249GbeeWb+WRBtJtGAEHwgLHbDuUztoSGqKV
         axeqozuvapD3qXtgkH9URtSct5DOEZKv7TrtlnSE=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, nivedita@alum.mit.edu,
        mingo@kernel.org, lukas@wunner.de, atish.patra@wdc.com
Subject: [PATCH 11/19] efi/libstub/x86: Permit cmdline data to be allocated above 4 GB
Date:   Mon, 10 Feb 2020 17:02:40 +0100
Message-Id: <20200210160248.4889-12-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210160248.4889-1-ardb@kernel.org>
References: <20200210160248.4889-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

We now support cmdline data that is located in memory that is not
32-bit addressable, so relax the allocation limit on systems where
this feature is enabled.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/efi.h                     | 2 --
 drivers/firmware/efi/libstub/arm-stub.c        | 2 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c | 9 ++-------
 drivers/firmware/efi/libstub/efistub.h         | 3 ++-
 drivers/firmware/efi/libstub/x86-stub.c        | 5 +++--
 5 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 86169a24b0d8..85f79accd3f8 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -34,8 +34,6 @@ static inline bool efi_have_uv1_memmap(void)
 #define EFI32_LOADER_SIGNATURE	"EL32"
 #define EFI64_LOADER_SIGNATURE	"EL64"
 
-#define MAX_CMDLINE_ADDRESS	UINT_MAX
-
 #define ARCH_EFI_IRQ_FLAGS_MASK	X86_EFLAGS_IF
 
 /*
diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index d357393e680e..ebdf1964dd5c 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -161,7 +161,7 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table_arg,
 	 * protocol. We are going to copy the command line into the
 	 * device tree, so this can be allocated anywhere.
 	 */
-	cmdline_ptr = efi_convert_cmdline(image, &cmdline_size);
+	cmdline_ptr = efi_convert_cmdline(image, &cmdline_size, ULONG_MAX);
 	if (!cmdline_ptr) {
 		pr_efi_err("getting command line via LOADED_IMAGE_PROTOCOL\n");
 		goto fail;
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 6db91655c743..92ccd0a51ae6 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -497,17 +497,13 @@ static u8 *efi_utf16_to_utf8(u8 *dst, const u16 *src, int n)
 	return dst;
 }
 
-#ifndef MAX_CMDLINE_ADDRESS
-#define MAX_CMDLINE_ADDRESS	ULONG_MAX
-#endif
-
 /*
  * Convert the unicode UEFI command line to ASCII to pass to kernel.
  * Size of memory allocated return in *cmd_line_len.
  * Returns NULL on error.
  */
 char *efi_convert_cmdline(efi_loaded_image_t *image,
-			  int *cmd_line_len)
+			  int *cmd_line_len, unsigned long max_addr)
 {
 	const u16 *s2;
 	u8 *s1 = NULL;
@@ -535,8 +531,7 @@ char *efi_convert_cmdline(efi_loaded_image_t *image,
 
 	options_bytes++;	/* NUL termination */
 
-	status = efi_allocate_pages(options_bytes, &cmdline_addr,
-				MAX_CMDLINE_ADDRESS);
+	status = efi_allocate_pages(options_bytes, &cmdline_addr, max_addr);
 	if (status != EFI_SUCCESS)
 		return NULL;
 
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 8bb46c1fd2cd..b94c63d17a4f 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -578,7 +578,8 @@ void efi_printk(char *str);
 
 void efi_free(unsigned long size, unsigned long addr);
 
-char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len);
+char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len,
+			  unsigned long max_addr);
 
 efi_status_t efi_get_memory_map(struct efi_boot_memmap *map);
 
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 9d60352baa0f..f2dbf119837c 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -405,7 +405,8 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	hdr->type_of_loader = 0x21;
 
 	/* Convert unicode cmdline to ascii */
-	cmdline_ptr = efi_convert_cmdline(image, &options_size);
+	cmdline_ptr = efi_convert_cmdline(image, &options_size,
+					  above4g ? ULONG_MAX : UINT_MAX);
 	if (!cmdline_ptr)
 		goto fail;
 
@@ -445,7 +446,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	/* not reached */
 
 fail2:
-	efi_free(options_size, hdr->cmd_line_ptr);
+	efi_free(options_size, (unsigned long)cmdline_ptr);
 fail:
 	efi_free(0x4000, (unsigned long)boot_params);
 
-- 
2.17.1

