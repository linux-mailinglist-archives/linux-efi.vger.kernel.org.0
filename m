Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32223551611
	for <lists+linux-efi@lfdr.de>; Mon, 20 Jun 2022 12:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbiFTKlS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 20 Jun 2022 06:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbiFTKlS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 20 Jun 2022 06:41:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53453140AF
        for <linux-efi@vger.kernel.org>; Mon, 20 Jun 2022 03:41:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA0AA61030
        for <linux-efi@vger.kernel.org>; Mon, 20 Jun 2022 10:41:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C26C341C5;
        Mon, 20 Jun 2022 10:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655721676;
        bh=tDICFP23Gkq3KlXOH0+wQJrKRyc2YIv9+dk0fsNTF5g=;
        h=From:To:Cc:Subject:Date:From;
        b=uUzobBeG5siu6p6ra/jl53xtRdbY3ZOSvXypjkRTET/NfjYozomkz57IuucDfEHRL
         gLBVGtCRJKTX2AfAw43DceMLAXVNRmzJnqHLYSKNgstn9FlnSrnYGsJSN3npb3EsLR
         OYGutAORvfcSirHTYhAntZeubsBffJjNhjmrhN+flkUTWFO97B5E0VudxvdwDDdsrm
         UlKq9Ab/LsnMFra4nASSUIn0l1kAcW0xX+sAcYLviKxJMqptUcpZVUPxN7NzysqgWZ
         iiHiyaccTNcWFowJEH+yCPptGMmsmO6Br7NQiPT5aiiV9IBqtrABePxurfmRV2zzAX
         9+cqS4KBu12ZA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] efi: efibc: avoid efivar API for setting variables
Date:   Mon, 20 Jun 2022 12:41:09 +0200
Message-Id: <20220620104110.1684255-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4194; h=from:subject; bh=tDICFP23Gkq3KlXOH0+wQJrKRyc2YIv9+dk0fsNTF5g=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBisE7F2EmCa2o7VqQ8Ch3s6LlmONCjhMPLUM+Gz7ZI qFWsfrWJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYrBOxQAKCRDDTyI5ktmPJFmVC/ 9H3pt+/TD97jbZJzTZYUjkZcrohSUWSn5i4DETdYcL6Qvmye7cJ8jflnrIYXzBDUdRvVhn+C7Sb21h Btqqu7wU9dQohhnJP33dYddEoHViyJdlqr+ZmhFFpH76RFTu0+lqtEPzF4qO1X0wdsg6Cus3ADcDHY 7gofxbfxaShupMcrdleHHGt0n4PUcjRF6VI/LYo/+qtKUlH6Lxi8TLIPpGNiVmSYl6EJsmohh/RsuH UyTiQcIDUYi70o+ugTvfrOCXgGJJ4WIVhszLWdUPZkrCwv7mZ3ULLFUwstMhdHZXjPFLIaKy4wzU9a Kx2YSGE3GM1hdvpbJxAwbpVXBNvSKmU2SN3gkwDjfE+yoo2aH8g9LWpVCv0TEd/fx9ZrgtGoQVyCCY b8UmOX23C+3wwrqzERzjsy+CaUNe0v+16KZHEdbFZlgp0/93fM6TR5UVtqtHbwEJxlep079Qv/hJO/ m1hhFDrd0/D5fDJeKc2ZWaqvNWWopReyadeaCDW1+dNcA=
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

Avoid abusing the efivar API by passing locally instantiated
efivar_entry structs into efivar_set_entry_safe(), rather than using the
API as intended. Instead, just call efi.set_variable() directly.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/Kconfig |  1 +
 drivers/firmware/efi/efibc.c | 76 ++++++++++++++----------------------
 2 files changed, 30 insertions(+), 47 deletions(-)

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 7aa4717cdcac..6fd4414c4836 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -145,6 +145,7 @@ config EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER
 
 config EFI_BOOTLOADER_CONTROL
 	tristate "EFI Bootloader Control"
+	select UCS2_STRING
 	default n
 	help
 	  This module installs a reboot hook, such that if reboot() is
