Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486B859806E
	for <lists+linux-efi@lfdr.de>; Thu, 18 Aug 2022 10:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbiHRI4M (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Aug 2022 04:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243591AbiHRI4K (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 Aug 2022 04:56:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7B5B07F6
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 01:56:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25D7F61313
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 08:56:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE8FC43140;
        Thu, 18 Aug 2022 08:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660812968;
        bh=E4aJPGS29hqrXtOm2Rk8yZNBA1ShxPq6XnAQv0Yzdgo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pGjOnN8PI/DBiZRpR0DFQSN3Tc6TFo8n7RiLBcsksYTKIlDsSKQHdq9mQweHetldU
         BgPYEOdv5Y8gidQS/J+Yq0K/XLdh0LR6mOLrB0dLy4rMl/jugvGiVJtmI26+6VLVDg
         m8wH7YNeBosKbcfwwIfhioeVHLpQKUQpyTsvg1Oj6p0I6zpNZf4Dw68WqCOwZE+Moy
         WqbGDyFFkWYnzOtPyxIFtN8KFNxiinytVXOEdiRujeNoaCVVGb3Jy164SaKZ8v7WIB
         U0uB7s/yEosGWYivVrOBWMfq3fbzGSgZ0q2RETPFGY8ab9NshbbacVPRximJzxFpMk
         S7qZsjNmMwcyQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     grub-devel@nongnu.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        grub-devel@gnu.org, Daniel Kiper <daniel.kiper@oracle.com>,
        Nikita Ermakov <arei@altlinux.org>,
        Atish Patra <atishp@atishpatra.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        dann frazier <dann.frazier@canonical.com>,
        Julian Andres Klode <julian.klode@canonical.com>
Subject: [PATCH resend 8/9] efi: implement LoadFile2 initrd loading protocol for Linux
Date:   Thu, 18 Aug 2022 10:55:38 +0200
Message-Id: <20220818085540.2075028-9-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220818085540.2075028-1-ardb@kernel.org>
References: <20220818085540.2075028-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7202; i=ardb@kernel.org; h=from:subject; bh=E4aJPGS29hqrXtOm2Rk8yZNBA1ShxPq6XnAQv0Yzdgo=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBi/f6Hzl0gppHvBOfmhXqtA5gFYm+ewwTuCZwrrFvz zuPY55SJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYv3+hwAKCRDDTyI5ktmPJHIRC/ 0Zdod2xED5yDq3AmetnuExsEacDpDuIlX1tgQoJjIVUehQeCMopwYHl5SgopAk7ep2u9iAqpSGPQOb D04IQOEPe5FQdkt1XpvwS4Vu0fkc5HW4GgMWfW5irXSoBlD7tDhpZKYwFLDhwKQJGQzmnX8d8i3Wct 1pS+xMIV82alG0c9Xwtz6KOjcwyHtDEk8B92c6AWh2W9xVdDq1MGMcNyxf0pEZvq1DHTB4ZN5dQfAT swhv7Nc4zf5ky2e0EChG50WW05u+HnbUouC0ES2R623u5173YWIjZZ9eq+zsuFDF6x71JdpXzmb6Og K+5ti/HaVwa32eF5i1b4JsHA62NTmgj18BDRas3939yUCCYnmxdGLCZ2HIHoZOWMa/jxn1s9tsRI9W k2AOMLAMwioKTOocL5bREv+OCFw0b9lP81NHQVKdFBjrJNE7qFmjzn6KBNXqzRb4rKl4dp/srwnX5v HsY155z4pgqNrYpR5OS0t1qTJLpo6wH6TpsAfNMca/9uA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 grub-core/loader/arm64/linux.c | 129 +++++++++++++++++++-
 1 file changed, 128 insertions(+), 1 deletion(-)

diff --git a/grub-core/loader/arm64/linux.c b/grub-core/loader/arm64/linux.c
index 56ba8d0a6ea3..82c7558b4c4c 100644
--- a/grub-core/loader/arm64/linux.c
+++ b/grub-core/loader/arm64/linux.c
@@ -48,6 +48,48 @@ static grub_uint32_t cmdline_size;
 static grub_addr_t initrd_start;
 static grub_addr_t initrd_end;
 
+static grub_efi_guid_t load_file2_guid = GRUB_EFI_LOAD_FILE2_PROTOCOL_GUID;
+static grub_efi_guid_t device_path_guid = GRUB_EFI_DEVICE_PATH_GUID;
+static struct grub_linux_initrd_context initrd_ctx = { 0, 0, 0 };
+static grub_efi_handle_t initrd_lf2_handle;
+static int initrd_use_loadfile2;
+
+struct initrd_media_device_path {
+  grub_efi_vendor_media_device_path_t  vendor;
+  grub_efi_device_path_t               end;
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
 grub_err_t
 grub_arch_efi_linux_load_image_header (grub_file_t file,
                                       struct linux_arch_kernel_header * lh)
@@ -78,6 +120,18 @@ grub_arch_efi_linux_load_image_header (grub_file_t file,
        return grub_error(GRUB_ERR_FILE_READ_ERROR, "failed to read COFF image header");
     }
 
+  /*
+   * Linux kernels built for any architecture are guaranteed to support the
+   * LoadFile2 based initrd loading protocol if the image version is >= 1.
+   */
+  if (lh->coff_image_header.optional_header.major_image_version >= 1)
+    initrd_use_loadfile2 = 1;
+   else
+    initrd_use_loadfile2 = 0;
+
+  grub_dprintf ("linux", "LoadFile2 initrd loading %sabled\n",
+                initrd_use_loadfile2 ? "en" : "dis");
+
   return GRUB_ERR_NONE;
 }
 
@@ -197,6 +251,8 @@ grub_linux_boot (void)
 static grub_err_t
 grub_linux_unload (void)
 {
+  grub_efi_boot_services_t *b;
+
   grub_dl_unref (my_mod);
   loaded = 0;
   if (initrd_start)
@@ -208,6 +264,19 @@ grub_linux_unload (void)
     grub_efi_free_pages ((grub_addr_t) kernel_addr,
 			 GRUB_EFI_BYTES_TO_PAGES (kernel_size));
   grub_fdt_unload ();
+
+  if (initrd_lf2_handle)
+    {
+      b = grub_efi_system_table->boot_services;
+      b->uninstall_multiple_protocol_interfaces (initrd_lf2_handle,
+                                                 &load_file2_guid,
+                                                 &initrd_lf2,
+                                                 &device_path_guid,
+                                                 &initrd_lf2_device_path,
+                                                 NULL);
+      initrd_lf2_handle = NULL;
+      initrd_use_loadfile2 = 0;
+    }
   return GRUB_ERR_NONE;
 }
 
@@ -247,13 +316,50 @@ allocate_initrd_mem (int initrd_pages)
 				       GRUB_EFI_LOADER_DATA);
 }
 
