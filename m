Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6606C1A348B
	for <lists+linux-efi@lfdr.de>; Thu,  9 Apr 2020 15:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgDINFG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Apr 2020 09:05:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbgDINFG (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 9 Apr 2020 09:05:06 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D490721556;
        Thu,  9 Apr 2020 13:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586437506;
        bh=ilS9Uh3RrYGVJaGs8AYWP2E9uj7DxanAuXoWfeQM8ZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SX96mAGFX6SqwnptbHoyyroFo+xTp8pvzuO1sa9LkgXzQSbg4bpoBIkPrbFqM16P5
         SUleIfqb6MjNrJWpgtfuujELOEJQfRLJdtYgh9n5nXW83ZY6/wlEs7ddxIdPWxw6Cp
         6RtL+GF+EyXbGF7yXRdZuAugQhLJfdve0eEclZLM=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>,
        Colin Ian King <colin.king@canonical.com>,
        Gary Lin <glin@suse.com>, Jiri Slaby <jslaby@suse.cz>,
        Sergey Shatunov <me@prok.pw>, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/9] efi/x86: Always relocate the kernel for EFI handover entry
Date:   Thu,  9 Apr 2020 15:04:29 +0200
Message-Id: <20200409130434.6736-5-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200409130434.6736-1-ardb@kernel.org>
References: <20200409130434.6736-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

Commit

  d5cdf4cfeac9 ("efi/x86: Don't relocate the kernel unless necessary")

tries to avoid relocating the kernel in the EFI stub as far as possible.

However, when systemd-boot is used to boot a unified kernel image [1],
the image is constructed by embedding the bzImage as a .linux section in
a PE executable that contains a small stub loader from systemd that will
call the EFI stub handover entry, together with additional sections and
potentially an initrd. When this image is constructed, by for example
dracut, the initrd is placed after the bzImage without ensuring that at
least init_size bytes are available for the bzImage. If the kernel is
not relocated by the EFI stub, this could result in the compressed
kernel's startup code in head_{32,64}.S overwriting the initrd.

To prevent this, unconditionally relocate the kernel if the EFI stub was
entered via the handover entry point.

[1] https://systemd.io/BOOT_LOADER_SPECIFICATION/#type-2-efi-unified-kernel-images

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Reported-by: Sergey Shatunov <me@prok.pw>
Fixes: d5cdf4cfeac9 ("efi/x86: Don't relocate the kernel unless necessary")
Link: https://lore.kernel.org/r/20200406180614.429454-2-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 867a57e28980..05ccb229fb45 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -740,8 +740,15 @@ unsigned long efi_main(efi_handle_t handle,
 	 * now use KERNEL_IMAGE_SIZE, which will be 512MiB, the same as what
 	 * KASLR uses.
 	 *
-	 * Also relocate it if image_offset is zero, i.e. we weren't loaded by
-	 * LoadImage, but we are not aligned correctly.
+	 * Also relocate it if image_offset is zero, i.e. the kernel wasn't
+	 * loaded by LoadImage, but rather by a bootloader that called the
+	 * handover entry. The reason we must always relocate in this case is
+	 * to handle the case of systemd-boot booting a unified kernel image,
+	 * which is a PE executable that contains the bzImage and an initrd as
+	 * COFF sections. The initrd section is placed after the bzImage
+	 * without ensuring that there are at least init_size bytes available
+	 * for the bzImage, and thus the compressed kernel's startup code may
+	 * overwrite the initrd unless it is moved out of the way.
 	 */
 
 	buffer_start = ALIGN(bzimage_addr - image_offset,
@@ -751,8 +758,7 @@ unsigned long efi_main(efi_handle_t handle,
 	if ((buffer_start < LOAD_PHYSICAL_ADDR)				     ||
 	    (IS_ENABLED(CONFIG_X86_32) && buffer_end > KERNEL_IMAGE_SIZE)    ||
 	    (IS_ENABLED(CONFIG_X86_64) && buffer_end > MAXMEM_X86_64_4LEVEL) ||
-	    (image_offset == 0 && !IS_ALIGNED(bzimage_addr,
-					      hdr->kernel_alignment))) {
+	    (image_offset == 0)) {
 		status = efi_relocate_kernel(&bzimage_addr,
 					     hdr->init_size, hdr->init_size,
 					     hdr->pref_address,
-- 
2.17.1

