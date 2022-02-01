Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110BE4A5C78
	for <lists+linux-efi@lfdr.de>; Tue,  1 Feb 2022 13:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238182AbiBAMpG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Feb 2022 07:45:06 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11582 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238177AbiBAMpD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Feb 2022 07:45:03 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 211CdUvb017127;
        Tue, 1 Feb 2022 12:44:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=iTV4qKEjdbDa6WSM4yM7pSW2xXxTF8i676FiAx/YLIY=;
 b=mwqGE5HLeTShArrroKwJ4CnGnbWWaqZr6NxNR4ym2C1xL3uyaNHqwIfaXgtUzcLjGlHx
 F4sx29/DliBJ/gTA1cy9dlgllfCVJwId966U6Zx/PZmRxKnnltSOXLVsr2M61TbDJLoY
 CQ4e80xV2a8TTSpODvX231KF5NRY+28jFJa4jX2I3Pjrh6nQzdmOqoJQxF1aTxxilypw
 XsvnZc8/RvvmmdzQ2JHTmvkkNxeH9OQFRmDpwH4seKErqxio/BAfNauH9PdW4ZLm2mf7
 GwsvWfuRHxMlMmWaRisWd7eqd+teho6dPfDjJc8I2Mqt1Ujf8nFolValZQlaFZKki+qR Dg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dxj34e0f2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 12:44:52 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 211CfA3v026077;
        Tue, 1 Feb 2022 12:44:52 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dxj34e0ej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 12:44:51 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 211Ccs66014529;
        Tue, 1 Feb 2022 12:44:50 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma03wdc.us.ibm.com with ESMTP id 3dvw7afq7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 12:44:50 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 211Cimdh18350378
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Feb 2022 12:44:48 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EBEF4BE063;
        Tue,  1 Feb 2022 12:44:47 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C808BE05A;
        Tue,  1 Feb 2022 12:44:46 +0000 (GMT)
Received: from amdrome3.watson.ibm.com (unknown [9.2.130.16])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  1 Feb 2022 12:44:46 +0000 (GMT)
From:   Dov Murik <dovmurik@linux.ibm.com>
To:     linux-efi@vger.kernel.org
Cc:     Dov Murik <dovmurik@linux.ibm.com>, Borislav Petkov <bp@suse.de>,
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
        Gerd Hoffmann <kraxel@redhat.com>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 4/5] efi: Load efi_secret module if EFI secret area is populated
Date:   Tue,  1 Feb 2022 12:44:12 +0000
Message-Id: <20220201124413.1093099-5-dovmurik@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220201124413.1093099-1-dovmurik@linux.ibm.com>
References: <20220201124413.1093099-1-dovmurik@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zCHGyvBGKkltewj3n9q9_4j5UELREzLL
X-Proofpoint-GUID: A8VY6Klct7kjbqf0XX0m0eGBZ_nh5CWa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_03,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202010068
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

If the efi_secret module is built, register a late_initcall in the EFI
driver which checks whether the EFI secret area is available and
populated, and then requests to load the efi_secret module.

This will cause the <securityfs>/coco/efi_secret directory to appear in
guests into which secrets were injected; in other cases, the module is
not loaded.

Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>
---
 drivers/firmware/efi/Makefile        |  1 +
 drivers/firmware/efi/coco.c          | 58 ++++++++++++++++++++++++++++
 drivers/virt/coco/efi_secret/Kconfig |  3 ++
 3 files changed, 62 insertions(+)
 create mode 100644 drivers/firmware/efi/coco.c

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
index ed181797ed86..068fdd1fccd7 100644
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

