Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC4655363E
	for <lists+linux-efi@lfdr.de>; Tue, 21 Jun 2022 17:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352492AbiFUPhE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 21 Jun 2022 11:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352299AbiFUPgz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 21 Jun 2022 11:36:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE9B15A04;
        Tue, 21 Jun 2022 08:36:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71573B81A3D;
        Tue, 21 Jun 2022 15:36:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001F8C341CA;
        Tue, 21 Jun 2022 15:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655825810;
        bh=AyMf5a6EWC7oeWOHfGJtd0LBp6KIPFK+tiDrxGR2nKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h3J+Klj6gYyxK/YAFeFhUptg5yAxoIXrQn5dofyG8qfygFVBeIZLVVaT8jU6/Jxc2
         eeoK4fBbQTlaxzPLcHSvWRYYxgBPA5R+6uvFN6jNty+1o3NUimdUWUW9fQAi7GXabC
         am+CMnPj6snc7tcc04xe8ceKQRo5up62WVRLlX5hEuOPS4bgNsS/VxglHf9AkV9Hhb
         S+XRNSdyfYSgtU3bWcyQ2BY3ypKXWUIQXapsV0I1/Sli3hSivcTB+0N219VB/0jd9b
         3H6gpG6MUYanoT3G4VSDKaO1jijY8IZikPtHVPonClTK+x4lWGKSu5FTzlByvntBAq
         UltoA6pGrbZ5Q==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v2 7/9] efi: vars: Remove deprecated 'efivars' sysfs interface
Date:   Tue, 21 Jun 2022 17:36:21 +0200
Message-Id: <20220621153623.3786960-8-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220621153623.3786960-1-ardb@kernel.org>
References: <20220621153623.3786960-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=35820; h=from:subject; bh=AyMf5a6EWC7oeWOHfGJtd0LBp6KIPFK+tiDrxGR2nKs=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiseVytfTmqfu104N0Nx73IQDGraHI3QfmCrBaKpqV 3PW748OJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYrHlcgAKCRDDTyI5ktmPJH05C/ 436jTQIjK8PUFQv9EZPnDJdKv3YAzpuTx/ZlLOkdM8j7n20NgDzFxxi3gnb1X1IIZVfOG0W4rx2sYQ USt6ADepag53z0y0ZWD/JEz8htiH98mG/dvluffvYpmdsYr4u2rmVSNXfxpk83G7MBC0jPrLirmXHZ GeD5UsUzil21tTlQCsxBNatdJ+qzfu3H8L818geImAmFHjdUoZ89U+UVKL/71wu+LWkjAB668wU1Hs CnIWVbZSG8Ub5EJrzdasvKx2SbeQNKtQxO3fAOP0upK35WPIFrkNV0Euft5nd6jSPOegh9DyhgDXWp 3LgPq7Q8Zm+LALt6w225xjQUCPI7y09U7CvsE6vw1uccUcwGWYkr6ftsH8lDCbVFAXtERRpN0Nh07O m4Aaa+yJXlTjgOcXwFmvtKBa6+YKEt43VDQ7AxL51oNEnkZhdKv0S6gop/IqkmlJGu9KPt8wSKhpYl /xczAZ3M5cdmClxTUV5B4DLAL5w+9EzPWFrXaxu7HTKMQ=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit 5d9db883761a ("efi: Add support for a UEFI variable filesystem")
dated Oct 5, 2012, introduced a new efivarfs pseudo-filesystem to
replace the efivars sysfs interface that was used up to that point to
expose EFI variables to user space.

The main problem with the sysfs interface was that it only supported up
to 1024 bytes of payload per file, whereas the underlying variables
themselves are only bounded by a platform specific per-variable and
global limit that is typically much higher than 1024 bytes.

The deprecated sysfs interface is only enabled on x86 and Itanium, other
EFI enabled architectures only support the efivarfs pseudo-filesystem.

So let's finally rip off the band aid, and drop the old interface
entirely. This will make it easier to refactor and clean up the
underlying infrastructure that is shared between efivars, efivarfs and
efi-pstore, and is long overdue for a makeover.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 Documentation/x86/x86_64/uefi.rst        |   2 +-
 arch/arm/configs/milbeaut_m10v_defconfig |   1 -
 arch/ia64/configs/bigsur_defconfig       |   1 -
 arch/ia64/configs/generic_defconfig      |   1 -
 arch/ia64/configs/gensparse_defconfig    |   1 -
 arch/ia64/configs/tiger_defconfig        |   1 -
 arch/ia64/configs/zx1_defconfig          |   1 -
 arch/x86/configs/i386_defconfig          |   1 -
 arch/x86/configs/x86_64_defconfig        |   1 -
 drivers/firmware/efi/Kconfig             |  12 -
 drivers/firmware/efi/Makefile            |   1 -
 drivers/firmware/efi/efivars.c           | 660 --------------------
 drivers/firmware/efi/vars.c              | 265 +-------
 include/linux/efi.h                      |  18 -
 14 files changed, 3 insertions(+), 963 deletions(-)

diff --git a/Documentation/x86/x86_64/uefi.rst b/Documentation/x86/x86_64/uefi.rst
index 3b894103a734..fbc30c9a071d 100644
--- a/Documentation/x86/x86_64/uefi.rst
+++ b/Documentation/x86/x86_64/uefi.rst
@@ -29,7 +29,7 @@ Mechanics
   be selected::
 
 	CONFIG_EFI=y
-	CONFIG_EFI_VARS=y or m		# optional
+	CONFIG_EFIVAR_FS=y or m		# optional
 
 - Create a VFAT partition on the disk
 - Copy the following to the VFAT partition:
