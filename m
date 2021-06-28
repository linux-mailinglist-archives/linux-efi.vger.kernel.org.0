Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71AD03B6887
	for <lists+linux-efi@lfdr.de>; Mon, 28 Jun 2021 20:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbhF1ShZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 28 Jun 2021 14:37:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6974 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234597AbhF1ShY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 28 Jun 2021 14:37:24 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15SIYA3T189933;
        Mon, 28 Jun 2021 14:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=jGw3eNzgJYR0WmMIMTO+C+xze8avqDJb+bq3OeQIgZw=;
 b=ZDmTNEaIOffPk71yaZKM8inpxk0x/hsxiDP4TE0v2PbkPP4CI2LZyJm3QIJIPN51J1EJ
 CeBvIF3k1oawmuwjKAXeEOesIwXbnbLRWKNBm05Ny5f3DvZtlExv/EYWDcWHd2YLdDXT
 YPpRb2VQqUuaYhKBZP2bo5MliPI/F/CMM3rZTOHsDPSJbyOVz167XphK5TNOm6/4Oqy2
 ctqup0xYPhgRkcCbQ3YJlS4o/hZFVpA4eyOIISwKzFgXa1BcpAeD/WKcG1y+K9MFjulu
 YGF6O+v5KG7CHG5dZjZxqn60IcP8O+yX20iaQoZ4S13tilr8SXCVONsXNJEWVjv4VU3L Yw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39fj7ctwgr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 14:34:44 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15SIYDxj190076;
        Mon, 28 Jun 2021 14:34:44 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39fj7ctwgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 14:34:44 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15SISHaQ011531;
        Mon, 28 Jun 2021 18:34:43 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04dal.us.ibm.com with ESMTP id 39ekxadr1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 18:34:43 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15SIYgrD41157040
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 18:34:42 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29685AC060;
        Mon, 28 Jun 2021 18:34:42 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1F6BAC059;
        Mon, 28 Jun 2021 18:34:41 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.2.130.16])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 28 Jun 2021 18:34:41 +0000 (GMT)
From:   Dov Murik <dovmurik@linux.ibm.com>
To:     linux-efi@vger.kernel.org
Cc:     Dov Murik <dovmurik@linux.ibm.com>,
        Laszlo Ersek <lersek@redhat.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>, linux-coco@lists.linux.dev,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 2/3] efi: Reserve confidential computing secret area
Date:   Mon, 28 Jun 2021 18:34:30 +0000
Message-Id: <20210628183431.953934-3-dovmurik@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210628183431.953934-1-dovmurik@linux.ibm.com>
References: <20210628183431.953934-1-dovmurik@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7EF2g0YTvKdrrS4isXcMP20tgipRtHd0
X-Proofpoint-ORIG-GUID: UwF2X2M9KZ2CvsPQikBDpAdO-0r4bGN2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-28_14:2021-06-25,2021-06-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106280121
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When efi-stub copies an EFI-provided confidential computing secret area,
reserve that memory block for future use within the kernel.

Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>
---
 drivers/firmware/efi/Makefile                 |  2 +-
 drivers/firmware/efi/confidential-computing.c | 41 +++++++++++++++++++
 drivers/firmware/efi/efi.c                    |  5 +++
 include/linux/efi.h                           |  4 ++
 4 files changed, 51 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/efi/confidential-computing.c

diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index 467e94259679..63f21f7351da 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -12,7 +12,7 @@ KASAN_SANITIZE_runtime-wrappers.o	:= n
 
 obj-$(CONFIG_ACPI_BGRT) 		+= efi-bgrt.o
 obj-$(CONFIG_EFI)			+= efi.o vars.o reboot.o memattr.o tpm.o
-obj-$(CONFIG_EFI)			+= memmap.o
+obj-$(CONFIG_EFI)			+= memmap.o confidential-computing.o
 ifneq ($(CONFIG_EFI_CAPSULE_LOADER),)
 obj-$(CONFIG_EFI)			+= capsule.o
 endif
diff --git a/drivers/firmware/efi/confidential-computing.c b/drivers/firmware/efi/confidential-computing.c
new file mode 100644
index 000000000000..e6bb4d1e8f17
--- /dev/null
+++ b/drivers/firmware/efi/confidential-computing.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Confidential computing secret area handling
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
+int __init efi_confidential_computing_secret_area_reserve(void)
+{
+	struct linux_efi_confidential_computing_secret_area *secret_area;
+	unsigned long secret_area_size;
+
+	if (efi.confidential_computing_secret == EFI_INVALID_TABLE_ADDR)
+		return 0;
+
+	secret_area = early_memremap(efi.confidential_computing_secret, sizeof(*secret_area));
+	if (!secret_area) {
+		pr_err("Failed to map confidential computing secret area\n");
+		efi.confidential_computing_secret = EFI_INVALID_TABLE_ADDR;
+		return -ENOMEM;
+	}
+
+	secret_area_size = sizeof(*secret_area) + secret_area->size;
+	memblock_reserve(efi.confidential_computing_secret, secret_area_size);
+
+	pr_info("Reserved memory of EFI-provided confidential computing secret area");
+
+	early_memunmap(secret_area, sizeof(*secret_area));
+	return 0;
+}
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 4b7ee3fa9224..da36333e5c9f 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -526,6 +526,9 @@ static const efi_config_table_type_t common_tables[] __initconst = {
 #ifdef CONFIG_LOAD_UEFI_KEYS
 	{LINUX_EFI_MOK_VARIABLE_TABLE_GUID,	&efi.mokvar_table,	"MOKvar"	},
 #endif
+	{LINUX_EFI_CONFIDENTIAL_COMPUTING_SECRET_AREA_GUID,
+						&efi.confidential_computing_secret,
+									"ConfCompSecret"},
 	{},
 };
 
@@ -613,6 +616,8 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
 
 	efi_tpm_eventlog_init();
 
+	efi_confidential_computing_secret_area_reserve();
+
 	if (mem_reserve != EFI_INVALID_TABLE_ADDR) {
 		unsigned long prsv = mem_reserve;
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 4f647f1ee298..e9740bd16db0 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -551,6 +551,8 @@ extern struct efi {
 	unsigned long			tpm_log;		/* TPM2 Event Log table */
 	unsigned long			tpm_final_log;		/* TPM2 Final Events Log table */
 	unsigned long			mokvar_table;		/* MOK variable config table */
+	unsigned long			confidential_computing_secret;	/* Confidential computing */
+									/* secret table           */
 
 	efi_get_time_t			*get_time;
 	efi_set_time_t			*set_time;
@@ -1190,6 +1192,8 @@ extern int efi_tpm_final_log_size;
 
 extern unsigned long rci2_table_phys;
 
+extern int efi_confidential_computing_secret_area_reserve(void);
+
 /*
  * efi_runtime_service() function identifiers.
  * "NONE" is used by efi_recover_from_page_fault() to check if the page
-- 
2.25.1

