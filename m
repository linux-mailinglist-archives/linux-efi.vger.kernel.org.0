Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A644D434501
	for <lists+linux-efi@lfdr.de>; Wed, 20 Oct 2021 08:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhJTGRF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Oct 2021 02:17:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53076 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229715AbhJTGRE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 Oct 2021 02:17:04 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19K5gNdP015104;
        Wed, 20 Oct 2021 02:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=fGRye17iV9B/XxoNx8fhI19L3gsprfmWejtgtwWuGOQ=;
 b=sps6NDlHP9tA7dweUW1RC9h6zNOw67RZ0Xmy25bv+X20+f7pI9uzBn4HCvkotPH4v7Yo
 /nLT62KRXpYp/9QTx+7rfp5bEnRXBt/uNDuU5RrnFKzs23WvKMY5r0nserX78Jk7mb2G
 Q5CbRKNlazPpv5U3BAWLsFmuqOW8VhO5Chns1DEci1PKJxZ868+EaXTcQA5G6SJDbW1g
 CxZTNAqDhdEsh8uPBa/x3VuVfDXQRbZXfKoLkiAB3di3J5YRf/7NlYXCay0sLJJKECNj
 izKq/PjxkjJR0mwVKKZuoOOKdbzj2rn1ioyT7N/8X96i4V9MNbFVy5Gt3VJ9kiErZkuK /g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3btb5k2v7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 02:14:27 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19K4kmxR025311;
        Wed, 20 Oct 2021 02:14:26 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3btb5k2v7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 02:14:26 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19K6C95h023406;
        Wed, 20 Oct 2021 06:14:25 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01dal.us.ibm.com with ESMTP id 3bqpccf6qq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 06:14:25 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19K6ENNM42926564
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 06:14:23 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31811AC067;
        Wed, 20 Oct 2021 06:14:23 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF970AC05F;
        Wed, 20 Oct 2021 06:14:22 +0000 (GMT)
Received: from amdrome3.watson.ibm.com (unknown [9.2.130.16])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 20 Oct 2021 06:14:22 +0000 (GMT)
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
Subject: [PATCH v4 1/3] efi/libstub: Copy confidential computing secret area
Date:   Wed, 20 Oct 2021 06:14:06 +0000
Message-Id: <20211020061408.3447533-2-dovmurik@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211020061408.3447533-1-dovmurik@linux.ibm.com>
References: <20211020061408.3447533-1-dovmurik@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3so5gxdGT4rYymXjOUkXoisozRchWFKs
X-Proofpoint-ORIG-GUID: LRLCKAcO0HpGailTb4-Kh0vbhfo1wEBn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-20_02,2021-10-19_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxscore=0 adultscore=0 spamscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110200032
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Confidential computing (coco) hardware such as AMD SEV (Secure Encrypted
Virtualization) allows a guest owner to inject secrets into the VMs
memory without the host/hypervisor being able to read them.

Firmware support for secret injection is available in OVMF, which
reserves a memory area for secret injection and includes a pointer to it
the in EFI config table entry LINUX_EFI_COCO_SECRET_TABLE_GUID.
However, OVMF doesn't force the guest OS to keep this memory area
reserved.

If EFI exposes such a table entry, efi/libstub will copy this area to a
reserved memory for future use inside the kernel.

A pointer to the new copy is kept in the EFI table under
LINUX_EFI_COCO_SECRET_AREA_GUID.

The new functionality can be enabled with CONFIG_EFI_COCO_SECRET=y.

Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>
---
 drivers/firmware/efi/Kconfig            | 12 +++++
 drivers/firmware/efi/libstub/Makefile   |  1 +
 drivers/firmware/efi/libstub/coco.c     | 68 +++++++++++++++++++++++++
 drivers/firmware/efi/libstub/efi-stub.c |  2 +
 drivers/firmware/efi/libstub/efistub.h  |  6 +++
 drivers/firmware/efi/libstub/x86-stub.c |  2 +
 include/linux/efi.h                     |  6 +++
 7 files changed, 97 insertions(+)
 create mode 100644 drivers/firmware/efi/libstub/coco.c

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 2c3dac5ecb36..68d1c5e6a7b5 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -284,3 +284,15 @@ config EFI_CUSTOM_SSDT_OVERLAYS
 
 	  See Documentation/admin-guide/acpi/ssdt-overlays.rst for more
 	  information.
+
+config EFI_COCO_SECRET
+	bool "Copy and reserve EFI Confidential Computing secret area"
+	depends on EFI
+	default n
+	help
+	  Copy memory reserved by EFI for Confidential Computing (coco)
+	  injected secrets, if EFI exposes such a table entry.
+
+	  If you say Y here, the EFI stub copy the EFI secret area (if
+	  available) and reserve it for use inside the kernel.  This will
+	  allow the virt/coo/efi_secret module to access the secrets.
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index d0537573501e..fdada3fd5d9b 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -66,6 +66,7 @@ $(obj)/lib-%.o: $(srctree)/lib/%.c FORCE
 lib-$(CONFIG_EFI_GENERIC_STUB)	+= efi-stub.o fdt.o string.o \
 				   $(patsubst %.c,lib-%.o,$(efi-deps-y))
 
+lib-$(CONFIG_EFI_COCO_SECRET)	+= coco.o
 lib-$(CONFIG_ARM)		+= arm32-stub.o
 lib-$(CONFIG_ARM64)		+= arm64-stub.o
 lib-$(CONFIG_X86)		+= x86-stub.o