diff --git a/drivers/firmware/efi/efibc.c b/drivers/firmware/efi/efibc.c
index 15a47539dc56..8ced7af8e56d 100644
--- a/drivers/firmware/efi/efibc.c
+++ b/drivers/firmware/efi/efibc.c
@@ -10,69 +10,51 @@
 #include <linux/module.h>
 #include <linux/reboot.h>
 #include <linux/slab.h>
+#include <linux/ucs2_string.h>
 
-static void efibc_str_to_str16(const char *str, efi_char16_t *str16)
-{
-	size_t i;
-
-	for (i = 0; i < strlen(str); i++)
-		str16[i] = str[i];
-
-	str16[i] = '\0';
-}
+#define MAX_DATA_LEN	512
 
-static int efibc_set_variable(const char *name, const char *value)
+static int efibc_set_variable(efi_char16_t *name, efi_char16_t *value,
+			      unsigned long len)
 {
-	int ret;
-	efi_guid_t guid = LINUX_EFI_LOADER_ENTRY_GUID;
-	struct efivar_entry *entry;
-	size_t size = (strlen(value) + 1) * sizeof(efi_char16_t);
+	efi_status_t status;
 
-	if (size > sizeof(entry->var.Data)) {
-		pr_err("value is too large (%zu bytes) for '%s' EFI variable\n", size, name);
-		return -EINVAL;
-	}
+	status = efi.set_variable(name, &LINUX_EFI_LOADER_ENTRY_GUID,
+				  EFI_VARIABLE_NON_VOLATILE
+				  | EFI_VARIABLE_BOOTSERVICE_ACCESS
+				  | EFI_VARIABLE_RUNTIME_ACCESS,
+				  len * sizeof(efi_char16_t), value);
 
-	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
-	if (!entry) {
-		pr_err("failed to allocate efivar entry for '%s' EFI variable\n", name);
-		return -ENOMEM;
+	if (status != EFI_SUCCESS) {
+		pr_err("failed to set EFI variable: 0x%lx\n", status);
+		return -EIO;
 	}
-
-	efibc_str_to_str16(name, entry->var.VariableName);
-	efibc_str_to_str16(value, (efi_char16_t *)entry->var.Data);
-	memcpy(&entry->var.VendorGuid, &guid, sizeof(guid));
-
-	ret = efivar_entry_set_safe(entry->var.VariableName,
-				    entry->var.VendorGuid,
-				    EFI_VARIABLE_NON_VOLATILE
-				    | EFI_VARIABLE_BOOTSERVICE_ACCESS
-				    | EFI_VARIABLE_RUNTIME_ACCESS,
-				    false, size, entry->var.Data);
-
-	if (ret)
-		pr_err("failed to set %s EFI variable: 0x%x\n",
-		       name, ret);
-
-	kfree(entry);
-	return ret;
+	return 0;
 }
 
 static int efibc_reboot_notifier_call(struct notifier_block *notifier,
 				      unsigned long event, void *data)
 {
-	const char *reason = "shutdown";
+	efi_char16_t *reason = event == SYS_RESTART ? L"reboot"
+						    : L"shutdown";
+	const u8 *str = data;
+	efi_char16_t *wdata;
+	unsigned long l;
 	int ret;
 
-	if (event == SYS_RESTART)
-		reason = "reboot";
-
-	ret = efibc_set_variable("LoaderEntryRebootReason", reason);
+	ret = efibc_set_variable(L"LoaderEntryRebootReason", reason,
+				 ucs2_strlen(reason));
 	if (ret || !data)
 		return NOTIFY_DONE;
 
-	efibc_set_variable("LoaderEntryOneShot", (char *)data);
+	wdata = kmalloc(MAX_DATA_LEN * sizeof(efi_char16_t), GFP_KERNEL);
+	for (l = 0; l < MAX_DATA_LEN - 1 && str[l] != '\0'; l++)
+		wdata[l] = str[l];
+	wdata[l] = L'\0';
+
+	efibc_set_variable(L"LoaderEntryOneShot", wdata, l);
 
+	kfree(wdata);
 	return NOTIFY_DONE;
 }
 
@@ -84,7 +66,7 @@ static int __init efibc_init(void)
 {
 	int ret;
 
-	if (!efivars_kobject() || !efivar_supports_writes())
+	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_SET_VARIABLE))
 		return -ENODEV;
 
 	ret = register_reboot_notifier(&efibc_reboot_notifier);
-- 
2.35.1

