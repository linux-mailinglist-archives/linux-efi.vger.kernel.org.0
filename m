Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E99BF1120C
	for <lists+linux-efi@lfdr.de>; Thu,  2 May 2019 06:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfEBEE4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 May 2019 00:04:56 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46895 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfEBEEz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 May 2019 00:04:55 -0400
Received: by mail-pg1-f193.google.com with SMTP id n2so422830pgg.13;
        Wed, 01 May 2019 21:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jz1PSIAOwqEC7aMJdQtzoyve7waLviSL+4YglVxn7es=;
        b=K11pW5qiJtxsZ0bF9x/JRCq8UPI9nEoAJGhuM7BK17TmlQ8MXwJlduwGMxy2FtAlPU
         OjI3+SGNjqd4sm4ytXxEKRaukqPp1QmTqC10DeBvxl2+sGv6GKIEwsuB1gev3F3LQ8Ro
         p72yPJrpddRbgocW4EIJDC0VfkHxCTwyRnY3c0F0BXE9OK2FECHGnNtRmBGhmFVMkKA5
         jhLErVoU5w3CEXIzdDgWyWcPNBS4a3w4E3OD7PIMSrQwJCHGrX68ibaimnX8E1zdDQks
         IC6Al1qfyCS0HSQv0itwJMIaenTssHmuOY6mQVXBJIODxJ35ChL/IclAMbp+dvUrkGa0
         gnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jz1PSIAOwqEC7aMJdQtzoyve7waLviSL+4YglVxn7es=;
        b=qNQWDI5bBy/kGKQhXhn6noGxWQwXMK4s0Bu0II6ZX0QJCUgrNpefDxHdBycZJ1LsCo
         POZp4uBfvrhPAi0iCurK2FXxSZfI8mCPnH8MqH15Tj6NfIzwMZ4bxKZ0es/dSoKfXjPY
         tX8WQw7927TquawOVnap/3oBPsinYhgO2sM/McswQOpdKoQpnUH1nOsWsnHGThbtzog3
         OWBM72dfXyuDRzBTPokcSJjVlEvBYCOdf+IzteDCx3on/O797VmHjaCAFdbF2S4mnDQu
         lvBg5pFn0JMLWEUP97SZqUfUubUIM+A6mk+drbhMlGPdLTa6h/jXaCQtQqo2AmITu8gS
         fP4Q==
X-Gm-Message-State: APjAAAUg15GBNYkKLgREph1F8Enjff0PJ/xwDxCoJWt9p5+ZqJVSEZvJ
        VVd0huqqwM4WE85o4JJQMq8=
X-Google-Smtp-Source: APXvYqxeWFXdp9Aaw2xVD6N3+II2bl82wdzZQQIjljIKkZW1twnJvGKHWabJWPcKHP5bXGU8BZVw6w==
X-Received: by 2002:a65:6545:: with SMTP id a5mr1661162pgw.264.1556769895131;
        Wed, 01 May 2019 21:04:55 -0700 (PDT)
Received: from linux-l9pv.suse ([202.47.205.198])
        by smtp.gmail.com with ESMTPSA id k4sm1107687pgh.27.2019.05.01.21.04.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 May 2019 21:04:54 -0700 (PDT)
From:   "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
X-Google-Original-From: "Lee, Chun-Yi" <jlee@suse.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        Josh Boyer <jwboyer@fedoraproject.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-efi@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>
Subject: [PATCH 2/2 v3] efi: print appropriate status message when loading certificates
Date:   Thu,  2 May 2019 12:04:40 +0800
Message-Id: <20190502040441.30372-2-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20190502040441.30372-1-jlee@suse.com>
References: <20190502040441.30372-1-jlee@suse.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When loading certificates list from UEFI variable, the original error
message direct shows the efi status code from UEFI firmware. It looks
ugly:

[    2.335031] Couldn't get size: 0x800000000000000e
[    2.335032] Couldn't get UEFI MokListRT
[    2.339985] Couldn't get size: 0x800000000000000e
[    2.339987] Couldn't get UEFI dbx list

So, this patch shows the status string instead of status code.

On the other hand, the "Couldn't get UEFI" message doesn't need
to be exposed when db/dbx/mok variable do not exist. So, this
patch set the message level to debug.

v3.
- Print messages similar to db/mok when loading dbx hash to blacklist:
[    1.500952] EFI: Blacklisting hash of an executable: UEFI:dbx
[    1.501773] blacklist: Loaded blacklisting hash
'bin:80b4d96931bf0d02fd91a61e19d14f1da452e66db2408ca8604d411f92659f0a'

- Setting messages for the existence of db/mok/dbx lists to debug level.

v2.
Setting the MODSIGN messages level to debug.

Link:
https://forums.opensuse.org/showthread.php/535324-MODSIGN-Couldn-t-get-UEFI-db-list?p=2897516#post2897516
Cc: James Morris <jmorris@namei.org>
Cc: Serge E. Hallyn" <serge@hallyn.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Nayna Jain <nayna@linux.ibm.com>
Cc: Josh Boyer <jwboyer@fedoraproject.org>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---
 certs/blacklist.c                             |  3 +-
 security/integrity/platform_certs/load_uefi.c | 40 +++++++++++++++++++--------
 2 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/certs/blacklist.c b/certs/blacklist.c
