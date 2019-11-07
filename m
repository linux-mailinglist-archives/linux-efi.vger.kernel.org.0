Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A160F2683
	for <lists+linux-efi@lfdr.de>; Thu,  7 Nov 2019 05:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733216AbfKGEWa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 6 Nov 2019 23:22:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5010 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733200AbfKGEW1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 6 Nov 2019 23:22:27 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA74Lvnd077598
        for <linux-efi@vger.kernel.org>; Wed, 6 Nov 2019 23:22:25 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w462uanft-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Wed, 06 Nov 2019 23:22:25 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <erichte@linux.ibm.com>;
        Thu, 7 Nov 2019 04:22:23 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 7 Nov 2019 04:22:19 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA74MIKA50069542
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Nov 2019 04:22:18 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 401CDAE053;
        Thu,  7 Nov 2019 04:22:18 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C034BAE045;
        Thu,  7 Nov 2019 04:22:15 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.40.192.65])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 Nov 2019 04:22:15 +0000 (GMT)
From:   Eric Richter <erichte@linux.ibm.com>
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
Subject: [PATCH v7 3/4] x86/efi: move common keyring handler functions to new file
Date:   Wed,  6 Nov 2019 22:22:04 -0600
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191107042205.13710-1-erichte@linux.ibm.com>
References: <20191107042205.13710-1-erichte@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19110704-0020-0000-0000-000003834644
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110704-0021-0000-0000-000021D9788B
Message-Id: <20191107042205.13710-4-erichte@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-06_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911070044
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Nayna Jain <nayna@linux.ibm.com>

The handlers to add the keys to the .platform keyring and blacklisted
hashes to the .blacklist keyring is common for both the uefi and powerpc
mechanisms of loading the keys/hashes from the firmware.

This patch moves the common code from load_uefi.c to keyring_handler.c

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
Acked-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Eric Richter <erichte@linux.ibm.com>
---
 security/integrity/Makefile                   |  3 +-
 .../platform_certs/keyring_handler.c          | 80 +++++++++++++++++++
 .../platform_certs/keyring_handler.h          | 32 ++++++++
 security/integrity/platform_certs/load_uefi.c | 67 +---------------
 4 files changed, 115 insertions(+), 67 deletions(-)
 create mode 100644 security/integrity/platform_certs/keyring_handler.c
 create mode 100644 security/integrity/platform_certs/keyring_handler.h

diff --git a/security/integrity/Makefile b/security/integrity/Makefile
index 35e6ca773734..351c9662994b 100644
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
 
 obj-$(CONFIG_IMA)			+= ima/
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

