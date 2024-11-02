Return-Path: <linux-efi+bounces-2108-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B780B9B9D64
	for <lists+linux-efi@lfdr.de>; Sat,  2 Nov 2024 07:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65CEC283EE8
	for <lists+linux-efi@lfdr.de>; Sat,  2 Nov 2024 06:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AADA14A0A3;
	Sat,  2 Nov 2024 06:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mb4eV9y8"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA719474;
	Sat,  2 Nov 2024 06:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730528592; cv=none; b=srAKK/6tTLk6MeZbE5fOtUC+yUc2yHxpEKNjGMBaK/jF7Eh4msSVcPGPZl//iMNtZGpeKd4K70vc1fThGEPM5Nr1AOw0g4i/2DW/urbf6U61OzNWYAmRqUHsWXulxyz/epzr3nXXwqLzfawPuh33ziRl65TH5YJ46MaFt8waJtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730528592; c=relaxed/simple;
	bh=gzlKGnvzGZzthTS3QitaJ2eHRSt7oYdMJoKnxawWJRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gOsiUp3ByfA4ncEJ3OsFtbL4MEkgZ0GtR4F0c7l+VA4DU52ZThJbxa6L6NYkGUR/1z3vIXLRHQmdJPwhIL11L+NBFG8S89XMmGdegLqdBFtdV7D2meQJHHrW9Ygf5gPx/tQ80WeD6AAxPScVZglU73GQkKhCKqnowUp/DPANaAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mb4eV9y8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D929BC4CEC3;
	Sat,  2 Nov 2024 06:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730528591;
	bh=gzlKGnvzGZzthTS3QitaJ2eHRSt7oYdMJoKnxawWJRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mb4eV9y89dfN9oOHM4OhAI4OQ9Cj+BXbnE3G1iP+z3SxUwpusj+9d70QI2O0L1xsr
	 D4ZpzGO5RyHqIe1AmcaEw2Q5a61TKTWIxJAkezKtKzPKOBI1geuWEsZsQpYfRrFF3A
	 TGBu4UpN+3rMyk0FvZFAEvQ23i0qvzOY0W15n1sj+Pa7LBMnYql5a8YOkIpxDzyzNs
	 MZQkrqibQSz+pxBRvg0g2FwLcG2VVMQyiYlVwdQm6X7HQ/2Xpon6NHMiPrZg/o1jv8
	 3Ga0mxAkfPcjbBy8BwIM0kRg37tuS8DNeDQ0VUPNCGJ/oTC1X77l59oakmKgdmzPBC
	 BRp8JCbfcljXg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: jarkko@kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: James.Bottomley@hansenpartnership.com,
	andrew.cooper3@citrix.com,
	ardb@kernel.org,
	baolu.lu@linux.intel.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	davem@davemloft.net,
	dpsmith@apertussolutions.com,
	dwmw2@infradead.org,
	ebiederm@xmission.com,
	herbert@gondor.apana.org.au,
	hpa@zytor.com,
	iommu@lists.linux-foundation.org,
	kanth.ghatraju@oracle.com,
	kexec@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luto@amacapital.net,
	mingo@redhat.com,
	mjg59@srcf.ucam.org,
	nivedita@alum.mit.edu,
	ross.philipson@oracle.com,
	tglx@linutronix.de,
	trenchboot-devel@googlegroups.com,
	x86@kernel.org
