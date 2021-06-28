Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A893B6883
	for <lists+linux-efi@lfdr.de>; Mon, 28 Jun 2021 20:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbhF1ShX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 28 Jun 2021 14:37:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61986 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234532AbhF1ShW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 28 Jun 2021 14:37:22 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15SIYLDv083139;
        Mon, 28 Jun 2021 14:34:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=mTHEHqZPDmYqt/tWItKKjdDa5/ESAOzeT5/F7ccqY0M=;
 b=AvompGET82QF11fpf+ET2aA6wfstg4ZCQtG+Sg1koaoQhtWh3LoAAqwpWnn8Omq4zbxw
 lF2Be+3D9l3zxsmWas8B05LssRejoYGDeaINwKdH6iibUeOTPn2o6egVdz5imx781MfF
 3yChmKlmJNHfOD+W1OK5IYBGnWUI2H2lfspBa7NNWUncxiBtIDw013MUIUzIs+7m8Ztu
 Q4yigIw327ljJIenV0YhFkcrGxHRy4g30fMqY2NXz/UlyP/dgcwEXXhGwQ80YupI1U+s
 /22UmUjn+KjIqFWpQ8e3IAfBeC6wIYZ7qJTMQsJHMWwhhL4XonE7ZU2MoPuGXR1jJ7Ju mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39fd08dm8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 14:34:42 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15SIYgTS083905;
        Mon, 28 Jun 2021 14:34:42 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39fd08dm8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 14:34:41 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15SISBMe027439;
        Mon, 28 Jun 2021 18:34:41 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02dal.us.ibm.com with ESMTP id 39duvb8mtg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 18:34:41 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15SIYej237355992
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 18:34:40 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EBB86AC069;
        Mon, 28 Jun 2021 18:34:39 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3E08AC062;
        Mon, 28 Jun 2021 18:34:39 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.2.130.16])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 28 Jun 2021 18:34:39 +0000 (GMT)
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
Subject: [RFC PATCH v2 1/3] efi/libstub: Copy confidential computing secret area
Date:   Mon, 28 Jun 2021 18:34:29 +0000
Message-Id: <20210628183431.953934-2-dovmurik@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210628183431.953934-1-dovmurik@linux.ibm.com>
References: <20210628183431.953934-1-dovmurik@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Sjv0tWuw2YY8xBRTAjrP5FQ5T9ZgF0GO
X-Proofpoint-ORIG-GUID: xbvnbsO7Rlu_jCuypXybUjEijIhzZyfd
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-28_14:2021-06-25,2021-06-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106280121
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Confidential computing hardware such as AMD SEV (Secure Encrypted
Virtualization) allows a guest owner to inject secrets into the VMs
memory without the host/hypervisor being able to read them.

Firmware support for secret injection is available in OVMF, which
reserves a memory area for secret injection and includes a pointer to it
the in EFI config table entry
LINUX_EFI_CONFIDENTIAL_COMPUTING_SECRET_TABLE_GUID.  However, OVMF
doesn't force the guest OS to keep this memory area reserved.

If EFI exposes such a table entry, efi/libstub will copy this area to a
reserved memory for future use inside the kernel.

A pointer to the new copy is kept in the EFI table under
LINUX_EFI_CONFIDENTIAL_COMPUTING_SECRET_AREA_GUID.

Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>
---
 drivers/firmware/efi/libstub/Makefile         |  3 +-
 .../efi/libstub/confidential-computing.c      | 68 +++++++++++++++++++
 drivers/firmware/efi/libstub/efi-stub.c       |  2 +
 drivers/firmware/efi/libstub/efistub.h        |  2 +
 drivers/firmware/efi/libstub/x86-stub.c       |  2 +
 include/linux/efi.h                           |  7 ++
 6 files changed, 83 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/efi/libstub/confidential-computing.c

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index d0537573501e..938ed23dd135 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -55,7 +55,8 @@ KCOV_INSTRUMENT			:= n
 lib-y				:= efi-stub-helper.o gop.o secureboot.o tpm.o \
 				   file.o mem.o random.o randomalloc.o pci.o \
 				   skip_spaces.o lib-cmdline.o lib-ctype.o \
-				   alignedmem.o relocate.o vsprintf.o
+				   alignedmem.o relocate.o vsprintf.o \
+				   confidential-computing.o
 
 # include the stub's generic dependencies from lib/ when building for ARM/arm64
 efi-deps-y := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c fdt_empty_tree.c fdt_sw.c
