Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0ED54FC72
	for <lists+linux-efi@lfdr.de>; Fri, 17 Jun 2022 19:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383410AbiFQRtO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 17 Jun 2022 13:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383415AbiFQRtO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 17 Jun 2022 13:49:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A633349911;
        Fri, 17 Jun 2022 10:49:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A23AB82B6F;
        Fri, 17 Jun 2022 17:49:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B1FC341C5;
        Fri, 17 Jun 2022 17:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655488150;
        bh=NRpFD5sKUmNhRBtQPM8OHv18DB2Va4KJOWSCP+G+UoU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lZFGFIjGM9IV0ipc2R8etW1SK4ceOXPtF+rEvv3O120BT+8uG9zGltMGcQo5aUIa9
         jXCTbxwzftO1JobT6jd1yc4SSBB05VUhdKnH9pubO+YDFsmOZmppZLHCPUMFWlGrCw
         N+D9X2W+erMGk/i+m/2eAC8xEHO9YXx2yT1bEnO8zerzZAKjca5GtKCi8nWPVHg0C3
         QrThjUgpX+W0a6hBPrd9Z4/GAyahqEZEBYcwQyoNagNg3cJ+y4G4pIo2L+zJKlkKFg
         H+4t2USeMX3m1SKTwnshTFjA7zR/jiXlapk/yy1hdExS8nOerg/wtRZ1cbW40JKFOG
         d98+SY8wcb4xw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     keescook@chromium.org, Ard Biesheuvel <ardb@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        linux-input@vger.kernel.org, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com
Subject: [PATCH 3/4] iwlwifi: Switch to proper EFI variable store interface
Date:   Fri, 17 Jun 2022 19:48:50 +0200
Message-Id: <20220617174851.1286026-4-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220617174851.1286026-1-ardb@kernel.org>
References: <20220617174851.1286026-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6127; h=from:subject; bh=NRpFD5sKUmNhRBtQPM8OHv18DB2Va4KJOWSCP+G+UoU=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBirL6A9hCvWi6TSw7XCEuKPlWcRrWPHbmibsDstdOk tFUHZ4eJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYqy+gAAKCRDDTyI5ktmPJJS2DA CxEx44N/mbhZHFq32AhUF7uUgKurPuqChuo90Ofa8DGxcEUS7ut12FdB8v21xlGs/rwTmzzIFW5RCC AQ2oc1OcpN0KZFsh7M6ev6eBC0bkb5ohKBFaTnj9x6OJw39EZaDrQ9X4ybH/+ID6xb1L2OZ46/8KcI PfGd9cGFSbMX9bVoCY6IQuXbaOQh17zCeJnIjkNYwUrVg52yzTTVF1XXIFgYePR+J+aaAjCHL18p8T 9ClNbrhYJBY4BBN7kwtkwzdEpRPHOC1w8bN9IYYqkoQYwQOm7ewWmSQGkNufHsNsjbLMvOSXxX/pse ak6jp92Maqyk0TrWtW4neos3EXE2kWewrEtf2P3OeyGYVjWr7TodYlg+Ymg+BLxKt4Yd0LMBtdDvvR AeIkomMxVq4dgZf3uwDTaYz0H2o9dUDZNq+wwcucEgJNntIAElix4mqI80gpOJoRpqb7MaXY/Vy9yQ qRYItbQZNAXuU2eNCMYK5SjoWISXL8aOKAogICiQTeNVI=
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

Using half of the efivar API with locally baked efivar_entry instances
is not the right way to use this API, and these uses impede planned work
on the efivar layer itself.