diff --git a/drivers/firmware/efi/libstub/coco.c b/drivers/firmware/efi/libstub/coco.c
new file mode 100644
index 000000000000..bf546b6a3f72
--- /dev/null
+++ b/drivers/firmware/efi/libstub/coco.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Confidential computing (coco) secret area handling
+ *
+ * Copyright (C) 2021 IBM Corporation
+ * Author: Dov Murik <dovmurik@linux.ibm.com>
+ */
+
+#include <linux/efi.h>
+#include <linux/sizes.h>
+#include <asm/efi.h>
+
+#include "efistub.h"
+
+#define LINUX_EFI_COCO_SECRET_TABLE_GUID                                                           \
+	EFI_GUID(0xadf956ad, 0xe98c, 0x484c, 0xae, 0x11, 0xb5, 0x1c, 0x7d, 0x33, 0x64, 0x47)
+
+/**
+ * struct efi_coco_secret_table - EFI config table that points to the
+ * confidential computing secret area. The guid
+ * LINUX_EFI_COCO_SECRET_TABLE_GUID holds this table.
+ * @base:	Physical address of the EFI secret area
+ * @size:	Size (in bytes) of the EFI secret area
+ */
+struct efi_coco_secret_table {
+	u64 base;
+	u64 size;
+} __attribute((packed));
+
+/*
+ * Create a copy of EFI's confidential computing secret area (if available) so
+ * that the secrets are accessible in the kernel after ExitBootServices.
+ */
+void efi_copy_coco_secret_area(void)
+{
+	efi_guid_t linux_secret_area_guid = LINUX_EFI_COCO_SECRET_AREA_GUID;
+	efi_status_t status;
+	struct efi_coco_secret_table *secret_table;
+	struct linux_efi_coco_secret_area *secret_area;
+
+	secret_table = get_efi_config_table(LINUX_EFI_COCO_SECRET_TABLE_GUID);
+	if (!secret_table)
+		return;
+
+	if (secret_table->size == 0 || secret_table->size >= SZ_4G)
+		return;
+
+	/* Allocate space for the secret area and copy it */
+	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
+			     sizeof(*secret_area) + secret_table->size, (void **)&secret_area);
+
+	if (status != EFI_SUCCESS) {
+		efi_err("Unable to allocate memory for confidential computing secret area copy\n");
+		return;
+	}
+
+	secret_area->size = secret_table->size;
+	memcpy(secret_area->area, (void *)(unsigned long)secret_table->base, secret_table->size);
+
+	status = efi_bs_call(install_configuration_table, &linux_secret_area_guid, secret_area);
+	if (status != EFI_SUCCESS)
+		goto err_free;
+
+	return;
+
+err_free:
+	efi_bs_call(free_pool, secret_area);
+}
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 26e69788f27a..18b3acd15c85 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -205,6 +205,8 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 
 	efi_retrieve_tpm2_eventlog();
 
+	efi_copy_coco_secret_area();
+
 	/* Ask the firmware to clear memory on unclean shutdown */
 	efi_enable_reset_attack_mitigation();
 
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index cde0a2ef507d..a23771547790 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -858,4 +858,10 @@ efi_enable_reset_attack_mitigation(void) { }
 
 void efi_retrieve_tpm2_eventlog(void);
 
+#ifdef CONFIG_EFI_COCO_SECRET
+void efi_copy_coco_secret_area(void);
+#else
+static inline void efi_copy_coco_secret_area(void) { }
+#endif
+
 #endif
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index f14c4ff5839f..4ad85e1b6191 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -793,6 +793,8 @@ unsigned long efi_main(efi_handle_t handle,
 
 	efi_retrieve_tpm2_eventlog();
 
+	efi_copy_coco_secret_area();
+
 	setup_graphics(boot_params);
 
 	setup_efi_pci(boot_params);
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 6b5d36babfcc..9021dd521302 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -359,6 +359,7 @@ void efi_native_runtime_setup(void);
 #define LINUX_EFI_MEMRESERVE_TABLE_GUID		EFI_GUID(0x888eb0c6, 0x8ede, 0x4ff5,  0xa8, 0xf0, 0x9a, 0xee, 0x5c, 0xb9, 0x77, 0xc2)
 #define LINUX_EFI_INITRD_MEDIA_GUID		EFI_GUID(0x5568e427, 0x68fc, 0x4f3d,  0xac, 0x74, 0xca, 0x55, 0x52, 0x31, 0xcc, 0x68)
 #define LINUX_EFI_MOK_VARIABLE_TABLE_GUID	EFI_GUID(0xc451ed2b, 0x9694, 0x45d3,  0xba, 0xba, 0xed, 0x9f, 0x89, 0x88, 0xa3, 0x89)
+#define LINUX_EFI_COCO_SECRET_AREA_GUID		EFI_GUID(0x940ed1e9, 0xd3da, 0x408b,  0xb3, 0x07, 0xe3, 0x2d, 0x25, 0x4a, 0x65, 0x16)
 
 /* OEM GUIDs */
 #define DELLEMC_EFI_RCI2_TABLE_GUID		EFI_GUID(0x2d9f28a2, 0xa886, 0x456a,  0x97, 0xa8, 0xf1, 0x1e, 0xf2, 0x4f, 0xf4, 0x55)
@@ -1282,4 +1283,9 @@ static inline struct efi_mokvar_table_entry *efi_mokvar_entry_find(
 }
 #endif
 
+struct linux_efi_coco_secret_area {
+	u32	size;
+	u8	area[];
+};
+
 #endif /* _LINUX_EFI_H */
-- 
2.25.1

