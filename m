Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD936F89B7
	for <lists+linux-efi@lfdr.de>; Fri,  5 May 2023 21:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbjEEToe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 May 2023 15:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233467AbjEETod (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 5 May 2023 15:44:33 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC112112;
        Fri,  5 May 2023 12:44:31 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345JZ2Fx030579;
        Fri, 5 May 2023 19:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Rv5VSU7ygmQR5zUYKc4NzVg9cPjw3mc4U3K3rd95/90=;
 b=QifIIhP9+2vny35smkVE5zdQUY06czD3uh2dTj2NLEPI3TbEr8CncTfIRxaTwKpC5KE1
 1daLPE4cRDIuywCVGcAc5l7LvvJXjQUwyMgoykCRjDOJsC9YNYWLFKC5VOHDgi/t1lJ6
 q8TKzB02PHbqzmri8bCBOaz2/yRQscbwVVvRcut2YiKCXKS+2qWGzg2ffg0IOmecxZbe
 5eHYOUH5cH4w74Cg1StLkojf2bjaLe1FpucjoyreZWUFghNNad8/bVKV/mQMoNsBqbO0
 bK2Kq9fptlVq+ptOwl2zL0g7dknc6WTfnre4AolEUiXK7wI3c540occWM+0g5Gf5RBQq Lw== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qd658ujbf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 May 2023 19:44:13 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 345HBh7Z003454;
        Fri, 5 May 2023 19:44:12 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([9.208.129.117])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3q8tv8r5ma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 May 2023 19:44:12 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 345JiBkd1114788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 May 2023 19:44:11 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1367258043;
        Fri,  5 May 2023 19:44:11 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C30FB58055;
        Fri,  5 May 2023 19:44:09 +0000 (GMT)
Received: from rhel-laptop.ibm.com.com (unknown [9.160.1.159])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  5 May 2023 19:44:09 +0000 (GMT)
From:   gjoyce@linux.vnet.ibm.com
To:     linux-block@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, jonathan.derrick@linux.dev,
        brking@linux.vnet.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au,
        axboe@kernel.dk, akpm@linux-foundation.org,
        gjoyce@linux.vnet.ibm.com, linux-efi@vger.kernel.org,
        keyrings@vger.kernel.org, me@benboeckel.net, elliott@hpe.com,
        andonnel@au1.ibm.com
Subject: [PATCH 4/4] powerpc/pseries: update SED for PLPKS api changes
Date:   Fri,  5 May 2023 14:44:02 -0500
Message-Id: <20230505194402.2079010-5-gjoyce@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230505194402.2079010-1-gjoyce@linux.vnet.ibm.com>
References: <20230505194402.2079010-1-gjoyce@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vxStIMBmyH44MPqhKmUCxaLzQ6Uf0VYM
X-Proofpoint-ORIG-GUID: vxStIMBmyH44MPqhKmUCxaLzQ6Uf0VYM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_25,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050156
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Greg Joyce <gjoyce@linux.vnet.ibm.com>

Changes to the PLPKS API require minor updates to the SED Opal
PLPKS keystore code.

Signed-off-by: Greg Joyce <gjoyce@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/Kconfig        |  6 +++++
 arch/powerpc/platforms/pseries/Makefile       |  2 +-
 .../powerpc/platforms/pseries/plpks_sed_ops.c | 22 +++++--------------
 block/Kconfig                                 |  1 +
 4 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index 21b22bf16ce6..c2f8a29e7b9b 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -163,6 +163,12 @@ config PSERIES_PLPKS
 	# This option is selected by in-kernel consumers that require
 	# access to the PKS.
 
+config PSERIES_PLPKS_SED
+	depends on PPC_PSERIES
+	bool
+	# This option is selected by in-kernel consumers that require
+	# access to the SED PKS keystore.
+
 config PAPR_SCM
 	depends on PPC_PSERIES && MEMORY_HOTPLUG && LIBNVDIMM
 	tristate "Support for the PAPR Storage Class Memory interface"
diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index 4242aed0d5d3..1476c5e4433c 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -29,7 +29,7 @@ obj-$(CONFIG_PPC_SVM)		+= svm.o
 obj-$(CONFIG_FA_DUMP)		+= rtas-fadump.o
 obj-$(CONFIG_PSERIES_PLPKS)	+= plpks.o
 obj-$(CONFIG_PPC_SECURE_BOOT)	+= plpks-secvar.o
-obj-$(CONFIG_PSERIES_PLPKS_SED)	+= plpks-sed.o
+obj-$(CONFIG_PSERIES_PLPKS_SED)	+= plpks_sed_ops.o
 obj-$(CONFIG_SUSPEND)		+= suspend.o
 obj-$(CONFIG_PPC_VAS)		+= vas.o vas-sysfs.o
 
diff --git a/arch/powerpc/platforms/pseries/plpks_sed_ops.c b/arch/powerpc/platforms/pseries/plpks_sed_ops.c
index 086934b319a9..c1d08075e850 100644
--- a/arch/powerpc/platforms/pseries/plpks_sed_ops.c
+++ b/arch/powerpc/platforms/pseries/plpks_sed_ops.c
@@ -14,7 +14,7 @@
 #include <linux/string.h>
 #include <linux/ioctl.h>
 #include <linux/sed-opal-key.h>
-#include "plpks.h"
+#include <asm/plpks.h>
 
 /*
  * structure that contains all SED data
@@ -28,9 +28,6 @@ struct plpks_sed_object_data {
 	u_char key[32];
 };
 
-#define PLPKS_PLATVAR_POLICY            WORLDREADABLE
-#define PLPKS_PLATVAR_OS_COMMON         4
-
 #define PLPKS_SED_OBJECT_DATA_V0        0
 #define PLPKS_SED_MANGLED_LABEL         "/default/pri"
 #define PLPKS_SED_COMPONENT             "sed-opal"
@@ -50,8 +47,8 @@ void plpks_init_var(struct plpks_var *var, char *keyname)
 		var->name = PLPKS_SED_MANGLED_LABEL;
 		var->namelen = strlen(keyname);
 	}
-	var->policy = PLPKS_PLATVAR_POLICY;
-	var->os = PLPKS_PLATVAR_OS_COMMON;
+	var->policy = PLPKS_WORLDREADABLE;
+	var->os = PLPKS_VAR_COMMON;
 	var->data = NULL;
 	var->datalen = 0;
 	var->component = PLPKS_SED_COMPONENT;
@@ -64,28 +61,19 @@ int sed_read_key(char *keyname, char *key, u_int *keylen)
 {
 	struct plpks_var var;
 	struct plpks_sed_object_data data;
-	u_int offset;
 	int ret;
 	u_int len;
 
 	plpks_init_var(&var, keyname);
-	var.data = &data;
+	var.data = (u8 *)&data;
 	var.datalen = sizeof(data);
 
 	ret = plpks_read_os_var(&var);
 	if (ret != 0)
 		return ret;
 
-	offset = offsetof(struct plpks_sed_object_data, key);
-	if (offset > var.datalen) {
-		return -EINVAL;
-	}
-
-	len = min(be32_to_cpu(data.key_len), *keylen);
-
+	len = min_t(u16, be32_to_cpu(data.key_len), var.datalen);
 	memcpy(key, data.key, len);
-	kfree(var.data);
-
 	key[len] = '\0';
 	*keylen = len;
 
diff --git a/block/Kconfig b/block/Kconfig
index 76b23114fdeb..75d4db34df5a 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -182,6 +182,7 @@ config BLK_SED_OPAL
 	bool "Logic for interfacing with Opal enabled SEDs"
 	depends on KEYS
 	select PSERIES_PLPKS if PPC_PSERIES
+	select PSERIES_PLPKS_SED if PPC_PSERIES
 	help
 	Builds Logic for interfacing with Opal enabled controllers.
 	Enabling this option enables users to setup/unlock/lock
-- 
gjoyce@linux.vnet.ibm.com

