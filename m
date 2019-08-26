Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBFFD9D05F
	for <lists+linux-efi@lfdr.de>; Mon, 26 Aug 2019 15:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732329AbfHZNYQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 26 Aug 2019 09:24:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7088 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732275AbfHZNYE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 26 Aug 2019 09:24:04 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7QDMI0h057461
        for <linux-efi@vger.kernel.org>; Mon, 26 Aug 2019 09:24:02 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2umehxcajg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Mon, 26 Aug 2019 09:24:01 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <nayna@linux.ibm.com>;
        Mon, 26 Aug 2019 14:24:00 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 26 Aug 2019 14:23:56 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7QDNsQ933751120
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Aug 2019 13:23:54 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CBEF4204D;
        Mon, 26 Aug 2019 13:23:54 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD31E42045;
        Mon, 26 Aug 2019 13:23:51 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.85.199.141])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 26 Aug 2019 13:23:51 +0000 (GMT)
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
Subject: [PATCH v3 1/4] powerpc/powernv: Add OPAL API interface to access secure variable
Date:   Mon, 26 Aug 2019 09:23:35 -0400
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1566825818-9731-1-git-send-email-nayna@linux.ibm.com>
References: <1566825818-9731-1-git-send-email-nayna@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19082613-0008-0000-0000-0000030D7C21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082613-0009-0000-0000-00004A2BB4BC
Message-Id: <1566825818-9731-2-git-send-email-nayna@linux.ibm.com>
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

The X.509 certificates trusted by the platform and required to secure boot
the OS kernel are wrapped in secure variables, which are controlled by
OPAL.

This patch adds firmware/kernel interface to read and write OPAL secure
variables based on the unique key.

This support can be enabled using CONFIG_OPAL_SECVAR.

Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 arch/powerpc/include/asm/opal-api.h          |   5 +-
 arch/powerpc/include/asm/opal.h              |   7 +-
 arch/powerpc/include/asm/powernv.h           |   2 +
 arch/powerpc/include/asm/secvar.h            |  35 +++++
 arch/powerpc/kernel/Makefile                 |   2 +-
 arch/powerpc/kernel/secvar-ops.c             |  19 +++
 arch/powerpc/platforms/powernv/Kconfig       |   6 +
 arch/powerpc/platforms/powernv/Makefile      |   1 +
 arch/powerpc/platforms/powernv/opal-call.c   |   3 +
 arch/powerpc/platforms/powernv/opal-secvar.c | 138 +++++++++++++++++++
 arch/powerpc/platforms/powernv/opal.c        |   5 +
 11 files changed, 220 insertions(+), 3 deletions(-)
 create mode 100644 arch/powerpc/include/asm/secvar.h
 create mode 100644 arch/powerpc/kernel/secvar-ops.c
 create mode 100644 arch/powerpc/platforms/powernv/opal-secvar.c

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 383242eb0dea..b238b4f26c5b 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -208,7 +208,10 @@
 #define OPAL_HANDLE_HMI2			166
 #define	OPAL_NX_COPROC_INIT			167
 #define OPAL_XIVE_GET_VP_STATE			170
-#define OPAL_LAST				170
+#define OPAL_SECVAR_GET                         173
+#define OPAL_SECVAR_GET_NEXT                    174
+#define OPAL_SECVAR_ENQUEUE_UPDATE              175
+#define OPAL_LAST                               175
 
 #define QUIESCE_HOLD			1 /* Spin all calls at entry */
 #define QUIESCE_REJECT			2 /* Fail all calls with OPAL_BUSY */
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 57bd029c715e..0606b1d22db4 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -296,7 +296,11 @@ int opal_set_power_shift_ratio(u32 handle, int token, u32 psr);
 int opal_sensor_group_clear(u32 group_hndl, int token);
 int opal_sensor_group_enable(u32 group_hndl, int token, bool enable);
 int opal_nx_coproc_init(uint32_t chip_id, uint32_t ct);
-
+int opal_secvar_get(const char *key, uint64_t key_len, u8 *data,
+		    uint64_t *data_size);
+int opal_secvar_get_next(const char *key, uint64_t *key_len, uint64_t key_size);
+int opal_secvar_enqueue_update(const char *key, uint64_t key_len, u8 *data,
+			       uint64_t data_size);
 s64 opal_signal_system_reset(s32 cpu);
 s64 opal_quiesce(u64 shutdown_type, s32 cpu);
 
@@ -387,6 +391,7 @@ void opal_wake_poller(void);
 void opal_powercap_init(void);
 void opal_psr_init(void);
 void opal_sensor_groups_init(void);
