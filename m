Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346F74FEA86
	for <lists+linux-efi@lfdr.de>; Wed, 13 Apr 2022 01:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiDLXYz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 12 Apr 2022 19:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiDLXYZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 12 Apr 2022 19:24:25 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD4DD081B;
        Tue, 12 Apr 2022 15:11:19 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23CKC9lU030610;
        Tue, 12 Apr 2022 21:21:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=yDxXQRLIbdqRMihUE0+TpE0g+H+VTfTrIRfDvd6rS50=;
 b=Ck/xSDI3218uBHfkLCUwqQwZRuDcYlZwnwwq0T1xSU+/DOZCVIc2hCc/FCNmg2AEh2P6
 pV4aletnO0muQ/Ir91zNPCXC3XgilcjNDmYo1MO76MWJ+RWVHewKge2ITYaNEjYjEff5
 hoSvVcL6FH5Zlax1FAfOZB6AUVhHDz6Gut/IviHuFErxnQxIGa4UcJN+AoWTXULceO4q
 0/7R4f2x2uWsKsxEPsQMvVIQmGgxFZZzUddgGmcwXTRS5cZHJ8dAZtHzAYCWpoBGgRb+
 /W6qAzcLpnzlmVWRTNGfTFXIAobbgYtoQXtBR5Jr2s/6QVYZKn8dKCro2M3lvTJXVqCd 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fdg8c1968-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 21:21:42 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23CL9P0W027046;
        Tue, 12 Apr 2022 21:21:41 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fdg8c195j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 21:21:41 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23CLDVbl010694;
        Tue, 12 Apr 2022 21:21:40 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma05wdc.us.ibm.com with ESMTP id 3fb1s9k31k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 21:21:40 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23CLLdke30998878
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 21:21:39 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9941113604F;
        Tue, 12 Apr 2022 21:21:39 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A4713136053;
        Tue, 12 Apr 2022 21:21:37 +0000 (GMT)
Received: from amdrome3.watson.ibm.com (unknown [9.2.130.16])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 12 Apr 2022 21:21:37 +0000 (GMT)
From:   Dov Murik <dovmurik@linux.ibm.com>
To:     linux-efi@vger.kernel.org
Cc:     Dov Murik <dovmurik@linux.ibm.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Borislav Petkov <bp@suse.de>,
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
        Lenny Szubowicz <lszubowi@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 2/4] virt: Add efi_secret module to expose confidential computing secrets
Date:   Tue, 12 Apr 2022 21:21:25 +0000
Message-Id: <20220412212127.154182-3-dovmurik@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220412212127.154182-1-dovmurik@linux.ibm.com>
References: <20220412212127.154182-1-dovmurik@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IE-ypMd3jx80PZbNnuEA5Z0AUAmLfZE9
X-Proofpoint-GUID: zDEF-W4Pnn0njo9itrEZ2aOaejLK0dIa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-12_06,2022-04-12_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 phishscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204120097
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The new efi_secret module exposes the confidential computing (coco)
EFI secret area via securityfs interface.

When the module is loaded (and securityfs is mounted, typically under
/sys/kernel/security), a "secrets/coco" directory is created in
securityfs.  In it, a file is created for each secret entry.  The name
of each such file is the GUID of the secret entry, and its content is
the secret data.

