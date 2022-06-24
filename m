Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AD75595AE
	for <lists+linux-efi@lfdr.de>; Fri, 24 Jun 2022 10:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbiFXIuM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Jun 2022 04:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbiFXIt5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 24 Jun 2022 04:49:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CAF77078;
        Fri, 24 Jun 2022 01:49:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37B2FB8269D;
        Fri, 24 Jun 2022 08:49:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784F5C341C8;
        Fri, 24 Jun 2022 08:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656060590;
        bh=kzFjhw8Xb3a3larN7JfeNLNVg/ZQF9igvpbRu6yvEq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Or+SC0GBnyoQ0tqh/k3n1mcEPV3rcJ120YUn/zUMVtBcOe5Kl2pfL8LBIKeIdDuFA
         nbwJIVIyroaIFCjMFzmXy55OfiLi1Gi6g87HSpeqr5HyoYfzxRRIQMYe5Cqn1hMaHy
         jNQi/K2m+p/8d8v3PmJQagyyTe7jBrA4yxMqFGitZtEr4b9JcQwQ2TYJYa+VhPplId
         qDps1WC66APYcoTSIzbN//E9JvuDn0EvpiSTRNDakOxxoNTKvPjpfkHJFXpbXq8gKI
         a+H3ZPW8U6P/gM+R2NRKedCe8ZFp13QfAMZu4gO6dTB0edpAlyAMbjTsfdgquEpwqI
         g+yFQd1IgR8MQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>, Jeremy Kerr <jk@ozlabs.org>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v3 4/9] efi: pstore: Omit efivars caching EFI varstore access layer
Date:   Fri, 24 Jun 2022 10:49:20 +0200
Message-Id: <20220624084925.724516-5-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220624084925.724516-1-ardb@kernel.org>
References: <20220624084925.724516-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15632; h=from:subject; bh=kzFjhw8Xb3a3larN7JfeNLNVg/ZQF9igvpbRu6yvEq8=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBitXqLuOeIzgM5rz+ZVhAycPG+Ua0Doc1u37rxWIeG nXBhZguJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYrV6iwAKCRDDTyI5ktmPJIPWC/ 0WjdmbDRXTVl4GkuwFRpAAvsv3sLIWbWqxjnl5rpSkFfSZXycrw5GKI5xyk1noQVRXYH2u+JlS4yY3 T5L0z+X0CQr7ueJc8VrIm3OlSXwbTMK+R5s0FTRklgg+wdSquMHvU8h9shoUyIT+k0g0q4ZQoOui0X Ktkn7EVdcq38OK9zCaUY0pwWcYG+RkfHQaHAFezrAgMIG7QYp1bMQDFW0C9fRR74wDDbu2wyyxhgE/ s9vi7sUek1D9u/hZ802z4/1tQkS3CO/WShT79auXGE9zAWs60UKbH1gYFf/WzwZWwU31yDiu4Barxr kfPAcYT6vL0L4CexWUY/CncF6plM2fGXiIQvcoFE6Kl8gKz3folJWll35RSK68rCiR7oVu70oyuDVy WAD9RPjOXffzvUJv2wyuQoh7ahYSEGpQ007rexXJYyBrM/QU1JwJeoYjufHMCX7/zEskRTUb65SC1U lYlDUFLVcKFzekWjNtZkIc4CGhG6R4JYSnH5+Utz/P9AI=
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

Avoid the efivars layer and simply call the newly introduced EFI
varstore helpers instead. This simplifies the code substantially, and
also allows us to remove some hacks in the shared efivars layer that
were added for efi-pstore specifically.

In order to be able to delete the EFI variable associated with a record,
store the UTF-16 name of the variable in the pstore record's priv field.
That way, we don't have to make guesses regarding which variable the
record may have been loaded from.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/Kconfig      |   1 +
 drivers/firmware/efi/efi-pstore.c | 374 +++++---------------
 drivers/firmware/efi/efivars.c    |  12 +-
 drivers/firmware/efi/vars.c       |  12 +-
 include/linux/efi.h               |   2 -
 5 files changed, 91 insertions(+), 310 deletions(-)

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 6fd4414c4836..7fe8b5c686d2 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -22,6 +22,7 @@ config EFI_ESRT
 config EFI_VARS_PSTORE
 	tristate "Register efivars backend for pstore"
 	depends on PSTORE
+	select UCS2_STRING
 	default y
 	help
 	  Say Y here to enable use efivars as a backend to pstore. This
diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
index 0d80cc7ff6ca..3bddc152fcd4 100644
--- a/drivers/firmware/efi/efi-pstore.c
+++ b/drivers/firmware/efi/efi-pstore.c
@@ -6,6 +6,8 @@
 #include <linux/slab.h>
 #include <linux/ucs2_string.h>
 
+MODULE_IMPORT_NS(EFIVAR);
+
 #define DUMP_NAME_LEN 66
 
 #define EFIVARS_DATA_SIZE_MAX 1024
@@ -20,18 +22,25 @@ module_param_named(pstore_disable, efivars_pstore_disable, bool, 0644);
 	 EFI_VARIABLE_BOOTSERVICE_ACCESS | \
 	 EFI_VARIABLE_RUNTIME_ACCESS)
 
-static LIST_HEAD(efi_pstore_list);
-static DECLARE_WORK(efivar_work, NULL);
-
 static int efi_pstore_open(struct pstore_info *psi)
 {
-	psi->data = NULL;
+	int err;
+
+	err = efivar_lock();
+	if (err)
+		return err;
+
+	psi->data = kzalloc(EFIVARS_DATA_SIZE_MAX, GFP_KERNEL);
+	if (!psi->data)
+		return -ENOMEM;
+
 	return 0;
 }
 
 static int efi_pstore_close(struct pstore_info *psi)
 {
-	psi->data = NULL;
+	efivar_unlock();
+	kfree(psi->data);
 	return 0;
 }
 
@@ -40,22 +49,17 @@ static inline u64 generic_id(u64 timestamp, unsigned int part, int count)
 	return (timestamp * 100 + part) * 1000 + count;
 }
 
