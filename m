Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9BE21A98E
	for <lists+linux-efi@lfdr.de>; Thu,  9 Jul 2020 23:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgGIVMp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Jul 2020 17:12:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:58506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbgGIVMo (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 9 Jul 2020 17:12:44 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F49520672;
        Thu,  9 Jul 2020 21:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594329163;
        bh=gdNAjKFjd7Ma8Rp8a9m6lG9yDDI4JcIuK5Ysm9BcJfo=;
        h=From:To:Cc:Subject:Date:From;
        b=vX8lbvipPcFGZK5JKbxkTM+SSTKJMhYFHfmf21jyuzdH1BrmFK7OJcFr7zdVGcMuD
         w/SCcToOZYAxLY2Ll+z7X+4Yyz6FdaocUw44kHF03+uFnbST7rryRx2OmI7i17/vls
         C+zfBHjImBxwPK5Z7eKQt7AJWzMzYmfCEnb6F8iw=
From:   Will Deacon <will@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        David Brazdil <dbrazdil@google.com>
Subject: [RFC PATCH] efi/libstub/arm64: Retain 2MB kernel Image alignment if !KASLR
Date:   Thu,  9 Jul 2020 22:12:37 +0100
Message-Id: <20200709211237.29455-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Since commit 82046702e288 ("efi/libstub/arm64: Replace 'preferred' offset
with alignment check"), loading a relocatable arm64 kernel at a physical
address which is not 2MB aligned and subsequently booting with EFI will
leave the Image in-place, relying on the kernel to relocate itself early
during boot. In conjunction with commit dd4bc6076587 ("arm64: warn on
incorrect placement of the kernel by the bootloader"), which enables
CONFIG_RELOCATABLE by default, this effectively means that entering an
arm64 kernel loaded at an alignment smaller than 2MB with EFI (e.g. using
QEMU) will result in silent relocation at runtime.

Unfortunately, this has a subtle but confusing affect for developers
trying to inspect the PC value during a crash and comparing it to the
symbol addresses in vmlinux using tools such as 'nm' or 'addr2line';
all text addresses will be displaced by a sub-2MB offset, resulting in
the wrong symbol being identified in many cases. Passing "nokaslr" on
the command line or disabling "CONFIG_RANDOMIZE_BASE" does not help,
since the EFI stub only copies the kernel Image to a 2MB boundary if it
is not relocatable.

Adjust the EFI stub for arm64 so that the minimum Image alignment is 2MB
unless KASLR is in use.

Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: David Brazdil <dbrazdil@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---

Not massively happy with this patch, but also not massively happy that
addr2line is so misleading without it. Thoughts?

 drivers/firmware/efi/libstub/arm64-stub.c     | 25 +++++++++++--------
 .../firmware/efi/libstub/efi-stub-helper.c    |  2 +-
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index 7f6a57dec513..e5bfac79e5ac 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -35,13 +35,16 @@ efi_status_t check_platform_features(void)
 }
 
 /*
- * Relocatable kernels can fix up the misalignment with respect to
- * MIN_KIMG_ALIGN, so they only require a minimum alignment of EFI_KIMG_ALIGN
- * (which accounts for the alignment of statically allocated objects such as
- * the swapper stack.)
+ * Although relocatable kernels can fix up the misalignment with respect to
+ * MIN_KIMG_ALIGN, the resulting virtual text addresses are subtly out of
+ * sync with those recorded in the vmlinux when kaslr is disabled but the
+ * image required relocation anyway. Therefore retain 2M alignment unless
+ * KASLR is in use.
  */
-static const u64 min_kimg_align = IS_ENABLED(CONFIG_RELOCATABLE) ? EFI_KIMG_ALIGN
-								 : MIN_KIMG_ALIGN;
+static u64 min_kimg_align(void)
+{
+	return efi_nokaslr ? MIN_KIMG_ALIGN : EFI_KIMG_ALIGN;
+}
 
 efi_status_t handle_kernel_image(unsigned long *image_addr,
 				 unsigned long *image_size,
@@ -74,21 +77,21 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 
 	kernel_size = _edata - _text;
 	kernel_memsize = kernel_size + (_end - _edata);
-	*reserve_size = kernel_memsize + TEXT_OFFSET % min_kimg_align;
+	*reserve_size = kernel_memsize + TEXT_OFFSET % min_kimg_align();
 
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && phys_seed != 0) {
 		/*
 		 * If KASLR is enabled, and we have some randomness available,
 		 * locate the kernel at a randomized offset in physical memory.
 		 */
-		status = efi_random_alloc(*reserve_size, min_kimg_align,
+		status = efi_random_alloc(*reserve_size, min_kimg_align(),
 					  reserve_addr, phys_seed);
 	} else {
 		status = EFI_OUT_OF_RESOURCES;
 	}
 
 	if (status != EFI_SUCCESS) {
-		if (IS_ALIGNED((u64)_text - TEXT_OFFSET, min_kimg_align)) {
+		if (IS_ALIGNED((u64)_text - TEXT_OFFSET, min_kimg_align())) {
 			/*
 			 * Just execute from wherever we were loaded by the
 			 * UEFI PE/COFF loader if the alignment is suitable.
@@ -99,7 +102,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 		}
 
 		status = efi_allocate_pages_aligned(*reserve_size, reserve_addr,
-						    ULONG_MAX, min_kimg_align);
+						    ULONG_MAX, min_kimg_align());
 
 		if (status != EFI_SUCCESS) {
 			efi_err("Failed to relocate kernel\n");
@@ -108,7 +111,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 		}
 	}
 
-	*image_addr = *reserve_addr + TEXT_OFFSET % min_kimg_align;
+	*image_addr = *reserve_addr + TEXT_OFFSET % min_kimg_align();
 	memcpy((void *)*image_addr, _text, kernel_size);
 
 	return EFI_SUCCESS;
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index d40fd68c6bb2..6bca70bbb43d 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -19,7 +19,7 @@
 #include "efistub.h"
 
 bool efi_nochunk;
-bool efi_nokaslr;
+bool efi_nokaslr = !IS_ENABLED(CONFIG_RANDOMIZE_BASE);
 bool efi_noinitrd;
 int efi_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
 bool efi_novamap;
-- 
2.27.0.383.g050319c2ae-goog

