Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFC2275D19
	for <lists+linux-efi@lfdr.de>; Wed, 23 Sep 2020 18:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgIWQPN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 23 Sep 2020 12:15:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:42188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726829AbgIWQPM (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 23 Sep 2020 12:15:12 -0400
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 869F721D92;
        Wed, 23 Sep 2020 16:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600877711;
        bh=HLUV5aGznfDhUCFhdzMz8R+EKO/xLvwQOuXUkqXnmxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tKYbr3Ze1ZZJykh3TeZoisD+t1hBGPCrKN0aOGa2wvUJGvRvhGJhWOSt8UjpzXkaM
         ZwJ7oD6jGKLXDfKGwSfq/IooneJ42ImWUBZk9FfIfGh7aOoQr46RHxof0gxGZc9pk5
         DGBO2eOIPXLZFh8t3KIMsa17X7JxP+RcrKxgVLgg=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        Peter Jones <pjones@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH 7/7] efi: efivars: remove deprecated sysfs interface
Date:   Wed, 23 Sep 2020 18:14:04 +0200
Message-Id: <20200923161404.17811-8-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200923161404.17811-1-ardb@kernel.org>
References: <20200923161404.17811-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
Note: for reference only - please read cover letter before replying.

 Documentation/ABI/stable/sysfs-firmware-efi-vars |  75 ---
 drivers/firmware/efi/Kconfig                     |  12 -
 drivers/firmware/efi/Makefile                    |   1 -
 drivers/firmware/efi/efivars.c                   | 671 --------------------
 include/linux/efi.h                              |   7 -
 5 files changed, 766 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-firmware-efi-vars b/Documentation/ABI/stable/sysfs-firmware-efi-vars
deleted file mode 100644
index 5def20b9019e..000000000000
--- a/Documentation/ABI/stable/sysfs-firmware-efi-vars
+++ /dev/null
@@ -1,75 +0,0 @@
-What:		/sys/firmware/efi/vars
-Date:		April 2004
-Contact:	Matt Domsch <Matt_Domsch@dell.com>
-Description:
-		This directory exposes interfaces for interactive with
-		EFI variables.  For more information on EFI variables,
-		see 'Variable Services' in the UEFI specification
-		(section 7.2 in specification version 2.3 Errata D).
-
-		In summary, EFI variables are named, and are classified
-		into separate namespaces through the use of a vendor
-		GUID.  They also have an arbitrary binary value
-		associated with them.
-
-		The efivars module enumerates these variables and
-		creates a separate directory for each one found.  Each
-		directory has a name of the form "<key>-<vendor guid>"
-		and contains the following files:
-
-		attributes:	A read-only text file enumerating the
-				EFI variable flags.  Potential values
-				include:
-
-				EFI_VARIABLE_NON_VOLATILE
-				EFI_VARIABLE_BOOTSERVICE_ACCESS
-				EFI_VARIABLE_RUNTIME_ACCESS
-				EFI_VARIABLE_HARDWARE_ERROR_RECORD
-				EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS
-
-				See the EFI documentation for an
-				explanation of each of these variables.
-
-		data:		A read-only binary file that can be read
-				to attain the value of the EFI variable
-
-		guid:		The vendor GUID of the variable.  This
-				should always match the GUID in the
-				variable's name.
-
-		raw_var:	A binary file that can be read to obtain
-				a structure that contains everything
-				there is to know about the variable.
-				For structure definition see "struct
-				efi_variable" in the kernel sources.
-
-				This file can also be written to in
-				order to update the value of a variable.
-				For this to work however, all fields of
-				the "struct efi_variable" passed must
-				match byte for byte with the structure
-				read out of the file, save for the value
-				portion.
-
-				**Note** the efi_variable structure
-				read/written with this file contains a
-				'long' type that may change widths
-				depending on your underlying
-				architecture.
-
-		size:		As ASCII representation of the size of
-				the variable's value.
-
-
-		In addition, two other magic binary files are provided
-		in the top-level directory and are used for adding and
-		removing variables:
-
-		new_var:	Takes a "struct efi_variable" and
-				instructs the EFI firmware to create a
-				new variable.
-
-		del_var:	Takes a "struct efi_variable" and
-				instructs the EFI firmware to remove any
-				variable that has a matching vendor GUID
-				and variable key name.
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index da1887f72a51..42731b4e335c 100644
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
index 7a216984552b..00fbc1b80c84 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -14,7 +14,6 @@ obj-$(CONFIG_ACPI_BGRT) 		+= efi-bgrt.o
 obj-$(CONFIG_EFI)			+= efi.o vars.o reboot.o memattr.o tpm.o
 obj-$(CONFIG_EFI)			+= capsule.o memmap.o
 obj-$(CONFIG_EFI_PARAMS_FROM_FDT)	+= fdtparams.o
-obj-$(CONFIG_EFI_VARS)			+= efivars.o
 obj-$(CONFIG_EFI_ESRT)			+= esrt.o
 obj-$(CONFIG_EFI_VARS_PSTORE)		+= efi-pstore.o
 obj-$(CONFIG_UEFI_CPER)			+= cper.o
diff --git a/drivers/firmware/efi/efivars.c b/drivers/firmware/efi/efivars.c
deleted file mode 100644
index a76f50e15e6d..000000000000
--- a/drivers/firmware/efi/efivars.c
+++ /dev/null
@@ -1,671 +0,0 @@
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
-MODULE_ALIAS("platform:efivars");
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
-
-static struct kobj_type efivar_ktype = {
-	.release = efivar_release,
-	.sysfs_ops = &efivar_attr_ops,
-	.default_attrs = def_attrs,
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
-	if (err) {
-		efivar_entry_iter_end();
-		return err;
-	}
-
-	if (!entry->scanning) {
-		efivar_entry_iter_end();
-		efivar_unregister(entry);
-	} else
-		efivar_entry_iter_end();
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
-	if (efivar_entry_add(new_var, &efivar_sysfs_list)) {
-		efivar_unregister(new_var);
-		return -EINTR;
-	}
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
-	int err = efivar_entry_remove(entry);
-
-	if (err)
-		return err;
-	efivar_unregister(entry);
-	return 0;
-}
-
-static void efivars_sysfs_exit(void)
-{
-	/* Remove all entries and destroy */
-	int err;
-
-	err = __efivar_entry_iter(efivar_sysfs_destroy, &efivar_sysfs_list,
-				  NULL, NULL);
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
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 7defdc456dc0..6f9dc44d6d8e 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -979,17 +979,10 @@ struct efi_variable {
 struct efivar_entry {
 	struct efi_variable var;
 	struct list_head list;
-	struct kobject kobj;
 	bool scanning;
 	bool deleting;
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
-- 
2.17.1

