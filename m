Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01403C4482
	for <lists+linux-efi@lfdr.de>; Wed,  2 Oct 2019 01:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbfJAXmW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Oct 2019 19:42:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19884 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729325AbfJAXmW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Oct 2019 19:42:22 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x91Ng5UC170287
        for <linux-efi@vger.kernel.org>; Tue, 1 Oct 2019 19:42:21 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vcdgpn9a5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Tue, 01 Oct 2019 19:42:20 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <nayna@linux.ibm.com>;
        Wed, 2 Oct 2019 00:42:18 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 2 Oct 2019 00:42:14 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x91NgCF631850678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Oct 2019 23:42:12 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 722C5A4062;
        Tue,  1 Oct 2019 23:42:12 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D63A6A4054;
        Tue,  1 Oct 2019 23:42:09 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.80.224.222])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Oct 2019 23:42:09 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linuxppc-dev@ozlabs.org, linux-efi@vger.kernel.org,
        linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Eric Ricther <erichte@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v4 3/4] x86/efi: move common keyring handler functions to new file
Date:   Tue,  1 Oct 2019 19:41:50 -0400
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1569973311-3047-1-git-send-email-nayna@linux.ibm.com>
References: <1569973311-3047-1-git-send-email-nayna@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19100123-4275-0000-0000-0000036D236C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100123-4276-0000-0000-000038802451
Message-Id: <1569973311-3047-4-git-send-email-nayna@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-01_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910010202
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The handlers to add the keys to the .platform keyring and blacklisted
hashes to the .blacklist keyring is common for both the uefi and powerpc
mechanisms of loading the keys/hashes from the firmware.

This patch moves the common code from load_uefi.c to keyring_handler.c

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
Acked-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/Makefile                   |  3 +-
 .../platform_certs/keyring_handler.c          | 80 +++++++++++++++++++
 .../platform_certs/keyring_handler.h          | 32 ++++++++
 security/integrity/platform_certs/load_uefi.c | 67 +---------------
 4 files changed, 115 insertions(+), 67 deletions(-)
 create mode 100644 security/integrity/platform_certs/keyring_handler.c
 create mode 100644 security/integrity/platform_certs/keyring_handler.h

diff --git a/security/integrity/Makefile b/security/integrity/Makefile
index 19faace69644..525bf1d6e0db 100644
--- a/security/integrity/Makefile
+++ b/security/integrity/Makefile
@@ -11,7 +11,8 @@ integrity-$(CONFIG_INTEGRITY_SIGNATURE) += digsig.o
 integrity-$(CONFIG_INTEGRITY_ASYMMETRIC_KEYS) += digsig_asymmetric.o
 integrity-$(CONFIG_INTEGRITY_PLATFORM_KEYRING) += platform_certs/platform_keyring.o
 integrity-$(CONFIG_LOAD_UEFI_KEYS) += platform_certs/efi_parser.o \
-					platform_certs/load_uefi.o
+				      platform_certs/load_uefi.o \
+				      platform_certs/keyring_handler.o
 integrity-$(CONFIG_LOAD_IPL_KEYS) += platform_certs/load_ipl_s390.o
 $(obj)/load_uefi.o: KBUILD_CFLAGS += -fshort-wchar
 
