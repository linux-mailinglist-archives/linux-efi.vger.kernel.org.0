Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9F337F2F7
	for <lists+linux-efi@lfdr.de>; Thu, 13 May 2021 08:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhEMG2F (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 May 2021 02:28:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63684 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230070AbhEMG2E (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 May 2021 02:28:04 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14D64JoK078313;
        Thu, 13 May 2021 02:26:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=YqIl2pFNJ0Q2HcLqPfX7r6Rx+rCEjWSGTQC+8zsgA3Y=;
 b=AOpwv7RwMoZ1XPQKnO159MfUki2pIRdCYfdDFnirPenrbJfP1x4adHatiYOx8x2hL67K
 BcCe/F/wiICT8xzUd750ricUBqoEr1wvAf8caFUjRUmHU/JreKWTFfmh1U0Jz+mvC0cw
 +VUJhTgtBfedY9vBS8RWXhizwgv+8S7P9shZpu0KQnh1YERXKDB0zEA1ejCWpxLf5GgJ
 SY0unWSH2mp4gmrLEEIxsloKG91aVXD2onGQviNXGWb2SLehh8+gACMCDr9EX1B68lMw
 u/QfdBvJ+luEJ4MoJebCAzl6eI2ZCLPHNT3398B+TxvtTtUV5bkXXL+nVsplNDK/JiNH Wg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38gxbjgqwr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 May 2021 02:26:52 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14D65GRl083443;
        Thu, 13 May 2021 02:26:51 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38gxbjgqwk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 May 2021 02:26:51 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14D6CXWl002310;
        Thu, 13 May 2021 06:26:51 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma02dal.us.ibm.com with ESMTP id 38dj99kngg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 May 2021 06:26:51 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14D6Qmon14483762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 May 2021 06:26:48 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A92A78064;
        Thu, 13 May 2021 06:26:48 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4AE037805C;
        Thu, 13 May 2021 06:26:47 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.2.130.16])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 13 May 2021 06:26:47 +0000 (GMT)
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
Subject: [RFC PATCH 1/3] efi/libstub: Copy confidential computing secret area
Date:   Thu, 13 May 2021 06:26:32 +0000
Message-Id: <20210513062634.2481118-2-dovmurik@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210513062634.2481118-1-dovmurik@linux.ibm.com>
References: <20210513062634.2481118-1-dovmurik@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ExH94_XHD8MuCKkhdznwcTMAV2JdBAGI
X-Proofpoint-ORIG-GUID: b4AD_st6VipNFCRuV3GxquusgHZbWTVS
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-13_03:2021-05-12,2021-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105130046
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

