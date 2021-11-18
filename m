Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE4D4455A80
	for <lists+linux-efi@lfdr.de>; Thu, 18 Nov 2021 12:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343974AbhKRLho (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Nov 2021 06:37:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4034 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343949AbhKRLhd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 Nov 2021 06:37:33 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AIBE3e0017716;
        Thu, 18 Nov 2021 11:34:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=jwIke+PU0+2RZ1CulmTmFpaDiU3AmNOxzKJXDehjQjw=;
 b=BVer5xA3tjMaIuEdhjZ4NmUuMbD5HlqMvedO122Fgo9DIGhT2xP1InimjQ9zxLT5m3Rh
 QbiKbTSrUhJLF8tBqq0U/m3PGbi16fssJFssTY/Vq4HOz4Ovp8o5uzdGlt6srfVAiMhU
 4o0jjLUFZG3wMLnO3biyBkNX0M8qybNebfCZ0nDiTkoFwkfjDhhps5qiO0fY8ocXSGnv
 jaLSjZh16H7UjE1M8UOKrlw1i+eGnA8pi+B1J9VdmDkQ2GF3/etp7UZPx/aSHzbQlm7h
 dm1g1ZfR63Ee6/RvqhLhrRMtTi5mjw5KAcaI4XFyCoRkq2Vj/P0EviKvb02U8ZcPwuuU gQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cdns98c3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Nov 2021 11:34:11 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AIBFSEr024034;
        Thu, 18 Nov 2021 11:34:11 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cdns98c35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Nov 2021 11:34:10 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AIBRlSZ017383;
        Thu, 18 Nov 2021 11:34:09 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma02wdc.us.ibm.com with ESMTP id 3cd81dpsus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Nov 2021 11:34:09 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AIBY6pQ48693694
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 11:34:06 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0513AE066;
        Thu, 18 Nov 2021 11:34:05 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2EC9AE05C;
        Thu, 18 Nov 2021 11:34:05 +0000 (GMT)
Received: from amdrome3.watson.ibm.com (unknown [9.2.130.16])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 18 Nov 2021 11:34:05 +0000 (GMT)
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
Subject: [PATCH v5 3/4] virt: Add efi_secret module to expose confidential computing secrets
Date:   Thu, 18 Nov 2021 11:33:58 +0000
Message-Id: <20211118113359.642571-4-dovmurik@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211118113359.642571-1-dovmurik@linux.ibm.com>
References: <20211118113359.642571-1-dovmurik@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LLRcEYyqyk4Q8pPn_5NXjXPMk1M7FIgU
X-Proofpoint-ORIG-GUID: fIl8lWfv37TBPVCcMasQ2x179xR1U3bW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-18_05,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 phishscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111180067
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The new efi_secret module exposes the confidential computing (coco)
EFI secret area via securityfs interface.

When the module is loaded (and securityfs is mounted, typically under
/sys/kernel/security), a "coco/efi_secret" directory is created in
securityfs.  In it, a file is created for each secret entry.  The name
of each such file is the GUID of the secret entry, and its content is
the secret data.

This allows applications running in a confidential computing setting to
read secrets provided by the guest owner via a secure secret injection
mechanism (such as AMD SEV's LAUNCH_SECRET command).

Removing (unlinking) files in the "coco/efi_secret" directory will zero
out the secret in memory, and remove the filesystem entry.  If the
module is removed and loaded again, that secret will not appear in the
filesystem.

Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>
---
 .../ABI/testing/securityfs-coco-efi_secret    |  50 +++
 drivers/virt/Kconfig                          |   3 +
 drivers/virt/Makefile                         |   1 +
 drivers/virt/coco/efi_secret/Kconfig          |  11 +
 drivers/virt/coco/efi_secret/Makefile         |   2 +
 drivers/virt/coco/efi_secret/efi_secret.c     | 341 ++++++++++++++++++
 6 files changed, 408 insertions(+)
 create mode 100644 Documentation/ABI/testing/securityfs-coco-efi_secret
 create mode 100644 drivers/virt/coco/efi_secret/Kconfig
 create mode 100644 drivers/virt/coco/efi_secret/Makefile
 create mode 100644 drivers/virt/coco/efi_secret/efi_secret.c

diff --git a/Documentation/ABI/testing/securityfs-coco-efi_secret b/Documentation/ABI/testing/securityfs-coco-efi_secret
new file mode 100644
index 000000000000..ae56976db1bc
--- /dev/null
+++ b/Documentation/ABI/testing/securityfs-coco-efi_secret
@@ -0,0 +1,50 @@
+What:		security/coco/efi_secret
+Date:		October 2021
+Contact:	Dov Murik <dovmurik@linux.ibm.com>
+Description:
+		Exposes confidential computing (coco) EFI secrets to
+		userspace via securityfs.
+
+		EFI can declare memory area used by confidential computing
+		platforms (such as AMD SEV and SEV-ES) for secret injection by
+		the Guest Owner during VM's launch.  The secrets are encrypted
+		by the Guest Owner and decrypted inside the trusted enclave,
+		and therefore are not readable by the untrusted host.
+
+		The efi_secret module exposes the secrets to userspace.  Each
+		secret appears as a file under <securityfs>/coco/efi_secret,
+		where the filename is the GUID of the entry in the secrets
+		table.
+
+		Two operations are supported for the files: read and unlink.
+		Reading the file returns the content of secret entry.
+		Unlinking the file overwrites the secret data with zeroes and
+		removes the entry from the filesystem.  A secret cannot be read
+		after it has been unlinked.
+
+		For example, listing the available secrets::
+
+		  # modprobe efi_secret
+		  # ls -l /sys/kernel/security/coco/efi_secret
+		  -r--r----- 1 root root 0 Jun 28 11:54 736870e5-84f0-4973-92ec-06879ce3da0b
+		  -r--r----- 1 root root 0 Jun 28 11:54 83c83f7f-1356-4975-8b7e-d3a0b54312c6
+		  -r--r----- 1 root root 0 Jun 28 11:54 9553f55d-3da2-43ee-ab5d-ff17f78864d2
+		  -r--r----- 1 root root 0 Jun 28 11:54 e6f5a162-d67f-4750-a67c-5d065f2a9910
+
+		Reading the secret data by reading a file::
+
+		  # cat /sys/kernel/security/coco/efi_secret/e6f5a162-d67f-4750-a67c-5d065f2a9910
+		  the-content-of-the-secret-data
+
+		Wiping a secret by unlinking a file::
+
+		  # rm /sys/kernel/security/coco/efi_secret/e6f5a162-d67f-4750-a67c-5d065f2a9910
+		  # ls -l /sys/kernel/security/coco/efi_secret
+		  -r--r----- 1 root root 0 Jun 28 11:54 736870e5-84f0-4973-92ec-06879ce3da0b
+		  -r--r----- 1 root root 0 Jun 28 11:54 83c83f7f-1356-4975-8b7e-d3a0b54312c6
+		  -r--r----- 1 root root 0 Jun 28 11:54 9553f55d-3da2-43ee-ab5d-ff17f78864d2
+
+		Note: The binary format of the secrets table injected by the
+		Guest Owner is described in
+		drivers/virt/coco/efi_secret/efi_secret.c under "Structure of
+		the EFI secret area".
diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
index 8061e8ef449f..fe7a6579b974 100644
--- a/drivers/virt/Kconfig
+++ b/drivers/virt/Kconfig
@@ -36,4 +36,7 @@ source "drivers/virt/vboxguest/Kconfig"
 source "drivers/virt/nitro_enclaves/Kconfig"
 
 source "drivers/virt/acrn/Kconfig"
+
+source "drivers/virt/coco/efi_secret/Kconfig"
+
 endif
diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
index 3e272ea60cd9..efdb015783f9 100644
--- a/drivers/virt/Makefile
+++ b/drivers/virt/Makefile
@@ -8,3 +8,4 @@ obj-y				+= vboxguest/
 
 obj-$(CONFIG_NITRO_ENCLAVES)	+= nitro_enclaves/
 obj-$(CONFIG_ACRN_HSM)		+= acrn/
+obj-$(CONFIG_EFI_SECRET)	+= coco/efi_secret/
diff --git a/drivers/virt/coco/efi_secret/Kconfig b/drivers/virt/coco/efi_secret/Kconfig
new file mode 100644
index 000000000000..a39a5a90a1e5
--- /dev/null
+++ b/drivers/virt/coco/efi_secret/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config EFI_SECRET
+	tristate "EFI secret area securityfs support"
+	depends on EFI
+	select EFI_COCO_SECRET
+	select SECURITYFS
+	help
+	  This is a driver for accessing the EFI secret area via securityfs.
+
+	  To compile this driver as a module, choose M here.
+	  The module will be called efi_secret.
diff --git a/drivers/virt/coco/efi_secret/Makefile b/drivers/virt/coco/efi_secret/Makefile
new file mode 100644
index 000000000000..c7047ce804f7
--- /dev/null
+++ b/drivers/virt/coco/efi_secret/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_EFI_SECRET) += efi_secret.o
diff --git a/drivers/virt/coco/efi_secret/efi_secret.c b/drivers/virt/coco/efi_secret/efi_secret.c
new file mode 100644
index 000000000000..c0eaf63bc85a
--- /dev/null
+++ b/drivers/virt/coco/efi_secret/efi_secret.c
@@ -0,0 +1,341 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * efi_secret module
+ *
+ * Copyright (C) 2021 IBM Corporation
+ * Author: Dov Murik <dovmurik@linux.ibm.com>
+ */
+
+/**
+ * DOC: efi_secret: Allow reading EFI confidential computing (coco) secret area
+ * via securityfs interface.
+ *
+ * When the module is loaded (and securityfs is mounted, typically under
+ * /sys/kernel/security), a "coco/efi_secret" directory is created in
+ * securityfs.  In it, a file is created for each secret entry.  The name of
+ * each such file is the GUID of the secret entry, and its content is the
+ * secret data.
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
+#include <asm/cacheflush.h>
+
+#define EFI_SECRET_NUM_FILES 64
+
+#define EFI_SECRET_TABLE_HEADER_GUID \
+	EFI_GUID(0x1e74f542, 0x71dd, 0x4d66, 0x96, 0x3e, 0xef, 0x42, 0x87, 0xff, 0x17, 0x3b)
+
+struct efi_secret {
+	struct dentry *coco_dir;
+	struct dentry *fs_dir;
+	struct dentry *fs_files[EFI_SECRET_NUM_FILES];
+	void __iomem *secret_data;
+	u64 secret_data_len;
+};
+
+/*
+ * Structure of the EFI secret area
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
+ * @guid:	Must be EFI_SECRET_TABLE_HEADER_GUID
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
+static struct efi_secret the_efi_secret;
+
+static inline struct efi_secret *efi_secret_get(void)
+{
+	return &the_efi_secret;
+}
+
+static int efi_secret_bin_file_show(struct seq_file *file, void *data)
+{
+	struct secret_entry *e = file->private;
+
+	if (e)
+		seq_write(file, e->data, secret_entry_data_len(e));
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(efi_secret_bin_file);
+
+/*
+ * Overwrite memory content with zeroes, and ensure that dirty cache lines are
+ * actually written back to memory, to clear out the secret.
+ */
+static void wipe_memory(void *addr, size_t size)
+{
+	memzero_explicit(addr, size);
+#ifdef CONFIG_X86
+	clflush_cache_range(addr, size);
+#endif
+}
+
+static int efi_secret_unlink(struct inode *dir, struct dentry *dentry)
+{
+	struct efi_secret *s = efi_secret_get();
+	struct inode *inode = d_inode(dentry);
+	struct secret_entry *e = (struct secret_entry *)inode->i_private;
+	int i;
+
+	if (e) {
+		/* Zero out the secret data */
+		wipe_memory(e->data, secret_entry_data_len(e));
+		e->guid = NULL_GUID;
+	}
+
+	inode->i_private = NULL;
+
+	for (i = 0; i < EFI_SECRET_NUM_FILES; i++)
+		if (s->fs_files[i] == dentry)
+			s->fs_files[i] = NULL;
+
+	/*
+	 * securityfs_remove tries to lock the directory's inode, but we reach
+	 * the unlink callback when it's already locked
+	 */
+	inode_unlock(dir);
+	securityfs_remove(dentry);
+	inode_lock(dir);
+
+	return 0;
+}
+
+static const struct inode_operations efi_secret_dir_inode_operations = {
+	.lookup         = simple_lookup,
+	.unlink         = efi_secret_unlink,
+};
+
+static int efi_secret_map_area(void)
+{
+	int ret;
+	struct efi_secret *s = efi_secret_get();
+	struct linux_efi_coco_secret_area *secret_area;
+
+	if (efi.coco_secret == EFI_INVALID_TABLE_ADDR) {
+		pr_err("Secret area address is not available\n");
+		return -EINVAL;
+	}
+
+	secret_area = memremap(efi.coco_secret, sizeof(*secret_area), MEMREMAP_WB);
+	if (secret_area == NULL) {
+		pr_err("Could not map secret area EFI config entry\n");
+		return -ENOMEM;
+	}
+	if (!secret_area->base_pa || secret_area->size < sizeof(struct secret_header)) {
+		pr_err("Invalid secret area memory location (base_pa=0x%llx size=0x%llx)\n",
+		       secret_area->base_pa, secret_area->size);
+		ret = -EINVAL;
+		goto unmap;
+	}
+
+	s->secret_data = ioremap_encrypted(secret_area->base_pa, secret_area->size);
+	if (s->secret_data == NULL) {
+		pr_err("Could not map secret area\n");
+		ret = -ENOMEM;
+		goto unmap;
+	}
+
+	s->secret_data_len = secret_area->size;
+	ret = 0;
+
+unmap:
+	memunmap(secret_area);
+	return ret;
+}
+
+static void efi_secret_securityfs_teardown(void)
+{
+	struct efi_secret *s = efi_secret_get();
+	int i;
+
+	for (i = (EFI_SECRET_NUM_FILES - 1); i >= 0; i--) {
+		securityfs_remove(s->fs_files[i]);
+		s->fs_files[i] = NULL;
+	}
+
+	securityfs_remove(s->fs_dir);
+	s->fs_dir = NULL;
+
+	securityfs_remove(s->coco_dir);
+	s->coco_dir = NULL;
+
+	pr_debug("Removed efi_secret securityfs entries\n");
+}
+
+static int efi_secret_securityfs_setup(void)
+{
+	efi_guid_t tableheader_guid = EFI_SECRET_TABLE_HEADER_GUID;
+	struct efi_secret *s = efi_secret_get();
+	int ret = 0, i = 0, bytes_left;
+	unsigned char *ptr;
+	struct secret_header *h;
+	struct secret_entry *e;
+	struct dentry *dent;
+	char guid_str[EFI_VARIABLE_GUID_LEN + 1];
+
+	s->coco_dir = NULL;
+	s->fs_dir = NULL;
+	memset(s->fs_files, 0, sizeof(s->fs_files));
+
+	dent = securityfs_create_dir("coco", NULL);
+	if (IS_ERR(dent)) {
+		pr_err("Error creating coco securityfs directory entry err=%ld\n", PTR_ERR(dent));
+		return PTR_ERR(dent);
+	}
+	s->coco_dir = dent;
+
+	dent = securityfs_create_dir("efi_secret", s->coco_dir);
+	if (IS_ERR(dent)) {
+		pr_err("Error creating efi_secret securityfs directory entry err=%ld\n",
+		       PTR_ERR(dent));
+		return PTR_ERR(dent);
+	}
+	d_inode(dent)->i_op = &efi_secret_dir_inode_operations;
+	s->fs_dir = dent;
+
+	ptr = s->secret_data;
+	h = (struct secret_header *)ptr;
+	if (memcmp(&h->guid, &tableheader_guid, sizeof(h->guid))) {
+		pr_err("EFI secret area does not start with correct GUID\n");
+		ret = -EINVAL;
+		goto err_cleanup;
+	}
+	if (h->len < sizeof(*h)) {
+		pr_err("EFI secret area reported length is too small\n");
+		ret = -EINVAL;
+		goto err_cleanup;
+	}
+	if (h->len > s->secret_data_len) {
+		pr_err("EFI secret area reported length is too big\n");
+		ret = -EINVAL;
+		goto err_cleanup;
+	}
+
+	bytes_left = h->len - sizeof(*h);
+	ptr += sizeof(*h);
+	while (bytes_left >= (int)sizeof(*e) && i < EFI_SECRET_NUM_FILES) {
+		e = (struct secret_entry *)ptr;
+		if (e->len < sizeof(*e) || e->len > (unsigned int)bytes_left) {
+			pr_err("EFI secret area is corrupted\n");
+			ret = -EINVAL;
+			goto err_cleanup;
+		}
+
+		/* Skip deleted entries (which will have NULL_GUID) */
+		if (efi_guidcmp(e->guid, NULL_GUID)) {
+			efi_guid_to_str(&e->guid, guid_str);
+
+			dent = securityfs_create_file(guid_str, 0440, s->fs_dir, (void *)e,
+						      &efi_secret_bin_file_fops);
+			if (IS_ERR(dent)) {
+				pr_err("Error creating efi_secret securityfs entry\n");
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
+	pr_debug("Created %d entries in efi_secret securityfs\n", i);
+	return 0;
+
+err_cleanup:
+	efi_secret_securityfs_teardown();
+	return ret;
+}
+
+static void efi_secret_unmap_area(void)
+{
+	struct efi_secret *s = efi_secret_get();
+
+	if (s->secret_data) {
+		iounmap(s->secret_data);
+		s->secret_data = NULL;
+		s->secret_data_len = 0;
+	}
+}
+
+static int __init efi_secret_init(void)
+{
+	int ret;
+
+	ret = efi_secret_map_area();
+	if (ret)
+		return ret;
+
+	ret = efi_secret_securityfs_setup();
+	if (ret)
+		goto err_unmap;
+
+	return ret;
+
+err_unmap:
+	efi_secret_unmap_area();
+	return ret;
+}
+
+static void __exit efi_secret_exit(void)
+{
+	efi_secret_securityfs_teardown();
+	efi_secret_unmap_area();
+}
+
+module_init(efi_secret_init);
+module_exit(efi_secret_exit);
+
+MODULE_DESCRIPTION("Confidential computing EFI secret area access");
+MODULE_AUTHOR("IBM");
+MODULE_LICENSE("GPL");
-- 
2.25.1

