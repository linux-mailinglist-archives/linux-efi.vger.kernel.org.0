Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB7854FC6F
	for <lists+linux-efi@lfdr.de>; Fri, 17 Jun 2022 19:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383408AbiFQRtI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 17 Jun 2022 13:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383268AbiFQRtI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 17 Jun 2022 13:49:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7911737BDD;
        Fri, 17 Jun 2022 10:49:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1543161F14;
        Fri, 17 Jun 2022 17:49:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C91C3411F;
        Fri, 17 Jun 2022 17:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655488146;
        bh=zul0a/iKMQjQIwDgMYDRWuClISYCTC5Pc4a5yv4ykHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A0VMGgeuhHBLJfooIQDy844VH4uFqJVQpIGxqq9MFPSNwX+qm2umf8RhZdFAGRRdf
         4/NwGsxLcBV3gixtJEBly/uMid08ceDVnJxO44eMOYHKxM6ziLclK4zS3Xtow+VcUz
         Qa0Sg91FqgQZQVc9YhOYYFXEQYrBMluxMvldli889/kcQwR1lkr0Q13RLmNVrLEhF0
         uFfTsopNiRx5NT7qsLHR9B54ZjDT1RKsENRrQ7hON0U+FRFI6OSUddAuGc1aOWUZPJ
         zf31spidL1Fi6pQwiIHbEFPlHJokQUCS6gK4GlsIgN7+1R7dxBIzv3dFbI154RDERN
         kqkS25EOfs1hQ==
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
Subject: [PATCH 2/4] Input: applespi - avoid efivars API and invoke EFI services directly
Date:   Fri, 17 Jun 2022 19:48:49 +0200
Message-Id: <20220617174851.1286026-3-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220617174851.1286026-1-ardb@kernel.org>
References: <20220617174851.1286026-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3021; h=from:subject; bh=zul0a/iKMQjQIwDgMYDRWuClISYCTC5Pc4a5yv4ykHc=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBirL5+pmHpuNv9hnsTFaaAjIWZa3K33CmkmpF30fjR CKB86kOJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYqy+fgAKCRDDTyI5ktmPJNAoC/ sGBPLZNCLoyVBeI75qNl3RJjTRKAKU5P3Of9YPT7Ap9YR2LUotFA5/xjAcjF9yBcwtoCIjG1JAw5aZ FzLkINCWJZH5IqLS93l+w46i8DUKGTIR3bX0M0VR2HrVtI9Tp6Cdc6rlYFNhjniVbE4tX3uqBixl6C 67MiqebpyAA+D787FP/3NQ0kjbabMi/IW3y49z6KQTQNLiAXGo7MqG9JSpawInvXB05RaNYa+rAs4/ v9jfeA7LM4abKVH0r3MpSv11aX9uKcgVeqCUyiONyYL8A6HFodhUDWcn0AOo/mabE2+ZqQj/7oNirC 9v6ESqsKkrd+kUAaiXnx/lRJ6qJM53TItqnVGFDHZhOCt38941EnZq91J3IV+2waZIk86fBRP47CRN kUeZKQvErOlBF3jJOY1Zb8quFYqz4kYpAZ1/K0dIeaNG/WAViBD6iELvvzwWwzaPpoPYqR20VySumD WzjBuJ/NVIAy5F+Yc6JdbyPVwQstIwovOslDh1JHkGElI=
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

This driver abuses the efivar API, by using a few of its helpers on
entries that were not instantiated by the API itself. This is a problem
as future cleanup work on efivars is complicated by this.

So let's just switch to the get/set variable runtime wrappers directly.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/input/keyboard/applespi.c | 42 +++++++-------------
 1 file changed, 14 insertions(+), 28 deletions(-)

diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
index d1f5354d5ea2..cbc6c0d4670a 100644
--- a/drivers/input/keyboard/applespi.c
+++ b/drivers/input/keyboard/applespi.c
@@ -1597,52 +1597,38 @@ static u32 applespi_notify(acpi_handle gpe_device, u32 gpe, void *context)
 
 static int applespi_get_saved_bl_level(struct applespi_data *applespi)
 {
-	struct efivar_entry *efivar_entry;
+	efi_status_t sts = EFI_NOT_FOUND;
 	u16 efi_data = 0;
-	unsigned long efi_data_len;
-	int sts;
-
-	efivar_entry = kmalloc(sizeof(*efivar_entry), GFP_KERNEL);
-	if (!efivar_entry)
-		return -ENOMEM;
-
-	memcpy(efivar_entry->var.VariableName, EFI_BL_LEVEL_NAME,
-	       sizeof(EFI_BL_LEVEL_NAME));
-	efivar_entry->var.VendorGuid = EFI_BL_LEVEL_GUID;
-	efi_data_len = sizeof(efi_data);
+	unsigned long efi_data_len = sizeof(efi_data);
 
-	sts = efivar_entry_get(efivar_entry, NULL, &efi_data_len, &efi_data);
-	if (sts && sts != -ENOENT)
+	if (efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
+		sts = efi.get_variable(EFI_BL_LEVEL_NAME, &EFI_BL_LEVEL_GUID,
+				       NULL, &efi_data_len, &efi_data);
+	if (sts != EFI_SUCCESS && sts != EFI_NOT_FOUND)
 		dev_warn(&applespi->spi->dev,
-			 "Error getting backlight level from EFI vars: %d\n",
+			 "Error getting backlight level from EFI vars: 0x%lx\n",
 			 sts);
 
-	kfree(efivar_entry);
-
-	return sts ? sts : efi_data;
+	return sts != EFI_SUCCESS ? -ENODEV : efi_data;
 }
 
 static void applespi_save_bl_level(struct applespi_data *applespi,
 				   unsigned int level)
 {
-	efi_guid_t efi_guid;
+	efi_status_t sts = EFI_UNSUPPORTED;
 	u32 efi_attr;
-	unsigned long efi_data_len;
 	u16 efi_data;
-	int sts;
 
-	/* Save keyboard backlight level */
-	efi_guid = EFI_BL_LEVEL_GUID;
 	efi_data = (u16)level;
-	efi_data_len = sizeof(efi_data);
 	efi_attr = EFI_VARIABLE_NON_VOLATILE | EFI_VARIABLE_BOOTSERVICE_ACCESS |
 		   EFI_VARIABLE_RUNTIME_ACCESS;
 
-	sts = efivar_entry_set_safe((efi_char16_t *)EFI_BL_LEVEL_NAME, efi_guid,
-				    efi_attr, true, efi_data_len, &efi_data);
-	if (sts)
+	if (efi_rt_services_supported(EFI_RT_SUPPORTED_SET_VARIABLE))
+		sts = efi.set_variable(EFI_BL_LEVEL_NAME, &EFI_BL_LEVEL_GUID,
+				       efi_attr, sizeof(efi_data), &efi_data);
+	if (sts != EFI_SUCCESS)
 		dev_warn(&applespi->spi->dev,
-			 "Error saving backlight level to EFI vars: %d\n", sts);
+			 "Error saving backlight level to EFI vars: 0x%lx\n", sts);
 }
 
 static int applespi_probe(struct spi_device *spi)
-- 
2.35.1

