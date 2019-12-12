Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAE9111C95F
	for <lists+linux-efi@lfdr.de>; Thu, 12 Dec 2019 10:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbfLLJig (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Dec 2019 04:38:36 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40884 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbfLLJig (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 Dec 2019 04:38:36 -0500
Received: by mail-wm1-f66.google.com with SMTP id t14so1693194wmi.5;
        Thu, 12 Dec 2019 01:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6OFVz1V+QdSxenYGCYriudr4690ZB5/L3ueHTeHO5JI=;
        b=iu2oujS4uBIC/mGVXZwBCITYwmhwoIVD6SU1up0d6MC7GsNBgB+Z3YWAqFTe0eJxkW
         Lge/MLAolwiBpQQ5aZ0cny62Sio7aJRyVus+9FxgcSPI7Z83uP/UzO/OaXcOzhsJJOoQ
         jivVmjILRdZoEYu8QP2sFw2tDnMZvRQwBkuGFTuGxB6U4XnUUutywaJNXmrdl6wB4Yag
         KdJR0qDnI9dCeRTPgpUY/3UWw2J6mROXYmxACs5YY5D5cMkO746Kj/Nfu3BhrVe+p/vg
         FVwMtfthT/KzZVUGT/SLq2OZm+/9WGuWXWDTbsEH98ZtVyiXM9DwoVq/eZpDOFYkgo85
         7Tgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6OFVz1V+QdSxenYGCYriudr4690ZB5/L3ueHTeHO5JI=;
        b=IysPBZEVq3T9lTCuDjms0SKYya9xmTHEJu4qkRkoK/s1wG+mtOkDZQ27i3f3NuL3Fg
         BpumcKLCYa/2Cqn+cy8yvKyJbdLXE52+LCQO/fl4UkaL1uQTDs9ivbMsB92cK2qvcE+q
         OeGTV4KsU93YFE0EE0aogOOwmGpp9bpSBQeyPO73aYBGRe0PgCYNLW8jWvxpPfqY5dt3
         YA+LCe70AzXolXXuqsiJz38cNlRh/Z3wt5UaAm+wOA6iOs0wrVNEJ9YX6+0gZ7qhVQlS
         vsaXAdH0gvKMBKcjQ2QnfT7tDhfVj1RUNj21p6L9zUa0YGjW3lW5iqJj58K16B1mHf6h
         GuaQ==
X-Gm-Message-State: APjAAAURFF5cjLu0oarCjgxhf6D8B6Qjnj2gTHjH+LqucxInCNELJK7t
        r5svR6qB0fVYWFKPrm9Q1F8=
X-Google-Smtp-Source: APXvYqxi1X9dzmpuNKwm/hSxvBMNS9eiNkE+auH0j6TmmuDBUFABS5sZvv0wUWSaTe0yPaK5o6dWDA==
X-Received: by 2002:a1c:4e10:: with SMTP id g16mr5310900wmh.94.1576143514424;
        Thu, 12 Dec 2019 01:38:34 -0800 (PST)
Received: from linux-691t.suse.de ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id z8sm5471508wrq.22.2019.12.12.01.38.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 01:38:33 -0800 (PST)
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
Date:   Thu, 12 Dec 2019 17:38:12 +0800
Message-Id: <20191212093812.10518-3-jlee@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191212093812.10518-1-jlee@suse.com>
References: <20191212093812.10518-1-jlee@suse.com>
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
 security/integrity/platform_certs/load_uefi.c | 41 ++++++++++++++-------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
index 81b19c52832b..3b766831d2c5 100644
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
@@ -48,23 +49,31 @@ static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
 
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
+	pr_err("Couldn't get %s list: %s (0x%lx)\n",
+		source, efi_status_to_str(status), status);
+	return NULL;
 }
 
 /*
@@ -153,10 +162,8 @@ static int __init load_uefi_certs(void)
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
@@ -166,10 +173,8 @@ static int __init load_uefi_certs(void)
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
@@ -177,10 +182,8 @@ static int __init load_uefi_certs(void)
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

