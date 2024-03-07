Return-Path: <linux-efi+bounces-756-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BA3874966
	for <lists+linux-efi@lfdr.de>; Thu,  7 Mar 2024 09:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80BAB282B82
	for <lists+linux-efi@lfdr.de>; Thu,  7 Mar 2024 08:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A75C6313F;
	Thu,  7 Mar 2024 08:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c5K93M9n"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9161D6311A;
	Thu,  7 Mar 2024 08:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709799487; cv=none; b=IYInMVPi7dlMUFnIYDJZCpEEa0db+pLSyk2eV7qsh+fv1X35is0pwpn3yO7I9L3j0wWlgiC19/MgLTcYncv2JWtf0hy2P9Hevgmg2nUCW3lrrVCknJCXs4RAx0Ml6FHbTEe3vz3A9IaEJVdzF9f6GxmaHqOuww/hYQilGCCi6rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709799487; c=relaxed/simple;
	bh=0eSjyN2LlC9Wrx63xy7rOACa0dzQKMyCRU8Nm4Mq0Hg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lFpHSMP7iaoobXbup+u1Q4SiMvhq2hROndygCn/U8g0qGTzJ2vmdH55N1GLkEKU3eItucWhW0YAV/4d6yvQyjlkwbH9FnTno0HWc1+c3eZla5Fd4oyynvd0WV4ZC3bZ+KRjkU0i81n8WS2JfNWiBE9RMkFU1IUsTDlmEvEmhD+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c5K93M9n; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709799486; x=1741335486;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0eSjyN2LlC9Wrx63xy7rOACa0dzQKMyCRU8Nm4Mq0Hg=;
  b=c5K93M9nKDECMYkpKu1LDXuY5rRfGdW5j7bjVWsEVoc4Ud/i7jFXRch5
   QJbuz7qpcuYxDRzl8RpqB9N/NXI7JmjRWgwk7qAHFmQlf/Ibf+3QWnr1V
   9MNZZ8QiqZaw7/kURl8uTpN1/ODtBAVN0TviGhfUV+v1db5FcQTOM0oj9
   KHUz0bnaB/pQBYgdMgh9K/1KQOenL3S8OtmrwgRd0MnbX3FGnsbKoxi6U
   OQvjwy5tgMupSeHVNamDOTzAo6rccbE7NRrowtrxCbyRf9bpL1qBPLIjD
   c27TOJb/bCftv9rvzIkU4srTBqTS8A9E9zTGiS2+hsm6Edj01LYf/BhbZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4577437"
X-IronPort-AV: E=Sophos;i="6.06,210,1705392000"; 
   d="scan'208";a="4577437"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 00:18:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,210,1705392000"; 
   d="scan'208";a="14598959"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by fmviesa003.fm.intel.com with ESMTP; 07 Mar 2024 00:18:02 -0800
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
Subject: [PATCH] riscv: dmi: Add SMBIOS/DMI support
Date: Thu,  7 Mar 2024 16:31:54 +0800
Message-Id: <20240307083154.346542-1-haibo1.xu@intel.com>
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
 arch/riscv/Kconfig                   | 11 +++++++++++
 arch/riscv/include/asm/dmi.h         | 29 ++++++++++++++++++++++++++++
 drivers/firmware/efi/riscv-runtime.c | 13 +++++++++++++
 3 files changed, 53 insertions(+)
 create mode 100644 arch/riscv/include/asm/dmi.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 0bfcfec67ed5..a123a3e7e5f3 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -918,6 +918,17 @@ config EFI
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
index 000000000000..a861043f02dc
--- /dev/null
+++ b/arch/riscv/include/asm/dmi.h
@@ -0,0 +1,29 @@
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
+/*
+ * According to section 2.3.6 of the UEFI spec, the firmware should not
+ * request a virtual mapping for configuration tables such as SMBIOS.
+ * This means we have to map them before use.
+ */
+#define dmi_early_remap(x, l)		ioremap_prot(x, l, _PAGE_KERNEL)
+#define dmi_early_unmap(x, l)		iounmap(x)
+#define dmi_remap(x, l)			ioremap_prot(x, l, _PAGE_KERNEL)
+#define dmi_unmap(x)			iounmap(x)
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


