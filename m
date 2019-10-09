Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9F0FD1C93
	for <lists+linux-efi@lfdr.de>; Thu, 10 Oct 2019 01:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732395AbfJIXS7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Oct 2019 19:18:59 -0400
Received: from mga07.intel.com ([134.134.136.100]:59968 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731145AbfJIXS7 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 9 Oct 2019 19:18:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 16:18:58 -0700
X-IronPort-AV: E=Sophos;i="5.67,277,1566889200"; 
   d="scan'208";a="393845622"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 16:18:57 -0700
Subject: [PATCH v6 01/12] acpi/numa: Establish a new drivers/acpi/numa/
 directory
From:   Dan Williams <dan.j.williams@intel.com>
To:     mingo@redhat.com
Cc:     Len Brown <lenb@kernel.org>, Keith Busch <kbusch@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        peterz@infradead.org, vishal.l.verma@intel.com,
        ard.biesheuvel@linaro.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Date:   Wed, 09 Oct 2019 16:04:40 -0700
Message-ID: <157066228021.1059972.697896634266979217.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157066227329.1059972.5659620631541203458.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157066227329.1059972.5659620631541203458.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Currently hmat.c lives under an "hmat" directory which does not enhance
the description of the file. The initial motivation for giving hmat.c
its own directory was to delineate it as mm functionality in contrast to
ACPI device driver functionality.

As ACPI continues to play an increasing role in conveying
memory location and performance topology information to the OS take the
opportunity to co-locate these NUMA relevant tables in a combined
directory.

numa.c is renamed to srat.c and moved to drivers/acpi/numa/ along with
hmat.c.

Cc: Len Brown <lenb@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/Kconfig       |    9 +--------
 drivers/acpi/Makefile      |    3 +--
 drivers/acpi/hmat/Makefile |    2 --
 drivers/acpi/numa/Kconfig  |    6 ++++++
 drivers/acpi/numa/Makefile |    3 +++
 drivers/acpi/numa/hmat.c   |    0 
 drivers/acpi/numa/srat.c   |    0 
 7 files changed, 11 insertions(+), 12 deletions(-)
 delete mode 100644 drivers/acpi/hmat/Makefile
 rename drivers/acpi/{hmat/Kconfig => numa/Kconfig} (77%)
 create mode 100644 drivers/acpi/numa/Makefile
 rename drivers/acpi/{hmat/hmat.c => numa/hmat.c} (100%)
 rename drivers/acpi/{numa.c => numa/srat.c} (100%)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index ebe1e9e5fd81..8c7c46065e9d 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -319,12 +319,6 @@ config ACPI_THERMAL
 	  To compile this driver as a module, choose M here:
 	  the module will be called thermal.
 
-config ACPI_NUMA
-	bool "NUMA support"
-	depends on NUMA
-	depends on (X86 || IA64 || ARM64)
-	default y if IA64 || ARM64
-
 config ACPI_CUSTOM_DSDT_FILE
 	string "Custom DSDT Table file to include"
 	default ""
@@ -473,8 +467,7 @@ config ACPI_REDUCED_HARDWARE_ONLY
 	  If you are unsure what to do, do not enable this option.
 
 source "drivers/acpi/nfit/Kconfig"
-source "drivers/acpi/hmat/Kconfig"
-
+source "drivers/acpi/numa/Kconfig"
 source "drivers/acpi/apei/Kconfig"
 source "drivers/acpi/dptf/Kconfig"
 
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 5d361e4e3405..f08a661274e8 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -55,7 +55,6 @@ acpi-$(CONFIG_X86)		+= acpi_cmos_rtc.o
 acpi-$(CONFIG_X86)		+= x86/apple.o
 acpi-$(CONFIG_X86)		+= x86/utils.o
 acpi-$(CONFIG_DEBUG_FS)		+= debugfs.o
-acpi-$(CONFIG_ACPI_NUMA)	+= numa.o
 acpi-$(CONFIG_ACPI_PROCFS_POWER) += cm_sbs.o
 acpi-y				+= acpi_lpat.o
 acpi-$(CONFIG_ACPI_LPIT)	+= acpi_lpit.o
@@ -80,7 +79,7 @@ obj-$(CONFIG_ACPI_PROCESSOR)	+= processor.o
 obj-$(CONFIG_ACPI)		+= container.o
 obj-$(CONFIG_ACPI_THERMAL)	+= thermal.o
 obj-$(CONFIG_ACPI_NFIT)		+= nfit/
-obj-$(CONFIG_ACPI_HMAT)		+= hmat/
+obj-$(CONFIG_ACPI_NUMA)		+= numa/
 obj-$(CONFIG_ACPI)		+= acpi_memhotplug.o
 obj-$(CONFIG_ACPI_HOTPLUG_IOAPIC) += ioapic.o
 obj-$(CONFIG_ACPI_BATTERY)	+= battery.o
diff --git a/drivers/acpi/hmat/Makefile b/drivers/acpi/hmat/Makefile
deleted file mode 100644
index 1c20ef36a385..000000000000
--- a/drivers/acpi/hmat/Makefile
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_ACPI_HMAT) := hmat.o
diff --git a/drivers/acpi/hmat/Kconfig b/drivers/acpi/numa/Kconfig
similarity index 77%
rename from drivers/acpi/hmat/Kconfig
rename to drivers/acpi/numa/Kconfig
index 95a29964dbea..acbd5aa76e40 100644
--- a/drivers/acpi/hmat/Kconfig
+++ b/drivers/acpi/numa/Kconfig
@@ -1,4 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
+config ACPI_NUMA
+	bool "NUMA support"
+	depends on NUMA
+	depends on (X86 || IA64 || ARM64)
+	default y if IA64 || ARM64
+
 config ACPI_HMAT
 	bool "ACPI Heterogeneous Memory Attribute Table Support"
 	depends on ACPI_NUMA
diff --git a/drivers/acpi/numa/Makefile b/drivers/acpi/numa/Makefile
new file mode 100644
index 000000000000..517a6c689a94
--- /dev/null
+++ b/drivers/acpi/numa/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_ACPI_NUMA) += srat.o
+obj-$(CONFIG_ACPI_HMAT) += hmat.o
diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/numa/hmat.c
similarity index 100%
rename from drivers/acpi/hmat/hmat.c
rename to drivers/acpi/numa/hmat.c
diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa/srat.c
similarity index 100%
rename from drivers/acpi/numa.c
rename to drivers/acpi/numa/srat.c

