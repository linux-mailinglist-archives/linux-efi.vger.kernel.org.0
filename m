Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B882A369D
	for <lists+linux-efi@lfdr.de>; Mon,  2 Nov 2020 23:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725785AbgKBWi0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Nov 2020 17:38:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:55236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgKBWiZ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 2 Nov 2020 17:38:25 -0500
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14EEC22384;
        Mon,  2 Nov 2020 22:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604356704;
        bh=W6puH/ry+3qo06s1xpa3gn2nlx7yJ1jJ2qy1z+5RQKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CCskhuPZ+cYFf+ExURczE6E1XnYSL1h7baPT5oi9FwHXRGt4sASBs/Zz79KTB5/hK
         et4gbTN+a8oxI0yZo12brEg2hALvJ9Q3bJ54/yN96/QqR+aL3kjrDP3NsqfNQMB+RS
         3D3Ajekj7unLylICLIHETflTKnd/6w/FxHHVOs5M=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, zohar@linux.ibm.com,
        jmorris@namei.org, serge@hallyn.com, dmitry.kasatkin@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, clin@suse.com,
        x86@kernel.org, jlee@suse.com, linux-integrity@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 1/3] efi: generalize efi_get_secureboot
Date:   Mon,  2 Nov 2020 23:37:58 +0100
Message-Id: <20201102223800.12181-2-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201102223800.12181-1-ardb@kernel.org>
References: <20201102223800.12181-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Chester Lin <clin@suse.com>

Generalize the efi_get_secureboot() function so not only efistub but also
other subsystems can use it.

Note that the MokSbState handling is not factored out: the variable is
boot time only, and so it cannot be parameterized as easily. Also, the
IMA code will switch to this version in a future patch, and it does not
incorporate the MokSbState exception in the first place.

Note that the new efi_get_secureboot_mode() helper treats any failures
to read SetupMode as setup mode being disabled.

Co-developed-by: Chester Lin <clin@suse.com>
Signed-off-by: Chester Lin <clin@suse.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/Makefile         |  2 +-
 drivers/firmware/efi/libstub/efistub.h    |  2 +
 drivers/firmware/efi/libstub/secureboot.c | 41 +++++++-------------
 include/linux/efi.h                       | 23 ++++++++++-
 4 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index ee249088cbfe..8d358a6fe6ec 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -35,7 +35,7 @@ cflags-$(CONFIG_X86_32) := -march=i386
 cflags-$(CONFIG_X86_64) := -mcmodel=small -mno-red-zone
 KBUILD_CFLAGS += $(cflags-y)
 KBUILD_CFLAGS += -mno-mmx -mno-sse
-KBUILD_CFLAGS += -ffreestanding
+KBUILD_CFLAGS += -ffreestanding -fshort-wchar
 KBUILD_CFLAGS += -fno-stack-protector
 KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
 KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 2d7abcd99de9..b8ec29d6a74a 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -848,4 +848,6 @@ asmlinkage void __noreturn efi_enter_kernel(unsigned long entrypoint,
 
 void efi_handle_post_ebs_state(void);
 
+enum efi_secureboot_mode efi_get_secureboot(void);
+
 #endif
diff --git a/drivers/firmware/efi/libstub/secureboot.c b/drivers/firmware/efi/libstub/secureboot.c
index 5efc524b14be..af18d86c1604 100644
--- a/drivers/firmware/efi/libstub/secureboot.c
+++ b/drivers/firmware/efi/libstub/secureboot.c
@@ -12,15 +12,16 @@
 
 #include "efistub.h"
 
-/* BIOS variables */
-static const efi_guid_t efi_variable_guid = EFI_GLOBAL_VARIABLE_GUID;
-static const efi_char16_t efi_SecureBoot_name[] = L"SecureBoot";
-static const efi_char16_t efi_SetupMode_name[] = L"SetupMode";
-
 /* SHIM variables */
 static const efi_guid_t shim_guid = EFI_SHIM_LOCK_GUID;
 static const efi_char16_t shim_MokSBState_name[] = L"MokSBState";
 
+static efi_status_t get_var(efi_char16_t *name, efi_guid_t *vendor, u32 *attr,
+			    unsigned long *data_size, void *data)
+{
+	return get_efi_var(name, vendor, attr, data_size, data);
+}
+
 /*
  * Determine whether we're in secure boot mode.
  *
@@ -30,26 +31,18 @@ static const efi_char16_t shim_MokSBState_name[] = L"MokSBState";
 enum efi_secureboot_mode efi_get_secureboot(void)
 {
 	u32 attr;
-	u8 secboot, setupmode, moksbstate;
 	unsigned long size;
+	enum efi_secureboot_mode mode;
 	efi_status_t status;
+	u8 moksbstate;
 
-	size = sizeof(secboot);
-	status = get_efi_var(efi_SecureBoot_name, &efi_variable_guid,
-			     NULL, &size, &secboot);
-	if (status == EFI_NOT_FOUND)
-		return efi_secureboot_mode_disabled;
-	if (status != EFI_SUCCESS)
-		goto out_efi_err;
-
-	size = sizeof(setupmode);
-	status = get_efi_var(efi_SetupMode_name, &efi_variable_guid,
-			     NULL, &size, &setupmode);
-	if (status != EFI_SUCCESS)
-		goto out_efi_err;
-
-	if (secboot == 0 || setupmode == 1)
-		return efi_secureboot_mode_disabled;
+	mode = efi_get_secureboot_mode(get_var);
+	if (mode == efi_secureboot_mode_unknown) {
+		efi_err("Could not determine UEFI Secure Boot status.\n");
+		return efi_secureboot_mode_unknown;
+	}
+	if (mode != efi_secureboot_mode_enabled)
+		return mode;
 
 	/*
 	 * See if a user has put the shim into insecure mode. If so, and if the
@@ -69,8 +62,4 @@ enum efi_secureboot_mode efi_get_secureboot(void)
 secure_boot_enabled:
 	efi_info("UEFI Secure Boot is enabled.\n");
 	return efi_secureboot_mode_enabled;
-
-out_efi_err:
-	efi_err("Could not determine UEFI Secure Boot status.\n");
-	return efi_secureboot_mode_unknown;
 }
diff --git a/include/linux/efi.h b/include/linux/efi.h
index bd9d83a94173..79b2d4de62e0 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1082,7 +1082,28 @@ enum efi_secureboot_mode {
 	efi_secureboot_mode_disabled,
 	efi_secureboot_mode_enabled,
 };
-enum efi_secureboot_mode efi_get_secureboot(void);
+
+static inline
+enum efi_secureboot_mode efi_get_secureboot_mode(efi_get_variable_t *get_var)
+{
+	u8 secboot, setupmode = 0;
+	efi_status_t status;
+	unsigned long size;
+
+	size = sizeof(secboot);
+	status = get_var(L"SecureBoot", &EFI_GLOBAL_VARIABLE_GUID, NULL, &size,
+			 &secboot);
+	if (status == EFI_NOT_FOUND)
+		return efi_secureboot_mode_disabled;
+	if (status != EFI_SUCCESS)
+		return efi_secureboot_mode_unknown;
+
+	size = sizeof(setupmode);
+	get_var(L"SetupMode", &EFI_GLOBAL_VARIABLE_GUID, NULL, &size, &setupmode);
+	if (secboot == 0 || setupmode == 1)
+		return efi_secureboot_mode_disabled;
+	return efi_secureboot_mode_enabled;
+}
 
 #ifdef CONFIG_RESET_ATTACK_MITIGATION
 void efi_enable_reset_attack_mitigation(void);
-- 
2.17.1

