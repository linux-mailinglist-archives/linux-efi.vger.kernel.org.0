Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC6F2E40B3
	for <lists+linux-efi@lfdr.de>; Fri, 25 Oct 2019 02:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388256AbfJYAru (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Oct 2019 20:47:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29824 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388239AbfJYAru (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Oct 2019 20:47:50 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9P0lRg3067512
        for <linux-efi@vger.kernel.org>; Thu, 24 Oct 2019 20:47:49 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vukqgw8p1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Thu, 24 Oct 2019 20:47:48 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <nayna@linux.ibm.com>;
        Fri, 25 Oct 2019 01:47:47 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 25 Oct 2019 01:47:42 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9P0leab50200816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Oct 2019 00:47:40 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DC9811C04A;
        Fri, 25 Oct 2019 00:47:40 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDBB111C064;
        Fri, 25 Oct 2019 00:47:37 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.40.192.65])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 25 Oct 2019 00:47:37 +0000 (GMT)
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
Subject: [PATCH v5 1/4] powerpc/powernv: Add OPAL API interface to access secure variable
Date:   Thu, 24 Oct 2019 19:47:26 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025004729.4452-1-nayna@linux.ibm.com>
References: <20191025004729.4452-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19102500-0028-0000-0000-000003AF2387
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102500-0029-0000-0000-0000247157B1
Message-Id: <20191025004729.4452-2-nayna@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-24_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910250007
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
 arch/powerpc/include/asm/opal.h              |   7 +
 arch/powerpc/include/asm/secvar.h            |  35 +++++
 arch/powerpc/kernel/Makefile                 |   2 +-
 arch/powerpc/kernel/secvar-ops.c             |  16 +++
 arch/powerpc/platforms/powernv/Makefile      |   2 +-
 arch/powerpc/platforms/powernv/opal-call.c   |   3 +
 arch/powerpc/platforms/powernv/opal-secvar.c | 140 +++++++++++++++++++
 arch/powerpc/platforms/powernv/opal.c        |   3 +
 9 files changed, 210 insertions(+), 3 deletions(-)
 create mode 100644 arch/powerpc/include/asm/secvar.h
 create mode 100644 arch/powerpc/kernel/secvar-ops.c
 create mode 100644 arch/powerpc/platforms/powernv/opal-secvar.c

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 378e3997845a..c1f25a760eb1 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -211,7 +211,10 @@
 #define OPAL_MPIPL_UPDATE			173
 #define OPAL_MPIPL_REGISTER_TAG			174
 #define OPAL_MPIPL_QUERY_TAG			175
-#define OPAL_LAST				175
+#define OPAL_SECVAR_GET				176
+#define OPAL_SECVAR_GET_NEXT			177
+#define OPAL_SECVAR_ENQUEUE_UPDATE		178
+#define OPAL_LAST				178
 
 #define QUIESCE_HOLD			1 /* Spin all calls at entry */
 #define QUIESCE_REJECT			2 /* Fail all calls with OPAL_BUSY */
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index a0cf8fba4d12..9986ac34b8e2 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -298,6 +298,13 @@ int opal_sensor_group_clear(u32 group_hndl, int token);
 int opal_sensor_group_enable(u32 group_hndl, int token, bool enable);
 int opal_nx_coproc_init(uint32_t chip_id, uint32_t ct);
 
+int opal_secvar_get(const char *key, uint64_t key_len, u8 *data,
+		    uint64_t *data_size);
+int opal_secvar_get_next(const char *key, uint64_t *key_len,
+			 uint64_t key_buf_size);
+int opal_secvar_enqueue_update(const char *key, uint64_t key_len, u8 *data,
+			       uint64_t data_size);
+
 s64 opal_mpipl_update(enum opal_mpipl_ops op, u64 src, u64 dest, u64 size);
 s64 opal_mpipl_register_tag(enum opal_mpipl_tags tag, u64 addr);
 s64 opal_mpipl_query_tag(enum opal_mpipl_tags tag, u64 *addr);
diff --git a/arch/powerpc/include/asm/secvar.h b/arch/powerpc/include/asm/secvar.h
new file mode 100644
index 000000000000..4cc35b58b986
--- /dev/null
+++ b/arch/powerpc/include/asm/secvar.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 IBM Corporation
+ * Author: Nayna Jain
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
+			uint64_t keybufsize);
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
index e8eb2955b7d5..3cf26427334f 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -161,7 +161,7 @@ ifneq ($(CONFIG_PPC_POWERNV)$(CONFIG_PPC_SVM),)
 obj-y				+= ucall.o
 endif
 
-obj-$(CONFIG_PPC_SECURE_BOOT)	+= secure_boot.o ima_arch.o
+obj-$(CONFIG_PPC_SECURE_BOOT)	+= secure_boot.o ima_arch.o secvar-ops.o
 
 # Disable GCOV, KCOV & sanitizers in odd or sensitive code
 GCOV_PROFILE_prom_init.o := n
