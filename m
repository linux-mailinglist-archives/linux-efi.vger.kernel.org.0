Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87ABF47F57
	for <lists+linux-efi@lfdr.de>; Mon, 17 Jun 2019 12:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfFQKLz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Jun 2019 06:11:55 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:41456 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727952AbfFQKLy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Jun 2019 06:11:54 -0400
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5HA5Uoj029799
        for <linux-efi@vger.kernel.org>; Mon, 17 Jun 2019 06:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=3QJSWTvMCxmIlidA5FLsR+IdaD8Bvb3Epg6BRMYYtwg=;
 b=i0m6SYp+s7ROlr3Mlp14JPzjgjj9dvlNVY8Vb6Jy9nd6mPgzX7EU/iimOFrL605wqZYN
 L8EROAgB2oQmWRymE7C3K/1itr6ZvJs+9Q6odLzaKF+WWI7KkmnL+lXQvruQfXqc1Gh3
 TYANSr/uhwFMo00lY4zeJSOqn7V64Ul/HtRXBQIcLdtv53aXE45hFHd6BNTMYVXfhazk
 PLXxuJqR8AKb4lYuuBEPJRJgKFiN0e+n4csc8SViXuvBeKcv/ocQrhXLpIMp7hNP6fX1
 SWP0LsubawcRNY+i/ELBIdGkQZbAL9LCtejtHee/4glLJfPlqasFYQ6f1joUWiJapbfn bw== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 2t4uw91c4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Mon, 17 Jun 2019 06:11:52 -0400
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5HA8NCC161734
        for <linux-efi@vger.kernel.org>; Mon, 17 Jun 2019 06:11:51 -0400
Received: from ausc60pc101.us.dell.com (ausc60pc101.us.dell.com [143.166.85.206])
        by mx0a-00154901.pphosted.com with ESMTP id 2t65peu2us-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-efi@vger.kernel.org>; Mon, 17 Jun 2019 06:11:51 -0400
X-LoopCount0: from 10.166.136.212
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="1424180882"
From:   <Narendra.K@dell.com>
To:     <linux-efi@vger.kernel.org>
CC:     <Narendra.K@dell.com>
Subject: [RFC PATCH] Export Runtime Configuration Interface table to sysfs
Thread-Topic: [RFC PATCH] Export Runtime Configuration Interface table to
 sysfs
Thread-Index: AQHVJPURJUa43Zv1v02xbnzCeW3iXQ==
Date:   Mon, 17 Jun 2019 10:11:45 +0000
Message-ID: <20190617101134.GA2242@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BC351C516552E241AFF9D658BA824ECF@dell.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-17_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906170095
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906170095
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
Hi, the patch is created on kernel version 5.2-rc4. It applies to
5.2-rc5 also. If the approach looks correct, I will resubmit with RFC
tag removed. =20

 Documentation/ABI/testing/sysfs-firmware-efi |   9 ++
 drivers/firmware/efi/Makefile                |   2 +-
 drivers/firmware/efi/efi.c                   |  20 ++-
 drivers/firmware/efi/rci2_table.c            | 148 +++++++++++++++++++
 include/linux/efi.h                          |   7 +
 5 files changed, 184 insertions(+), 2 deletions(-)
 create mode 100644 drivers/firmware/efi/rci2_table.c

diff --git a/Documentation/ABI/testing/sysfs-firmware-efi b/Documentation/A=
BI/testing/sysfs-firmware-efi
index e794eac32a90..cb887b5e10cb 100644
--- a/Documentation/ABI/testing/sysfs-firmware-efi
+++ b/Documentation/ABI/testing/sysfs-firmware-efi
@@ -28,3 +28,12 @@ Description:	Displays the physical addresses of all EFI =
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
+
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
index 16b2137d117c..2fe114ff8149 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -53,6 +53,7 @@ struct efi __read_mostly efi =3D {
 	.rng_seed		=3D EFI_INVALID_TABLE_ADDR,
 	.tpm_log		=3D EFI_INVALID_TABLE_ADDR,
 	.mem_reserve		=3D EFI_INVALID_TABLE_ADDR,
+	.rci2			=3D EFI_INVALID_TABLE_ADDR,
 };
 EXPORT_SYMBOL(efi);
