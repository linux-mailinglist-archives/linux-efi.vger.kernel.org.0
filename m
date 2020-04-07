Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEF5B1A103C
	for <lists+linux-efi@lfdr.de>; Tue,  7 Apr 2020 17:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbgDGPcZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Apr 2020 11:32:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:51690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728306AbgDGPcY (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 7 Apr 2020 11:32:24 -0400
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 286182075E;
        Tue,  7 Apr 2020 15:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586273543;
        bh=KWZiog4H3rCLwylxUb1Cp0hHZ0DXkOqYeTina58plxA=;
        h=From:To:Cc:Subject:Date:From;
        b=Mzn724bh/mYrQN+zOHOl+nPSLEVTV4cGu79XBMUIK8Ggd1iflOS7bdAunf8nw9Z2m
         bJWRvSktkCkbwM+wkHOJM7r1w4tmKpszNQ8xTOt1zQaVw8/jEc/e2ZGzfAngz5zVlv
         t2TEff4TVH2M5j4LlZbb5XQuDJ2sze0KQOEDeakc=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     x86@kernel.org, linux-doc@vger.kernel.org, corbet@lwn.net,
        nivedita@alum.mit.edu, bp@alien8.de,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] Documentation: efi/x86: clarify EFI handover protocol and its requirements
Date:   Tue,  7 Apr 2020 17:32:06 +0200
Message-Id: <20200407153206.17360-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
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
be loader properly (as opposed to simply being copied into memory). Also,
drop the code32_start header field from the list of values that need to be
provided, as this is no longer required.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 Documentation/x86/boot.rst | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
index fa7ddc0428c8..22ac52921692 100644
--- a/Documentation/x86/boot.rst
+++ b/Documentation/x86/boot.rst
@@ -1399,14 +1399,19 @@ must have read/write permission; CS must be __BOOT_CS and DS, ES, SS
 must be __BOOT_DS; interrupt must be disabled; %rsi must hold the base
 address of the struct boot_params.
 
-EFI Handover Protocol
-=====================
+EFI Handover Protocol (deprecated)
+==================================
 
 This protocol allows boot loaders to defer initialisation to the EFI
 boot stub. The boot loader is required to load the kernel/initrd(s)
 from the boot media and jump to the EFI handover protocol entry point
 which is hdr->handover_offset bytes from the beginning of
 startup_{32,64}.
+The boot loader MUST respect the kernel's PE/COFF metadata when it comes
+to section alignment, the memory footprint of the executable image beyond
+the size of the file itself, and any other aspect of the PE/COFF header
+that may affect correct operation of the image as a PE/COFF binary in the
+execution context provided by the EFI firmware.
 
 The function prototype for the handover entry point looks like this::
 
@@ -1419,9 +1424,15 @@ UEFI specification. 'bp' is the boot loader-allocated boot params.
 
 The boot loader *must* fill out the following fields in bp::
 
-  - hdr.code32_start
   - hdr.cmd_line_ptr
   - hdr.ramdisk_image (if applicable)
   - hdr.ramdisk_size  (if applicable)
 
 All other fields should be zero.
+
+NOTE: The EFI Handover Protocol is deprecated in favour of the ordinary PE/COFF
+      entry point, combined with the LINUX_EFI_INITRD_MEDIA_GUID based initrd
+      loading protocol, which removes the need for any knowledge on the part of
+      the EFI bootloader regarding the internal representation of boot_params or
+      any requirements/limitations regarding the placement of the command line
+      and ramdisk in memory, or the placement of the kernel image itself.
-- 
2.17.1

