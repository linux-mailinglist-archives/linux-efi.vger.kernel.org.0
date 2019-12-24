Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E843312A2D6
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2019 16:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfLXPK4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Dec 2019 10:10:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:50772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbfLXPK4 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 24 Dec 2019 10:10:56 -0500
Received: from localhost.localdomain (aaubervilliers-681-1-7-6.w90-88.abo.wanadoo.fr [90.88.129.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02213206D3;
        Tue, 24 Dec 2019 15:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577200255;
        bh=Ws+oTwB+I3M+2jvOIhXh/ZD0LB86tM4i3zzfEbfA6Rg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t9mdvB3WF77xeoMels2lsiq+8AG56R2zmGHFbRK1htGvrwkwM5YAa719YeWfYHWsD
         ujrTQiFaBWlFCdblnmLjREwMxtpPdqm0eIuBiRQfgfHP3lpt5sS8LglLe4E3sfmJkS
         VKGOrDwWMpuW88lVQhZAxujxmu0VmbsLxhlmbgtc=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH 06/25] efi/x86: rename efi_is_native() to efi_is_mixed()
Date:   Tue, 24 Dec 2019 16:10:06 +0100
Message-Id: <20191224151025.32482-7-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224151025.32482-1-ardb@kernel.org>
References: <20191224151025.32482-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 38d44f36d5ed..e188b7ce0796 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -828,7 +828,7 @@ static bool should_map_region(efi_memory_desc_t *md)
 	 * Map all of RAM so that we can access arguments in the 1:1
 	 * mapping when making EFI runtime calls.
 	 */
-	if (IS_ENABLED(CONFIG_EFI_MIXED) && !efi_is_native()) {
+	if (efi_is_mixed()) {
 		if (md->type == EFI_CONVENTIONAL_MEMORY ||
 		    md->type == EFI_LOADER_DATA ||
 		    md->type == EFI_LOADER_CODE)
@@ -903,7 +903,7 @@ static void __init kexec_enter_virtual_mode(void)
 	 * kexec kernel because in the initial boot something else might
 	 * have been mapped at these virtual addresses.
 	 */
-	if (!efi_is_native() || efi_enabled(EFI_OLD_MEMMAP)) {
+	if (efi_is_mixed() || efi_enabled(EFI_OLD_MEMMAP)) {
 		efi_memmap_unmap();
 		clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
 		return;
@@ -1040,7 +1040,7 @@ static void __init __efi_enter_virtual_mode(void)
 
 	efi_sync_low_kernel_mappings();
 
-	if (efi_is_native()) {
+	if (!efi_is_mixed()) {
 		status = phys_efi_set_virtual_address_map(
 				efi.memmap.desc_size * count,
 				efi.memmap.desc_size,
@@ -1071,7 +1071,7 @@ static void __init __efi_enter_virtual_mode(void)
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
2.20.1

