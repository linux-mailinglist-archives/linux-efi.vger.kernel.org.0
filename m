Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7814444DD5
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jun 2019 22:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbfFMUuu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Jun 2019 16:50:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50000 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730156AbfFMUut (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Jun 2019 16:50:49 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5DKkrap110503
        for <linux-efi@vger.kernel.org>; Thu, 13 Jun 2019 16:50:49 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t3td38c6a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Thu, 13 Jun 2019 16:50:48 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <nayna@linux.ibm.com>;
        Thu, 13 Jun 2019 21:50:46 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 13 Jun 2019 21:50:43 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5DKofZN12255418
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jun 2019 20:50:41 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7A0052052;
        Thu, 13 Jun 2019 20:50:40 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.85.207.125])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E9D4D5204F;
        Thu, 13 Jun 2019 20:50:37 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linuxppc-dev@ozlabs.org, linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Eric Ricther <erichte@linux.ibm.com>
Subject: [PATCH 2/2] powerpc: expose secure variables via sysfs
Date:   Thu, 13 Jun 2019 16:50:27 -0400
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1560459027-5248-1-git-send-email-nayna@linux.ibm.com>
References: <1560459027-5248-1-git-send-email-nayna@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19061320-4275-0000-0000-000003421DD7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061320-4276-0000-0000-00003852391E
Message-Id: <1560459027-5248-3-git-send-email-nayna@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-13_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906130156
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

As part of PowerNV secure boot support, OS verification keys are stored
and controlled by OPAL as secure variables. These need to be exposed to
the userspace so that sysadmins can perform key management tasks.

This patch adds the support to expose secure variables via a sysfs
interface It reuses the the existing efi defined hooks and backend in
order to maintain the compatibility with the userspace tools.

Though it reuses a great deal of efi, POWER platforms do not use EFI.
A new config, POWER_SECVAR_SYSFS, is defined to enable this new sysfs
interface.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 arch/powerpc/Kconfig                 |   2 +
 drivers/firmware/Makefile            |   1 +
 drivers/firmware/efi/efivars.c       |   2 +-
 drivers/firmware/powerpc/Kconfig     |  12 +
 drivers/firmware/powerpc/Makefile    |   3 +
 drivers/firmware/powerpc/efi_error.c |  46 ++++
 drivers/firmware/powerpc/secvar.c    | 326 +++++++++++++++++++++++++++
 7 files changed, 391 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/powerpc/Kconfig
 create mode 100644 drivers/firmware/powerpc/Makefile
 create mode 100644 drivers/firmware/powerpc/efi_error.c
 create mode 100644 drivers/firmware/powerpc/secvar.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 9de77bb14f54..1548dd8cf1a0 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -916,6 +916,8 @@ config PPC_SECURE_BOOT
 	  allows user to enable OS Secure Boot on PowerPC systems that
 	  have firmware secure boot support.
 
+source "drivers/firmware/powerpc/Kconfig"
+
 endmenu
 
 config ISA_DMA_API
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 3fa0b34eb72f..8cfaf7e6769d 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -33,3 +33,4 @@ obj-$(CONFIG_UEFI_CPER)		+= efi/
 obj-y				+= imx/
 obj-y				+= tegra/
 obj-y				+= xilinx/
+obj-$(CONFIG_POWER_SECVAR_SYSFS) += powerpc/
diff --git a/drivers/firmware/efi/efivars.c b/drivers/firmware/efi/efivars.c
index 7576450c8254..30ef53003c24 100644
--- a/drivers/firmware/efi/efivars.c
+++ b/drivers/firmware/efi/efivars.c
@@ -664,7 +664,7 @@ int efivars_sysfs_init(void)
 	struct kobject *parent_kobj = efivars_kobject();
 	int error = 0;
 
-	if (!efi_enabled(EFI_RUNTIME_SERVICES))
+	if (IS_ENABLED(CONFIG_EFI) && !efi_enabled(EFI_RUNTIME_SERVICES))
 		return -ENODEV;
 
 	/* No efivars has been registered yet */