+static grub_efi_status_t
+grub_efi_initrd_load_file2(grub_efi_load_file2_t *this,
+                          grub_efi_device_path_t *device_path,
+                          grub_efi_boolean_t boot_policy,
+                          grub_efi_uintn_t *buffer_size,
+                          void *buffer)
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
+  grub_dprintf ("linux", "Providing initrd via LOAD_FILE2_PROTOCOL\n");
+
+  if (grub_initrd_load (&initrd_ctx, buffer))
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
+  grub_efi_boot_services_t *b;
+  grub_efi_status_t status;
 
   if (argc == 0)
     {
@@ -271,6 +377,27 @@ grub_cmd_initrd (grub_command_t cmd __attribute__ ((unused)),
   if (grub_initrd_init (argc, argv, &initrd_ctx))
     goto fail;
 
+  if (initrd_use_loadfile2)
+    {
+      if (!initrd_lf2_handle)
+        {
+          b = grub_efi_system_table->boot_services;
+          status = b->install_multiple_protocol_interfaces (&initrd_lf2_handle,
+                                                            &load_file2_guid,
+                                                            &initrd_lf2,
+                                                            &device_path_guid,
+                                                            &initrd_lf2_device_path,
+                                                            NULL);
+          if (status == GRUB_EFI_OUT_OF_RESOURCES)
+            {
+              grub_error (GRUB_ERR_OUT_OF_MEMORY, N_("out of memory"));
+              return grub_errno;
+            }
+        }
+      grub_dprintf ("linux", "Using LoadFile2 initrd loading protocol\n");
+      return GRUB_ERR_NONE;
+    }
+
   initrd_size = grub_get_initrd_size (&initrd_ctx);
   grub_dprintf ("linux", "Loading initrd\n");
 
-- 
2.35.1

