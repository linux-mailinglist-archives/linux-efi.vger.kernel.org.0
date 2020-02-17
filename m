Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A219161506
	for <lists+linux-efi@lfdr.de>; Mon, 17 Feb 2020 15:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbgBQOsq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Feb 2020 09:48:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:58332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729009AbgBQOsq (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 17 Feb 2020 09:48:46 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE90620718;
        Mon, 17 Feb 2020 14:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581950925;
        bh=0/AcIU9tvltYH1wW9MREZcZag8ez+CDRUtpc+Y6G/LU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kMz0Tjv8HozFIKf1SQS0wY7onORCtqr0xivGVNgoVGhmsRvKzlL5suN5DVZoDgUtD
         zm90DqQ+mlKzWvgXHF0edTIkS//4T8ht60eyJZ1LZBPZibv11arUxVBp8tmB7z+qPr
         udC1w5SySBOKOOG2z6/Nooald8TQB3iH+JKLFHrk=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, lersek@redhat.com,
        leif@nuviainc.com, pjones@redhat.com, mjg59@google.com,
        agraf@csgraf.de, daniel.kiper@oracle.com, hdegoede@redhat.com,
        nivedita@alum.mit.edu, mingo@kernel.org
Subject: [PATCH v2 3/5] efi/libstub/x86: Use Exit() boot service to exit the stub on errors
Date:   Mon, 17 Feb 2020 15:48:20 +0100
Message-Id: <20200217144822.24616-4-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200217144822.24616-1-ardb@kernel.org>
References: <20200217144822.24616-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Currently, we either return with an error [from efi_pe_entry()] or
enter a deadloop [in efi_main()] if any fatal errors occur during
execution of the EFI stub. Let's switch to calling the Exit() EFI boot
service instead in both cases, so that we
a) can get rid of the deadloop, and simply return to the boot manager
   if any errors occur during execution of the stub, including during
   the call to ExitBootServices(),
b) can also return cleanly from efi_pe_entry() or efi_main() in mixed
   mode, once we introduce support for LoadImage/StartImage based mixed
   mode in the next patch.

Note that on systems running downstream GRUBs [which do not use LoadImage
or StartImage to boot the kernel, and instead, pass their own image
handle as the loaded image handle], calling Exit() will exit from GRUB
rather than from the kernel, but this is a tolerable side effect.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/efi.h              |  8 ++++++++
 drivers/firmware/efi/libstub/efistub.h  |  5 ++++-
 drivers/firmware/efi/libstub/x86-stub.c | 20 +++++++++++++-------
 3 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index fcb21e3d13c5..05131b962374 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -268,6 +268,11 @@ static inline void *efi64_zero_upper(void *p)
 	return p;
 }
 
+static inline u32 efi64_convert_status(efi_status_t status)
+{
+	return (u32)(status | (u64)status >> 32);
+}
+
 #define __efi64_argmap_free_pages(addr, size)				\
 	((addr), 0, (size))
 
@@ -286,6 +291,9 @@ static inline void *efi64_zero_upper(void *p)
 #define __efi64_argmap_locate_device_path(protocol, path, handle)	\
 	((protocol), (path), efi64_zero_upper(handle))
 
+#define __efi64_argmap_exit(handle, status, size, data)			\
+	((handle), efi64_convert_status(status), (size), (data))
+
 /* PCI I/O */
 #define __efi64_argmap_get_location(protocol, seg, bus, dev, func)	\
 	((protocol), efi64_zero_upper(seg), efi64_zero_upper(bus),	\
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 6960e730f990..cc90a748bcf0 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -144,7 +144,10 @@ union efi_boot_services {
 								     void *);
 		void *load_image;
 		void *start_image;
-		void *exit;
+		efi_status_t __noreturn (__efiapi *exit)(efi_handle_t,
+							 efi_status_t,
+							 unsigned long,
+							 efi_char16_t *);
 		void *unload_image;
 		efi_status_t (__efiapi *exit_boot_services)(efi_handle_t,
 							    unsigned long);
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index ce0c3caa3087..cec6baa14d5c 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -340,6 +340,13 @@ static void setup_graphics(struct boot_params *boot_params)
 	}
 }
 
+
+static void __noreturn efi_exit(efi_handle_t handle, efi_status_t status)
+{
+	efi_bs_call(exit, handle, status, 0, NULL);
+	unreachable();
+}
+
 void startup_32(struct boot_params *boot_params);
 
 void __noreturn efi_stub_entry(efi_handle_t handle,
@@ -369,12 +376,12 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 
 	/* Check if we were booted by the EFI firmware */
 	if (sys_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
-		return EFI_INVALID_PARAMETER;
+		efi_exit(handle, EFI_INVALID_PARAMETER);
 
 	status = efi_bs_call(handle_protocol, handle, &proto, (void *)&image);
 	if (status != EFI_SUCCESS) {
 		efi_printk("Failed to get handle for LOADED_IMAGE_PROTOCOL\n");
-		return status;
+		efi_exit(handle, status);
 	}
 
 	hdr = &((struct boot_params *)efi_table_attr(image, image_base))->hdr;
@@ -384,7 +391,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 				    above4g ? ULONG_MAX : UINT_MAX);
 	if (status != EFI_SUCCESS) {
 		efi_printk("Failed to allocate lowmem for boot params\n");
-		return status;
+		efi_exit(handle, status);
 	}
 
 	memset(boot_params, 0x0, 0x4000);
@@ -442,7 +449,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 fail:
 	efi_free(0x4000, (unsigned long)boot_params);
 
-	return status;
+	efi_exit(handle, status);
 }
 
 static void add_e820ext(struct boot_params *params,
@@ -709,7 +716,7 @@ struct boot_params *efi_main(efi_handle_t handle,
 
 	/* Check if we were booted by the EFI firmware */
 	if (sys_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
-		goto fail;
+		efi_exit(handle, EFI_INVALID_PARAMETER);
 
 	/*
 	 * If the kernel isn't already loaded at the preferred load
@@ -793,6 +800,5 @@ struct boot_params *efi_main(efi_handle_t handle,
 fail:
 	efi_printk("efi_main() failed!\n");
 
-	for (;;)
-		asm("hlt");
+	efi_exit(handle, status);
 }
-- 
2.17.1

