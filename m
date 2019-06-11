Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB1363D36F
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jun 2019 19:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405792AbfFKRGZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 11 Jun 2019 13:06:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45518 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405784AbfFKRGY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 11 Jun 2019 13:06:24 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5BH2hLx122279
        for <linux-efi@vger.kernel.org>; Tue, 11 Jun 2019 13:06:23 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t2favu9jx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Tue, 11 Jun 2019 13:06:23 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <nayna@linux.ibm.com>;
        Tue, 11 Jun 2019 18:06:21 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 11 Jun 2019 18:06:17 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5BH68RR33292564
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 17:06:08 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A088911C04A;
        Tue, 11 Jun 2019 17:06:15 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DC5D11C058;
        Tue, 11 Jun 2019 17:06:13 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.80.199.191])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 11 Jun 2019 17:06:12 +0000 (GMT)
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
Subject: [PATCH v4 1/3] powerpc/powernv: Add OPAL API interface to get secureboot state
Date:   Tue, 11 Jun 2019 13:06:03 -0400
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1560272765-5768-1-git-send-email-nayna@linux.ibm.com>
References: <1560272765-5768-1-git-send-email-nayna@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19061117-0016-0000-0000-000002883096
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061117-0017-0000-0000-000032E5608B
Message-Id: <1560272765-5768-2-git-send-email-nayna@linux.ibm.com>
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

From: Claudio Carvalho <cclaudio@linux.ibm.com>

The X.509 certificates trusted by the platform and other information
required to secure boot the OS kernel are wrapped in secure variables,
which are controlled by OPAL.

This patch adds support to read OPAL secure variables through
OPAL_SECVAR_GET call. It returns the metadata and data for a given secure
variable based on the unique key.

Since OPAL can support different types of backend which can vary in the
variable interpretation, a new OPAL API call named OPAL_SECVAR_BACKEND, is
added to retrieve the supported backend version. This helps the consumer
to know how to interpret the variable.

This support can be enabled using CONFIG_OPAL_SECVAR

Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
This patch depends on a new OPAL call that is being added to skiboot.
The patch set that implements the new call has been posted to
https://patchwork.ozlabs.org/project/skiboot/list/?series=112868

 arch/powerpc/include/asm/opal-api.h          |  4 +-
 arch/powerpc/include/asm/opal-secvar.h       | 23 ++++++
 arch/powerpc/include/asm/opal.h              |  6 ++
 arch/powerpc/platforms/powernv/Kconfig       |  6 ++
 arch/powerpc/platforms/powernv/Makefile      |  1 +
 arch/powerpc/platforms/powernv/opal-call.c   |  2 +
 arch/powerpc/platforms/powernv/opal-secvar.c | 85 ++++++++++++++++++++
 7 files changed, 126 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/include/asm/opal-secvar.h
 create mode 100644 arch/powerpc/platforms/powernv/opal-secvar.c

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index e1577cfa7186..a505e669b4b6 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -212,7 +212,9 @@
 #define OPAL_HANDLE_HMI2			166
 #define	OPAL_NX_COPROC_INIT			167
 #define OPAL_XIVE_GET_VP_STATE			170
-#define OPAL_LAST				170
+#define OPAL_SECVAR_GET                         173
+#define OPAL_SECVAR_BACKEND                     177
+#define OPAL_LAST				177
 
 #define QUIESCE_HOLD			1 /* Spin all calls at entry */
 #define QUIESCE_REJECT			2 /* Fail all calls with OPAL_BUSY */
diff --git a/arch/powerpc/include/asm/opal-secvar.h b/arch/powerpc/include/asm/opal-secvar.h
new file mode 100644
index 000000000000..b677171a0368
--- /dev/null
+++ b/arch/powerpc/include/asm/opal-secvar.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PowerNV definitions for secure variables OPAL API.
+ *
+ * Copyright (C) 2019 IBM Corporation
+ * Author: Claudio Carvalho <cclaudio@linux.ibm.com>
+ *
+ */
+#ifndef OPAL_SECVAR_H
+#define OPAL_SECVAR_H
+
+enum {
+	BACKEND_NONE = 0,
+	BACKEND_TC_COMPAT_V1,
+};
+
+extern int opal_get_variable(u8 *key, unsigned long ksize,
+			     u8 *metadata, unsigned long *mdsize,
+			     u8 *data, unsigned long *dsize);
+
+extern int opal_variable_version(unsigned long *backend);
+
+#endif
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 4cc37e708bc7..57d2c2356eda 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -394,6 +394,12 @@ void opal_powercap_init(void);
 void opal_psr_init(void);
 void opal_sensor_groups_init(void);
 
