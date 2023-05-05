Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D795D6F89BD
	for <lists+linux-efi@lfdr.de>; Fri,  5 May 2023 21:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbjEETpI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 May 2023 15:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbjEETpH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 5 May 2023 15:45:07 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC35E4A;
        Fri,  5 May 2023 12:45:05 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345JgwOo003497;
        Fri, 5 May 2023 19:44:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=rvN03YZ7rSocVoRSnHhsR4/yEXvY1KusYZCCiUe4D8I=;
 b=KzKJyWCefCrY6J8bIp3G5BDs3fmnJfX6L8XQxGjWEM/p7+2YA7QQAs79556KXQ7Z2qE8
 XjDIWVKyoO8zSCFtaIruKI1+2McOMYiRS2KH6ROMNbPJy3+2CuJQFQLnqMN41JcuZVoo
 ZUIjP2dCRu1YmX+/otDqms/hl43aDAeiwzq4Nsc1t1OXYOR2v/soZWfYqjjEc5aP2dOh
 Mr+E2XVPW1qbrVx65pdCxRGQIUbEo9HjWS7VTjJ8Zlw9DcW99VSMAXGN7m02bE18PBLf
 Nhy/GFnsfjiSQ/je7Oc3aJLMeXCmOz+vBLjQ3GXvKt/2tRIirLxCq4r83QpDYGl0sdUs 6Q== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qd86qr0wp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 May 2023 19:44:10 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 345JViQB006789;
        Fri, 5 May 2023 19:44:09 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3q8tv8r7et-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 May 2023 19:44:09 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 345Ji8mw8127168
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 May 2023 19:44:08 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31FA458059;
        Fri,  5 May 2023 19:44:08 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E24285805D;
        Fri,  5 May 2023 19:44:06 +0000 (GMT)
Received: from rhel-laptop.ibm.com.com (unknown [9.160.1.159])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  5 May 2023 19:44:06 +0000 (GMT)
From:   gjoyce@linux.vnet.ibm.com
To:     linux-block@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, jonathan.derrick@linux.dev,
        brking@linux.vnet.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au,
        axboe@kernel.dk, akpm@linux-foundation.org,
        gjoyce@linux.vnet.ibm.com, linux-efi@vger.kernel.org,
        keyrings@vger.kernel.org, me@benboeckel.net, elliott@hpe.com,
        andonnel@au1.ibm.com
Subject: [PATCH 2/4] powerpc/pseries: PLPKS SED Opal keystore support
Date:   Fri,  5 May 2023 14:44:00 -0500
Message-Id: <20230505194402.2079010-3-gjoyce@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230505194402.2079010-1-gjoyce@linux.vnet.ibm.com>
References: <20230505194402.2079010-1-gjoyce@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JKHsxi15qsHbOO7gGpFRGS7tWIFBgm7Z
X-Proofpoint-ORIG-GUID: JKHsxi15qsHbOO7gGpFRGS7tWIFBgm7Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_26,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050160
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Greg Joyce <gjoyce@linux.vnet.ibm.com>

Define operations for SED Opal to read/write keys
from POWER LPAR Platform KeyStore(PLPKS). This allows
non-volatile storage of SED Opal keys.

Signed-off-by: Greg Joyce <gjoyce@linux.vnet.ibm.com>
Reviewed-by: Jonathan Derrick <jonathan.derrick@linux.dev>
---
 arch/powerpc/platforms/pseries/Makefile       |   1 +
 .../powerpc/platforms/pseries/plpks_sed_ops.c | 126 ++++++++++++++++++
 2 files changed, 127 insertions(+)
 create mode 100644 arch/powerpc/platforms/pseries/plpks_sed_ops.c

diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index 53c3b91af2f7..4242aed0d5d3 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_PPC_SVM)		+= svm.o
 obj-$(CONFIG_FA_DUMP)		+= rtas-fadump.o
 obj-$(CONFIG_PSERIES_PLPKS)	+= plpks.o
 obj-$(CONFIG_PPC_SECURE_BOOT)	+= plpks-secvar.o
+obj-$(CONFIG_PSERIES_PLPKS_SED)	+= plpks-sed.o
 obj-$(CONFIG_SUSPEND)		+= suspend.o
 obj-$(CONFIG_PPC_VAS)		+= vas.o vas-sysfs.o
 
