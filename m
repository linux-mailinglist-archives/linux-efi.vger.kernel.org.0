Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 903F3EA990
	for <lists+linux-efi@lfdr.de>; Thu, 31 Oct 2019 04:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfJaDbw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Oct 2019 23:31:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45460 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726336AbfJaDbv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Oct 2019 23:31:51 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9V3Rc1k062274
        for <linux-efi@vger.kernel.org>; Wed, 30 Oct 2019 23:31:50 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vyhtga3h6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Wed, 30 Oct 2019 23:31:50 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 31 Oct 2019 03:31:47 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 31 Oct 2019 03:31:43 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9V3VfXM36831356
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Oct 2019 03:31:42 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC659A405F;
        Thu, 31 Oct 2019 03:31:41 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59198A4065;
        Thu, 31 Oct 2019 03:31:40 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.85.201.217])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 31 Oct 2019 03:31:40 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linuxppc-dev@ozlabs.org, linux-efi@vger.kernel.org,
        linux-integrity@vger.kernel.org
Cc:     Nayna Jain <nayna@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Eric Ricther <erichte@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>
Subject: [PATCH v10 1/9] powerpc: detect the secure boot mode of the system
Date:   Wed, 30 Oct 2019 23:31:26 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1572492694-6520-1-git-send-email-zohar@linux.ibm.com>
References: <1572492694-6520-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19103103-0012-0000-0000-0000035F54ED
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19103103-0013-0000-0000-0000219A9D42
Message-Id: <1572492694-6520-2-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-31_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910310031
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Nayna Jain <nayna@linux.ibm.com>

This patch defines a function to detect the secure boot state of a
PowerNV system.

The PPC_SECURE_BOOT config represents the base enablement of secure boot
for powerpc.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 arch/powerpc/Kconfig                   | 10 ++++++++++
 arch/powerpc/include/asm/secure_boot.h | 23 +++++++++++++++++++++++
 arch/powerpc/kernel/Makefile           |  2 ++
 arch/powerpc/kernel/secure_boot.c      | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 67 insertions(+)
 create mode 100644 arch/powerpc/include/asm/secure_boot.h
 create mode 100644 arch/powerpc/kernel/secure_boot.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 3e56c9c2f16e..56ea0019b616 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -934,6 +934,16 @@ config PPC_MEM_KEYS
 
 	  If unsure, say y.
 
+config PPC_SECURE_BOOT
+	prompt "Enable secure boot support"
+	bool
+	depends on PPC_POWERNV
+	help
+	  Systems with firmware secure boot enabled need to define security
+	  policies to extend secure boot to the OS. This config allows a user
+	  to enable OS secure boot on systems that have firmware support for
+	  it. If in doubt say N.
+
 endmenu
 
 config ISA_DMA_API
diff --git a/arch/powerpc/include/asm/secure_boot.h b/arch/powerpc/include/asm/secure_boot.h
new file mode 100644
index 000000000000..07d0fe0ca81f
--- /dev/null
+++ b/arch/powerpc/include/asm/secure_boot.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Secure boot definitions
+ *
+ * Copyright (C) 2019 IBM Corporation
+ * Author: Nayna Jain
+ */
+#ifndef _ASM_POWER_SECURE_BOOT_H
+#define _ASM_POWER_SECURE_BOOT_H
+
+#ifdef CONFIG_PPC_SECURE_BOOT
+
+bool is_ppc_secureboot_enabled(void);
+
+#else
+
+static inline bool is_ppc_secureboot_enabled(void)
+{
+	return false;
+}
+
+#endif
+#endif
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index a7ca8fe62368..e2a54fa240ac 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -161,6 +161,8 @@ ifneq ($(CONFIG_PPC_POWERNV)$(CONFIG_PPC_SVM),)
 obj-y				+= ucall.o
 endif
 
+obj-$(CONFIG_PPC_SECURE_BOOT)	+= secure_boot.o
+
 # Disable GCOV, KCOV & sanitizers in odd or sensitive code
 GCOV_PROFILE_prom_init.o := n
 KCOV_INSTRUMENT_prom_init.o := n
diff --git a/arch/powerpc/kernel/secure_boot.c b/arch/powerpc/kernel/secure_boot.c
new file mode 100644
index 000000000000..63dc82c50862
--- /dev/null
+++ b/arch/powerpc/kernel/secure_boot.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 IBM Corporation
+ * Author: Nayna Jain
+ */
+#include <linux/types.h>
+#include <linux/of.h>
+#include <asm/secure_boot.h>
+
+bool is_ppc_secureboot_enabled(void)
+{
+	struct device_node *node;
+	bool enabled = false;
+
+	node = of_find_compatible_node(NULL, NULL, "ibm,secvar-v1");
+	if (!of_device_is_available(node)) {
+		pr_err("Cannot find secure variable node in device tree; failing to secure state\n");
+		goto out;
+	}
+
+	/*
+	 * secureboot is enabled if os-secure-enforcing property exists,
+	 * else disabled.
+	 */
+	enabled = of_property_read_bool(node, "os-secure-enforcing");
+
+out:
+	of_node_put(node);
+
+	pr_info("Secure boot mode %s\n", enabled ? "enabled" : "disabled");
+	return enabled;
+}
-- 
2.7.5