=20
@@ -73,6 +74,7 @@ static unsigned long *efi_tables[] =3D {
 	&efi.esrt,
 	&efi.properties_table,
 	&efi.mem_attr_table,
+	&efi.rci2,
 };
=20
 struct mm_struct efi_mm =3D {
@@ -384,6 +386,9 @@ static int __init efisubsys_init(void)
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
@@ -488,6 +493,12 @@ static __initdata efi_config_table_type_t common_table=
s[] =3D {
 	{NULL_GUID, NULL, NULL},
 };
=20
+/* OEM Tables */
+static __initdata efi_config_table_type_t oem_tables[] =3D {
+	{DELLEMC_EFI_RCI2_TABLE_GUID, "RCI2", &efi.rci2},
+	{NULL_GUID, NULL, NULL},
+};
+
 static __init int match_config_table(efi_guid_t *guid,
 				     unsigned long table,
 				     efi_config_table_type_t *table_types)
@@ -538,8 +549,10 @@ int __init efi_config_parse_tables(void *config_tables=
, int count, int sz,
 			table =3D ((efi_config_table_32_t *)tablep)->table;
 		}
=20
-		if (!match_config_table(&guid, table, common_tables))
+		if (!match_config_table(&guid, table, common_tables)) {
 			match_config_table(&guid, table, arch_tables);
+			match_config_table(&guid, table, oem_tables);
+		}
=20
 		tablep +=3D sz;
 	}
@@ -627,6 +640,11 @@ int __init efi_config_parse_tables(void *config_tables=
, int count, int sz,
 		}
 	}
=20
+	if (efi.rci2 !=3D EFI_INVALID_TABLE_ADDR)
+		efi_rci2_table_init();
+	else
+		pr_debug("EFI RCI2 table address not found\n");
+
 	return 0;
 }
=20
diff --git a/drivers/firmware/efi/rci2_table.c b/drivers/firmware/efi/rci2_=
table.c
new file mode 100644
index 000000000000..b18354d5b81e
--- /dev/null
+++ b/drivers/firmware/efi/rci2_table.c
@@ -0,0 +1,148 @@
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
+
+int __init efi_rci2_table_init(void)
+{
+	rci2_base =3D early_memremap(efi.rci2,
+				   sizeof(struct rci2_table_global_hdr));
+	if (!rci2_base) {
+		pr_debug("RCI2 table init failed - could not map RCI2 table\n");
+		return -ENOMEM;
+	}
+
+	if (strncmp(rci2_base +
+		    offsetof(struct rci2_table_global_hdr, rci2_sig),
+		    RCI_SIGNATURE, 4)) {
+		memunmap(rci2_base);
+		pr_debug("RCI2 table init failed - incorrect signature\n");
+		return -ENODEV;
+	}
+
+	rci2_table_len =3D *(u32 *)(rci2_base +
+				  offsetof(struct rci2_table_global_hdr,
+				  rci2_len));
+
+	early_memunmap(rci2_base, sizeof(struct rci2_table_global_hdr));
+
+	return 0;
+}
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
+	if (!rci2_table_len)
+		goto err;
+
+	rci2_base =3D memremap(efi.rci2, rci2_table_len, MEMREMAP_WB);
+	if (!rci2_base) {
+		pr_debug("RCI2 table - could not map RCI2 table\n");
+		return -ENOMEM;
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
index 6ebc2098cfe1..3a3f37ee5c48 100644
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
@@ -997,6 +1000,7 @@ extern struct efi {
 	unsigned long rng_seed;		/* UEFI firmware random seed */
 	unsigned long tpm_log;		/* TPM2 Event Log table */
 	unsigned long mem_reserve;	/* Linux EFI memreserve table */
+	unsigned long rci2;		/* Dell EMC EFI RCI2 Table */
 	efi_get_time_t *get_time;
 	efi_set_time_t *set_time;
 	efi_get_wakeup_time_t *get_wakeup_time;
@@ -1712,6 +1716,9 @@ struct linux_efi_tpm_eventlog {
=20
 extern int efi_tpm_eventlog_init(void);
=20
+extern int efi_rci2_table_init(void);
+extern int efi_rci2_sysfs_init(void);
+
 /*
  * efi_runtime_service() function identifiers.
  * "NONE" is used by efi_recover_from_page_fault() to check if the page
--=20
2.18.1

With regards,
Narendra K=
