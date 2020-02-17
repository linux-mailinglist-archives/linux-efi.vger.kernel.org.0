Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEA7161505
	for <lists+linux-efi@lfdr.de>; Mon, 17 Feb 2020 15:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgBQOsn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Feb 2020 09:48:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:58296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729009AbgBQOsn (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 17 Feb 2020 09:48:43 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9122208C4;
        Mon, 17 Feb 2020 14:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581950922;
        bh=4rK/Cs75LSvVEvWuQDcMPhlsO3AXpj3H4QQv2bcKFFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wV2aFTe8oZY4FYbcYLXWsg2aYO2uyC5ziXiFPZxLaOhqFig4KtgyYx4U+oi7hBY+H
         JrAqluXSUom83kTRmfv5BfFrnUnpl/UQvgFBrru0IVLWhjF/aRPrSun6QYexmNHsNK
         EVEgTt/ONrc0+kPQZ/vO+zHhTou9Z85jcIp47GKw=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, lersek@redhat.com,
        leif@nuviainc.com, pjones@redhat.com, mjg59@google.com,
        agraf@csgraf.de, daniel.kiper@oracle.com, hdegoede@redhat.com,
        nivedita@alum.mit.edu, mingo@kernel.org
Subject: [PATCH v2 2/5] efi/libstub/x86: Make loaded_image protocol handling mixed mode safe
Date:   Mon, 17 Feb 2020 15:48:19 +0100
Message-Id: <20200217144822.24616-3-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200217144822.24616-1-ardb@kernel.org>
References: <20200217144822.24616-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add the definitions and use the special wrapper so that the loaded_image
UEFI protocol can be safely used from mixed mode.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c |  4 +-
 drivers/firmware/efi/libstub/efistub.h         | 45 ++++++++++++++------
 drivers/firmware/efi/libstub/x86-stub.c        |  4 +-
 3 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index d98f9a1bf82c..618c189dd55c 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -171,8 +171,8 @@ char *efi_convert_cmdline(efi_loaded_image_t *image,
 	const u16 *s2;
 	u8 *s1 = NULL;
 	unsigned long cmdline_addr = 0;
-	int load_options_chars = image->load_options_size / 2; /* UTF-16 */
-	const u16 *options = image->load_options;
+	int load_options_chars = efi_table_attr(image, load_options_size) / 2;
+	const u16 *options = efi_table_attr(image, load_options);
 	int options_bytes = 0;  /* UTF-8 bytes */
 	int options_chars = 0;  /* UTF-16 chars */
 	efi_status_t status;
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 2e5e79edb4d7..6960e730f990 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -308,20 +308,37 @@ union efi_graphics_output_protocol {
 	} mixed_mode;
 };
 
-typedef struct {
-	u32			revision;
-	efi_handle_t		parent_handle;
-	efi_system_table_t	*system_table;
-	efi_handle_t		device_handle;
-	void			*file_path;
-	void			*reserved;
-	u32			load_options_size;
-	void			*load_options;
-	void			*image_base;
-	__aligned_u64		image_size;
-	unsigned int		image_code_type;
-	unsigned int		image_data_type;
-	efi_status_t		(__efiapi *unload)(efi_handle_t image_handle);
+typedef union {
+	struct {
+		u32			revision;
+		efi_handle_t		parent_handle;
+		efi_system_table_t	*system_table;
+		efi_handle_t		device_handle;
+		void			*file_path;
+		void			*reserved;
+		u32			load_options_size;
+		void			*load_options;
+		void			*image_base;
+		__aligned_u64		image_size;
+		unsigned int		image_code_type;
+		unsigned int		image_data_type;
+		efi_status_t		(__efiapi *unload)(efi_handle_t image_handle);
+	};
+	struct {
+		u32		revision;
+		u32		parent_handle;
+		u32		system_table;
+		u32		device_handle;
+		u32		file_path;
+		u32		reserved;
+		u32		load_options_size;
+		u32		load_options;
+		u32		image_base;
+		__aligned_u64	image_size;
+		u32		image_code_type;
+		u32		image_data_type;
+		u32		unload;
+	} mixed_mode;
 } efi_loaded_image_t;
 
 typedef struct {
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 7d4866471f86..ce0c3caa3087 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -377,7 +377,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 		return status;
 	}
 
-	hdr = &((struct boot_params *)image->image_base)->hdr;
+	hdr = &((struct boot_params *)efi_table_attr(image, image_base))->hdr;
 	above4g = hdr->xloadflags & XLF_CAN_BE_LOADED_ABOVE_4G;
 
 	status = efi_allocate_pages(0x4000, (unsigned long *)&boot_params,
@@ -392,7 +392,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	hdr = &boot_params->hdr;
 
 	/* Copy the second sector to boot_params */
-	memcpy(&hdr->jump, image->image_base + 512, 512);
+	memcpy(&hdr->jump, efi_table_attr(image, image_base) + 512, 512);
 
 	/*
 	 * Fill out some of the header fields ourselves because the
-- 
2.17.1

