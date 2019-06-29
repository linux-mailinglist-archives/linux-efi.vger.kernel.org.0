Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE4E75AA62
	for <lists+linux-efi@lfdr.de>; Sat, 29 Jun 2019 13:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfF2LXy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 29 Jun 2019 07:23:54 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:56710 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726874AbfF2LXx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 29 Jun 2019 07:23:53 -0400
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5TBKalf026750
        for <linux-efi@vger.kernel.org>; Sat, 29 Jun 2019 07:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=5bjI6+nG3Dm/bGFpda3b4IdIDnj1M75prbiQsf1C/pQ=;
 b=JhBENOl2y9m7aCqdBKuCDewShH+evPjAE2riQocRqcPNuOcKcuv6xY/MGZQ5gj0Y6vxG
 /ebrif5MDQDA4MNNF+v+yBEi24uTqHfu8ZlyvnoWoD86pMeB81rUxOUbkmximNtjnblC
 3X2NcjdDmBYWGBnyTcos2QneAnXYYRFdZUAuxTdSosUGoRcNxmk1qvFzoapng1QGSXd8
 /3uyp/hHkYxuJpqjc76YU8ZpYv+Sa81xqgehmjR0TReADyXFJJR+Q+E64Glp1eWH/i/N
 tyRVrBpGyu/Ah/aV5YUWYOR9B/tciGheqck46sIH53ipkZlv8BnmQD3GH/umQYNSiP27 oQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 2te4nng8ka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Sat, 29 Jun 2019 07:23:51 -0400
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5TBNpfZ078782
        for <linux-efi@vger.kernel.org>; Sat, 29 Jun 2019 07:23:51 -0400
Received: from ausxipps310.us.dell.com (AUSXIPPS310.us.dell.com [143.166.148.211])
        by mx0b-00154901.pphosted.com with ESMTP id 2te2hbjn9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-efi@vger.kernel.org>; Sat, 29 Jun 2019 07:23:51 -0400
X-LoopCount0: from 10.166.132.129
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="384676799"
From:   <Narendra.K@dell.com>
To:     <linux-efi@vger.kernel.org>, <ard.biesheuvel@linaro.org>,
        <pjones@redhat.com>
CC:     <Stuart.Hayes@dell.com>
Subject: [PATCH v0] Export Runtime Configuration Interface table to sysfs
Thread-Topic: [PATCH v0] Export Runtime Configuration Interface table to sysfs
Thread-Index: AQHVLm0dISGCw1TyVEKadDoZWf9krw==
Date:   Sat, 29 Jun 2019 11:23:45 +0000
Message-ID: <20190629112326.GA2366@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B31319F3C9E5054686A9019042E53529@dell.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-29_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906290145
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906290144
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Narendra K <Narendra.K@dell.com>

System firmware advertises the address of the 'Runtime
Configuration Interface table version 2 (RCI2)' via
an EFI Configuration Table entry. This code retrieves the RCI2
table from the address and exports it to sysfs as a binary
attribute 'rci2' under /sys/firmware/efi/tables directory.
The approach adopted is similar to the attribute 'DMI' under
/sys/firmware/dmi/tables.

RCI2 table contains BIOS HII in XML format and is used to populate
BIOS setup page in Dell EMC OpenManage Server Administrator tool.
The BIOS setup page contains BIOS tokens which can be configured.

Signed-off-by: Narendra K <Narendra.K@dell.com>
---
RFC -> v0:

- Removed rci2 table from struct efi and defined it in rci2_table.c similar=
 to
the way uv_systab_phys is define in dmesg.
- Removed the oem_tables array and added rci2 to common_tables array
- Removed the string 'rci2' from the common_tables array so that it is=20
not printed in dmesg.
- Merged function 'efi_rci2_table_init' into 'efi_rci2_sysfs_init' function=
 to
avoid calling early_memremap/unmap functions.

Also, a note unrelated to this patch - compilation error is observed when
testing with make defconfig related to uv_systab_phys in
arch/x86/platform/efi/efi.c. It seems like it needs to be protected with
CONFIG_X86_UV in efi_tables array.


 Documentation/ABI/testing/sysfs-firmware-efi |   8 +
 arch/x86/platform/efi/efi.c                  |   1 +
 drivers/firmware/efi/Makefile                |   2 +-
 drivers/firmware/efi/efi.c                   |   4 +
 drivers/firmware/efi/rci2_table.c            | 147 +++++++++++++++++++
 include/linux/efi.h                          |   6 +
 6 files changed, 167 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/efi/rci2_table.c

