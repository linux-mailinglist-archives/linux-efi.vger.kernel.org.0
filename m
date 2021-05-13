Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE4337F2F9
	for <lists+linux-efi@lfdr.de>; Thu, 13 May 2021 08:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhEMG2L (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 May 2021 02:28:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47286 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231299AbhEMG2J (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 May 2021 02:28:09 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14D6K8qK078217;
        Thu, 13 May 2021 02:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=JpQHQYjDO4Fte9LRqWq+6SHksnq/rCxTeIcEdVDE8J8=;
 b=G0jFHQN6b7im1l80HpmYsG/4vOFgukf9BbDhB4R7U+qWPXKnNDNtYFBe4mJZJwcMWcua
 32t8pXT4CoX4+pnPVdO78+vZmi05BdNSoHPRsqEFL8KPyAbqqC6oJ8MPzC7AAFRJGopp
 uQI5JHrCDXpv+6sa8IMCdSfcCOH6WmRMw3vcfonVfzW4Xm089DGK3WtkzkW2sGyD9p7q
 yYxlWsrYFFK0mGF3LNFFLbPR2F3I34kFNIN4GqQfLzwCR4yUveXwstuu+MCoSYGyx1Jo
 NG8z5awxy8A5c9PnIaGMGXx6+z9MlswXVpgagWDwXqbQotinOUSrLHa29O8Aiax8U9ma oQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38gw4tj8a3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 May 2021 02:26:57 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14D6L85c080632;
        Thu, 13 May 2021 02:26:57 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38gw4tj89x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 May 2021 02:26:57 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14D6QsPl010714;
        Thu, 13 May 2021 06:26:56 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma01dal.us.ibm.com with ESMTP id 38dj9a3nan-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 May 2021 06:26:56 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14D6QqxK21627198
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 May 2021 06:26:52 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B312A7805F;
        Thu, 13 May 2021 06:26:52 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC6057805C;
        Thu, 13 May 2021 06:26:51 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.2.130.16])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 13 May 2021 06:26:51 +0000 (GMT)
From:   Dov Murik <dovmurik@linux.ibm.com>
To:     linux-efi@vger.kernel.org
Cc:     Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Laszlo Ersek <lersek@redhat.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/3] efi: Reserve confidential computing secret area
Date:   Thu, 13 May 2021 06:26:33 +0000
Message-Id: <20210513062634.2481118-3-dovmurik@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210513062634.2481118-1-dovmurik@linux.ibm.com>
References: <20210513062634.2481118-1-dovmurik@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: A45O1zQbgS5ojHBPc5bVcHnLBsrf9Ugd
X-Proofpoint-GUID: 4BpM3cFGyzdLl8ZNxetenZ1WOs4jrqjt
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-13_03:2021-05-12,2021-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105130046
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When efi-stub copies an EFI-provided confidential computing secret area,
reserve that memory block for future use within the kernel.

Cc: Laszlo Ersek <lersek@redhat.com>
Cc: Ashish Kalra <ashish.kalra@amd.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: James Bottomley <jejb@linux.ibm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
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

