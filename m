Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B252812F78E
	for <lists+linux-efi@lfdr.de>; Fri,  3 Jan 2020 12:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbgACLkX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Jan 2020 06:40:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:39590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727710AbgACLkW (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 3 Jan 2020 06:40:22 -0500
Received: from localhost.localdomain (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8087F21D7D;
        Fri,  3 Jan 2020 11:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578051622;
        bh=Nm2GkN0v9JKdH/m8HQfUDrkVQHewuDa6fkB1QsjK/gE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gM0HEUomdf0vd7sFWAS7ee/Q2WvLCNYl0RhZHc50FOwHi0L3RNBVPKmcnscAxXpA+
         m5PhsF1pgJhtA5526c/hekj/ugc/J/NMtGJ5L4sfyVz8QWZi1lfkS5G+lX/uorWK3y
         zkrCVBuHnsA9KVEt+iyld67rfdMZ3C2QKys1+5MQ=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Matthew Garrett <mjg59@google.com>
Subject: [PATCH 03/20] efi/x86: re-disable RT services for 32-bit kernels running on 64-bit EFI
Date:   Fri,  3 Jan 2020 12:39:36 +0100
Message-Id: <20200103113953.9571-4-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200103113953.9571-1-ardb@kernel.org>
References: <20200103113953.9571-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit a8147dba75b1 ("efi/x86: Rename efi_is_native() to efi_is_mixed()")
renamed and refactored efi_is_native() into efi_is_mixed(), but failed
to take into account that these are not diametrical opposites.

Mixed mode is a construct that permits 64-bit kernels to boot on 32-bit
firmware, but there is another non-native combination which is supported,
i.e., 32-bit kernels booting on 64-bit firmware, but only for boot and not
for runtime services. Also, mixed mode can be disabled in Kconfig, in
which case the 64-bit kernel can still be booted from 32-bit firmware,
but without access to runtime services.

Due to this oversight, efi_runtime_supported() now incorrectly returns
true for such configurations, resulting in crashes at boot. So fix this
by making efi_runtime_supported() aware of this.

As a side effect, some efi_thunk_xxx() stubs have become obsolete, so
remove them as well.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/efi.h | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 2d1378f19b74..b35b5d423e9d 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -163,10 +163,10 @@ static inline bool efi_is_mixed(void)
 
 static inline bool efi_runtime_supported(void)
 {
-	if (!efi_is_mixed())
+	if (IS_ENABLED(CONFIG_X86_64) == efi_enabled(EFI_64BIT))
 		return true;
 
-	if (!efi_enabled(EFI_OLD_MEMMAP))
+	if (IS_ENABLED(CONFIG_EFI_MIXED) && !efi_enabled(EFI_OLD_MEMMAP))
 		return true;
 
 	return false;
@@ -176,7 +176,6 @@ extern void parse_efi_setup(u64 phys_addr, u32 data_len);
 
 extern void efifb_setup_from_dmi(struct screen_info *si, const char *opt);
 
-#ifdef CONFIG_EFI_MIXED
 extern void efi_thunk_runtime_setup(void);
 extern efi_status_t efi_thunk_set_virtual_address_map(
 	void *phys_set_virtual_address_map,
@@ -184,19 +183,6 @@ extern efi_status_t efi_thunk_set_virtual_address_map(
 	unsigned long descriptor_size,
 	u32 descriptor_version,
 	efi_memory_desc_t *virtual_map);
-#else
-static inline void efi_thunk_runtime_setup(void) {}
-static inline efi_status_t efi_thunk_set_virtual_address_map(
-	void *phys_set_virtual_address_map,
-	unsigned long memory_map_size,
-	unsigned long descriptor_size,
-	u32 descriptor_version,
-	efi_memory_desc_t *virtual_map)
-{
-	return EFI_SUCCESS;
-}
-#endif /* CONFIG_EFI_MIXED */
-
 
 /* arch specific definitions used by the stub code */
 
-- 
2.20.1

