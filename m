Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E451D11E045
	for <lists+linux-efi@lfdr.de>; Fri, 13 Dec 2019 10:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfLMJHQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Dec 2019 04:07:16 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54326 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfLMJHQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Dec 2019 04:07:16 -0500
Received: by mail-wm1-f68.google.com with SMTP id b19so1261140wmj.4;
        Fri, 13 Dec 2019 01:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ecy3+9YwiUy4ysqR8X7NcmLf801I05PLIwbX/oPr26s=;
        b=XkAc2x2o+tefBO4kVz3F8NQ9qvVTyK2MAz1DB/DG7jNoFAesqZlsNb38mnj3cfaQ5c
         YAtDC51yuUabVRd2CIoPZDLAAqAooy+q7ZoGlM9IDxqywz9SzxCerh7SIHsEaJ1szl26
         XAidsIjH4vDc0ll6q1HRU2+r+kud0ZvWPUyorvYzmImIkANbLz5ISwbJdvlbYZ8eAkE1
         KMf5W3wLD6MJVVP8VCEIHFKpC/+fPW758MpUGyz5CWQRadeCQ7CglNDHo++DwPGD10LH
         4dILzJfCXPCmIvVmsN7aQnNCIB282yafaWg2VaEySqQ7Ihkj3zuL81L9Mq+8pDzTanYi
         atwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ecy3+9YwiUy4ysqR8X7NcmLf801I05PLIwbX/oPr26s=;
        b=rkATi69uYjLJTKMdbNGjDEoQrmWqszstO9k8PwMWjfnBbDWxwiu2kTLVlD7fH27Lnb
         xh8dGbjO3IdgYH5hg4ZmalY6Y0n06G2Iine8jdQgmvwzjWJfiWS+cwjNISE0eMAW7aWc
         TG/RUdVB5tQq/7suPwLiG9BVzYjoiwJJBM+W2LF+oZR7H689hCsKSrpsrUnIa4U4af8t
         mEb050ZvvgBZvNk7pcdJymVCrzkk+e8mcaMDd+EypP10gkq9rgj/gD3MEoLS9dMnfjxh
         gTKmpLP4tTM5xBpDLm0+0NTn+kC6SF662yHjXwORUchtikTGz34pLfJpOu+cNPHNw8ii
         qtNA==
X-Gm-Message-State: APjAAAW6WR84U3ka9TjAZ0mV9wSvmQSeFDByOZxeQg95ap+Q28fEBQpB
        x3iIpJ2tfKeLi/IVRjrdCNg=
X-Google-Smtp-Source: APXvYqwlZcqxB9Y7iFgT0DNE48hTNMDUeas/Nc+2IXbcisCCpQ02eylNO0Ik+vdAIHa7Vi8+TfnUBQ==
X-Received: by 2002:a1c:7310:: with SMTP id d16mr11676218wmb.165.1576228033939;
        Fri, 13 Dec 2019 01:07:13 -0800 (PST)
Received: from linux-691t.suse.de ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id y6sm9079094wrl.17.2019.12.13.01.07.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 01:07:13 -0800 (PST)
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
Subject: [PATCH 2/2] efi: show error messages only when loading certificates is failed
Date:   Fri, 13 Dec 2019 17:06:46 +0800
Message-Id: <20191213090646.12329-3-jlee@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191213090646.12329-1-jlee@suse.com>
References: <20191213090646.12329-1-jlee@suse.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When loading certificates list from EFI variables, the error
message and efi status code always be emitted to dmesg. It looks
ugly:

[    2.335031] Couldn't get size: 0x800000000000000e
[    2.335032] Couldn't get UEFI MokListRT
[    2.339985] Couldn't get size: 0x800000000000000e
[    2.339987] Couldn't get UEFI dbx list

This cosmetic patch moved the messages to the error handling code
path. And, it also shows the corresponding status string of status
code.

Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---
 security/integrity/platform_certs/load_uefi.c | 40 ++++++++++++++-------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
index 81b19c52832b..b6c60fb3fb6c 100644
--- a/security/integrity/platform_certs/load_uefi.c
+++ b/security/integrity/platform_certs/load_uefi.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/kernel.h>
 #include <linux/sched.h>
@@ -39,7 +40,7 @@ static __init bool uefi_check_ignore_db(void)
  * Get a certificate list blob from the named EFI variable.
  */
 static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
-				  unsigned long *size)
+				  unsigned long *size, const char *source)
 {
 	efi_status_t status;
 	unsigned long lsize = 4;
@@ -48,23 +49,30 @@ static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
 
 	status = efi.get_variable(name, guid, NULL, &lsize, &tmpdb);
 	if (status != EFI_BUFFER_TOO_SMALL) {
-		pr_err("Couldn't get size: 0x%lx\n", status);
-		return NULL;
+		if (status == EFI_NOT_FOUND) {
+			pr_debug("%s list was not found\n", source);
+			return NULL;
+		}
+		goto err;
 	}
 
 	db = kmalloc(lsize, GFP_KERNEL);
-	if (!db)
-		return NULL;
+	if (!db) {
+		status = EFI_OUT_OF_RESOURCES;
+		goto err;
+	}
 
 	status = efi.get_variable(name, guid, NULL, &lsize, db);
 	if (status != EFI_SUCCESS) {
 		kfree(db);
-		pr_err("Error reading db var: 0x%lx\n", status);
-		return NULL;
+		goto err;
 	}
 
 	*size = lsize;
 	return db;
+err:
+	pr_err("Couldn't get %s list: %s\n", source, efi_status_to_str(status));
+	return NULL;
 }
 
 /*
@@ -153,10 +161,8 @@ static int __init load_uefi_certs(void)
 	 * an error if we can't get them.
 	 */
 	if (!uefi_check_ignore_db()) {
-		db = get_cert_list(L"db", &secure_var, &dbsize);
-		if (!db) {
-			pr_err("MODSIGN: Couldn't get UEFI db list\n");
-		} else {
+		db = get_cert_list(L"db", &secure_var, &dbsize, "UEFI:db");
+		if (db) {
 			rc = parse_efi_signature_list("UEFI:db",
 					db, dbsize, get_handler_for_db);
 			if (rc)
@@ -166,10 +172,8 @@ static int __init load_uefi_certs(void)
 		}
 	}
 
-	mok = get_cert_list(L"MokListRT", &mok_var, &moksize);
-	if (!mok) {
-		pr_info("Couldn't get UEFI MokListRT\n");
-	} else {
+	mok = get_cert_list(L"MokListRT", &mok_var, &moksize, "UEFI:MokListRT");
+	if (mok) {
 		rc = parse_efi_signature_list("UEFI:MokListRT",
 					      mok, moksize, get_handler_for_db);
 		if (rc)
@@ -177,10 +181,8 @@ static int __init load_uefi_certs(void)
 		kfree(mok);
 	}
 
-	dbx = get_cert_list(L"dbx", &secure_var, &dbxsize);
-	if (!dbx) {
-		pr_info("Couldn't get UEFI dbx list\n");
-	} else {
+	dbx = get_cert_list(L"dbx", &secure_var, &dbxsize, "UEFI:dbx");
+	if (dbx) {
 		rc = parse_efi_signature_list("UEFI:dbx",
 					      dbx, dbxsize,
 					      get_handler_for_dbx);
-- 
2.16.4

