Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5AF605263
	for <lists+linux-efi@lfdr.de>; Wed, 19 Oct 2022 23:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJSV6S (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Oct 2022 17:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJSV6R (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Oct 2022 17:58:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B850183E25
        for <linux-efi@vger.kernel.org>; Wed, 19 Oct 2022 14:58:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2203B81BFB
        for <linux-efi@vger.kernel.org>; Wed, 19 Oct 2022 21:58:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC9AC433D6;
        Wed, 19 Oct 2022 21:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666216692;
        bh=LoqhsCc9OhmILHVevl9+p0fF2HwjzOCxVmUWY26+EE4=;
        h=From:To:Cc:Subject:Date:From;
        b=Hhi9mc8uwfL90OZxcJ3+Ph2H3pVBHyqnlYlDhPzUWATQD6AO5A2SwNKQclz2OrYl9
         BpENQLIdeQ02NCbaekvvQwpZ4hS+Rf4ilS0BAtVX6PhNvLFkNhcOSv73t/vn8Voa2a
         7v2o4zCAhQ9N5EkuHCJDQ6DZknhFmlL2Nf3yaQo/giivWP7H7SAdsD1RuRsAUbYUV8
         usbJbb9zkW4FakG/jf85SW8kqEPL642Y38pPeLH33E2tdfYvvUdZohNcVryotGFbby
         E2nWsHvHpQur37lf9YiLv4CQhuLd57j9IhGrxT39Nt5bsXo1RO7aGUqrpfWTUMW7Rm
         r6TfwyeYKWhtA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] efi: efivars: Fix variable writes without query_variable_store()
Date:   Wed, 19 Oct 2022 23:58:04 +0200
Message-Id: <20221019215804.1405063-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3773; i=ardb@kernel.org; h=from:subject; bh=LoqhsCc9OhmILHVevl9+p0fF2HwjzOCxVmUWY26+EE4=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjUHLrmC1w/s12uZmtThBeaWBYW/13KI/YtkB/oAPS EJXyHMeJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY1By6wAKCRDDTyI5ktmPJJ3qDA CWAGLoUD2O0OVgTEG7liEwoXJo635sGhQ0vV3ETqVFsf5WWolcFu/nxJyCyUpeFYWnm4y/dShe34fe UaOtNidVv66iZKgnTTO0MawRNj6Ln5/ek8O07eGdw3K/x+YFeWf9slu64IQoMTCdJ1Z5B/xCp2FBxD YbVFvDnBG8zpvDokaPjbv3ZpqUryhJKsHuMKUdV4QxTG+18wIA8WtQVao56/LCsxzZ0eMR1Weg1roN xZwpWEKQub4kVcRLW1AS4XtlEI/U2SzPoRKtf4pQFiZSwzDKiHe0buIUwdXmbOSj/CbUhsOy4jj8W0 4EsX1ckb4TZjTBVmHN6fnuRlVj9EVRc4rz1foOYoSybb6hU6G+ID97jjk9A2WR9QtlrPC8jUj4yFr6 wjF6SguIKFWpxXFD5q18xDurmiGxliRyS1FielD3RHcFtARu5WbnJgk0Y7XNzz5cixkGsvlaffq1oh TLq/FMHsNlvrTTHk+jA71keLnCncE5NwLRfQS1p8hPVB8=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit bbc6d2c6ef22 ("efi: vars: Switch to new wrapper layer")
refactored the efivars layer so that the 'business logic' related to
which UEFI variables affect the boot flow in which way could be moved
out of it, and into the efivarfs driver.

This inadvertently broke setting variables on firmware implementations
that lack the QueryVariableInfo() boot service, because we no longer
tolerate a EFI_UNSUPPORTED result from check_var_size() when calling
efivar_entry_set_get_size(), which now ends up calling check_var_size()
twice inadvertently.

If QueryVariableInfo() is missing, we support writes of up to 64k -
let's move that logic into check_var_size(), and drop the redundant
call.

Fixes: bbc6d2c6ef22 ("efi: vars: Switch to new wrapper layer")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/vars.c |  9 ++++-----
 fs/efivarfs/vars.c          | 16 ----------------
 include/linux/efi.h         |  3 ---
 3 files changed, 4 insertions(+), 24 deletions(-)

diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index dd74d2ad3184..5a022f3ee00d 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -20,19 +20,19 @@ static struct efivars *__efivars;
 
 static DEFINE_SEMAPHORE(efivars_lock);
 
-efi_status_t check_var_size(u32 attributes, unsigned long size)
+static efi_status_t check_var_size(u32 attributes, unsigned long size)
 {
 	const struct efivar_operations *fops;
 
 	fops = __efivars->ops;
 
 	if (!fops->query_variable_store)
-		return EFI_UNSUPPORTED;
+		return (size <= SZ_64K) ? EFI_SUCCESS : EFI_OUT_OF_RESOURCES;
 
 	return fops->query_variable_store(attributes, size, false);
 }
-EXPORT_SYMBOL_NS_GPL(check_var_size, EFIVAR);
 
+static
 efi_status_t check_var_size_nonblocking(u32 attributes, unsigned long size)
 {
 	const struct efivar_operations *fops;
@@ -40,11 +40,10 @@ efi_status_t check_var_size_nonblocking(u32 attributes, unsigned long size)
 	fops = __efivars->ops;
 
 	if (!fops->query_variable_store)
-		return EFI_UNSUPPORTED;
+		return (size <= SZ_64K) ? EFI_SUCCESS : EFI_OUT_OF_RESOURCES;
 
 	return fops->query_variable_store(attributes, size, true);
 }
-EXPORT_SYMBOL_NS_GPL(check_var_size_nonblocking, EFIVAR);
 
 /**
  * efivars_kobject - get the kobject for the registered efivars
diff --git a/fs/efivarfs/vars.c b/fs/efivarfs/vars.c
index a0ef63cfcecb..9e4f47808bd5 100644
--- a/fs/efivarfs/vars.c
+++ b/fs/efivarfs/vars.c
@@ -651,22 +651,6 @@ int efivar_entry_set_get_size(struct efivar_entry *entry, u32 attributes,
 	if (err)
 		return err;
 
-	/*
-	 * Ensure that the available space hasn't shrunk below the safe level
-	 */
-	status = check_var_size(attributes, *size + ucs2_strsize(name, 1024));
-	if (status != EFI_SUCCESS) {
-		if (status != EFI_UNSUPPORTED) {
-			err = efi_status_to_err(status);
-			goto out;
-		}
-
-		if (*size > 65536) {
-			err = -ENOSPC;
-			goto out;
-		}
-	}
-
 	status = efivar_set_variable_locked(name, vendor, attributes, *size,
 					    data, false);
 	if (status != EFI_SUCCESS) {
diff --git a/include/linux/efi.h b/include/linux/efi.h
index da3974bf05d3..80f3c1c7827d 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1085,9 +1085,6 @@ efi_status_t efivar_set_variable_locked(efi_char16_t *name, efi_guid_t *vendor,
 efi_status_t efivar_set_variable(efi_char16_t *name, efi_guid_t *vendor,
 				 u32 attr, unsigned long data_size, void *data);
 
-efi_status_t check_var_size(u32 attributes, unsigned long size);
-efi_status_t check_var_size_nonblocking(u32 attributes, unsigned long size);
-
 #if IS_ENABLED(CONFIG_EFI_CAPSULE_LOADER)
 extern bool efi_capsule_pending(int *reset_type);
 
-- 
2.35.1

