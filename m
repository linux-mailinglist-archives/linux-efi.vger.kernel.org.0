Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD583054A
	for <lists+linux-efi@lfdr.de>; Fri, 31 May 2019 01:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfE3XNQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 May 2019 19:13:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:24884 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfE3XNQ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 30 May 2019 19:13:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 May 2019 16:13:15 -0700
X-ExtLoop1: 1
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga004.jf.intel.com with ESMTP; 30 May 2019 16:13:15 -0700
Subject: [PATCH v2 1/8] acpi: Drop drivers/acpi/hmat/ directory
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-efi@vger.kernel.org
Cc:     Len Brown <lenb@kernel.org>, Keith Busch <keith.busch@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, vishal.l.verma@intel.com,
        ard.biesheuvel@linaro.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-nvdimm@lists.01.org
Date:   Thu, 30 May 2019 15:59:27 -0700
Message-ID: <155925716783.3775979.13301455166290564145.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155925716254.3775979.16716824941364738117.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <155925716254.3775979.16716824941364738117.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

As a single source file object there is no need for the hmat enabling to
have its own directory.

Cc: Len Brown <lenb@kernel.org>
Cc: Keith Busch <keith.busch@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/Kconfig       |   12 +++++++++++-
 drivers/acpi/Makefile      |    2 +-
 drivers/acpi/hmat.c        |    0 
 drivers/acpi/hmat/Kconfig  |   11 -----------
 drivers/acpi/hmat/Makefile |    2 --
 5 files changed, 12 insertions(+), 15 deletions(-)
 rename drivers/acpi/{hmat/hmat.c => hmat.c} (100%)
 delete mode 100644 drivers/acpi/hmat/Kconfig
 delete mode 100644 drivers/acpi/hmat/Makefile

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 283ee94224c6..ec8691e4152f 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -475,7 +475,17 @@ config ACPI_REDUCED_HARDWARE_ONLY
 	  If you are unsure what to do, do not enable this option.
 
 source "drivers/acpi/nfit/Kconfig"
-source "drivers/acpi/hmat/Kconfig"
+
+config ACPI_HMAT
+	bool "ACPI Heterogeneous Memory Attribute Table Support"
+	depends on ACPI_NUMA
+	select HMEM_REPORTING
+	help
+	 If set, this option has the kernel parse and report the
+	 platform's ACPI HMAT (Heterogeneous Memory Attributes Table),
+	 register memory initiators with their targets, and export
+	 performance attributes through the node's sysfs device if
+	 provided.
 
 source "drivers/acpi/apei/Kconfig"
 source "drivers/acpi/dptf/Kconfig"
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 5d361e4e3405..fc89686498dd 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -80,7 +80,7 @@ obj-$(CONFIG_ACPI_PROCESSOR)	+= processor.o
 obj-$(CONFIG_ACPI)		+= container.o
 obj-$(CONFIG_ACPI_THERMAL)	+= thermal.o
 obj-$(CONFIG_ACPI_NFIT)		+= nfit/
-obj-$(CONFIG_ACPI_HMAT)		+= hmat/
+obj-$(CONFIG_ACPI_HMAT)		+= hmat.o
 obj-$(CONFIG_ACPI)		+= acpi_memhotplug.o
 obj-$(CONFIG_ACPI_HOTPLUG_IOAPIC) += ioapic.o
 obj-$(CONFIG_ACPI_BATTERY)	+= battery.o
diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat.c
similarity index 100%
rename from drivers/acpi/hmat/hmat.c
rename to drivers/acpi/hmat.c
diff --git a/drivers/acpi/hmat/Kconfig b/drivers/acpi/hmat/Kconfig
deleted file mode 100644
index 95a29964dbea..000000000000
--- a/drivers/acpi/hmat/Kconfig
+++ /dev/null
@@ -1,11 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-config ACPI_HMAT
-	bool "ACPI Heterogeneous Memory Attribute Table Support"
-	depends on ACPI_NUMA
-	select HMEM_REPORTING
-	help
-	 If set, this option has the kernel parse and report the
-	 platform's ACPI HMAT (Heterogeneous Memory Attributes Table),
-	 register memory initiators with their targets, and export
-	 performance attributes through the node's sysfs device if
-	 provided.
diff --git a/drivers/acpi/hmat/Makefile b/drivers/acpi/hmat/Makefile
deleted file mode 100644
index 1c20ef36a385..000000000000
--- a/drivers/acpi/hmat/Makefile
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_ACPI_HMAT) := hmat.o

