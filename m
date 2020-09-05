Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC3A25E4EF
	for <lists+linux-efi@lfdr.de>; Sat,  5 Sep 2020 03:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgIEBbb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Sep 2020 21:31:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23984 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728302AbgIEBbW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Sep 2020 21:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599269479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:in-reply-to:in-reply-to:references:references;
        bh=NdBF9BxRtnQ51Jye5EupXs8XU8Cc4mM2XfckLdtHcWI=;
        b=b9ayQD8y8RTOZ3yU+bj+j7RXQMk5sRhB1ZaT0N6Slc0tkCEDl9cQjbJjcTv5969jrbOItN
        aBYyl66D+3KYvtlf45VVEWbGk9mEXZ040hY5Ud0Me5tKjehgikbzZLq+u7bG8vAW1lhvo3
        O12VAsEPO4iQ7yNjC64DCvbcM6+I/NA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-B_0SADqEPyu0N77SLXLBog-1; Fri, 04 Sep 2020 21:31:15 -0400
X-MC-Unique: B_0SADqEPyu0N77SLXLBog-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 412B0802B72;
        Sat,  5 Sep 2020 01:31:14 +0000 (UTC)
Received: from lszubowi.redhat.com (ovpn-65-66.rdu2.redhat.com [10.10.65.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0BA845D9CC;
        Sat,  5 Sep 2020 01:31:12 +0000 (UTC)
From:   Lenny Szubowicz <lszubowi@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-security-module@vger.kernel.org, andy.shevchenko@gmail.com,
        ardb@kernel.org, jmorris@namei.org, serge@hallyn.com,
        keescook@chromium.org, zohar@linux.ibm.com, bp@alien8.de,
        pjones@redhat.com, dhowells@redhat.com, prarit@redhat.com
Subject: [PATCH V2 2/3] integrity: Move import of MokListRT certs to a separate routine
Date:   Fri,  4 Sep 2020 21:31:06 -0400
Message-Id: <20200905013107.10457-3-lszubowi@redhat.com>
In-Reply-To: <20200905013107.10457-1-lszubowi@redhat.com>
References: <20200905013107.10457-1-lszubowi@redhat.com>
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
index 253fb9a7fc98..c1c622b4dc78 100644
--- a/security/integrity/platform_certs/load_uefi.c
+++ b/security/integrity/platform_certs/load_uefi.c
@@ -66,6 +66,43 @@ static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
 }
 
 /*
+ * load_moklist_certs() - Load MokList certs
+ *
+ * Load the certs contained in the UEFI MokListRT database into the
+ * platform trusted keyring.
+ *
+ * Return:	Status
+ */
+static int __init load_moklist_certs(void)
+{
+	efi_guid_t mok_var = EFI_SHIM_LOCK_GUID;
+	void *mok;
+	unsigned long moksize;
+	efi_status_t status;
+	int rc;
+
+	/* Get MokListRT. It might not exist, so it isn't an error
+	 * if we can't get it.
+	 */
+	mok = get_cert_list(L"MokListRT", &mok_var, &moksize, &status);
+	if (mok) {
+		rc = parse_efi_signature_list("UEFI:MokListRT",
+					      mok, moksize, get_handler_for_db);
+		kfree(mok);
+		if (rc)
+			pr_err("Couldn't parse MokListRT signatures: %d\n", rc);
+		return rc;
+	}
+	if (status == EFI_NOT_FOUND)
+		pr_debug("MokListRT variable wasn't found\n");
+	else
+		pr_info("Couldn't get UEFI MokListRT\n");
+	return 0;
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

