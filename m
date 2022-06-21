Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0394F553631
	for <lists+linux-efi@lfdr.de>; Tue, 21 Jun 2022 17:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352198AbiFUPgs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 21 Jun 2022 11:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352122AbiFUPgl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 21 Jun 2022 11:36:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C312AC5D;
        Tue, 21 Jun 2022 08:36:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD973617B1;
        Tue, 21 Jun 2022 15:36:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02DC9C341C4;
        Tue, 21 Jun 2022 15:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655825799;
        bh=KD/hF3zJ/eAmndtkBzYxCLXSh9ebX5LMntETgnfP0/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TlPSpPmu3e30kgnDu69SM3B8HUTaIaXAPl/GYETdbHEVuTiCKn2dnSOvejeOneUL2
         p7ALcCymGPjGpO6tvE0d7gHFePmWygemv7fN1HJCKAr7O5gcOHBTv3AOuTbI7o+hyA
         0+FuEG5/5e/8vfTeRqqWPkQghEEPX7aFuDR1W0GgHs/z6KRJNoqkmuIqjyQb2B0QF8
         jJEZxECyqEz5HUmbisuHKThc/Aex9WlW4VhGmUzWsc4AzTILS5LUEYYAojE3lGVnhc
         ZIwSCKh1x8QzRmNPTm1ltKcV/RpBr6Pr2kwgIMGWwQjJZGe0oq/CNBeqDYGKnbAkcz
         dRR3eg07kY0SQ==
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
Subject: [PATCH v2 3/9] efi: vars: Add thin wrapper around EFI get/set variable interface
Date:   Tue, 21 Jun 2022 17:36:17 +0200
Message-Id: <20220621153623.3786960-4-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220621153623.3786960-1-ardb@kernel.org>
References: <20220621153623.3786960-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7635; h=from:subject; bh=KD/hF3zJ/eAmndtkBzYxCLXSh9ebX5LMntETgnfP0/4=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiseVrkn24VTgSrWc+EHPzY1wDUPYo3MkPh6frskhc mhCu0O2JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYrHlawAKCRDDTyI5ktmPJN2KC/ 0QGS5WsXOEr+FSFjPu40oqgtd6gMe8FcuCOLFl6JP9ExUckt4PKkolh0HEYdNquxWnwDH4ZB71r0kJ cuBSHlp7j3S6OqRDVAjqnB4dbDv6TI4ORHD6ATV/GK32n2UA7TSS2i5RyOYx4tm7AZNEhvf7JlU1JY 4IbDHhoF0lxh3zsH/Ui3PZgWXUtLQQ3Tu5jBZTel1k2HlWg4RNJKimVLaYE7J+lcDMChgGW4ZHIb9A IxNBW+N1nw2XJGP70JZNhhZ4o65Y1AyuTQhzspBYpkzy4DsRF5MKPtLQ8A4o/QGvV0aUFwNe0ih1Xw 2SfzMcY6Pc+qj+A0b89SNQlF909iocbIp6zFYi7HPqp5CGHqJj6IVXjWDIycWkAYwv/econbJdljOo 1w2gXoTTMKbhy+3HSYd66wUrgj1949+TwKcm+LnDhSiVmiXsqgBQQdeHNd5UZ+gAwUMN5f6zQsybgn oaAFAsmrqTAfDwhNWUXvNqQ2OU1Hw6bjYYp+m2wST7DXE=
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

