Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1832981F3
	for <lists+linux-efi@lfdr.de>; Sun, 25 Oct 2020 14:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416429AbgJYNt7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 25 Oct 2020 09:49:59 -0400
Received: from foss.arm.com ([217.140.110.172]:46312 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416426AbgJYNt7 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 25 Oct 2020 09:49:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E66530E;
        Sun, 25 Oct 2020 06:49:58 -0700 (PDT)
Received: from e123331-lin.nice.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23B903F68F;
        Sun, 25 Oct 2020 06:49:57 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@arm.com>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@arm.com>, grub-devel@gnu.org,
        daniel.kiper@oracle.com, leif@nuviainc.com
Subject: [PATCH v2 3/8] efi: move MS-DOS stub out of generic PE header definition
Date:   Sun, 25 Oct 2020 14:49:36 +0100
Message-Id: <20201025134941.4805-4-ard.biesheuvel@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201025134941.4805-1-ard.biesheuvel@arm.com>
References: <20201025134941.4805-1-ard.biesheuvel@arm.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The PE/COFF spec permits the COFF signature and file header to appear
anywhere in the file, and the actual offset is recorded in 4 byte
little endian field at offset 0x3c of the image.

When GRUB is emitted as a PE/COFF binary, we reuse the 128 byte MS-DOS
stub (even for non-x86 architectures), putting the COFF signature and
file header at offset 0x80. However, other PE/COFF images may use
different values, and non-x86 Linux kernels use an offset of 0x40
instead.

So let's get rid of the grub_pe32_header struct from pe32.h, given that
it does not represent anything defined by the PE/COFF spec. Instead,
use the GRUB_PE32_MSDOS_STUB_SIZE macro explicitly to reference the
COFF header in the only place in the code where we rely on this.

The remaining fields are moved into a struct grub_coff_image_header,
which we will use later to access COFF header fields of arbitrary
images (and which may therefore appear at different offsets)

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@arm.com>
---
 grub-core/kern/efi/efi.c | 5 +++--
 include/grub/efi/pe32.h  | 5 +----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/grub-core/kern/efi/efi.c b/grub-core/kern/efi/efi.c
index e0165e74c587..9e5a72be538d 100644
--- a/grub-core/kern/efi/efi.c
+++ b/grub-core/kern/efi/efi.c
@@ -282,7 +282,7 @@ grub_addr_t
 grub_efi_modules_addr (void)
 {
   grub_efi_loaded_image_t *image;
-  struct grub_pe32_header *header;
+  struct grub_coff_image_header *header;
   struct grub_pe32_coff_header *coff_header;
   struct grub_pe32_section_table *sections;
   struct grub_pe32_section_table *section;
@@ -293,7 +293,8 @@ grub_efi_modules_addr (void)
   if (! image)
     return 0;
 
-  header = image->image_base;
+  header = (struct grub_coff_image_header *) ((char *) image->image_base
+					      + GRUB_PE32_MSDOS_STUB_SIZE);
   coff_header = &(header->coff_header);
   sections
     = (struct grub_pe32_section_table *) ((char *) coff_header
diff --git a/include/grub/efi/pe32.h b/include/grub/efi/pe32.h
index 0ed8781f0376..a2da4b318c85 100644
--- a/include/grub/efi/pe32.h
+++ b/include/grub/efi/pe32.h
@@ -254,11 +254,8 @@ struct grub_pe32_section_table
 
 #define GRUB_PE32_SIGNATURE_SIZE 4
 
-struct grub_pe32_header
+struct grub_coff_image_header
 {
-  /* This should be filled in with GRUB_PE32_MSDOS_STUB.  */
-  grub_uint8_t msdos_stub[GRUB_PE32_MSDOS_STUB_SIZE];
-
   /* This is always PE\0\0.  */
   char signature[GRUB_PE32_SIGNATURE_SIZE];
 
-- 
2.17.1

