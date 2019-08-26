Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51F6D9D063
	for <lists+linux-efi@lfdr.de>; Mon, 26 Aug 2019 15:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732275AbfHZNYX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 26 Aug 2019 09:24:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60388 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732333AbfHZNYT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 26 Aug 2019 09:24:19 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7QDLsrg013518
        for <linux-efi@vger.kernel.org>; Mon, 26 Aug 2019 09:24:18 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2umg7dg3s8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Mon, 26 Aug 2019 09:24:17 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <nayna@linux.ibm.com>;
        Mon, 26 Aug 2019 14:24:15 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 26 Aug 2019 14:24:10 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7QDO8LX46596158
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Aug 2019 13:24:08 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E2C94203F;
        Mon, 26 Aug 2019 13:24:08 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D7E64204B;
        Mon, 26 Aug 2019 13:24:06 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.85.199.141])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 26 Aug 2019 13:24:05 +0000 (GMT)
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
Subject: [PATCH v3 4/4] powerpc: load firmware trusted keys/hashes into kernel keyring
Date:   Mon, 26 Aug 2019 09:23:38 -0400
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1566825818-9731-1-git-send-email-nayna@linux.ibm.com>
References: <1566825818-9731-1-git-send-email-nayna@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19082613-0020-0000-0000-0000036420CB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082613-0021-0000-0000-000021B968F2
Message-Id: <1566825818-9731-5-git-send-email-nayna@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-26_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908260145
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
---
 security/integrity/Kconfig                    |  8 ++
 security/integrity/Makefile                   |  3 +
 .../integrity/platform_certs/load_powerpc.c   | 88 +++++++++++++++++++
 3 files changed, 99 insertions(+)
 create mode 100644 security/integrity/platform_certs/load_powerpc.c

diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
index 0bae6adb63a9..26abee23e4e3 100644
--- a/security/integrity/Kconfig
+++ b/security/integrity/Kconfig
@@ -72,6 +72,14 @@ config LOAD_IPL_KEYS
        depends on S390
        def_bool y
 
+config LOAD_PPC_KEYS
+	bool "Enable loading of platform and blacklisted keys for POWER"
+	depends on INTEGRITY_PLATFORM_KEYRING
+	depends on PPC_SECURE_BOOT
+	help
+	  Enable loading of keys to the .platform keyring and blacklisted
+	  hashes to the .blacklist keyring for powerpc based platforms.
+
 config INTEGRITY_AUDIT
 	bool "Enables integrity auditing support "
 	depends on AUDIT
diff --git a/security/integrity/Makefile b/security/integrity/Makefile
index 525bf1d6e0db..9eeb6b053de3 100644
--- a/security/integrity/Makefile
+++ b/security/integrity/Makefile
@@ -14,6 +14,9 @@ integrity-$(CONFIG_LOAD_UEFI_KEYS) += platform_certs/efi_parser.o \
 				      platform_certs/load_uefi.o \
 				      platform_certs/keyring_handler.o
 integrity-$(CONFIG_LOAD_IPL_KEYS) += platform_certs/load_ipl_s390.o
+integrity-$(CONFIG_LOAD_PPC_KEYS) += platform_certs/efi_parser.o \
+					 platform_certs/load_powerpc.o \
+					 platform_certs/keyring_handler.o
 $(obj)/load_uefi.o: KBUILD_CFLAGS += -fshort-wchar
 
 subdir-$(CONFIG_IMA)			+= ima
diff --git a/security/integrity/platform_certs/load_powerpc.c b/security/integrity/platform_certs/load_powerpc.c
new file mode 100644
index 000000000000..359d5063d4da
--- /dev/null
+++ b/security/integrity/platform_certs/load_powerpc.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 IBM Corporation
+ * Author: Nayna Jain <nayna@linux.ibm.com>
+ *
+ *      - loads keys and hashes stored and controlled by the firmware.
+ */
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/cred.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <asm/secboot.h>
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
+		pr_err("Error reading db var: %d\n", rc);
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
+
+	if (!secvar_ops)
+		return -ENODEV;
+
+	/* Get db, and dbx.  They might not exist, so it isn't
+	 * an error if we can't get them.
+	 */
+	db = get_cert_list("db", 3, &dbsize);
+	if (!db) {
+		pr_err("Couldn't get db list from firmware\n");
+	} else {
+		rc = parse_efi_signature_list("powerpc:db",
+				db, dbsize, get_handler_for_db);
+		if (rc)
+			pr_err("Couldn't parse db signatures: %d\n",
+					rc);
+		kfree(db);
+	}
+
+	dbx = get_cert_list("dbx", 3,  &dbxsize);
+	if (!dbx) {
+		pr_info("Couldn't get dbx list from firmware\n");
+	} else {
+		rc = parse_efi_signature_list("powerpc:dbx",
+				dbx, dbxsize,
+				get_handler_for_dbx);
+		if (rc)
+			pr_err("Couldn't parse dbx signatures: %d\n", rc);
+		kfree(dbx);
+	}
+
+	return rc;
+}
+late_initcall(load_powerpc_certs);
-- 
2.20.1

