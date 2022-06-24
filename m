Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3105595B9
	for <lists+linux-efi@lfdr.de>; Fri, 24 Jun 2022 10:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbiFXIt6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Jun 2022 04:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiFXIt4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 24 Jun 2022 04:49:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064BF60E24;
        Fri, 24 Jun 2022 01:49:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A42AB827D0;
        Fri, 24 Jun 2022 08:49:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F6DC34114;
        Fri, 24 Jun 2022 08:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656060587;
        bh=KD/hF3zJ/eAmndtkBzYxCLXSh9ebX5LMntETgnfP0/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q5nQV+D6kYfu7AT/JKphUS2gZiMdoRS0Fq+BkVYVpJQkaxDFu3jMisj1klyYlmxRu
         tlvW79Mn2JsQJrz1AE5WPsAY3Ds8LJM3WXOdmniFe1rS0bz7hOxTi1d1eF07BF/wO5
         W5CE/boJ3wQgdoSYJKuZoeEB49CU8vC5rRAyrfEfH5EljsdBEZDDFPf1OdbP8CAhBe
         KUmDRhPnPfSmFvw833GrBYbzydhHjVNzPu+mIg/vq5tAqgNkmURl1tA1fSZd7pGoN0
         1i2svKnAHhN+TQa2yC3PaNb5+rDNIVFNbg2C7TOAqjnkmA6Gnn+jAglsW7EaCrt9y9
         lgK+DbeGhRP8A==
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
Subject: [PATCH v3 3/9] efi: vars: Add thin wrapper around EFI get/set variable interface
Date:   Fri, 24 Jun 2022 10:49:19 +0200
Message-Id: <20220624084925.724516-4-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220624084925.724516-1-ardb@kernel.org>
References: <20220624084925.724516-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7635; h=from:subject; bh=KD/hF3zJ/eAmndtkBzYxCLXSh9ebX5LMntETgnfP0/4=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBitXqKkn24VTgSrWc+EHPzY1wDUPYo3MkPh6frskhc mhCu0O2JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYrV6igAKCRDDTyI5ktmPJJssDA CgRv0h5dyOzwBvhQ/54jN3img++5LevHNnbUePWMUdzpqkFm0MBkXKcdiPwG4Dbm2zd1ywg9Tpgoxe /3/Vef3IBd9r7uwXDxq3Ae6hE16DA/vpAnpzBSNQ+0nvgCevHvOWnIoJwzGmB17r6uC1lhkRqgXWe5 W60c9TROM6cEvwmuNgxo8laeNCGCMCg62qlrhUc2JGQzFW/2AEkoUKmBlDKUdQmX7QkGSj4pBFXKy+ 69CUeiv1jt8fasSeVMbF2jYjI1s1xifyu5bAFzbTJ0yTzmFJAT3fq1yJDmAmnGeI7PvjNxaayd8Gcv mFRPEUzezmvYwnfFi7kTQEb7W96/tPdEsZE7tRoeLM6UO3siWAlZeq397zBsuqTEBtKztDZi8w60iB NaKTccXU+rgDghQHDDWcs0H+cY1GSHtVY9f3CZu19/+L0TNbu1pXlqYmTM2DdYP3P5b5gva8EI8jgb uwLLvdZFaKd7oG1kTV5sRcfvcT/WfZJUdiZ8gOH2mGWKU=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The current efivars layer is a jumble of list iterators, shadow data
structures and safe variable manipulation helpers that really belong in
the efivarfs pseudo file system once the obsolete sysfs access method to
EFI variables is removed.

So split off a minimal efivar get/set variable API that reuses the
existing efivars_lock semaphore to mediate access to the various runtime
services, primarily to ensure that performing a SetVariable() on one CPU
while another is calling GetNextVariable() in a loop to enumerate the
contents of the EFI variable store does not result in surprises.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/vars.c | 154 ++++++++++++++++++--
 include/linux/efi.h         |  20 +++
 2 files changed, 164 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index 146360e2f1cb..41c82614a4b2 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -298,14 +298,10 @@ efivar_variable_is_removable(efi_guid_t vendor, const char *var_name,
 }
 EXPORT_SYMBOL_GPL(efivar_variable_is_removable);
 
