Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3AB5855B0
	for <lists+linux-efi@lfdr.de>; Fri, 29 Jul 2022 21:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238895AbiG2Tqz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 29 Jul 2022 15:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238894AbiG2Tqv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 29 Jul 2022 15:46:51 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B32D88747;
        Fri, 29 Jul 2022 12:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=1wgWQHyf41Q4C/D0b3udJRG2sHG+B+p4zwm51LjrGK0=; b=oCPi7V9p9/OkdOMDupFy+1UUfk
        7jRgYnYqnn0bjOD2MKIVi2UnGtBW+2GWtq+SejmyGPXMGE/CvyqOKYqCuNC8hisl8iujG7Oysk2fg
        YAiT92UIssrhaNbw3sL6Zr104YzxTchOaqVK8p9XBzgSKiRC/OhBg+XOZMEDBIZQVhKRxHLvQxEnN
        L1f3k0k6P5fAi1zV8/5BIzYunZ8UvkZ7Ntv4BkM44TLUeeZDoYExL582Yu2+TvWQ8OFsiFlMCSHp3
        CszL1OT3wxpUsMdvKxxafF7c3xzyBvFsT5OS3BpgVSqCWWRSi3Avx0Lp5CsN9/qKO+nSVy3Y9x2B6
        BkQkW/dQ==;
Received: from [177.83.209.223] (helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1oHVwa-00BMCN-NS; Fri, 29 Jul 2022 21:46:48 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     ardb@kernel.org, linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, anton@enomsg.org, ccross@android.com,
        keescook@chromium.org, matt@codeblueprint.co.uk,
        mjg59@srcf.ucam.org, tony.luck@intel.com,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH v2 1/3] efi: Add a generic helper to convert strings to unicode
Date:   Fri, 29 Jul 2022 16:45:30 -0300
Message-Id: <20220729194532.228403-2-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220729194532.228403-1-gpiccoli@igalia.com>
References: <20220729194532.228403-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Currently both efi-pstore and efibc rely in simple for-loops to convert
from regular char pointers to u16/unicode strings; so let's export this
functionality as a helper to common EFI code to prevent code duplication.
This helper will also be used in a subsequent patch (adding a new module).

Notice that efi-pstore didn't write the end NULL char in the unicode
string before this patch, but this should not change anything in a
relevant way for this module - other than that, no functional change is
expected.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 drivers/firmware/efi/efi-pstore.c |  4 +---
 drivers/firmware/efi/efibc.c      |  9 ++++-----
 include/linux/efi.h               | 17 +++++++++++++++++
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
index 3bddc152fcd4..965a4c0d6e60 100644
--- a/drivers/firmware/efi/efi-pstore.c
+++ b/drivers/firmware/efi/efi-pstore.c
@@ -167,7 +167,6 @@ static int efi_pstore_write(struct pstore_record *record)
 	char name[DUMP_NAME_LEN];
 	efi_char16_t efi_name[DUMP_NAME_LEN];
 	efi_status_t status;
-	int i;
 
 	record->id = generic_id(record->time.tv_sec, record->part,
 				record->count);
@@ -180,8 +179,7 @@ static int efi_pstore_write(struct pstore_record *record)
 		 (long long)record->time.tv_sec,
 		 record->compressed ? 'C' : 'D');
 
-	for (i = 0; i < DUMP_NAME_LEN; i++)
-		efi_name[i] = name[i];
+	efi_str8_to_str16(efi_name, name, DUMP_NAME_LEN - 1);
 
 	if (efivar_trylock())
 		return -EBUSY;
diff --git a/drivers/firmware/efi/efibc.c b/drivers/firmware/efi/efibc.c
index 8ced7af8e56d..7e3bf60d24e0 100644
--- a/drivers/firmware/efi/efibc.c
+++ b/drivers/firmware/efi/efibc.c
@@ -39,7 +39,7 @@ static int efibc_reboot_notifier_call(struct notifier_block *notifier,
 						    : L"shutdown";
 	const u8 *str = data;
 	efi_char16_t *wdata;
-	unsigned long l;
+	size_t len;
 	int ret;
 
 	ret = efibc_set_variable(L"LoaderEntryRebootReason", reason,
@@ -48,11 +48,10 @@ static int efibc_reboot_notifier_call(struct notifier_block *notifier,
 		return NOTIFY_DONE;
 
 	wdata = kmalloc(MAX_DATA_LEN * sizeof(efi_char16_t), GFP_KERNEL);
-	for (l = 0; l < MAX_DATA_LEN - 1 && str[l] != '\0'; l++)
-		wdata[l] = str[l];
-	wdata[l] = L'\0';
 
-	efibc_set_variable(L"LoaderEntryOneShot", wdata, l);
+	len = efi_str8_to_str16(wdata, str, MAX_DATA_LEN - 1);
+
+	efibc_set_variable(L"LoaderEntryOneShot", wdata, len);
 
 	kfree(wdata);
 	return NOTIFY_DONE;
diff --git a/include/linux/efi.h b/include/linux/efi.h
index d2b84c2fec39..c0ea01be3772 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1030,6 +1030,23 @@ struct efivars {
 
 #define EFI_VAR_NAME_LEN	1024
 
+/*
+ * Helper that converts regular char buffer to u16 unicode-like strings;
+ * notice that the unicode buffer requires to be at least len+1 in size.
+ */
+static inline size_t
+efi_str8_to_str16(efi_char16_t *str16, const char *str8, size_t len)
+{
+	size_t i;
+
+	for (i = 0; i < len && str8[i] != '\0'; i++)
+		str16[i] = str8[i];
+
+	str16[i] = L'\0';
+
+	return i;
+}
+
 int efivars_register(struct efivars *efivars,
 		     const struct efivar_operations *ops,
 		     struct kobject *kobject);
-- 
2.37.1