index 3a507b9e2568..f91437e39e44 100644
--- a/certs/blacklist.c
+++ b/certs/blacklist.c
@@ -100,7 +100,8 @@ int mark_hash_blacklisted(const char *hash)
 	if (IS_ERR(key)) {
 		pr_err("Problem blacklisting hash (%ld)\n", PTR_ERR(key));
 		return PTR_ERR(key);
-	}
+	} else
+		pr_notice("Loaded blacklisting hash '%s'\n", hash);
 	return 0;
 }
 
diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
index 81b19c52832b..6b6996e5bc27 100644
--- a/security/integrity/platform_certs/load_uefi.c
+++ b/security/integrity/platform_certs/load_uefi.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#define pr_fmt(fmt) "EFI: "fmt
+
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/cred.h>
@@ -35,6 +37,18 @@ static __init bool uefi_check_ignore_db(void)
 	return status == EFI_SUCCESS;
 }
 
+static void str16_to_str(efi_char16_t *str16, char *str, int str_size)
+{
+	int i = 0;
+
+	while (str16[i] != '\0' && i < (str_size - 1)) {
+		str[i] = str16[i];
+		i++;
+	}
+
+	str[i] = '\0';
+}
+
 /*
  * Get a certificate list blob from the named EFI variable.
  */
@@ -44,13 +58,20 @@ static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
 	efi_status_t status;
 	unsigned long lsize = 4;
 	unsigned long tmpdb[4];
+	char namestr[16];
 	void *db;
 
+	str16_to_str(name, namestr, ARRAY_SIZE(namestr));
 	status = efi.get_variable(name, guid, NULL, &lsize, &tmpdb);
 	if (status != EFI_BUFFER_TOO_SMALL) {
-		pr_err("Couldn't get size: 0x%lx\n", status);
+		if (status == EFI_NOT_FOUND)
+			pr_debug("UEFI %s list doesn't exist\n", namestr);
+		else
+			pr_err("Couldn't get size for UEFI %s list: %s\n",
+				namestr, efi_status_to_str(status));
 		return NULL;
 	}
+	pr_debug("UEFI %s list exists\n", namestr);
 
 	db = kmalloc(lsize, GFP_KERNEL);
 	if (!db)
@@ -59,7 +80,8 @@ static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
 	status = efi.get_variable(name, guid, NULL, &lsize, db);
 	if (status != EFI_SUCCESS) {
 		kfree(db);
-		pr_err("Error reading db var: 0x%lx\n", status);
+		pr_err("Error reading UEFI %s list: %s\n",
+			namestr, efi_status_to_str(status));
 		return NULL;
 	}
 
@@ -95,6 +117,7 @@ static __init void uefi_blacklist_hash(const char *source, const void *data,
 static __init void uefi_blacklist_x509_tbs(const char *source,
 					   const void *data, size_t len)
 {
+	pr_info("Blacklisting X.509 TBS hash: %s\n", source);
 	uefi_blacklist_hash(source, data, len, "tbs:", 4);
 }
 
@@ -104,6 +127,7 @@ static __init void uefi_blacklist_x509_tbs(const char *source,
 static __init void uefi_blacklist_binary(const char *source,
 					 const void *data, size_t len)
 {
+	pr_info("Blacklisting hash of an executable: %s\n", source);
 	uefi_blacklist_hash(source, data, len, "bin:", 4);
 }
 
@@ -154,9 +178,7 @@ static int __init load_uefi_certs(void)
 	 */
 	if (!uefi_check_ignore_db()) {
 		db = get_cert_list(L"db", &secure_var, &dbsize);
-		if (!db) {
-			pr_err("MODSIGN: Couldn't get UEFI db list\n");
-		} else {
+		if (db) {
 			rc = parse_efi_signature_list("UEFI:db",
 					db, dbsize, get_handler_for_db);
 			if (rc)
@@ -167,9 +189,7 @@ static int __init load_uefi_certs(void)
 	}
 
 	mok = get_cert_list(L"MokListRT", &mok_var, &moksize);
-	if (!mok) {
-		pr_info("Couldn't get UEFI MokListRT\n");
-	} else {
+	if (mok) {
 		rc = parse_efi_signature_list("UEFI:MokListRT",
 					      mok, moksize, get_handler_for_db);
 		if (rc)
@@ -178,9 +198,7 @@ static int __init load_uefi_certs(void)
 	}
 
 	dbx = get_cert_list(L"dbx", &secure_var, &dbxsize);
-	if (!dbx) {
-		pr_info("Couldn't get UEFI dbx list\n");
-	} else {
+	if (dbx) {
 		rc = parse_efi_signature_list("UEFI:dbx",
 					      dbx, dbxsize,
 					      get_handler_for_dbx);
-- 
2.16.4

