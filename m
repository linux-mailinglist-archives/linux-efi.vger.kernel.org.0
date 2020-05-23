Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9221DF69B
	for <lists+linux-efi@lfdr.de>; Sat, 23 May 2020 12:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725270AbgEWK13 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 23 May 2020 06:27:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:57336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgEWK13 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 23 May 2020 06:27:29 -0400
Received: from e123331-lin.nice.arm.com (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63A5F206DD;
        Sat, 23 May 2020 10:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590229648;
        bh=O8/SmrbusiNZ6KQAn6HxseRVU9h8hE9qRipkbqeLJfQ=;
        h=From:To:Cc:Subject:Date:From;
        b=ubTxddSDyMsCuaTSz4dhrEMQVRGYdFa2XBIIo5BZT8BGtaMW8+AXnJywmDem2qTsG
         v3DJDVeTG7TewoQROUylLJ1D2q8Qh1Dx5Qb8AxlWVc8LA4+m474w4C9kpTCBtOnp8L
         0QVRaeEowHNjyb0aYtCBsiEZgpLFFkKI2D2Yo7Jg=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] efi/libstub: Add missing prototype for PE/COFF entry point
Date:   Sat, 23 May 2020 12:27:22 +0200
Message-Id: <20200523102722.6347-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Fix a missing prototype warning by adding a forward declaration
for the PE/COFF entrypoint, and while at it, align the function
name between the x86 and ARM versions of the stub.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/boot/compressed/efi-header.S   | 2 +-
 arch/arm64/kernel/efi-entry.S           | 2 +-
 arch/arm64/kernel/efi-header.S          | 2 +-
 drivers/firmware/efi/libstub/efi-stub.c | 3 ++-
 drivers/firmware/efi/libstub/efistub.h  | 3 +++
 5 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/compressed/efi-header.S b/arch/arm/boot/compressed/efi-header.S
index 62286da318e7..c0e7a745103e 100644
--- a/arch/arm/boot/compressed/efi-header.S
+++ b/arch/arm/boot/compressed/efi-header.S
@@ -60,7 +60,7 @@ optional_header:
 		.long	__pecoff_code_size		@ SizeOfCode
 		.long	__pecoff_data_size		@ SizeOfInitializedData
 		.long	0				@ SizeOfUninitializedData
-		.long	efi_entry - start		@ AddressOfEntryPoint
+		.long	efi_pe_entry - start		@ AddressOfEntryPoint
 		.long	start_offset			@ BaseOfCode
 		.long	__pecoff_data_start - start	@ BaseOfData
 
diff --git a/arch/arm64/kernel/efi-entry.S b/arch/arm64/kernel/efi-entry.S
index 1a03618df0df..5664af1e9260 100644
--- a/arch/arm64/kernel/efi-entry.S
+++ b/arch/arm64/kernel/efi-entry.S
@@ -14,7 +14,7 @@
 
 SYM_CODE_START(efi_enter_kernel)
 	/*
-	 * efi_entry() will have copied the kernel image if necessary and we
+	 * efi_pe_entry() will have copied the kernel image if necessary and we
 	 * end up here with device tree address in x1 and the kernel entry
 	 * point stored in x0. Save those values in registers which are
 	 * callee preserved.
diff --git a/arch/arm64/kernel/efi-header.S b/arch/arm64/kernel/efi-header.S
index 914999ccaf8a..f2457d4b76a4 100644
--- a/arch/arm64/kernel/efi-header.S
+++ b/arch/arm64/kernel/efi-header.S
@@ -27,7 +27,7 @@ optional_header:
 	.long	__initdata_begin - efi_header_end	// SizeOfCode
 	.long	__pecoff_data_size			// SizeOfInitializedData
 	.long	0					// SizeOfUninitializedData
-	.long	__efistub_efi_entry - _head		// AddressOfEntryPoint
+	.long	__efistub_efi_pe_entry - _head		// AddressOfEntryPoint
 	.long	efi_header_end - _head			// BaseOfCode
 
 extra_header_fields:
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index cc8d6f510a89..9b7634369158 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -140,7 +140,8 @@ asmlinkage void __noreturn efi_enter_kernel(unsigned long entrypoint,
  * for both archictectures, with the arch-specific code provided in the
  * handle_kernel_image() function.
  */
-efi_status_t efi_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg)
+efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
+				   efi_system_table_t *sys_table_arg)
 {
 	efi_loaded_image_t *image;
 	efi_status_t status;
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 1de8dc02529a..03f74608b963 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -40,6 +40,9 @@ extern bool efi_novamap;
 
 extern const efi_system_table_t *efi_system_table;
 
+efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
+				   efi_system_table_t *sys_table_arg);
+
 #ifndef ARCH_HAS_EFISTUB_WRAPPERS
 
 #define efi_is_native()		(true)
-- 
2.17.1

