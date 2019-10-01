Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69EDCC4483
	for <lists+linux-efi@lfdr.de>; Wed,  2 Oct 2019 01:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbfJAXmW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Oct 2019 19:42:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23904 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726960AbfJAXmS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Oct 2019 19:42:18 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x91Ng55C069854
        for <linux-efi@vger.kernel.org>; Tue, 1 Oct 2019 19:42:16 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vcc4eywee-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Tue, 01 Oct 2019 19:42:16 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <nayna@linux.ibm.com>;
        Wed, 2 Oct 2019 00:42:14 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 2 Oct 2019 00:42:10 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x91Ng8CQ49741880
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Oct 2019 23:42:08 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B22BEA405C;
        Tue,  1 Oct 2019 23:42:08 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 266DCA405B;
        Tue,  1 Oct 2019 23:42:06 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.80.224.222])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Oct 2019 23:42:05 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linuxppc-dev@ozlabs.org, linux-efi@vger.kernel.org,
        linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Eric Ricther <erichte@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v4 2/4] powerpc: expose secure variables to userspace via sysfs
Date:   Tue,  1 Oct 2019 19:41:49 -0400
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1569973311-3047-1-git-send-email-nayna@linux.ibm.com>
References: <1569973311-3047-1-git-send-email-nayna@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19100123-0016-0000-0000-000002B324AD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100123-0017-0000-0000-000033142628
Message-Id: <1569973311-3047-3-git-send-email-nayna@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-01_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910010202
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

PowerNV secure variables, which store the keys used for OS kernel
verification, are managed by the firmware. These secure variables need to
be accessed by the userspace for addition/deletion of the certificates.

This patch adds the sysfs interface to expose secure variables for PowerNV
secureboot. The users shall use this interface for manipulating
the keys stored in the secure variables.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/ABI/testing/sysfs-secvar |  37 +++++
 arch/powerpc/Kconfig                   |  10 ++
 arch/powerpc/kernel/Makefile           |   1 +
 arch/powerpc/kernel/secvar-sysfs.c     | 198 +++++++++++++++++++++++++
 4 files changed, 246 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-secvar
 create mode 100644 arch/powerpc/kernel/secvar-sysfs.c

diff --git a/Documentation/ABI/testing/sysfs-secvar b/Documentation/ABI/testing/sysfs-secvar
new file mode 100644
index 000000000000..815bd8ec4d5e
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-secvar
@@ -0,0 +1,37 @@
+What:		/sys/firmware/secvar
+Date:		August 2019
+Contact:	Nayna Jain <nayna@linux.ibm.com>
+Description:	This directory is created if the POWER firmware supports OS
+		secureboot, thereby secure variables. It exposes interface
+		for reading/writing the secure variables
+
+What:		/sys/firmware/secvar/vars
+Date:		August 2019
+Contact:	Nayna Jain <nayna@linux.ibm.com>
+Description:	This directory lists all the secure variables that are supported
+		by the firmware.
+
+What:		/sys/firmware/secvar/vars/<variable name>
+Date:		August 2019
+Contact:	Nayna Jain <nayna@linux.ibm.com>
+Description:	Each secure variable is represented as a directory named as
+		<variable_name>. The variable name is unique and is in ASCII
+		representation. The data and size can be determined by reading
+		their respective attribute files.
+
+What:		/sys/firmware/secvar/vars/<variable_name>/size
+Date:		August 2019
+Contact:	Nayna Jain <nayna@linux.ibm.com>
+Description:	An integer representation of the size of the content of the
+		variable. In other words, it represents the size of the data.
+
+What:		/sys/firmware/secvar/vars/<variable_name>/data
+Date:		August 2019
+Contact:	Nayna Jain <nayna@linux.ibm.com>
+Description:	A read-only file containing the value of the variable
+
+What:		/sys/firmware/secvar/vars/<variable_name>/update
+Date:		August 2019
+Contact:	Nayna Jain <nayna@linux.ibm.com>
+Description:	A write-only file that is used to submit the new value for the
+		variable.
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index deb19ec6ba3d..89084e4e5054 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -946,6 +946,16 @@ config PPC_SECURE_BOOT
 	  to enable OS secure boot on systems that have firmware support for
 	  it. If in doubt say N.
 
+config SECVAR_SYSFS
+	tristate "Enable sysfs interface for POWER secure variables"
+	depends on PPC_SECURE_BOOT
+	depends on SYSFS
+	help
+	  POWER secure variables are managed and controlled by firmware.
+	  These variables are exposed to userspace via sysfs to enable
+	  read/write operations on these variables. Say Y if you have
+	  secure boot enabled and want to expose variables to userspace.
+
 endmenu
 
 config ISA_DMA_API
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 3cf26427334f..116a3a5c0557 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -162,6 +162,7 @@ obj-y				+= ucall.o
 endif
 
 obj-$(CONFIG_PPC_SECURE_BOOT)	+= secure_boot.o ima_arch.o secvar-ops.o
+obj-$(CONFIG_SECVAR_SYSFS)	+= secvar-sysfs.o
 
 # Disable GCOV, KCOV & sanitizers in odd or sensitive code
 GCOV_PROFILE_prom_init.o := n
diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
new file mode 100644
index 000000000000..87a7cea41523
--- /dev/null
+++ b/arch/powerpc/kernel/secvar-sysfs.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2019 IBM Corporation <nayna@linux.ibm.com>
+ *
+ * This code exposes secure variables to user via sysfs
+ */
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/compat.h>
+#include <linux/string.h>
+#include <asm/secvar.h>
+
+/*
+ * Since firmware checks the maximum allowed size, currently, it is default to
+ * 0. In future, it will be read from the device tree.
+ */
+#define VARIABLE_MAX_SIZE  0
+/* Approximate value */
+#define NAME_MAX_SIZE	   1024
+
+static struct kobject *secvar_kobj;
+static struct kset *secvar_kset;
+
+static ssize_t size_show(struct kobject *kobj, struct kobj_attribute *attr,
+			 char *buf)
+{
+	uint64_t dsize;
+	int rc;
+
+	rc = secvar_ops->get(kobj->name, strlen(kobj->name) + 1, NULL, &dsize);
+	if (rc) {
+		pr_err("Error retrieving variable size %d\n", rc);
+		return rc;
+	}
+
+	rc = sprintf(buf, "%llu\n", dsize);
+
+	return rc;
+}
+
+static ssize_t data_read(struct file *filep, struct kobject *kobj,
+			 struct bin_attribute *attr, char *buf, loff_t off,
+			 size_t count)
+{
+	uint64_t dsize;
+	int rc;
+	char *data;
+
+	rc = secvar_ops->get(kobj->name, strlen(kobj->name) + 1, NULL, &dsize);
+	if (rc) {
+		pr_err("Error getting variable size %d\n", rc);
+		return rc;
+	}
+	pr_debug("dsize is %llu\n", dsize);
+
+	data = kzalloc(dsize, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	rc = secvar_ops->get(kobj->name, strlen(kobj->name)+1, data, &dsize);
+	if (rc) {
+		pr_err("Error getting variable %d\n", rc);
+		goto data_fail;
+	}
+
+	rc = memory_read_from_buffer(buf, count, &off, data, dsize);
+
+data_fail:
+	kfree(data);
+	return rc;
+}
+
+static ssize_t update_write(struct file *filep, struct kobject *kobj,
+			    struct bin_attribute *attr, char *buf, loff_t off,
+			    size_t count)
+{
+	int rc;
+
+	pr_debug("count is %ld\n", count);
+	rc = secvar_ops->set(kobj->name, strlen(kobj->name)+1, buf, count);
+	if (rc) {
+		pr_err("Error setting the variable %s\n", kobj->name);
+		return rc;
+	}
+
+	return count;
+}
+
+static struct kobj_attribute size_attr = __ATTR_RO(size);
+
+static struct bin_attribute data_attr = __BIN_ATTR_RO(data, VARIABLE_MAX_SIZE);
+
+static struct bin_attribute update_attr = __BIN_ATTR_WO(update,
+							VARIABLE_MAX_SIZE);
+
+static struct bin_attribute  *secvar_bin_attrs[] = {
+	&data_attr,
+	&update_attr,
+	NULL,
+};
+
+static struct attribute *secvar_attrs[] = {
+	&size_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group secvar_attr_group = {
+	.attrs = secvar_attrs,
+	.bin_attrs = secvar_bin_attrs,
+};
+__ATTRIBUTE_GROUPS(secvar_attr);
+
+static struct kobj_type secvar_ktype = {
+	.sysfs_ops	= &kobj_sysfs_ops,
+	.default_groups = secvar_attr_groups,
+};
+
+static int secvar_sysfs_load(void)
+{
+	char *name;
+	uint64_t namesize = 0;
+	struct kobject *kobj;
+	int rc;
+
+	name = kzalloc(NAME_MAX_SIZE, GFP_KERNEL);
+	if (!name)
+		return -ENOMEM;
+
+	do {
+		rc = secvar_ops->get_next(name, &namesize, NAME_MAX_SIZE);
+		if (rc) {
+			if (rc != -ENOENT)
+				pr_err("error getting secvar from firmware %d\n",
+					rc);
+			break;
+		}
+
+		kobj = kzalloc(sizeof(*kobj), GFP_KERNEL);
+		if (!kobj)
+			return -ENOMEM;
+
+		kobject_init(kobj, &secvar_ktype);
+
+		rc = kobject_add(kobj, &secvar_kset->kobj, "%s", name);
+		if (rc) {
+			pr_warn("kobject_add error %d for attribute: %s\n", rc,
+				name);
+			kobject_put(kobj);
+			kobj = NULL;
+		}
+
+		if (kobj)
+			kobject_uevent(kobj, KOBJ_ADD);
+
+	} while (!rc);
+
+	kfree(name);
+	return rc;
+}
+
+static int secvar_sysfs_init(void)
+{
+	if (!secvar_ops) {
+		pr_warn("secvar: failed to retrieve secvar operations.\n");
+		return -ENODEV;
+	}
+
+	secvar_kobj = kobject_create_and_add("secvar", firmware_kobj);
+	if (!secvar_kobj) {
+		pr_err("secvar: Failed to create firmware kobj\n");
+		return -ENOMEM;
+	}
+
+	secvar_kset = kset_create_and_add("vars", NULL, secvar_kobj);
+	if (!secvar_kset) {
+		pr_err("secvar: sysfs kobject registration failed.\n");
+		kobject_put(secvar_kobj);
+		return -ENOMEM;
+	}
+
+	secvar_sysfs_load();
+
+	return 0;
+}
+
+static void secvar_sysfs_exit(void)
+{
+	kset_unregister(secvar_kset);
+	kobject_put(secvar_kobj);
+}
+
+module_init(secvar_sysfs_init);
+module_exit(secvar_sysfs_exit);
+
+MODULE_AUTHOR("Nayna Jain <nayna@linux.ibm.com>");
+MODULE_DESCRIPTION("sysfs interface to POWER secure variables");
+MODULE_LICENSE("GPL");
-- 
2.20.1

