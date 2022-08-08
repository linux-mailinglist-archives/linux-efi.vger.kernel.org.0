Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254D658CB6F
	for <lists+linux-efi@lfdr.de>; Mon,  8 Aug 2022 17:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbiHHPoJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 8 Aug 2022 11:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235852AbiHHPoH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 8 Aug 2022 11:44:07 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC82010C2;
        Mon,  8 Aug 2022 08:44:06 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 278Fd9jb024060;
        Mon, 8 Aug 2022 15:43:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4vO33KM9Kg2lQ/XR0IrQu6Dhh3R1NiWTNIKnWvbRKBI=;
 b=UjhwfRU/yF90T78/3JfBWsCb8coJwr377p9XHOab6jfKXgE69+he3krBAiV8iOlNUbPX
 7vXvue+Ykq+C6SLZHKJgvNK/Dut0bwaPJwWEH0U84PmV5N0FM2CGkH6mG+jmpMZ4c+5R
 rxaH6OKpwNIP2GrjRt7fDmHl6Sa2QSshsAgT4vvQGgp7n5ev/wfipDAL6/ldBX218c1/
 tsGagKhC3qGpn0bPqgNI8A/FFAHdUUIkZMhWwVYcQ3+TW+G2PkyzeqeZ2When+3YkRor
 /WUiQnC1RDFvVWAnFSPeoKBBzW7RJfPjeltPYRtm5mQCYdYuS8a5R8TFs+yjQnuHDqfc dA== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hu48fawet-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 15:43:53 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 278FZpVS014626;
        Mon, 8 Aug 2022 15:43:53 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04dal.us.ibm.com with ESMTP id 3hsfx98rgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 15:43:52 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 278FhpQU33423822
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Aug 2022 15:43:52 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E16C27805E;
        Mon,  8 Aug 2022 15:43:51 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 857A778067;
        Mon,  8 Aug 2022 15:43:50 +0000 (GMT)
Received: from rhel-laptop.ibm.com.com (unknown [9.160.34.213])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  8 Aug 2022 15:43:50 +0000 (GMT)
From:   gjoyce@linux.vnet.ibm.com
To:     linux-block@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, jonathan.derrick@linux.dev,
        brking@linux.vnet.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au,
        nayna@linux.ibm.com, axboe@kernel.dk, akpm@linux-foundation.org,
        gjoyce@linux.vnet.ibm.com, linux-efi@vger.kernel.org,
        keyrings@vger.kernel.org
Subject: [PATCH v3a 2/2] powerpc/pseries: Override lib/arch_vars.c functions
Date:   Mon,  8 Aug 2022 10:43:45 -0500
Message-Id: <20220808154345.11240-3-gjoyce@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220808154345.11240-1-gjoyce@linux.vnet.ibm.com>
References: <20220808154345.11240-1-gjoyce@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: x3Mw2vB0hgJ4LR6g2Ez-ea2ha6KH1oWB
X-Proofpoint-ORIG-GUID: x3Mw2vB0hgJ4LR6g2Ez-ea2ha6KH1oWB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_10,2022-08-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208080075
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Greg Joyce <gjoyce@linux.vnet.ibm.com>

Self Encrypting Drives(SED) make use of POWER LPAR Platform KeyStore
for storing its variables. Thus the block subsystem needs to access
PowerPC specific functions to read/write objects in PLPKS.

Override the default implementations in lib/arch_vars.c file with
PowerPC specific versions.

Signed-off-by: Greg Joyce <gjoyce@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/Makefile       |   1 +
 .../platforms/pseries/plpks_arch_ops.c        | 167 ++++++++++++++++++
 2 files changed, 168 insertions(+)
 create mode 100644 arch/powerpc/platforms/pseries/plpks_arch_ops.c

diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index 14e143b946a3..3a545422eae5 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_PPC_SPLPAR)	+= vphn.o
 obj-$(CONFIG_PPC_SVM)		+= svm.o
 obj-$(CONFIG_FA_DUMP)		+= rtas-fadump.o
 obj-$(CONFIG_PSERIES_PLPKS) += plpks.o
+obj-$(CONFIG_PSERIES_PLPKS) += plpks_arch_ops.o
 
 obj-$(CONFIG_SUSPEND)		+= suspend.o
 obj-$(CONFIG_PPC_VAS)		+= vas.o vas-sysfs.o
