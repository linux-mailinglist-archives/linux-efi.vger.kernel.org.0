Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0EBC3B6888
	for <lists+linux-efi@lfdr.de>; Mon, 28 Jun 2021 20:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbhF1Sh2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 28 Jun 2021 14:37:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45672 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234624AbhF1Sh0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 28 Jun 2021 14:37:26 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15SIXdJK187365;
        Mon, 28 Jun 2021 14:34:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=jTW9aXV9hpAT0u3TVnTxQaFhbAwOxCLKiv0NzipVvUE=;
 b=iOW3subQBm2/OhoOgFj41aQ+mRxjvGjiHcr2cpvKHN5ZVnsdDRSg0s7yHdFTCNtBxT0Z
 znmQ46iKIuTQvbcLtV2MqEKiajkMM+gbRYBE8Md6fqBceT3+WA/bUMjDVizM1D/kHH3V
 v0AlglRETRfUNJoCjDn8UbEfzoJLCu+UGoXS/u6RP4Xu4/n7ZbqAHGL41me6pMxuseN8
 iFGg3ualIzvJ/rWIV07K12fQRpEQn1MiovgFCoyxRUqvSVmzUrLO3Hk9yjMpAGlHD+Ws
 sgey1EoExSkW4wRFgXqwzVcazWUcVMkElTMRQkszbAF8bvSAcPe/HSl6fdqORhAnG29l +A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39fcgaen5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 14:34:47 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15SIYDVZ188171;
        Mon, 28 Jun 2021 14:34:46 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39fcgaen54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 14:34:46 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15SIREs0014537;
        Mon, 28 Jun 2021 18:34:45 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma01dal.us.ibm.com with ESMTP id 39duvbq0wq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 18:34:45 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15SIYill34799978
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 18:34:44 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D5D3AC066;
        Mon, 28 Jun 2021 18:34:44 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBC2AAC05E;
        Mon, 28 Jun 2021 18:34:43 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.2.130.16])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 28 Jun 2021 18:34:43 +0000 (GMT)
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
Subject: [RFC PATCH v2 3/3] virt: Add sev_secret module to expose confidential computing secrets
Date:   Mon, 28 Jun 2021 18:34:31 +0000
Message-Id: <20210628183431.953934-4-dovmurik@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210628183431.953934-1-dovmurik@linux.ibm.com>
References: <20210628183431.953934-1-dovmurik@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Fe-wtuHfLriIPrLX_Bl1P29ufqF5ZvWX
X-Proofpoint-GUID: ESaWOHJy8_qcsWKX87Ys8A0mrOxN1xrK
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-28_14:2021-06-25,2021-06-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106280121
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The new sev_secret module exposes the confidential computing secret area
via securityfs interface.

When the module is loaded (and securityfs is mounted, typically under
/sys/kernel/security), an "sev_secret" directory is created in
securityfs.  In it, a file is created for each secret entry.  The name
of each such file is the GUID of the secret entry, and its content is
the secret data.

