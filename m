Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4604152F400
	for <lists+linux-efi@lfdr.de>; Fri, 20 May 2022 21:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353317AbiETTvb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 May 2022 15:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353318AbiETTva (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 20 May 2022 15:51:30 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84BF5A2E3;
        Fri, 20 May 2022 12:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=i1SabHWBF9yjaawRYqmI4JtnrLJvNYnK3oYqAVGf7Ao=; b=gesr4pHQ0zxgkl4V4UHZOm/9At
        KVQwK8sl9PhTHOAgnypdTxNXRdkr4bWPbUK6Li6GY/6LRRY/OTndzqrYB+wh5lLbyiv5wCVLQIm5P
        fYyOUVReou6EYoVA/0t/qOjs6hxpyWFPQzJ1htTgcxM9t8DHtec9N7KXN03AGiaE51w09F/xGYSJl
        vdlSJkoWe+NXaNOgRtbx77ASGNpf6PugBB5YcKh7/kYy7lCooFnkz/NFBEHxEehRXtMbjbc+CI0Ba
        142I0nIDZEhkGopOp5PAE/n9Yb35rOttg5fc7SE2WE0avYKZjdTqEW72WUd51ielFusXPxF6mesHd
        PcrvrEcQ==;
Received: from 200-161-159-120.dsl.telesp.net.br ([200.161.159.120] helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1ns8ei-00D3mx-Qz; Fri, 20 May 2022 21:51:25 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     ardb@kernel.org, linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, anton@enomsg.org, ccross@android.com,
        keescook@chromium.org, matt@codeblueprint.co.uk,
        matthew.garrett@nebula.com, tony.luck@intel.com,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH 1/2] efi: Add a generic helper to convert strings to unicode
Date:   Fri, 20 May 2022 16:50:27 -0300
Message-Id: <20220520195028.1347426-2-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220520195028.1347426-1-gpiccoli@igalia.com>
References: <20220520195028.1347426-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Currently both efi-pstore and efibc rely in simple for-loops
to convert from regular char pointers to u16/unicode strings;
efibc has even a nice helper to perform such work.

So, let's export this helper to common EFI code to prevent
code duplication (like in efi-pstore); this helper will also
be used in a subsequent patch (adding a new module).

Notice that efi-pstore didn't write the end NULL char in the
unicode string before this patch, but this should not change
anything. No functional change is expected here.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 drivers/firmware/efi/efi-pstore.c |  5 ++---
 drivers/firmware/efi/efibc.c      | 16 ++++------------
 include/linux/efi.h               | 15 +++++++++++++++
 3 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
index 7e771c56c13c..299116ecfb4e 100644
--- a/drivers/firmware/efi/efi-pstore.c
+++ b/drivers/firmware/efi/efi-pstore.c
@@ -249,7 +249,7 @@ static int efi_pstore_write(struct pstore_record *record)
 	char name[DUMP_NAME_LEN];
 	efi_char16_t efi_name[DUMP_NAME_LEN];
 	efi_guid_t vendor = LINUX_EFI_CRASH_GUID;
-	int i, ret = 0;
+	int ret = 0;
 
 	record->id = generic_id(record->time.tv_sec, record->part,
 				record->count);
@@ -262,8 +262,7 @@ static int efi_pstore_write(struct pstore_record *record)
 		 (long long)record->time.tv_sec,
 		 record->compressed ? 'C' : 'D');
 
-	for (i = 0; i < DUMP_NAME_LEN; i++)
-		efi_name[i] = name[i];
+	efi_str8_to_str16(efi_name, name, DUMP_NAME_LEN - 1);
 
 	ret = efivar_entry_set_safe(efi_name, vendor, PSTORE_EFI_ATTRIBUTES,
 			      false, record->size, record->psi->buf);
diff --git a/drivers/firmware/efi/efibc.c b/drivers/firmware/efi/efibc.c
index 15a47539dc56..63fe2bf753cb 100644
--- a/drivers/firmware/efi/efibc.c
+++ b/drivers/firmware/efi/efibc.c
@@ -11,16 +11,6 @@
 #include <linux/reboot.h>
 #include <linux/slab.h>
 
-static void efibc_str_to_str16(const char *str, efi_char16_t *str16)
-{
-	size_t i;
-
-	for (i = 0; i < strlen(str); i++)
-		str16[i] = str[i];
-
-	str16[i] = '\0';
-}
-
 static int efibc_set_variable(const char *name, const char *value)
 {
 	int ret;
@@ -39,8 +29,10 @@ static int efibc_set_variable(const char *name, const char *value)
 		return -ENOMEM;
 	}
 
-	efibc_str_to_str16(name, entry->var.VariableName);
-	efibc_str_to_str16(value, (efi_char16_t *)entry->var.Data);
+	efi_str8_to_str16(entry->var.VariableName, name, strlen(name));
+	efi_str8_to_str16((efi_char16_t *)entry->var.Data, value,
+			  strlen(value));
+
 	memcpy(&entry->var.VendorGuid, &guid, sizeof(guid));
 
 	ret = efivar_entry_set_safe(entry->var.VariableName,
diff --git a/include/linux/efi.h b/include/linux/efi.h
index ccd4d3f91c98..066ebc5bcb2a 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1030,6 +1030,21 @@ efivar_unregister(struct efivar_entry *var)
 	kobject_put(&var->kobj);
 }
 
+/*
+ * Helper that converts regular char buffer to u16 unicode-like strings;
+ * notice that the unicode buffer requires to be at least len+1 in size.
+ */
+static inline void
+efi_str8_to_str16(efi_char16_t *str16, const char *str8, size_t len)
+{
+	size_t i;
+
+	for (i = 0; i < len; i++)
+		str16[i] = str8[i];
+
+	str16[i] = '\0';
+}
+
 int efivars_register(struct efivars *efivars,
 		     const struct efivar_operations *ops,
 		     struct kobject *kobject);
-- 
2.36.0