Subject: [RFC PATCH v2 1/2] tpm, tpm_tis: Introduce TPM_IOC_SET_LOCALITY
Date: Sat,  2 Nov 2024 08:22:56 +0200
Message-ID: <20241102062259.2521361-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <D5BB5GX4KEUO.VJ2G9G9QKYRR@kernel.org>
References: <D5BB5GX4KEUO.VJ2G9G9QKYRR@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DRTM needs to be able to set the locality used by kernel. Provide
TPM_IOC_SET_LOCALITY operation for this purpose. It is enabled only if
the kernel command-line has 'tpm.set_locality_enabled=1'. The operation
is one-shot allowed only for tpm_tis for the moment.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v2:
- Do not ignore the return value of tpm_ioc_set_locality().
- if (!(chip->flags & TPM_CHIP_FLAG_SET_LOCALITY_ENABLED))
- Refined kernel-parameters.txt description.
- Use __u8 instead of u8 in the uapi.
- Tested with https://codeberg.org/jarkko/tpm-set-locality-test/src/branch/main/src/main.rs
v1:
- NOTE: Only compile-tested.
---
 .../admin-guide/kernel-parameters.txt         |  5 ++
 .../userspace-api/ioctl/ioctl-number.rst      |  2 +
 drivers/char/tpm/tpm-chip.c                   |  2 +-
 drivers/char/tpm/tpm-dev.c                    | 70 +++++++++++++++++++
 drivers/char/tpm/tpm_tis_core.c               |  2 +
 include/linux/tpm.h                           | 10 +++
 include/uapi/linux/tpm.h                      | 11 +++
 7 files changed, 101 insertions(+), 1 deletion(-)
 create mode 100644 include/uapi/linux/tpm.h

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1518343bbe22..8fd9fc94c883 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6727,6 +6727,11 @@
 	torture.verbose_sleep_duration= [KNL]
 			Duration of each verbose-printk() sleep in jiffies.
 
+	tpm.set_locality_enabled= [HW,TPM]
+			Enable one-shot locality setting after the boot. The
+			operation can be performed with TPM_IOC_SET_LOCALITY
+			applied to /dev/tpm0. The default value is 0.
+
 	tpm_suspend_pcr=[HW,TPM]
 			Format: integer pcr id
 			Specify that at suspend time, the tpm driver
diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index e4be1378ba26..3eba57ab2fb1 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -338,6 +338,8 @@ Code  Seq#    Include File                                           Comments
 0xA3  90-9F  linux/dtlk.h
 0xA4  00-1F  uapi/linux/tee.h                                        Generic TEE subsystem
 0xA4  00-1F  uapi/asm/sgx.h                                          <mailto:linux-sgx@vger.kernel.org>
+0xA4  00-1F  uapi/linux/tpm.h                                        TPM
+                                                                     <mailto:linux-integrity@vger.kernel.org>
 0xA5  01-05  linux/surface_aggregator/cdev.h                         Microsoft Surface Platform System Aggregator
                                                                      <mailto:luzmaximilian@gmail.com>
 0xA5  20-2F  linux/surface_aggregator/dtx.h                          Microsoft Surface DTX driver
diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 7df7abaf3e52..c8016342352a 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -44,7 +44,7 @@ static int tpm_request_locality(struct tpm_chip *chip)
 	if (!chip->ops->request_locality)
 		return 0;
 
-	rc = chip->ops->request_locality(chip, 0);
+	rc = chip->ops->request_locality(chip, chip->default_locality);
 	if (rc < 0)
 		return rc;
 
diff --git a/drivers/char/tpm/tpm-dev.c b/drivers/char/tpm/tpm-dev.c
index 97c94b5e9340..d07aec98f894 100644
--- a/drivers/char/tpm/tpm-dev.c
+++ b/drivers/char/tpm/tpm-dev.c
@@ -13,8 +13,74 @@
  * Device file system interface to the TPM
  */
 #include <linux/slab.h>
+#include <uapi/linux/tpm.h>
 #include "tpm-dev.h"
 
