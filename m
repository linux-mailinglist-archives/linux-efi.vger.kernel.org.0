Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3496261ECF3
	for <lists+linux-efi@lfdr.de>; Mon,  7 Nov 2022 09:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbiKGIbt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Nov 2022 03:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiKGIbr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Nov 2022 03:31:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB03140AA
        for <linux-efi@vger.kernel.org>; Mon,  7 Nov 2022 00:31:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A27B5B80E30
        for <linux-efi@vger.kernel.org>; Mon,  7 Nov 2022 08:31:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C512C433C1;
        Mon,  7 Nov 2022 08:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667809903;
        bh=Aln1nSpmBccCqlxn2AqxaLIwKmnD2kETPzdNwtD2bJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q2kGhSMsfy2FYLG24eva4JNMUjv+LC2PWZIVNIh9fFx6Rgo1oLXUIZtXK0O8Nhl1H
         0bHZrGz02+oKbj+rKrLOQvd5m3ncNfMTc99cAaFOUdG4sPCLrHDb3yzrIERWIXQj+9
         WweOJU72o/lZ3C1gB5rFSNhvW65Q6pjVighq9SZ5N1Ny2w05G2ec60YICSn/flA3r2
         iwK1sn0FNMHRi53tM+gL4L9jhLuTrAJbniHJV8PU69tUUhZjCS85plIgRH8CkEjTrW
         3zcmEjIyXCR1oTOT4B43kwh8BIxpQS/wXEZp2ShDOUBWUKU2Wr/c88QVYJ6nTe/vKw
         FPo9BbsL7u26Q==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     dyoung@redhat.com, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 2/2] efi: x86: Move EFI runtime map sysfs code to arch/x86
Date:   Mon,  7 Nov 2022 09:31:34 +0100
Message-Id: <20221107083134.234918-3-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221107083134.234918-1-ardb@kernel.org>
References: <20221107083134.234918-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7569; i=ardb@kernel.org; h=from:subject; bh=Aln1nSpmBccCqlxn2AqxaLIwKmnD2kETPzdNwtD2bJ8=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjaMJlFuRNgsHwccYIYZ+zqjaguW6L0l8rb3ESVmQ4 C1lRyBWJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY2jCZQAKCRDDTyI5ktmPJL7tC/ 9HEldz2Zp3gblPmxyjHLAYH02XyJUZd1jnGYSDe4R+PyDNpzMjKtUFMamgiBaXRGu8QTOPfD2WFeEi fTBRQmRDjKheyQ8mzPGAYP4qZWAiIofiXENBDjE+8P4gZFKmxgmc5mMeWULg7VESwy9Zbe5hclqcDk LYs2j/paD/aoZXYhZkUvhe5VP2iHDMjqtFptao6N1WP1W3mt67404MdrVFQQSoJhJJmiCFRkDNuL8n 960oZbTO6yBDlVHkSqg4c2XGON8pjrlw6H9HOhAKjGh++TQWj5AalgWAvZyTaNHomq8sur+bK1f3fV QRmSeDk3SxQNK4hdgNqqp81m8eMq4RDPO1aEdxlf+EioC33qQ5nxfxzZ1Bcrx224GF/lmhb2xKkSyG /EdiaVqTjOGrEg3AMWZOfKtBsOmOKqn3xz2kKps4GNua4MTktaklJpetQ87TBRRE81bD6GjYdJT6a3 Cl4Pq0qtscGB+d0b8625ruPbXD9W26kYb30pfwakvvzfw=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The EFI runtime map code is only wired up on x86, which is the only
architecture that has a need for it in its implementation of kexec.

