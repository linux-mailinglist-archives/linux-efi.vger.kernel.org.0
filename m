Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E167157F57
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2020 17:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgBJQDA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Feb 2020 11:03:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:52556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727435AbgBJQDA (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 10 Feb 2020 11:03:00 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6B5A2085B;
        Mon, 10 Feb 2020 16:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581350580;
        bh=/KC+vTeLrkRYzD0b3w6OUkEw760BQRu7pNW9oIQZ9+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o8B9oQYHIj5Vf5ECSZ2SCjvsmbmJMr/+pdhSkTf8Flcy73MpDV1JDJIvOsPkhPx4p
         w7s6DxqS2yGgjHICu55V/cyHK7m8enO5lMbDw6Y5jnihrv2wwuaowvPYKC1rLtpYZJ
         dnX4Akn0n+gpHtWD/jE+iqhuEf5cr8vOLoLrfe78=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, nivedita@alum.mit.edu,
        mingo@kernel.org, lukas@wunner.de, atish.patra@wdc.com
Subject: [PATCH 01/19] efi/libstub/x86: Remove pointless zeroing of apm_bios_info
Date:   Mon, 10 Feb 2020 17:02:30 +0100
Message-Id: <20200210160248.4889-2-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210160248.4889-1-ardb@kernel.org>
References: <20200210160248.4889-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

We have some code in the EFI stub entry point that takes the address
of the apm_bios_info struct in the newly allocated and zeroed out
boot_params structure, only to zero it out again. This is pointless
so remove it.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/eboot.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 32423e83ba8f..4745a1ee7953 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -358,7 +358,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 				   efi_system_table_t *sys_table_arg)
 {
 	struct boot_params *boot_params;
-	struct apm_bios_info *bi;
 	struct setup_header *hdr;
 	efi_loaded_image_t *image;
 	efi_guid_t proto = LOADED_IMAGE_PROTOCOL_GUID;
@@ -389,7 +388,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	memset(boot_params, 0x0, 0x4000);
 
 	hdr = &boot_params->hdr;
-	bi = &boot_params->apm_bios_info;
 
 	/* Copy the second sector to boot_params */
 	memcpy(&hdr->jump, image->image_base + 512, 512);
@@ -416,9 +414,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	hdr->ramdisk_image = 0;
 	hdr->ramdisk_size = 0;
 
-	/* Clear APM BIOS info */
-	memset(bi, 0, sizeof(*bi));
-
 	status = efi_parse_options(cmdline_ptr);
 	if (status != EFI_SUCCESS)
 		goto fail2;
-- 
2.17.1

