Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC9D51A3489
	for <lists+linux-efi@lfdr.de>; Thu,  9 Apr 2020 15:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgDINFE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Apr 2020 09:05:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:43838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbgDINFD (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 9 Apr 2020 09:05:03 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E04D20B1F;
        Thu,  9 Apr 2020 13:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586437503;
        bh=WARHdac/C67XYFJmrDmG5ihz8zpB/KKdjwhcuDK5NtQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=10xhPsc5V6uC0i7V1VNjTmewa2xHFOOS01ZqYuTMFMjRJTHjHdNxJdNpkoqjVGect
         vNOtXwaHS6d4zUo9z3PKDbAPmkxWCcnoC7IVHh38G+dcy7+tUhqaOCBG8ronzsSzMM
         zPRxMg8p9rc2Izke5XMQQdFFNNdccrKCSC0g5NSc=
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
Subject: [PATCH 3/9] efi/x86: Move efi stub globals from .bss to .data
Date:   Thu,  9 Apr 2020 15:04:28 +0200
Message-Id: <20200409130434.6736-4-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200409130434.6736-1-ardb@kernel.org>
References: <20200409130434.6736-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

Commit

  3ee372ccce4d ("x86/boot/compressed/64: Remove .bss/.pgtable from bzImage")

removed the .bss section from the bzImage.

However, while a PE loader is required to zero-initialize the .bss
section before calling the PE entry point, the EFI handover protocol
does not currently document any requirement that .bss be initialized by
the bootloader prior to calling the handover entry.

When systemd-boot is used to boot a unified kernel image [1], the image
is constructed by embedding the bzImage as a .linux section in a PE
executable that contains a small stub loader from systemd together with
additional sections and potentially an initrd. As the .bss section
within the bzImage is no longer explicitly present as part of the file,
it is not initialized before calling the EFI handover entry.
Furthermore, as the size of the embedded .linux section is only the size
of the bzImage file itself, the .bss section's memory may not even have
been allocated.

In particular, this can result in efi_disable_pci_dma being true even
when it was not specified via the command line or configuration option,
which in turn causes crashes while booting on some systems.

To avoid issues, place all EFI stub global variables into the .data
section instead of .bss. As of this writing, only boolean flags for a
few command line arguments and the sys_table pointer were in .bss and
will now move into the .data section.

[1] https://systemd.io/BOOT_LOADER_SPECIFICATION/#type-2-efi-unified-kernel-images

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Reported-by: Sergey Shatunov <me@prok.pw>
Fixes: 3ee372ccce4d ("x86/boot/compressed/64: Remove .bss/.pgtable from bzImage")
Link: https://lore.kernel.org/r/20200406180614.429454-1-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efistub.h  | 2 +-
 drivers/firmware/efi/libstub/x86-stub.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index cc90a748bcf0..67d26949fd26 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -25,7 +25,7 @@
 #define EFI_ALLOC_ALIGN		EFI_PAGE_SIZE
 #endif
 
-#ifdef CONFIG_ARM
+#if defined(CONFIG_ARM) || defined(CONFIG_X86)
 #define __efistub_global	__section(.data)
 #else
 #define __efistub_global
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index e02ea51273ff..867a57e28980 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -20,7 +20,7 @@
 /* Maximum physical address for 64-bit kernel with 4-level paging */
 #define MAXMEM_X86_64_4LEVEL (1ull << 46)
 
-static efi_system_table_t *sys_table;
+static efi_system_table_t *sys_table __efistub_global;
 extern const bool efi_is64;
 extern u32 image_offset;
 
-- 
2.17.1

