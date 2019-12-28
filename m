Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB0812BDE7
	for <lists+linux-efi@lfdr.de>; Sat, 28 Dec 2019 16:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfL1PV6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 28 Dec 2019 10:21:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:32950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfL1PV6 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 28 Dec 2019 10:21:58 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 781B920838;
        Sat, 28 Dec 2019 15:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577546517;
        bh=TudBKfV85+OP2Ddjyx6pdmHwGXQc6GcY+nAu3kXWZD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mRit0gqaxbdz+c53CxW+0jC2NJ1iOVmNV8QFtIG7wK5sWMpBtRj9aUEGI0Zqbh7QJ
         Ou6rdEmWyKIMSpxBp65T9KqT6hA8OHkWIcFUzoapGYDYhu8rnuccZqjj5Iq3xR7Qx5
         fJWnE3n8NXNA0arFAubXPUvKriqwV2qfgg4OYJyI=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 3/7] efi/x86: re-disable RT services for 32-bit kernels running on 64-bit EFI
Date:   Sat, 28 Dec 2019 16:21:05 +0100
Message-Id: <20191228152109.6301-4-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191228152109.6301-1-ardb@kernel.org>
References: <20191228152109.6301-1-ardb@kernel.org>
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
for runtime services.

Due to this oversight, efi_runtime_supported() now incorrectly returns
true for such configurations, resulting in crashes at boot. So fix this
by making efi_runtime_supported() aware of this.

As a side effect, some efi_thunk_xxx() stubs have become obsolete, so
remove them as well.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/efi.h | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 2d1378f19b74..9f4281aae779 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -163,6 +163,9 @@ static inline bool efi_is_mixed(void)
 
 static inline bool efi_runtime_supported(void)
 {
+	if (IS_ENABLED(CONFIG_X86_32))
+		return !efi_enabled(EFI_64BIT);
+
 	if (!efi_is_mixed())
 		return true;
 
@@ -176,7 +179,6 @@ extern void parse_efi_setup(u64 phys_addr, u32 data_len);
 
 extern void efifb_setup_from_dmi(struct screen_info *si, const char *opt);
 
-#ifdef CONFIG_EFI_MIXED
 extern void efi_thunk_runtime_setup(void);
 extern efi_status_t efi_thunk_set_virtual_address_map(
 	void *phys_set_virtual_address_map,
@@ -184,19 +186,6 @@ extern efi_status_t efi_thunk_set_virtual_address_map(
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
2.17.1

