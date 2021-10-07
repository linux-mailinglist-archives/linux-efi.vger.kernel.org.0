Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6512C424D2E
	for <lists+linux-efi@lfdr.de>; Thu,  7 Oct 2021 08:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240240AbhJGGVD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 7 Oct 2021 02:21:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36662 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231797AbhJGGVC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 7 Oct 2021 02:21:02 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19766soG026300;
        Thu, 7 Oct 2021 02:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=42jey/J7MkoU4a7hbVMgG0u/fh44icbwRuYrZCzqWoE=;
 b=BsHkd3NmovE0xNUASjtmACNzQ+QnYTA68NY1HMghZdmOwwSho1FC+0Pbeb1NSJXycAsx
 rAkG21gLv+WPRv5kVDf6++khWcQ24s7jQuAL6vfpJHvJCzFYrcaBt7+g2Q+ADkCaPMBI
 Ej481iFlqOLCEMKKCW7+LIWqizbXwqJPeJU70/39lOvILu5cQfpsHwhsYBVKMUFUpCWz
 6Jkm8dMV1Fp0WN3+oy4Eco41yOVmstE6SKYQpzW5Ffw4hzMOiiSWZJA/RA5yHGmoPHWA
 udChiY3s/c0JVcU9/72/UX2uBHkomkHOB17IIoEMlht43WZAINW9E0/EFJfRI4p2ZyF7 3Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bhsgpaddm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Oct 2021 02:18:46 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1976BuQ1021710;
        Thu, 7 Oct 2021 02:18:45 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bhsgpadcv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Oct 2021 02:18:45 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1976HsY8032334;
        Thu, 7 Oct 2021 06:18:44 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma01wdc.us.ibm.com with ESMTP id 3bef2bsuey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Oct 2021 06:18:44 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1976IgPk53936470
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Oct 2021 06:18:42 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58B81AE062;
        Thu,  7 Oct 2021 06:18:42 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0721EAE063;
        Thu,  7 Oct 2021 06:18:42 +0000 (GMT)
Received: from amdrome3.watson.ibm.com (unknown [9.2.130.16])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  7 Oct 2021 06:18:41 +0000 (GMT)
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
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] efi: Reserve confidential computing secret area
Date:   Thu,  7 Oct 2021 06:18:37 +0000
Message-Id: <20211007061838.1381129-4-dovmurik@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211007061838.1381129-1-dovmurik@linux.ibm.com>
References: <20211007061838.1381129-1-dovmurik@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hZ96oJHV3vQGjRymjLpIbmcL8kOMJltl
X-Proofpoint-ORIG-GUID: n3XjYuVTlvd4cF0KPusrhhj-yEbMPyTd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-06_04,2021-10-07_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110070039
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When efi-stub copies an EFI-provided confidential computing (coco)
secret area, reserve that memory block for future use within the kernel.

Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>
---
 arch/x86/platform/efi/efi.c   |  1 +
 drivers/firmware/efi/Makefile |  2 +-
 drivers/firmware/efi/coco.c   | 41 +++++++++++++++++++++++++++++++++++
 drivers/firmware/efi/efi.c    |  3 +++
 include/linux/efi.h           |  3 +++
 5 files changed, 49 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/efi/coco.c

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 147c30a81f15..35e082e5f603 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -93,6 +93,7 @@ static const unsigned long * const efi_tables[] = {
 #ifdef CONFIG_LOAD_UEFI_KEYS
 	&efi.mokvar_table,
 #endif
+	&efi.coco_secret,
 };
 
 u64 efi_setup;		/* efi setup_data physical address */
diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index c02ff25dd477..bfd35294703e 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -12,7 +12,7 @@ KASAN_SANITIZE_runtime-wrappers.o	:= n
 
 obj-$(CONFIG_ACPI_BGRT) 		+= efi-bgrt.o
 obj-$(CONFIG_EFI)			+= efi.o vars.o reboot.o memattr.o tpm.o
-obj-$(CONFIG_EFI)			+= memmap.o
+obj-$(CONFIG_EFI)			+= memmap.o coco.o
 ifneq ($(CONFIG_EFI_CAPSULE_LOADER),)
 obj-$(CONFIG_EFI)			+= capsule.o
 endif
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
index 847f33ffc4ae..07e17ad225a6 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -526,6 +526,7 @@ static const efi_config_table_type_t common_tables[] __initconst = {
 #ifdef CONFIG_LOAD_UEFI_KEYS
 	{LINUX_EFI_MOK_VARIABLE_TABLE_GUID,	&efi.mokvar_table,	"MOKvar"	},
 #endif
+	{LINUX_EFI_COCO_SECRET_AREA_GUID,	&efi.coco_secret,	"CocoSecret"	},
 	{},
 };
 
@@ -613,6 +614,8 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
 
 	efi_tpm_eventlog_init();
 
+	efi_coco_secret_area_reserve();
+
 	if (mem_reserve != EFI_INVALID_TABLE_ADDR) {
 		unsigned long prsv = mem_reserve;
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 9021dd521302..e86600af5dfd 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -550,6 +550,7 @@ extern struct efi {
 	unsigned long			tpm_log;		/* TPM2 Event Log table */
 	unsigned long			tpm_final_log;		/* TPM2 Final Events Log table */
 	unsigned long			mokvar_table;		/* MOK variable config table */
+	unsigned long			coco_secret;		/* Confidential computing secret table */
 
 	efi_get_time_t			*get_time;
 	efi_set_time_t			*set_time;
@@ -1189,6 +1190,8 @@ extern int efi_tpm_final_log_size;
 
 extern unsigned long rci2_table_phys;
 
+extern int efi_coco_secret_area_reserve(void);
+
 /*
  * efi_runtime_service() function identifiers.
  * "NONE" is used by efi_recover_from_page_fault() to check if the page
-- 
2.25.1

