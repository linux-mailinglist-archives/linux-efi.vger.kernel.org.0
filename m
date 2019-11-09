Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC2C3F60EF
	for <lists+linux-efi@lfdr.de>; Sat,  9 Nov 2019 20:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfKITBD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 9 Nov 2019 14:01:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64020 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726681AbfKITBD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 9 Nov 2019 14:01:03 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA9IuxeY181746
        for <linux-efi@vger.kernel.org>; Sat, 9 Nov 2019 14:01:02 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w5th85drw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Sat, 09 Nov 2019 14:01:01 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <nayna@linux.ibm.com>;
        Sat, 9 Nov 2019 19:01:00 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 9 Nov 2019 19:00:56 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA9J0JwL38207828
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 9 Nov 2019 19:00:19 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98FC552050;
        Sat,  9 Nov 2019 19:00:54 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.40.192.65])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 20AA85204E;
        Sat,  9 Nov 2019 19:00:52 +0000 (GMT)
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
Subject: [PATCH v8 4/4] powerpc: load firmware trusted keys/hashes into kernel keyring
Date:   Sat,  9 Nov 2019 13:00:32 -0600
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191109190032.96259-1-nayna@linux.ibm.com>
References: <20191109190032.96259-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19110919-0016-0000-0000-000002C23D10
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110919-0017-0000-0000-00003323C7BD
Message-Id: <20191109190032.96259-5-nayna@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-09_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911090193
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The keys used to verify the Host OS kernel are managed by firmware as
secure variables. This patch loads the verification keys into the .platform
keyring and revocation hashes into .blacklist keyring. This enables
verification and loading of the kernels signed by the boot time keys which
are trusted by firmware.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Eric Richter <erichte@linux.ibm.com>
---
 security/integrity/Kconfig                    |  9 ++
 security/integrity/Makefile                   |  4 +-
 .../integrity/platform_certs/load_powerpc.c   | 98 +++++++++++++++++++
 3 files changed, 110 insertions(+), 1 deletion(-)
 create mode 100644 security/integrity/platform_certs/load_powerpc.c

diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
index 0bae6adb63a9..71f0177e8716 100644
--- a/security/integrity/Kconfig
+++ b/security/integrity/Kconfig
@@ -72,6 +72,15 @@ config LOAD_IPL_KEYS
        depends on S390
        def_bool y
 
+config LOAD_PPC_KEYS
+	bool "Enable loading of platform and blacklisted keys for POWER"
+	depends on INTEGRITY_PLATFORM_KEYRING
+	depends on PPC_SECURE_BOOT
+	default y
+	help
+	  Enable loading of keys to the .platform keyring and blacklisted
+	  hashes to the .blacklist keyring for powerpc based platforms.
+
 config INTEGRITY_AUDIT
 	bool "Enables integrity auditing support "
 	depends on AUDIT
diff --git a/security/integrity/Makefile b/security/integrity/Makefile
index 351c9662994b..7ee39d66cf16 100644
--- a/security/integrity/Makefile
+++ b/security/integrity/Makefile
@@ -14,6 +14,8 @@ integrity-$(CONFIG_LOAD_UEFI_KEYS) += platform_certs/efi_parser.o \
 				      platform_certs/load_uefi.o \
 				      platform_certs/keyring_handler.o
 integrity-$(CONFIG_LOAD_IPL_KEYS) += platform_certs/load_ipl_s390.o
-
+integrity-$(CONFIG_LOAD_PPC_KEYS) += platform_certs/efi_parser.o \
+                                     platform_certs/load_powerpc.o \
+                                     platform_certs/keyring_handler.o
 obj-$(CONFIG_IMA)			+= ima/
 obj-$(CONFIG_EVM)			+= evm/
diff --git a/security/integrity/platform_certs/load_powerpc.c b/security/integrity/platform_certs/load_powerpc.c
new file mode 100644
index 000000000000..99ddc2ed59e6
--- /dev/null
+++ b/security/integrity/platform_certs/load_powerpc.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 IBM Corporation
+ * Author: Nayna Jain
+ *
+ *      - loads keys and hashes stored and controlled by the firmware.
+ */
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/cred.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <asm/secure_boot.h>
+#include <asm/secvar.h>
+#include "keyring_handler.h"
+
+/*
+ * Get a certificate list blob from the named secure variable.
+ */
+static __init void *get_cert_list(u8 *key, unsigned long keylen, uint64_t *size)
+{
+	int rc;
+	void *db;
+
+	rc = secvar_ops->get(key, keylen, NULL, size);
+	if (rc) {
+		pr_err("Couldn't get size: %d\n", rc);
+		return NULL;
+	}
+
+	db = kmalloc(*size, GFP_KERNEL);
+	if (!db)
+		return NULL;
+
+	rc = secvar_ops->get(key, keylen, db, size);
+	if (rc) {
+		kfree(db);
+		pr_err("Error reading %s var: %d\n", key, rc);
+		return NULL;
+	}
+
+	return db;
+}
+
+/*
+ * Load the certs contained in the keys databases into the platform trusted
+ * keyring and the blacklisted X.509 cert SHA256 hashes into the blacklist
+ * keyring.
+ */
+static int __init load_powerpc_certs(void)
+{
+	void *db = NULL, *dbx = NULL;
+	uint64_t dbsize = 0, dbxsize = 0;
+	int rc = 0;
+	struct device_node *node;
+
+	if (!secvar_ops)
+		return -ENODEV;
+
+	/* The following only applies for the edk2-compat backend.
+	 * Return early if it is not set.
+	 */
+
+	node = of_find_compatible_node(NULL, NULL, "ibm,edk2-compat-v1");
+	if (!node)
+		return -ENODEV;
+
+	/* Get db, and dbx.  They might not exist, so it isn't
+	 * an error if we can't get them.
+	 */
+	db = get_cert_list("db", 3, &dbsize);
+	if (!db) {
+		pr_err("Couldn't get db list from firmware\n");
+	} else {
+		rc = parse_efi_signature_list("powerpc:db", db, dbsize,
+					      get_handler_for_db);
+		if (rc)
+			pr_err("Couldn't parse db signatures: %d\n", rc);
+		kfree(db);
+	}
+
+	dbx = get_cert_list("dbx", 4,  &dbxsize);
+	if (!dbx) {
+		pr_info("Couldn't get dbx list from firmware\n");
+	} else {
+		rc = parse_efi_signature_list("powerpc:dbx", dbx, dbxsize,
+					      get_handler_for_dbx);
+		if (rc)
+			pr_err("Couldn't parse dbx signatures: %d\n", rc);
+		kfree(dbx);
+	}
+
+	of_node_put(node);
+
+	return rc;
+}
+late_initcall(load_powerpc_certs);
-- 
2.20.1