This allows applications running in a confidential computing setting to
read secrets provided by the guest owner via a secure secret injection
mechanism (such as AMD SEV's LAUNCH_SECRET command).

Removing (unlinking) files in the "secrets/coco" directory will zero out
the secret in memory, and remove the filesystem entry.  If the module is
removed and loaded again, that secret will not appear in the filesystem.

Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
---
 Documentation/ABI/testing/securityfs-secrets-coco |  51 +++
 drivers/virt/Kconfig                              |   3 +
 drivers/virt/Makefile                             |   1 +
 drivers/virt/coco/efi_secret/Kconfig              |  16 +
 drivers/virt/coco/efi_secret/Makefile             |   2 +
 drivers/virt/coco/efi_secret/efi_secret.c         | 349 ++++++++++++++++++++
 6 files changed, 422 insertions(+)

diff --git a/Documentation/ABI/testing/securityfs-secrets-coco b/Documentation/ABI/testing/securityfs-secrets-coco
new file mode 100644
index 000000000000..f2b6909155f9
--- /dev/null
+++ b/Documentation/ABI/testing/securityfs-secrets-coco
@@ -0,0 +1,51 @@
+What:		security/secrets/coco
+Date:		February 2022
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
+		secret appears as a file under <securityfs>/secrets/coco,
+		where the filename is the GUID of the entry in the secrets
+		table.  This module is loaded automatically by the EFI driver
+		if the EFI secret area is populated.
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
+		  # ls -l /sys/kernel/security/secrets/coco
+		  -r--r----- 1 root root 0 Jun 28 11:54 736870e5-84f0-4973-92ec-06879ce3da0b
+		  -r--r----- 1 root root 0 Jun 28 11:54 83c83f7f-1356-4975-8b7e-d3a0b54312c6
+		  -r--r----- 1 root root 0 Jun 28 11:54 9553f55d-3da2-43ee-ab5d-ff17f78864d2
+		  -r--r----- 1 root root 0 Jun 28 11:54 e6f5a162-d67f-4750-a67c-5d065f2a9910
+
+		Reading the secret data by reading a file::
+
+		  # cat /sys/kernel/security/secrets/coco/e6f5a162-d67f-4750-a67c-5d065f2a9910
+		  the-content-of-the-secret-data
+
+		Wiping a secret by unlinking a file::
+
+		  # rm /sys/kernel/security/secrets/coco/e6f5a162-d67f-4750-a67c-5d065f2a9910
+		  # ls -l /sys/kernel/security/secrets/coco
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
index 000000000000..4404d198f3b2
--- /dev/null
+++ b/drivers/virt/coco/efi_secret/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config EFI_SECRET
+	tristate "EFI secret area securityfs support"
+	depends on EFI && X86_64
+	select EFI_COCO_SECRET
+	select SECURITYFS
+	help
+	  This is a driver for accessing the EFI secret area via securityfs.
+	  The EFI secret area is a memory area designated by the firmware for
+	  confidential computing secret injection (for example for AMD SEV
+	  guests).  The driver exposes the secrets as files in
+	  <securityfs>/secrets/coco.  Files can be read and deleted (deleting
+	  a file wipes the secret from memory).
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
index 000000000000..e700a5ef7043
--- /dev/null
+++ b/drivers/virt/coco/efi_secret/efi_secret.c
@@ -0,0 +1,349 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * efi_secret module
+ *
+ * Copyright (C) 2022 IBM Corporation
+ * Author: Dov Murik <dovmurik@linux.ibm.com>
+ */
+
+/**
+ * DOC: efi_secret: Allow reading EFI confidential computing (coco) secret area
+ * via securityfs interface.
+ *
+ * When the module is loaded (and securityfs is mounted, typically under
+ * /sys/kernel/security), a "secrets/coco" directory is created in securityfs.
+ * In it, a file is created for each secret entry.  The name of each such file
+ * is the GUID of the secret entry, and its content is the secret data.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/seq_file.h>
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/security.h>
+#include <linux/efi.h>
+#include <linux/cacheflush.h>
+
+#define EFI_SECRET_NUM_FILES 64
+
+struct efi_secret {
+	struct dentry *secrets_dir;
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
+static int efi_secret_map_area(struct platform_device *dev)
+{
+	int ret;
+	struct efi_secret *s = efi_secret_get();
+	struct linux_efi_coco_secret_area *secret_area;
+
+	if (efi.coco_secret == EFI_INVALID_TABLE_ADDR) {
+		dev_err(&dev->dev, "Secret area address is not available\n");
+		return -EINVAL;
+	}
+
+	secret_area = memremap(efi.coco_secret, sizeof(*secret_area), MEMREMAP_WB);
+	if (secret_area == NULL) {
+		dev_err(&dev->dev, "Could not map secret area EFI config entry\n");
+		return -ENOMEM;
+	}
+	if (!secret_area->base_pa || secret_area->size < sizeof(struct secret_header)) {
+		dev_err(&dev->dev,
+			"Invalid secret area memory location (base_pa=0x%llx size=0x%llx)\n",
+			secret_area->base_pa, secret_area->size);
+		ret = -EINVAL;
+		goto unmap;
+	}
+
+	s->secret_data = ioremap_encrypted(secret_area->base_pa, secret_area->size);
+	if (s->secret_data == NULL) {
+		dev_err(&dev->dev, "Could not map secret area\n");
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
+static void efi_secret_securityfs_teardown(struct platform_device *dev)
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
+	securityfs_remove(s->secrets_dir);
+	s->secrets_dir = NULL;
+
+	dev_dbg(&dev->dev, "Removed securityfs entries\n");
+}
+
+static int efi_secret_securityfs_setup(struct platform_device *dev)
+{
+	struct efi_secret *s = efi_secret_get();
+	int ret = 0, i = 0, bytes_left;
+	unsigned char *ptr;
+	struct secret_header *h;
+	struct secret_entry *e;
+	struct dentry *dent;
+	char guid_str[EFI_VARIABLE_GUID_LEN + 1];
+
+	ptr = (void __force *)s->secret_data;
+	h = (struct secret_header *)ptr;
+	if (efi_guidcmp(h->guid, EFI_SECRET_TABLE_HEADER_GUID)) {
+		/*
+		 * This is not an error: it just means that EFI defines secret
+		 * area but it was not populated by the Guest Owner.
+		 */
+		dev_dbg(&dev->dev, "EFI secret area does not start with correct GUID\n");
+		return -ENODEV;
+	}
+	if (h->len < sizeof(*h)) {
+		dev_err(&dev->dev, "EFI secret area reported length is too small\n");
+		return -EINVAL;
+	}
+	if (h->len > s->secret_data_len) {
+		dev_err(&dev->dev, "EFI secret area reported length is too big\n");
+		return -EINVAL;
+	}
+
+	s->secrets_dir = NULL;
+	s->fs_dir = NULL;
+	memset(s->fs_files, 0, sizeof(s->fs_files));
+
+	dent = securityfs_create_dir("secrets", NULL);
+	if (IS_ERR(dent)) {
+		dev_err(&dev->dev, "Error creating secrets securityfs directory entry err=%ld\n",
+			PTR_ERR(dent));
+		return PTR_ERR(dent);
+	}
+	s->secrets_dir = dent;
+
+	dent = securityfs_create_dir("coco", s->secrets_dir);
+	if (IS_ERR(dent)) {
+		dev_err(&dev->dev, "Error creating coco securityfs directory entry err=%ld\n",
+			PTR_ERR(dent));
+		return PTR_ERR(dent);
+	}
+	d_inode(dent)->i_op = &efi_secret_dir_inode_operations;
+	s->fs_dir = dent;
+
+	bytes_left = h->len - sizeof(*h);
+	ptr += sizeof(*h);
+	while (bytes_left >= (int)sizeof(*e) && i < EFI_SECRET_NUM_FILES) {
+		e = (struct secret_entry *)ptr;
+		if (e->len < sizeof(*e) || e->len > (unsigned int)bytes_left) {
+			dev_err(&dev->dev, "EFI secret area is corrupted\n");
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
+				dev_err(&dev->dev, "Error creating efi_secret securityfs entry\n");
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
+	dev_info(&dev->dev, "Created %d entries in securityfs secrets/coco\n", i);
+	return 0;
+
+err_cleanup:
+	efi_secret_securityfs_teardown(dev);
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
+static int efi_secret_probe(struct platform_device *dev)
+{
+	int ret;
+
+	ret = efi_secret_map_area(dev);
+	if (ret)
+		return ret;
+
+	ret = efi_secret_securityfs_setup(dev);
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
+static int efi_secret_remove(struct platform_device *dev)
+{
+	efi_secret_securityfs_teardown(dev);
+	efi_secret_unmap_area();
+	return 0;
+}
+
+static struct platform_driver efi_secret_driver = {
+	.probe = efi_secret_probe,
+	.remove = efi_secret_remove,
+	.driver = {
+		.name = "efi_secret",
+	},
+};
+
+module_platform_driver(efi_secret_driver);
+
+MODULE_DESCRIPTION("Confidential computing EFI secret area access");
+MODULE_AUTHOR("IBM");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:efi_secret");
-- 
2.25.1

