Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA49C1A348E
	for <lists+linux-efi@lfdr.de>; Thu,  9 Apr 2020 15:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgDINFN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Apr 2020 09:05:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:44052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbgDINFM (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 9 Apr 2020 09:05:12 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7919E21473;
        Thu,  9 Apr 2020 13:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586437511;
        bh=vCcsT7+NygRnTXSt2aa9KbXrWpz8ex7XrrLJuGpgULQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pFDfpLRVRypgIwn8ix8hVyEWSc4iP3ENOny9OB4Q2vn3zFH9o7MkNqi3RbL/doRsC
         yhuQ+ou4bLgF4TDvNWPdR3mRrvjv+M5hlLteDuXeT6bsO9Fo4EmC801VV4va10Z5nA
         zLXPz4gcqfZbUk/5BQ02FdhGZpiBsX2dHo9UvPTg=
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
Subject: [PATCH 6/9] Documentation: efi/x86: clarify EFI handover protocol and its requirements
Date:   Thu,  9 Apr 2020 15:04:31 +0200
Message-Id: <20200409130434.6736-7-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200409130434.6736-1-ardb@kernel.org>
References: <20200409130434.6736-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The EFI handover protocol was introduced on x86 to permit the boot
loader to pass a populated boot_params structure as an additional
function argument to the entry point. This allows the bootloader to
pass the base and size of a initrd image, which is more flexible
than relying on the EFI stub's file I/O routines, which can only
access the file system from which the kernel image itself was loaded
from firmware.

This approach requires a fair amount of internal knowledge regarding
the layout of the boot_params structure on the part of the boot loader,
as well as knowledge regarding the allowed placement of the initrd in
memory, and so it has been deprecated in favour of a new initrd loading
method that is based on existing UEFI protocols and best practices.

So update the x86 boot protocol documentation to clarify that the EFI
handover protocol has been deprecated, and while at it, add a note that
invoking the EFI handover protocol still requires the PE/COFF image to
be loaded properly (as opposed to simply being copied into memory).
Also, drop the code32_start header field from the list of values that
need to be provided, as this is no longer required.

Reviewed-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 Documentation/x86/boot.rst | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
index fa7ddc0428c8..5325c71ca877 100644
--- a/Documentation/x86/boot.rst
+++ b/Documentation/x86/boot.rst
@@ -1399,8 +1399,8 @@ must have read/write permission; CS must be __BOOT_CS and DS, ES, SS
 must be __BOOT_DS; interrupt must be disabled; %rsi must hold the base
 address of the struct boot_params.
 
-EFI Handover Protocol
-=====================
+EFI Handover Protocol (deprecated)
+==================================
 
 This protocol allows boot loaders to defer initialisation to the EFI
 boot stub. The boot loader is required to load the kernel/initrd(s)
@@ -1408,6 +1408,12 @@ from the boot media and jump to the EFI handover protocol entry point
 which is hdr->handover_offset bytes from the beginning of
 startup_{32,64}.
 
+The boot loader MUST respect the kernel's PE/COFF metadata when it comes
+to section alignment, the memory footprint of the executable image beyond
+the size of the file itself, and any other aspect of the PE/COFF header
+that may affect correct operation of the image as a PE/COFF binary in the
+execution context provided by the EFI firmware.
+
 The function prototype for the handover entry point looks like this::
 
     efi_main(void *handle, efi_system_table_t *table, struct boot_params *bp)
@@ -1419,9 +1425,18 @@ UEFI specification. 'bp' is the boot loader-allocated boot params.
 
 The boot loader *must* fill out the following fields in bp::
 
-  - hdr.code32_start
   - hdr.cmd_line_ptr
   - hdr.ramdisk_image (if applicable)
   - hdr.ramdisk_size  (if applicable)
 
 All other fields should be zero.
+
+NOTE: The EFI Handover Protocol is deprecated in favour of the ordinary PE/COFF
+      entry point, combined with the LINUX_EFI_INITRD_MEDIA_GUID based initrd
+      loading protocol (refer to [0] for an example of the bootloader side of
+      this), which removes the need for any knowledge on the part of the EFI
+      bootloader regarding the internal representation of boot_params or any
+      requirements/limitations regarding the placement of the command line
+      and ramdisk in memory, or the placement of the kernel image itself.
+
+[0] https://github.com/u-boot/u-boot/commit/ec80b4735a593961fe701cc3a5d717d4739b0fd0
-- 
2.17.1

