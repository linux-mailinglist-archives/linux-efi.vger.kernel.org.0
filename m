Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3866E553639
	for <lists+linux-efi@lfdr.de>; Tue, 21 Jun 2022 17:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352835AbiFUPhF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 21 Jun 2022 11:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352513AbiFUPg4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 21 Jun 2022 11:36:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A08C2A97F;
        Tue, 21 Jun 2022 08:36:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36A0BB81A3C;
        Tue, 21 Jun 2022 15:36:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4A4C341C7;
        Tue, 21 Jun 2022 15:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655825812;
        bh=o3ok/9R+UqcUDjiZQfJKpJOqlYP6HeiJwMpgWwGIlHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g7Wke4tpiZwMdmNRgpML8B3HM2D58MMkPav6aJmukhpeUX3Cck0g3xaGSDtrP0F05
         xSRktC3maZO+b+l9AxFcW/ozm6ybYFevOG1Wd+uMep6uz6mvCksk0t9oKvECFGF/uy
         zAdWvNKouzMBVVMDl/Sy9sfa0Twqed8ZaNqQaY1TOQpf5YxslR5+inqMeAD+DYlUI+
         xJ5cYEEOV5hva0CtltQVfvT1I2PwzYuZVQAoA5HFFxx2yKmYE+FWvjrfS9dl6EarRR
         auVqd+ZY3chFSnKpO9cX4w6YEQhVi+fHQdfYHDQH3CRTWPreaBENlfWFX4I8GwQK+K
         vUeobYDtZgrPw==
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
Subject: [PATCH v2 8/9] efi: vars: Switch to new wrapper layer
Date:   Tue, 21 Jun 2022 17:36:22 +0200
Message-Id: <20220621153623.3786960-9-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220621153623.3786960-1-ardb@kernel.org>
References: <20220621153623.3786960-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8472; h=from:subject; bh=o3ok/9R+UqcUDjiZQfJKpJOqlYP6HeiJwMpgWwGIlHQ=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiseV0EnZCPl3tiCtuUYhPnTsiyC/DnppIVmUimcLK bAwkLqOJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYrHldAAKCRDDTyI5ktmPJK9fDA CVubELxTwa0PlwqbBHNFlFN0hGSO+HvnCjHzJ59F0p67EYNHvcWCiLVJ204ne3NgtxVs2FlD5hzNGR 8rXMpD/uYpe8IBdusN8fU5pEEwK+loTU2leuDEBgSzyFXeVpi9tkL84TZ8TnSRGCLtZgDOSXr7ynFI hA14CJyaih/hQH2tR6K48rwkNT+jQPYQNTOnHph8Z7g13REn6zAcootOHZ+6qDryGPEmDwYCykxfdV V6zUz7QHzhaJ6+ptdUJqSVhokm4hbe/kaXCP5q4yjyVZOtuX0e7ka5u2EZ3u+8eTk+mt2StQsMG2/H QGXkJkE6dmZxDV0+ymFJTai2kx4DPF/vE25JFHoDKOmWCC6X/e00Gneakh0hDN5FgDP0KrQWlndu7s dPNXHblclfb94w57kFy99Ooxjl7jThHNeStnAD7Hd5PpATsB0LeRwsQ44vp1NqsbuSj5Vkj6wQZ0yu sB2XSbfbhutTTwafRB186jrrWB+6lfdQXg9l+BqftuElg=
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

Switch the caching linked-list efivars layer implementation to the newly
introduced efivar get/set variable wrappers, instead of accessing the
lock and the ops pointer directly. This will permit us to move this code
out of the public efivars API, and into efivarfs once the obsolete sysfs
access method is finally removed.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/vars.c | 133 ++++++++------------
 1 file changed, 52 insertions(+), 81 deletions(-)

diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index 94de1d0cb4e7..cafc128a5774 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -408,28 +408,21 @@ static void dup_variable_bug(efi_char16_t *str16, efi_guid_t *vendor_guid,
 int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
 		void *data, bool duplicates, struct list_head *head)
 {
-	const struct efivar_operations *ops;
 	unsigned long variable_name_size = 1024;
 	efi_char16_t *variable_name;
 	efi_status_t status;
 	efi_guid_t vendor_guid;
 	int err = 0;
 
-	if (!__efivars)
-		return -EFAULT;
-
-	ops = __efivars->ops;
-
 	variable_name = kzalloc(variable_name_size, GFP_KERNEL);
 	if (!variable_name) {
 		printk(KERN_ERR "efivars: Memory allocation failed.\n");
 		return -ENOMEM;
 	}
 
-	if (down_interruptible(&efivars_lock)) {
-		err = -EINTR;
+	err = efivar_lock();
+	if (err)
 		goto free;
-	}
 
 	/*
 	 * Per EFI spec, the maximum storage allocated for both
@@ -439,9 +432,9 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
 	do {
 		variable_name_size = 1024;
 
-		status = ops->get_next_variable(&variable_name_size,
-						variable_name,
-						&vendor_guid);
+		status = efivar_get_next_variable(&variable_name_size,
+						  variable_name,
+						  &vendor_guid);
 		switch (status) {
 		case EFI_SUCCESS:
 			variable_name_size = var_name_strnsize(variable_name,
@@ -483,7 +476,7 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
 
 	} while (status != EFI_NOT_FOUND);
 
-	up(&efivars_lock);
+	efivar_unlock();
 free:
 	kfree(variable_name);
 
@@ -500,10 +493,13 @@ EXPORT_SYMBOL_GPL(efivar_init);
  */
 int efivar_entry_add(struct efivar_entry *entry, struct list_head *head)
 {
-	if (down_interruptible(&efivars_lock))
-		return -EINTR;
+	int err;
+
+	err = efivar_lock();
+	if (err)
+		return err;
 	list_add(&entry->list, head);
-	up(&efivars_lock);
+	efivar_unlock();
 
 	return 0;
 }
@@ -544,7 +540,7 @@ EXPORT_SYMBOL_GPL(efivar_entry_remove);
 static void efivar_entry_list_del_unlock(struct efivar_entry *entry)
 {
 	list_del(&entry->list);
-	up(&efivars_lock);
+	efivar_unlock();
 }
 
 /**
@@ -560,22 +556,18 @@ static void efivar_entry_list_del_unlock(struct efivar_entry *entry)
  */
 int efivar_entry_delete(struct efivar_entry *entry)
 {
-	const struct efivar_operations *ops;
 	efi_status_t status;
+	int err;
 
-	if (down_interruptible(&efivars_lock))
-		return -EINTR;
+	err = efivar_lock();
+	if (err)
+		return err;
 
-	if (!__efivars) {
-		up(&efivars_lock);
-		return -EINVAL;
-	}
-	ops = __efivars->ops;
-	status = ops->set_variable(entry->var.VariableName,
-				   &entry->var.VendorGuid,
-				   0, 0, NULL);
+	status = efivar_set_variable_locked(entry->var.VariableName,
+					    &entry->var.VendorGuid,
+					    0, 0, NULL, false);
 	if (!(status == EFI_SUCCESS || status == EFI_NOT_FOUND)) {
-		up(&efivars_lock);
+		efivar_unlock();
 		return efi_status_to_err(status);
 	}
 
@@ -591,21 +583,18 @@ EXPORT_SYMBOL_GPL(efivar_entry_delete);
  */
 int efivar_entry_size(struct efivar_entry *entry, unsigned long *size)
 {
-	const struct efivar_operations *ops;
 	efi_status_t status;
+	int err;
 
 	*size = 0;
 
-	if (down_interruptible(&efivars_lock))
-		return -EINTR;
-	if (!__efivars) {
-		up(&efivars_lock);
-		return -EINVAL;
-	}
-	ops = __efivars->ops;
-	status = ops->get_variable(entry->var.VariableName,
-				   &entry->var.VendorGuid, NULL, size, NULL);
-	up(&efivars_lock);
+	err = efivar_lock();
+	if (err)
+		return err;
+
+	status = efivar_get_variable(entry->var.VariableName,
+				     &entry->var.VendorGuid, NULL, size, NULL);
+	efivar_unlock();
 
 	if (status != EFI_BUFFER_TOO_SMALL)
 		return efi_status_to_err(status);
@@ -621,21 +610,16 @@ EXPORT_SYMBOL_GPL(efivar_entry_size);
  * @size: size of @data buffer
  * @data: buffer to store variable data
  *
- * The caller MUST call efivar_entry_iter_begin() and
- * efivar_entry_iter_end() before and after the invocation of this
- * function, respectively.
+ * The caller MUST hold the efivar lock when calling this function.
  */
 int __efivar_entry_get(struct efivar_entry *entry, u32 *attributes,
 		       unsigned long *size, void *data)
 {
 	efi_status_t status;
 
-	if (!__efivars)
-		return -EINVAL;
-
-	status = __efivars->ops->get_variable(entry->var.VariableName,
-					      &entry->var.VendorGuid,
-					      attributes, size, data);
+	status = efivar_get_variable(entry->var.VariableName,
+				     &entry->var.VendorGuid,
+				     attributes, size, data);
 
 	return efi_status_to_err(status);
 }
@@ -651,22 +635,15 @@ EXPORT_SYMBOL_GPL(__efivar_entry_get);
 int efivar_entry_get(struct efivar_entry *entry, u32 *attributes,
 		     unsigned long *size, void *data)
 {
-	efi_status_t status;
-
-	if (down_interruptible(&efivars_lock))
-		return -EINTR;
-
-	if (!__efivars) {
-		up(&efivars_lock);
-		return -EINVAL;
-	}
+	int err;
 
-	status = __efivars->ops->get_variable(entry->var.VariableName,
-					      &entry->var.VendorGuid,
-					      attributes, size, data);
-	up(&efivars_lock);
+	err = efivar_lock();
+	if (err)
+		return err;
+	err = __efivar_entry_get(entry, attributes, size, data);
+	efivar_unlock();
 
-	return efi_status_to_err(status);
+	return err;
 }
 EXPORT_SYMBOL_GPL(efivar_entry_get);
 
@@ -695,7 +672,6 @@ EXPORT_SYMBOL_GPL(efivar_entry_get);
 int efivar_entry_set_get_size(struct efivar_entry *entry, u32 attributes,
 			      unsigned long *size, void *data, bool *set)
 {
-	const struct efivar_operations *ops;
 	efi_char16_t *name = entry->var.VariableName;
 	efi_guid_t *vendor = &entry->var.VendorGuid;
 	efi_status_t status;
@@ -711,13 +687,9 @@ int efivar_entry_set_get_size(struct efivar_entry *entry, u32 attributes,
 	 * set_variable call, and removal of the variable from the efivars
 	 * list (in the case of an authenticated delete).
 	 */
-	if (down_interruptible(&efivars_lock))
-		return -EINTR;
-
-	if (!__efivars) {
-		err = -EINVAL;
-		goto out;
-	}
+	err = efivar_lock();
+	if (err)
+		return err;
 
 	/*
 	 * Ensure that the available space hasn't shrunk below the safe level
@@ -735,9 +707,8 @@ int efivar_entry_set_get_size(struct efivar_entry *entry, u32 attributes,
 		}
 	}
 
-	ops = __efivars->ops;
-
-	status = ops->set_variable(name, vendor, attributes, *size, data);
+	status = efivar_set_variable_locked(name, vendor, attributes, *size,
+					    data, false);
 	if (status != EFI_SUCCESS) {
 		err = efi_status_to_err(status);
 		goto out;
@@ -752,14 +723,14 @@ int efivar_entry_set_get_size(struct efivar_entry *entry, u32 attributes,
 	 * happened.
 	 */
 	*size = 0;
-	status = ops->get_variable(entry->var.VariableName,
-				   &entry->var.VendorGuid,
-				   NULL, size, NULL);
+	status = efivar_get_variable(entry->var.VariableName,
+				    &entry->var.VendorGuid,
+				    NULL, size, NULL);
 
 	if (status == EFI_NOT_FOUND)
 		efivar_entry_list_del_unlock(entry);
 	else
-		up(&efivars_lock);
+		efivar_unlock();
 
 	if (status && status != EFI_BUFFER_TOO_SMALL)
 		return efi_status_to_err(status);
@@ -767,7 +738,7 @@ int efivar_entry_set_get_size(struct efivar_entry *entry, u32 attributes,
 	return 0;
 
 out:
-	up(&efivars_lock);
+	efivar_unlock();
 	return err;
 
 }
@@ -793,7 +764,7 @@ int efivar_entry_iter(int (*func)(struct efivar_entry *, void *),
 	struct efivar_entry *entry, *n;
 	int err = 0;
 
-	err = down_interruptible(&efivars_lock);
+	err = efivar_lock();
 	if (err)
 		return err;
 
@@ -802,7 +773,7 @@ int efivar_entry_iter(int (*func)(struct efivar_entry *, void *),
 		if (err)
 			break;
 	}
-	up(&efivars_lock);
+	efivar_unlock();
 
 	return err;
 }
-- 
2.35.1