diff --git a/arch/powerpc/platforms/pseries/plpks_sed_ops.c b/arch/powerpc/platforms/pseries/plpks_sed_ops.c
new file mode 100644
index 000000000000..086934b319a9
--- /dev/null
+++ b/arch/powerpc/platforms/pseries/plpks_sed_ops.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * POWER Platform specific code for non-volatile SED key access
+ * Copyright (C) 2022 IBM Corporation
+ *
+ * Define operations for SED Opal to read/write keys
+ * from POWER LPAR Platform KeyStore(PLPKS).
+ *
+ * Self Encrypting Drives(SED) key storage using PLPKS
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/ioctl.h>
+#include <linux/sed-opal-key.h>
+#include "plpks.h"
+
+/*
+ * structure that contains all SED data
+ */
+struct plpks_sed_object_data {
+	u_char version;
+	u_char pad1[7];
+	u_long authority;
+	u_long range;
+	u_int  key_len;
+	u_char key[32];
+};
+
+#define PLPKS_PLATVAR_POLICY            WORLDREADABLE
+#define PLPKS_PLATVAR_OS_COMMON         4
+
+#define PLPKS_SED_OBJECT_DATA_V0        0
+#define PLPKS_SED_MANGLED_LABEL         "/default/pri"
+#define PLPKS_SED_COMPONENT             "sed-opal"
+#define PLPKS_SED_KEY                   "opal-boot-pin"
+
+/*
+ * authority is admin1 and range is global
+ */
+#define PLPKS_SED_AUTHORITY  0x0000000900010001
+#define PLPKS_SED_RANGE      0x0000080200000001
+
+void plpks_init_var(struct plpks_var *var, char *keyname)
+{
+	var->name = keyname;
+	var->namelen = strlen(keyname);
+	if (strcmp(PLPKS_SED_KEY, keyname) == 0) {
+		var->name = PLPKS_SED_MANGLED_LABEL;
+		var->namelen = strlen(keyname);
+	}
+	var->policy = PLPKS_PLATVAR_POLICY;
+	var->os = PLPKS_PLATVAR_OS_COMMON;
+	var->data = NULL;
+	var->datalen = 0;
+	var->component = PLPKS_SED_COMPONENT;
+}
+
+/*
+ * Read the SED Opal key from PLPKS given the label
+ */
+int sed_read_key(char *keyname, char *key, u_int *keylen)
+{
+	struct plpks_var var;
+	struct plpks_sed_object_data data;
+	u_int offset;
+	int ret;
+	u_int len;
+
+	plpks_init_var(&var, keyname);
+	var.data = &data;
+	var.datalen = sizeof(data);
+
+	ret = plpks_read_os_var(&var);
+	if (ret != 0)
+		return ret;
+
+	offset = offsetof(struct plpks_sed_object_data, key);
+	if (offset > var.datalen) {
+		return -EINVAL;
+	}
+
+	len = min(be32_to_cpu(data.key_len), *keylen);
+
+	memcpy(key, data.key, len);
+	kfree(var.data);
+
+	key[len] = '\0';
+	*keylen = len;
+
+	return 0;
+}
+
+/*
+ * Write the SED Opal key to PLPKS given the label
+ */
+int sed_write_key(char *keyname, char *key, u_int keylen)
+{
+	struct plpks_var var;
+	struct plpks_sed_object_data data;
+	struct plpks_var_name vname;
+
+	plpks_init_var(&var, keyname);
+
+	var.datalen = sizeof(struct plpks_sed_object_data);
+	var.data = (u8 *)&data;
+
+	/* initialize SED object */
+	data.version = PLPKS_SED_OBJECT_DATA_V0;
+	data.authority = cpu_to_be64(PLPKS_SED_AUTHORITY);
+	data.range = cpu_to_be64(PLPKS_SED_RANGE);
+	memset(&data.pad1, '\0', sizeof(data.pad1));
+	data.key_len = cpu_to_be32(keylen);
+	memcpy(data.key, (char *)key, keylen);
+
+	/*
+	 * Key update requires remove first. The return value
+	 * is ignored since it's okay if the key doesn't exist.
+	 */
+	vname.namelen = var.namelen;
+	vname.name = var.name;
+	plpks_remove_var(var.component, var.os, vname);
+
+	return plpks_write_var(var);
+}
-- 
gjoyce@linux.vnet.ibm.com