diff --git a/arch/powerpc/kernel/secvar-ops.c b/arch/powerpc/kernel/secvar-ops.c
new file mode 100644
index 000000000000..4cfa7dbd8850
--- /dev/null
+++ b/arch/powerpc/kernel/secvar-ops.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 IBM Corporation
+ * Author: Nayna Jain
+ *
+ * This file initializes secvar operations for PowerPC Secureboot
+ */
+
+#include <asm/secvar.h>
+
+const struct secvar_operations *secvar_ops;
+
+void set_secvar_ops(const struct secvar_operations *ops)
+{
+	secvar_ops = ops;
+}
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index a3ac9646119d..f9c4fa99e8b9 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -4,7 +4,7 @@ obj-y			+= idle.o opal-rtc.o opal-nvram.o opal-lpc.o opal-flash.o
 obj-y			+= rng.o opal-elog.o opal-dump.o opal-sysparam.o opal-sensor.o
 obj-y			+= opal-msglog.o opal-hmi.o opal-power.o opal-irqchip.o
 obj-y			+= opal-kmsg.o opal-powercap.o opal-psr.o opal-sensor-groups.o
-obj-y			+= ultravisor.o
+obj-y			+= ultravisor.o opal-secvar.o
 
 obj-$(CONFIG_SMP)	+= smp.o subcore.o subcore-asm.o
 obj-$(CONFIG_FA_DUMP)	+= opal-fadump.o
diff --git a/arch/powerpc/platforms/powernv/opal-call.c b/arch/powerpc/platforms/powernv/opal-call.c
index a2aa5e433ac8..5cd0f52d258f 100644
--- a/arch/powerpc/platforms/powernv/opal-call.c
+++ b/arch/powerpc/platforms/powernv/opal-call.c
@@ -290,3 +290,6 @@ OPAL_CALL(opal_nx_coproc_init,			OPAL_NX_COPROC_INIT);
 OPAL_CALL(opal_mpipl_update,			OPAL_MPIPL_UPDATE);
 OPAL_CALL(opal_mpipl_register_tag,		OPAL_MPIPL_REGISTER_TAG);
 OPAL_CALL(opal_mpipl_query_tag,			OPAL_MPIPL_QUERY_TAG);
+OPAL_CALL(opal_secvar_get,			OPAL_SECVAR_GET);
+OPAL_CALL(opal_secvar_get_next,			OPAL_SECVAR_GET_NEXT);
+OPAL_CALL(opal_secvar_enqueue_update,		OPAL_SECVAR_ENQUEUE_UPDATE);
diff --git a/arch/powerpc/platforms/powernv/opal-secvar.c b/arch/powerpc/platforms/powernv/opal-secvar.c
new file mode 100644
index 000000000000..4cfb282a9feb
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-secvar.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PowerNV code for secure variables
+ *
+ * Copyright (C) 2019 IBM Corporation
+ * Author: Claudio Carvalho
+ *         Nayna Jain
+ *
+ * APIs to access secure variables managed by OPAL.
+ */
+
+#define pr_fmt(fmt) "secvar: "fmt
+
+#include <linux/types.h>
+#include <linux/platform_device.h>
+#include <linux/of_platform.h>
+#include <asm/opal.h>
+#include <asm/secvar.h>
+#include <asm/secure_boot.h>
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
+static int opal_get_variable(const char *key, uint64_t ksize,
+			     u8 *data, uint64_t *dsize)
+{
+	int rc;
+
+	if (!key || !dsize)
+		return -EINVAL;
+
+	*dsize = cpu_to_be64(*dsize);
+
+	rc = opal_secvar_get(key, ksize, data, dsize);
+
+	*dsize = be64_to_cpu(*dsize);
+
+	return opal_status_to_err(rc);
+}
+
+static int opal_get_next_variable(const char *key, uint64_t *keylen,
+				  uint64_t keybufsize)
+{
+	int rc;
+
+	if (!key || !keylen)
+		return -EINVAL;
+
+	*keylen = cpu_to_be64(*keylen);
+
+	rc = opal_secvar_get_next(key, keylen, keybufsize);
+
+	*keylen = be64_to_cpu(*keylen);
+
+	return opal_status_to_err(rc);
+}
+
+static int opal_set_variable(const char *key, uint64_t ksize, u8 *data,
+			     uint64_t dsize)
+{
+	int rc;
+
+	if (!key || !data)
+		return -EINVAL;
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
+static int opal_secvar_probe(struct platform_device *pdev)
+{
+	if (!opal_check_token(OPAL_SECVAR_GET)
+			|| !opal_check_token(OPAL_SECVAR_GET_NEXT)
+			|| !opal_check_token(OPAL_SECVAR_ENQUEUE_UPDATE)) {
+		pr_err("OPAL doesn't support secure variables\n");
+		return -ENODEV;
+	}
+
+	set_secvar_ops(&opal_secvar_ops);
+
+	return 0;
+}
+
+static const struct of_device_id opal_secvar_match[] = {
+	{ .compatible = "ibm,secvar-v1",},
+	{},
+};
+
+static struct platform_driver opal_secvar_driver = {
+	.driver = {
+		.name = "secvar",
+		.of_match_table = opal_secvar_match,
+	},
+};
+
+static int __init opal_secvar_init(void)
+{
+	return platform_driver_probe(&opal_secvar_driver, opal_secvar_probe);
+}
+device_initcall(opal_secvar_init);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 38e90270280b..8d1e45a8bdc2 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -1002,6 +1002,9 @@ static int __init opal_init(void)
 	/* Initialise OPAL Power control interface */
 	opal_power_control_init();
 
+	/* Initialize OPAL secure variables */
+	opal_pdev_init("ibm,secvar-v1");
+
 	return 0;
 }
 machine_subsys_initcall(powernv, opal_init);
-- 
2.20.1