-static int efi_pstore_read_func(struct efivar_entry *entry,
-				struct pstore_record *record)
+static int efi_pstore_read_func(struct pstore_record *record,
+				efi_char16_t *varname)
 {
-	efi_guid_t vendor = LINUX_EFI_CRASH_GUID;
+	unsigned long wlen, size = EFIVARS_DATA_SIZE_MAX;
 	char name[DUMP_NAME_LEN], data_type;
-	int i;
+	efi_status_t status;
 	int cnt;
 	unsigned int part;
-	unsigned long size;
 	u64 time;
 
-	if (efi_guidcmp(entry->var.VendorGuid, vendor))
-		return 0;
-
-	for (i = 0; i < DUMP_NAME_LEN; i++)
-		name[i] = entry->var.VariableName[i];
+	ucs2_as_utf8(name, varname, DUMP_NAME_LEN);
 
 	if (sscanf(name, "dump-type%u-%u-%d-%llu-%c",
 		   &record->type, &part, &cnt, &time, &data_type) == 5) {
@@ -95,161 +99,75 @@ static int efi_pstore_read_func(struct efivar_entry *entry,
 	} else
 		return 0;
 
-	entry->var.DataSize = 1024;
-	__efivar_entry_get(entry, &entry->var.Attributes,
-			   &entry->var.DataSize, entry->var.Data);
-	size = entry->var.DataSize;
-	memcpy(record->buf, entry->var.Data,
-	       (size_t)min_t(unsigned long, EFIVARS_DATA_SIZE_MAX, size));
-
-	return size;
-}
-
-/**
- * efi_pstore_scan_sysfs_enter
- * @pos: scanning entry
- * @next: next entry
- * @head: list head
- */
-static void efi_pstore_scan_sysfs_enter(struct efivar_entry *pos,
-					struct efivar_entry *next,
-					struct list_head *head)
-{
-	pos->scanning = true;
-	if (&next->list != head)
-		next->scanning = true;
-}
-
-/**
- * __efi_pstore_scan_sysfs_exit
- * @entry: deleting entry
- * @turn_off_scanning: Check if a scanning flag should be turned off
- */
-static inline int __efi_pstore_scan_sysfs_exit(struct efivar_entry *entry,
-						bool turn_off_scanning)
-{
-	if (entry->deleting) {
-		list_del(&entry->list);
-		efivar_entry_iter_end();
-		kfree(entry);
-		if (efivar_entry_iter_begin())
-			return -EINTR;
-	} else if (turn_off_scanning)
-		entry->scanning = false;
-
-	return 0;
-}
-
-/**
- * efi_pstore_scan_sysfs_exit
- * @pos: scanning entry
- * @next: next entry
- * @head: list head
- * @stop: a flag checking if scanning will stop
- */
-static int efi_pstore_scan_sysfs_exit(struct efivar_entry *pos,
-				       struct efivar_entry *next,
-				       struct list_head *head, bool stop)
-{
-	int ret = __efi_pstore_scan_sysfs_exit(pos, true);
-
-	if (ret)
-		return ret;
-
-	if (stop)
-		ret = __efi_pstore_scan_sysfs_exit(next, &next->list != head);
-	return ret;
-}
+	record->buf = kmalloc(size, GFP_KERNEL);
+	if (!record->buf)
+		return -ENOMEM;
 
-/**
- * efi_pstore_sysfs_entry_iter
- *
- * @record: pstore record to pass to callback
- *
- * You MUST call efivar_entry_iter_begin() before this function, and
- * efivar_entry_iter_end() afterwards.
- *
- */
-static int efi_pstore_sysfs_entry_iter(struct pstore_record *record)
-{
-	struct efivar_entry **pos = (struct efivar_entry **)&record->psi->data;
-	struct efivar_entry *entry, *n;
-	struct list_head *head = &efi_pstore_list;
-	int size = 0;
-	int ret;
-
-	if (!*pos) {
-		list_for_each_entry_safe(entry, n, head, list) {
-			efi_pstore_scan_sysfs_enter(entry, n, head);
-
-			size = efi_pstore_read_func(entry, record);
-			ret = efi_pstore_scan_sysfs_exit(entry, n, head,
-							 size < 0);
-			if (ret)
-				return ret;
-			if (size)
-				break;
-		}
-		*pos = n;
-		return size;
+	status = efivar_get_variable(varname, &LINUX_EFI_CRASH_GUID, NULL,
+				     &size, record->buf);
+	if (status != EFI_SUCCESS) {
+		kfree(record->buf);
+		return -EIO;
 	}
 
-	list_for_each_entry_safe_from((*pos), n, head, list) {
-		efi_pstore_scan_sysfs_enter((*pos), n, head);
-
-		size = efi_pstore_read_func((*pos), record);
-		ret = efi_pstore_scan_sysfs_exit((*pos), n, head, size < 0);
-		if (ret)
-			return ret;
-		if (size)
-			break;
+	/*
+	 * Store the name of the variable in the pstore_record priv field, so
+	 * we can reuse it later if we need to delete the EFI variable from the
+	 * variable store.
+	 */
+	wlen = (ucs2_strnlen(varname, DUMP_NAME_LEN) + 1) * sizeof(efi_char16_t);
+	record->priv = kmemdup(varname, wlen, GFP_KERNEL);
+	if (!record->priv) {
+		kfree(record->buf);
+		return -ENOMEM;
 	}
-	*pos = n;
+
 	return size;
 }
 
-/**
- * efi_pstore_read
- *
- * This function returns a size of NVRAM entry logged via efi_pstore_write().
- * The meaning and behavior of efi_pstore/pstore are as below.
- *
- * size > 0: Got data of an entry logged via efi_pstore_write() successfully,
- *           and pstore filesystem will continue reading subsequent entries.
- * size == 0: Entry was not logged via efi_pstore_write(),
- *            and efi_pstore driver will continue reading subsequent entries.
- * size < 0: Failed to get data of entry logging via efi_pstore_write(),
- *           and pstore will stop reading entry.
- */
 static ssize_t efi_pstore_read(struct pstore_record *record)
 {
-	ssize_t size;
+	efi_char16_t *varname = record->psi->data;
+	efi_guid_t guid = LINUX_EFI_CRASH_GUID;
+	unsigned long varname_size;
+	efi_status_t status;
 
-	record->buf = kzalloc(EFIVARS_DATA_SIZE_MAX, GFP_KERNEL);
-	if (!record->buf)
-		return -ENOMEM;
+	for (;;) {
+		varname_size = EFIVARS_DATA_SIZE_MAX;
 
-	if (efivar_entry_iter_begin()) {
-		size = -EINTR;
-		goto out;
-	}
-	size = efi_pstore_sysfs_entry_iter(record);
-	efivar_entry_iter_end();
+		/*
+		 * If this is the first read() call in the pstore enumeration,
+		 * varname will be the empty string, and the GetNextVariable()
+		 * runtime service call will return the first EFI variable in
+		 * its own enumeration order, ignoring the guid argument.
+		 *
+		 * Subsequent calls to GetNextVariable() must pass the name and
+		 * guid values returned by the previous call, which is why we
+		 * store varname in record->psi->data. Given that we only
+		 * enumerate variables with the efi-pstore GUID, there is no
+		 * need to record the guid return value.
+		 */
+		status = efivar_get_next_variable(&varname_size, varname, &guid);
+		if (status == EFI_NOT_FOUND)
+			return 0;
 
-out:
-	if (size <= 0) {
-		kfree(record->buf);
-		record->buf = NULL;
+		if (status != EFI_SUCCESS)
+			return -EIO;
+
+		/* skip variables that don't concern us */
+		if (efi_guidcmp(guid, LINUX_EFI_CRASH_GUID))
+			continue;
+
+		return efi_pstore_read_func(record, varname);
 	}
-	return size;
 }
 
 static int efi_pstore_write(struct pstore_record *record)
 {
 	char name[DUMP_NAME_LEN];
 	efi_char16_t efi_name[DUMP_NAME_LEN];
-	efi_guid_t vendor = LINUX_EFI_CRASH_GUID;
-	int i, ret = 0;
+	efi_status_t status;
+	int i;
 
 	record->id = generic_id(record->time.tv_sec, record->part,
 				record->count);
@@ -265,88 +183,26 @@ static int efi_pstore_write(struct pstore_record *record)
 	for (i = 0; i < DUMP_NAME_LEN; i++)
 		efi_name[i] = name[i];
 
-	ret = efivar_entry_set_safe(efi_name, vendor, PSTORE_EFI_ATTRIBUTES,
-			      false, record->size, record->psi->buf);
-
-	if (record->reason == KMSG_DUMP_OOPS && try_module_get(THIS_MODULE))
-		if (!schedule_work(&efivar_work))
-			module_put(THIS_MODULE);
-
-	return ret;
+	if (efivar_trylock())
+		return -EBUSY;
+	status = efivar_set_variable_locked(efi_name, &LINUX_EFI_CRASH_GUID,
+					    PSTORE_EFI_ATTRIBUTES,
+					    record->size, record->psi->buf,
+					    true);
+	efivar_unlock();
+	return status == EFI_SUCCESS ? 0 : -EIO;
 };
 
-/*
- * Clean up an entry with the same name
- */
-static int efi_pstore_erase_func(struct efivar_entry *entry, void *data)
-{
-	efi_char16_t *efi_name = data;
-	efi_guid_t vendor = LINUX_EFI_CRASH_GUID;
-	unsigned long ucs2_len = ucs2_strlen(efi_name);
-
-	if (efi_guidcmp(entry->var.VendorGuid, vendor))
-		return 0;
-
-	if (ucs2_strncmp(entry->var.VariableName, efi_name, (size_t)ucs2_len))
-		return 0;
-
-	if (entry->scanning) {
-		/*
-		 * Skip deletion because this entry will be deleted
-		 * after scanning is completed.
-		 */
-		entry->deleting = true;
-	} else
-		list_del(&entry->list);
-
-	/* found */
-	__efivar_entry_delete(entry);
-
-	return 1;
-}
-
-static int efi_pstore_erase_name(const char *name)
-{
-	struct efivar_entry *entry = NULL;
-	efi_char16_t efi_name[DUMP_NAME_LEN];
-	int found, i;
-
-	for (i = 0; i < DUMP_NAME_LEN; i++) {
-		efi_name[i] = name[i];
-		if (name[i] == '\0')
-			break;
-	}
-
-	if (efivar_entry_iter_begin())
-		return -EINTR;
-
-	found = __efivar_entry_iter(efi_pstore_erase_func, &efi_pstore_list,
-				    efi_name, &entry);
-	efivar_entry_iter_end();
-
-	if (found && !entry->scanning)
-		kfree(entry);
-
-	return found ? 0 : -ENOENT;
-}
-
 static int efi_pstore_erase(struct pstore_record *record)
 {
-	char name[DUMP_NAME_LEN];
-	int ret;
+	efi_status_t status;
 
-	snprintf(name, sizeof(name), "dump-type%u-%u-%d-%lld",
-		 record->type, record->part, record->count,
-		 (long long)record->time.tv_sec);
-	ret = efi_pstore_erase_name(name);
-	if (ret != -ENOENT)
-		return ret;
-
-	snprintf(name, sizeof(name), "dump-type%u-%u-%lld",
-		record->type, record->part, (long long)record->time.tv_sec);
-	ret = efi_pstore_erase_name(name);
+	status = efivar_set_variable(record->priv, &LINUX_EFI_CRASH_GUID,
+				     PSTORE_EFI_ATTRIBUTES, 0, NULL);
 
-	return ret;
+	if (status != EFI_SUCCESS && status != EFI_NOT_FOUND)
+		return -EIO;
+	return 0;
 }
 
 static struct pstore_info efi_pstore_info = {
@@ -360,74 +216,14 @@ static struct pstore_info efi_pstore_info = {
 	.erase		= efi_pstore_erase,
 };
 
-static int efi_pstore_callback(efi_char16_t *name, efi_guid_t vendor,
-			       unsigned long name_size, void *data)
-{
-	struct efivar_entry *entry;
-
-	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
-	if (!entry)
-		return -ENOMEM;
-
-	memcpy(entry->var.VariableName, name, name_size);
-	entry->var.VendorGuid = vendor;
-
-	__efivar_entry_add(entry, &efi_pstore_list);
-
-	return 0;
-}
-
-static int efi_pstore_update_entry(efi_char16_t *name, efi_guid_t vendor,
-				   unsigned long name_size, void *data)
-{
-	struct efivar_entry *entry = data;
-
-	if (efivar_entry_find(name, vendor, &efi_pstore_list, false))
-		return 0;
-
-	memcpy(entry->var.VariableName, name, name_size);
-	memcpy(&(entry->var.VendorGuid), &vendor, sizeof(efi_guid_t));
-
-	return 1;
-}
-
-static void efi_pstore_update_entries(struct work_struct *work)
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
-		err = efivar_init(efi_pstore_update_entry, entry,
-				  false, &efi_pstore_list);
-		if (!err)
-			break;
-
-		efivar_entry_add(entry, &efi_pstore_list);
-	}
-
-	kfree(entry);
-	module_put(THIS_MODULE);
-}
-
 static __init int efivars_pstore_init(void)
 {
-	int ret;
-
-	if (!efivars_kobject() || !efivar_supports_writes())
+	if (!efivar_supports_writes())
 		return 0;
 
 	if (efivars_pstore_disable)
 		return 0;
 
-	ret = efivar_init(efi_pstore_callback, NULL, true, &efi_pstore_list);
-	if (ret)
-		return ret;
-
 	efi_pstore_info.buf = kmalloc(4096, GFP_KERNEL);
 	if (!efi_pstore_info.buf)
 		return -ENOMEM;
@@ -440,8 +236,6 @@ static __init int efivars_pstore_init(void)
 		efi_pstore_info.bufsize = 0;
 	}
 
-	INIT_WORK(&efivar_work, efi_pstore_update_entries);
-
 	return 0;
 }
 
diff --git a/drivers/firmware/efi/efivars.c b/drivers/firmware/efi/efivars.c
index c19db0b35c0d..8341fb15f62e 100644
--- a/drivers/firmware/efi/efivars.c
+++ b/drivers/firmware/efi/efivars.c
@@ -467,16 +467,12 @@ static ssize_t efivar_delete(struct file *filp, struct kobject *kobj,
 	else if (__efivar_entry_delete(entry))
 		err = -EIO;
 
-	if (err) {
-		efivar_entry_iter_end();
+	efivar_entry_iter_end();
+
+	if (err)
 		return err;
-	}
 
-	if (!entry->scanning) {
-		efivar_entry_iter_end();
-		efivar_unregister(entry);
-	} else
-		efivar_entry_iter_end();
+	efivar_unregister(entry);
 
 	/* It's dead Jim.... */
 	return count;
diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index 41c82614a4b2..5640ffa81544 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -821,16 +821,8 @@ struct efivar_entry *efivar_entry_find(efi_char16_t *name, efi_guid_t guid,
 	if (!found)
 		return NULL;
 
-	if (remove) {
-		if (entry->scanning) {
-			/*
-			 * The entry will be deleted
-			 * after scanning is completed.
-			 */
-			entry->deleting = true;
-		} else
-			list_del(&entry->list);
-	}
+	if (remove)
+		list_del(&entry->list);
 
 	return entry;
 }
diff --git a/include/linux/efi.h b/include/linux/efi.h
index c828ab6f0e2a..08bc6215e3b4 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1043,8 +1043,6 @@ struct efivar_entry {
 	struct efi_variable var;
 	struct list_head list;
 	struct kobject kobj;
-	bool scanning;
-	bool deleting;
 };
 
 static inline void
-- 
2.35.1

