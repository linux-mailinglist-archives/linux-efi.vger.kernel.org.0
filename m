Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F20E2981F8
	for <lists+linux-efi@lfdr.de>; Sun, 25 Oct 2020 14:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416434AbgJYNuG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 25 Oct 2020 09:50:06 -0400
Received: from foss.arm.com ([217.140.110.172]:46358 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416433AbgJYNuG (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 25 Oct 2020 09:50:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B428B12FC;
        Sun, 25 Oct 2020 06:50:05 -0700 (PDT)
Received: from e123331-lin.nice.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A0023F68F;
        Sun, 25 Oct 2020 06:50:04 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@arm.com>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@arm.com>, grub-devel@gnu.org,
        daniel.kiper@oracle.com, leif@nuviainc.com
Subject: [PATCH v2 8/8] linux: ignore FDT unless we need to modify it
Date:   Sun, 25 Oct 2020 14:49:41 +0100
Message-Id: <20201025134941.4805-9-ard.biesheuvel@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201025134941.4805-1-ard.biesheuvel@arm.com>
References: <20201025134941.4805-1-ard.biesheuvel@arm.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Now that we implemented support for the LoadFile2 protocol for initrd
loading, there is no longer a need to pass the initrd parameters via
the device tree. This means there is no longer a reason to update the
device tree in the first place, and so we can ignore it entirely.

The only remaining reason to deal with the devicetree is if we are
using the 'devicetree' command to load one from disk, so tweak the
logic in grub_fdt_install() to take that into account.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@arm.com>
Reviewed-by: Leif Lindholm <leif@nuviainc.com>
---
 grub-core/loader/arm64/linux.c | 22 ++++++++++----------
 grub-core/loader/efi/fdt.c     |  7 +++++--
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/grub-core/loader/arm64/linux.c b/grub-core/loader/arm64/linux.c
index c6a95e1f0c43..248277c753b6 100644
--- a/grub-core/loader/arm64/linux.c
+++ b/grub-core/loader/arm64/linux.c
@@ -107,21 +107,21 @@ finalize_params_linux (void)
 
   void *fdt;
 
-  fdt = grub_fdt_load (GRUB_EFI_LINUX_FDT_EXTRA_SPACE);
+  /* Set initrd info */
+  if (initrd_start && initrd_end > initrd_start)
+    {
+      fdt = grub_fdt_load (GRUB_EFI_LINUX_FDT_EXTRA_SPACE);
 
-  if (!fdt)
-    goto failure;
+      if (!fdt)
+	goto failure;
 
-  node = grub_fdt_find_subnode (fdt, 0, "chosen");
-  if (node < 0)
-    node = grub_fdt_add_subnode (fdt, 0, "chosen");
+      node = grub_fdt_find_subnode (fdt, 0, "chosen");
+      if (node < 0)
+	node = grub_fdt_add_subnode (fdt, 0, "chosen");
 
-  if (node < 1)
-    goto failure;
+      if (node < 1)
+	goto failure;
 
-  /* Set initrd info */
-  if (initrd_start && initrd_end > initrd_start)
-    {
       grub_dprintf ("linux", "Initrd @ %p-%p\n",
 		    (void *) initrd_start, (void *) initrd_end);
 
diff --git a/grub-core/loader/efi/fdt.c b/grub-core/loader/efi/fdt.c
index ee9c5592c700..ab900b27d927 100644
--- a/grub-core/loader/efi/fdt.c
+++ b/grub-core/loader/efi/fdt.c
@@ -85,13 +85,16 @@ grub_fdt_install (void)
   grub_efi_guid_t fdt_guid = GRUB_EFI_DEVICE_TREE_GUID;
   grub_efi_status_t status;
 
+  if (!fdt && !loaded_fdt)
+    return GRUB_ERR_NONE;
+
   b = grub_efi_system_table->boot_services;
-  status = b->install_configuration_table (&fdt_guid, fdt);
+  status = b->install_configuration_table (&fdt_guid, fdt ?: loaded_fdt);
   if (status != GRUB_EFI_SUCCESS)
     return grub_error (GRUB_ERR_IO, "failed to install FDT");
 
   grub_dprintf ("fdt", "Installed/updated FDT configuration table @ %p\n",
-		fdt);
+		fdt ?: loaded_fdt);
   return GRUB_ERR_NONE;
 }
 
-- 
2.17.1

