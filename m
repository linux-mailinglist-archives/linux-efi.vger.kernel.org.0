Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6F016113C
	for <lists+linux-efi@lfdr.de>; Mon, 17 Feb 2020 12:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbgBQLj6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Feb 2020 06:39:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34058 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728504AbgBQLj5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Feb 2020 06:39:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581939595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QRFmFOmaNTRD1QIBloTftoDjLg6oNQM+MmQJYi2gh5g=;
        b=J+zpR9k46M7zQdvFOXlVhdEF3OkCz663N/RcWxkTYoXUCiup0z8R6y56SXhqnffpHr2k32
        4hgSS89zVSCt01KX4l/PR+sgfn7v5XZ5q5BrFf+EVZono0O0rvyE93yeHjbZ6rpDfq0QYb
        YXl1gelslzMQ3L3js0H15izRP/yLD30=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-94Esxfy9NbqdLH1kMeTmYQ-1; Mon, 17 Feb 2020 06:39:54 -0500
X-MC-Unique: 94Esxfy9NbqdLH1kMeTmYQ-1
Received: by mail-wr1-f69.google.com with SMTP id t3so8761625wrm.23
        for <linux-efi@vger.kernel.org>; Mon, 17 Feb 2020 03:39:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QRFmFOmaNTRD1QIBloTftoDjLg6oNQM+MmQJYi2gh5g=;
        b=sELZyWl3/+XE6G8z6OzVwplHA4yOosKOLXxWodn9UjkLfpEI1DhrwdnAkWWKaU/+B6
         XpuDM0tQoZ/A+MTuYq/mwi/n/pWr+lgQMV23/cNBnavuv3r6LBs3JEkl4EBAQ5Ao70AH
         QYOqe6C895RguC9q2pmkbMvC/Op7yIZbp7c81enmwBKpnUkJfMBuJmStq4NHfTdgNx9N
         TTcZuNX9RCRO48giW00LiYeBSwcuKboDhYjjpfH25ppMGVm6qmiRhK9nsa6h6KF19OK+
         Dx7nrdMiB7c8Glg8Yd/OHb5RE9/EIJ+G3589DtqycHMdApLs4qgr2Yu//he/SGLCj/WJ
         LtyQ==
X-Gm-Message-State: APjAAAWTZoJ+iAnY8KPMd/+O264mS6Aa4oUN6UDfp9a/Tnosl4H0vccw
        LTOBduq0GIF/51I7kWloRdIeyP2hCk2tMhgna/cqrpzHm8a/bi3pl8F+5Orbbi40p8UhkOBbX9S
        ZIxnlB2PCi+G4TgL8T7o4
X-Received: by 2002:a5d:4d0a:: with SMTP id z10mr21650604wrt.253.1581939592319;
        Mon, 17 Feb 2020 03:39:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqwN2okTJcojI/z4Sv+jYqgvwukj9C5eNn7FosG40Fd5mXfN5sJbwb9Yjzx0ib+Co8jWunrSPw==
X-Received: by 2002:a5d:4d0a:: with SMTP id z10mr21650582wrt.253.1581939592064;
        Mon, 17 Feb 2020 03:39:52 -0800 (PST)
Received: from minerva.redhat.com ([2a01:c50f:ab80:6700:527f:85b3:5615:ff0b])
        by smtp.gmail.com with ESMTPSA id y6sm620529wrl.17.2020.02.17.03.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 03:39:51 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Eric Richter <erichte@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        YueHaibing <yuehaibing@huawei.com>,
        linux-security-module@vger.kernel.org
Subject: [RESEND PATCH v2] efi: Only print errors about failing to get certs if EFI vars are found
Date:   Mon, 17 Feb 2020 12:39:47 +0100
Message-Id: <20200217113947.2070436-1-javierm@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

If CONFIG_LOAD_UEFI_KEYS is enabled, the kernel attempts to load the certs
from the db, dbx and MokListRT EFI variables into the appropriate keyrings.

But it just assumes that the variables will be present and prints an error
if the certs can't be loaded, even when is possible that the variables may
not exist. For example the MokListRT variable will only be present if shim
is used.

So only print an error message about failing to get the certs list from an
EFI variable if this is found. Otherwise these printed errors just pollute
the kernel log ring buffer with confusing messages like the following:

[    5.427251] Couldn't get size: 0x800000000000000e
[    5.427261] MODSIGN: Couldn't get UEFI db list
[    5.428012] Couldn't get size: 0x800000000000000e
[    5.428023] Couldn't get UEFI MokListRT

