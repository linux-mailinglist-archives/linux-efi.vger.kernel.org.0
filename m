Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1A9397E2D
	for <lists+linux-efi@lfdr.de>; Wed, 21 Aug 2019 17:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbfHUPI5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Aug 2019 11:08:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49510 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729820AbfHUPIv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Aug 2019 11:08:51 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7LF0hN3015072
        for <linux-efi@vger.kernel.org>; Wed, 21 Aug 2019 11:08:51 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uh87kghqu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Wed, 21 Aug 2019 11:08:50 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <nayna@linux.ibm.com>;
        Wed, 21 Aug 2019 16:08:46 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 21 Aug 2019 16:08:41 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7LF8JrV25559482
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 15:08:19 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7FF0AA406E;
        Wed, 21 Aug 2019 15:08:39 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 094CEA4040;
        Wed, 21 Aug 2019 15:08:37 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.85.158.102])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 21 Aug 2019 15:08:36 +0000 (GMT)
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
Subject: [PATCH v2 2/4] powerpc: expose secure variables to userspace via sysfs
Date:   Wed, 21 Aug 2019 11:08:21 -0400
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1566400103-18201-1-git-send-email-nayna@linux.ibm.com>
References: <1566400103-18201-1-git-send-email-nayna@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19082115-4275-0000-0000-0000035B8B0A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082115-4276-0000-0000-0000386DAEA1
Message-Id: <1566400103-18201-3-git-send-email-nayna@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-21_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908210160
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
---
 Documentation/ABI/testing/sysfs-secvar |  27 ++++
 arch/powerpc/Kconfig                   |   9 ++
 arch/powerpc/kernel/Makefile           |   1 +
 arch/powerpc/kernel/secvar-sysfs.c     | 210 +++++++++++++++++++++++++
 4 files changed, 247 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-secvar
 create mode 100644 arch/powerpc/kernel/secvar-sysfs.c

diff --git a/Documentation/ABI/testing/sysfs-secvar b/Documentation/ABI/testing/sysfs-secvar
new file mode 100644
index 000000000000..68f0e03d873d
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-secvar
@@ -0,0 +1,27 @@
+What:		/sys/firmware/secvar
+Date:		August 2019
+Contact:	Nayna Jain <nayna@linux.ibm.com>
+Description:
+		This directory exposes interfaces for interacting with
+		the secure variables managed by OPAL firmware.
+
+		This is only for the powerpc/powernv platform.
+
+		Directory:
+		vars:		This directory lists all the variables that
+				are supported by the OPAL. The variables are
+				represented in the form of directories with
+				their variable names. The variable name is
+				unique and is in ASCII representation. The data
+				and size can be determined by reading their
+				respective attribute files.
+
+		Each variable directory has the following files:
+		name:		An ASCII representation of the variable name
+		data:		A read-only file containing the value of the
+				variable
+		size:		An integer representation of the size of the
+				content of the variable. In other works, it
+				represents the size of the data
+		update:		A write-only file that is used to submit the new
+				value for the variable.
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 42109682b727..b4bdf77837b2 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -925,6 +925,15 @@ config PPC_SECURE_BOOT
 	  allows user to enable OS Secure Boot on PowerPC systems that
 	  have firmware secure boot support.
 
+config SECVAR_SYSFS
+        tristate "Enable sysfs interface for POWER secure variables"
+        depends on PPC_SECURE_BOOT
+        help
+          POWER secure variables are managed and controlled by firmware.
+          These variables are exposed to userspace via sysfs to enable
+          read/write operations on these variables. Say Y if you have
+	  secure boot enabled and want to expose variables to userspace.
+
 endmenu
 
 config ISA_DMA_API
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 9041563f1c74..4ea7b738c3a3 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -158,6 +158,7 @@ obj-$(CONFIG_EPAPR_PARAVIRT)	+= epapr_paravirt.o epapr_hcalls.o
 obj-$(CONFIG_KVM_GUEST)		+= kvm.o kvm_emul.o
 
 obj-$(CONFIG_PPC_SECURE_BOOT)	+= secboot.o ima_arch.o secvar-ops.o
+obj-$(CONFIG_SECVAR_SYSFS)     += secvar-sysfs.o
 
 # Disable GCOV, KCOV & sanitizers in odd or sensitive code
 GCOV_PROFILE_prom_init.o := n
diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
new file mode 100644
index 000000000000..e46986bb29a0
--- /dev/null
+++ b/arch/powerpc/kernel/secvar-sysfs.c
@@ -0,0 +1,210 @@
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
+#include <asm/opal.h>
+#include <asm/secvar.h>
+
+//Approximating it for now, it is bound to change.
+#define VARIABLE_MAX_SIZE  32000
+
+static struct kobject *powerpc_kobj;
+static struct secvar_operations *secvarops;
+struct kset *secvar_kset;
+
+static ssize_t name_show(struct kobject *kobj, struct kobj_attribute *attr,
+			 char *buf)
+{
+	return sprintf(buf, "%s", kobj->name);
+}
+
+static ssize_t size_show(struct kobject *kobj, struct kobj_attribute *attr,
+			 char *buf)
+{
+	unsigned long dsize;
+	int rc;
+
+	rc = secvarops->get_variable(kobj->name, strlen(kobj->name) + 1, NULL,
+				     &dsize);
+	if (rc) {
+		pr_err("Error retrieving variable size %d\n", rc);
+		return rc;
+	}
+
+	rc = sprintf(buf, "%ld", dsize);
+
+	return rc;
+}
+
+static ssize_t data_read(struct file *filep, struct kobject *kobj,
+			 struct bin_attribute *attr, char *buf, loff_t off,
+			 size_t count)
+{
+	unsigned long dsize;
+	int rc;
+	char *data;
+
+	rc = secvarops->get_variable(kobj->name, strlen(kobj->name) + 1, NULL,
+				     &dsize);
+	if (rc) {
+		pr_err("Error getting variable size %d\n", rc);
+		return rc;
+	}
+	pr_debug("dsize is %ld\n", dsize);
+
+	data = kzalloc(dsize, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	rc = secvarops->get_variable(kobj->name, strlen(kobj->name)+1, data,
+				     &dsize);
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
+	rc = secvarops->set_variable(kobj->name, strlen(kobj->name)+1, buf,
+				     count);
+	if (rc) {
+		pr_err("Error setting the variable %s\n", kobj->name);
+		return rc;
+	}
+
+	return count;
+}
+
+static struct kobj_attribute name_attr =
+__ATTR(name, 0444, name_show, NULL);
+
+static struct kobj_attribute size_attr =
+__ATTR(size, 0444, size_show, NULL);
+
+static struct bin_attribute data_attr = {
+	.attr = {.name = "data", .mode = 0444},
+	.size = VARIABLE_MAX_SIZE,
+	.read = data_read,
+};
+
+
+static struct bin_attribute update_attr = {
+	.attr = {.name = "update", .mode = 0200},
+	.size = VARIABLE_MAX_SIZE,
+	.write = update_write,
+};
+
+static struct bin_attribute  *secvar_bin_attrs[] = {
+	&data_attr,
+	&update_attr,
+	NULL,
+};
+
+static struct attribute *secvar_attrs[] = {
+	&name_attr.attr,
+	&size_attr.attr,
+	NULL,
+};
+
+const struct attribute_group secvar_attr_group = {
+	.attrs = secvar_attrs,
+	.bin_attrs = secvar_bin_attrs,
+};
+
+int secvar_sysfs_load(void)
+{
+
+	char *name;
+	unsigned long namesize;
+	struct kobject *kobj;
+	int status;
+	int rc = 0;
+
+	name = kzalloc(1024, GFP_KERNEL);
+	if (!name)
+		return -ENOMEM;
+
+	do {
+
+		status = secvarops->get_next_variable(name, &namesize, 1024);
+		if (status != OPAL_SUCCESS)
+			break;
+
+		pr_info("name is %s\n", name);
+		kobj = kobject_create_and_add(name, &(secvar_kset->kobj));
+		if (kobj) {
+			rc = sysfs_create_group(kobj, &secvar_attr_group);
+			if (rc)
+				pr_err("Error creating attributes for %s variable\n",
+				name);
+		} else {
+			pr_err("Error creating sysfs entry for %s variable\n",
+				name);
+			rc = -EINVAL;
+		}
+
+	} while ((status == OPAL_SUCCESS) && (rc == 0));
+
+	kfree(name);
+	return rc;
+}
+
+int secvar_sysfs_init(void)
+{
+	powerpc_kobj = kobject_create_and_add("secvar", firmware_kobj);
+	if (!powerpc_kobj) {
+		pr_err("secvar: Failed to create firmware kobj\n");
+		return -ENODEV;
+	}
+
+	secvar_kset = kset_create_and_add("vars", NULL, powerpc_kobj);
+	if (!secvar_kset) {
+		pr_err("secvar: sysfs kobject registration failed.\n");
+		return -ENODEV;
+	}
+
+	secvarops = get_secvar_ops();
+	if (!secvarops) {
+		kobject_put(powerpc_kobj);
+		pr_err("secvar: failed to retrieve secvar operations.\n");
+		return -ENODEV;
+	}
+
+	secvar_sysfs_load();
+	pr_info("Secure variables sysfs initialized");
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(secvar_sysfs_init);
+
+static void secvar_sysfs_exit(void)
+{
+	kobject_put(powerpc_kobj);
+}
+EXPORT_SYMBOL_GPL(secvar_sysfs_exit);
+
+module_init(secvar_sysfs_init);
+module_exit(secvar_sysfs_exit);
+
+MODULE_AUTHOR("Nayna Jain<nayna@linux.ibm.com>");
+MODULE_DESCRIPTION("sysfs interface to POWER secure variables");
+MODULE_LICENSE("GPL");
-- 
2.20.1

