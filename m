Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA664275D10
	for <lists+linux-efi@lfdr.de>; Wed, 23 Sep 2020 18:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgIWQO7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 23 Sep 2020 12:14:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:41858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWQO7 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 23 Sep 2020 12:14:59 -0400
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5670821BE5;
        Wed, 23 Sep 2020 16:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600877698;
        bh=jBPk9GYHchZOkBmUWbnB7ym+PkKvrGJQed6G/FmGfrw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IuM1FobYpIunjTJWK7dJWn7EA8cdsFf5/ToAAbijFKdjNakRdxWeL4mTR+wXlsuUf
         fVGGrIhGWDrgqMTlDUiFU/iYve4rn5NadeaJs3lGkCrZHHLpMVBJeF3hkaW10Zohc7
         v7dSEaFotzXO7PYfNbi5maeaCKYCqVZ7T7fZ3Bcs=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        Peter Jones <pjones@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH 1/7] efi: pstore: disentangle from deprecated efivars module
Date:   Wed, 23 Sep 2020 18:13:58 +0200
Message-Id: <20200923161404.17811-2-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200923161404.17811-1-ardb@kernel.org>
References: <20200923161404.17811-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The EFI pstore implementation relies on the 'efivars' abstraction,
which encapsulates the EFI variable store in a way that can be
overridden by other backing stores, like the Google SMI one.

On top of that, the EFI pstore implementation also relies on the
efivars.ko module, which is a separate layer built on top of the
'efivars' abstraction that exposes the [deprecated] sysfs entries
for each variable that exists in the backing store.

Since the efivars.ko module is deprecated, and all users appear to
have moved to the efivarfs file system instead, let's prepare for
its removal, by removing EFI pstore's dependency on it.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/Kconfig      |  2 +-
 drivers/firmware/efi/efi-pstore.c | 76 ++++++++++++++++++--
 drivers/firmware/efi/efivars.c    | 41 +----------
 include/linux/efi.h               |  4 --
 4 files changed, 74 insertions(+), 49 deletions(-)

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 3939699e62fe..dd8d10817bdf 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -26,7 +26,7 @@ config EFI_ESRT
 
 config EFI_VARS_PSTORE
 	tristate "Register efivars backend for pstore"
-	depends on EFI_VARS && PSTORE
+	depends on PSTORE
 	default y
 	help
 	  Say Y here to enable use efivars as a backend to pstore. This
diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
index feb7fe6f2da7..785f5e6b3a41 100644
--- a/drivers/firmware/efi/efi-pstore.c
+++ b/drivers/firmware/efi/efi-pstore.c
@@ -8,6 +8,8 @@
 
 #define DUMP_NAME_LEN 66
 
+#define EFIVARS_DATA_SIZE_MAX 1024
+
 static bool efivars_pstore_disable =
 	IS_ENABLED(CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE);
 
@@ -18,6 +20,8 @@ module_param_named(pstore_disable, efivars_pstore_disable, bool, 0644);
 	 EFI_VARIABLE_BOOTSERVICE_ACCESS | \
 	 EFI_VARIABLE_RUNTIME_ACCESS)
 