diff --git a/arch/arm/configs/milbeaut_m10v_defconfig b/arch/arm/configs/milbeaut_m10v_defconfig
index 7c07f9893a0f..9b4789af0201 100644
--- a/arch/arm/configs/milbeaut_m10v_defconfig
+++ b/arch/arm/configs/milbeaut_m10v_defconfig
@@ -44,7 +44,6 @@ CONFIG_ARM_CPUIDLE=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_KERNEL_MODE_NEON=y
-CONFIG_EFI_VARS=m
 CONFIG_EFI_CAPSULE_LOADER=m
 CONFIG_ARM_CRYPTO=y
 CONFIG_CRYPTO_SHA1_ARM_NEON=m
diff --git a/arch/ia64/configs/bigsur_defconfig b/arch/ia64/configs/bigsur_defconfig
index 0341a67cc1bf..a3724882295c 100644
--- a/arch/ia64/configs/bigsur_defconfig
+++ b/arch/ia64/configs/bigsur_defconfig
@@ -10,7 +10,6 @@ CONFIG_SMP=y
 CONFIG_NR_CPUS=2
 CONFIG_PREEMPT=y
 CONFIG_IA64_PALINFO=y
-CONFIG_EFI_VARS=y
 CONFIG_BINFMT_MISC=m
 CONFIG_ACPI_BUTTON=m
 CONFIG_ACPI_FAN=m
diff --git a/arch/ia64/configs/generic_defconfig b/arch/ia64/configs/generic_defconfig
index 8916a2850c48..a3dff482a3d7 100644
--- a/arch/ia64/configs/generic_defconfig
+++ b/arch/ia64/configs/generic_defconfig
@@ -21,7 +21,6 @@ CONFIG_IA64_MCA_RECOVERY=y
 CONFIG_IA64_PALINFO=y
 CONFIG_KEXEC=y
 CONFIG_CRASH_DUMP=y
-CONFIG_EFI_VARS=y
 CONFIG_BINFMT_MISC=m
 CONFIG_ACPI_BUTTON=m
 CONFIG_ACPI_FAN=m
diff --git a/arch/ia64/configs/gensparse_defconfig b/arch/ia64/configs/gensparse_defconfig
index 281eb9c544f9..4cd46105b020 100644
--- a/arch/ia64/configs/gensparse_defconfig
+++ b/arch/ia64/configs/gensparse_defconfig
@@ -18,7 +18,6 @@ CONFIG_HOTPLUG_CPU=y
 CONFIG_SPARSEMEM_MANUAL=y
 CONFIG_IA64_MCA_RECOVERY=y
 CONFIG_IA64_PALINFO=y
-CONFIG_EFI_VARS=y
 CONFIG_BINFMT_MISC=m
 CONFIG_ACPI_BUTTON=m
 CONFIG_ACPI_FAN=m
diff --git a/arch/ia64/configs/tiger_defconfig b/arch/ia64/configs/tiger_defconfig
index b4f9819a1a45..a2045d73adfa 100644
--- a/arch/ia64/configs/tiger_defconfig
+++ b/arch/ia64/configs/tiger_defconfig
@@ -23,7 +23,6 @@ CONFIG_FORCE_CPEI_RETARGET=y
 CONFIG_IA64_MCA_RECOVERY=y
 CONFIG_IA64_PALINFO=y
 CONFIG_KEXEC=y
-CONFIG_EFI_VARS=y
 CONFIG_BINFMT_MISC=m
 CONFIG_ACPI_BUTTON=m
 CONFIG_ACPI_FAN=m
diff --git a/arch/ia64/configs/zx1_defconfig b/arch/ia64/configs/zx1_defconfig
index 851d8594cdb8..99f8b2a0332b 100644
--- a/arch/ia64/configs/zx1_defconfig
+++ b/arch/ia64/configs/zx1_defconfig
@@ -12,7 +12,6 @@ CONFIG_FLATMEM_MANUAL=y
 CONFIG_IA64_MCA_RECOVERY=y
 CONFIG_IA64_PALINFO=y
 CONFIG_CRASH_DUMP=y
-CONFIG_EFI_VARS=y
 CONFIG_BINFMT_MISC=y
 CONFIG_HOTPLUG_PCI=y
 CONFIG_HOTPLUG_PCI_ACPI=y
diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index 98a4852ed6a0..7207219509f6 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -135,7 +135,6 @@ CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_DEBUG_DEVRES=y
 CONFIG_CONNECTOR=y
-CONFIG_EFI_VARS=y
 CONFIG_EFI_CAPSULE_LOADER=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_VIRTIO_BLK=y
diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
index 69784505a7a8..5ce67b73e218 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -134,7 +134,6 @@ CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_DEBUG_DEVRES=y
 CONFIG_CONNECTOR=y
-CONFIG_EFI_VARS=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_VIRTIO_BLK=y
 CONFIG_BLK_DEV_SD=y
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 6fd4414c4836..c2f64e405336 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -2,18 +2,6 @@
 menu "EFI (Extensible Firmware Interface) Support"
 	depends on EFI
 
-config EFI_VARS
-	tristate "EFI Variable Support via sysfs"
-	depends on EFI && (X86 || IA64)
-	default n
-	help
-	  If you say Y here, you are able to get EFI (Extensible Firmware
-	  Interface) variable information via sysfs.  You may read,
-	  write, create, and destroy EFI variables through this interface.
-	  Note that this driver is only retained for compatibility with
-	  legacy users: new users should use the efivarfs filesystem
-	  instead.
-
 config EFI_ESRT
 	bool
 	depends on EFI && !IA64
diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index c02ff25dd477..8d151e332584 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -17,7 +17,6 @@ ifneq ($(CONFIG_EFI_CAPSULE_LOADER),)
 obj-$(CONFIG_EFI)			+= capsule.o
 endif
 obj-$(CONFIG_EFI_PARAMS_FROM_FDT)	+= fdtparams.o