+static bool set_locality_enabled;
+module_param(set_locality_enabled, bool, 0644);
+
+/*
+ * Set a locality as a one-shot operation. A chip must declare support for it
+ * with %TPM_CHIP_FLAG_SET_LOCALITY_ENABLED, which will cleared after setting
+ * the locality.
+ */
+static long tpm_ioc_set_locality(struct tpm_chip *chip, u8 __user *localityp)
+{
+	u8 locality;
+
+	if (!set_locality_enabled)
+		return -ENOIOCTLCMD;
+
+	if (!(chip->flags & TPM_CHIP_FLAG_SET_LOCALITY_ENABLED))
+		return -EOPNOTSUPP;
+
+	if (copy_from_user(&locality, localityp, sizeof(locality)))
+		return -EFAULT;
+
+	if (locality >= TPM_MAX_LOCALITY)
+		return -EINVAL;
+
+	chip->default_locality = locality;
+	chip->flags &= ~TPM_CHIP_FLAG_SET_LOCALITY_ENABLED;
+	return 0;
+}
+
+static long tpm_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct file_priv *priv = file->private_data;
+	void __user *argp = (void __user *)arg;
+	struct tpm_chip *chip = priv->chip;
+	int ret;
+
+	mutex_lock(&priv->buffer_mutex);
+
+	ret = tpm_try_get_ops(chip);
+	if (ret)
+		goto out;
+
+	switch (cmd) {
+	case TPM_IOC_SET_LOCALITY:
+		ret = tpm_ioc_set_locality(chip, argp);
+		break;
+	default:
+		ret = -ENOIOCTLCMD;
+		break;
+	}
+
+	tpm_put_ops(chip);
+
+out:
+	mutex_unlock(&priv->buffer_mutex);
+	return 0;
+}
+
+#ifdef CONFIG_COMPAT
+static long tpm_compat_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
+{
+	return tpm_ioctl(filep, cmd, arg);
+}
+#endif
+
 static int tpm_open(struct inode *inode, struct file *file)
 {
 	struct tpm_chip *chip;
@@ -59,6 +125,10 @@ static int tpm_release(struct inode *inode, struct file *file)
 
 const struct file_operations tpm_fops = {
 	.owner = THIS_MODULE,
+	.unlocked_ioctl = tpm_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = tpm_compat_ioctl,
+#endif
 	.open = tpm_open,
 	.read = tpm_common_read,
 	.write = tpm_common_write,
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index fdef214b9f6b..3517db710423 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -1111,6 +1111,8 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
 
+	chip->flags |= TPM_CHIP_FLAG_SET_LOCALITY_ENABLED;
+
 #ifdef CONFIG_ACPI
 	chip->acpi_dev_handle = acpi_dev_handle;
 #endif
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 587b96b4418e..27071ef13b7a 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -147,6 +147,12 @@ struct tpm_chip_seqops {
  */
 #define TPM2_MAX_CONTEXT_SIZE 4096
 
+/*
+ * The maximum locality (0 - 4) for a TPM, as defined in section 3.2 of the
+ * Client Platform Profile Specification.
+ */
+#define TPM_MAX_LOCALITY		4
+
 struct tpm_chip {
 	struct device dev;
 	struct device devs;
@@ -202,6 +208,9 @@ struct tpm_chip {
 	/* active locality */
 	int locality;
 
+	/* the default locality used by the kernel (default 0) */
+	u8 default_locality;
+
 #ifdef CONFIG_TCG_TPM2_HMAC
 	/* details for communication security via sessions */
 
@@ -348,6 +357,7 @@ enum tpm_chip_flags {
 	TPM_CHIP_FLAG_SUSPENDED			= BIT(8),
 	TPM_CHIP_FLAG_HWRNG_DISABLED		= BIT(9),
 	TPM_CHIP_FLAG_DISABLE			= BIT(10),
+	TPM_CHIP_FLAG_SET_LOCALITY_ENABLED	= BIT(11),
 };
 
 #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
diff --git a/include/uapi/linux/tpm.h b/include/uapi/linux/tpm.h
new file mode 100644
index 000000000000..73485a184f14
--- /dev/null
+++ b/include/uapi/linux/tpm.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_TPM_H
+#define _UAPI_TPM_H
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+#define TPM_MAGIC 0xA4
+#define TPM_IOC_SET_LOCALITY _IOW(TPM_MAGIC, 0x00, __u8)
+
+#endif /* _UAPI_TPM_H */
-- 
2.47.0