diff --git a/arch/powerpc/platforms/pseries/plpks_arch_ops.c b/arch/powerpc/platforms/pseries/plpks_arch_ops.c
new file mode 100644
index 000000000000..fdea3322f696
--- /dev/null
+++ b/arch/powerpc/platforms/pseries/plpks_arch_ops.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * POWER Platform arch specific code for SED
+ * Copyright (C) 2022 IBM Corporation
+ *
+ * Define operations for generic kernel subsystems to read/write keys
+ * from POWER LPAR Platform KeyStore(PLPKS).
+ *
+ * List of subsystems/usecase using PLPKS:
+ * - Self Encrypting Drives(SED)
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/ioctl.h>
+#include <uapi/linux/sed-opal.h>
+#include <linux/sed-opal.h>
+#include <linux/arch_vars.h>
+#include "plpks.h"
+
+/*
+ * variable structure that contains all SED data
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
+/*
+ * ext_type values
+ *     00        no extension exists
+ *     01-1F     common
+ *     20-3F     AIX
+ *     40-5F     Linux
+ *     60-7F     IBMi
+ */
+
+/*
+ * This extension is optional for version 1 sed_object_data
+ */
+struct sed_object_extension {
+	u8 ext_type;
+	u8 rsvd[3];
+	u8 ext_data[64];
+};
+
+#define PKS_SED_OBJECT_DATA_V1          1
+#define PKS_SED_MANGLED_LABEL           "/default/pri"
+#define PLPKS_SED_COMPONENT             "sed-opal"
+
+#define PLPKS_ARCHVAR_POLICY            WORLDREADABLE
+#define PLPKS_ARCHVAR_OS_COMMON         4
+
+/*
+ * Read the variable data from PKS given the label
+ */
+int arch_read_variable(enum arch_variable_type type, char *varname,
+		       void *varbuf, u_int *varlen)
+{
+	struct plpks_var var;
+	struct plpks_sed_object_data *data;
+	u_int offset = 0;
+	char *buf = (char *)varbuf;
+	int ret;
+
+	var.name = varname;
+	var.namelen = strlen(varname);
+	var.policy = PLPKS_ARCHVAR_POLICY;
+	var.os = PLPKS_ARCHVAR_OS_COMMON;
+	var.data = NULL;
+	var.datalen = 0;
+
+	switch (type) {
+	case ARCH_VAR_OPAL_KEY:
+		var.component = PLPKS_SED_COMPONENT;
+#ifdef OPAL_AUTH_KEY
+		if (strcmp(OPAL_AUTH_KEY, varname) == 0) {
+			var.name = PKS_SED_MANGLED_LABEL;
+			var.namelen = strlen(varname);
+		}
+#endif
+		offset = offsetof(struct plpks_sed_object_data, key);
+		break;
+	case ARCH_VAR_OTHER:
+		var.component = "";
+		break;
+	}
+
+	ret = plpks_read_os_var(&var);
+	if (ret != 0)
+		return ret;
+
+	if (offset > var.datalen)
+		offset = 0;
+
+	switch (type) {
+	case ARCH_VAR_OPAL_KEY:
+		data = (struct plpks_sed_object_data *)var.data;
+		*varlen = data->key_len;
+		break;
+	case ARCH_VAR_OTHER:
+		*varlen = var.datalen;
+		break;
+	}
+
+	if (var.data) {
+		memcpy(varbuf, var.data + offset, var.datalen - offset);
+		buf[*varlen] = '\0';
+		kfree(var.data);
+	}
+
+	return 0;
+}
+
+/*
+ * Write the variable data to PKS given the label
+ */
+int arch_write_variable(enum arch_variable_type type, char *varname,
+			void *varbuf, u_int varlen)
+{
+	struct plpks_var var;
+	struct plpks_sed_object_data data;
+	struct plpks_var_name vname;
+
+	var.name = varname;
+	var.namelen = strlen(varname);
+	var.policy = PLPKS_ARCHVAR_POLICY;
+	var.os = PLPKS_ARCHVAR_OS_COMMON;
+	var.datalen = varlen;
+	var.data = varbuf;
+
+	switch (type) {
+	case ARCH_VAR_OPAL_KEY:
+		var.component = PLPKS_SED_COMPONENT;
+#ifdef OPAL_AUTH_KEY
+		if (strcmp(OPAL_AUTH_KEY, varname) == 0) {
+			var.name = PKS_SED_MANGLED_LABEL;
+			var.namelen = strlen(varname);
+		}
+#endif
+		var.datalen = sizeof(struct plpks_sed_object_data);
+		var.data = (u8 *)&data;
+
+		/* initialize SED object */
+		data.version = PKS_SED_OBJECT_DATA_V1;
+		data.authority = 0;
+		data.range = 0;
+		data.key_len = varlen;
+		memcpy(data.key, varbuf, varlen);
+		break;
+	case ARCH_VAR_OTHER:
+		var.component = "";
+		break;
+	}
+
+	/* variable update requires delete first */
+	vname.namelen = var.namelen;
+	vname.name = var.name;
+	(void)plpks_remove_var(var.component, var.os, vname);
+
+	return plpks_write_var(var);
+}
-- 
2.27.0