+void opal_secvar_init(void);
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/powerpc/include/asm/powernv.h b/arch/powerpc/include/asm/powernv.h
index e1a858718716..cff980a85dd2 100644
--- a/arch/powerpc/include/asm/powernv.h
+++ b/arch/powerpc/include/asm/powernv.h
@@ -12,10 +12,12 @@ extern void powernv_set_nmmu_ptcr(unsigned long ptcr);
 void pnv_program_cpu_hotplug_lpcr(unsigned int cpu, u64 lpcr_val);
 
 void pnv_tm_init(void);
+
 #else
 static inline void powernv_set_nmmu_ptcr(unsigned long ptcr) { }
 
 static inline void pnv_tm_init(void) { }
+
 #endif
 
 #endif /* _ASM_POWERNV_H */
diff --git a/arch/powerpc/include/asm/secvar.h b/arch/powerpc/include/asm/secvar.h
new file mode 100644
index 000000000000..f27655cb5db8
--- /dev/null
+++ b/arch/powerpc/include/asm/secvar.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 IBM Corporation
+ * Author: Nayna Jain <nayna@linux.ibm.com>
+ *
+ * PowerPC secure variable operations.
+ */
+#ifndef SECVAR_OPS_H
+#define SECVAR_OPS_H
+
+#include <linux/types.h>
+#include <linux/errno.h>
+
+extern const struct secvar_operations *secvar_ops;
+
+struct secvar_operations {
+	int (*get)(const char *key, uint64_t key_len, u8 *data,
+		   uint64_t *data_size);
+	int (*get_next)(const char *key, uint64_t *key_len,
+			uint64_t keysize);
+	int (*set)(const char *key, uint64_t key_len, u8 *data,
+		   uint64_t data_size);
+};
+
+#ifdef CONFIG_PPC_SECURE_BOOT
+
+extern void set_secvar_ops(const struct secvar_operations *ops);
+
+#else
+
+static inline void set_secvar_ops(const struct secvar_operations *ops) { }
+
+#endif
+
+#endif
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 520b1c814197..9041563f1c74 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -157,7 +157,7 @@ endif
 obj-$(CONFIG_EPAPR_PARAVIRT)	+= epapr_paravirt.o epapr_hcalls.o
 obj-$(CONFIG_KVM_GUEST)		+= kvm.o kvm_emul.o
 
-obj-$(CONFIG_PPC_SECURE_BOOT)	+= secboot.o ima_arch.o
+obj-$(CONFIG_PPC_SECURE_BOOT)	+= secboot.o ima_arch.o secvar-ops.o
 
 # Disable GCOV, KCOV & sanitizers in odd or sensitive code
 GCOV_PROFILE_prom_init.o := n
diff --git a/arch/powerpc/kernel/secvar-ops.c b/arch/powerpc/kernel/secvar-ops.c
new file mode 100644
index 000000000000..e067bc0c2336
--- /dev/null
+++ b/arch/powerpc/kernel/secvar-ops.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 IBM Corporation
+ * Author: Nayna Jain <nayna@linux.ibm.com>
+ *
+ * This file initializes secvar operations for PowerPC Secureboot
+ */
+
+#include <stddef.h>
+#include <asm/secvar.h>
+
+const struct secvar_operations *secvar_ops;
+
+void set_secvar_ops(const struct secvar_operations *ops)
+{
+	if (!ops)
+		secvar_ops = NULL;
+	secvar_ops = ops;
+}
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
index 29ca523c1c79..93106e867924 100644
--- a/arch/powerpc/platforms/powernv/opal-call.c
+++ b/arch/powerpc/platforms/powernv/opal-call.c
@@ -287,3 +287,6 @@ OPAL_CALL(opal_pci_set_pbcq_tunnel_bar,		OPAL_PCI_SET_PBCQ_TUNNEL_BAR);
 OPAL_CALL(opal_sensor_read_u64,			OPAL_SENSOR_READ_U64);
 OPAL_CALL(opal_sensor_group_enable,		OPAL_SENSOR_GROUP_ENABLE);
 OPAL_CALL(opal_nx_coproc_init,			OPAL_NX_COPROC_INIT);
