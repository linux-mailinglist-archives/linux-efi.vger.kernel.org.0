Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B7F4C6AFB
	for <lists+linux-efi@lfdr.de>; Mon, 28 Feb 2022 12:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbiB1LoO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 28 Feb 2022 06:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbiB1LoN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 28 Feb 2022 06:44:13 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F6C40E55;
        Mon, 28 Feb 2022 03:43:33 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21SAfrsK020403;
        Mon, 28 Feb 2022 11:43:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Ok3ZaZP/oB2vsIbjkE6+h9sRPe3kQ5CyzPWNvmHNzH4=;
 b=OynJqDxdzb3sX9hFI9xjoT/ahP/eGmlhdVezXZ89mZIXDtvuy3YVl/ZtMWPBRVUdJPbr
 pPfIOIVhNCBU/rXtlb3BPq97ehfj4Uq1Io0QPfUanfcGfoXXHE/ZIEo9X6pLV+8M3gBn
 pz5NxlXkjLbL61vVufGEzHOUtcS010Nuk6NDzmCpg8uUk583llu565pWVYEfNQEgvUFN
 qM/UVHIY6bQf30KU6OSlieZiJNLqxauGMn8kxaftoDRqrKtp+Od+MFVCTaRnviTSrO+O
 zY91+FfRtsqo5lQEa+K60lvWT+bVZ03zCozg4WEsPZxgJLF554yfk1QFlI89hF0gKFIA bQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3egvv31cqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Feb 2022 11:43:02 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21SBeXNA004451;
        Mon, 28 Feb 2022 11:43:01 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3egvv31cpu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Feb 2022 11:43:01 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21SBXFYR017381;
        Mon, 28 Feb 2022 11:43:00 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma04wdc.us.ibm.com with ESMTP id 3eftrr5ecs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Feb 2022 11:43:00 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21SBgxR949545578
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 11:42:59 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CAD7D112069;
        Mon, 28 Feb 2022 11:42:59 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76D5B112065;
        Mon, 28 Feb 2022 11:42:59 +0000 (GMT)
Received: from amdrome3.watson.ibm.com (unknown [9.2.130.16])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 28 Feb 2022 11:42:59 +0000 (GMT)
From:   Dov Murik <dovmurik@linux.ibm.com>
To:     linux-efi@vger.kernel.org
Cc:     Dov Murik <dovmurik@linux.ibm.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Borislav Petkov <bp@suse.de>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Scull <ascull@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 3/4] efi: Load efi_secret module if EFI secret area is populated
Date:   Mon, 28 Feb 2022 11:42:53 +0000
Message-Id: <20220228114254.1099945-4-dovmurik@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228114254.1099945-1-dovmurik@linux.ibm.com>
References: <20220228114254.1099945-1-dovmurik@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nJrzFN_5PBpfMKMln7jGNbeNQeyV1KbM
X-Proofpoint-ORIG-GUID: H5xjocaR_gG7EoBgvZiwLn4IltjyvG9o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-28_04,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 mlxlogscore=999 malwarescore=0 suspectscore=0
 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202280065
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

If the efi_secret module is built, register a late_initcall in the EFI
driver which checks whether the EFI secret area is available and
populated, and then requests to load the efi_secret module.

This will cause the <securityfs>/secrets/coco directory to appear in
guests into which secrets were injected; in other cases, the module is
not loaded.

Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/firmware/efi/Makefile        |  1 +
 drivers/firmware/efi/coco.c          | 58 ++++++++++++++++++++
 drivers/virt/coco/efi_secret/Kconfig |  3 +
 3 files changed, 62 insertions(+)

diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index c02ff25dd477..49c4a8c0bfc4 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_APPLE_PROPERTIES)		+= apple-properties.o
 obj-$(CONFIG_EFI_RCI2_TABLE)		+= rci2-table.o
 obj-$(CONFIG_EFI_EMBEDDED_FIRMWARE)	+= embedded-firmware.o
 obj-$(CONFIG_LOAD_UEFI_KEYS)		+= mokvar-table.o
+obj-$(CONFIG_EFI_COCO_SECRET)		+= coco.o
 
 fake_map-y				+= fake_mem.o
 fake_map-$(CONFIG_X86)			+= x86_fake_mem.o
diff --git a/drivers/firmware/efi/coco.c b/drivers/firmware/efi/coco.c
new file mode 100644
index 000000000000..f8efd240ab05
--- /dev/null
+++ b/drivers/firmware/efi/coco.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Confidential computing (coco) secret area handling
+ *
+ * Copyright (C) 2021 IBM Corporation
+ * Author: Dov Murik <dovmurik@linux.ibm.com>
+ */
+
+#define pr_fmt(fmt) "efi: " fmt
+
+#include <linux/efi.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kmod.h>
+
+#ifdef CONFIG_EFI_SECRET_MODULE
+
+/*
+ * Load the efi_secret module if the EFI secret area is populated
+ */
+static int __init load_efi_secret_module(void)
+{
+	struct linux_efi_coco_secret_area *area;
+	efi_guid_t *header_guid;
+	int ret = 0;
+
+	if (efi.coco_secret == EFI_INVALID_TABLE_ADDR)
+		return 0;
+
+	area = memremap(efi.coco_secret, sizeof(*area), MEMREMAP_WB);
+	if (!area) {
+		pr_err("Failed to map confidential computing secret area descriptor\n");
+		return -ENOMEM;
+	}
+	if (!area->base_pa || area->size < sizeof(*header_guid))
+		goto unmap_desc;
+
+	header_guid = (void __force *)ioremap_encrypted(area->base_pa, sizeof(*header_guid));
+	if (!header_guid) {
+		pr_err("Failed to map secret area\n");
+		ret = -ENOMEM;
+		goto unmap_desc;
+	}
+	if (efi_guidcmp(*header_guid, EFI_SECRET_TABLE_HEADER_GUID))
+		goto unmap_encrypted;
+
+	ret = request_module("efi_secret");
+
+unmap_encrypted:
+	iounmap((void __iomem *)header_guid);
+
+unmap_desc:
+	memunmap(area);
+	return ret;
+}
+late_initcall(load_efi_secret_module);
+
+#endif
diff --git a/drivers/virt/coco/efi_secret/Kconfig b/drivers/virt/coco/efi_secret/Kconfig
index 4404d198f3b2..dc8da2921e36 100644
--- a/drivers/virt/coco/efi_secret/Kconfig
+++ b/drivers/virt/coco/efi_secret/Kconfig
@@ -14,3 +14,6 @@ config EFI_SECRET
 
 	  To compile this driver as a module, choose M here.
 	  The module will be called efi_secret.
+
+	  The module is loaded automatically by the EFI driver if the EFI
+	  secret area is populated.
-- 
2.25.1

