Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6656C553634
	for <lists+linux-efi@lfdr.de>; Tue, 21 Jun 2022 17:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352126AbiFUPgl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 21 Jun 2022 11:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352100AbiFUPgj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 21 Jun 2022 11:36:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9E02A734;
        Tue, 21 Jun 2022 08:36:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD050B81A3C;
        Tue, 21 Jun 2022 15:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C356C341C0;
        Tue, 21 Jun 2022 15:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655825796;
        bh=56IF+p6ZRKtIMtoS9fAs8VmyAr/kQM9xHoUlBuj9S2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ScW07YE5t3mYhd3WBlBt+RJSvGOwaS1mEb6NqRHuDd4h0bc2HuBncwi2AS/yRAHju
         8b/miZl16XcEjkOcpUxQNCByOmOsy/4+349QdqmZDEEZZc928U5stZocmamGxp5pR8
         KUqVsf+PEvKKOGG+3q2SN3jlb6Yq2OzoGHSinwyYAH9w42leRD9w1r6wZjJ5ZHGSNZ
         NKr0vvsu2kjpd2s5ll/j69u9L0C4e0KTs/SEEL5ypBWMW8Faj7mLpfdObFHfyO2MrL
         8atOYatu5gqHbtdHGeH4vSPE6oBUmXyRH65tIcsdQ6SVqR018bJsV3VSXwuPpJ3yF+
         dx4dZVHAki0RQ==
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
Subject: [PATCH v2 2/9] efi: vars: Don't drop lock in the middle of efivar_init()
Date:   Tue, 21 Jun 2022 17:36:16 +0200
Message-Id: <20220621153623.3786960-3-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220621153623.3786960-1-ardb@kernel.org>
References: <20220621153623.3786960-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5517; h=from:subject; bh=56IF+p6ZRKtIMtoS9fAs8VmyAr/kQM9xHoUlBuj9S2A=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiseVqsbWXK1ba1qtaxOzy6beuyeIfsZcL6+fe4pEi OKlnrDuJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYrHlagAKCRDDTyI5ktmPJHwHDA C7jrT8oNH+DGZpJaHGRhGvkgr/ygN3T8jfqTaQiPumMFy6W6nWEUO2WANfAuTh0mHu++qhbIkSK+5Q sQivNL5EQfFr1OrNiE5v4MwQ3KT/Sy09PBS2C0zY6RNBeelDnCL+l/cZz+4lJ4lNt/f2KbTX5xtQ0n 1q7gzeFIgakpO/8h7UXF0ksnaOMfGmU5+DeF59azX+mMgoUzCB3zKTebM8iLu+ickN4wEmB62RRP6D xIBbxXglkNw3XBKMMXoaYslrjPR6hBkBi/RIPiTEf6NUxcK771BHbsM8LoDHfq0gXZHv1b20Pf5pLA Nk+oS9m+Tp/p7MqfEXLavFExoltxAwPAD09xlc+owjFu2thfMkDMMnjBkPXj2jGyuX0B/zwb5cJ1EI NO8ZVjYoNKWeOsAiKmk2/r+j09zrFJnI2lq4reNbCJc0Vz3MzBfXvugtaSbe70uXlVPWOLLPzfZPXN Q1IpB8wV/ooOrPfU2dLm+pV8M68c7PMzUaTk0kQTQlE/k=
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

Even though the efivars_lock lock is documented as protecting the
efivars->ops pointer (among other things), efivar_init() happily
releases and reacquires the lock for every EFI variable that it
enumerates. This used to be needed because the lock was originally a
spinlock, which prevented the callback that is invoked for every
variable from being able to sleep. However, releasing the lock could
potentially invalidate the ops pointer, but more importantly, it might
allow a SetVariable() runtime service call to take place concurrently,
and the UEFI spec does not define how this affects an enumeration that
is running in parallel using the GetNextVariable() runtime service,
which is what efivar_init() uses.

In the meantime, the lock has been converted into a semaphore, and the
only reason we need to drop the lock is because the efivarfs pseudo
filesystem driver will otherwise deadlock when it invokes the efivars
API from the callback to create the efivar_entry items and insert them
into the linked list. (EFI pstore is affected in a similar way)

