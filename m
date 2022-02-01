Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255AF4A5C72
	for <lists+linux-efi@lfdr.de>; Tue,  1 Feb 2022 13:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238051AbiBAMo6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Feb 2022 07:44:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34576 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236280AbiBAMo5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Feb 2022 07:44:57 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 211CWRcP016597;
        Tue, 1 Feb 2022 12:44:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=/ME2+T1XeR8iH+r9U1Xo2ommcVwuBNu7w918xx3utiU=;
 b=fYZl44G5bUTe8z+20Tzx34w/py8Hl4NHRSVI9P5ZTUFtpsKH/cmRv7JJXQlujnvgUPAP
 AFnq6pfl7fb9vR43/JAblT8n+7FcQ320t1xJuYYDiWs1fwU9Hb0XXoBh6Soo8pluETHx
 +lVJ6qHgfZcYPUNhdL6LFQ022jgJcWJHJbyNnEq3E2gfGXf6vnx0XLcFxeIHDi5cEzV4
 WctzFJtzgDgNieY+odMLoAfhd4NAGqRE03sd+s15+0425vECq7/5WjaVXF67VyE9YTHM
 OSUowSJC+Eqk8ubIcL813zHqYz+hKWbY4sk/UqS8Z++z9+4X9Dztq+Ptk19zgpKXrAgx 9w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dxn4ht9y5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 12:44:45 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 211CWYZ5017768;
        Tue, 1 Feb 2022 12:44:45 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dxn4ht9xu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 12:44:45 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 211CcbLb027683;
        Tue, 1 Feb 2022 12:44:44 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma01dal.us.ibm.com with ESMTP id 3dvw7bbbb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 12:44:43 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 211Cig2v40042764
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Feb 2022 12:44:42 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01B8ABE059;
        Tue,  1 Feb 2022 12:44:42 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C65FFBE051;
        Tue,  1 Feb 2022 12:44:39 +0000 (GMT)
Received: from amdrome3.watson.ibm.com (unknown [9.2.130.16])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  1 Feb 2022 12:44:39 +0000 (GMT)
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
Subject: [PATCH v7 1/5] efi: Save location of EFI confidential computing area
Date:   Tue,  1 Feb 2022 12:44:09 +0000
Message-Id: <20220201124413.1093099-2-dovmurik@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220201124413.1093099-1-dovmurik@linux.ibm.com>
References: <20220201124413.1093099-1-dovmurik@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wmGTVlF0paF6NYCpcO-F1bAwIfCPmHag
X-Proofpoint-ORIG-GUID: kSKa92qFQlEVWVPzHohFCr9JHkWfi4fn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_03,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202010068
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Confidential computing (coco) hardware such as AMD SEV (Secure Encrypted
Virtualization) allows a guest owner to inject secrets into the VMs
memory without the host/hypervisor being able to read them.

Firmware support for secret injection is available in OVMF, which
reserves a memory area for secret injection and includes a pointer to it
the in EFI config table entry LINUX_EFI_COCO_SECRET_TABLE_GUID.

If EFI exposes such a table entry, uefi_init() will keep a pointer to
the EFI config table entry in efi.coco_secret, so it can be used later
by the kernel (specifically drivers/virt/coco/efi_secret).  It will also
appear in the kernel log as "CocoSecret=ADDRESS"; for example:

    [    0.000000] efi: EFI v2.70 by EDK II
    [    0.000000] efi: CocoSecret=0x7f22e680 SMBIOS=0x7f541000 ACPI=0x7f77e000 ACPI 2.0=0x7f77e014 MEMATTR=0x7ea0c018

The new functionality can be enabled with CONFIG_EFI_COCO_SECRET=y.

Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>
---
 arch/x86/platform/efi/efi.c  |  3 +++
 drivers/firmware/efi/Kconfig | 16 ++++++++++++++++
 drivers/firmware/efi/efi.c   |  6 ++++++
 include/linux/efi.h          | 10 ++++++++++
 4 files changed, 35 insertions(+)

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
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 2c3dac5ecb36..6fa251b3709f 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -284,3 +284,19 @@ config EFI_CUSTOM_SSDT_OVERLAYS
 
 	  See Documentation/admin-guide/acpi/ssdt-overlays.rst for more
 	  information.
