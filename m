Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F535296E33
	for <lists+linux-efi@lfdr.de>; Fri, 23 Oct 2020 14:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463439AbgJWMIi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 23 Oct 2020 08:08:38 -0400
Received: from foss.arm.com ([217.140.110.172]:50748 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S463277AbgJWMIi (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 23 Oct 2020 08:08:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23E43143D;
        Fri, 23 Oct 2020 05:08:37 -0700 (PDT)
Received: from e123331-lin.nice.arm.com (unknown [10.37.8.102])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB6953F66B;
        Fri, 23 Oct 2020 05:08:35 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@arm.com>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@arm.com>, grub-devel@gnu.org,
        daniel.kiper@oracle.com, leif@nuviainc.com
Subject: [PATCH 3/4] efi: implemented LoadFile2 initr loading protocol for Linux
Date:   Fri, 23 Oct 2020 14:08:24 +0200
Message-Id: <20201023120825.30466-4-ard.biesheuvel@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201023120825.30466-1-ard.biesheuvel@arm.com>
References: <20201023120825.30466-1-ard.biesheuvel@arm.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Recent Linux kernels will invoke the LoadFile2 protocol installed on
a well-known vendor media path to load the initrd if it is exposed by
the firmware. Using this method is preferred for two reasons:
- the Linux kernel is in charge of allocating the memory, and so it can
  implement any placement policy it wants (given that these tend to
  change between kernel versions),
- it is no longer necessary to modify the device tree provided by the
  firmware.

So let's install this protocol when handling the 'initrd' command if
such a recent kernel was detected (based on the PE/COFF image version),
and defer loading the initrd contents until the point where the kernel
invokes the LoadFile2 protocol.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@arm.com>
---
 grub-core/loader/arm64/linux.c | 117 +++++++++++++++++++-
 1 file changed, 116 insertions(+), 1 deletion(-)

diff --git a/grub-core/loader/arm64/linux.c b/grub-core/loader/arm64/linux.c
index ef3e9f9444ca..285422c7bd43 100644
--- a/grub-core/loader/arm64/linux.c
+++ b/grub-core/loader/arm64/linux.c
@@ -48,9 +48,16 @@ static grub_uint32_t cmdline_size;
 static grub_addr_t initrd_start;
 static grub_addr_t initrd_end;
 
+static struct grub_linux_initrd_context initrd_ctx = { 0, 0, 0 };
+static grub_efi_handle_t initrd_lf2_handle;
+static int initrd_use_loadfile2;
+
 grub_err_t
 grub_arch_efi_linux_check_image (struct linux_arch_kernel_header * lh)
 {
+  struct grub_pe32_coff_header *coff_header;
+  struct grub_pe32_optional_header *optional_header;
+
   if (lh->magic != GRUB_LINUX_ARMXX_MAGIC_SIGNATURE)
     return grub_error(GRUB_ERR_BAD_OS, "invalid magic number");
 
@@ -61,6 +68,21 @@ grub_arch_efi_linux_check_image (struct linux_arch_kernel_header * lh)
   grub_dprintf ("linux", "UEFI stub kernel:\n");
   grub_dprintf ("linux", "PE/COFF header @ %08x\n", lh->hdr_offset);
 
+  coff_header = (struct grub_pe32_coff_header *)((unsigned long)lh + lh->hdr_offset);
+  optional_header = (struct grub_pe32_optional_header *)(coff_header + 1);
+
+  /*
+   * Linux kernels built for any architecture are guaranteed to support the
+   * LoadFile2 based initrd loading protocol if the image version is >= 1.
+   */
+  if (optional_header->major_image_version >= 1)
+    initrd_use_loadfile2 = 1;
+   else
+    initrd_use_loadfile2 = 0;
+
+  grub_dprintf ("linux", "LoadFile2 initrd loading %sabled\n",
+		initrd_use_loadfile2 ? "en" : "dis");
+
   return GRUB_ERR_NONE;
 }
 
@@ -230,13 +252,88 @@ allocate_initrd_mem (int initrd_pages)
 				       GRUB_EFI_LOADER_DATA);
 }
 