diff --git a/Documentation/ABI/testing/sysfs-firmware-efi b/Documentation/A=
BI/testing/sysfs-firmware-efi
index e794eac32a90..f7822c522a46 100644
--- a/Documentation/ABI/testing/sysfs-firmware-efi
+++ b/Documentation/ABI/testing/sysfs-firmware-efi
@@ -28,3 +28,11 @@ Description:	Displays the physical addresses of all EFI =
Configuration
 		versions are always printed first, i.e. ACPI20 comes
 		before ACPI.
 Users:		dmidecode
+
+What:		/sys/firmware/efi/tables/rci2
+Date:		June 2019
+Contact:	Narendra K <Narendra.K@dell.com>, linux-bugs@dell.com
+Description:	Displays the content of the Runtime Configuration Interface
+		Table version 2 on Dell EMC PowerEdge systems in binary format
+Users:		It is used by Dell EMC OpenManage Server Administrator tool to
+		populate BIOS setup page.
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 002078645969..6e1c1b0ce015 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -80,6 +80,7 @@ static const unsigned long * const efi_tables[] =3D {
 	&efi.esrt,
 	&efi.properties_table,
 	&efi.mem_attr_table,
+	&rci2_table_phys,
 };
=20
 u64 efi_setup;		/* efi setup_data physical address */
diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index d2d0d2030620..db07828ca1ed 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -11,7 +11,7 @@
 KASAN_SANITIZE_runtime-wrappers.o	:=3D n
=20
 obj-$(CONFIG_ACPI_BGRT) 		+=3D efi-bgrt.o
-obj-$(CONFIG_EFI)			+=3D efi.o vars.o reboot.o memattr.o tpm.o
+obj-$(CONFIG_EFI)			+=3D efi.o vars.o reboot.o memattr.o tpm.o rci2_table.=
o
 obj-$(CONFIG_EFI)			+=3D capsule.o memmap.o
 obj-$(CONFIG_EFI_VARS)			+=3D efivars.o
 obj-$(CONFIG_EFI_ESRT)			+=3D esrt.o
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index d082d5b2fb84..429c676f53fb 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -363,6 +363,9 @@ static int __init efisubsys_init(void)
 		goto err_remove_group;
 	}
