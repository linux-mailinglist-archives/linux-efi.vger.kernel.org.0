Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D980146FBA
	for <lists+linux-efi@lfdr.de>; Thu, 23 Jan 2020 18:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAWRbB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 23 Jan 2020 12:31:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:49692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728792AbgAWRbB (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 23 Jan 2020 12:31:01 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E0D021569;
        Thu, 23 Jan 2020 17:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579800660;
        bh=+YI2M5SKhBJCFLqZih6bihD47cYXJn9nHejxv31f9Aw=;
        h=From:To:Cc:Subject:Date:From;
        b=spHTo4vc8ITV13ltK7QTZTF1lyK01rmVXX1JwueWTWpEo+UbNwbIYkfYYo3eiGYIr
         5JkyALWZ4Gi0ohohsYf5FF4O07UTC1N45OWbI2yj9x3NPUSA0VmBW9+aAKkWpdaU+7
         MM42stgtqZPgLrM/IOc08ypllTmpsqZX8ttI994I=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     leif.lindholm@linaro.org, daniel.kiper@oracle.com,
        mjg59@google.com, Ard Biesheuvel <ardb@kernel.org>
Subject: [RFC PATCH] efi/libstub/x86: look for bootparams when booting via PE entry point
Date:   Thu, 23 Jan 2020 18:30:47 +0100
Message-Id: <20200123173047.18409-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

There are currently a couple of different ways the Linux kernel can be
booted on UEFI x86 systems:
1) legacy boot - the bootloader jumps straight into the first byte of the
   kernel image after taking down the UEFI boot services and populating a
   bootparams structure with the required information
2) PE entry point - the kernel is booted as an ordinary PE/COFF executable,
   using the loadimage and startimage boot services, and it is left to the
   boot stub to allocate and populate a bootparams structure
3) EFI handover protocol - the kernel is copied into memory and the loader
   jumps into it at a fixed offset, providing a bootparams structure but
   with the EFI boot services still active.

Option #3 is the option preferred by the distros today, since it allows
the bootloader to populate and pass the bootparams structure directly,
which enables things like initrd images loaded from any filesystem (as
opposed to option #2, which requires the kernel's boot stub to load the
initrd but it only supports loading images from the same volume that the
kernel image was loaded from). Option #3 also supports loading 32-bit
kernels on 64-bit firmware and vice versa.

However, option #2 is a more seamless match, given that it uses the
firmware's standard loading facilities, which is also what EFI secure
boot authentication checks are based on.

So let's provide a way for option #2 to be used in combination with a
bootloader provided bootparams structure, by specifying a special protocol
GUID for it, and looking for it on the image handle when entering via the
ordinary PE/COFF entry point. This allows a loader to call LoadImage,
install the new protocol on the resulting handle and invoke the kernel via
StartImage, and thus rely on the authentication performed by those boot
services if secure boot is enabled.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/eboot.c | 8 ++++++++
 arch/x86/boot/header.S           | 2 +-
 include/linux/efi.h              | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 82e26d0ff075..b74c4b18dc20 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -362,6 +362,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	struct setup_header *hdr;
 	efi_loaded_image_t *image;
 	efi_guid_t proto = LOADED_IMAGE_PROTOCOL_GUID;
+	efi_guid_t bp_proto = LINUX_EFI_X86_BOOTPARAMS_PROTOCOL_GUID;
 	int options_size = 0;
 	efi_status_t status;
 	char *cmdline_ptr;
@@ -374,6 +375,13 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	if (sys_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
 		return EFI_INVALID_PARAMETER;
 
+	status = efi_bs_call(handle_protocol, handle, &bp_proto,
+			     (void **)&boot_params);
+	if (status == EFI_SUCCESS) {
+		efi_stub_entry(handle, sys_table, boot_params);
+		/* not reached */
+	}
+
 	status = efi_bs_call(handle_protocol, handle, &proto, (void *)&image);
 	if (status != EFI_SUCCESS) {
 		efi_printk("Failed to get handle for LOADED_IMAGE_PROTOCOL\n");
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 97d9b6d6c1af..2b5d4d181df1 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -300,7 +300,7 @@ _start:
 	# Part 2 of the header, from the old setup.S
 
 		.ascii	"HdrS"		# header signature
-		.word	0x020f		# header version number (>= 0x0105)
+		.word	0x0210		# header version number (>= 0x0105)
 					# or else old loadlin-1.5 will fail)
 		.globl realmode_swtch
 realmode_swtch:	.word	0, 0		# default_switch, SETUPSEG
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 4169e9d0d699..fd381ebce127 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -666,6 +666,7 @@ void efi_native_runtime_setup(void);
 #define LINUX_EFI_TPM_EVENT_LOG_GUID		EFI_GUID(0xb7799cb0, 0xeca2, 0x4943,  0x96, 0x67, 0x1f, 0xae, 0x07, 0xb7, 0x47, 0xfa)
 #define LINUX_EFI_TPM_FINAL_LOG_GUID		EFI_GUID(0x1e2ed096, 0x30e2, 0x4254,  0xbd, 0x89, 0x86, 0x3b, 0xbe, 0xf8, 0x23, 0x25)
 #define LINUX_EFI_MEMRESERVE_TABLE_GUID		EFI_GUID(0x888eb0c6, 0x8ede, 0x4ff5,  0xa8, 0xf0, 0x9a, 0xee, 0x5c, 0xb9, 0x77, 0xc2)
+#define LINUX_EFI_X86_BOOTPARAMS_PROTOCOL_GUID	EFI_GUID(0xa50da594, 0x048d, 0x4296,  0xb2, 0xe1, 0xce, 0xc7, 0xb4, 0xf5, 0x79, 0x13)
 
 /* OEM GUIDs */
 #define DELLEMC_EFI_RCI2_TABLE_GUID		EFI_GUID(0x2d9f28a2, 0xa886, 0x456a,  0x97, 0xa8, 0xf1, 0x1e, 0xf2, 0x4f, 0xf4, 0x55)
-- 
2.17.1

