Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43F15C0759
	for <lists+linux-efi@lfdr.de>; Fri, 27 Sep 2019 16:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfI0O0f (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Sep 2019 10:26:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40862 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727824AbfI0O0e (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 27 Sep 2019 10:26:34 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8REM8am037383
        for <linux-efi@vger.kernel.org>; Fri, 27 Sep 2019 10:26:33 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v8w271w68-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Fri, 27 Sep 2019 10:26:31 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <nayna@linux.ibm.com>;
        Fri, 27 Sep 2019 15:26:28 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 27 Sep 2019 15:26:23 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8REQLIW43516126
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Sep 2019 14:26:21 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16706A405C;
        Fri, 27 Sep 2019 14:26:21 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F70EA405B;
        Fri, 27 Sep 2019 14:26:17 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.80.207.173])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 27 Sep 2019 14:26:17 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linuxppc-dev@ozlabs.org, linux-efi@vger.kernel.org,
        linux-integrity@vger.kernel.org, devicetree@vger.kernel.org
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
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v6 2/9] powerpc: detect the secure boot mode of the system
Date:   Fri, 27 Sep 2019 10:25:53 -0400
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1569594360-7141-1-git-send-email-nayna@linux.ibm.com>
References: <1569594360-7141-1-git-send-email-nayna@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19092714-0020-0000-0000-000003725410
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19092714-0021-0000-0000-000021C82573
Message-Id: <1569594360-7141-3-git-send-email-nayna@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-27_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909270134
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Secure boot on PowerNV defines different IMA policies based on the secure
boot state of the system.

This patch defines a function to detect the secure boot state of the
system.

The PPC_SECURE_BOOT config represents the base enablement of secureboot
on POWER.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 arch/powerpc/Kconfig                   | 10 ++++
 arch/powerpc/include/asm/secure_boot.h | 31 ++++++++++
 arch/powerpc/kernel/Makefile           |  2 +
 arch/powerpc/kernel/secure_boot.c      | 82 ++++++++++++++++++++++++++
 4 files changed, 125 insertions(+)
 create mode 100644 arch/powerpc/include/asm/secure_boot.h
 create mode 100644 arch/powerpc/kernel/secure_boot.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 77f6ebf97113..2c54beb29f1a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -912,6 +912,16 @@ config PPC_MEM_KEYS
 
 	  If unsure, say y.
 
+config PPC_SECURE_BOOT
+	prompt "Enable secure boot support"
+	bool
+	depends on PPC_POWERNV
+	help
+	  Systems with firmware secure boot enabled needs to define security
+	  policies to extend secure boot to the OS. This config allows user
+	  to enable OS secure boot on systems that have firmware support for
+	  it. If in doubt say N.
+
 endmenu
 
 config ISA_DMA_API
diff --git a/arch/powerpc/include/asm/secure_boot.h b/arch/powerpc/include/asm/secure_boot.h
new file mode 100644
index 000000000000..4e8e2b08a993
--- /dev/null
+++ b/arch/powerpc/include/asm/secure_boot.h
@@ -0,0 +1,31 @@
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
+#define SECURE_BOOT_MASK	0xFFFFFFFF00000000
+
+bool is_powerpc_os_secureboot_enabled(void);
+int get_powerpc_os_sb_node(struct device_node **node);
+
+#else
+
+static inline bool is_powerpc_os_secureboot_enabled(void)
+{
+	return false;
+}
+
+static inline int get_powerpc_os_sb_node(struct device_node **node)
+{
+	return -ENOENT;
+}
+
+#endif
+#endif
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index ea0c69236789..875b0785a20e 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -157,6 +157,8 @@ endif
 obj-$(CONFIG_EPAPR_PARAVIRT)	+= epapr_paravirt.o epapr_hcalls.o
 obj-$(CONFIG_KVM_GUEST)		+= kvm.o kvm_emul.o
 
+obj-$(CONFIG_PPC_SECURE_BOOT)	+= secure_boot.o
+
 # Disable GCOV, KCOV & sanitizers in odd or sensitive code
 GCOV_PROFILE_prom_init.o := n
 KCOV_INSTRUMENT_prom_init.o := n
diff --git a/arch/powerpc/kernel/secure_boot.c b/arch/powerpc/kernel/secure_boot.c
new file mode 100644
index 000000000000..45ca19f5e836
--- /dev/null
+++ b/arch/powerpc/kernel/secure_boot.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 IBM Corporation
+ * Author: Nayna Jain
+ */
+#include <linux/types.h>
+#include <linux/of.h>
+#include <asm/secure_boot.h>
+
+static struct device_node *get_powerpc_fw_sb_node(void)
+{
+	return of_find_node_by_name(NULL, "ibm,secureboot");
+}
+
+bool is_powerpc_os_sb_supported(void)
+{
+	struct device_node *node = NULL;
+
+	node = get_powerpc_fw_sb_node();
+	if (node && of_device_is_compatible(node, "ibm,secureboot-v3"))
+		return true;
+
+	return false;
+}
+
+int get_powerpc_os_sb_node(struct device_node **node)
+{
+	struct device_node *fwsbnode;
+
+	if (!is_powerpc_os_sb_supported())
+		return -ENOTSUPP;
+
+	fwsbnode = get_powerpc_fw_sb_node();
+	if (!fwsbnode)
+		return -ENOENT;
+
+	*node = of_find_node_by_name(fwsbnode, "secvar");
+	if (*node)
+		return 0;
+
+	return -ENOENT;
+}
+
+bool is_powerpc_os_secureboot_enabled(void)
+{
+	struct device_node *node;
+	u64 sbmode = 0;
+	int rc;
+
+	rc = get_powerpc_os_sb_node(&node);
+	if (rc == -ENOTSUPP)
+		goto disabled;
+
+	/* Fail secure for any failure related to secvar */
+	if (rc) {
+		pr_err("Expected secure variables support, fail secure\n");
+		goto enabled;
+	}
+
+	if (!of_device_is_available(node)) {
+		pr_err("Secure variables support is in error state, fail secure\n");
+		goto enabled;
+	}
+
+	rc = of_property_read_u64(node, "os-secure-mode", &sbmode);
+	if (rc)
+		goto enabled;
+
+	sbmode = be64_to_cpu(sbmode);
+
+	/* checks for the secure mode enforcing bit */
+	if (!(sbmode & SECURE_BOOT_MASK))
+		goto disabled;
+
+enabled:
+	pr_info("secureboot mode enabled\n");
+	return true;
+
+disabled:
+	pr_info("secureboot mode disabled\n");
+	return false;
+}
-- 
2.20.1