=20
+	if (efi_rci2_sysfs_init() !=3D 0)
+		pr_debug("efi rci2: sysfs attribute creation under /sys/firmware/efi/ fa=
iled");
+
 	return 0;
=20
 err_remove_group:
@@ -463,6 +466,7 @@ static __initdata efi_config_table_type_t common_tables=
[] =3D {
 	{LINUX_EFI_RANDOM_SEED_TABLE_GUID, "RNG", &efi.rng_seed},
 	{LINUX_EFI_TPM_EVENT_LOG_GUID, "TPMEventLog", &efi.tpm_log},
 	{LINUX_EFI_MEMRESERVE_TABLE_GUID, "MEMRESERVE", &efi.mem_reserve},
+	{DELLEMC_EFI_RCI2_TABLE_GUID, NULL, &rci2_table_phys},
 	{NULL_GUID, NULL, NULL},
 };
=20
diff --git a/drivers/firmware/efi/rci2_table.c b/drivers/firmware/efi/rci2_=
table.c
new file mode 100644
index 000000000000..796b93bb5e93
--- /dev/null
+++ b/drivers/firmware/efi/rci2_table.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Export Runtime Configuration Interface Table Version 2 (RCI2)
+ * to sysfs
+ *
+ * Copyright (C) 2019 Dell Inc
+ * by Narendra K <Narendra.K@dell.com>
+ *
+ * System firmware advertises the address of the RCI2 Table via
+ * an EFI Configuration Table entry. This code retrieves the RCI2
+ * table from the address and exports it to sysfs as a binary
+ * attribute 'rci2' under /sys/firmware/efi/tables directory.
+ */
+
+#include <linux/kobject.h>
+#include <linux/device.h>
+#include <linux/sysfs.h>
+#include <linux/efi.h>
+#include <linux/types.h>
+#include <linux/io.h>
+
+#define RCI_SIGNATURE	"_RC_"
+
+struct rci2_table_global_hdr {
+	u16 type;
+	u16 resvd0;
+	u16 hdr_len;
+	u8 rci2_sig[4];
+	u16 resvd1;
+	u32 resvd2;
+	u32 resvd3;
+	u8 major_rev;
+	u8 minor_rev;
+	u16 num_of_structs;
+	u32 rci2_len;
+	u16 rci2_chksum;
+} __packed;
+
+static u8 *rci2_base;
+static u32 rci2_table_len;
+unsigned long rci2_table_phys __ro_after_init =3D EFI_INVALID_TABLE_ADDR;
+
+static ssize_t raw_table_read(struct file *file, struct kobject *kobj,
+			      struct bin_attribute *attr, char *buf,
+			      loff_t pos, size_t count)
+{
+	memcpy(buf, attr->private + pos, count);
+	return count;
+}
+
+static BIN_ATTR(rci2, S_IRUSR, raw_table_read, NULL, 0);
+
+static u16 checksum(void)
+{
+	u8 len_is_odd =3D rci2_table_len % 2;
+	u32 chksum_len =3D rci2_table_len;
+	u16 *base =3D (u16 *)rci2_base;
+	u8 buf[2] =3D {0};
+	u32 offset =3D 0;
+	u16 chksum =3D 0;
+
+	if (len_is_odd)
+		chksum_len -=3D 1;
+
+	while (offset < chksum_len) {
+		chksum +=3D *base;
+		offset +=3D 2;
+		base++;
+	}
+
+	if (len_is_odd) {
+		buf[0] =3D *(u8 *)base;
+		chksum +=3D *(u16 *)(buf);
+	}
+
+	return chksum;
+}
+
+int __init efi_rci2_sysfs_init(void)
+{
+
+	struct kobject *tables_kobj;
+	int ret =3D -ENOMEM;
+
+	rci2_base =3D memremap(rci2_table_phys,
+			     sizeof(struct rci2_table_global_hdr),
+			     MEMREMAP_WB);
+	if (!rci2_base) {
+		pr_debug("RCI2 table init failed - could not map RCI2 table\n");
+		goto err;
+	}
+
+	if (strncmp(rci2_base +
+		    offsetof(struct rci2_table_global_hdr, rci2_sig),
+		    RCI_SIGNATURE, 4)) {
+		pr_debug("RCI2 table init failed - incorrect signature\n");
+		ret =3D -ENODEV;
+		goto err_unmap;
+	}
+
+	rci2_table_len =3D *(u32 *)(rci2_base +
+				  offsetof(struct rci2_table_global_hdr,
+				  rci2_len));
+
+	memunmap(rci2_base);
+
+	if (!rci2_table_len) {
+		pr_debug("RCI2 table init failed - incorrect table length\n");
+		goto err;
+	}
+
+	rci2_base =3D memremap(rci2_table_phys, rci2_table_len, MEMREMAP_WB);
+	if (!rci2_base) {
+		pr_debug("RCI2 table - could not map RCI2 table\n");
+		goto err;
+	}
+
+	if (checksum() !=3D 0) {
+		pr_debug("RCI2 table - incorrect checksum\n");
+		ret =3D -ENODEV;
+		goto err_unmap;
+	}
+
+	tables_kobj =3D kobject_create_and_add("tables", efi_kobj);
+	if (!tables_kobj) {
+		pr_debug("RCI2 table - tables_kobj creation failed\n");
+		goto err_unmap;
+	}
+
+	bin_attr_rci2.size =3D rci2_table_len;
+	bin_attr_rci2.private =3D rci2_base;
+	ret =3D sysfs_create_bin_file(tables_kobj, &bin_attr_rci2);
+	if (ret !=3D 0) {
+		pr_debug("RCI2 table - rci2 sysfs bin file creation failed\n");
+		kobject_del(tables_kobj);
+		kobject_put(tables_kobj);
+		goto err_unmap;
+	}
+
+	return 0;
+
+ err_unmap:
+	memunmap(rci2_base);
+ err:
+	pr_debug("RCI2 table - sysfs initialization failed\n");
+	return ret;
+}
diff --git a/include/linux/efi.h b/include/linux/efi.h
index ac48db107214..ef74c7ec75bb 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -691,6 +691,9 @@ void efi_native_runtime_setup(void);
 #define LINUX_EFI_TPM_EVENT_LOG_GUID		EFI_GUID(0xb7799cb0, 0xeca2, 0x4943,=
  0x96, 0x67, 0x1f, 0xae, 0x07, 0xb7, 0x47, 0xfa)
 #define LINUX_EFI_MEMRESERVE_TABLE_GUID		EFI_GUID(0x888eb0c6, 0x8ede, 0x4f=
f5,  0xa8, 0xf0, 0x9a, 0xee, 0x5c, 0xb9, 0x77, 0xc2)
=20
+/* OEM GUIDs */
+#define DELLEMC_EFI_RCI2_TABLE_GUID		EFI_GUID(0x2d9f28a2, 0xa886, 0x456a, =
 0x97, 0xa8, 0xf1, 0x1e, 0xf2, 0x4f, 0xf4, 0x55)
+
 typedef struct {
 	efi_guid_t guid;
 	u64 table;
@@ -1703,6 +1706,9 @@ struct linux_efi_tpm_eventlog {
=20
 extern int efi_tpm_eventlog_init(void);
=20
+extern unsigned long rci2_table_phys;
+extern int efi_rci2_sysfs_init(void);
+
 /*
  * efi_runtime_service() function identifiers.
  * "NONE" is used by efi_recover_from_page_fault() to check if the page
--=20
2.18.1

--=20
With regards,
Narendra K=
