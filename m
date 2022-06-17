Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3DF54FC6B
	for <lists+linux-efi@lfdr.de>; Fri, 17 Jun 2022 19:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383385AbiFQRtF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 17 Jun 2022 13:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383377AbiFQRtE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 17 Jun 2022 13:49:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22AB37BDD;
        Fri, 17 Jun 2022 10:49:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6854561F13;
        Fri, 17 Jun 2022 17:49:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF4AC341C4;
        Fri, 17 Jun 2022 17:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655488142;
        bh=vB9funzmggAWF3D29wN3gul0eRo6BzB1rO5s3sDxiwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K8MHf2Pztn/G+ugOOXD0xdtW5p+wCkH4hsdA8TzmeqKaErN7YTrKL7E7HCm5AzIeW
         Ercav7fpV/mGurdCAi24P51geoD5jc5bxejOJpJh34dqNFt5q4iIjW6ex9ldiK9IX2
         PT2NiK97FL0ftHLlGYhDuC+4La/OWzFvqrhVxOXm2GoC7bFK7f0HKn9DkuE2vPUnkV
         XcOOURduIGaIC8fLK4d6eJ1tUVRHTIaS2MldwBqvu9Qk6sbM7h7/0XyblsFkz7spaz
         +H22gZkaFr55x6CQGBWPK0JDwP/H9orN+GOvzHuwQ/7TcK1maGpCA+5tdgmRwJBeF+
         uqWT+Rt8CTYsQ==
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
Subject: [PATCH 1/4] efi: avoid efivars layer when loading SSDTs from variables
Date:   Fri, 17 Jun 2022 19:48:48 +0200
Message-Id: <20220617174851.1286026-2-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220617174851.1286026-1-ardb@kernel.org>
References: <20220617174851.1286026-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4607; h=from:subject; bh=vB9funzmggAWF3D29wN3gul0eRo6BzB1rO5s3sDxiwQ=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBirL59ydHqdCFHnG8sTxlNiWD1NOclxPn6HAfHL9yj oKaxUT+JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYqy+fQAKCRDDTyI5ktmPJAqIDA Ck85s5ka8nJ+CHx8H//IOQKEY1pd+Kl3wznMUE4UWWXV94YDIDaBeUWm0zXVPCBZk4liZIZ6nfGicn 4Elvw3BpdX2/nFPlqBKQgddDN3eau4tLbK11MmDZPSwKYVEygOipuU3kJfUUB/1wobKfVgNsAnkgqv lc7wu+l0Ajd5nSK6T8mk8bQ2+9NLn2E0rqpU6rmUNINU6rIekzfxM5ncI+Q7yltsDm0fnqGYkiMDfh KMNmNFo+th/unUn9LamOt6N5Wb9GHwj5NZ8cAiDKDEbQpufyq6f+nePIAKgvc15I8s4R+qote0icw4 NOTaGRbIWPmCvfJpBJzDVuWwBkBKelC218BkKkmhUpNVAn+gWtjd5kqLSIYOHuDKS9uExBY5n5hkV+ 9pS7IyhAi574GXxaKEgjZmVRfpW1Z6IA3NNcPkaHX1NSf3I1BBI5A9JfR6b96kgXa0AsOxHEgQC85u efbHb/+i1+GYAHn/yYjbx9n9KxBb7rp+e4afkFHW9PGoA=
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

The efivars intermediate variable access layer provides an abstraction
that permits the EFI variable store to be replaced by something else
that implements a compatible interface, and caches all variables in the
variable store for fast access via the efivarfs pseudo-filesystem.

The SSDT override feature does not take advantage of either feature, as
it is only used when the generic EFI implementation of efivars is used,
and it traverses all variables only once to find the ones it is
interested in, and frees all data structures that the efivars layer
keeps right after.

So in this case, let's just call EFI's code directly, using the function
pointers in struct efi.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi.c | 103 ++++++++------------
 1 file changed, 41 insertions(+), 62 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 860534bcfdac..630c18618f6a 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -202,7 +202,7 @@ static void generic_ops_unregister(void)
 }
 
 #ifdef CONFIG_EFI_CUSTOM_SSDT_OVERLAYS