+static LIST_HEAD(efi_pstore_list);
+
 static int efi_pstore_open(struct pstore_info *psi)
 {
 	psi->data = NULL;
@@ -126,7 +130,7 @@ static inline int __efi_pstore_scan_sysfs_exit(struct efivar_entry *entry,
 	if (entry->deleting) {
 		list_del(&entry->list);
 		efivar_entry_iter_end();
-		efivar_unregister(entry);
+		kfree(entry);
 		if (efivar_entry_iter_begin())
 			return -EINTR;
 	} else if (turn_off_scanning)
@@ -169,7 +173,7 @@ static int efi_pstore_sysfs_entry_iter(struct pstore_record *record)
 {
 	struct efivar_entry **pos = (struct efivar_entry **)&record->psi->data;
 	struct efivar_entry *entry, *n;
-	struct list_head *head = &efivar_sysfs_list;
+	struct list_head *head = &efi_pstore_list;
 	int size = 0;
 	int ret;
 
@@ -314,12 +318,12 @@ static int efi_pstore_erase_name(const char *name)
 	if (efivar_entry_iter_begin())
 		return -EINTR;
 
-	found = __efivar_entry_iter(efi_pstore_erase_func, &efivar_sysfs_list,
+	found = __efivar_entry_iter(efi_pstore_erase_func, &efi_pstore_list,
 				    efi_name, &entry);
 	efivar_entry_iter_end();
 
 	if (found && !entry->scanning)
-		efivar_unregister(entry);
+		kfree(entry);
 
 	return found ? 0 : -ENOENT;
 }
@@ -354,14 +358,76 @@ static struct pstore_info efi_pstore_info = {
 	.erase		= efi_pstore_erase,
 };
 
+static int efi_pstore_callback(efi_char16_t *name, efi_guid_t vendor,
+			       unsigned long name_size, void *data)
+{
+	struct efivar_entry *entry;
+	int ret;
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	memcpy(entry->var.VariableName, name, name_size);
+	entry->var.VendorGuid = vendor;
+
+	ret = efivar_entry_add(entry, &efi_pstore_list);
+	if (ret)
+		kfree(entry);
+
+	return ret;
+}
+
+static int efi_pstore_update_entry(efi_char16_t *name, efi_guid_t vendor,
+				   unsigned long name_size, void *data)
+{
+	struct efivar_entry *entry = data;
+
+	if (efivar_entry_find(name, vendor, &efi_pstore_list, false))
+		return 0;
+
+	memcpy(entry->var.VariableName, name, name_size);
+	memcpy(&(entry->var.VendorGuid), &vendor, sizeof(efi_guid_t));
+
+	return 1;
+}
+
+static void efi_pstore_update_entries(struct work_struct *work)
+{
+	struct efivar_entry *entry;
+	int err;
+
+	/* Add new sysfs entries */
+	while (1) {
+		entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+		if (!entry)
+			return;
+
+		err = efivar_init(efi_pstore_update_entry, entry,
+				  false, &efi_pstore_list);
+		if (!err)
+			break;
+
+		efivar_entry_add(entry, &efi_pstore_list);
+	}
+
+	kfree(entry);
+}
+
 static __init int efivars_pstore_init(void)
 {
+	int ret;
+
 	if (!efivars_kobject() || !efivar_supports_writes())
 		return 0;
 
 	if (efivars_pstore_disable)
 		return 0;
 
+	ret = efivar_init(efi_pstore_callback, NULL, true, &efi_pstore_list);
+	if (ret)
+		return ret;
+
 	efi_pstore_info.buf = kmalloc(4096, GFP_KERNEL);
 	if (!efi_pstore_info.buf)
 		return -ENOMEM;
@@ -374,6 +440,8 @@ static __init int efivars_pstore_init(void)
 		efi_pstore_info.bufsize = 0;
 	}
 
+	INIT_WORK(&efivar_work, efi_pstore_update_entries);
+
 	return 0;
 }
 
diff --git a/drivers/firmware/efi/efivars.c b/drivers/firmware/efi/efivars.c
index dcea137142b3..f39321dbc29f 100644
--- a/drivers/firmware/efi/efivars.c
+++ b/drivers/firmware/efi/efivars.c
@@ -24,8 +24,7 @@ MODULE_LICENSE("GPL");
 MODULE_VERSION(EFIVARS_VERSION);
 MODULE_ALIAS("platform:efivars");
 
-LIST_HEAD(efivar_sysfs_list);
-EXPORT_SYMBOL_GPL(efivar_sysfs_list);
+static LIST_HEAD(efivar_sysfs_list);
 
 static struct kset *efivars_kset;
 
@@ -591,42 +590,6 @@ create_efivars_bin_attributes(void)
 	return error;
 }
 
-static int efivar_update_sysfs_entry(efi_char16_t *name, efi_guid_t vendor,
-				     unsigned long name_size, void *data)
-{
-	struct efivar_entry *entry = data;
-
-	if (efivar_entry_find(name, vendor, &efivar_sysfs_list, false))
-		return 0;
-
-	memcpy(entry->var.VariableName, name, name_size);
-	memcpy(&(entry->var.VendorGuid), &vendor, sizeof(efi_guid_t));
-
-	return 1;
-}
-
-static void efivar_update_sysfs_entries(struct work_struct *work)
-{
-	struct efivar_entry *entry;
-	int err;
-
-	/* Add new sysfs entries */
-	while (1) {
-		entry = kzalloc(sizeof(*entry), GFP_KERNEL);
-		if (!entry)
-			return;
-
-		err = efivar_init(efivar_update_sysfs_entry, entry,
-				  false, &efivar_sysfs_list);
-		if (!err)
-			break;
-
-		efivar_create_sysfs_entry(entry);
-	}
-
-	kfree(entry);
-}
-
 static int efivars_sysfs_callback(efi_char16_t *name, efi_guid_t vendor,
 				  unsigned long name_size, void *data)
 {
@@ -701,8 +664,6 @@ int efivars_sysfs_init(void)
 		return error;
 	}
 
-	INIT_WORK(&efivar_work, efivar_update_sysfs_entries);
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(efivars_sysfs_init);
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 73db1ae04cef..a470256f5ee3 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -984,8 +984,6 @@ struct efivar_entry {
 	bool deleting;
 };
 
-extern struct list_head efivar_sysfs_list;
-
 static inline void
 efivar_unregister(struct efivar_entry *var)
 {
@@ -1043,8 +1041,6 @@ void efivar_run_worker(void);
 #if defined(CONFIG_EFI_VARS) || defined(CONFIG_EFI_VARS_MODULE)
 int efivars_sysfs_init(void);
 
-#define EFIVARS_DATA_SIZE_MAX 1024
-
 #endif /* CONFIG_EFI_VARS */
 extern bool efi_capsule_pending(int *reset_type);
 
-- 
2.17.1

