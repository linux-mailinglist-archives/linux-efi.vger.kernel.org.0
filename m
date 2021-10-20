Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D74D434505
	for <lists+linux-efi@lfdr.de>; Wed, 20 Oct 2021 08:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhJTGR6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Oct 2021 02:17:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26580 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229715AbhJTGR5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 Oct 2021 02:17:57 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19K5bgfP012274;
        Wed, 20 Oct 2021 02:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=wo4RR46GqPhMajXCZvxidPEu4/ZcF6n8psKbCv75GrY=;
 b=KAAul2i84zZgu9PHe0IzBoV8iKUPPoE4X02eBYWJz4FHdu5l5tYHVRBoBGodynSkilQQ
 adzEyPperEEizp5+rpvL6Ox/7WvuS2+cIRgUhyv8I0Z7iYdKv7Au/+0UOx5OMiiSK+H0
 9GyUgGt1F6t2kkRvX/cfyRAK9SPTfPwke2g6Vf+CbY2I/7MyofptJix5tO6VrAS2JKmq
 6B2ViHIyTJ6nbsxSY26BLo/z1TaMClYQdjtRbhPSIULHPw4RxEYz9umcs5HiQ4fGObyE
 V37Fc+HrWHPGCcyXIa/aliKRR/QbI5eJCQFgzO4/lihU5hU6zTg0nfCqxmJMth39G6Dz ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bt7436wjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 02:14:26 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19K6EQw0000374;
        Wed, 20 Oct 2021 02:14:26 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bt7436wjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 02:14:26 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19K6DUGl002519;
        Wed, 20 Oct 2021 06:14:25 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03dal.us.ibm.com with ESMTP id 3bqpcbqdsj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 06:14:25 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19K6EN8j30671104
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 06:14:23 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A643AC066;
        Wed, 20 Oct 2021 06:14:23 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C43FAC062;
        Wed, 20 Oct 2021 06:14:23 +0000 (GMT)
Received: from amdrome3.watson.ibm.com (unknown [9.2.130.16])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 20 Oct 2021 06:14:23 +0000 (GMT)
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
Subject: [PATCH v4 2/3] efi: Reserve confidential computing secret area
Date:   Wed, 20 Oct 2021 06:14:07 +0000
Message-Id: <20211020061408.3447533-3-dovmurik@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211020061408.3447533-1-dovmurik@linux.ibm.com>
References: <20211020061408.3447533-1-dovmurik@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eqwqk01esOBrCctG2dGOrlifna1xpmVe
X-Proofpoint-GUID: 3EJsY_6fhb51TQA8_Mt_2rYi4lYMLrYY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-20_02,2021-10-19_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110200032
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When efi-stub copies an EFI-provided confidential computing (coco)
secret area, reserve that memory block for future use within the kernel.

Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>
---
 arch/x86/platform/efi/efi.c   |  3 +++
 drivers/firmware/efi/Makefile |  1 +
 drivers/firmware/efi/coco.c   | 41 +++++++++++++++++++++++++++++++++++
 drivers/firmware/efi/efi.c    |  8 +++++++
 include/linux/efi.h           | 10 +++++++++
 5 files changed, 63 insertions(+)
 create mode 100644 drivers/firmware/efi/coco.c

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 147c30a81f15..1591d67e0bcd 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -93,6 +93,9 @@ static const unsigned long * const efi_tables[] = {
 #ifdef CONFIG_LOAD_UEFI_KEYS
 	&efi.mokvar_table,
 #endif
+#ifdef CONFIG_EFI_COCO_SECRET
+	&efi.coco_secret,
+#endif
 };
 
 u64 efi_setup;		/* efi setup_data physical address */
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
index 000000000000..42f477d6188c
--- /dev/null
+++ b/drivers/firmware/efi/coco.c
@@ -0,0 +1,41 @@
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
+#include <linux/memblock.h>
+#include <asm/early_ioremap.h>
+
+/*
+ * Reserve the confidential computing secret area memory
+ */
+int __init efi_coco_secret_area_reserve(void)
+{
+	struct linux_efi_coco_secret_area *secret_area;
+	unsigned long secret_area_size;
+
+	if (efi.coco_secret == EFI_INVALID_TABLE_ADDR)
+		return 0;
+
+	secret_area = early_memremap(efi.coco_secret, sizeof(*secret_area));
+	if (!secret_area) {
+		pr_err("Failed to map confidential computing secret area\n");
+		efi.coco_secret = EFI_INVALID_TABLE_ADDR;
+		return -ENOMEM;
+	}
+
+	secret_area_size = sizeof(*secret_area) + secret_area->size;
+	memblock_reserve(efi.coco_secret, secret_area_size);
+
+	pr_info("Reserved memory of EFI-provided confidential computing secret area");
+
+	early_memunmap(secret_area, sizeof(*secret_area));
+	return 0;
+}
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 847f33ffc4ae..31bdae2afc47 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -46,6 +46,9 @@ struct efi __read_mostly efi = {
 #ifdef CONFIG_LOAD_UEFI_KEYS
 	.mokvar_table		= EFI_INVALID_TABLE_ADDR,
 #endif
+#ifdef CONFIG_EFI_COCO_SECRET
+	.coco_secret		= EFI_INVALID_TABLE_ADDR,
+#endif
 };
 EXPORT_SYMBOL(efi);
 
@@ -525,6 +528,9 @@ static const efi_config_table_type_t common_tables[] __initconst = {
 #endif
 #ifdef CONFIG_LOAD_UEFI_KEYS
 	{LINUX_EFI_MOK_VARIABLE_TABLE_GUID,	&efi.mokvar_table,	"MOKvar"	},
+#endif
+#ifdef CONFIG_EFI_COCO_SECRET
+	{LINUX_EFI_COCO_SECRET_AREA_GUID,	&efi.coco_secret,	"CocoSecret"	},
 #endif
 	{},
 };
@@ -613,6 +619,8 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
 
 	efi_tpm_eventlog_init();
 
+	efi_coco_secret_area_reserve();
+
 	if (mem_reserve != EFI_INVALID_TABLE_ADDR) {
 		unsigned long prsv = mem_reserve;
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 9021dd521302..6e57dd083e25 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -550,6 +550,7 @@ extern struct efi {
 	unsigned long			tpm_log;		/* TPM2 Event Log table */
 	unsigned long			tpm_final_log;		/* TPM2 Final Events Log table */
 	unsigned long			mokvar_table;		/* MOK variable config table */
+	unsigned long			coco_secret;		/* Confidential computing secret table */
 
 	efi_get_time_t			*get_time;
 	efi_set_time_t			*set_time;
@@ -1288,4 +1289,13 @@ struct linux_efi_coco_secret_area {
 	u8	area[];
 };
 
+#ifdef CONFIG_EFI_COCO_SECRET
+extern int efi_coco_secret_area_reserve(void);
+#else
+static inline int efi_coco_secret_area_reserve(void)
+{
+	return 0;
+}
+#endif
+
 #endif /* _LINUX_EFI_H */
-- 
2.25.1

