Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E971660F9DC
	for <lists+linux-efi@lfdr.de>; Thu, 27 Oct 2022 15:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbiJ0N6N (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 27 Oct 2022 09:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236211AbiJ0N6H (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 27 Oct 2022 09:58:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A668185436
        for <linux-efi@vger.kernel.org>; Thu, 27 Oct 2022 06:58:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB4D662348
        for <linux-efi@vger.kernel.org>; Thu, 27 Oct 2022 13:58:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A042C433D6;
        Thu, 27 Oct 2022 13:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666879082;
        bh=bgyDxGKBqK6twqf/XveIiXoaP8Q703ADktjJt3W8sR8=;
        h=From:To:Cc:Subject:Date:From;
        b=jC1Nczke9I03901DuioVDXgwc9eKqcOqFSb6heVwrR+EoulkgYJb1515mC5UF5lZL
         TVPJA4vH6bJmYvx+ZA7mgwek9/xKTL7C1aKLq5lR+s11lSl0u2jEMldHtRzk6HYAWt
         sP2KsLwXBzeRaq3ImvsPeTuqDqJE0v/7ncF2vbDDLzR8rRTR8khsn5wA3ClP1pWO2I
         dGU6EddAGsEp3Th3JDdB96ZEL+Bn4WhVD962IDr7Za+xWNTYiN53KYiGl0bz6/RhCP
         LWaD6M0JQd32Hdo4ahrZQGtiNH0sgpdK1FmF0GRhzFEz/mHFCyGkQyveXD/vGsTIJO
         iiU6Ld9ULC+0Q==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     gargaditya08@live.com, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] efi: efivars: Fix variable writes with unsupported query_variable_store()
Date:   Thu, 27 Oct 2022 15:57:55 +0200
Message-Id: <20221027135755.1732339-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4514; i=ardb@kernel.org; h=from:subject; bh=bgyDxGKBqK6twqf/XveIiXoaP8Q703ADktjJt3W8sR8=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjWo5i2bbWebuhs5e0orC02opz310jojxPlorJWJ/j Lt8k3zeJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY1qOYgAKCRDDTyI5ktmPJI8ADA CHbPMQ6M9QLMi7MljvbhVBAp96jB2Rl7Cmd5VHj6TixgTWw9bP1ekxDqd98aSfZXtGQWZvNO+WpGyz rfgeANGWD0vd/eRgT8pMXPvDM94iSWqINo5XzkX95EJ3PQXGEtfgG0lKavEjaW5HMEj8/5GPHNAPhB a7egKZdee3HCuryKv6E/gbvlbKPYl0ChSJgwjoyY6L0TBgScufkXba5DZK6vkaRJSwKgUHr0lCp2K6 RfGNeMp0l7ATXqgJgq7RmURFkTgvGLrFsGbBfstg7oK8KGqOT/4VBLSZZLY+AIj2Zg0BZkUim42LDI 8ghhk34nZLlJ88XKX8g/wmNTWX4GOXBeIzCczMvtul1Rs9ozU7s33MMqAXFVEKtMP3FsWAF8Ee8Rs6 Yg1F22Uej92CA8SAcCs65nOe5kfFgrXHtsbDAEJUolcSqIUU1I0G1xiB25MM6F1gkisZ6+bzsTiTGJ D0OVTg8vIBRS04pFKFq23xUZZs+DDjR1YQrJd1LXV0xvU=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit 8a254d90a775 ("efi: efivars: Fix variable writes without
query_variable_store()") addressed an issue that was introduced during
the EFI variable store refactor, where alternative implementations of
the efivars layer that lacked query_variable_store() would no longer
work.

Unfortunately, there is another case to consider here, which was missed:
if the efivars layer is backed by the EFI runtime services as usual, but
the EFI implementation predates the introduction of QueryVariableInfo(),
we will return EFI_UNSUPPORTED, and this is no longer being dealt with
correctly.

So let's fix this, and while at it, clean up the code a bit, by merging
the check_var_size() routines as well as their callers.

Cc: <stable@vger.kernel.org> # v6.0
Fixes: bbc6d2c6ef22 ("efi: vars: Switch to new wrapper layer")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/vars.c | 68 +++++++++++--------------------------
 1 file changed, 20 insertions(+), 48 deletions(-)

diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index 433b61587139..0ba9f18312f5 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -21,29 +21,22 @@ static struct efivars *__efivars;
 
 static DEFINE_SEMAPHORE(efivars_lock);
 
-static efi_status_t check_var_size(u32 attributes, unsigned long size)
-{
-	const struct efivar_operations *fops;
-
-	fops = __efivars->ops;
-
-	if (!fops->query_variable_store)
-		return (size <= SZ_64K) ? EFI_SUCCESS : EFI_OUT_OF_RESOURCES;
-
-	return fops->query_variable_store(attributes, size, false);
-}
-
-static
-efi_status_t check_var_size_nonblocking(u32 attributes, unsigned long size)
+static efi_status_t check_var_size(bool nonblocking, u32 attributes,
+				   unsigned long size)
 {
 	const struct efivar_operations *fops;
+	efi_status_t status;
 
 	fops = __efivars->ops;
 
 	if (!fops->query_variable_store)
+		status = EFI_UNSUPPORTED;
+	else
+		status = fops->query_variable_store(attributes, size,
+						    nonblocking);
+	if (status == EFI_UNSUPPORTED)
 		return (size <= SZ_64K) ? EFI_SUCCESS : EFI_OUT_OF_RESOURCES;
-
-	return fops->query_variable_store(attributes, size, true);
+	return status;
 }
 
 /**
@@ -195,26 +188,6 @@ efi_status_t efivar_get_next_variable(unsigned long *name_size,
 }
 EXPORT_SYMBOL_NS_GPL(efivar_get_next_variable, EFIVAR);
 
-/*
- * efivar_set_variable_blocking() - local helper function for set_variable
- *
- * Must be called with efivars_lock held.
- */
-static efi_status_t
-efivar_set_variable_blocking(efi_char16_t *name, efi_guid_t *vendor,
-			     u32 attr, unsigned long data_size, void *data)
-{
-	efi_status_t status;
-
-	if (data_size > 0) {
-		status = check_var_size(attr, data_size +
-					      ucs2_strsize(name, 1024));
-		if (status != EFI_SUCCESS)
-			return status;
-	}
-	return __efivars->ops->set_variable(name, vendor, attr, data_size, data);
-}
-
 /*
  * efivar_set_variable_locked() - set a variable identified by name/vendor
  *
@@ -228,23 +201,21 @@ efi_status_t efivar_set_variable_locked(efi_char16_t *name, efi_guid_t *vendor,
 	efi_set_variable_t *setvar;
 	efi_status_t status;
 
-	if (!nonblocking)
-		return efivar_set_variable_blocking(name, vendor, attr,
-						    data_size, data);
+	if (data_size > 0) {
+		status = check_var_size(nonblocking, attr,
+					data_size + ucs2_strsize(name, 1024));
+		if (status != EFI_SUCCESS)
+			return status;
+	}
 
 	/*
 	 * If no _nonblocking variant exists, the ordinary one
 	 * is assumed to be non-blocking.
 	 */
-	setvar = __efivars->ops->set_variable_nonblocking ?:
-		 __efivars->ops->set_variable;
+	setvar = __efivars->ops->set_variable_nonblocking;
+	if (!setvar || !nonblocking)
+		 setvar = __efivars->ops->set_variable;
 
-	if (data_size > 0) {
-		status = check_var_size_nonblocking(attr, data_size +
-							  ucs2_strsize(name, 1024));
-		if (status != EFI_SUCCESS)
-			return status;
-	}
 	return setvar(name, vendor, attr, data_size, data);
 }
 EXPORT_SYMBOL_NS_GPL(efivar_set_variable_locked, EFIVAR);
@@ -264,7 +235,8 @@ efi_status_t efivar_set_variable(efi_char16_t *name, efi_guid_t *vendor,
 	if (efivar_lock())
 		return EFI_ABORTED;
 
-	status = efivar_set_variable_blocking(name, vendor, attr, data_size, data);
+	status = efivar_set_variable_locked(name, vendor, attr, data_size,
+					    data, false);
 	efivar_unlock();
 	return status;
 }
-- 
2.35.1

