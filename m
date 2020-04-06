Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABA3419FC7B
	for <lists+linux-efi@lfdr.de>; Mon,  6 Apr 2020 20:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgDFSGV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Apr 2020 14:06:21 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36978 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgDFSGU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Apr 2020 14:06:20 -0400
Received: by mail-qk1-f196.google.com with SMTP id 130so2050761qke.4;
        Mon, 06 Apr 2020 11:06:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cvg3whVQVAqqlVvqOZl3uLW5HgEWpclGCuhQ2YcgjRY=;
        b=ZXORiSjktGzng5GOwaaomOc+sqqFWx3e95yZ5ZcxQ8xEU+CIcOtf6AGjK2TtGDSKO4
         k4Q9Y+3a1VRynxa+Hb1CoeMz5Tx94tm/ZZcobm14p/2DYT93nctSPd+bfPtDb8stDhcK
         qJeuYijVYLi6azpj5Js1nnz7EDuLrrwIO3zEv1t1S16ck2wzUDDws6IX8b3cfUhJZWdj
         C73CWZY5McHccdJTl7F2ZuMPbUfxvaJIveihbEC6zskb13V9llIQm9ghrPGVn/Pz10Am
         ZZI1W9Ns+TVt3Ixk4SZDsCI3Xi5zSo1cQs7CVe6okBNz8nHaNrhkaetLqzTW8nkSeG9x
         iKmw==
X-Gm-Message-State: AGi0PuYSbARN1DLc2C8VPOdvNhitKakbM2PYiMzoFuGcruEAB2uSvBUf
        3d8FH4eCUUeUsridqEFcNhA=
X-Google-Smtp-Source: APiQypLuA1RvXa3qTFL/Z2cWoE6mihW4wAocrADNP0Wws3ruz0vwV/5ow4uaekkSs2FoM1c2ZDPGMA==
X-Received: by 2002:a37:9c8b:: with SMTP id f133mr23159866qke.482.1586196377975;
        Mon, 06 Apr 2020 11:06:17 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id a136sm10548473qkc.75.2020.04.06.11.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 11:06:17 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@alien8.de>, Sergey Shatunov <me@prok.pw>,
        hpa@zytor.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org, linux-efi <linux-efi@vger.kernel.org>,
        initramfs@vger.kernel.org,
        Donovan Tremura <neurognostic@protonmail.ch>,
        Harald Hoyer <harald@hoyer.xyz>
Subject: [PATCH 2/2] efi/x86: Always relocate the kernel for EFI handover entry
Date:   Mon,  6 Apr 2020 14:06:14 -0400
Message-Id: <20200406180614.429454-2-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200406180614.429454-1-nivedita@alum.mit.edu>
References: <CAMj1kXEUkJ1XJ9OTsijeq8tNNYC00bXqEV44OMtX5ugo9WoLKA@mail.gmail.com>
 <20200406180614.429454-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

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
---
 drivers/firmware/efi/libstub/x86-stub.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index e7af6d2eddbf..7583e908852f 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -742,8 +742,15 @@ unsigned long efi_main(efi_handle_t handle,
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
@@ -753,8 +760,7 @@ unsigned long efi_main(efi_handle_t handle,
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
2.24.1

