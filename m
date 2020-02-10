Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67B0E157F58
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2020 17:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgBJQDD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Feb 2020 11:03:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:52592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727435AbgBJQDC (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 10 Feb 2020 11:03:02 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6895120842;
        Mon, 10 Feb 2020 16:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581350581;
        bh=R7q80aWwvv5LOMlcAX4Y2uWOdpki+5GAuOG1bTRQdxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BGJdxe+i+6TyO1fAEWnFN6JYegR+KHyCzV3yE/XKWINfJKbF6S9LBdEgGLG9SZz8m
         Zd12oru6xSsCIgVi42NgmPiHJNESywktUqnmbMtfP0pt7a31TlMsVacDgbL1RE6hck
         URXUxPi2FYllM1JrXfD0yBFntDJ5w7DFjPp5GBn0=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, nivedita@alum.mit.edu,
        mingo@kernel.org, lukas@wunner.de, atish.patra@wdc.com
Subject: [PATCH 02/19] efi/libstub/x86: Avoid overflowing code32_start on PE entry
Date:   Mon, 10 Feb 2020 17:02:31 +0100
Message-Id: <20200210160248.4889-3-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210160248.4889-1-ardb@kernel.org>
References: <20200210160248.4889-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When using the native PE entry point (as opposed to the EFI handover
protocol entry point that is used more widely), we set code32_start,
which is a 32-bit wide field, to the effective symbol address of
startup_32, which could overflow given that the EFI loader may have
located the running image anywhere in memory, and we haven't reached
the point yet where we relocate ourselves.

Since we relocate ourselves if code32_start != pref_address, this
isn't likely to lead to problems in practice, given how unlikely
it is that the truncated effective address of startup_32 happens
to equal pref_address. But it is better to defer the assignment
of code32_start to after the relocation, when it is guaranteed to
fit.

While at it, move the call to efi_relocate_kernel() to an earlier
stage so it is more likely that our preferred offset in memory has
not been occupied by other memory allocations done in the mean time.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/eboot.c | 40 +++++++++-----------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 4745a1ee7953..55637135b50c 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -439,8 +439,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	boot_params->ext_ramdisk_image = (u64)ramdisk_addr >> 32;
 	boot_params->ext_ramdisk_size  = (u64)ramdisk_size >> 32;
 
-	hdr->code32_start = (u32)(unsigned long)startup_32;
-
 	efi_stub_entry(handle, sys_table, boot_params);
 	/* not reached */
 
@@ -707,6 +705,7 @@ struct boot_params *efi_main(efi_handle_t handle,
 			     efi_system_table_t *sys_table_arg,
 			     struct boot_params *boot_params)
 {
+	unsigned long bzimage_addr = (unsigned long)startup_32;
 	struct setup_header *hdr = &boot_params->hdr;
 	efi_status_t status;
 	unsigned long cmdline_paddr;
@@ -717,6 +716,23 @@ struct boot_params *efi_main(efi_handle_t handle,
 	if (sys_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
 		goto fail;
 
+	/*
+	 * If the kernel isn't already loaded at the preferred load
+	 * address, relocate it.
+	 */
+	if (bzimage_addr != hdr->pref_address) {
+		status = efi_relocate_kernel(&bzimage_addr,
+					     hdr->init_size, hdr->init_size,
+					     hdr->pref_address,
+					     hdr->kernel_alignment,
+					     LOAD_PHYSICAL_ADDR);
+		if (status != EFI_SUCCESS) {
+			efi_printk("efi_relocate_kernel() failed!\n");
+			goto fail;
+		}
+	}
+	hdr->code32_start = (u32)bzimage_addr;
+
 	/*
 	 * make_boot_params() may have been called before efi_main(), in which
 	 * case this is the second time we parse the cmdline. This is ok,
@@ -746,26 +762,6 @@ struct boot_params *efi_main(efi_handle_t handle,
 
 	setup_quirks(boot_params);
 
-	/*
-	 * If the kernel isn't already loaded at the preferred load
-	 * address, relocate it.
-	 */
-	if (hdr->pref_address != hdr->code32_start) {
-		unsigned long bzimage_addr = hdr->code32_start;
-		status = efi_relocate_kernel(&bzimage_addr,
-					     hdr->init_size, hdr->init_size,
-					     hdr->pref_address,
-					     hdr->kernel_alignment,
-					     LOAD_PHYSICAL_ADDR);
-		if (status != EFI_SUCCESS) {
-			efi_printk("efi_relocate_kernel() failed!\n");
-			goto fail;
-		}
-
-		hdr->pref_address = hdr->code32_start;
-		hdr->code32_start = bzimage_addr;
-	}
-
 	status = exit_boot(boot_params, handle);
 	if (status != EFI_SUCCESS) {
 		efi_printk("exit_boot() failed!\n");
-- 
2.17.1