So let's move this code under arch/x86 and drop all references to it
from generic code. To ensure that the efi_runtime_map_init() is invoked
at the appropriate time use a 'sync' subsys_initcall() that will be
called right after the EFI initcall made from generic code where the
original invocation of efi_runtime_map_init() resided.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/Kconfig                                          | 11 ++++++++
 arch/x86/include/asm/efi.h                                | 22 +++++++++++++++
 arch/x86/platform/efi/Makefile                            |  1 +
 {drivers/firmware => arch/x86/platform}/efi/runtime-map.c |  6 ++---
 drivers/firmware/efi/Kconfig                              | 11 --------
 drivers/firmware/efi/Makefile                             |  1 -
 drivers/firmware/efi/efi.c                                |  5 +---
 include/linux/efi.h                                       | 28 --------------------
 8 files changed, 38 insertions(+), 47 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 99ece961c1010f53..79baff0cc7b9a181 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2015,6 +2015,17 @@ config EFI_MAX_FAKE_MEM
 	  Ranges can be set up to this value using comma-separated list.
 	  The default value is 8.
 
+config EFI_RUNTIME_MAP
+	bool "Export EFI runtime maps to sysfs" if EXPERT
+	depends on EFI
+	default KEXEC_CORE
+	help
+	  Export EFI runtime memory regions to /sys/firmware/efi/runtime-map.
+	  That memory map is required by the 2nd kernel to set up EFI virtual
+	  mappings after kexec, but can also be used for debugging purposes.
+
+	  See also Documentation/ABI/testing/sysfs-firmware-efi-runtime-map.
+
 source "kernel/Kconfig.hz"
 
 config KEXEC
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 011b710cc42cd060..47ebee3dffde9063 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -431,4 +431,26 @@ extern void __init efi_memmap_insert(struct efi_memory_map *old_memmap,
 #define arch_ima_efi_boot_mode	\
 	({ extern struct boot_params boot_params; boot_params.secure_boot; })
 
+#ifdef CONFIG_EFI_RUNTIME_MAP
+int efi_get_runtime_map_size(void);
+int efi_get_runtime_map_desc_size(void);
+int efi_runtime_map_copy(void *buf, size_t bufsz);
+#else
+static inline int efi_get_runtime_map_size(void)
+{
+	return 0;
+}
+
+static inline int efi_get_runtime_map_desc_size(void)
+{
+	return 0;
+}
+
+static inline int efi_runtime_map_copy(void *buf, size_t bufsz)
+{
+	return 0;
+}
+
+#endif
+
 #endif /* _ASM_X86_EFI_H */
diff --git a/arch/x86/platform/efi/Makefile b/arch/x86/platform/efi/Makefile
index ed5502a5185d4ead..543df9a1379d121c 100644
--- a/arch/x86/platform/efi/Makefile
+++ b/arch/x86/platform/efi/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_EFI) 		+= memmap.o quirks.o efi.o efi_$(BITS).o \
 				   efi_stub_$(BITS).o
 obj-$(CONFIG_EFI_MIXED)		+= efi_thunk_$(BITS).o
 obj-$(CONFIG_EFI_FAKE_MEMMAP)	+= fake_mem.o
+obj-$(CONFIG_EFI_RUNTIME_MAP)	+= runtime-map.o
diff --git a/drivers/firmware/efi/runtime-map.c b/arch/x86/platform/efi/runtime-map.c
similarity index 97%
rename from drivers/firmware/efi/runtime-map.c
rename to arch/x86/platform/efi/runtime-map.c
index 92a3d45a795cd5e4..cc35efaeaaa3b5eb 100644
--- a/drivers/firmware/efi/runtime-map.c
+++ b/arch/x86/platform/efi/runtime-map.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * linux/drivers/efi/runtime-map.c
  * Copyright (C) 2013 Red Hat, Inc., Dave Young <dyoung@redhat.com>
  */
 
@@ -157,13 +156,13 @@ int efi_runtime_map_copy(void *buf, size_t bufsz)
 	return 0;
 }
 
-int __init efi_runtime_map_init(struct kobject *efi_kobj)
+static int __init efi_runtime_map_init(void)
 {
 	int i, j, ret = 0;
 	struct efi_runtime_map_entry *entry;
 	efi_memory_desc_t *md;
 
-	if (!efi_enabled(EFI_MEMMAP))
+	if (!efi_enabled(EFI_MEMMAP) || !efi_kobj)
 		return 0;
 
 	map_entries = kcalloc(efi.memmap.nr_map, sizeof(entry), GFP_KERNEL);
@@ -191,3 +190,4 @@ int __init efi_runtime_map_init(struct kobject *efi_kobj)
 out:
 	return ret;
 }
