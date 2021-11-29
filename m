Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5107646140C
	for <lists+linux-efi@lfdr.de>; Mon, 29 Nov 2021 12:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238525AbhK2Lsq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 29 Nov 2021 06:48:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45758 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235717AbhK2Lqq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 29 Nov 2021 06:46:46 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATBFYDP001515;
        Mon, 29 Nov 2021 11:43:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=mIYzRuO7LvXm0r/YjJvj8zXWEHXksOAcpjzZMQASRg4=;
 b=Zwrs4QboPJ2QlV61kC3KXr3tg6ndnaZXXawLttRK9YwzzyYLB/P0VzYVoyKvc3YRjX1P
 lmw0R72jlPEOrj/PTukHraQ8XKAfJ5KvTJgG4oRH/O9VvdBY41XKiUk9BNWWBnh3oiag
 p7UJFMcWIbpkqYUFyILBopbJOOiwdhCBybm9wF0IsP+zxYTU9PEpk9A5MdHoPtNr+qXS
 netp4Gh4e76Be17JFHXg7HsPR9lX35rfwuWhomVrld261UPvYgwxPXeyKLvxDl0Ctk7Q
 kIgaRQ+2f6fMOSnGXQ4qB53JRgtTTlyjFSA3Q/i4GAhjRa1dtauHzyMEEqxaKjqOPMYz qg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cmwu50m4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 11:43:07 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1ATBLLgB023171;
        Mon, 29 Nov 2021 11:43:06 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cmwu50m3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 11:43:05 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1ATBY5LW015073;
        Mon, 29 Nov 2021 11:43:04 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma05wdc.us.ibm.com with ESMTP id 3ckca9yded-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 11:43:04 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1ATBh1L734931050
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 11:43:01 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F692124069;
        Mon, 29 Nov 2021 11:43:01 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BDAE012405B;
        Mon, 29 Nov 2021 11:43:00 +0000 (GMT)
Received: from amdrome3.watson.ibm.com (unknown [9.2.130.16])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 29 Nov 2021 11:43:00 +0000 (GMT)
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
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/5] efi: Load efi_secret module if EFI secret area is populated
Date:   Mon, 29 Nov 2021 11:42:50 +0000
Message-Id: <20211129114251.3741721-5-dovmurik@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211129114251.3741721-1-dovmurik@linux.ibm.com>
References: <20211129114251.3741721-1-dovmurik@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3vPTbit5rA4g2mpeIvK6B77Q0YY_AIOt
X-Proofpoint-GUID: y9WMW21SbCLKBNYjq75xLwrZdkq_tDbw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-29_07,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 malwarescore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111290058
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
index 000000000000..9885ab75e12f
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
+	header_guid = ioremap_encrypted(area->base_pa, sizeof(*header_guid));
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
+	iounmap(header_guid);
+
+unmap_desc:
+	memunmap(area);
+	return ret;
+}
+late_initcall(load_efi_secret_module);
+
+#endif
diff --git a/drivers/virt/coco/efi_secret/Kconfig b/drivers/virt/coco/efi_secret/Kconfig
index be363ed48f24..06a32613815e 100644
--- a/drivers/virt/coco/efi_secret/Kconfig
+++ b/drivers/virt/coco/efi_secret/Kconfig
@@ -9,3 +9,6 @@ config EFI_SECRET
 
 	  To compile this driver as a module, choose M here.
 	  The module will be called efi_secret.
+
+	  The module is loaded automatically by the EFI driver if the EFI
+	  secret area is populated.
-- 
2.25.1