+
+config EFI_COCO_SECRET
+	bool "EFI Confidential Computing Secret Area Support"
+	depends on EFI
+	help
+	  Confidential Computing platforms (such as AMD SEV) allow the
+	  Guest Owner to securely inject secrets during guest VM launch.
+	  The secrets are placed in a designated EFI reserved memory area.
+
+	  In order to use the secrets in the kernel, the location of the secret
+	  area (as published in the EFI config table) must be kept.
+
+	  If you say Y here, the address of the EFI secret area will be kept
+	  for usage inside the kernel.  This will allow the
+	  virt/coco/efi_secret module to access the secrets, which in turn
+	  allows userspace programs to access the injected secrets.
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 7de3f5b6e8d0..378d044b2463 100644
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
 
@@ -528,6 +531,9 @@ static const efi_config_table_type_t common_tables[] __initconst = {
 #endif
 #ifdef CONFIG_LOAD_UEFI_KEYS
 	{LINUX_EFI_MOK_VARIABLE_TABLE_GUID,	&efi.mokvar_table,	"MOKvar"	},
+#endif
+#ifdef CONFIG_EFI_COCO_SECRET
+	{LINUX_EFI_COCO_SECRET_AREA_GUID,	&efi.coco_secret,	"CocoSecret"	},
 #endif
 	{},
 };
diff --git a/include/linux/efi.h b/include/linux/efi.h
index ccd4d3f91c98..771d4cd06b56 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -405,6 +405,7 @@ void efi_native_runtime_setup(void);
 #define LINUX_EFI_MEMRESERVE_TABLE_GUID		EFI_GUID(0x888eb0c6, 0x8ede, 0x4ff5,  0xa8, 0xf0, 0x9a, 0xee, 0x5c, 0xb9, 0x77, 0xc2)
 #define LINUX_EFI_INITRD_MEDIA_GUID		EFI_GUID(0x5568e427, 0x68fc, 0x4f3d,  0xac, 0x74, 0xca, 0x55, 0x52, 0x31, 0xcc, 0x68)
 #define LINUX_EFI_MOK_VARIABLE_TABLE_GUID	EFI_GUID(0xc451ed2b, 0x9694, 0x45d3,  0xba, 0xba, 0xed, 0x9f, 0x89, 0x88, 0xa3, 0x89)
+#define LINUX_EFI_COCO_SECRET_AREA_GUID		EFI_GUID(0xadf956ad, 0xe98c, 0x484c,  0xae, 0x11, 0xb5, 0x1c, 0x7d, 0x33, 0x64, 0x47)
 
 /* OEM GUIDs */
 #define DELLEMC_EFI_RCI2_TABLE_GUID		EFI_GUID(0x2d9f28a2, 0xa886, 0x456a,  0x97, 0xa8, 0xf1, 0x1e, 0xf2, 0x4f, 0xf4, 0x55)
@@ -596,6 +597,7 @@ extern struct efi {
 	unsigned long			tpm_log;		/* TPM2 Event Log table */
 	unsigned long			tpm_final_log;		/* TPM2 Final Events Log table */
 	unsigned long			mokvar_table;		/* MOK variable config table */
+	unsigned long			coco_secret;		/* Confidential computing secret table */
 
 	efi_get_time_t			*get_time;
 	efi_set_time_t			*set_time;
@@ -1335,4 +1337,12 @@ extern void efifb_setup_from_dmi(struct screen_info *si, const char *opt);
 static inline void efifb_setup_from_dmi(struct screen_info *si, const char *opt) { }
 #endif
 
+struct linux_efi_coco_secret_area {
+	u64	base_pa;
+	u64	size;
+};
+
+/* Header of a populated EFI secret area */
+#define EFI_SECRET_TABLE_HEADER_GUID	EFI_GUID(0x1e74f542, 0x71dd, 0x4d66,  0x96, 0x3e, 0xef, 0x42, 0x87, 0xff, 0x17, 0x3b)
+
 #endif /* _LINUX_EFI_H */
-- 
2.25.1

