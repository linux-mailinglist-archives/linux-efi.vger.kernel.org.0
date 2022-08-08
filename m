Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9C258CB73
	for <lists+linux-efi@lfdr.de>; Mon,  8 Aug 2022 17:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235852AbiHHPoJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 8 Aug 2022 11:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238062AbiHHPoH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 8 Aug 2022 11:44:07 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024C82BCB;
        Mon,  8 Aug 2022 08:44:06 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 278EnZYQ024030;
        Mon, 8 Aug 2022 15:43:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=vCkjYYMr8qi+Dx9V5Urxb8UXElS0dbRq92qE6ZnPnaE=;
 b=V/zuB6j7JbxrQX/EQlMfEBUCyYbhdRKQ3Oen+m3kKrnc2BP2VT63Kwi+CwOPVswnhvLC
 57ZKFRKdG0tzqW94IkgXCNvn69kmXhyyKV0rtPxm2gNM4tIzaMnF0bOxSWpf2ZY8o+Wa
 REc1/SffV1JZ7wiVKV8exEHtckG1NhJaHeVVpL84iziRCT53EQ3AozvGuAZVqKd2ewZa
 G7DxtgaxTtECnYaSr3EhYox7zQnCXVoCFVpo4kJm1+HHEvKpeweW4nxxPEwfTWRxhPwv
 gH8NuZxu2S064q/6VYcqIQfejk3EvxvLai4JUeSWKmsTbpQMsI9mPjkJk61VT/5Nv+ib qQ== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hu4kf9t3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 15:43:52 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 278FZqlK014644;
        Mon, 8 Aug 2022 15:43:51 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma04dal.us.ibm.com with ESMTP id 3hsfx98rgk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 15:43:51 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 278FhoqD15663370
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Aug 2022 15:43:50 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CDD278063;
        Mon,  8 Aug 2022 15:43:50 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD42078060;
        Mon,  8 Aug 2022 15:43:48 +0000 (GMT)
Received: from rhel-laptop.ibm.com.com (unknown [9.160.34.213])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  8 Aug 2022 15:43:48 +0000 (GMT)
From:   gjoyce@linux.vnet.ibm.com
To:     linux-block@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, jonathan.derrick@linux.dev,
        brking@linux.vnet.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au,
        nayna@linux.ibm.com, axboe@kernel.dk, akpm@linux-foundation.org,
        gjoyce@linux.vnet.ibm.com, linux-efi@vger.kernel.org,
        keyrings@vger.kernel.org
Subject: [PATCH v3a 1/2] lib: generic accessor functions for arch keystore
Date:   Mon,  8 Aug 2022 10:43:44 -0500
Message-Id: <20220808154345.11240-2-gjoyce@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220808154345.11240-1-gjoyce@linux.vnet.ibm.com>
References: <20220808154345.11240-1-gjoyce@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3jKGgdTabMg7G_nunuX-UgB3NGt8eIGU
X-Proofpoint-GUID: 3jKGgdTabMg7G_nunuX-UgB3NGt8eIGU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_10,2022-08-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 spamscore=0 suspectscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Generic kernel subsystems may rely on platform specific persistent
KeyStore to store objects containing sensitive key material. In such case,
they need to access architecture specific functions to perform read/write
operations on these variables.

Define the generic variable read/write prototypes to be implemented by
architecture specific versions. The default(weak) implementations of
these prototypes return -EOPNOTSUPP unless overridden by architecture
versions.

Signed-off-by: Greg Joyce <gjoyce@linux.vnet.ibm.com>
---
 include/linux/arch_vars.h | 23 +++++++++++++++++++++++
 lib/Makefile              |  2 +-
 lib/arch_vars.c           | 25 +++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/arch_vars.h
 create mode 100644 lib/arch_vars.c

diff --git a/include/linux/arch_vars.h b/include/linux/arch_vars.h
new file mode 100644
index 000000000000..9c280ff9432e
--- /dev/null
+++ b/include/linux/arch_vars.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Platform variable opearations.
+ *
+ * Copyright (C) 2022 IBM Corporation
+ *
+ * These are the accessor functions (read/write) for architecture specific
+ * variables. Specific architectures can provide overrides.
+ *
+ */
+
+#include <linux/kernel.h>
+
+enum arch_variable_type {
+	ARCH_VAR_OPAL_KEY      = 0,     /* SED Opal Authentication Key */
+	ARCH_VAR_OTHER         = 1,     /* Other type of variable */
+	ARCH_VAR_MAX           = 1,     /* Maximum type value */
+};
+
+int arch_read_variable(enum arch_variable_type type, char *varname,
+		       void *varbuf, u_int *varlen);
+int arch_write_variable(enum arch_variable_type type, char *varname,
+			void *varbuf, u_int varlen);
diff --git a/lib/Makefile b/lib/Makefile
index f99bf61f8bbc..b90c4cb0dbbb 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -48,7 +48,7 @@ obj-y += bcd.o sort.o parser.o debug_locks.o random32.o \
 	 bsearch.o find_bit.o llist.o memweight.o kfifo.o \
 	 percpu-refcount.o rhashtable.o \
 	 once.o refcount.o usercopy.o errseq.o bucket_locks.o \
-	 generic-radix-tree.o
+	 generic-radix-tree.o arch_vars.o
 obj-$(CONFIG_STRING_SELFTEST) += test_string.o
 obj-y += string_helpers.o
 obj-$(CONFIG_TEST_STRING_HELPERS) += test-string_helpers.o
diff --git a/lib/arch_vars.c b/lib/arch_vars.c
new file mode 100644
index 000000000000..e6f16d7d09c1
--- /dev/null
+++ b/lib/arch_vars.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Platform variable operations.
+ *
+ * Copyright (C) 2022 IBM Corporation
+ *
+ * These are the accessor functions (read/write) for architecture specific
+ * variables. Specific architectures can provide overrides.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/arch_vars.h>
+
+int __weak arch_read_variable(enum arch_variable_type type, char *varname,
+			      void *varbuf, u_int *varlen)
+{
+	return -EOPNOTSUPP;
+}
+
+int __weak arch_write_variable(enum arch_variable_type type, char *varname,
+			       void *varbuf, u_int varlen)
+{
+	return -EOPNOTSUPP;
+}
-- 
2.27.0