+OPAL_CALL(opal_secvar_get,                     OPAL_SECVAR_GET);
+OPAL_CALL(opal_secvar_get_next,                 OPAL_SECVAR_GET_NEXT);
+OPAL_CALL(opal_secvar_enqueue_update,           OPAL_SECVAR_ENQUEUE_UPDATE);
diff --git a/arch/powerpc/platforms/powernv/opal-secvar.c b/arch/powerpc/platforms/powernv/opal-secvar.c
new file mode 100644
index 000000000000..6682013fb10b
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-secvar.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PowerNV code for secure variables
+ *
+ * Copyright (C) 2019 IBM Corporation
+ * Author: Claudio Carvalho <cclaudio@linux.ibm.com>
+ *         Nayna Jain <nayna@linux.ibm.com>
+ *
+ * APIs to access secure variables managed by OPAL.
+ *
+ */
+
+#define pr_fmt(fmt) "secvar: "fmt
+
+#include <linux/types.h>
+#include <asm/opal.h>
+#include <asm/secvar.h>
+#include <asm/secboot.h>
+
+static int opal_status_to_err(int rc)
+{
+	int err;
+
+	switch (rc) {
+	case OPAL_SUCCESS:
+		err = 0;
+		break;
+	case OPAL_UNSUPPORTED:
+		err = -ENXIO;
+		break;
+	case OPAL_PARAMETER:
+		err = -EINVAL;
+		break;
+	case OPAL_RESOURCE:
+		err = -ENOSPC;
+		break;
+	case OPAL_HARDWARE:
+		err = -EIO;
+		break;
+	case OPAL_NO_MEM:
+		err = -ENOMEM;
+		break;
+	case OPAL_EMPTY:
+		err = -ENOENT;
+		break;
+	case OPAL_PARTIAL:
+		err = -EFBIG;
+		break;
+	default:
+		err = -EINVAL;
+	}
+
+	return err;
+}
+
+static bool is_opal_secvar_supported(void)
+{
+	static bool opal_secvar_supported;
+	static bool initialized;
+
+	if (initialized)
+		return opal_secvar_supported;
+
+	if (!is_powerpc_secvar_supported()) {
+		opal_secvar_supported = false;
+		goto out;
+	}
+
+	if (!opal_check_token(OPAL_SECVAR_GET)
+			|| !opal_check_token(OPAL_SECVAR_GET_NEXT)
+			|| !opal_check_token(OPAL_SECVAR_ENQUEUE_UPDATE)) {
+		pr_err("OPAL doesn't support secure variables\n");
+		opal_secvar_supported = false;
+	} else {
+		opal_secvar_supported = true;
+	}
+
+out:
+	initialized = true;
+
+	return opal_secvar_supported;
+}
+
+static int opal_get_variable(const char *key, uint64_t ksize,
+			     u8 *data, uint64_t *dsize)
+{
+	int rc;
+
+	if (dsize)
+		*dsize = cpu_to_be64(*dsize);
+
+	rc = opal_secvar_get(key, ksize, data, dsize);
+
+	if (dsize)
+		*dsize = be64_to_cpu(*dsize);
+
+	return opal_status_to_err(rc);
+}
+
+static int opal_get_next_variable(const char *key, uint64_t *keylen,
+				  uint64_t keysize)
+{
+	int rc;
+
+	if (keylen)
+		*keylen = cpu_to_be64(*keylen);
+
+	rc = opal_secvar_get_next(key, keylen, keysize);
+
+	if (keylen)
+		*keylen = be64_to_cpu(*keylen);
+
+	return opal_status_to_err(rc);
+}
+
+static int opal_set_variable(const char *key, uint64_t ksize, u8 *data,
+			     uint64_t dsize)
+{
+	int rc;
+
+	rc = opal_secvar_enqueue_update(key, ksize, data, dsize);
+
+	return opal_status_to_err(rc);
+}
+
+static const struct secvar_operations opal_secvar_ops = {
+	.get = opal_get_variable,
+	.get_next = opal_get_next_variable,
+	.set = opal_set_variable,
+};
+
+void opal_secvar_init(void)
+{
+	if (!is_opal_secvar_supported())
+		set_secvar_ops(NULL);
+
+	set_secvar_ops(&opal_secvar_ops);
+}
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index aba443be7daa..3226961d451a 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -32,6 +32,8 @@
 #include <asm/mce.h>
 #include <asm/imc-pmu.h>
 #include <asm/bug.h>
+#include <asm/secvar.h>
+#include <asm/secboot.h>
 
 #include "powernv.h"
 
@@ -988,6 +990,9 @@ static int __init opal_init(void)
 	/* Initialise OPAL Power control interface */
 	opal_power_control_init();
 
+	/* Initialize OPAL secure variables */
+	opal_secvar_init();
+
 	return 0;
 }
 machine_subsys_initcall(powernv, opal_init);
-- 
2.20.1