diff --git a/security/integrity/platform_certs/keyring_handler.c b/security/integrity/platform_certs/keyring_handler.c
new file mode 100644
index 000000000000..c5ba695c10e3
--- /dev/null
+++ b/security/integrity/platform_certs/keyring_handler.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/cred.h>
+#include <linux/err.h>
+#include <linux/efi.h>
+#include <linux/slab.h>
+#include <keys/asymmetric-type.h>
+#include <keys/system_keyring.h>
+#include "../integrity.h"
+
+static efi_guid_t efi_cert_x509_guid __initdata = EFI_CERT_X509_GUID;
+static efi_guid_t efi_cert_x509_sha256_guid __initdata =
+	EFI_CERT_X509_SHA256_GUID;
+static efi_guid_t efi_cert_sha256_guid __initdata = EFI_CERT_SHA256_GUID;
+
+/*
+ * Blacklist a hash.
+ */
+static __init void uefi_blacklist_hash(const char *source, const void *data,
+				       size_t len, const char *type,
+				       size_t type_len)
+{
+	char *hash, *p;
+
+	hash = kmalloc(type_len + len * 2 + 1, GFP_KERNEL);
+	if (!hash)
+		return;
+	p = memcpy(hash, type, type_len);
+	p += type_len;
+	bin2hex(p, data, len);
+	p += len * 2;
+	*p = 0;
+
+	mark_hash_blacklisted(hash);
+	kfree(hash);
+}
+
+/*
+ * Blacklist an X509 TBS hash.
+ */
+static __init void uefi_blacklist_x509_tbs(const char *source,
+					   const void *data, size_t len)
+{
+	uefi_blacklist_hash(source, data, len, "tbs:", 4);
+}
+
+/*
+ * Blacklist the hash of an executable.
+ */
+static __init void uefi_blacklist_binary(const char *source,
+					 const void *data, size_t len)
+{
+	uefi_blacklist_hash(source, data, len, "bin:", 4);
+}
+
+/*
+ * Return the appropriate handler for particular signature list types found in
+ * the UEFI db and MokListRT tables.
+ */
+__init efi_element_handler_t get_handler_for_db(const efi_guid_t *sig_type)
+{
+	if (efi_guidcmp(*sig_type, efi_cert_x509_guid) == 0)
+		return add_to_platform_keyring;
+	return 0;
+}
+
+/*
+ * Return the appropriate handler for particular signature list types found in
+ * the UEFI dbx and MokListXRT tables.
+ */
+__init efi_element_handler_t get_handler_for_dbx(const efi_guid_t *sig_type)
+{
+	if (efi_guidcmp(*sig_type, efi_cert_x509_sha256_guid) == 0)
+		return uefi_blacklist_x509_tbs;
+	if (efi_guidcmp(*sig_type, efi_cert_sha256_guid) == 0)
+		return uefi_blacklist_binary;
+	return 0;
+}
diff --git a/security/integrity/platform_certs/keyring_handler.h b/security/integrity/platform_certs/keyring_handler.h
new file mode 100644
index 000000000000..2462bfa08fe3
--- /dev/null
+++ b/security/integrity/platform_certs/keyring_handler.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef PLATFORM_CERTS_INTERNAL_H
+#define PLATFORM_CERTS_INTERNAL_H
+
+#include <linux/efi.h>
+
+void blacklist_hash(const char *source, const void *data,
+		    size_t len, const char *type,
+		    size_t type_len);
+
+/*
+ * Blacklist an X509 TBS hash.
+ */
+void blacklist_x509_tbs(const char *source, const void *data, size_t len);
+
+/*
+ * Blacklist the hash of an executable.
+ */
+void blacklist_binary(const char *source, const void *data, size_t len);
+
+/*
+ * Return the handler for particular signature list types found in the db.
+ */
+efi_element_handler_t get_handler_for_db(const efi_guid_t *sig_type);
+
+/*
+ * Return the handler for particular signature list types found in the dbx.
+ */
+efi_element_handler_t get_handler_for_dbx(const efi_guid_t *sig_type);
+
+#endif
diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
index 81b19c52832b..4369204a19cd 100644
--- a/security/integrity/platform_certs/load_uefi.c
+++ b/security/integrity/platform_certs/load_uefi.c
@@ -9,6 +9,7 @@
 #include <keys/asymmetric-type.h>
 #include <keys/system_keyring.h>
 #include "../integrity.h"
+#include "keyring_handler.h"
 
 static efi_guid_t efi_cert_x509_guid __initdata = EFI_CERT_X509_GUID;
 static efi_guid_t efi_cert_x509_sha256_guid __initdata =
@@ -67,72 +68,6 @@ static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
 	return db;
 }
 
-/*
- * Blacklist a hash.
- */
-static __init void uefi_blacklist_hash(const char *source, const void *data,
-				       size_t len, const char *type,
-				       size_t type_len)
-{
-	char *hash, *p;
-
-	hash = kmalloc(type_len + len * 2 + 1, GFP_KERNEL);
-	if (!hash)
-		return;
-	p = memcpy(hash, type, type_len);
-	p += type_len;
-	bin2hex(p, data, len);
-	p += len * 2;
-	*p = 0;
-
-	mark_hash_blacklisted(hash);
-	kfree(hash);
-}
-
-/*
- * Blacklist an X509 TBS hash.
- */
-static __init void uefi_blacklist_x509_tbs(const char *source,
-					   const void *data, size_t len)
-{
-	uefi_blacklist_hash(source, data, len, "tbs:", 4);
-}
-
-/*
- * Blacklist the hash of an executable.
- */
-static __init void uefi_blacklist_binary(const char *source,
-					 const void *data, size_t len)
-{
-	uefi_blacklist_hash(source, data, len, "bin:", 4);
-}
-
-/*
- * Return the appropriate handler for particular signature list types found in
- * the UEFI db and MokListRT tables.
- */
-static __init efi_element_handler_t get_handler_for_db(const efi_guid_t *
-						       sig_type)
-{
-	if (efi_guidcmp(*sig_type, efi_cert_x509_guid) == 0)
-		return add_to_platform_keyring;
-	return 0;
-}
-
-/*
- * Return the appropriate handler for particular signature list types found in
- * the UEFI dbx and MokListXRT tables.
- */
-static __init efi_element_handler_t get_handler_for_dbx(const efi_guid_t *
-							sig_type)
-{
-	if (efi_guidcmp(*sig_type, efi_cert_x509_sha256_guid) == 0)
-		return uefi_blacklist_x509_tbs;
-	if (efi_guidcmp(*sig_type, efi_cert_sha256_guid) == 0)
-		return uefi_blacklist_binary;
-	return 0;
-}
-
 /*
  * Load the certs contained in the UEFI databases into the platform trusted
  * keyring and the UEFI blacklisted X.509 cert SHA256 hashes into the blacklist
-- 
2.20.1