-obj-$(CONFIG_EFI_VARS)			+= efivars.o
 obj-$(CONFIG_EFI_ESRT)			+= esrt.o
 obj-$(CONFIG_EFI_VARS_PSTORE)		+= efi-pstore.o
 obj-$(CONFIG_UEFI_CPER)			+= cper.o
diff --git a/drivers/firmware/efi/efivars.c b/drivers/firmware/efi/efivars.c
deleted file mode 100644
index 801a65582172..000000000000
--- a/drivers/firmware/efi/efivars.c
+++ /dev/null
@@ -1,660 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Originally from efivars.c,
- *
- * Copyright (C) 2001,2003,2004 Dell <Matt_Domsch@dell.com>
- * Copyright (C) 2004 Intel Corporation <matthew.e.tolentino@intel.com>
- *
- * This code takes all variables accessible from EFI runtime and
- *  exports them via sysfs
- */
-
-#include <linux/efi.h>
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/ucs2_string.h>
-#include <linux/compat.h>
-
-#define EFIVARS_VERSION "0.08"
-#define EFIVARS_DATE "2004-May-17"
-
-MODULE_AUTHOR("Matt Domsch <Matt_Domsch@Dell.com>");
-MODULE_DESCRIPTION("sysfs interface to EFI Variables");
-MODULE_LICENSE("GPL");
-MODULE_VERSION(EFIVARS_VERSION);
-
-static LIST_HEAD(efivar_sysfs_list);
-
-static struct kset *efivars_kset;
-
-static struct bin_attribute *efivars_new_var;
-static struct bin_attribute *efivars_del_var;
-
-struct compat_efi_variable {
-	efi_char16_t  VariableName[EFI_VAR_NAME_LEN/sizeof(efi_char16_t)];
-	efi_guid_t    VendorGuid;
-	__u32         DataSize;
-	__u8          Data[1024];
-	__u32         Status;
-	__u32         Attributes;
-} __packed;
-
-struct efivar_attribute {
-	struct attribute attr;
-	ssize_t (*show) (struct efivar_entry *entry, char *buf);
-	ssize_t (*store)(struct efivar_entry *entry, const char *buf, size_t count);
-};
-
-#define EFIVAR_ATTR(_name, _mode, _show, _store) \
-struct efivar_attribute efivar_attr_##_name = { \
-	.attr = {.name = __stringify(_name), .mode = _mode}, \
-	.show = _show, \
-	.store = _store, \
-};
-
-#define to_efivar_attr(_attr) container_of(_attr, struct efivar_attribute, attr)
-#define to_efivar_entry(obj)  container_of(obj, struct efivar_entry, kobj)
-
-/*
- * Prototype for sysfs creation function
- */
-static int
-efivar_create_sysfs_entry(struct efivar_entry *new_var);
-
-static ssize_t
-efivar_guid_read(struct efivar_entry *entry, char *buf)
-{
-	struct efi_variable *var = &entry->var;
-	char *str = buf;
-
-	if (!entry || !buf)
-		return 0;
-
-	efi_guid_to_str(&var->VendorGuid, str);
-	str += strlen(str);
-	str += sprintf(str, "\n");
-
-	return str - buf;
-}
-
-static ssize_t
-efivar_attr_read(struct efivar_entry *entry, char *buf)
-{
-	struct efi_variable *var = &entry->var;
-	unsigned long size = sizeof(var->Data);
-	char *str = buf;
-	int ret;
-
-	if (!entry || !buf)
-		return -EINVAL;
-
-	ret = efivar_entry_get(entry, &var->Attributes, &size, var->Data);
-	var->DataSize = size;
-	if (ret)
-		return -EIO;
-
-	if (var->Attributes & EFI_VARIABLE_NON_VOLATILE)
-		str += sprintf(str, "EFI_VARIABLE_NON_VOLATILE\n");
-	if (var->Attributes & EFI_VARIABLE_BOOTSERVICE_ACCESS)
-		str += sprintf(str, "EFI_VARIABLE_BOOTSERVICE_ACCESS\n");
-	if (var->Attributes & EFI_VARIABLE_RUNTIME_ACCESS)
-		str += sprintf(str, "EFI_VARIABLE_RUNTIME_ACCESS\n");
-	if (var->Attributes & EFI_VARIABLE_HARDWARE_ERROR_RECORD)
-		str += sprintf(str, "EFI_VARIABLE_HARDWARE_ERROR_RECORD\n");
-	if (var->Attributes & EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS)
-		str += sprintf(str,
-			"EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS\n");
-	if (var->Attributes &
-			EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS)
-		str += sprintf(str,
-			"EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS\n");
-	if (var->Attributes & EFI_VARIABLE_APPEND_WRITE)
-		str += sprintf(str, "EFI_VARIABLE_APPEND_WRITE\n");
-	return str - buf;
-}
-
-static ssize_t
-efivar_size_read(struct efivar_entry *entry, char *buf)
-{
-	struct efi_variable *var = &entry->var;
-	unsigned long size = sizeof(var->Data);
-	char *str = buf;
-	int ret;
-
-	if (!entry || !buf)
-		return -EINVAL;
-
-	ret = efivar_entry_get(entry, &var->Attributes, &size, var->Data);
-	var->DataSize = size;
-	if (ret)
-		return -EIO;
-
-	str += sprintf(str, "0x%lx\n", var->DataSize);
-	return str - buf;
-}
-
-static ssize_t
-efivar_data_read(struct efivar_entry *entry, char *buf)
-{
-	struct efi_variable *var = &entry->var;
-	unsigned long size = sizeof(var->Data);
-	int ret;
-
-	if (!entry || !buf)
-		return -EINVAL;
-
-	ret = efivar_entry_get(entry, &var->Attributes, &size, var->Data);
-	var->DataSize = size;
-	if (ret)
-		return -EIO;
-
-	memcpy(buf, var->Data, var->DataSize);
-	return var->DataSize;
-}
-
-static inline int
-sanity_check(struct efi_variable *var, efi_char16_t *name, efi_guid_t vendor,
-	     unsigned long size, u32 attributes, u8 *data)
-{
-	/*
-	 * If only updating the variable data, then the name
-	 * and guid should remain the same
-	 */
-	if (memcmp(name, var->VariableName, sizeof(var->VariableName)) ||
-		efi_guidcmp(vendor, var->VendorGuid)) {
-		printk(KERN_ERR "efivars: Cannot edit the wrong variable!\n");
-		return -EINVAL;
-	}
-
-	if ((size <= 0) || (attributes == 0)){
-		printk(KERN_ERR "efivars: DataSize & Attributes must be valid!\n");
-		return -EINVAL;
-	}
-
-	if ((attributes & ~EFI_VARIABLE_MASK) != 0 ||
-	    efivar_validate(vendor, name, data, size) == false) {
-		printk(KERN_ERR "efivars: Malformed variable content\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static void
-copy_out_compat(struct efi_variable *dst, struct compat_efi_variable *src)
-{
-	memcpy(dst->VariableName, src->VariableName, EFI_VAR_NAME_LEN);
-	memcpy(dst->Data, src->Data, sizeof(src->Data));
-
-	dst->VendorGuid = src->VendorGuid;
-	dst->DataSize = src->DataSize;
-	dst->Attributes = src->Attributes;
-}
-
-/*
- * We allow each variable to be edited via rewriting the
- * entire efi variable structure.
- */
-static ssize_t
-efivar_store_raw(struct efivar_entry *entry, const char *buf, size_t count)
-{
-	struct efi_variable *new_var, *var = &entry->var;
-	efi_char16_t *name;
-	unsigned long size;
-	efi_guid_t vendor;
-	u32 attributes;
-	u8 *data;
-	int err;
-
-	if (!entry || !buf)
-		return -EINVAL;
-
-	if (in_compat_syscall()) {
-		struct compat_efi_variable *compat;
-
-		if (count != sizeof(*compat))
-			return -EINVAL;
-
-		compat = (struct compat_efi_variable *)buf;
-		attributes = compat->Attributes;
-		vendor = compat->VendorGuid;
-		name = compat->VariableName;
-		size = compat->DataSize;
-		data = compat->Data;
-
-		err = sanity_check(var, name, vendor, size, attributes, data);
-		if (err)
-			return err;
-
-		copy_out_compat(&entry->var, compat);
-	} else {
-		if (count != sizeof(struct efi_variable))
-			return -EINVAL;
-
-		new_var = (struct efi_variable *)buf;
-
-		attributes = new_var->Attributes;
-		vendor = new_var->VendorGuid;
-		name = new_var->VariableName;
-		size = new_var->DataSize;
-		data = new_var->Data;
-
-		err = sanity_check(var, name, vendor, size, attributes, data);
-		if (err)
-			return err;
-
-		memcpy(&entry->var, new_var, count);
-	}
-
-	err = efivar_entry_set(entry, attributes, size, data, NULL);
-	if (err) {
-		printk(KERN_WARNING "efivars: set_variable() failed: status=%d\n", err);
-		return -EIO;
-	}
-
-	return count;
-}
-
-static ssize_t
-efivar_show_raw(struct efivar_entry *entry, char *buf)
-{
-	struct efi_variable *var = &entry->var;
-	struct compat_efi_variable *compat;
-	unsigned long datasize = sizeof(var->Data);
-	size_t size;
-	int ret;
-
-	if (!entry || !buf)
-		return 0;
-
-	ret = efivar_entry_get(entry, &var->Attributes, &datasize, var->Data);
-	var->DataSize = datasize;
-	if (ret)
-		return -EIO;
-
-	if (in_compat_syscall()) {
-		compat = (struct compat_efi_variable *)buf;
-
-		size = sizeof(*compat);
-		memcpy(compat->VariableName, var->VariableName,
-			EFI_VAR_NAME_LEN);
-		memcpy(compat->Data, var->Data, sizeof(compat->Data));
-
-		compat->VendorGuid = var->VendorGuid;
-		compat->DataSize = var->DataSize;
-		compat->Attributes = var->Attributes;
-	} else {
-		size = sizeof(*var);
-		memcpy(buf, var, size);
-	}
-
-	return size;
-}
-
-/*
- * Generic read/write functions that call the specific functions of
- * the attributes...
- */
-static ssize_t efivar_attr_show(struct kobject *kobj, struct attribute *attr,
-				char *buf)
-{
-	struct efivar_entry *var = to_efivar_entry(kobj);
-	struct efivar_attribute *efivar_attr = to_efivar_attr(attr);
-	ssize_t ret = -EIO;
-
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
-
-	if (efivar_attr->show) {
-		ret = efivar_attr->show(var, buf);
-	}
-	return ret;
-}
-
-static ssize_t efivar_attr_store(struct kobject *kobj, struct attribute *attr,
-				const char *buf, size_t count)
-{
-	struct efivar_entry *var = to_efivar_entry(kobj);
-	struct efivar_attribute *efivar_attr = to_efivar_attr(attr);
-	ssize_t ret = -EIO;
-
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
-
-	if (efivar_attr->store)
-		ret = efivar_attr->store(var, buf, count);
-
-	return ret;
-}
-
-static const struct sysfs_ops efivar_attr_ops = {
-	.show = efivar_attr_show,
-	.store = efivar_attr_store,
-};
-
-static void efivar_release(struct kobject *kobj)
-{
-	struct efivar_entry *var = to_efivar_entry(kobj);
-	kfree(var);
-}
-
-static EFIVAR_ATTR(guid, 0400, efivar_guid_read, NULL);
-static EFIVAR_ATTR(attributes, 0400, efivar_attr_read, NULL);
-static EFIVAR_ATTR(size, 0400, efivar_size_read, NULL);
-static EFIVAR_ATTR(data, 0400, efivar_data_read, NULL);
-static EFIVAR_ATTR(raw_var, 0600, efivar_show_raw, efivar_store_raw);
-
-static struct attribute *def_attrs[] = {
-	&efivar_attr_guid.attr,
-	&efivar_attr_size.attr,
-	&efivar_attr_attributes.attr,
-	&efivar_attr_data.attr,
-	&efivar_attr_raw_var.attr,
-	NULL,
-};
-ATTRIBUTE_GROUPS(def);
-
-static struct kobj_type efivar_ktype = {
-	.release = efivar_release,
-	.sysfs_ops = &efivar_attr_ops,
-	.default_groups = def_groups,
-};
-
-static ssize_t efivar_create(struct file *filp, struct kobject *kobj,
-			     struct bin_attribute *bin_attr,
-			     char *buf, loff_t pos, size_t count)
-{
-	struct compat_efi_variable *compat = (struct compat_efi_variable *)buf;
-	struct efi_variable *new_var = (struct efi_variable *)buf;
-	struct efivar_entry *new_entry;
-	bool need_compat = in_compat_syscall();
-	efi_char16_t *name;
-	unsigned long size;
-	u32 attributes;
-	u8 *data;
-	int err;
-
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
-
-	if (need_compat) {
-		if (count != sizeof(*compat))
-			return -EINVAL;
-
-		attributes = compat->Attributes;
-		name = compat->VariableName;
-		size = compat->DataSize;
-		data = compat->Data;
-	} else {
-		if (count != sizeof(*new_var))
-			return -EINVAL;
-
-		attributes = new_var->Attributes;
-		name = new_var->VariableName;
-		size = new_var->DataSize;
-		data = new_var->Data;
-	}
-
-	if ((attributes & ~EFI_VARIABLE_MASK) != 0 ||
-	    efivar_validate(new_var->VendorGuid, name, data,
-			    size) == false) {
-		printk(KERN_ERR "efivars: Malformed variable content\n");
-		return -EINVAL;
-	}
-
-	new_entry = kzalloc(sizeof(*new_entry), GFP_KERNEL);
-	if (!new_entry)
-		return -ENOMEM;
-
-	if (need_compat)
-		copy_out_compat(&new_entry->var, compat);
-	else
-		memcpy(&new_entry->var, new_var, sizeof(*new_var));
-
-	err = efivar_entry_set(new_entry, attributes, size,
-			       data, &efivar_sysfs_list);
-	if (err) {
-		if (err == -EEXIST)
-			err = -EINVAL;
-		goto out;
-	}
-
-	if (efivar_create_sysfs_entry(new_entry)) {
-		printk(KERN_WARNING "efivars: failed to create sysfs entry.\n");
-		kfree(new_entry);
-	}
-	return count;
-
-out:
-	kfree(new_entry);
-	return err;
-}
-
-static ssize_t efivar_delete(struct file *filp, struct kobject *kobj,
-			     struct bin_attribute *bin_attr,
-			     char *buf, loff_t pos, size_t count)
-{
-	struct efi_variable *del_var = (struct efi_variable *)buf;
-	struct compat_efi_variable *compat;
-	struct efivar_entry *entry;
-	efi_char16_t *name;
-	efi_guid_t vendor;
-	int err = 0;
-
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
-
-	if (in_compat_syscall()) {
-		if (count != sizeof(*compat))
-			return -EINVAL;
-
-		compat = (struct compat_efi_variable *)buf;
-		name = compat->VariableName;
-		vendor = compat->VendorGuid;
-	} else {
-		if (count != sizeof(*del_var))
-			return -EINVAL;
-
-		name = del_var->VariableName;
-		vendor = del_var->VendorGuid;
-	}
-
-	if (efivar_entry_iter_begin())
-		return -EINTR;
-	entry = efivar_entry_find(name, vendor, &efivar_sysfs_list, true);
-	if (!entry)
-		err = -EINVAL;
-	else if (__efivar_entry_delete(entry))
-		err = -EIO;
-
-	efivar_entry_iter_end();
-
-	if (err)
-		return err;
-
-	efivar_unregister(entry);
-
-	/* It's dead Jim.... */
-	return count;
-}
-
-/**
- * efivar_create_sysfs_entry - create a new entry in sysfs
- * @new_var: efivar entry to create
- *
- * Returns 0 on success, negative error code on failure
- */
-static int
-efivar_create_sysfs_entry(struct efivar_entry *new_var)
-{
-	int short_name_size;
-	char *short_name;
-	unsigned long utf8_name_size;
-	efi_char16_t *variable_name = new_var->var.VariableName;
-	int ret;
-
-	/*
-	 * Length of the variable bytes in UTF8, plus the '-' separator,
-	 * plus the GUID, plus trailing NUL
-	 */
-	utf8_name_size = ucs2_utf8size(variable_name);
-	short_name_size = utf8_name_size + 1 + EFI_VARIABLE_GUID_LEN + 1;
-
-	short_name = kmalloc(short_name_size, GFP_KERNEL);
-	if (!short_name)
-		return -ENOMEM;
-
-	ucs2_as_utf8(short_name, variable_name, short_name_size);
-
-	/* This is ugly, but necessary to separate one vendor's
-	   private variables from another's.         */
-	short_name[utf8_name_size] = '-';
-	efi_guid_to_str(&new_var->var.VendorGuid,
-			 short_name + utf8_name_size + 1);
-
-	new_var->kobj.kset = efivars_kset;
-
-	ret = kobject_init_and_add(&new_var->kobj, &efivar_ktype,
-				   NULL, "%s", short_name);
-	kfree(short_name);
-	if (ret) {
-		kobject_put(&new_var->kobj);
-		return ret;
-	}
-
-	kobject_uevent(&new_var->kobj, KOBJ_ADD);
-	__efivar_entry_add(new_var, &efivar_sysfs_list);
-
-	return 0;
-}
-
-static int
-create_efivars_bin_attributes(void)
-{
-	struct bin_attribute *attr;
-	int error;
-
-	/* new_var */
-	attr = kzalloc(sizeof(*attr), GFP_KERNEL);
-	if (!attr)
-		return -ENOMEM;
-
-	attr->attr.name = "new_var";
-	attr->attr.mode = 0200;
-	attr->write = efivar_create;
-	efivars_new_var = attr;
-
-	/* del_var */
-	attr = kzalloc(sizeof(*attr), GFP_KERNEL);
-	if (!attr) {
-		error = -ENOMEM;
-		goto out_free;
-	}
-	attr->attr.name = "del_var";
-	attr->attr.mode = 0200;
-	attr->write = efivar_delete;
-	efivars_del_var = attr;
-
-	sysfs_bin_attr_init(efivars_new_var);
-	sysfs_bin_attr_init(efivars_del_var);
-
-	/* Register */
-	error = sysfs_create_bin_file(&efivars_kset->kobj, efivars_new_var);
-	if (error) {
-		printk(KERN_ERR "efivars: unable to create new_var sysfs file"
-			" due to error %d\n", error);
-		goto out_free;
-	}
-
-	error = sysfs_create_bin_file(&efivars_kset->kobj, efivars_del_var);
-	if (error) {
-		printk(KERN_ERR "efivars: unable to create del_var sysfs file"
-			" due to error %d\n", error);
-		sysfs_remove_bin_file(&efivars_kset->kobj, efivars_new_var);
-		goto out_free;
-	}
-
-	return 0;
-out_free:
-	kfree(efivars_del_var);
-	efivars_del_var = NULL;
-	kfree(efivars_new_var);
-	efivars_new_var = NULL;
-	return error;
-}
-
-static int efivars_sysfs_callback(efi_char16_t *name, efi_guid_t vendor,
-				  unsigned long name_size, void *data)
-{
-	struct efivar_entry *entry;
-
-	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
-	if (!entry)
-		return -ENOMEM;
-
-	memcpy(entry->var.VariableName, name, name_size);
-	memcpy(&(entry->var.VendorGuid), &vendor, sizeof(efi_guid_t));
-
-	efivar_create_sysfs_entry(entry);
-
-	return 0;
-}
-
-static int efivar_sysfs_destroy(struct efivar_entry *entry, void *data)
-{
-	efivar_entry_remove(entry);
-	efivar_unregister(entry);
-	return 0;
-}
-
-static void efivars_sysfs_exit(void)
-{
-	/* Remove all entries and destroy */
-	int err;
-
-	err = efivar_entry_iter(efivar_sysfs_destroy, &efivar_sysfs_list, NULL);
-	if (err) {
-		pr_err("efivars: Failed to destroy sysfs entries\n");
-		return;
-	}
-
-	if (efivars_new_var)
-		sysfs_remove_bin_file(&efivars_kset->kobj, efivars_new_var);
-	if (efivars_del_var)
-		sysfs_remove_bin_file(&efivars_kset->kobj, efivars_del_var);
-	kfree(efivars_new_var);
-	kfree(efivars_del_var);
-	kset_unregister(efivars_kset);
-}
-
-static int efivars_sysfs_init(void)
-{
-	struct kobject *parent_kobj = efivars_kobject();
-	int error = 0;
-
-	/* No efivars has been registered yet */
-	if (!parent_kobj || !efivar_supports_writes())
-		return 0;
-
-	printk(KERN_INFO "EFI Variables Facility v%s %s\n", EFIVARS_VERSION,
-	       EFIVARS_DATE);
-
-	efivars_kset = kset_create_and_add("vars", NULL, parent_kobj);
-	if (!efivars_kset) {
-		printk(KERN_ERR "efivars: Subsystem registration failed.\n");
-		return -ENOMEM;
-	}
-
-	efivar_init(efivars_sysfs_callback, NULL, true, &efivar_sysfs_list);
-
-	error = create_efivars_bin_attributes();
-	if (error) {
-		efivars_sysfs_exit();
-		return error;
-	}
-
-	return 0;
-}
-
-module_init(efivars_sysfs_init);
-module_exit(efivars_sysfs_exit);
diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index 932435945c85..94de1d0cb4e7 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -547,36 +547,6 @@ static void efivar_entry_list_del_unlock(struct efivar_entry *entry)
 	up(&efivars_lock);
 }
 
-/**
- * __efivar_entry_delete - delete an EFI variable
- * @entry: entry containing EFI variable to delete
- *
- * Delete the variable from the firmware but leave @entry on the
- * variable list.
- *
- * This function differs from efivar_entry_delete() because it does
- * not remove @entry from the variable list. Also, it is safe to be
- * called from within a efivar_entry_iter_begin() and
- * efivar_entry_iter_end() region, unlike efivar_entry_delete().
- *
- * Returns 0 on success, or a converted EFI status code if
- * set_variable() fails.
- */
-int __efivar_entry_delete(struct efivar_entry *entry)
-{
-	efi_status_t status;
-
-	if (!__efivars)
-		return -EINVAL;
-
-	status = __efivars->ops->set_variable(entry->var.VariableName,
-					      &entry->var.VendorGuid,
-					      0, 0, NULL);
-
-	return efi_status_to_err(status);
-}
-EXPORT_SYMBOL_GPL(__efivar_entry_delete);
-
 /**
  * efivar_entry_delete - delete variable and remove entry from list
  * @entry: entry containing variable to delete
@@ -614,213 +584,6 @@ int efivar_entry_delete(struct efivar_entry *entry)
 }
 EXPORT_SYMBOL_GPL(efivar_entry_delete);
 
-/**
- * efivar_entry_set - call set_variable()
- * @entry: entry containing the EFI variable to write
- * @attributes: variable attributes
- * @size: size of @data buffer
- * @data: buffer containing variable data
- * @head: head of variable list
- *
- * Calls set_variable() for an EFI variable. If creating a new EFI
- * variable, this function is usually followed by efivar_entry_add().
- *
- * Before writing the variable, the remaining EFI variable storage
- * space is checked to ensure there is enough room available.
- *
- * If @head is not NULL a lookup is performed to determine whether
- * the entry is already on the list.
- *
- * Returns 0 on success, -EINTR if we can't grab the semaphore,
- * -EEXIST if a lookup is performed and the entry already exists on
- * the list, or a converted EFI status code if set_variable() fails.
- */
-int efivar_entry_set(struct efivar_entry *entry, u32 attributes,
-		     unsigned long size, void *data, struct list_head *head)
-{
-	const struct efivar_operations *ops;
-	efi_status_t status;
-	efi_char16_t *name = entry->var.VariableName;
-	efi_guid_t vendor = entry->var.VendorGuid;
-
-	if (down_interruptible(&efivars_lock))
-		return -EINTR;
-
-	if (!__efivars) {
-		up(&efivars_lock);
-		return -EINVAL;
-	}
-	ops = __efivars->ops;
-	if (head && efivar_entry_find(name, vendor, head, false)) {
-		up(&efivars_lock);
-		return -EEXIST;
-	}
-
-	status = check_var_size(attributes, size + ucs2_strsize(name, 1024));
-	if (status == EFI_SUCCESS || status == EFI_UNSUPPORTED)
-		status = ops->set_variable(name, &vendor,
-					   attributes, size, data);
-
-	up(&efivars_lock);
-
-	return efi_status_to_err(status);
-
-}
-EXPORT_SYMBOL_GPL(efivar_entry_set);
-
-/*
- * efivar_entry_set_nonblocking - call set_variable_nonblocking()
- *
- * This function is guaranteed to not block and is suitable for calling
- * from crash/panic handlers.
- *
- * Crucially, this function will not block if it cannot acquire
- * efivars_lock. Instead, it returns -EBUSY.
- */
-static int
-efivar_entry_set_nonblocking(efi_char16_t *name, efi_guid_t vendor,
-			     u32 attributes, unsigned long size, void *data)
-{
-	const struct efivar_operations *ops;
-	efi_status_t status;
-
-	if (down_trylock(&efivars_lock))
-		return -EBUSY;
-
-	if (!__efivars) {
-		up(&efivars_lock);
-		return -EINVAL;
-	}
-
-	status = check_var_size_nonblocking(attributes,
-					    size + ucs2_strsize(name, 1024));
-	if (status != EFI_SUCCESS) {
-		up(&efivars_lock);
-		return -ENOSPC;
-	}
-
-	ops = __efivars->ops;
-	status = ops->set_variable_nonblocking(name, &vendor, attributes,
-					       size, data);
-
-	up(&efivars_lock);
-	return efi_status_to_err(status);
-}
-
-/**
- * efivar_entry_set_safe - call set_variable() if enough space in firmware
- * @name: buffer containing the variable name
- * @vendor: variable vendor guid
- * @attributes: variable attributes
- * @block: can we block in this context?
- * @size: size of @data buffer
- * @data: buffer containing variable data
- *
- * Ensures there is enough free storage in the firmware for this variable, and
- * if so, calls set_variable(). If creating a new EFI variable, this function
- * is usually followed by efivar_entry_add().
- *
- * Returns 0 on success, -ENOSPC if the firmware does not have enough
- * space for set_variable() to succeed, or a converted EFI status code
- * if set_variable() fails.
- */
-int efivar_entry_set_safe(efi_char16_t *name, efi_guid_t vendor, u32 attributes,
-			  bool block, unsigned long size, void *data)
-{
-	const struct efivar_operations *ops;
-	efi_status_t status;
-	unsigned long varsize;
-
-	if (!__efivars)
-		return -EINVAL;
-
-	ops = __efivars->ops;
-	if (!ops->query_variable_store)
-		return -ENOSYS;
-
-	/*
-	 * If the EFI variable backend provides a non-blocking
-	 * ->set_variable() operation and we're in a context where we
-	 * cannot block, then we need to use it to avoid live-locks,
-	 * since the implication is that the regular ->set_variable()
-	 * will block.
-	 *
-	 * If no ->set_variable_nonblocking() is provided then
-	 * ->set_variable() is assumed to be non-blocking.
-	 */
-	if (!block && ops->set_variable_nonblocking)
-		return efivar_entry_set_nonblocking(name, vendor, attributes,
-						    size, data);
-
-	varsize = size + ucs2_strsize(name, 1024);
-	if (!block) {
-		if (down_trylock(&efivars_lock))
-			return -EBUSY;
-		status = check_var_size_nonblocking(attributes, varsize);
-	} else {
-		if (down_interruptible(&efivars_lock))
-			return -EINTR;
-		status = check_var_size(attributes, varsize);
-	}
-
-	if (status != EFI_SUCCESS) {
-		up(&efivars_lock);
-		return -ENOSPC;
-	}
-
-	status = ops->set_variable(name, &vendor, attributes, size, data);
-
-	up(&efivars_lock);
-
-	return efi_status_to_err(status);
-}
-EXPORT_SYMBOL_GPL(efivar_entry_set_safe);
-
-/**
- * efivar_entry_find - search for an entry
- * @name: the EFI variable name
- * @guid: the EFI variable vendor's guid
- * @head: head of the variable list
- * @remove: should we remove the entry from the list?
- *
- * Search for an entry on the variable list that has the EFI variable
- * name @name and vendor guid @guid. If an entry is found on the list
- * and @remove is true, the entry is removed from the list.
- *
- * The caller MUST call efivar_entry_iter_begin() and
- * efivar_entry_iter_end() before and after the invocation of this
- * function, respectively.
- *
- * Returns the entry if found on the list, %NULL otherwise.
- */
-struct efivar_entry *efivar_entry_find(efi_char16_t *name, efi_guid_t guid,
-				       struct list_head *head, bool remove)
-{
-	struct efivar_entry *entry, *n;
-	int strsize1, strsize2;
-	bool found = false;
-
-	list_for_each_entry_safe(entry, n, head, list) {
-		strsize1 = ucs2_strsize(name, 1024);
-		strsize2 = ucs2_strsize(entry->var.VariableName, 1024);
-		if (strsize1 == strsize2 &&
-		    !memcmp(name, &(entry->var.VariableName), strsize1) &&
-		    !efi_guidcmp(guid, entry->var.VendorGuid)) {
-			found = true;
-			break;
-		}
-	}
-
-	if (!found)
-		return NULL;
-
-	if (remove)
-		list_del(&entry->list);
-
-	return entry;
-}
-EXPORT_SYMBOL_GPL(efivar_entry_find);
-
 /**
  * efivar_entry_size - obtain the size of a variable
  * @entry: entry for this variable
@@ -1010,30 +773,6 @@ int efivar_entry_set_get_size(struct efivar_entry *entry, u32 attributes,
 }
 EXPORT_SYMBOL_GPL(efivar_entry_set_get_size);
 
-/**
- * efivar_entry_iter_begin - begin iterating the variable list
- *
- * Lock the variable list to prevent entry insertion and removal until
- * efivar_entry_iter_end() is called. This function is usually used in
- * conjunction with __efivar_entry_iter() or efivar_entry_iter().
- */
-int efivar_entry_iter_begin(void)
-{
-	return down_interruptible(&efivars_lock);
-}
-EXPORT_SYMBOL_GPL(efivar_entry_iter_begin);
-
-/**
- * efivar_entry_iter_end - finish iterating the variable list
- *
- * Unlock the variable list and allow modifications to the list again.
- */
-void efivar_entry_iter_end(void)
-{
-	up(&efivars_lock);
-}
-EXPORT_SYMBOL_GPL(efivar_entry_iter_end);
-
 /**
  * efivar_entry_iter - iterate over variable list
  * @func: callback function
@@ -1054,7 +793,7 @@ int efivar_entry_iter(int (*func)(struct efivar_entry *, void *),
 	struct efivar_entry *entry, *n;
 	int err = 0;
 
-	err = efivar_entry_iter_begin();
+	err = down_interruptible(&efivars_lock);
 	if (err)
 		return err;
 
@@ -1063,7 +802,7 @@ int efivar_entry_iter(int (*func)(struct efivar_entry *, void *),
 		if (err)
 			break;
 	}
-	efivar_entry_iter_end();
+	up(&efivars_lock);
 
 	return err;
 }
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 93ce85a14a46..10ef0a0d5e9a 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1045,12 +1045,6 @@ struct efivar_entry {
 	struct kobject kobj;
 };
 
-static inline void
-efivar_unregister(struct efivar_entry *var)
-{
-	kobject_put(&var->kobj);
-}
-
 int efivars_register(struct efivars *efivars,
 		     const struct efivar_operations *ops,
 		     struct kobject *kobject);
@@ -1064,8 +1058,6 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
 int efivar_entry_add(struct efivar_entry *entry, struct list_head *head);
 void __efivar_entry_add(struct efivar_entry *entry, struct list_head *head);
 void efivar_entry_remove(struct efivar_entry *entry);
-
-int __efivar_entry_delete(struct efivar_entry *entry);
 int efivar_entry_delete(struct efivar_entry *entry);
 
 int efivar_entry_size(struct efivar_entry *entry, unsigned long *size);
@@ -1073,22 +1065,12 @@ int __efivar_entry_get(struct efivar_entry *entry, u32 *attributes,
 		       unsigned long *size, void *data);
 int efivar_entry_get(struct efivar_entry *entry, u32 *attributes,
 		     unsigned long *size, void *data);
-int efivar_entry_set(struct efivar_entry *entry, u32 attributes,
-		     unsigned long size, void *data, struct list_head *head);
 int efivar_entry_set_get_size(struct efivar_entry *entry, u32 attributes,
 			      unsigned long *size, void *data, bool *set);
-int efivar_entry_set_safe(efi_char16_t *name, efi_guid_t vendor, u32 attributes,
-			  bool block, unsigned long size, void *data);
-
-int efivar_entry_iter_begin(void);
-void efivar_entry_iter_end(void);
 
 int efivar_entry_iter(int (*func)(struct efivar_entry *, void *),
 		      struct list_head *head, void *data);
 
-struct efivar_entry *efivar_entry_find(efi_char16_t *name, efi_guid_t guid,
-				       struct list_head *head, bool remove);
-
 bool efivar_validate(efi_guid_t vendor, efi_char16_t *var_name, u8 *data,
 		     unsigned long data_size);
 bool efivar_variable_is_removable(efi_guid_t vendor, const char *name,
-- 
2.35.1

