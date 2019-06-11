Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41AA43D372
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jun 2019 19:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405786AbfFKRG2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 11 Jun 2019 13:06:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35202 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405813AbfFKRG2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 11 Jun 2019 13:06:28 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5BH35HJ072678
        for <linux-efi@vger.kernel.org>; Tue, 11 Jun 2019 13:06:27 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t2fkbtbma-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Tue, 11 Jun 2019 13:06:26 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <nayna@linux.ibm.com>;
        Tue, 11 Jun 2019 18:06:25 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 11 Jun 2019 18:06:20 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5BH6JNa56885340
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 17:06:19 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BDD511C050;
        Tue, 11 Jun 2019 17:06:19 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A4A1D11C04C;
        Tue, 11 Jun 2019 17:06:16 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.80.199.191])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 11 Jun 2019 17:06:16 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linuxppc-dev@ozlabs.org, linux-efi@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Subject: [PATCH v4 2/3] powerpc/powernv: detect the secure boot mode of the system
Date:   Tue, 11 Jun 2019 13:06:04 -0400
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1560272765-5768-1-git-send-email-nayna@linux.ibm.com>
References: <1560272765-5768-1-git-send-email-nayna@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19061117-4275-0000-0000-000003416B9A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061117-4276-0000-0000-000038517DF3
Message-Id: <1560272765-5768-3-git-send-email-nayna@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-11_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906110109
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

PowerNV secure boot defines different IMA policies based on the secure
boot state of the system.

This patch defines a function to detect the secure boot state of the
system.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 arch/powerpc/include/asm/secboot.h       | 21 ++++++++
 arch/powerpc/platforms/powernv/Makefile  |  2 +-
 arch/powerpc/platforms/powernv/secboot.c | 61 ++++++++++++++++++++++++
 3 files changed, 83 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/include/asm/secboot.h
 create mode 100644 arch/powerpc/platforms/powernv/secboot.c

diff --git a/arch/powerpc/include/asm/secboot.h b/arch/powerpc/include/asm/secboot.h
new file mode 100644
index 000000000000..1904fb4a3352
--- /dev/null
+++ b/arch/powerpc/include/asm/secboot.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PowerPC secure boot definitions
+ *
+ * Copyright (C) 2019 IBM Corporation
+ * Author: Nayna Jain <nayna@linux.ibm.com>
+ *
+ */
+#ifndef POWERPC_SECBOOT_H
+#define POWERPC_SECBOOT_H
+
+#if defined(CONFIG_OPAL_SECVAR)
+extern bool get_powerpc_sb_mode(void);
+#else
+static inline bool get_powerpc_sb_mode(void)
+{
+	return false;
+}
+#endif
+
+#endif
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index 6651c742e530..6f4af607a915 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -16,4 +16,4 @@ obj-$(CONFIG_PERF_EVENTS) += opal-imc.o
 obj-$(CONFIG_PPC_MEMTRACE)	+= memtrace.o
 obj-$(CONFIG_PPC_VAS)	+= vas.o vas-window.o vas-debug.o
 obj-$(CONFIG_OCXL_BASE)	+= ocxl.o
-obj-$(CONFIG_OPAL_SECVAR) += opal-secvar.o
+obj-$(CONFIG_OPAL_SECVAR) += opal-secvar.o secboot.o
diff --git a/arch/powerpc/platforms/powernv/secboot.c b/arch/powerpc/platforms/powernv/secboot.c
new file mode 100644
index 000000000000..9199e520ebed
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/secboot.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 IBM Corporation
+ * Author: Nayna Jain <nayna@linux.ibm.com>
+ *
+ * secboot.c
+ *      - util function to get powerpc secboot state
+ */
+#include <linux/uuid.h>
+#include <asm/opal.h>
+#include <asm/secboot.h>
+#include <asm/opal-secvar.h>
+
+bool get_powerpc_sb_mode(void)
+{
+	u8 secure_boot_name[] = "SecureBoot";
+	u8 setup_mode_name[] = "SetupMode";
+	u8 secboot, setupmode;
+	unsigned long size = sizeof(secboot);
+	int status;
+	unsigned long version;
+
+	status = opal_variable_version(&version);
+	if ((status != OPAL_SUCCESS) || (version != BACKEND_TC_COMPAT_V1)) {
+		pr_info("secboot: error retrieving compatible backend\n");
+		return false;
+	}
+
+	status = opal_get_variable(secure_boot_name, sizeof(secure_boot_name),
+				   NULL, NULL, &secboot, &size);
+
+	/*
+	 * For now assume all failures reading the SecureBoot variable implies
+	 * secure boot is not enabled. Later differentiate failure types.
+	 */
+	if (status != OPAL_SUCCESS) {
+		secboot = 0;
+		setupmode = 0;
+		goto out;
+	}
+
+	size = sizeof(setupmode);
+	status = opal_get_variable(setup_mode_name, sizeof(setup_mode_name),
+				   NULL, NULL,  &setupmode, &size);
+
+	/*
+	 * Failure to read the SetupMode variable does not prevent
+	 * secure boot mode
+	 */
+	if (status != OPAL_SUCCESS)
+		setupmode = 0;
+
+out:
+	if ((secboot == 0) || (setupmode == 1)) {
+		pr_info("secboot: secureboot mode disabled\n");
+		return false;
+	}
+
+	pr_info("secboot: secureboot mode enabled\n");
+	return true;
+}
-- 
2.20.1

