Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB8E168FF2
	for <lists+linux-efi@lfdr.de>; Sat, 22 Feb 2020 16:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgBVP4n (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 22 Feb 2020 10:56:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:38334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727681AbgBVP4n (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 22 Feb 2020 10:56:43 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F308724650;
        Sat, 22 Feb 2020 15:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582387002;
        bh=cdao8bj1y6LRYPb1ERhjwlQKtW1DKph5MLljiIwWieQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=brEJSuUDh8SQFSKhDl8b+N5I8XHZ6ldVGrsq8eO3PdxuaTT5aXdRE1gYC8dX6HFig
         +4w8G8OFAKJirlHxnFg/Ba+OpAwm99EadX1/GDKE4gr0M33jtex6ObacH5qf5H72e2
         KikkN4f9tQM5ayOT1aRITKyeDX32WlZwaSS2tSRI=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, hdegoede@redhat.com,
        nivedita@alum.mit.edu, x86@kernel.org
Subject: [PATCH v3 4/6] efi/libstub/x86: Use Exit() boot service to exit the stub on errors
Date:   Sat, 22 Feb 2020 16:55:17 +0100
Message-Id: <20200222155519.23550-5-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200222155519.23550-1-ardb@kernel.org>
References: <20200222155519.23550-1-ardb@kernel.org>
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
index 0de57151c732..cdcf48d52a12 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -270,6 +270,11 @@ static inline void *efi64_zero_upper(void *p)
 	return p;
 }
 
+static inline u32 efi64_convert_status(efi_status_t status)
+{
+	return (u32)(status | (u64)status >> 32);
+}
+
 #define __efi64_argmap_free_pages(addr, size)				\
 	((addr), 0, (size))
 
@@ -288,6 +293,9 @@ static inline void *efi64_zero_upper(void *p)
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