+subsys_initcall_sync(efi_runtime_map_init);
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 552512f211a1f5e7..08ed88e49ea307b0 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -26,17 +26,6 @@ config EFI_VARS_PSTORE_DEFAULT_DISABLE
 	  backend for pstore by default. This setting can be overridden
 	  using the efivars module's pstore_disable parameter.
 
-config EFI_RUNTIME_MAP
-	bool "Export EFI runtime maps to sysfs" if EXPERT
-	depends on X86 && EFI
-	default KEXEC_CORE
-	help
-	  Export EFI runtime memory regions to /sys/firmware/efi/runtime-map.
-	  That memory map is required by the 2nd kernel to set up EFI virtual
-	  mappings after kexec, but can also be used for debugging purposes.
-
-	  See also Documentation/ABI/testing/sysfs-firmware-efi-runtime-map.
-
 config EFI_SOFT_RESERVE
 	bool "Reserve EFI Specific Purpose Memory"
 	depends on EFI && EFI_STUB && ACPI_HMAT
diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index 8e4f0d5b26e542c3..7d3b08cc8c5a2813 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -20,7 +20,6 @@ obj-$(CONFIG_EFI_PARAMS_FROM_FDT)	+= fdtparams.o
 obj-$(CONFIG_EFI_ESRT)			+= esrt.o
 obj-$(CONFIG_EFI_VARS_PSTORE)		+= efi-pstore.o
 obj-$(CONFIG_UEFI_CPER)			+= cper.o
-obj-$(CONFIG_EFI_RUNTIME_MAP)		+= runtime-map.o
 obj-$(CONFIG_EFI_RUNTIME_WRAPPERS)	+= runtime-wrappers.o
 subdir-$(CONFIG_EFI_STUB)		+= libstub
 obj-$(CONFIG_EFI_BOOTLOADER_CONTROL)	+= efibc.o
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 84a3e52fe8880311..4f2879cde0a51d57 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -394,10 +394,6 @@ static int __init efisubsys_init(void)
 		goto err_unregister;
 	}
 
-	error = efi_runtime_map_init(efi_kobj);
-	if (error)
-		goto err_remove_group;
-
 	/* and the standard mountpoint for efivarfs */
 	error = sysfs_create_mount_point(efi_kobj, "efivars");
 	if (error) {
@@ -423,6 +419,7 @@ static int __init efisubsys_init(void)
 		generic_ops_unregister();
 err_put:
 	kobject_put(efi_kobj);
+	efi_kobj = NULL;
 	destroy_workqueue(efi_rts_wq);
 	return error;
 }
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 16b7318957b0709f..13bf2574a5d76c9e 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1091,34 +1091,6 @@ extern int efi_capsule_update(efi_capsule_header_t *capsule,
 static inline bool efi_capsule_pending(int *reset_type) { return false; }
 #endif
 
-#ifdef CONFIG_EFI_RUNTIME_MAP
-int efi_runtime_map_init(struct kobject *);
-int efi_get_runtime_map_size(void);
-int efi_get_runtime_map_desc_size(void);
-int efi_runtime_map_copy(void *buf, size_t bufsz);
-#else
-static inline int efi_runtime_map_init(struct kobject *kobj)
-{
-	return 0;
-}
-
-static inline int efi_get_runtime_map_size(void)
-{
-	return 0;
-}
-
-static inline int efi_get_runtime_map_desc_size(void)
-{
-	return 0;
-}
-
-static inline int efi_runtime_map_copy(void *buf, size_t bufsz)
-{
-	return 0;
-}
-
-#endif
-
 #ifdef CONFIG_EFI
 extern bool efi_runtime_disabled(void);
 #else
-- 
2.35.1