diff --git a/drivers/firmware/powerpc/Kconfig b/drivers/firmware/powerpc/Kconfig
new file mode 100644
index 000000000000..e0303fc517d5
--- /dev/null
+++ b/drivers/firmware/powerpc/Kconfig
@@ -0,0 +1,12 @@
+config POWER_SECVAR_SYSFS
+	tristate "Enable sysfs interface for POWER secure variables"
+	default n
+	depends on PPC_SECURE_BOOT
+	select UCS2_STRING
+	help
+	  POWER secure variables are managed and controlled by OPAL.
+	  These variables are exposed to userspace via sysfs to allow
+	  user to read/write these variables. Say Y if you have secure
+	  boot enabled and want to expose variables to userspace.
+
+source "drivers/firmware/efi/Kconfig"
diff --git a/drivers/firmware/powerpc/Makefile b/drivers/firmware/powerpc/Makefile
new file mode 100644
index 000000000000..d5fa3b007315
--- /dev/null
+++ b/drivers/firmware/powerpc/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_POWER_SECVAR_SYSFS) += ../efi/efivars.o efi_error.o ../efi/vars.o secvar.o
diff --git a/drivers/firmware/powerpc/efi_error.c b/drivers/firmware/powerpc/efi_error.c
new file mode 100644
index 000000000000..b5cabd52e6b4
--- /dev/null
+++ b/drivers/firmware/powerpc/efi_error.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 IBM Corporation
+ * Author: Nayna Jain <nayna@linux.ibm.com>
+ *
+ * efi_error.c
+ *      - Error codes as understood by efi based tools
+ *      Taken from drivers/firmware/efi/efi.c
+ */
+#include<linux/efi.h>
+
+int efi_status_to_err(efi_status_t status)
+{
+	int err;
+
+	switch (status) {
+	case EFI_SUCCESS:
+		err = 0;
+		break;
+	case EFI_INVALID_PARAMETER:
+		err = -EINVAL;
+		break;
+	case EFI_OUT_OF_RESOURCES:
+		err = -ENOSPC;
+		break;
+	case EFI_DEVICE_ERROR:
+		err = -EIO;
+		break;
+	case EFI_WRITE_PROTECTED:
+		err = -EROFS;
+		break;
+	case EFI_SECURITY_VIOLATION:
+		err = -EACCES;
+		break;
+	case EFI_NOT_FOUND:
+		err = -ENOENT;
+		break;
+	case EFI_ABORTED:
+		err = -EINTR;
+		break;
+	default:
+		err = -EINVAL;
+	}
+
+	return err;
+}
diff --git a/drivers/firmware/powerpc/secvar.c b/drivers/firmware/powerpc/secvar.c
new file mode 100644
index 000000000000..f1f134a0bb7c
--- /dev/null
+++ b/drivers/firmware/powerpc/secvar.c
@@ -0,0 +1,326 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 IBM Corporation
+ * Author: Nayna Jain <nayna@linux.ibm.com>
+ *
+ * secvar.c
+ * - wrappers to expose secure variables to userspace
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/spinlock.h>
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/ioctl.h>
+#include <linux/uaccess.h>
+#include <linux/kdebug.h>
+#include <linux/efi.h>
+#include <linux/module.h>
+#include <linux/ucs2_string.h>
+#include <asm/opal-secvar.h>
+#include <asm/opal.h>
+
+static struct efivars efivars;
+struct kobject *powerpc_kobj;
+
+efi_status_t opal_to_efi_status_log(int rc, const char *func_name)
+{
+	efi_status_t status;
+
+	switch (rc) {
+	case OPAL_EMPTY:
+		status = EFI_NOT_FOUND;
+		break;
+	case OPAL_HARDWARE:
+		status = EFI_DEVICE_ERROR;
+		break;
+	case OPAL_NO_MEM:
+		pr_err("%s: No space in the volatile storage\n", func_name);
+		status = EFI_OUT_OF_RESOURCES;
+		break;
+	case OPAL_PARAMETER:
+		status = EFI_INVALID_PARAMETER;
+		break;
+	case OPAL_PARTIAL:
+		status = EFI_BUFFER_TOO_SMALL;
+		break;
+	case OPAL_PERMISSION:
+		status = EFI_WRITE_PROTECTED;
+		break;
+	case OPAL_RESOURCE:
+		pr_err("%s: No space in the non-volatile storage\n", func_name);
+		status = EFI_OUT_OF_RESOURCES;
+		break;
+	case OPAL_SUCCESS:
+		status = EFI_SUCCESS;
+		break;
+	default:
+		pr_err("%s: Unknown OPAL error %d\n", func_name, rc);
+		status = EFI_DEVICE_ERROR;
+		break;
+	}
+
+	return status;
+}
+
+#define opal_to_efi_status(rc) opal_to_efi_status_log(rc, __func__)
+
+static void createkey(efi_char16_t *name, u8 **key, unsigned long *keylen)
+{
+	*keylen = ucs2_utf8size(name) + 1;
+
+	*key = kzalloc(*keylen, GFP_KERNEL);
+	if (!*key) {
+		*keylen = 0;
+		*key = NULL;
+		return;
+	}
+
+	ucs2_as_utf8(*key, name, *keylen);
+}
+
+static void createmetadata(efi_char16_t *name, efi_guid_t *vendor, u32 *attr,
+			   u8 **mdata, unsigned long *mdsize)
+{
+	int size = 0;
+
+	*mdsize = ucs2_strsize(name, 1024) + sizeof(efi_guid_t) + sizeof(u32);
+	*mdata = kzalloc(*mdsize, GFP_KERNEL);
+
+	memcpy(*mdata, name, ucs2_strsize(name, 1024));
+	size = ucs2_strsize(name, 1024);
+
+	memcpy(*mdata + size, vendor, sizeof(efi_guid_t));
+	size += sizeof(efi_guid_t);
+
+	if (attr != NULL)
+		memcpy(*mdata + size, attr, sizeof(u32));
+	else
+		memset(*mdata + size, 0, sizeof(u32));
+}
+
+static int convert_buffer_to_efi_guid(u8 *buffer, efi_guid_t *guid)
+{
+	u32 *a1;
+	u16 *a2;
+	u16 *a3;
+
+	a1 = kzalloc(4, GFP_KERNEL);
+	memcpy(a1, buffer, 4);
+	*a1 = be32_to_cpu(*a1);
+
+	a2 = kzalloc(2, GFP_KERNEL);
+	memcpy(a2, buffer+4, 2);
+	*a2 = be16_to_cpu(*a2);
+
+	a3 = kzalloc(2, GFP_KERNEL);
+	memcpy(a3, buffer+6, 2);
+	*a3 = be16_to_cpu(*a3);
+
+	*guid = EFI_GUID(*a1, *a2, *a3, *(buffer + 8),
+			*(buffer + 9),
+			*(buffer + 10),
+			*(buffer + 11),
+			*(buffer + 12),
+			*(buffer + 13),
+			*(buffer + 14),
+			*(buffer + 15));
+
+	kfree(a1);
+	kfree(a2);
+	kfree(a3);
+	return 0;
+}
+
+static efi_status_t powerpc_get_variable(efi_char16_t *name, efi_guid_t *vendor,
+					 u32 *attr, unsigned long *data_size,
+					 void *data)
+{
+	int rc;
+	u8 *key;
+	unsigned long keylen;
+	u8 *metadata;
+	unsigned long mdsize;
+	unsigned long dsize;
+	unsigned long namesize;
+
+	if (!name)
+		return EFI_INVALID_PARAMETER;
+
+	if (!vendor)
+		return EFI_INVALID_PARAMETER;
+
+	if (*data_size == 0) {
+		/* If *data_size is zero, it implies data size is being asked */
+		createkey(name, &key, &keylen);
+		rc = opal_get_variable_size(key, keylen, &mdsize, &dsize);
+		*data_size = dsize;
+		kfree(key);
+		return opal_to_efi_status(rc);
+	}
+
+	createkey(name, &key, &keylen);
+	createmetadata(name, vendor, attr, &metadata, &mdsize);
+
+	rc = opal_get_variable(key, keylen, metadata, &mdsize, data, data_size);
+
+	if (rc)
+		return opal_to_efi_status(rc);
+
+	if (mdsize > 0) {
+		namesize = mdsize - sizeof(efi_guid_t) - sizeof(u32);
+		if (!attr)
+			return opal_to_efi_status(rc);
+		memset(attr, 0, sizeof(u32));
+		memcpy(attr, metadata + namesize + sizeof(efi_guid_t),
+		       sizeof(u32));
+		*attr = be32_to_cpu(*attr);
+	}
+
+	kfree(key);
+	kfree(metadata);
+
+	return opal_to_efi_status(rc);
+}
+
+
+static efi_status_t powerpc_get_next_variable(unsigned long *name_size,
+					      efi_char16_t *name,
+					      efi_guid_t *vendor)
+{
+	int rc;
+	u8 *key;
+	int namesize;
+	unsigned long keylen;
+	unsigned long keysize = 1024;
+	unsigned long *mdsize;
+	u8 *mdata = NULL;
+	efi_guid_t guid;
+
+	if (ucs2_strnlen(name, 1024) > 0) {
+		createkey(name, &key, &keylen);
+	} else {
+		keylen = 0;
+		key = kzalloc(1024, GFP_KERNEL);
+	}
+
+	pr_info("%s: powerpc get next variable, key is %s\n", __func__, key);
+
+	rc = opal_get_next_variable(key, &keylen, keysize);
+	if (rc) {
+		kfree(key);
+		return opal_to_efi_status(rc);
+	}
+
+	mdsize = kzalloc(sizeof(unsigned long), GFP_KERNEL);
+	rc = opal_get_variable_size(key, keylen, mdsize, NULL);
+	if (rc)
+		goto out;
+
+	if (*mdsize <= 0)
+		goto out;
+
+	mdata = kzalloc(*mdsize, GFP_KERNEL);
+
+	rc = opal_get_variable(key, keylen, mdata, mdsize, NULL, NULL);
+	if (rc)
+		goto out;
+
+	if (*mdsize > 0) {
+		namesize = *mdsize - sizeof(efi_guid_t) - sizeof(u32);
+		if (namesize > 0) {
+			memset(&guid, 0, sizeof(efi_guid_t));
+			convert_buffer_to_efi_guid(mdata + namesize, &guid);
+			memcpy(vendor, &guid, sizeof(efi_guid_t));
+			memset(name, 0, namesize + 2);
+			memcpy(name, mdata, namesize);
+			*name_size = namesize + 2;
+			name[namesize++] = 0;
+			name[namesize] = 0;
+		}
+	}
+
+out:
+	kfree(mdsize);
+	kfree(mdata);
+
+	return opal_to_efi_status(rc);
+}
+
+static efi_status_t powerpc_set_variable(efi_char16_t *name, efi_guid_t *vendor,
+					 u32 attr, unsigned long data_size,
+					 void *data)
+{
+	int rc;
+	u8 *key;
+	unsigned long keylen;
+	u8 *metadata;
+	unsigned long mdsize;
+
+	if (!name)
+		return EFI_INVALID_PARAMETER;
+
+	if (!vendor)
+		return EFI_INVALID_PARAMETER;
+
+	createkey(name, &key, &keylen);
+	pr_info("%s: nayna key is %s\n", __func__, key);
+
+	createmetadata(name, vendor, &attr, &metadata, &mdsize);
+
+	rc = opal_set_variable(key, keylen, metadata, mdsize, data, data_size);
+
+	return opal_to_efi_status(rc);
+}
+
+
+static const struct efivar_operations efivar_ops = {
+	.get_variable = powerpc_get_variable,
+	.set_variable = powerpc_set_variable,
+	.get_next_variable = powerpc_get_next_variable,
+};
+
+
+static __init int power_secvar_init(void)
+{
+	int rc = 0;
+	unsigned long ver = 0;
+
+	rc = opal_variable_version(&ver);
+	if (ver != BACKEND_TC_COMPAT_V1) {
+		pr_info("Compatible backend unsupported\n");
+		return -1;
+	}
+
+	powerpc_kobj = kobject_create_and_add("secvar", firmware_kobj);
+	if (!powerpc_kobj) {
+		pr_info("secvar: Failed to create firmware kobj\n");
+		goto out_err;
+	}
+
+	rc = efivars_register(&efivars, &efivar_ops, powerpc_kobj);
+	if (rc) {
+		pr_info("powerpc: Failed to register efivars\n");
+		return rc;
+	}
+
+	return 0;
+out_err:
+	kobject_put(powerpc_kobj);
+	pr_info("powerpc: failed to load: %d\n", rc);
+	return rc;
+}
+arch_initcall(power_secvar_init);
+
+static void __exit power_secvar_exit(void)
+{
+	efivars_unregister(&efivars);
+	kobject_put(powerpc_kobj);
+}
+module_exit(power_secvar_exit);
+
+MODULE_AUTHOR("Nayna Jain");
+MODULE_LICENSE("GPL");
-- 
2.20.1