+struct initrd_media_device_path {
+  grub_efi_vendor_media_device_path_t	vendor;
+  grub_efi_device_path_t		end;
+} GRUB_PACKED;
+
+#define LINUX_EFI_INITRD_MEDIA_GUID  \
+  { 0x5568e427, 0x68fc, 0x4f3d, \
+    { 0xac, 0x74, 0xca, 0x55, 0x52, 0x31, 0xcc, 0x68 } \
+  }
+
+static struct initrd_media_device_path initrd_lf2_device_path = {
+  {
+    {
+      GRUB_EFI_MEDIA_DEVICE_PATH_TYPE,
+      GRUB_EFI_VENDOR_MEDIA_DEVICE_PATH_SUBTYPE,
+      sizeof(grub_efi_vendor_media_device_path_t),
+    },
+    LINUX_EFI_INITRD_MEDIA_GUID
+  }, {
+    GRUB_EFI_END_DEVICE_PATH_TYPE,
+    GRUB_EFI_END_ENTIRE_DEVICE_PATH_SUBTYPE,
+    sizeof(grub_efi_device_path_t)
+  }
+};
+
+static grub_efi_status_t
+grub_efi_initrd_load_file2(grub_efi_load_file2_t *this,
+                           grub_efi_device_path_t *device_path,
+                           grub_efi_boolean_t boot_policy,
+                           grub_efi_uintn_t *buffer_size,
+                           void *buffer);
+
+static grub_efi_load_file2_t initrd_lf2 = {
+  grub_efi_initrd_load_file2
+};
+
+static grub_efi_status_t
+grub_efi_initrd_load_file2(grub_efi_load_file2_t *this,
+			   grub_efi_device_path_t *device_path,
+			   grub_efi_boolean_t boot_policy,
+			   grub_efi_uintn_t *buffer_size,
+			   void *buffer)
+{
+  grub_efi_status_t status = GRUB_EFI_SUCCESS;
+  grub_efi_uintn_t initrd_size;
+
+  if (!this || this != &initrd_lf2 || !buffer_size)
+    return GRUB_EFI_INVALID_PARAMETER;
+
+  if (device_path->type != GRUB_EFI_END_DEVICE_PATH_TYPE ||
+      device_path->subtype != GRUB_EFI_END_ENTIRE_DEVICE_PATH_SUBTYPE)
+    return GRUB_EFI_NOT_FOUND;
+
+  if (boot_policy)
+    return GRUB_EFI_UNSUPPORTED;
+
+  initrd_size = grub_get_initrd_size (&initrd_ctx);
+  if (!buffer || *buffer_size < initrd_size)
+    {
+      *buffer_size = initrd_size;
+      return GRUB_EFI_BUFFER_TOO_SMALL;
+    }
+
+  grub_dprintf ("linux", "Loading initrd via LOAD_FILE2_PROTOCOL\n");
+
+  if (grub_initrd_load (&initrd_ctx, NULL, buffer))
+    status = GRUB_EFI_LOAD_ERROR;
+
+  grub_initrd_close (&initrd_ctx);
+  return status;
+}
+
 static grub_err_t
 grub_cmd_initrd (grub_command_t cmd __attribute__ ((unused)),
 		 int argc, char *argv[])
 {
-  struct grub_linux_initrd_context initrd_ctx = { 0, 0, 0 };
   int initrd_size, initrd_pages;
   void *initrd_mem = NULL;
+  grub_efi_guid_t load_file2_guid = GRUB_EFI_LOAD_FILE2_PROTOCOL_GUID;
+  grub_efi_guid_t device_path_guid = GRUB_EFI_DEVICE_PATH_GUID;
+  grub_efi_boot_services_t *b;
+  grub_efi_status_t status;
 
   if (argc == 0)
     {
@@ -254,6 +351,24 @@ grub_cmd_initrd (grub_command_t cmd __attribute__ ((unused)),
   if (grub_initrd_init (argc, argv, &initrd_ctx))
     goto fail;
 
+  if (initrd_use_loadfile2 && !initrd_lf2_handle)
+    {
+      b = grub_efi_system_table->boot_services;
+      status = b->install_multiple_protocol_interfaces (&initrd_lf2_handle,
+							&load_file2_guid,
+							&initrd_lf2,
+							&device_path_guid,
+							&initrd_lf2_device_path,
+							NULL);
+      if (status == GRUB_EFI_OUT_OF_RESOURCES)
+        {
+	  grub_error (GRUB_ERR_OUT_OF_MEMORY, N_("out of memory"));
+	  return grub_errno;
+	}
+      grub_dprintf ("linux", "LoadFile2 initrd loading protocol installed\n");
+      return GRUB_ERR_NONE;
+    }
+
   initrd_size = grub_get_initrd_size (&initrd_ctx);
   grub_dprintf ("linux", "Loading initrd\n");
 
-- 
2.17.1