diff --git a/drivers/firmware/efi/libstub/confidential-computing.c b/drivers/firmware/efi/libstub/confidential-computing.c
new file mode 100644
index 000000000000..96b97ff5d503
--- /dev/null
+++ b/drivers/firmware/efi/libstub/confidential-computing.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Confidential computing secret area handling
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
+#define LINUX_EFI_CONFIDENTIAL_COMPUTING_SECRET_TABLE_GUID                                         \
+	EFI_GUID(0xadf956ad, 0xe98c, 0x484c, 0xae, 0x11, 0xb5, 0x1c, 0x7d, 0x33, 0x64, 0x47)
+
+/**
+ * struct efi_confidential_computing_secret_table - EFI config table that
+ * points to the confidential computing secret area. The guid
+ * LINUX_EFI_CONFIDENTIAL_COMPUTING_SECRET_TABLE_GUID holds this table.
+ * @base:	Physical address of the EFI secret area
+ * @size:	Size (in bytes) of the EFI secret area
+ */
+struct efi_confidential_computing_secret_table {
+	u64 base;
+	u64 size;
+} __attribute((packed));
+
+/*
+ * Create a copy of EFI's confidential computing secret area (if available) so
+ * that the secrets are accessible in the kernel after ExitBootServices.
+ */
+void efi_copy_confidential_computing_secret_area(void)
+{
+	efi_guid_t linux_secret_area_guid = LINUX_EFI_CONFIDENTIAL_COMPUTING_SECRET_AREA_GUID;
+	efi_status_t status;
+	struct efi_confidential_computing_secret_table *secret_table;
+	struct linux_efi_confidential_computing_secret_area *secret_area;
+
+	secret_table = get_efi_config_table(LINUX_EFI_CONFIDENTIAL_COMPUTING_SECRET_TABLE_GUID);
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
index 26e69788f27a..56bcd94a387e 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -205,6 +205,8 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 
 	efi_retrieve_tpm2_eventlog();
 
+	efi_copy_confidential_computing_secret_area();
+
 	/* Ask the firmware to clear memory on unclean shutdown */
 	efi_enable_reset_attack_mitigation();
 
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index cde0a2ef507d..1c02658042ea 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -858,4 +858,6 @@ efi_enable_reset_attack_mitigation(void) { }
 
 void efi_retrieve_tpm2_eventlog(void);
 
+void efi_copy_confidential_computing_secret_area(void);
+
 #endif
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index f14c4ff5839f..c663bf47370a 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -793,6 +793,8 @@ unsigned long efi_main(efi_handle_t handle,
 
 	efi_retrieve_tpm2_eventlog();
 
+	efi_copy_confidential_computing_secret_area();
+
 	setup_graphics(boot_params);
 
 	setup_efi_pci(boot_params);
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 6b5d36babfcc..4f647f1ee298 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -359,6 +359,8 @@ void efi_native_runtime_setup(void);
 #define LINUX_EFI_MEMRESERVE_TABLE_GUID		EFI_GUID(0x888eb0c6, 0x8ede, 0x4ff5,  0xa8, 0xf0, 0x9a, 0xee, 0x5c, 0xb9, 0x77, 0xc2)
 #define LINUX_EFI_INITRD_MEDIA_GUID		EFI_GUID(0x5568e427, 0x68fc, 0x4f3d,  0xac, 0x74, 0xca, 0x55, 0x52, 0x31, 0xcc, 0x68)
 #define LINUX_EFI_MOK_VARIABLE_TABLE_GUID	EFI_GUID(0xc451ed2b, 0x9694, 0x45d3,  0xba, 0xba, 0xed, 0x9f, 0x89, 0x88, 0xa3, 0x89)
+#define LINUX_EFI_CONFIDENTIAL_COMPUTING_SECRET_AREA_GUID \
+						EFI_GUID(0x940ed1e9, 0xd3da, 0x408b,  0xb3, 0x07, 0xe3, 0x2d, 0x25, 0x4a, 0x65, 0x16)
 
 /* OEM GUIDs */
 #define DELLEMC_EFI_RCI2_TABLE_GUID		EFI_GUID(0x2d9f28a2, 0xa886, 0x456a,  0x97, 0xa8, 0xf1, 0x1e, 0xf2, 0x4f, 0xf4, 0x55)
@@ -1282,4 +1284,9 @@ static inline struct efi_mokvar_table_entry *efi_mokvar_entry_find(
 }
 #endif
 
+struct linux_efi_confidential_computing_secret_area {
+	u32	size;
+	u8	area[];
+};
+
 #endif /* _LINUX_EFI_H */
-- 
2.25.1

