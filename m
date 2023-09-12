Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA71B79CAE1
	for <lists+linux-efi@lfdr.de>; Tue, 12 Sep 2023 11:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbjILJCO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 12 Sep 2023 05:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbjILJBf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 12 Sep 2023 05:01:35 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E7810E3
        for <linux-efi@vger.kernel.org>; Tue, 12 Sep 2023 02:01:30 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59222a14ee1so63987167b3.1
        for <linux-efi@vger.kernel.org>; Tue, 12 Sep 2023 02:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694509290; x=1695114090; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2tvI11no6ZvQpwOGtD7SmPhcRm3cJFuX6Xc9ZqA56hw=;
        b=gTDubkF5H/h5ak1H3XgaTAbulD+vMiPFy7dbaZbexBG4VO3/79ADpeRlf81Pixzc6y
         L/87n2atBYV1YNjIM6X9t5e9j01N1ZFNnYOjxkUK4kNpBhV6Jm3O3GlF3ffrHNFbl3TK
         WbUZpB2e+eZ9Gikx+U0rwLc7dxVc/9CjivUXJXfUnL7zRE5sZuL2WAdbtvFiQbHWJDyL
         sBNO/tbpR3DvBrTh+m0J8DB+9E2RnOTYpaqAEnEJL7Rd1i9hazZw4JNxkco66hHnsO/x
         ae34QAdSRpZIx6VCmd/F7UxH1AK4S3sCctk9wPZUCXsZwe80frzpeOVHl0mKzEoTKDip
         krJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694509290; x=1695114090;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2tvI11no6ZvQpwOGtD7SmPhcRm3cJFuX6Xc9ZqA56hw=;
        b=AGD0Fja4wHeaaAGUtRzatPe3pJXxYmOthYRh3NucAmzEAqHA4qq8pUPYEgUwVImweL
         mBHwrlT8I/Ln0Ohy5mtQK5YkbQZBPqXuz4c4cyqnFQmaVvQ/839dIgZZyjI+jV7xEI78
         QpARTz2njd83MQBXe78YsPD7HQ5b+6ZJZw0qqmA9lI1aZP/3I+ZNFLu6p02NgELcl1iL
         74iNsabjAjTx0vfQLBLDG7dJ9ZnOXDLZz39tpLLJZI64gWQoTNC12VL5VdOXv+lZo93J
         8oXTKa1z5sYbL9KwjfaAfNTj2C3cEUX/UkCx2TfNag3yVAjD4ReoNQSQckKJfM3C/pZO
         P3sA==
X-Gm-Message-State: AOJu0YwyKmT3zDXj18/b2buFouUlf/uHMDijqOHMVPv4ctkAgftST2Ug
        HrpVK9VY3pBv0CDAY9tDw07Y2lGwJ80CnSGiyy2cEP6wc/Nj+WHRy8O1eZnyiii543v9FgmLAkq
        PBotdc7PzNsXLEXBuL1Y7XhYz8U1nugKRghO4lIfiHHVn1shjzn0SGONOSiHC
X-Google-Smtp-Source: AGHT+IGFlBfEsGa7oWurzDLl/SbOLYcvdinALugrqVeiiQbXKMzAzAWym2jp1tk5FdY/S7niWkYNKUl9
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:1707:b0:d7b:9830:c172 with SMTP id
 by7-20020a056902170700b00d7b9830c172mr288041ybb.0.1694509289690; Tue, 12 Sep
 2023 02:01:29 -0700 (PDT)
Date:   Tue, 12 Sep 2023 09:00:53 +0000
In-Reply-To: <20230912090051.4014114-17-ardb@google.com>
Mime-Version: 1.0
References: <20230912090051.4014114-17-ardb@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3785; i=ardb@kernel.org;
 h=from:subject; bh=nvt548TxMzPAfrcolR6Dxu6IZrj/XUbhhxX9pY3970g=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZVB49j5KR1frtj1n1wYllN3piW9b0/FzQSf7qBt+x9ly
 ixa9P5ERykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZhIdAYjw4XPli+nl82Vb1n5
 //HJSUe0l0ue+sazYl15m7Ojx56gb0wM/ytbVl75yJ9y/9vtur971Kx5c5QqAjaoVRxvMppfG2a gyAQA
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912090051.4014114-19-ardb@google.com>
Subject: [PATCH v2 02/15] x86/efi: Disregard setup header of loaded image
From:   Ard Biesheuvel <ardb@google.com>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