-#define EFIVAR_SSDT_NAME_MAX	16
+#define EFIVAR_SSDT_NAME_MAX	16UL
 static char efivar_ssdt[EFIVAR_SSDT_NAME_MAX] __initdata;
 static int __init efivar_ssdt_setup(char *str)
 {
@@ -219,83 +219,62 @@ static int __init efivar_ssdt_setup(char *str)
 }
 __setup("efivar_ssdt=", efivar_ssdt_setup);
 
-static __init int efivar_ssdt_iter(efi_char16_t *name, efi_guid_t vendor,
-				   unsigned long name_size, void *data)
-{
-	struct efivar_entry *entry;
-	struct list_head *list = data;
-	char utf8_name[EFIVAR_SSDT_NAME_MAX];
-	int limit = min_t(unsigned long, EFIVAR_SSDT_NAME_MAX, name_size);
-
-	ucs2_as_utf8(utf8_name, name, limit - 1);
-	if (strncmp(utf8_name, efivar_ssdt, limit) != 0)
-		return 0;
-
-	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
-	if (!entry)
-		return 0;
-
-	memcpy(entry->var.VariableName, name, name_size);
-	memcpy(&entry->var.VendorGuid, &vendor, sizeof(efi_guid_t));
-
-	efivar_entry_add(entry, list);
-
-	return 0;
-}
-
 static __init int efivar_ssdt_load(void)
 {
-	LIST_HEAD(entries);
-	struct efivar_entry *entry, *aux;
-	unsigned long size;
-	void *data;
-	int ret;
+	unsigned long name_size = 256;
+	efi_char16_t *name = NULL;
+	efi_status_t status;
+	efi_guid_t guid;
 
 	if (!efivar_ssdt[0])
 		return 0;
 
-	ret = efivar_init(efivar_ssdt_iter, &entries, true, &entries);
-
-	list_for_each_entry_safe(entry, aux, &entries, list) {
-		pr_info("loading SSDT from variable %s-%pUl\n", efivar_ssdt,
-			&entry->var.VendorGuid);
+	name = kzalloc(name_size, GFP_KERNEL);
+	if (!name)
+		return -ENOMEM;
 
-		list_del(&entry->list);
+	for (;;) {
+		char utf8_name[EFIVAR_SSDT_NAME_MAX];
+		unsigned long data_size = 0;
+		void *data;
+		int limit;
 
-		ret = efivar_entry_size(entry, &size);
-		if (ret) {
-			pr_err("failed to get var size\n");
-			goto free_entry;
+		status = efi.get_next_variable(&name_size, name, &guid);
+		if (status == EFI_NOT_FOUND) {
+			break;
+		} else if (status == EFI_BUFFER_TOO_SMALL) {
+			name = krealloc(name, name_size, GFP_KERNEL);
+			if (!name)
+				return -ENOMEM;
+			continue;
 		}
 
-		data = kmalloc(size, GFP_KERNEL);
-		if (!data) {
-			ret = -ENOMEM;
-			goto free_entry;
-		}
+		limit = min(EFIVAR_SSDT_NAME_MAX, name_size);
+		ucs2_as_utf8(utf8_name, name, limit - 1);
+		if (strncmp(utf8_name, efivar_ssdt, limit) != 0)
+			continue;
 
-		ret = efivar_entry_get(entry, NULL, &size, data);
-		if (ret) {
-			pr_err("failed to get var data\n");
-			goto free_data;
-		}
+		pr_info("loading SSDT from variable %s-%pUl\n", efivar_ssdt, &guid);
 
-		ret = acpi_load_table(data, NULL);
-		if (ret) {
-			pr_err("failed to load table: %d\n", ret);
-			goto free_data;
-		}
+		status = efi.get_variable(name, &guid, NULL, &data_size, NULL);
+		if (status != EFI_BUFFER_TOO_SMALL || !data_size)
+			return -EIO;
 
-		goto free_entry;
+		data = kmalloc(data_size, GFP_KERNEL);
+		if (!data)
+			return -ENOMEM;
 
-free_data:
+		status = efi.get_variable(name, &guid, NULL, &data_size, data);
+		if (status == EFI_SUCCESS) {
+			acpi_status ret = acpi_load_table(data, NULL);
+			if (ret)
+				pr_err("failed to load table: %u\n", ret);
+		} else {
+			pr_err("failed to get var data: 0x%lx\n", status);
+		}
 		kfree(data);
-
-free_entry:
-		kfree(entry);
 	}
-
-	return ret;
+	return 0;
 }
 #else
 static inline int efivar_ssdt_load(void) { return 0; }
-- 
2.35.1