So switch to direct EFI variable store accesses: we don't need the
efivar layer anyway.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c | 96 +++++++-------------
 1 file changed, 32 insertions(+), 64 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index 23b1d689ba7b..9854466c21d9 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -19,20 +19,14 @@
 
 void *iwl_uefi_get_pnvm(struct iwl_trans *trans, size_t *len)
 {
-	struct efivar_entry *pnvm_efivar;
 	void *data;
 	unsigned long package_size;
-	int err;
+	efi_status_t status;
 
 	*len = 0;
 
-	pnvm_efivar = kzalloc(sizeof(*pnvm_efivar), GFP_KERNEL);
-	if (!pnvm_efivar)
-		return ERR_PTR(-ENOMEM);
-
-	memcpy(&pnvm_efivar->var.VariableName, IWL_UEFI_OEM_PNVM_NAME,
-	       sizeof(IWL_UEFI_OEM_PNVM_NAME));
-	pnvm_efivar->var.VendorGuid = IWL_EFI_VAR_GUID;
+	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
+		return ERR_PTR(-ENODEV);
 
 	/*
 	 * TODO: we hardcode a maximum length here, because reading
@@ -42,27 +36,22 @@ void *iwl_uefi_get_pnvm(struct iwl_trans *trans, size_t *len)
 	package_size = IWL_HARDCODED_PNVM_SIZE;
 
 	data = kmalloc(package_size, GFP_KERNEL);
-	if (!data) {
-		data = ERR_PTR(-ENOMEM);
-		goto out;
-	}
+	if (!data)
+		return ERR_PTR(-ENOMEM);
 
-	err = efivar_entry_get(pnvm_efivar, NULL, &package_size, data);
-	if (err) {
+	status = efi.get_variable(IWL_UEFI_OEM_PNVM_NAME, &IWL_EFI_VAR_GUID,
+				  NULL, &package_size, data);
+	if (status != EFI_SUCCESS) {
 		IWL_DEBUG_FW(trans,
-			     "PNVM UEFI variable not found %d (len %lu)\n",
-			     err, package_size);
+			     "PNVM UEFI variable not found 0x%lx (len %lu)\n",
+			     status, package_size);
 		kfree(data);
-		data = ERR_PTR(err);
-		goto out;
+		return ERR_PTR(efi_status_to_err(status));
 	}
 
 	IWL_DEBUG_FW(trans, "Read PNVM from UEFI with size %lu\n", package_size);
 	*len = package_size;
 
-out:
-	kfree(pnvm_efivar);
-
 	return data;
 }
 
@@ -211,21 +200,15 @@ static void *iwl_uefi_reduce_power_parse(struct iwl_trans *trans,
 
 void *iwl_uefi_get_reduced_power(struct iwl_trans *trans, size_t *len)
 {
-	struct efivar_entry *reduce_power_efivar;
 	struct pnvm_sku_package *package;
 	void *data = NULL;
 	unsigned long package_size;
-	int err;
+	efi_status_t status;
 
 	*len = 0;
 
-	reduce_power_efivar = kzalloc(sizeof(*reduce_power_efivar), GFP_KERNEL);
-	if (!reduce_power_efivar)
-		return ERR_PTR(-ENOMEM);
-
-	memcpy(&reduce_power_efivar->var.VariableName, IWL_UEFI_REDUCED_POWER_NAME,
-	       sizeof(IWL_UEFI_REDUCED_POWER_NAME));
-	reduce_power_efivar->var.VendorGuid = IWL_EFI_VAR_GUID;
+	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
+		return ERR_PTR(-ENODEV);
 
 	/*
 	 * TODO: we hardcode a maximum length here, because reading
@@ -235,19 +218,17 @@ void *iwl_uefi_get_reduced_power(struct iwl_trans *trans, size_t *len)
 	package_size = IWL_HARDCODED_REDUCE_POWER_SIZE;
 
 	package = kmalloc(package_size, GFP_KERNEL);
-	if (!package) {
-		package = ERR_PTR(-ENOMEM);
-		goto out;
-	}
+	if (!package)
+		return ERR_PTR(-ENOMEM);
 
-	err = efivar_entry_get(reduce_power_efivar, NULL, &package_size, package);
-	if (err) {
+	status = efi.get_variable(IWL_UEFI_REDUCED_POWER_NAME, &IWL_EFI_VAR_GUID,
+				  NULL, &package_size, data);
+	if (status != EFI_SUCCESS) {
 		IWL_DEBUG_FW(trans,
-			     "Reduced Power UEFI variable not found %d (len %lu)\n",
-			     err, package_size);
+			     "Reduced Power UEFI variable not found 0x%lx (len %lu)\n",
+			     status, package_size);
 		kfree(package);
-		data = ERR_PTR(err);
-		goto out;
+		return ERR_PTR(efi_status_to_err(status));
 	}
 
 	IWL_DEBUG_FW(trans, "Read reduced power from UEFI with size %lu\n",
@@ -262,9 +243,6 @@ void *iwl_uefi_get_reduced_power(struct iwl_trans *trans, size_t *len)
 
 	kfree(package);
 
-out:
-	kfree(reduce_power_efivar);
-
 	return data;
 }
 
@@ -304,22 +282,15 @@ static int iwl_uefi_sgom_parse(struct uefi_cnv_wlan_sgom_data *sgom_data,
 void iwl_uefi_get_sgom_table(struct iwl_trans *trans,
 			     struct iwl_fw_runtime *fwrt)
 {
-	struct efivar_entry *sgom_efivar;
 	struct uefi_cnv_wlan_sgom_data *data;
 	unsigned long package_size;
-	int err, ret;
-
-	if (!fwrt->geo_enabled)
-		return;
+	efi_status_t status;
+	int ret;
 
-	sgom_efivar = kzalloc(sizeof(*sgom_efivar), GFP_KERNEL);
-	if (!sgom_efivar)
+	if (!fwrt->geo_enabled ||
+	    !efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
 		return;
 
-	memcpy(&sgom_efivar->var.VariableName, IWL_UEFI_SGOM_NAME,
-	       sizeof(IWL_UEFI_SGOM_NAME));
-	sgom_efivar->var.VendorGuid = IWL_EFI_VAR_GUID;
-
 	/* TODO: we hardcode a maximum length here, because reading
 	 * from the UEFI is not working.  To implement this properly,
 	 * we have to call efivar_entry_size().
@@ -327,15 +298,14 @@ void iwl_uefi_get_sgom_table(struct iwl_trans *trans,
 	package_size = IWL_HARDCODED_SGOM_SIZE;
 
 	data = kmalloc(package_size, GFP_KERNEL);
-	if (!data) {
-		data = ERR_PTR(-ENOMEM);
-		goto out;
-	}
+	if (!data)
+		return;
 
-	err = efivar_entry_get(sgom_efivar, NULL, &package_size, data);
-	if (err) {
+	status = efi.get_variable(IWL_UEFI_SGOM_NAME, &IWL_EFI_VAR_GUID,
+				  NULL, &package_size, data);
+	if (status != EFI_SUCCESS) {
 		IWL_DEBUG_FW(trans,
-			     "SGOM UEFI variable not found %d\n", err);
+			     "SGOM UEFI variable not found 0x%lx\n", status);
 		goto out_free;
 	}
 
@@ -349,8 +319,6 @@ void iwl_uefi_get_sgom_table(struct iwl_trans *trans,
 out_free:
 	kfree(data);
 
-out:
-	kfree(sgom_efivar);
 }
 IWL_EXPORT_SYMBOL(iwl_uefi_get_sgom_table);
 #endif /* CONFIG_ACPI */
-- 
2.35.1

