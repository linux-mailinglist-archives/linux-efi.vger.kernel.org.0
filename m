Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D29553635
	for <lists+linux-efi@lfdr.de>; Tue, 21 Jun 2022 17:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351989AbiFUPgt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 21 Jun 2022 11:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351268AbiFUPgo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 21 Jun 2022 11:36:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEA215A04;
        Tue, 21 Jun 2022 08:36:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEEC4617B9;
        Tue, 21 Jun 2022 15:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF025C341CA;
        Tue, 21 Jun 2022 15:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655825802;
        bh=5YVojKdyXVi0r060ZTkjv/2DfytapGZMtXcjlFHAaSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QXvdqTIYitqMWsXmrJBkK6I4OGHTjji1rjg8UhzE0tEzgpwukUaYD8Iovd7uq0zs8
         3uqE5+pXulWkhTwIj0g4hF8CZ9hzFXbzUa5EQgLpdvoo6eoC9zSPGSQFvvy3P0NvyN
         4VEj5n2KoOab585gq6sZG/OuUnGLind9Dr3jSHlys4KHL3mW/Ux7T3p9481ynL0MbJ
         Kq/e1LByhXPDCM3Q2/AuP0va5cBrmb7ftH2Js4nmqhLqr8vxgRWbU6jv7FmNg2XEC9
         bAr9RRVRgs2K4/sDYZYVsbDW8ZtR3Cw2BZuc/EMswg0gI/2g0sH/SXkfPQ3DHezsPc
         n8jvNzg9emWEQ==
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
Subject: [PATCH v2 4/9] efi: pstore: Omit efivars caching EFI varstore access layer
Date:   Tue, 21 Jun 2022 17:36:18 +0200
Message-Id: <20220621153623.3786960-5-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220621153623.3786960-1-ardb@kernel.org>
References: <20220621153623.3786960-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17527; h=from:subject; bh=5YVojKdyXVi0r060ZTkjv/2DfytapGZMtXcjlFHAaSQ=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiseVtOKkt46wIL+m5WohyQYqjJRWur93Pk46OWIdf J/wXmKiJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYrHlbQAKCRDDTyI5ktmPJGhzDA CRkzaUnDOu5o9YmhJ8C+O77+LAtkNbcKpBhbw2hmnMSBs/A6cD+waLo7aPdGv8cIuZ1IrMMffVysSd V2FXEDWwaG4H+m3lG1650aO4RKiOIcHqgGFaP8IAjjBevwX1G8T4lLmMu4JdxfQMXtDlsmM8ZKDAVJ 4rCedJNyrkfeQx4S9HpzAxPq8SnVilCblsrXIwKbyP3pCwM+pBHL02crnIaCMK81Sq5823gzZ6vUc9 QLOoBouxQMz91lbMQFomxmsE57ILkB66N+GsNsforTID8mhUX5dlmoOODTxq/+cqv2kHxYKAqGtz2J m+jboBWKEhFAUnrOHRMMzP52RTMcgpap5GZghE7rXW3/94zbT8C+S1Es0ajcufZ98SDa4ymiUpeWUC yqJDfpjOJvXOQI8waLn25r0yF1LaeO+8V0Gy+V9nCrpLAKD0Jh/WGXuGPqJ5d8p/EZ1mOUkz5Q6PzW 32tVqOqdl1+sOcgWuXhbgeQJbgeUFXxlRR+e3Gdjk0Sm0=
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

Since we don't store the name of the associated EFI variable into each
pstore record when enumerating them, we have to guess the variable name
it was constructed from at deletion time, since we no longer keep a
shadow copy of the variable store. To make this a bit more exact, store
the CRC-32 of the ASCII name into the pstore record's ECC region so we
can use it later to make an educated guess regarding the name of the EFI
variable.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi-pstore.c | 386 ++++++--------------
 drivers/firmware/efi/efivars.c    |  12 +-
 drivers/firmware/efi/vars.c       |  12 +-
 include/linux/efi.h               |   2 -
 4 files changed, 119 insertions(+), 293 deletions(-)

diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
index 0d80cc7ff6ca..917d3935b58c 100644
--- a/drivers/firmware/efi/efi-pstore.c
+++ b/drivers/firmware/efi/efi-pstore.c
@@ -1,11 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0+
 
+#include <linux/crc32.h>
 #include <linux/efi.h>
 #include <linux/module.h>
 #include <linux/pstore.h>
 #include <linux/slab.h>
 #include <linux/ucs2_string.h>
 
+MODULE_IMPORT_NS(EFIVAR);
+
 #define DUMP_NAME_LEN 66
 
 #define EFIVARS_DATA_SIZE_MAX 1024
@@ -20,18 +23,25 @@ module_param_named(pstore_disable, efivars_pstore_disable, bool, 0644);
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
 
@@ -40,22 +50,20 @@ static inline u64 generic_id(u64 timestamp, unsigned int part, int count)
 	return (timestamp * 100 + part) * 1000 + count;
 }
 
