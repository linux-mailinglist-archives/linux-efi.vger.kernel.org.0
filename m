Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8632525DD
	for <lists+linux-efi@lfdr.de>; Wed, 26 Aug 2020 05:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgHZDpP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Aug 2020 23:45:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59235 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726809AbgHZDpN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Aug 2020 23:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598413511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:in-reply-to:in-reply-to:references:references;
        bh=/TBuoGPP1tG+0tOjQSeCl3WzgYge/SObbXxxTWBbxLs=;
        b=GOFYaFBY26jRYlDbpCnFyhCSluVjqKRMkmbFQmib6yDX8FF6dhMwGullEm6zXOQAxVMyHe
        3lm656LjPwQYMa4rDig+ow2v5/VIdyH8PLBU+iQl5jzcNKDrgwnmNzdCs+7a5C94xVuBGQ
        zEQATHyF7fZL5/XINIOrBH4doDl9IXI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-vD43XxqlMSS7DJst6HmNTA-1; Tue, 25 Aug 2020 23:45:09 -0400
X-MC-Unique: vD43XxqlMSS7DJst6HmNTA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 131BC801AED;
        Wed, 26 Aug 2020 03:45:08 +0000 (UTC)
Received: from lszubowi.redhat.com (unknown [10.10.110.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE7E25D9E4;
        Wed, 26 Aug 2020 03:45:05 +0000 (UTC)
From:   Lenny Szubowicz <lszubowi@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-security-module@vger.kernel.org, ardb@kernel.org,
        jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        zohar@linux.ibm.com, bp@alien8.de, pjones@redhat.com,
        dhowells@redhat.com, prarit@redhat.com
Subject: [PATCH 2/3] integrity: Move import of MokListRT certs to a separate routine
Date:   Tue, 25 Aug 2020 23:44:54 -0400
Message-Id: <20200826034455.28707-3-lszubowi@redhat.com>
In-Reply-To: <20200826034455.28707-1-lszubowi@redhat.com>
References: <20200826034455.28707-1-lszubowi@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Move the loading of certs from the UEFI MokListRT into a separate
routine to facilitate additional MokList functionality.

There is no visible functional change as a result of this patch.
Although the UEFI dbx certs are now loaded before the MokList certs,
they are loaded onto different key rings. So the order of the keys
on their respective key rings is the same.

Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>
---
 security/integrity/platform_certs/load_uefi.c | 63 +++++++++++++------
 1 file changed, 44 insertions(+), 19 deletions(-)

diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
index 253fb9a7fc98..547410d8ffa5 100644
--- a/security/integrity/platform_certs/load_uefi.c
+++ b/security/integrity/platform_certs/load_uefi.c
@@ -66,6 +66,43 @@ static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
 }
 
 /*
+ * load_moklist_certs() - Load MokList certs
+ *
+ * Returns:	Summary error status
+ *
+ * Load the certs contained in the UEFI MokListRT database into the
+ * platform trusted keyring.
+ */
+static int __init load_moklist_certs(void)
+{
+	efi_guid_t mok_var = EFI_SHIM_LOCK_GUID;
+	void *mok = NULL;
+	unsigned long moksize = 0;
+	efi_status_t status;
+	int rc = 0;
+
+	/* Get MokListRT. It might not exist, so it isn't an error
+	 * if we can't get it.
+	 */
+	mok = get_cert_list(L"MokListRT", &mok_var, &moksize, &status);
+	if (!mok) {
+		if (status == EFI_NOT_FOUND)
+			pr_debug("MokListRT variable wasn't found\n");
+		else
+			pr_info("Couldn't get UEFI MokListRT\n");
+	} else {
+		rc = parse_efi_signature_list("UEFI:MokListRT",
+					      mok, moksize, get_handler_for_db);
+		if (rc)
+			pr_err("Couldn't parse MokListRT signatures: %d\n", rc);
+		kfree(mok);
+	}
+	return rc;
+}
+
+/*
+ * load_uefi_certs() - Load certs from UEFI sources
+ *
  * Load the certs contained in the UEFI databases into the platform trusted
  * keyring and the UEFI blacklisted X.509 cert SHA256 hashes into the blacklist
  * keyring.
@@ -73,17 +110,16 @@ static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
 static int __init load_uefi_certs(void)
 {
 	efi_guid_t secure_var = EFI_IMAGE_SECURITY_DATABASE_GUID;
-	efi_guid_t mok_var = EFI_SHIM_LOCK_GUID;
-	void *db = NULL, *dbx = NULL, *mok = NULL;
-	unsigned long dbsize = 0, dbxsize = 0, moksize = 0;
+	void *db = NULL, *dbx = NULL;
+	unsigned long dbsize = 0, dbxsize = 0;
 	efi_status_t status;
 	int rc = 0;
 
 	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
 		return false;
 
-	/* Get db, MokListRT, and dbx.  They might not exist, so it isn't
-	 * an error if we can't get them.
+	/* Get db and dbx.  They might not exist, so it isn't an error
+	 * if we can't get them.
 	 */
 	if (!uefi_check_ignore_db()) {
 		db = get_cert_list(L"db", &secure_var, &dbsize, &status);
@@ -102,20 +138,6 @@ static int __init load_uefi_certs(void)
 		}
 	}
 
-	mok = get_cert_list(L"MokListRT", &mok_var, &moksize, &status);
-	if (!mok) {
-		if (status == EFI_NOT_FOUND)
-			pr_debug("MokListRT variable wasn't found\n");
-		else
-			pr_info("Couldn't get UEFI MokListRT\n");
-	} else {
-		rc = parse_efi_signature_list("UEFI:MokListRT",
-					      mok, moksize, get_handler_for_db);
-		if (rc)
-			pr_err("Couldn't parse MokListRT signatures: %d\n", rc);
-		kfree(mok);
-	}
-
 	dbx = get_cert_list(L"dbx", &secure_var, &dbxsize, &status);
 	if (!dbx) {
 		if (status == EFI_NOT_FOUND)
@@ -131,6 +153,9 @@ static int __init load_uefi_certs(void)
 		kfree(dbx);
 	}
 
+	/* Load the MokListRT certs */
+	rc = load_moklist_certs();
+
 	return rc;
 }
 late_initcall(load_uefi_certs);
-- 
2.27.0

