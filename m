Return-Path: <linux-efi+bounces-1211-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F83906426
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jun 2024 08:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 439AEB21D47
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jun 2024 06:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5990BDDB1;
	Thu, 13 Jun 2024 06:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h6SNfWEm"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2BB136E39;
	Thu, 13 Jun 2024 06:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718260608; cv=none; b=qelY61g+8754knatA7VZOX4IlHKlofJb6+Kau9DY5UUqFXxA73lB7+OKq9CvjX+rUVNnr3FcPTBKXagSwvanTFr8WrJCRdIkpC+CzbPm8jjppP0CXxTtOsDMW8pQCkyLe7GMUZmGSmILG6OWp1KdPEqhjZxHGsIkcaM2ltWSqlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718260608; c=relaxed/simple;
	bh=eDdu2f2vHJxLbLwxDJ+vmJ3c8IHG3EBc5uQ2lTCDa7s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PIVS1Pe1HMd1JXZVrf3fIHDWa/tcxFOMRXAmBfpADUdKNKHLgnCoYe3bTbb8rC2ewB4XlGsYTLuzddROus2YJOfws2K38LlF/DwZ4mGWl0aCSgLhLwpT/PPGdv/jJDaGuEF8C7u4Ye3+y4cPWoRX0eCcvNrS/3wbwh90lmeYNdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h6SNfWEm; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718260607; x=1749796607;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eDdu2f2vHJxLbLwxDJ+vmJ3c8IHG3EBc5uQ2lTCDa7s=;
  b=h6SNfWEmXtIIAdEVmvrC6x1VdCDdsa3a5VA8IBMlIgsGk39HNcY0JHjZ
   fnD9sGmcehX9HdYIR12QFRGJd+4M4YmpyLvsM8W69aXtfOLde0nykT010
   WlPab/bBOMlApWRbVSOnATJzkhVCCflecZ9MIQl2qoqg4gdCs8fEeCn9T
   zUf59U6CEFqSefBNCuQVwNjoU7LPgbYHc9Upzy0HCJkx7MIAV/gqXhrrP
   vY36pa75S9Pk8r+AAVyc2XBHvLbJF/JwjbgGe9pYug/+A9nok8k1Cyi4I
   mtRpTnOrMPiVh/+ML5eYI3AgQEhJLbtnOMtc/wJ2DhHJpjMa28kum+6am
   Q==;
X-CSE-ConnectionGUID: UJQ44+lNTgG8SZd1vZ5ulg==
X-CSE-MsgGUID: Q/VVXnwmT62fStltw4RI8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="14780589"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="14780589"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 23:36:46 -0700
X-CSE-ConnectionGUID: J12hYHyfTnGD4ai7Jeh/5A==
X-CSE-MsgGUID: 9MGimWN5SvWDIfmjW64BAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="44939106"
Received: from unknown (HELO haibo-OptiPlex-7090.sh.intel.com) ([10.239.159.132])
  by orviesa003.jf.intel.com with ESMTP; 12 Jun 2024 23:36:43 -0700
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
	Haibo Xu <haibo1.xu@intel.com>,
	Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v3] riscv: dmi: Add SMBIOS/DMI support
Date: Thu, 13 Jun 2024 14:55:07 +0800
Message-Id: <20240613065507.287577-1-haibo1.xu@intel.com>
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
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
---
 Changes since v2
   - Rebase to Linux 6.10-rc3
   - Add Reviewed-by tag
---
 arch/riscv/Kconfig                   | 11 +++++++++++
 arch/riscv/include/asm/dmi.h         | 24 ++++++++++++++++++++++++
 drivers/firmware/efi/riscv-runtime.c | 13 +++++++++++++
 3 files changed, 48 insertions(+)
 create mode 100644 arch/riscv/include/asm/dmi.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 0525ee2d63c7..b1fc6db48e7a 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -967,6 +967,17 @@ config EFI
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
index 01f0f90ea418..fa71cd898120 100644
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