-static int efi_pstore_read_func(struct efivar_entry *entry,
-				struct pstore_record *record)
+static int efi_pstore_read_func(struct pstore_record *record,
+				efi_char16_t *varname)
 {
-	efi_guid_t vendor = LINUX_EFI_CRASH_GUID;
+	unsigned long size = EFIVARS_DATA_SIZE_MAX;
 	char name[DUMP_NAME_LEN], data_type;
+	efi_status_t status;
 	int i;
 	int cnt;
 	unsigned int part;
-	unsigned long size;
 	u64 time;
-
-	if (efi_guidcmp(entry->var.VendorGuid, vendor))
-		return 0;
+	u32 *crc;
 
 	for (i = 0; i < DUMP_NAME_LEN; i++)
-		name[i] = entry->var.VariableName[i];
+		name[i] = varname[i];
 
 	if (sscanf(name, "dump-type%u-%u-%d-%llu-%c",
 		   &record->type, &part, &cnt, &time, &data_type) == 5) {
@@ -68,7 +76,6 @@ static int efi_pstore_read_func(struct efivar_entry *entry,
 			record->compressed = true;
 		else
 			record->compressed = false;
-		record->ecc_notice_size = 0;
 	} else if (sscanf(name, "dump-type%u-%u-%d-%llu",
 		   &record->type, &part, &cnt, &time) == 4) {
 		record->id = generic_id(time, part, cnt);
@@ -77,7 +84,6 @@ static int efi_pstore_read_func(struct efivar_entry *entry,
 		record->time.tv_sec = time;
 		record->time.tv_nsec = 0;
 		record->compressed = false;
-		record->ecc_notice_size = 0;
 	} else if (sscanf(name, "dump-type%u-%u-%llu",
 			  &record->type, &part, &time) == 3) {
 		/*
@@ -91,165 +97,74 @@ static int efi_pstore_read_func(struct efivar_entry *entry,
 		record->time.tv_sec = time;
 		record->time.tv_nsec = 0;
 		record->compressed = false;
-		record->ecc_notice_size = 0;
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
+	record->ecc_notice_size = sizeof(*crc);
+	record->buf = kmalloc(size + record->ecc_notice_size, GFP_KERNEL);
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
+	/*
+	 * Store the CRC-32 of the ASCII name in the record so we can use it to
+	 * reconstruct the name when we need to delete the EFI variable later.
+	 */
+	crc = (u32 *)&record->buf[size];
+	*crc = crc32_le(U32_MAX, name, strlen(name));
 
-		size = efi_pstore_read_func((*pos), record);
-		ret = efi_pstore_scan_sysfs_exit((*pos), n, head, size < 0);
-		if (ret)
-			return ret;
-		if (size)
-			break;
-	}
-	*pos = n;
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
@@ -265,51 +180,62 @@ static int efi_pstore_write(struct pstore_record *record)
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
 
 /*
- * Clean up an entry with the same name
+ * Reconstruct the EFI variable name from which we loaded this record based on
+ * the CRC-32 recorded in the entry.
  */
-static int efi_pstore_erase_func(struct efivar_entry *entry, void *data)
+static int efi_pstore_erase_name(struct pstore_record *record, char *name)
 {
-	efi_char16_t *efi_name = data;
-	efi_guid_t vendor = LINUX_EFI_CRASH_GUID;
-	unsigned long ucs2_len = ucs2_strlen(efi_name);
+	const u32 *crc = (const u32 *)&record->buf[record->size];
+	unsigned long l;
 
-	if (efi_guidcmp(entry->var.VendorGuid, vendor))
+	l = snprintf(name, DUMP_NAME_LEN, "dump-type%u-%u-%d-%lld-C",
+		     record->type, record->part, record->count,
+		     (long long)record->time.tv_sec);
+	if (*crc == crc32_le(U32_MAX, name, l))
 		return 0;
 
-	if (ucs2_strncmp(entry->var.VariableName, efi_name, (size_t)ucs2_len))
+	l = snprintf(name, DUMP_NAME_LEN, "dump-type%u-%u-%d-%lld-D",
+		     record->type, record->part, record->count,
+		     (long long)record->time.tv_sec);
+	if (*crc == crc32_le(U32_MAX, name, l))
 		return 0;
 
-	if (entry->scanning) {
-		/*
-		 * Skip deletion because this entry will be deleted
-		 * after scanning is completed.
-		 */
-		entry->deleting = true;
-	} else
-		list_del(&entry->list);
+	l = snprintf(name, DUMP_NAME_LEN, "dump-type%u-%u-%d-%lld",
+		     record->type, record->part, record->count,
+		     (long long)record->time.tv_sec);
+	if (*crc == crc32_le(U32_MAX, name, l))
+		return 0;
 
-	/* found */
-	__efivar_entry_delete(entry);
+	l = snprintf(name, DUMP_NAME_LEN, "dump-type%u-%u-%lld",
+		     record->type, record->part,
+		     (long long)record->time.tv_sec);
+	if (*crc == crc32_le(U32_MAX, name, l))
+		return 0;
 
-	return 1;
+	return -ENODEV;
 }
 
-static int efi_pstore_erase_name(const char *name)
+static int efi_pstore_erase(struct pstore_record *record)
 {
-	struct efivar_entry *entry = NULL;
 	efi_char16_t efi_name[DUMP_NAME_LEN];
-	int found, i;
+	char name[DUMP_NAME_LEN];
+	efi_status_t status;
+	int i, err;
+
+	err = efi_pstore_erase_name(record, name);
+	if (err)
+		return err;
 
 	for (i = 0; i < DUMP_NAME_LEN; i++) {
 		efi_name[i] = name[i];
@@ -317,36 +243,12 @@ static int efi_pstore_erase_name(const char *name)
 			break;
 	}
 
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
-static int efi_pstore_erase(struct pstore_record *record)
-{
-	char name[DUMP_NAME_LEN];
-	int ret;
-
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
+	status = efivar_set_variable(efi_name, &LINUX_EFI_CRASH_GUID,
+				     PSTORE_EFI_ATTRIBUTES, 0, NULL);
 
-	return ret;
+	if (status != EFI_SUCCESS && status != EFI_NOT_FOUND)
+		return -EIO;
+	return 0;
 }
 
 static struct pstore_info efi_pstore_info = {
@@ -360,74 +262,14 @@ static struct pstore_info efi_pstore_info = {
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
@@ -440,8 +282,6 @@ static __init int efivars_pstore_init(void)
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

