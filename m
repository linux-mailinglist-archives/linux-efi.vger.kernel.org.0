Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06CF9DD9E2
	for <lists+linux-efi@lfdr.de>; Sat, 19 Oct 2019 20:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfJSSGo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 19 Oct 2019 14:06:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52736 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726146AbfJSSGo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 19 Oct 2019 14:06:44 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9JI6h3A042470
        for <linux-efi@vger.kernel.org>; Sat, 19 Oct 2019 14:06:43 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vqucefpt1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Sat, 19 Oct 2019 14:06:43 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <nayna@linux.ibm.com>;
        Sat, 19 Oct 2019 19:06:40 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 19 Oct 2019 19:06:35 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9JI6XUV43319474
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Oct 2019 18:06:34 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2E4152052;
        Sat, 19 Oct 2019 18:06:33 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.85.146.216])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 278D152050;
        Sat, 19 Oct 2019 18:06:31 +0000 (GMT)
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
        Nayna Jain <nayna@linux.ibm.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Subject: [PATCH v8 2/8] powerpc/ima: add support to initialize ima policy rules
Date:   Sat, 19 Oct 2019 14:06:11 -0400
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571508377-23603-1-git-send-email-nayna@linux.ibm.com>
References: <1571508377-23603-1-git-send-email-nayna@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19101918-0008-0000-0000-0000032401C9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101918-0009-0000-0000-00004A4325EE
Message-Id: <1571508377-23603-3-git-send-email-nayna@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-19_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910190171
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

PowerNV system use a Linux-based bootloader, which relies on the IMA
subsystem to enforce different secure boot modes. Since the verification
policy may differ based on the secure boot mode of the system, the
policies must be defined at runtime.

This patch implements arch-specific support to define IMA policy
rules based on the runtime secure boot mode of the system.

This patch provides arch-specific IMA policies if PPC_SECURE_BOOT
config is enabled.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 arch/powerpc/Kconfig           |  1 +
 arch/powerpc/kernel/Makefile   |  2 +-
 arch/powerpc/kernel/ima_arch.c | 39 ++++++++++++++++++++++++++++++++++
 include/linux/ima.h            |  3 ++-
 4 files changed, 43 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/kernel/ima_arch.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 56ea0019b616..c795039bdc73 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -938,6 +938,7 @@ config PPC_SECURE_BOOT
 	prompt "Enable secure boot support"
 	bool
 	depends on PPC_POWERNV
+	depends on IMA_ARCH_POLICY
 	help
 	  Systems with firmware secure boot enabled need to define security
 	  policies to extend secure boot to the OS. This config allows a user
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index e2a54fa240ac..e8eb2955b7d5 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -161,7 +161,7 @@ ifneq ($(CONFIG_PPC_POWERNV)$(CONFIG_PPC_SVM),)
 obj-y				+= ucall.o
 endif
 
-obj-$(CONFIG_PPC_SECURE_BOOT)	+= secure_boot.o
+obj-$(CONFIG_PPC_SECURE_BOOT)	+= secure_boot.o ima_arch.o
 
 # Disable GCOV, KCOV & sanitizers in odd or sensitive code
 GCOV_PROFILE_prom_init.o := n
diff --git a/arch/powerpc/kernel/ima_arch.c b/arch/powerpc/kernel/ima_arch.c
new file mode 100644
index 000000000000..65d82ee74ea4
--- /dev/null
+++ b/arch/powerpc/kernel/ima_arch.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 IBM Corporation
+ * Author: Nayna Jain
+ */
+
+#include <linux/ima.h>
+#include <asm/secure_boot.h>
+
+bool arch_ima_get_secureboot(void)
+{
+	return is_ppc_secureboot_enabled();
+}
+
+/*
+ * The "secure_rules" are enabled only on "secureboot" enabled systems.
+ * These rules verify the file signatures against known good values.
+ * The "appraise_type=imasig|modsig" option allows the known good signature
+ * to be stored as an xattr or as an appended signature.
+ */
+static const char *const secure_rules[] = {
+	"appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig|modsig",
+#ifndef CONFIG_MODULE_SIG_FORCE
+	"appraise func=MODULE_CHECK appraise_type=imasig|modsig",
+#endif
+	NULL
+};
+
+/*
+ * Returns the relevant IMA arch-specific policies based on the system secure
+ * boot state.
+ */
+const char *const *arch_get_ima_policy(void)
+{
+	if (is_ppc_secureboot_enabled())
+		return secure_rules;
+
+	return NULL;
+}
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 1c37f17f7203..6d904754d858 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -29,7 +29,8 @@ extern void ima_kexec_cmdline(const void *buf, int size);
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