+extern int opal_secvar_get(uint64_t k_key, uint64_t k_key_len,
+			   uint64_t k_metadata, uint64_t k_metadata_size,
+			   uint64_t k_data, uint64_t k_data_size);
+
+extern int opal_secvar_backend(uint64_t k_backend);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_OPAL_H */
diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
index 850eee860cf2..65b060539b5c 100644
--- a/arch/powerpc/platforms/powernv/Kconfig
+++ b/arch/powerpc/platforms/powernv/Kconfig
@@ -47,3 +47,9 @@ config PPC_VAS
 	  VAS adapters are found in POWER9 based systems.
 
 	  If unsure, say N.
+
+config OPAL_SECVAR
+	bool "OPAL Secure Variables"
+	depends on PPC_POWERNV
+	help
+	  This enables the kernel to access OPAL secure variables.
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index da2e99efbd04..6651c742e530 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -16,3 +16,4 @@ obj-$(CONFIG_PERF_EVENTS) += opal-imc.o
 obj-$(CONFIG_PPC_MEMTRACE)	+= memtrace.o
 obj-$(CONFIG_PPC_VAS)	+= vas.o vas-window.o vas-debug.o
 obj-$(CONFIG_OCXL_BASE)	+= ocxl.o
+obj-$(CONFIG_OPAL_SECVAR) += opal-secvar.o
diff --git a/arch/powerpc/platforms/powernv/opal-call.c b/arch/powerpc/platforms/powernv/opal-call.c
index 36c8fa3647a2..0445980f294f 100644
--- a/arch/powerpc/platforms/powernv/opal-call.c
+++ b/arch/powerpc/platforms/powernv/opal-call.c
@@ -288,3 +288,5 @@ OPAL_CALL(opal_pci_set_pbcq_tunnel_bar,		OPAL_PCI_SET_PBCQ_TUNNEL_BAR);
 OPAL_CALL(opal_sensor_read_u64,			OPAL_SENSOR_READ_U64);
 OPAL_CALL(opal_sensor_group_enable,		OPAL_SENSOR_GROUP_ENABLE);
 OPAL_CALL(opal_nx_coproc_init,			OPAL_NX_COPROC_INIT);
+OPAL_CALL(opal_secvar_get,                      OPAL_SECVAR_GET);
+OPAL_CALL(opal_secvar_backend,                  OPAL_SECVAR_BACKEND);
diff --git a/arch/powerpc/platforms/powernv/opal-secvar.c b/arch/powerpc/platforms/powernv/opal-secvar.c
new file mode 100644
index 000000000000..dba441dd5af1
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-secvar.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PowerNV code for secure variables
+ *
+ * Copyright (C) 2019 IBM Corporation
+ * Author: Claudio Carvalho <cclaudio@linux.ibm.com>
+ *
+ */
+
+/*
+ * The opal wrappers in this file treat the @name, @vendor, and @data
+ * parameters as little endian blobs.
+ * @name is a ucs2 string
+ * @vendor is the vendor GUID. It is converted to LE in the kernel
+ * @data variable data, which layout may be different for each variable
+ */
+
+#define pr_fmt(fmt) "secvar: "fmt
+
+#include <linux/types.h>
+#include <asm/opal.h>
+#include <asm/opal-secvar.h>
+
+static bool is_opal_secvar_supported(void)
+{
+	static bool opal_secvar_supported;
+	static bool initialized;
+
+	if (initialized)
+		return opal_secvar_supported;
+
+	if (!opal_check_token(OPAL_SECVAR_GET)
+	    || !opal_check_token(OPAL_SECVAR_BACKEND)) {
+		pr_err("OPAL doesn't support secure variables\n");
+		opal_secvar_supported = false;
+	} else {
+		opal_secvar_supported = true;
+	}
+
+	initialized = true;
+
+	return opal_secvar_supported;
+}
+
+int opal_get_variable(u8 *key, unsigned long ksize, u8 *metadata,
+		      unsigned long *mdsize, u8 *data, unsigned long *dsize)
+{
+	int rc;
+
+	if (!is_opal_secvar_supported())
+		return OPAL_UNSUPPORTED;
+
+	if (mdsize)
+		*mdsize = cpu_to_be64(*mdsize);
+	if (dsize)
+		*dsize = cpu_to_be64(*dsize);
+
+	rc = opal_secvar_get(__pa(key), ksize, __pa(metadata), __pa(mdsize),
+			     __pa(data), __pa(dsize));
+
+	if (mdsize)
+		*mdsize = be64_to_cpu(*mdsize);
+	if (dsize)
+		*dsize = be64_to_cpu(*dsize);
+
+	return rc;
+}
+
+int opal_variable_version(unsigned long *backend)
+{
+	int rc;
+
+	if (!is_opal_secvar_supported())
+		return OPAL_UNSUPPORTED;
+
+	if (backend)
+		*backend = cpu_to_be64(*backend);
+
+	rc = opal_secvar_backend(__pa(backend));
+
+	if (backend)
+		*backend = be64_to_cpu(*backend);
+
+	return rc;
+}
-- 
2.20.1

