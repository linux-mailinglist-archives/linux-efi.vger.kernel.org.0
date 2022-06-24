Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C945595B4
	for <lists+linux-efi@lfdr.de>; Fri, 24 Jun 2022 10:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbiFXIuf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Jun 2022 04:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiFXIuN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 24 Jun 2022 04:50:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9725177FF2;
        Fri, 24 Jun 2022 01:50:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 127A562030;
        Fri, 24 Jun 2022 08:50:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44AFC341CA;
        Fri, 24 Jun 2022 08:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656060601;
        bh=o3ok/9R+UqcUDjiZQfJKpJOqlYP6HeiJwMpgWwGIlHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nn6alImawjd+9QoBcV6m0mxfrARLNgxEcEP0PW40pp0BLPA4Doe7utXXXkztKucId
         ZGYAkbyOISZy/X5DcxTgRi7+CrjgkaOksawR68dBi3T/xQSOPWOX17WR5FZ+v1Ila/
         caVvWy9Qe4HQpL14bP8P5Rktc0zEu6fH3nQdDfVC22nKL2dfTtIqqVwiWyBe5U1M62
         Y2nVFWoZrEh/rg02Rv69U1dXOghzEUJXOEhKIwu2m4s8YnLkl+ldmC4QI8u8PjwaKZ
         kT4NK25uaLp08QzksyI/INM1BH2NKHbxU7dnAw0XjPMK4ehNu2nWYazu7DgZS9w0mr
         YGATjRNyvVebw==
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
Subject: [PATCH v3 8/9] efi: vars: Switch to new wrapper layer
Date:   Fri, 24 Jun 2022 10:49:24 +0200
Message-Id: <20220624084925.724516-9-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220624084925.724516-1-ardb@kernel.org>
References: <20220624084925.724516-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8472; h=from:subject; bh=o3ok/9R+UqcUDjiZQfJKpJOqlYP6HeiJwMpgWwGIlHQ=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBitXqSEnZCPl3tiCtuUYhPnTsiyC/DnppIVmUimcLK bAwkLqOJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYrV6kgAKCRDDTyI5ktmPJAtsDA C0/utxOZ7k76WBwMabtSj8n32SaSB36WgJI8yLE33MLNPDqMhxDqFY52B2co1f9a9l74Gh30kD1SVc 9+HkRHlAG4bCwggxhYVJIQyrQCeRjNIPDOGvFqw/kFnoUSjryNDsa85gl2a9MMqUp1i2GmBvJu4QmQ jAvFCAh0sQ7RuC83/GviLEySvKH8MHyaiO3+rSfuoRay2sEl2hC67NmY4usVsgsNGFzR8Nj9F/Oow+ 8JdXgXAJe4nhu40WgWCZc3wbihM58E7mdgDZ2mI5ccyp2KsY/k86IGHInjOg8Kz7Nnbr5KazAQvzjq MOL/wYShsVOR0l0m0JpxlLD4NN/KbvG3Va3vFc2t0dcs2Y11LWFgDTWwfK5OoPOqsywi3KyUX1QNkA mJOORgZaD23M/mvEOkjIyVhfZAuxwy0P4qY3g4eNrmmLnf/cniZi1Wr3zXHwXl1FG6xkaco6+f18Vs GnLLwhocva2zWH24Rxa6Ejj9xV8osKKCrXmeQJbnlAamQ=
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

