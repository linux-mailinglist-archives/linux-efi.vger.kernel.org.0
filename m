Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 129C93D378
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jun 2019 19:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405822AbfFKRGb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 11 Jun 2019 13:06:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36870 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405816AbfFKRGb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 11 Jun 2019 13:06:31 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5BH2tJs134670
        for <linux-efi@vger.kernel.org>; Tue, 11 Jun 2019 13:06:30 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t2ed2681y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Tue, 11 Jun 2019 13:06:30 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <nayna@linux.ibm.com>;
        Tue, 11 Jun 2019 18:06:28 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 11 Jun 2019 18:06:24 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5BH6FWg26214754
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 17:06:16 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD24D11C05E;
        Tue, 11 Jun 2019 17:06:22 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23A1011C04C;
        Tue, 11 Jun 2019 17:06:20 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.80.199.191])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 11 Jun 2019 17:06:19 +0000 (GMT)
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
Subject: [PATCH v4 3/3] powerpc: Add support to initialize ima policy rules
Date:   Tue, 11 Jun 2019 13:06:05 -0400
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1560272765-5768-1-git-send-email-nayna@linux.ibm.com>
References: <1560272765-5768-1-git-send-email-nayna@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19061117-0028-0000-0000-0000037967E0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061117-0029-0000-0000-0000243957E4
Message-Id: <1560272765-5768-4-git-send-email-nayna@linux.ibm.com>
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

PowerNV secure boot relies on the kernel IMA security subsystem to
perform the OS kernel image signature verification. Since each secure
boot mode has different IMA policy requirements, dynamic definition of
the policy rules based on the runtime secure boot mode of the system is
required. On systems that support secure boot, but have it disabled,
only measurement policy rules of the kernel image and modules are
defined.

This patch defines the arch-specific implementation to retrieve the
secure boot mode of the system and accordingly configures the IMA policy
rules.

This patch provides arch-specific IMA policies if PPC_SECURE_BOOT
config is enabled.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 arch/powerpc/Kconfig           | 14 +++++++++
 arch/powerpc/kernel/Makefile   |  1 +
 arch/powerpc/kernel/ima_arch.c | 54 ++++++++++++++++++++++++++++++++++
 include/linux/ima.h            |  3 +-
 4 files changed, 71 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/kernel/ima_arch.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8c1c636308c8..9de77bb14f54 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -902,6 +902,20 @@ config PPC_MEM_KEYS
 
 	  If unsure, say y.
 
+config PPC_SECURE_BOOT
+	prompt "Enable PowerPC Secure Boot"
+	bool
+	default n
+	depends on PPC64
+	depends on OPAL_SECVAR
+	depends on IMA
+	depends on IMA_ARCH_POLICY
+	help
+	  Linux on POWER with firmware secure boot enabled needs to define
+	  security policies to extend secure boot to the OS.This config
+	  allows user to enable OS Secure Boot on PowerPC systems that
+	  have firmware secure boot support.
+
 endmenu
 
 config ISA_DMA_API
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 0ea6c4aa3a20..75c929b41341 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -131,6 +131,7 @@ ifdef CONFIG_IMA
 obj-y				+= ima_kexec.o
 endif
 endif
+obj-$(CONFIG_PPC_SECURE_BOOT)	+= ima_arch.o
 
 obj-$(CONFIG_AUDIT)		+= audit.o
 obj64-$(CONFIG_AUDIT)		+= compat_audit.o
diff --git a/arch/powerpc/kernel/ima_arch.c b/arch/powerpc/kernel/ima_arch.c
new file mode 100644
index 000000000000..1767bf6e6550
--- /dev/null
+++ b/arch/powerpc/kernel/ima_arch.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 IBM Corporation
+ * Author: Nayna Jain <nayna@linux.ibm.com>
+ *
+ * ima_arch.c
+ *      - initialize ima policies for PowerPC Secure Boot
+ */
+
+#include <linux/ima.h>
+#include <asm/secboot.h>
+
+bool arch_ima_get_secureboot(void)
+{
+	bool sb_mode;
+
+	sb_mode = get_powerpc_sb_mode();
+	if (sb_mode)
+		return true;
+	else
+		return false;
+}
+
+/*
+ * File signature verification is not needed, include only measurements
+ */
+static const char *const default_arch_rules[] = {
+	"measure func=KEXEC_KERNEL_CHECK template=ima-modsig",
+	"measure func=MODULE_CHECK template=ima-modsig",
+	NULL
+};
+
+/* Both file signature verification and measurements are needed */
+static const char *const sb_arch_rules[] = {
+	"measure func=KEXEC_KERNEL_CHECK template=ima-modsig",
+	"measure func=MODULE_CHECK template=ima-modsig",
+	"appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig|modsig template=ima-modsig",
+#if !IS_ENABLED(CONFIG_MODULE_SIG)
+	"appraise func=MODULE_CHECK appraise_type=imasig|modsig template=ima-modsig",
+#endif
+	NULL
+};
+
+/*
+ * On PowerPC, file measurements are to be added to the IMA measurement list
+ * irrespective of the secure boot state of the system. Signature verification
+ * is conditionally enabled based on the secure boot state.
+ */
+const char *const *arch_get_ima_policy(void)
+{
+	if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) && arch_ima_get_secureboot())
+		return sb_arch_rules;
+	return default_arch_rules;
+}
diff --git a/include/linux/ima.h b/include/linux/ima.h
index fd9f7cf4cdf5..a01df076ecae 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -31,7 +31,8 @@ extern void ima_post_path_mknod(struct dentry *dentry);
 extern void ima_add_kexec_buffer(struct kimage *image);
 #endif
 
-#if (defined(CONFIG_X86) && defined(CONFIG_EFI)) || defined(CONFIG_S390)
+#if (defined(CONFIG_X86) && defined(CONFIG_EFI)) || defined(CONFIG_S390) \
+	|| defined(CONFIG_PPC_SECURE_BOOT)
 extern bool arch_ima_get_secureboot(void);
 extern const char * const *arch_get_ima_policy(void);
 #else
-- 
2.20.1