-static efi_status_t
-check_var_size(u32 attributes, unsigned long size)
+efi_status_t check_var_size(u32 attributes, unsigned long size)
 {
 	const struct efivar_operations *fops;
 
-	if (!__efivars)
-		return EFI_UNSUPPORTED;
-
 	fops = __efivars->ops;
 
 	if (!fops->query_variable_store)
@@ -313,15 +309,12 @@ check_var_size(u32 attributes, unsigned long size)
 
 	return fops->query_variable_store(attributes, size, false);
 }
+EXPORT_SYMBOL_NS_GPL(check_var_size, EFIVAR);
 
-static efi_status_t
-check_var_size_nonblocking(u32 attributes, unsigned long size)
+efi_status_t check_var_size_nonblocking(u32 attributes, unsigned long size)
 {
 	const struct efivar_operations *fops;
 
-	if (!__efivars)
-		return EFI_UNSUPPORTED;
-
 	fops = __efivars->ops;
 
 	if (!fops->query_variable_store)
@@ -329,6 +322,7 @@ check_var_size_nonblocking(u32 attributes, unsigned long size)
 
 	return fops->query_variable_store(attributes, size, true);
 }
+EXPORT_SYMBOL_NS_GPL(check_var_size_nonblocking, EFIVAR);
 
 static bool variable_is_present(efi_char16_t *variable_name, efi_guid_t *vendor,
 				struct list_head *head)
@@ -1220,3 +1214,143 @@ int efivar_supports_writes(void)
 	return __efivars && __efivars->ops->set_variable;
 }
 EXPORT_SYMBOL_GPL(efivar_supports_writes);
