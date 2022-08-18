Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E28159806A
	for <lists+linux-efi@lfdr.de>; Thu, 18 Aug 2022 10:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243513AbiHRI4B (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Aug 2022 04:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbiHRIz7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 Aug 2022 04:55:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD90EB07DA
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 01:55:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AECE6122E
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 08:55:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1538C433B5;
        Thu, 18 Aug 2022 08:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660812957;
        bh=J6A6dWdEir0BbOuEt8vCg3aRhfPyn7L5Yj1djqNZlsA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KjCuPZf4J5/nnlemCbYp8mgMUz8uD+EV5HYL5aK+43M1wsQ0lipqnA0YIDPZjuxxS
         pgJt/KaarhH2NzR5jzo1LAiSa1FNS3QvQzP2n2vqICAd4TK10hEepw7zT1T7oceZJL
         CVdZutq2UZwz2pukIr6ikgtHKigX6eo9mbvoSlPlOxEbUTERK6A95wVv0nlrgwYoHV
         rtdb6kjxwuFJc0RKrSpKE38pwhAoeR3ViTZ7phbSwSOmv1TxIM4ZFEUQ/srQ30yqPT
         I94btamKNWEvbu+bCcGTdOgmMHcliWI0nZIUIgzZzb5a83w40dkYIhAXTlpolkC4jR
         f7It0EvozG3Og==
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
Subject: [PATCH resend 4/9] linux/arm: unify ARM/arm64 vs Xen PE/COFF header handling
Date:   Thu, 18 Aug 2022 10:55:34 +0200
Message-Id: <20220818085540.2075028-5-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220818085540.2075028-1-ardb@kernel.org>
References: <20220818085540.2075028-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6213; i=ardb@kernel.org; h=from:subject; bh=J6A6dWdEir0BbOuEt8vCg3aRhfPyn7L5Yj1djqNZlsA=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBi/f5/oTrcSD5ck8E6gpLDjyV5xGj4YdLIU0Fu32o3 QlY1JCiJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYv3+fwAKCRDDTyI5ktmPJM4tC/ oDdU9LA9WkkPVjZPNFNF1I+luM7QhEq+k6nSZoDzfD32pXV7L9aZefPT1hh8xldREmF7vv9H/cg2N5 aWF1y2B1AAWev0IXGFdWsee0svEEkBXGfjOwEpbPhO/tsNOl0ES0qnpIc09HycQCdr5kaXEemedgl5 tfn8Ey/FsaF3yEH06s+O/FagOC7o97d1+NDLJSUluiNCgnUmbCmbTnTKCpOSju6S3maAsIjD6c05XS zuZHKYNG13BUtcoaHs4Xa2wp4s7xYz7/q1NcjQ44coEs+CCEckBjl/UrRcy1o1O0QPV5z1NEOqQoH3 O5/KnXOpPyqh4jXm6a8adxtY2vbk0DZD2Qu4RsK9M8KrnSowS7mlOQGeH+6+PbvM30WWDE03OUx69c NMdon4AXJ2O+pkboY6czOjwjFQvUv5L+K5Yqmr9WdqSQRyfqR1zDp76WHoM25JoFGbl3ovoYTI8OkN au0lqvNg+IIbe533IhcFYmiIy2KBmdMMoNbqzPEl4HPKk=
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

Xen has its own version of the image header, to account for the
additional PE/COFF header fields. Since we are adding references to
those in the shared EFI loader code, update the common definitions
and drop the Xen specific one which no longer has a purpose.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 grub-core/loader/arm64/linux.c    | 12 +++++-----
 grub-core/loader/arm64/xen_boot.c | 23 ++++----------------
 include/grub/arm/linux.h          |  6 +++++
 include/grub/arm64/linux.h        |  4 ++++
 include/grub/efi/efi.h            |  4 +++-
 5 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/grub-core/loader/arm64/linux.c b/grub-core/loader/arm64/linux.c
index b5b559c236e0..7c0f17cf933d 100644
--- a/grub-core/loader/arm64/linux.c
+++ b/grub-core/loader/arm64/linux.c
@@ -49,8 +49,13 @@ static grub_addr_t initrd_start;
 static grub_addr_t initrd_end;
 
 grub_err_t
-grub_arch_efi_linux_check_image (struct linux_arch_kernel_header * lh)
+grub_arch_efi_linux_load_image_header (grub_file_t file,
+                                      struct linux_arch_kernel_header * lh)
 {
+  grub_file_seek (file, 0);
+  if (grub_file_read (file, lh, sizeof (*lh)) < (long) sizeof (*lh))
+    return grub_error(GRUB_ERR_FILE_READ_ERROR, "failed to read Linux image header");
+
   if ((lh->code0 & 0xffff) != GRUB_PE32_MAGIC)
     return grub_error (GRUB_ERR_NOT_IMPLEMENTED_YET,
 		       N_("plain image kernel not supported - rebuild with CONFIG_(U)EFI_STUB enabled"));
@@ -301,10 +306,7 @@ grub_cmd_linux (grub_command_t cmd __attribute__ ((unused)),
 
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
index bfab334dd87f..f2a2c0379795 100644
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
index 96f1494e05a2..e00bbcfa2ff2 100644
--- a/include/grub/arm64/linux.h
+++ b/include/grub/arm64/linux.h
@@ -21,6 +21,8 @@
 
 #include <grub/types.h>
 
+#include <grub/efi/pe32.h>
+
 #define GRUB_LINUX_ARM64_MAGIC_SIGNATURE 0x644d5241 /* 'ARM\x64' */
 
 /* From linux/Documentation/arm64/booting.txt */
@@ -36,6 +38,8 @@ struct linux_arm64_kernel_header
   grub_uint64_t res4;		/* reserved */
   grub_uint32_t magic;		/* Magic number, little endian, "ARM\x64" */
   grub_uint32_t hdr_offset;	/* Offset of PE/COFF header */
+
+  struct grub_coff_image_header coff_image_header;
 };
 
 #if defined(__aarch64__)
diff --git a/include/grub/efi/efi.h b/include/grub/efi/efi.h
index eb2dfdfce9f8..e61272de5330 100644
--- a/include/grub/efi/efi.h
+++ b/include/grub/efi/efi.h
@@ -102,7 +102,9 @@ extern void (*EXPORT_VAR(grub_efi_net_config)) (grub_efi_handle_t hnd,
 void *EXPORT_FUNC(grub_efi_get_firmware_fdt)(void);
 grub_err_t EXPORT_FUNC(grub_efi_get_ram_base)(grub_addr_t *);
 #include <grub/cpu/linux.h>
-grub_err_t grub_arch_efi_linux_check_image(struct linux_arch_kernel_header *lh);
+#include <grub/file.h>
+grub_err_t grub_arch_efi_linux_load_image_header(grub_file_t file,
+                                                struct linux_arch_kernel_header *lh);
 grub_err_t grub_arch_efi_linux_boot_image(grub_addr_t addr, grub_size_t size,
                                            char *args);
 #endif
-- 
2.35.1