Reported-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>

---

Changes in v2:
- Fix flaws in the logic, that caused the signature list was parsed if
  the return code was EFI_NOT_FOUND that pointed out Hans de Goede.
- Print debug messages if the variables are not found.

 security/integrity/platform_certs/load_uefi.c | 40 ++++++++++++-------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
index 111898aad56..f0c90824196 100644
--- a/security/integrity/platform_certs/load_uefi.c
+++ b/security/integrity/platform_certs/load_uefi.c
@@ -35,16 +35,18 @@ static __init bool uefi_check_ignore_db(void)
  * Get a certificate list blob from the named EFI variable.
  */
 static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
-				  unsigned long *size)
+				  unsigned long *size, efi_status_t *status)
 {
-	efi_status_t status;
 	unsigned long lsize = 4;
 	unsigned long tmpdb[4];
 	void *db;
 
-	status = efi.get_variable(name, guid, NULL, &lsize, &tmpdb);
-	if (status != EFI_BUFFER_TOO_SMALL) {
-		pr_err("Couldn't get size: 0x%lx\n", status);
+	*status = efi.get_variable(name, guid, NULL, &lsize, &tmpdb);
+	if (*status == EFI_NOT_FOUND)
+		return NULL;
+
+	if (*status != EFI_BUFFER_TOO_SMALL) {
+		pr_err("Couldn't get size: 0x%lx\n", *status);
 		return NULL;
 	}
 
@@ -52,10 +54,10 @@ static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
 	if (!db)
 		return NULL;
 
-	status = efi.get_variable(name, guid, NULL, &lsize, db);
-	if (status != EFI_SUCCESS) {
+	*status = efi.get_variable(name, guid, NULL, &lsize, db);
+	if (*status != EFI_SUCCESS) {
 		kfree(db);
-		pr_err("Error reading db var: 0x%lx\n", status);
+		pr_err("Error reading db var: 0x%lx\n", *status);
 		return NULL;
 	}
 
@@ -74,6 +76,7 @@ static int __init load_uefi_certs(void)
 	efi_guid_t mok_var = EFI_SHIM_LOCK_GUID;
 	void *db = NULL, *dbx = NULL, *mok = NULL;
 	unsigned long dbsize = 0, dbxsize = 0, moksize = 0;
+	efi_status_t status;
 	int rc = 0;
 
 	if (!efi.get_variable)
@@ -83,9 +86,12 @@ static int __init load_uefi_certs(void)
 	 * an error if we can't get them.
 	 */
 	if (!uefi_check_ignore_db()) {
-		db = get_cert_list(L"db", &secure_var, &dbsize);
+		db = get_cert_list(L"db", &secure_var, &dbsize, &status);
 		if (!db) {
-			pr_err("MODSIGN: Couldn't get UEFI db list\n");
+			if (status == EFI_NOT_FOUND)
+				pr_debug("MODSIGN: db variable wasn't found\n");
+			else
+				pr_err("MODSIGN: Couldn't get UEFI db list\n");
 		} else {
 			rc = parse_efi_signature_list("UEFI:db",
 					db, dbsize, get_handler_for_db);
@@ -96,9 +102,12 @@ static int __init load_uefi_certs(void)
 		}
 	}
 
-	mok = get_cert_list(L"MokListRT", &mok_var, &moksize);
+	mok = get_cert_list(L"MokListRT", &mok_var, &moksize, &status);
 	if (!mok) {
-		pr_info("Couldn't get UEFI MokListRT\n");
+		if (status == EFI_NOT_FOUND)
+			pr_debug("MokListRT variable wasn't found\n");
+		else
+			pr_info("Couldn't get UEFI MokListRT\n");
 	} else {
 		rc = parse_efi_signature_list("UEFI:MokListRT",
 					      mok, moksize, get_handler_for_db);
@@ -107,9 +116,12 @@ static int __init load_uefi_certs(void)
 		kfree(mok);
 	}
 
-	dbx = get_cert_list(L"dbx", &secure_var, &dbxsize);
+	dbx = get_cert_list(L"dbx", &secure_var, &dbxsize, &status);
 	if (!dbx) {
-		pr_info("Couldn't get UEFI dbx list\n");
+		if (status == EFI_NOT_FOUND)
+			pr_debug("dbx variable wasn't found\n");
+		else
+			pr_info("Couldn't get UEFI dbx list\n");
 	} else {
 		rc = parse_efi_signature_list("UEFI:dbx",
 					      dbx, dbxsize,
-- 
2.24.1

