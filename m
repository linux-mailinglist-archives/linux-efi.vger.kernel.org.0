Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A9B2981F4
	for <lists+linux-efi@lfdr.de>; Sun, 25 Oct 2020 14:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416430AbgJYNuB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 25 Oct 2020 09:50:01 -0400
Received: from foss.arm.com ([217.140.110.172]:46324 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416426AbgJYNuA (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 25 Oct 2020 09:50:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E3FA12FC;
        Sun, 25 Oct 2020 06:50:00 -0700 (PDT)
Received: from e123331-lin.nice.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF1383F68F;
        Sun, 25 Oct 2020 06:49:58 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@arm.com>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@arm.com>, grub-devel@gnu.org,
        daniel.kiper@oracle.com, leif@nuviainc.com
Subject: [PATCH v2 4/8] linux/arm: unify ARM/arm64 vs Xen PE/COFF header handling
Date:   Sun, 25 Oct 2020 14:49:37 +0100
Message-Id: <20201025134941.4805-5-ard.biesheuvel@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201025134941.4805-1-ard.biesheuvel@arm.com>
References: <20201025134941.4805-1-ard.biesheuvel@arm.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Xen has its own version of the image header, to account for the
additional PE/COFF header fields. Since we are adding references to
those in the shared EFI loader code, update the common definitions
and drop the Xen specific one which no longer has a purpose.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@arm.com>
---
 grub-core/loader/arm64/linux.c    | 12 +++++-----
 grub-core/loader/arm64/xen_boot.c | 23 ++++----------------
 include/grub/arm/linux.h          |  6 +++++
 include/grub/arm64/linux.h        |  4 ++++
 include/grub/efi/efi.h            |  4 +++-
 5 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/grub-core/loader/arm64/linux.c b/grub-core/loader/arm64/linux.c
index ef3e9f9444ca..915b6ad7292d 100644
--- a/grub-core/loader/arm64/linux.c
+++ b/grub-core/loader/arm64/linux.c
@@ -49,8 +49,13 @@ static grub_addr_t initrd_start;
 static grub_addr_t initrd_end;
 
 grub_err_t
-grub_arch_efi_linux_check_image (struct linux_arch_kernel_header * lh)
+grub_arch_efi_linux_load_image_header (grub_file_t file,
+				       struct linux_arch_kernel_header * lh)
 {
+  grub_file_seek (file, 0);
+  if (grub_file_read (file, lh, sizeof (*lh)) < (long) sizeof (*lh))
+    return grub_error(GRUB_ERR_FILE_READ_ERROR, "failed to read Linux image header");
+
   if (lh->magic != GRUB_LINUX_ARMXX_MAGIC_SIGNATURE)
     return grub_error(GRUB_ERR_BAD_OS, "invalid magic number");
 
@@ -304,10 +309,7 @@ grub_cmd_linux (grub_command_t cmd __attribute__ ((unused)),
 
   kernel_size = grub_file_size (file);
 
-  if (grub_file_read (file, &lh, sizeof (lh)) < (long) sizeof (lh))
-    return grub_errno;
-
-  if (grub_arch_efi_linux_check_image (&lh) != GRUB_ERR_NONE)
+  if (grub_arch_efi_linux_load_image_header (file, &lh) != GRUB_ERR_NONE)
     goto fail;
 
   grub_loader_unset();
diff --git a/grub-core/loader/arm64/xen_boot.c b/grub-core/loader/arm64/xen_boot.c
index 22cc25eccd9d..e5895ee78218 100644
--- a/grub-core/loader/arm64/xen_boot.c
+++ b/grub-core/loader/arm64/xen_boot.c
@@ -31,7 +31,6 @@
 #include <grub/efi/efi.h>
 #include <grub/efi/fdtload.h>
 #include <grub/efi/memory.h>
-#include <grub/efi/pe32.h>	/* required by struct xen_hypervisor_header */
 #include <grub/i18n.h>
 #include <grub/lib/cmdline.h>
 
@@ -65,18 +64,6 @@ enum module_type
 };
 typedef enum module_type module_type_t;
 
-struct xen_hypervisor_header
-{
-  struct linux_arm64_kernel_header efi_head;
-
-  /* This is always PE\0\0.  */
-  grub_uint8_t signature[GRUB_PE32_SIGNATURE_SIZE];
-  /* The COFF file header.  */
-  struct grub_pe32_coff_header coff_header;
-  /* The Optional header.  */
-  struct grub_pe64_optional_header optional_header;
-};
-
 struct xen_boot_binary
 {
   struct xen_boot_binary *next;
@@ -452,7 +439,7 @@ static grub_err_t
 grub_cmd_xen_hypervisor (grub_command_t cmd __attribute__ ((unused)),
 			 int argc, char *argv[])
 {
-  struct xen_hypervisor_header sh;
+  struct linux_arm64_kernel_header lh;
   grub_file_t file = NULL;
 
   grub_dl_ref (my_mod);
@@ -467,10 +454,7 @@ grub_cmd_xen_hypervisor (grub_command_t cmd __attribute__ ((unused)),
   if (!file)
     goto fail;
 
-  if (grub_file_read (file, &sh, sizeof (sh)) != (long) sizeof (sh))
-    goto fail;
-  if (grub_arch_efi_linux_check_image
-      ((struct linux_arch_kernel_header *) &sh) != GRUB_ERR_NONE)
+  if (grub_arch_efi_linux_load_image_header (file, &lh) != GRUB_ERR_NONE)
     goto fail;
   grub_file_seek (file, 0);
 
@@ -484,7 +468,8 @@ grub_cmd_xen_hypervisor (grub_command_t cmd __attribute__ ((unused)),
     return grub_errno;
 
   xen_hypervisor->is_hypervisor = 1;
-  xen_hypervisor->align = (grub_size_t) sh.optional_header.section_alignment;
+  xen_hypervisor->align
+    = (grub_size_t) lh.coff_image_header.optional_header.section_alignment;
 
   xen_boot_binary_load (xen_hypervisor, file, argc, argv);
   if (grub_errno == GRUB_ERR_NONE)
diff --git a/include/grub/arm/linux.h b/include/grub/arm/linux.h
index bcd5a7eb186e..ea815db13417 100644
--- a/include/grub/arm/linux.h
+++ b/include/grub/arm/linux.h
@@ -22,6 +22,8 @@
 
 #include "system.h"
 
+#include <grub/efi/pe32.h>
+
 #define GRUB_LINUX_ARM_MAGIC_SIGNATURE 0x016f2818
 
 struct linux_arm_kernel_header {
@@ -32,6 +34,10 @@ struct linux_arm_kernel_header {
   grub_uint32_t end;   /* _edata */
   grub_uint32_t reserved2[3];
   grub_uint32_t hdr_offset;
+
+#if defined GRUB_MACHINE_EFI
+  struct grub_coff_image_header coff_image_header;
+#endif
 };
 
 #if defined(__arm__)
diff --git a/include/grub/arm64/linux.h b/include/grub/arm64/linux.h
index 4269adc6dae5..e5a7ed3749d1 100644
--- a/include/grub/arm64/linux.h
+++ b/include/grub/arm64/linux.h
@@ -19,6 +19,8 @@
 #ifndef GRUB_ARM64_LINUX_HEADER
 #define GRUB_ARM64_LINUX_HEADER 1
 
+#include <grub/efi/pe32.h>
+
 #define GRUB_LINUX_ARM64_MAGIC_SIGNATURE 0x644d5241 /* 'ARM\x64' */
 
 /* From linux/Documentation/arm64/booting.txt */
@@ -34,6 +36,8 @@ struct linux_arm64_kernel_header
   grub_uint64_t res4;		/* reserved */
   grub_uint32_t magic;		/* Magic number, little endian, "ARM\x64" */
   grub_uint32_t hdr_offset;	/* Offset of PE/COFF header */
+
+  struct grub_coff_image_header	coff_image_header;
 };
 
 #if defined(__aarch64__)
diff --git a/include/grub/efi/efi.h b/include/grub/efi/efi.h
index e90e00dc431b..93cb2f5bc732 100644
--- a/include/grub/efi/efi.h
+++ b/include/grub/efi/efi.h
@@ -94,7 +94,9 @@ extern void (*EXPORT_VAR(grub_efi_net_config)) (grub_efi_handle_t hnd,
 void *EXPORT_FUNC(grub_efi_get_firmware_fdt)(void);
 grub_err_t EXPORT_FUNC(grub_efi_get_ram_base)(grub_addr_t *);
 #include <grub/cpu/linux.h>
-grub_err_t grub_arch_efi_linux_check_image(struct linux_arch_kernel_header *lh);
+#include <grub/file.h>
+grub_err_t grub_arch_efi_linux_load_image_header(grub_file_t file,
+					         struct linux_arch_kernel_header *lh);
 grub_err_t grub_arch_efi_linux_boot_image(grub_addr_t addr, grub_size_t size,
                                            char *args);
 #endif
-- 
2.17.1

