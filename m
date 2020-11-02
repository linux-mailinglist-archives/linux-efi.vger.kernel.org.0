Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D522A369F
	for <lists+linux-efi@lfdr.de>; Mon,  2 Nov 2020 23:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgKBWi3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Nov 2020 17:38:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:55294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgKBWi3 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 2 Nov 2020 17:38:29 -0500
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C657223BD;
        Mon,  2 Nov 2020 22:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604356708;
        bh=jd0lc7xktVJyaT/5sIC7f3m8eRs2yFAtQQ04Ih829IY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IchjoCRxZbA3ne8F7g7b654KXF+ZkWB8urgEdXLMh0b2IGqdm5GjtSgqKT22Sd0rE
         YjNVvJwsGkdQDIaBMxr0DPrF+gK8SXv85xrZR0BMPevMYtFK95JqMW9eG0GLJ9GJD3
         KADjwzNTU6f5tB596kdj+VyWJuPfcTP7ZxR7VvYQ=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, zohar@linux.ibm.com,
        jmorris@namei.org, serge@hallyn.com, dmitry.kasatkin@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, clin@suse.com,
        x86@kernel.org, jlee@suse.com, linux-integrity@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 2/3] ima: generalize x86/EFI arch glue for other EFI architectures
Date:   Mon,  2 Nov 2020 23:37:59 +0100
Message-Id: <20201102223800.12181-3-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201102223800.12181-1-ardb@kernel.org>
References: <20201102223800.12181-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Chester Lin <clin@suse.com>

Move the x86 IMA arch code into security/integrity/ima/ima_efi.c,
so that we will be able to wire it up for arm64 in a future patch.

Co-developed-by: Chester Lin <clin@suse.com>
Signed-off-by: Chester Lin <clin@suse.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/efi.h                                     |  3 ++
 arch/x86/kernel/Makefile                                       |  2 -
 security/integrity/ima/Makefile                                |  4 ++
 arch/x86/kernel/ima_arch.c => security/integrity/ima/ima_efi.c | 45 ++++++--------------
 4 files changed, 19 insertions(+), 35 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 7673dc833232..c98f78330b09 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -380,4 +380,7 @@ static inline void efi_fake_memmap_early(void)
 }
 #endif
 
+#define arch_ima_efi_boot_mode	\
+	({ extern struct boot_params boot_params; boot_params.secure_boot; })
+
 #endif /* _ASM_X86_EFI_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 68608bd892c0..5eeb808eb024 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -161,5 +161,3 @@ ifeq ($(CONFIG_X86_64),y)
 	obj-$(CONFIG_MMCONF_FAM10H)	+= mmconf-fam10h_64.o
 	obj-y				+= vsmp_64.o
 endif
-
-obj-$(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT)	+= ima_arch.o
diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
index 67dabca670e2..2499f2485c04 100644
--- a/security/integrity/ima/Makefile
+++ b/security/integrity/ima/Makefile
@@ -14,3 +14,7 @@ ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
 ima-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
 ima-$(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) += ima_asymmetric_keys.o
 ima-$(CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS) += ima_queue_keys.o
+
+ifeq ($(CONFIG_EFI),y)
+ima-$(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT) += ima_efi.o
+endif
diff --git a/arch/x86/kernel/ima_arch.c b/security/integrity/ima/ima_efi.c
similarity index 60%
rename from arch/x86/kernel/ima_arch.c
rename to security/integrity/ima/ima_efi.c
index 7dfb1e808928..233627a9d4b8 100644
--- a/arch/x86/kernel/ima_arch.c
+++ b/security/integrity/ima/ima_efi.c
@@ -5,50 +5,29 @@
 #include <linux/efi.h>
 #include <linux/module.h>
 #include <linux/ima.h>
+#include <asm/efi.h>
 
-extern struct boot_params boot_params;
+#ifndef arch_ima_efi_boot_mode
+#define arch_ima_efi_boot_mode efi_secureboot_mode_unknown
+#endif
 
 static enum efi_secureboot_mode get_sb_mode(void)
 {
-	efi_guid_t efi_variable_guid = EFI_GLOBAL_VARIABLE_GUID;
-	efi_status_t status;
-	unsigned long size;
-	u8 secboot, setupmode;
-
-	size = sizeof(secboot);
+	enum efi_secureboot_mode mode;
 
 	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE)) {
 		pr_info("ima: secureboot mode unknown, no efi\n");
 		return efi_secureboot_mode_unknown;
 	}
 
-	/* Get variable contents into buffer */
-	status = efi.get_variable(L"SecureBoot", &efi_variable_guid,
-				  NULL, &size, &secboot);
-	if (status == EFI_NOT_FOUND) {
+	mode = efi_get_secureboot_mode(efi.get_variable);
+	if (mode == efi_secureboot_mode_disabled)
 		pr_info("ima: secureboot mode disabled\n");
-		return efi_secureboot_mode_disabled;
-	}
-
-	if (status != EFI_SUCCESS) {
+	else if (mode == efi_secureboot_mode_unknown)
 		pr_info("ima: secureboot mode unknown\n");
-		return efi_secureboot_mode_unknown;
-	}
-
-	size = sizeof(setupmode);
-	status = efi.get_variable(L"SetupMode", &efi_variable_guid,
-				  NULL, &size, &setupmode);
-
-	if (status != EFI_SUCCESS)	/* ignore unknown SetupMode */
-		setupmode = 0;
-
-	if (secboot == 0 || setupmode == 1) {
-		pr_info("ima: secureboot mode disabled\n");
-		return efi_secureboot_mode_disabled;
-	}
-
-	pr_info("ima: secureboot mode enabled\n");
-	return efi_secureboot_mode_enabled;
+	else
+		pr_info("ima: secureboot mode enabled\n");
+	return mode;
 }
 
 bool arch_ima_get_secureboot(void)
@@ -57,7 +36,7 @@ bool arch_ima_get_secureboot(void)
 	static bool initialized;
 
 	if (!initialized && efi_enabled(EFI_BOOT)) {
-		sb_mode = boot_params.secure_boot;
+		sb_mode = arch_ima_efi_boot_mode;
 
 		if (sb_mode == efi_secureboot_mode_unset)
 			sb_mode = get_sb_mode();
-- 
2.17.1