So let's switch to helpers that can be used while the lock is already
taken. This way, we can hold on to the lock throughout the enumeration.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi-pstore.c |  7 ++-----
 drivers/firmware/efi/efivars.c    |  5 +----
 drivers/firmware/efi/vars.c       | 22 ++++++++++----------
 fs/efivarfs/super.c               |  6 ++----
 include/linux/efi.h               |  1 +
 5 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
index 7e771c56c13c..0d80cc7ff6ca 100644
--- a/drivers/firmware/efi/efi-pstore.c
+++ b/drivers/firmware/efi/efi-pstore.c
@@ -364,7 +364,6 @@ static int efi_pstore_callback(efi_char16_t *name, efi_guid_t vendor,
 			       unsigned long name_size, void *data)
 {
 	struct efivar_entry *entry;
-	int ret;
 
 	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
 	if (!entry)
@@ -373,11 +372,9 @@ static int efi_pstore_callback(efi_char16_t *name, efi_guid_t vendor,
 	memcpy(entry->var.VariableName, name, name_size);
 	entry->var.VendorGuid = vendor;
 
-	ret = efivar_entry_add(entry, &efi_pstore_list);
-	if (ret)
-		kfree(entry);
+	__efivar_entry_add(entry, &efi_pstore_list);
 
-	return ret;
+	return 0;
 }
 
 static int efi_pstore_update_entry(efi_char16_t *name, efi_guid_t vendor,
diff --git a/drivers/firmware/efi/efivars.c b/drivers/firmware/efi/efivars.c
index ea0bc39dc965..c19db0b35c0d 100644
--- a/drivers/firmware/efi/efivars.c
+++ b/drivers/firmware/efi/efivars.c
@@ -527,10 +527,7 @@ efivar_create_sysfs_entry(struct efivar_entry *new_var)
 	}
 
 	kobject_uevent(&new_var->kobj, KOBJ_ADD);
-	if (efivar_entry_add(new_var, &efivar_sysfs_list)) {
-		efivar_unregister(new_var);
-		return -EINTR;
-	}
+	__efivar_entry_add(new_var, &efivar_sysfs_list);
 
 	return 0;
 }
diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index cae590bd08f2..146360e2f1cb 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -450,9 +450,6 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
 						&vendor_guid);
 		switch (status) {
 		case EFI_SUCCESS:
-			if (duplicates)
-				up(&efivars_lock);
-
 			variable_name_size = var_name_strnsize(variable_name,
 							       variable_name_size);
 
@@ -476,14 +473,6 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
 				if (err)
 					status = EFI_NOT_FOUND;
 			}
-
-			if (duplicates) {
-				if (down_interruptible(&efivars_lock)) {
-					err = -EINTR;
-					goto free;
-				}
-			}
-
 			break;
 		case EFI_UNSUPPORTED:
 			err = -EOPNOTSUPP;
@@ -526,6 +515,17 @@ int efivar_entry_add(struct efivar_entry *entry, struct list_head *head)
 }
 EXPORT_SYMBOL_GPL(efivar_entry_add);
 
+/**
+ * __efivar_entry_add - add entry to variable list
+ * @entry: entry to add to list
+ * @head: list head
+ */
+void __efivar_entry_add(struct efivar_entry *entry, struct list_head *head)
+{
+	list_add(&entry->list, head);
+}
+EXPORT_SYMBOL_GPL(__efivar_entry_add);
+
 /**
  * efivar_entry_remove - remove entry from variable list
  * @entry: entry to remove from list
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 15880a68faad..09dfa8362f50 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -155,10 +155,8 @@ static int efivarfs_callback(efi_char16_t *name16, efi_guid_t vendor,
 		goto fail_inode;
 	}
 
-	efivar_entry_size(entry, &size);
-	err = efivar_entry_add(entry, &efivarfs_list);
-	if (err)
-		goto fail_inode;
+	__efivar_entry_get(entry, NULL, &size, NULL);
+	__efivar_entry_add(entry, &efivarfs_list);
 
 	/* copied by the above to local storage in the dentry. */
 	kfree(name);
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 53f64c14a525..56f04b6daeb0 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1064,6 +1064,7 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
 		void *data, bool duplicates, struct list_head *head);
 
 int efivar_entry_add(struct efivar_entry *entry, struct list_head *head);
+void __efivar_entry_add(struct efivar_entry *entry, struct list_head *head);
 int efivar_entry_remove(struct efivar_entry *entry);
 
 int __efivar_entry_delete(struct efivar_entry *entry);
-- 
2.35.1

