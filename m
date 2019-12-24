Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2B3512A2BF
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2019 16:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfLXPLS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Dec 2019 10:11:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:51278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727260AbfLXPLR (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 24 Dec 2019 10:11:17 -0500
Received: from localhost.localdomain (aaubervilliers-681-1-7-6.w90-88.abo.wanadoo.fr [90.88.129.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECFB12073B;
        Tue, 24 Dec 2019 15:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577200277;
        bh=1kGaF15vN4FH35+L10jBoeSTMyYo9nfMYIkLyf6n3DY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RAAjpbODotl186aq1RcetHMH9s138IBE/wqMv1B8Kk3twlDy+2p9PJLdcRCZ66jzh
         RW56ANO4m1gV3l0T67QxCGrd5zUnnBwUZrxl5BJV1IhkiFnuzkX7Ss9Dq+vwZ07t/P
         hXouMhyQ0Jx91lUSN2RVvMV5XIuqNazQw8qm5R3w=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH 20/25] efi/libstub/x86: work around page freeing issue in mixed mode
Date:   Tue, 24 Dec 2019 16:10:20 +0100
Message-Id: <20191224151025.32482-21-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224151025.32482-1-ardb@kernel.org>
References: <20191224151025.32482-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Mixed mode translates calls from the 64-bit kernel into the 32-bit
firmware by wrapping them in a call to a thunking routine that
pushes a 32-bit word onto the stack for each argument passed to the
function, regardless of the argument type. This works surprisingly
well for most services and protocols, with the exception of ones that
take explicit 64-bit arguments.

efi_free() invokes the FreePages() EFI boot service, which takes
a efi_physical_addr_t as its address argument, and this is one of
those 64-bit types. This means that the 32-bit firmware will
interpret the (addr, size) pair as a single 64-bit quantity, and
since it is guaranteed to have the high word set (as size > 0),
it will always fail due to the fact that EFI memory allocations are
always < 4 GB on 32-bit firmware.

So let's fix this by giving the thunking code a little hand, and
pass two values for the address, and a third one for the size.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/eboot.c               | 16 ++++++++++++++++
 drivers/firmware/efi/libstub/efi-stub-helper.c |  5 ++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index f81dd66626ce..ec92c4decc86 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -901,3 +901,19 @@ struct boot_params *efi_main(efi_handle_t handle,
 	for (;;)
 		asm("hlt");
 }
+
+#ifdef CONFIG_EFI_MIXED
+void efi_free_native(unsigned long size, unsigned long addr);
+
+void efi_free(unsigned long size, unsigned long addr)
+{
+	if (!size)
+		return;
+
+	if (efi_is_native())
+		efi_free_native(size, addr);
+	else
+		efi64_thunk(efi_system_table()->boottime->mixed_mode.free_pages,
+			    addr, 0, DIV_ROUND_UP(size, EFI_PAGE_SIZE));
+}
+#endif
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index d4215571f05a..b715ac6a0c94 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -346,6 +346,9 @@ efi_status_t efi_low_alloc_above(unsigned long size, unsigned long align,
 }
 
 void efi_free(unsigned long size, unsigned long addr)
+	__weak __alias(efi_free_native);
+
+void efi_free_native(unsigned long size, unsigned long addr)
 {
 	unsigned long nr_pages;
 
@@ -353,7 +356,7 @@ void efi_free(unsigned long size, unsigned long addr)
 		return;
 
 	nr_pages = round_up(size, EFI_ALLOC_ALIGN) / EFI_PAGE_SIZE;
-	efi_call_early(free_pages, addr, nr_pages);
+	efi_system_table()->boottime->free_pages(addr, nr_pages);
 }
 
 static efi_status_t efi_file_size(void *__fh, efi_char16_t *filename_16,
-- 
2.20.1