+
+/*
+ * efivar_lock() - obtain the efivar lock, wait for it if needed
+ * @return 0 on success, error code on failure
+ */
+int efivar_lock(void)
+{
+	if (down_interruptible(&efivars_lock))
+		return -EINTR;
+	if (!__efivars->ops) {
+		up(&efivars_lock);
+		return -ENODEV;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(efivar_lock, EFIVAR);
+
+/*
+ * efivar_lock() - obtain the efivar lock if it is free
+ * @return 0 on success, error code on failure
+ */
+int efivar_trylock(void)
+{
+	if (down_trylock(&efivars_lock))
+		 return -EBUSY;
+	if (!__efivars->ops) {
+		up(&efivars_lock);
+		return -ENODEV;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(efivar_trylock, EFIVAR);
+
+/*
+ * efivar_unlock() - release the efivar lock
+ */
+void efivar_unlock(void)
+{
+	up(&efivars_lock);
+}
+EXPORT_SYMBOL_NS_GPL(efivar_unlock, EFIVAR);
+
+/*
+ * efivar_get_variable() - retrieve a variable identified by name/vendor
+ *
+ * Must be called with efivars_lock held.
+ */
+efi_status_t efivar_get_variable(efi_char16_t *name, efi_guid_t *vendor,
+				 u32 *attr, unsigned long *size, void *data)
+{
+	return __efivars->ops->get_variable(name, vendor, attr, size, data);
+}
+EXPORT_SYMBOL_NS_GPL(efivar_get_variable, EFIVAR);
+
+/*
+ * efivar_get_next_variable() - enumerate the next name/vendor pair
+ *
+ * Must be called with efivars_lock held.
+ */
+efi_status_t efivar_get_next_variable(unsigned long *name_size,
+				      efi_char16_t *name, efi_guid_t *vendor)
+{
+	return __efivars->ops->get_next_variable(name_size, name, vendor);
+}
+EXPORT_SYMBOL_NS_GPL(efivar_get_next_variable, EFIVAR);
+
+/*
+ * efivar_set_variable_blocking() - local helper function for set_variable
+ *
+ * Must be called with efivars_lock held.
+ */
+static efi_status_t
+efivar_set_variable_blocking(efi_char16_t *name, efi_guid_t *vendor,
+			     u32 attr, unsigned long data_size, void *data)
+{
+	efi_status_t status;
+
+	if (data_size > 0) {
+		status = check_var_size(attr, data_size +
+					      ucs2_strsize(name, 1024));
+		if (status != EFI_SUCCESS)
+			return status;
+	}
+	return __efivars->ops->set_variable(name, vendor, attr, data_size, data);
+}
+
+/*
+ * efivar_set_variable_locked() - set a variable identified by name/vendor
+ *
+ * Must be called with efivars_lock held. If @nonblocking is set, it will use
+ * non-blocking primitives so it is guaranteed not to sleep.
+ */
+efi_status_t efivar_set_variable_locked(efi_char16_t *name, efi_guid_t *vendor,
+					u32 attr, unsigned long data_size,
+					void *data, bool nonblocking)
+{
+	efi_set_variable_t *setvar;
+	efi_status_t status;
+
+	if (!nonblocking)
+		return efivar_set_variable_blocking(name, vendor, attr,
+						    data_size, data);
+
+	/*
+	 * If no _nonblocking variant exists, the ordinary one
+	 * is assumed to be non-blocking.
+	 */
+	setvar = __efivars->ops->set_variable_nonblocking ?:
+		 __efivars->ops->set_variable;
+
+	if (data_size > 0) {
+		status = check_var_size_nonblocking(attr, data_size +
+							  ucs2_strsize(name, 1024));
+		if (status != EFI_SUCCESS)
+			return status;
+	}
+	return setvar(name, vendor, attr, data_size, data);
+}
+EXPORT_SYMBOL_NS_GPL(efivar_set_variable_locked, EFIVAR);
+
+/*
+ * efivar_set_variable() - set a variable identified by name/vendor
+ *
+ * Can be called without holding the efivars_lock. Will sleep on obtaining the
+ * lock, or on obtaining other locks that are needed in order to complete the
+ * call.
+ */
+efi_status_t efivar_set_variable(efi_char16_t *name, efi_guid_t *vendor,
+				 u32 attr, unsigned long data_size, void *data)
+{
+	efi_status_t status;
+
+	if (efivar_lock())
+		return EFI_ABORTED;
+
+	status = efivar_set_variable_blocking(name, vendor, attr, data_size, data);
+	efivar_unlock();
+	return status;
+}
+EXPORT_SYMBOL_NS_GPL(efivar_set_variable, EFIVAR);
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 56f04b6daeb0..c828ab6f0e2a 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1099,6 +1099,26 @@ bool efivar_validate(efi_guid_t vendor, efi_char16_t *var_name, u8 *data,
 bool efivar_variable_is_removable(efi_guid_t vendor, const char *name,
 				  size_t len);
 
+int efivar_lock(void);
+int efivar_trylock(void);
+void efivar_unlock(void);
+
+efi_status_t efivar_get_variable(efi_char16_t *name, efi_guid_t *vendor,
+				 u32 *attr, unsigned long *size, void *data);
+
+efi_status_t efivar_get_next_variable(unsigned long *name_size,
+				      efi_char16_t *name, efi_guid_t *vendor);
+
+efi_status_t efivar_set_variable_locked(efi_char16_t *name, efi_guid_t *vendor,
+					u32 attr, unsigned long data_size,
+					void *data, bool nonblocking);
+
+efi_status_t efivar_set_variable(efi_char16_t *name, efi_guid_t *vendor,
+				 u32 attr, unsigned long data_size, void *data);
+
+efi_status_t check_var_size(u32 attributes, unsigned long size);
+efi_status_t check_var_size_nonblocking(u32 attributes, unsigned long size);
+
 #if IS_ENABLED(CONFIG_EFI_CAPSULE_LOADER)
 extern bool efi_capsule_pending(int *reset_type);
 
-- 
2.35.1

