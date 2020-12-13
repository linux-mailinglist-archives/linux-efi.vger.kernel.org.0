Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B042D8D6D
	for <lists+linux-efi@lfdr.de>; Sun, 13 Dec 2020 14:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394736AbgLMNxF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 13 Dec 2020 08:53:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:59984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387999AbgLMNxF (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 13 Dec 2020 08:53:05 -0500
From:   Ard Biesheuvel <ardb@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-efi@vger.kernel.org
Cc:     tony.luck@intel.com, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] efi: ia64: disable the capsule loader
Date:   Sun, 13 Dec 2020 14:52:14 +0100
Message-Id: <20201213135214.85360-1-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

EFI capsule loading is a feature that was introduced into EFI long after
its initial introduction on Itanium, and it is highly unlikely that IA64
systems are receiving firmware updates in the first place, let alone
using EFI capsules.

So let's disable capsule support altogether on IA64. This fixes a build
error on IA64 due to a recent change that added an unconditional
include of asm/efi.h, which IA64 does not provide.

While at it, tweak the make rules a bit so that the EFI capsule
component that is always builtin (even if the EFI capsule loader itself
is built as a module) is omitted for all architectures if the module is
not enabled in the build.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/Kconfig  | 2 +-
 drivers/firmware/efi/Makefile | 5 ++++-
 include/linux/efi.h           | 4 ++++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index b452cfa2100b..5ac2a37ed025 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -147,7 +147,7 @@ config EFI_BOOTLOADER_CONTROL
 
 config EFI_CAPSULE_LOADER
 	tristate "EFI capsule loader"
-	depends on EFI
+	depends on EFI && !IA64
 	help
 	  This option exposes a loader interface "/dev/efi_capsule_loader" for
 	  users to load EFI capsules. This driver requires working runtime
diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index d6ca2da19339..467e94259679 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -12,7 +12,10 @@ KASAN_SANITIZE_runtime-wrappers.o	:= n
 
 obj-$(CONFIG_ACPI_BGRT) 		+= efi-bgrt.o
 obj-$(CONFIG_EFI)			+= efi.o vars.o reboot.o memattr.o tpm.o
-obj-$(CONFIG_EFI)			+= capsule.o memmap.o
+obj-$(CONFIG_EFI)			+= memmap.o
+ifneq ($(CONFIG_EFI_CAPSULE_LOADER),)
+obj-$(CONFIG_EFI)			+= capsule.o
+endif
 obj-$(CONFIG_EFI_PARAMS_FROM_FDT)	+= fdtparams.o
 obj-$(CONFIG_EFI_VARS)			+= efivars.o
 obj-$(CONFIG_EFI_ESRT)			+= esrt.o
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 1cd5d91d8ca1..b5943a88d690 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1038,6 +1038,7 @@ bool efivar_validate(efi_guid_t vendor, efi_char16_t *var_name, u8 *data,
 bool efivar_variable_is_removable(efi_guid_t vendor, const char *name,
 				  size_t len);
 
+#ifdef CONFIG_EFI_CAPSULE_LOADER
 extern bool efi_capsule_pending(int *reset_type);
 
 extern int efi_capsule_supported(efi_guid_t guid, u32 flags,
@@ -1045,6 +1046,9 @@ extern int efi_capsule_supported(efi_guid_t guid, u32 flags,
 
 extern int efi_capsule_update(efi_capsule_header_t *capsule,
 			      phys_addr_t *pages);
+#else
+static inline bool efi_capsule_pending(int *reset_type) { return false; }
+#endif
 
 #ifdef CONFIG_EFI_RUNTIME_MAP
 int efi_runtime_map_init(struct kobject *);
-- 
2.20.1

