Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 401D52981F5
	for <lists+linux-efi@lfdr.de>; Sun, 25 Oct 2020 14:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416431AbgJYNuC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 25 Oct 2020 09:50:02 -0400
Received: from foss.arm.com ([217.140.110.172]:46334 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416426AbgJYNuB (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 25 Oct 2020 09:50:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DBED1435;
        Sun, 25 Oct 2020 06:50:01 -0700 (PDT)
Received: from e123331-lin.nice.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F6D63F68F;
        Sun, 25 Oct 2020 06:50:00 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@arm.com>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@arm.com>, grub-devel@gnu.org,
        daniel.kiper@oracle.com, leif@nuviainc.com
Subject: [PATCH v2 5/8] linux/arm: account for COFF headers appearing at unexpected offsets
Date:   Sun, 25 Oct 2020 14:49:38 +0100
Message-Id: <20201025134941.4805-6-ard.biesheuvel@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201025134941.4805-1-ard.biesheuvel@arm.com>
References: <20201025134941.4805-1-ard.biesheuvel@arm.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The way we load the Linux and PE/COFF image headers depends on a fixed
placement of the COFF header at offset 0x40 into the file. This is a
reasonable default, given that this is where Linux emits it today.
However, in order to comply with the PE/COFF spec, which permits this
header to appear anywhere in the file, let's ensure that we read the
header from where it actually appears in the file if it is not located
at offset 0x40.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@arm.com>
---
 grub-core/loader/arm64/linux.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/grub-core/loader/arm64/linux.c b/grub-core/loader/arm64/linux.c
index 915b6ad7292d..28ff8584a3b5 100644
--- a/grub-core/loader/arm64/linux.c
+++ b/grub-core/loader/arm64/linux.c
@@ -66,6 +66,21 @@ grub_arch_efi_linux_load_image_header (grub_file_t file,
   grub_dprintf ("linux", "UEFI stub kernel:\n");
   grub_dprintf ("linux", "PE/COFF header @ %08x\n", lh->hdr_offset);
 
+  /*
+   * The PE/COFF spec permits the COFF header to appear anywhere in the file, so
+   * we need to double check whether it was where we expected it, and if not, we
+   * must load it from the correct offset into the coff_image_header field of
+   * struct linux_arch_kernel_header.
+   */
+  if ((grub_uint8_t *) lh + lh->hdr_offset != (grub_uint8_t *) &lh->coff_image_header)
+    {
+      grub_file_seek (file, lh->hdr_offset);
+
+      if (grub_file_read (file, &lh->coff_image_header, sizeof(struct grub_coff_image_header))
+	  != sizeof(struct grub_coff_image_header))
+	return grub_error(GRUB_ERR_FILE_READ_ERROR, "failed to read COFF image header");
+    }
+
   return GRUB_ERR_NONE;
 }
 
-- 
2.17.1

