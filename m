Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E348124E9E
	for <lists+linux-efi@lfdr.de>; Wed, 18 Dec 2019 18:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfLRRCR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Dec 2019 12:02:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:53232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727368AbfLRRCR (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 18 Dec 2019 12:02:17 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68CF924650;
        Wed, 18 Dec 2019 17:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576688536;
        bh=9UXdi9+k83l2dNzBnx8MXZnI2nvL09miLg3HX3ie14o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SuqF/luwzM8O2t0F7adkiPmzALrBfguZipuNLKKAJHAHYlfncF9lf7N20i0Mn/D+5
         bZGb/NbLKBAl82FoQM+fqYaPylrlZ6w2C88ss5FKmBiDpgePo4dDyXDZ1bRMCcJQC1
         rD4YUNOVEk6Xw0kZc/wTg6R6ic96xUNvgqs4E51Q=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH v2 02/21] efi/x86: rename efi_is_native() to efi_is_mixed()
Date:   Wed, 18 Dec 2019 19:01:20 +0200
Message-Id: <20191218170139.9468-3-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191218170139.9468-1-ardb@kernel.org>
References: <20191218170139.9468-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The ARM architecture does not permit combining 32-bit and 64-bit code
at the same privilege level, and so EFI mixed mode is strictly a x86
concept.

In preparation of turning the 32/64 bit distinction in shared stub
code to a native vs mixed one, refactor x86's current use of the
helper function efi_is_native() into efi_is_mixed().

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/efi.h     | 10 ++++++----
 arch/x86/platform/efi/efi.c    |  8 ++++----
 arch/x86/platform/efi/efi_64.c |  4 ++--
 arch/x86/platform/efi/quirks.c |  2 +-
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 59c19e0b6027..6094e7f49a99 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -153,17 +153,19 @@ extern u64 efi_setup;
 
 #ifdef CONFIG_EFI
 
-static inline bool efi_is_native(void)
+static inline bool efi_is_mixed(void)
 {
-	return IS_ENABLED(CONFIG_X86_64) == efi_enabled(EFI_64BIT);
+	if (!IS_ENABLED(CONFIG_EFI_MIXED))
+		return false;
+	return IS_ENABLED(CONFIG_X86_64) && !efi_enabled(EFI_64BIT);
 }
 
 static inline bool efi_runtime_supported(void)
 {
-	if (efi_is_native())
+	if (!efi_is_mixed())
 		return true;
 
-	if (IS_ENABLED(CONFIG_EFI_MIXED) && !efi_enabled(EFI_OLD_MEMMAP))
+	if (!efi_enabled(EFI_OLD_MEMMAP))
 		return true;
 
 	return false;
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index bb8e37a723d6..1493e964c267 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -848,7 +848,7 @@ static bool should_map_region(efi_memory_desc_t *md)
 	 * Map all of RAM so that we can access arguments in the 1:1
 	 * mapping when making EFI runtime calls.
 	 */
-	if (IS_ENABLED(CONFIG_EFI_MIXED) && !efi_is_native()) {
+	if (efi_is_mixed()) {
 		if (md->type == EFI_CONVENTIONAL_MEMORY ||
 		    md->type == EFI_LOADER_DATA ||
 		    md->type == EFI_LOADER_CODE)
@@ -923,7 +923,7 @@ static void __init kexec_enter_virtual_mode(void)
 	 * kexec kernel because in the initial boot something else might
 	 * have been mapped at these virtual addresses.
 	 */
-	if (!efi_is_native() || efi_enabled(EFI_OLD_MEMMAP)) {
+	if (efi_is_mixed() || efi_enabled(EFI_OLD_MEMMAP)) {
 		efi_memmap_unmap();
 		clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
 		return;
@@ -1060,7 +1060,7 @@ static void __init __efi_enter_virtual_mode(void)
 
 	efi_sync_low_kernel_mappings();
 
-	if (efi_is_native()) {
+	if (!efi_is_mixed()) {
 		status = phys_efi_set_virtual_address_map(
 				efi.memmap.desc_size * count,
 				efi.memmap.desc_size,
@@ -1091,7 +1091,7 @@ static void __init __efi_enter_virtual_mode(void)
 	 */
 	efi.runtime_version = efi_systab.hdr.revision;
 
-	if (efi_is_native())
+	if (!efi_is_mixed())
 		efi_native_runtime_setup();
 	else
 		efi_thunk_runtime_setup();
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 08ce8177c3af..885e50a707a6 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -388,7 +388,7 @@ int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages)
 	 * text and allocate a new stack because we can't rely on the
 	 * stack pointer being < 4GB.
 	 */
-	if (!IS_ENABLED(CONFIG_EFI_MIXED) || efi_is_native())
+	if (!efi_is_mixed())
 		return 0;
 
 	page = alloc_page(GFP_KERNEL|__GFP_DMA32);
@@ -449,7 +449,7 @@ void __init efi_map_region(efi_memory_desc_t *md)
 	 * booting in EFI mixed mode, because even though we may be
 	 * running a 64-bit kernel, the firmware may only be 32-bit.
 	 */
-	if (!efi_is_native () && IS_ENABLED(CONFIG_EFI_MIXED)) {
+	if (efi_is_mixed()) {
 		md->virt_addr = md->phys_addr;
 		return;
 	}
diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 7675cf754d90..84d7176983d2 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -397,7 +397,7 @@ static void __init efi_unmap_pages(efi_memory_desc_t *md)
 	 * EFI runtime calls, hence don't unmap EFI boot services code/data
 	 * regions.
 	 */
-	if (!efi_is_native())
+	if (efi_is_mixed())
 		return;
 
 	if (kernel_unmap_pages_in_pgd(pgd, pa, md->num_pages))
-- 
2.17.1

