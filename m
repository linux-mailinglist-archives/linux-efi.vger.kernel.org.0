Return-Path: <linux-efi+bounces-829-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA2887E1E8
	for <lists+linux-efi@lfdr.de>; Mon, 18 Mar 2024 02:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77564B212DD
	for <lists+linux-efi@lfdr.de>; Mon, 18 Mar 2024 01:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795521E866;
	Mon, 18 Mar 2024 01:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UjUANLT9"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3EE1E862;
	Mon, 18 Mar 2024 01:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710726934; cv=none; b=sBXtAwAJnfX1qgqLUoWRa4ZnKim8PYb3lX2qGhfTTa3n7JAozK8kuVatpayzoNvUm2NpnDL/9MrR39rJVtLN0LEhsIPT3euPpnD9EWhFrOgeO7grqUuBmupgWQFhM+FM2G5wgeNoh2T/53ciklmY1y4lMSv/mSfNbRUb4hS4BEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710726934; c=relaxed/simple;
	bh=iUMk+G89JkHrqV4fUL3Gt28oxAeNaZnrFGaHr6SxGkU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PZqhkYlnKHq2fXG2WjHTdyGtKOLhklEO49UOIOwp6L67yDF5DgN/ilHBNSt3NNAYZjBrybiiAcwPPlzOPBtPe926pSKCPzBbLFBJoonwdrpiR2gyX6E3bU4oYftCWR2Z3DJKks+LBxIZ5oWPDcE7VD5y54kP9pHnRbirFH6m31I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UjUANLT9; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710726933; x=1742262933;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iUMk+G89JkHrqV4fUL3Gt28oxAeNaZnrFGaHr6SxGkU=;
  b=UjUANLT9jAo8tjCK8wAGSQTnlyg600xxCaigcuF7w8QVrL65eZqD44O9
   5jZDUwXyDyfx2zCB5zdHj4lVUk9cXDlyer3T/qYJNLnDwjb+D7t9Xb+HZ
   kz1JORYPXyI8Z2pmU5u5Jvpw6EvzEdY4P18js1u8mJ1Nxddzg6aYXXK5W
   zUIANXikv7HzvjyuDrS4AuMS7O0thEdDJV2Z+Sna7P0zL1iZO0h+NBLRJ
   x1fdkgXWeeiT8bmUY9iPvMOW3fWJfAicC6TWELU5J/7DO4mjXNwxd5LEt
   K33Cus+19/TVQ1R0rBTGu2U1Z9fQDjSkp42zwIJsDQrBvOTlL6auz1ogF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="16668193"
X-IronPort-AV: E=Sophos;i="6.07,133,1708416000"; 
   d="scan'208";a="16668193"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2024 18:55:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,133,1708416000"; 
   d="scan'208";a="44248090"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by orviesa002.jf.intel.com with ESMTP; 17 Mar 2024 18:55:29 -0700
From: Haibo Xu <haibo1.xu@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-efi@vger.kernel.org
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	ardb@kernel.org,
	sunilvl@ventanamicro.com,
	xiaobo55x@gmail.com,
	Haibo Xu <haibo1.xu@intel.com>
Subject: [PATCH v2] riscv: dmi: Add SMBIOS/DMI support
Date: Mon, 18 Mar 2024 10:09:16 +0800
Message-Id: <20240318020916.1299190-1-haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the dmi driver for riscv which would allow access the
SMBIOS info through some userspace file(/sys/firmware/dmi/*).

The change was based on that of arm64 and has been verified
by dmidecode tool.

Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
Changes since v1
  - Change to use memremap/memunmap for dmi_(early)_remap/unmap
    definition(suggested by Ard)
  - Minor clean up for comments (Ard)
---
 arch/riscv/Kconfig                   | 11 +++++++++++
 arch/riscv/include/asm/dmi.h         | 24 ++++++++++++++++++++++++
 drivers/firmware/efi/riscv-runtime.c | 13 +++++++++++++
 3 files changed, 48 insertions(+)
 create mode 100644 arch/riscv/include/asm/dmi.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 8ebafe337eac..3639151cb4ef 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -952,6 +952,17 @@ config EFI
 	  allow the kernel to be booted as an EFI application. This
 	  is only useful on systems that have UEFI firmware.
 
+config DMI
+	bool "Enable support for SMBIOS (DMI) tables"
+	depends on EFI
+	default y
+	help
+	  This enables SMBIOS/DMI feature for systems.
+
+	  This option is only useful on systems that have UEFI firmware.
+	  However, even with this option, the resultant kernel should
+	  continue to boot on existing non-UEFI platforms.
+
 config CC_HAVE_STACKPROTECTOR_TLS
 	def_bool $(cc-option,-mstack-protector-guard=tls -mstack-protector-guard-reg=tp -mstack-protector-guard-offset=0)
 
diff --git a/arch/riscv/include/asm/dmi.h b/arch/riscv/include/asm/dmi.h
new file mode 100644
index 000000000000..ca7cce557ef7
--- /dev/null
+++ b/arch/riscv/include/asm/dmi.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024 Intel Corporation
+ *
+ * based on arch/arm64/include/asm/dmi.h
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#ifndef __ASM_DMI_H
+#define __ASM_DMI_H
+
+#include <linux/io.h>
+#include <linux/slab.h>
+
+#define dmi_early_remap(x, l)		memremap(x, l, MEMREMAP_WB)
+#define dmi_early_unmap(x, l)		memunmap(x)
+#define dmi_remap(x, l)			memremap(x, l, MEMREMAP_WB)
+#define dmi_unmap(x)			memunmap(x)
+#define dmi_alloc(l)			kzalloc(l, GFP_KERNEL)
+
+#endif
diff --git a/drivers/firmware/efi/riscv-runtime.c b/drivers/firmware/efi/riscv-runtime.c
index 09525fb5c240..c3bfb9e77e02 100644
--- a/drivers/firmware/efi/riscv-runtime.c
+++ b/drivers/firmware/efi/riscv-runtime.c
@@ -152,3 +152,16 @@ void arch_efi_call_virt_teardown(void)
 {
 	efi_virtmap_unload();
 }
+
+static int __init riscv_dmi_init(void)
+{
+	/*
+	 * On riscv, DMI depends on UEFI, and dmi_setup() needs to
+	 * be called early because dmi_id_init(), which is an arch_initcall
+	 * itself, depends on dmi_scan_machine() having been called already.
+	 */
+	dmi_setup();
+
+	return 0;
+}
+core_initcall(riscv_dmi_init);
-- 
2.34.1