The native EFI entrypoint does not take a struct boot_params from the
loader, but instead, it constructs one from scratch, using the setup
header data placed at the start of the image.

This setup header is placed in a way that permits legacy loaders to
manipulate the contents (i.e., to pass the kernel command line or the
address and size of an initial ramdisk), but EFI boot does not use it in
that way - it only copies the contents that were placed there at build
time, but EFI loaders will not (and should not) manipulate the setup
header to configure the boot. (Commit 63bf28ceb3ebbe76 "efi: x86: Wipe
setup_data on pure EFI boot" deals with some of the fallout of using
setup_data in a way that breaks EFI boot.)

Given that none of the non-zero values that are copied from the setup
header into the EFI stub's struct boot_params are relevant to the boot
now that the EFI stub no longer enters via the legacy decompressor, the
copy can be omitted altogether.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 46 +++-----------------
 1 file changed, 6 insertions(+), 40 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 2fee52ed335d..d76a9f7c35d0 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -449,9 +449,8 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 				   efi_system_table_t *sys_table_arg)
 {
-	struct boot_params *boot_params;
-	struct setup_header *hdr;
-	void *image_base;
+	static struct boot_params boot_params __page_aligned_bss;
+	struct setup_header *hdr = &boot_params.hdr;
 	efi_guid_t proto = LOADED_IMAGE_PROTOCOL_GUID;
 	int options_size = 0;
 	efi_status_t status;
@@ -469,30 +468,9 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 		efi_exit(handle, status);
 	}
 
-	image_base = efi_table_attr(image, image_base);
-
-	status = efi_allocate_pages(sizeof(struct boot_params),
-				    (unsigned long *)&boot_params, ULONG_MAX);
-	if (status != EFI_SUCCESS) {
-		efi_err("Failed to allocate lowmem for boot params\n");
-		efi_exit(handle, status);
-	}
-
-	memset(boot_params, 0x0, sizeof(struct boot_params));
-
-	hdr = &boot_params->hdr;
-
-	/* Copy the setup header from the second sector to boot_params */
-	memcpy(&hdr->jump, image_base + 512,
-	       sizeof(struct setup_header) - offsetof(struct setup_header, jump));
-
-	/*
-	 * Fill out some of the header fields ourselves because the
-	 * EFI firmware loader doesn't load the first sector.
-	 */
+	/* assign the setup_header fields that the kernel actually cares about */
 	hdr->root_flags	= 1;
 	hdr->vid_mode	= 0xffff;
-	hdr->boot_flag	= 0xAA55;
 
 	hdr->type_of_loader = 0x21;
 
@@ -501,25 +479,13 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	if (!cmdline_ptr)
 		goto fail;
 
-	efi_set_u64_split((unsigned long)cmdline_ptr,
-			  &hdr->cmd_line_ptr, &boot_params->ext_cmd_line_ptr);
-
-	hdr->ramdisk_image = 0;
-	hdr->ramdisk_size = 0;
-
-	/*
-	 * Disregard any setup data that was provided by the bootloader:
-	 * setup_data could be pointing anywhere, and we have no way of
-	 * authenticating or validating the payload.
-	 */
-	hdr->setup_data = 0;
+	efi_set_u64_split((unsigned long)cmdline_ptr, &hdr->cmd_line_ptr,
+			  &boot_params.ext_cmd_line_ptr);
 
-	efi_stub_entry(handle, sys_table_arg, boot_params);
+	efi_stub_entry(handle, sys_table_arg, &boot_params);
 	/* not reached */
 
 fail:
-	efi_free(sizeof(struct boot_params), (unsigned long)boot_params);
-
 	efi_exit(handle, status);
 }
 
-- 
2.42.0.283.g2d96d420d3-goog