This allows applications running in a confidential computing setting to
read secrets provided by the guest owner via a secure secret injection
mechanism (such as AMD SEV's LAUNCH_SECRET command).

Removing (unlinking) files in the "sev_secret" directory will zero out
the secret in memory, and remove the filesystem entry.  If the module
is removed and loaded again, that secret will not appear in the
filesystem.

Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>
---
 drivers/virt/Kconfig                 |   2 +
 drivers/virt/Makefile                |   1 +
 drivers/virt/sev_secret/Kconfig      |  11 +
 drivers/virt/sev_secret/Makefile     |   2 +
 drivers/virt/sev_secret/sev_secret.c | 298 +++++++++++++++++++++++++++
 5 files changed, 314 insertions(+)
 create mode 100644 drivers/virt/sev_secret/Kconfig
 create mode 100644 drivers/virt/sev_secret/Makefile
 create mode 100644 drivers/virt/sev_secret/sev_secret.c

diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
index 8061e8ef449f..c222cc625891 100644
--- a/drivers/virt/Kconfig
+++ b/drivers/virt/Kconfig
@@ -36,4 +36,6 @@ source "drivers/virt/vboxguest/Kconfig"
 source "drivers/virt/nitro_enclaves/Kconfig"
 
 source "drivers/virt/acrn/Kconfig"
+
+source "drivers/virt/sev_secret/Kconfig"
 endif
diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
index 3e272ea60cd9..0765e5418d1d 100644
--- a/drivers/virt/Makefile
+++ b/drivers/virt/Makefile
@@ -8,3 +8,4 @@ obj-y				+= vboxguest/
 
 obj-$(CONFIG_NITRO_ENCLAVES)	+= nitro_enclaves/
 obj-$(CONFIG_ACRN_HSM)		+= acrn/
+obj-y				+= sev_secret/
diff --git a/drivers/virt/sev_secret/Kconfig b/drivers/virt/sev_secret/Kconfig
new file mode 100644
index 000000000000..4505526b8ef1
--- /dev/null
+++ b/drivers/virt/sev_secret/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config AMD_SEV_SECRET_SECURITYFS
+	tristate "AMD SEV secret area securityfs support"
+	depends on EFI
+	select SECURITYFS
+	help
+	  This is a driver for accessing the AMD SEV secret area via
+	  securityfs.
+
+	  To compile this driver as a module, choose M here.
+	  The module will be called sev_secret.
diff --git a/drivers/virt/sev_secret/Makefile b/drivers/virt/sev_secret/Makefile
new file mode 100644
index 000000000000..9671f7bb3941
--- /dev/null
+++ b/drivers/virt/sev_secret/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_AMD_SEV_SECRET_SECURITYFS) += sev_secret.o
diff --git a/drivers/virt/sev_secret/sev_secret.c b/drivers/virt/sev_secret/sev_secret.c
new file mode 100644
index 000000000000..11a2d41f4711
--- /dev/null
+++ b/drivers/virt/sev_secret/sev_secret.c
@@ -0,0 +1,298 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * sev_secret module
+ *
+ * Copyright (C) 2021 IBM Corporation
+ * Author: Dov Murik <dovmurik@linux.ibm.com>
+ */
+
+#include <linux/seq_file.h>
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/security.h>
+#include <linux/efi.h>
+
+/**
+ * sev_secret: Allow reading confidential computing secret area via securityfs
+ * interface.
+ *
+ * When the module is loaded (and securityfs is mounted, typically under
+ * /sys/kernel/security), an "sev_secret" directory is created in securityfs.
+ * In it, a file is created for each secret entry.  The name of each such file
+ * is the GUID of the secret entry, and its content is the secret data.
+ */
+
+#define SEV_SECRET_NUM_FILES 64
+
+#define EFI_SEVSECRET_TABLE_HEADER_GUID \
+	EFI_GUID(0x1e74f542, 0x71dd, 0x4d66, 0x96, 0x3e, 0xef, 0x42, 0x87, 0xff, 0x17, 0x3b)
+
+struct sev_secret {
+	struct dentry *fs_dir;
+	struct dentry *fs_files[SEV_SECRET_NUM_FILES];
+	struct linux_efi_confidential_computing_secret_area *secret_area;
+};
+
+/*
+ * Structure of the SEV secret area
+ *
+ * Offset   Length
+ * (bytes)  (bytes)  Usage
+ * -------  -------  -----
+ *       0       16  Secret table header GUID (must be 1e74f542-71dd-4d66-963e-ef4287ff173b)
+ *      16        4  Length of bytes of the entire secret area
+ *
+ *      20       16  First secret entry's GUID
+ *      36        4  First secret entry's length in bytes (= 16 + 4 + x)
+ *      40        x  First secret entry's data
+ *
+ *    40+x       16  Second secret entry's GUID
+ *    56+x        4  Second secret entry's length in bytes (= 16 + 4 + y)
+ *    60+x        y  Second secret entry's data
+ *
+ * (... and so on for additional entries)
+ *
+ * The GUID of each secret entry designates the usage of the secret data.
+ */
+
+/**
+ * struct secret_header - Header of entire secret area; this should be followed
+ * by instances of struct secret_entry.
+ * @guid:	Must be EFI_SEVSECRET_TABLE_HEADER_GUID
+ * @len:	Length in bytes of entire secret area, including header
+ */
+struct secret_header {
+	efi_guid_t guid;
+	u32 len;
+} __attribute((packed));
+
+/**
+ * struct secret_entry - Holds one secret entry
+ * @guid:	Secret-specific GUID (or NULL_GUID if this secret entry was deleted)
+ * @len:	Length of secret entry, including its guid and len fields
+ * @data:	The secret data (full of zeros if this secret entry was deleted)
+ */
+struct secret_entry {
+	efi_guid_t guid;
+	u32 len;
+	u8 data[];
+} __attribute((packed));
+
+static size_t secret_entry_data_len(struct secret_entry *e)
+{
+	return e->len - sizeof(*e);
+}
+
+static struct sev_secret the_sev_secret;
+
+static inline struct sev_secret *sev_secret_get(void)
+{
+	return &the_sev_secret;
+}
+
+static int sev_secret_bin_file_show(struct seq_file *file, void *data)
+{
+	struct secret_entry *e = file->private;
+
+	if (e)
+		seq_write(file, e->data, secret_entry_data_len(e));
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(sev_secret_bin_file);
+
+static int sev_secret_unlink(struct inode *dir, struct dentry *dentry)
+{
+	struct sev_secret *s = sev_secret_get();
+	struct inode *inode = d_inode(dentry);
+	struct secret_entry *e = (struct secret_entry *)inode->i_private;
+        int i;
+
+        if (e) {
+		/* Zero out the secret data */
+		memzero_explicit(e->data, secret_entry_data_len(e));
+		e->guid = NULL_GUID;
+        }
+
+        inode->i_private = NULL;
+
+	for (i = 0; i < SEV_SECRET_NUM_FILES; i++)
+		if (s->fs_files[i] == dentry)
+                	s->fs_files[i] = NULL;
+
+        /* securityfs_remove tries to lock the directory's inode, but we reach
+         * the unlink callback when it's already locked */
+	inode_unlock(dir);
+	securityfs_remove(dentry);
+	inode_lock(dir);
+
+	return 0;
+}
+
+static const struct inode_operations sev_secret_dir_inode_operations = {
+	.lookup         = simple_lookup,
+	.unlink         = sev_secret_unlink,
+};
+
+static int sev_secret_map_area(void)
+{
+	struct sev_secret *s = sev_secret_get();
+	struct linux_efi_confidential_computing_secret_area *secret_area;
+	u32 secret_area_size;
+
+	if (efi.confidential_computing_secret == EFI_INVALID_TABLE_ADDR) {
+		pr_err("Secret area address is not available\n");
+		return -EINVAL;
+	}
+
+	secret_area =
+		memremap(efi.confidential_computing_secret, sizeof(*secret_area), MEMREMAP_WB);
+	if (secret_area == NULL) {
+		pr_err("Could not map secret area header\n");
+		return -ENOMEM;
+	}
+
+	secret_area_size = sizeof(*secret_area) + secret_area->size;
+	memunmap(secret_area);
+
+	secret_area = memremap(efi.confidential_computing_secret, secret_area_size, MEMREMAP_WB);
+	if (secret_area == NULL) {
+		pr_err("Could not map secret area\n");
+		return -ENOMEM;
+	}
+
+	s->secret_area = secret_area;
+	return 0;
+}
+
+static void sev_secret_securityfs_teardown(void)
+{
+	struct sev_secret *s = sev_secret_get();
+	int i;
+
+	for (i = (SEV_SECRET_NUM_FILES - 1); i >= 0; i--) {
+		securityfs_remove(s->fs_files[i]);
+		s->fs_files[i] = NULL;
+	}
+
+	securityfs_remove(s->fs_dir);
+	s->fs_dir = NULL;
+
+	pr_debug("Removed sev_secret securityfs entries\n");
+}
+
+static int sev_secret_securityfs_setup(void)
+{
+	efi_guid_t tableheader_guid = EFI_SEVSECRET_TABLE_HEADER_GUID;
+	struct sev_secret *s = sev_secret_get();
+	int ret = 0, i = 0, bytes_left;
+	unsigned char *ptr;
+	struct secret_header *h;
+	struct secret_entry *e;
+	struct dentry *dent;
+	char guid_str[EFI_VARIABLE_GUID_LEN + 1];
+
+	s->fs_dir = NULL;
+	memset(s->fs_files, 0, sizeof(s->fs_files));
+
+	dent = securityfs_create_dir("sev_secret", NULL);
+	if (IS_ERR(dent)) {
+		pr_err("Error creating SEV secret securityfs directory entry err=%ld", PTR_ERR(dent));
+		return PTR_ERR(dent);
+	}
+	d_inode(dent)->i_op = &sev_secret_dir_inode_operations;
+	s->fs_dir = dent;
+
+	ptr = s->secret_area->area;
+	h = (struct secret_header *)ptr;
+	if (memcmp(&h->guid, &tableheader_guid, sizeof(h->guid))) {
+		pr_err("SEV secret area does not start with correct GUID\n");
+		ret = -EINVAL;
+		goto err_cleanup;
+	}
+	if (h->len < sizeof(*h)) {
+		pr_err("SEV secret area reported length is too small\n");
+		ret = -EINVAL;
+		goto err_cleanup;
+	}
+
+	bytes_left = h->len - sizeof(*h);
+	ptr += sizeof(*h);
+	while (bytes_left >= (int)sizeof(*e) && i < SEV_SECRET_NUM_FILES) {
+		e = (struct secret_entry *)ptr;
+		if (e->len < sizeof(*e) || e->len > (unsigned int)bytes_left) {
+			pr_err("SEV secret area is corrupted\n");
+			ret = -EINVAL;
+			goto err_cleanup;
+		}
+
+		/* Skip deleted entries (which will have NULL_GUID) */
+		if (efi_guidcmp(e->guid, NULL_GUID)) {
+			efi_guid_to_str(&e->guid, guid_str);
+
+			dent = securityfs_create_file(guid_str, 0440, s->fs_dir, (void *)e,
+						      &sev_secret_bin_file_fops);
+			if (IS_ERR(dent)) {
+				pr_err("Error creating SEV secret securityfs entry\n");
+				ret = PTR_ERR(dent);
+				goto err_cleanup;
+			}
+
+			s->fs_files[i++] = dent;
+		}
+		ptr += e->len;
+		bytes_left -= e->len;
+	}
+
+	pr_debug("Created %d entries in sev_secret securityfs\n", i);
+	return 0;
+
+err_cleanup:
+	sev_secret_securityfs_teardown();
+	return ret;
+}
+
+static void sev_secret_unmap_area(void)
+{
+	struct sev_secret *s = sev_secret_get();
+
+	if (s->secret_area) {
+		memunmap(s->secret_area);
+		s->secret_area = NULL;
+	}
+}
+
+static int __init sev_secret_init(void)
+{
+	int ret;
+
+	ret = sev_secret_map_area();
+	if (ret)
+		return ret;
+
+	ret = sev_secret_securityfs_setup();
+	if (ret)
+		goto err_unmap;
+
+	return ret;
+
+err_unmap:
+	sev_secret_unmap_area();
+	return ret;
+}
+
+static void __exit sev_secret_exit(void)
+{
+	sev_secret_securityfs_teardown();
+	sev_secret_unmap_area();
+}
+
+module_init(sev_secret_init);
+module_exit(sev_secret_exit);
+
+MODULE_DESCRIPTION("AMD SEV confidential computing secret area access");
+MODULE_AUTHOR("IBM");
+MODULE_LICENSE("GPL");
-- 
2.25.1

