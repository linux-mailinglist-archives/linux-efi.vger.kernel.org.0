Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFE612DA4C
	for <lists+linux-efi@lfdr.de>; Tue, 31 Dec 2019 17:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfLaQZY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Dec 2019 11:25:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:37086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfLaQZY (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 31 Dec 2019 11:25:24 -0500
Received: from localhost.localdomain (91-167-84-221.subs.proxad.net [91.167.84.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DAC4206D9;
        Tue, 31 Dec 2019 16:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577809523;
        bh=y6g0BUdgEHUWB2uWwIUzYIyMtZZVgqLbDgyvIjJ17aY=;
        h=From:To:Cc:Subject:Date:From;
        b=pfHQwFOFN374ffFBUHVHWEhiRFy1U1fhOJREPft2VXjDdHOPhtvAzjstE/SUHQXqn
         QgjBVsL17f7Gh+5HeU1I5IDCrSAcCrumWqmRhCw9ERRaMAMPM0GUT9waypn2DP/zw3
         oeNtww5b6oA594ZBeaAH2os7rdOX7QTpelcUmu/g=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Matthew Garrett <matthewgarrett@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Matthew Garrett <mjg59@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v3] efi: Allow disabling PCI busmastering on bridges during boot
Date:   Tue, 31 Dec 2019 17:23:44 +0100
Message-Id: <20191231162344.130654-1-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Matthew Garrett <matthewgarrett@google.com>

Add an option to disable the busmaster bit in the control register on
all PCI bridges calling ExitBootServices() and passing control to the
runtime kernel. System firmware may configure the IOMMU to prevent
malicious PCI devices from being able to attack the OS via DMA. However,
since firmware can't guarantee that the OS is IOMMU-aware, it will tear
down IOMMU configuration when ExitBootServices() is called. This leaves
a window between where a hostile device could still cause damage before
Linux configures the IOMMU again.

If CONFIG_EFI_DISABLE_PCI_DMA is enabled or "efi=disable_early_pci_dma"
is passed on the command line, the EFI stub will clear the busmaster bit
on all PCI bridges before ExitBootServices() is called. This will
prevent any malicious PCI devices from being able to perform DMA until
the kernel reenables busmastering after configuring the IOMMU.

This option may cause failures with some poorly behaved hardware and
should not be enabled without testing. The kernel commandline options
"efi=disable_early_pci_dma" or "efi=no_disable_early_pci_dma" may be
used to override the default. Note that PCI devices downstream from PCI
bridges are disconnected from their drivers first, using the UEFI
driver model API, so that DMA can be disabled safely at the bridge
level.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arvind Sankar <nivedita@alum.mit.edu>
Co-developed-by: Matthew Garrett <mjg59@google.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
[ardb: disconnect PCI I/O handles first, as suggested by Arvind]
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |   4 +
 arch/x86/boot/compressed/eboot.c                |   2 +
 drivers/firmware/efi/Kconfig                    |  22 ++++
 drivers/firmware/efi/libstub/Makefile           |   2 +-
 drivers/firmware/efi/libstub/arm-stub.c         |   1 +
 drivers/firmware/efi/libstub/efi-stub-helper.c  |  17 +++
 drivers/firmware/efi/libstub/efistub.h          |   1 +
 drivers/firmware/efi/libstub/pci.c              | 118 ++++++++++++++++++++
 include/linux/efi.h                             |   6 +-
 9 files changed, 171 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fbcf8d1eb3ee..9db18aa1f75c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1177,6 +1177,10 @@
 			claim. Specify efi=nosoftreserve to disable this
 			reservation and treat the memory by its base type
 			(i.e. EFI_CONVENTIONAL_MEMORY / "System RAM").
+			disable_early_pci_dma: Disable the busmaster bit on all
+			PCI bridges while in the EFI boot stub
+			no_disable_early_pci_dma: Leave the busmaster bit set
+			on all PCI bridges while in the EFI boot stub
 
 	efi_no_storage_paranoia [EFI; X86]
 			Using this parameter you can use more than 50% of
diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 98477f3529f6..4a96761a2bfd 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -166,6 +166,8 @@ static void setup_efi_pci(struct boot_params *params)
 
 free_handle:
 	efi_bs_call(free_pool, pci_handle);
+
+	efi_pci_disable_bridge_busmaster();
 }
 
 static void retrieve_apple_device_properties(struct boot_params *boot_params)
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index bcc378c19ebe..5e78c5f6c751 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -215,6 +215,28 @@ config EFI_RCI2_TABLE
 
 	  Say Y here for Dell EMC PowerEdge systems.
 
+config EFI_DISABLE_PCI_DMA
+       bool "Clear Busmaster bit on PCI bridges during ExitBootServices()"
+       help
+	  Disable the busmaster bit in the control register on all PCI bridges
+	  while calling ExitBootServices() and passing control to the runtime
+	  kernel. System firmware may configure the IOMMU to prevent malicious
+	  PCI devices from being able to attack the OS via DMA. However, since
+	  firmware can't guarantee that the OS is IOMMU-aware, it will tear
+	  down IOMMU configuration when ExitBootServices() is called. This
+	  leaves a window between where a hostile device could still cause
+	  damage before Linux configures the IOMMU again.
+
+	  If you say Y here, the EFI stub will clear the busmaster bit on all
+	  PCI bridges before ExitBootServices() is called. This will prevent
+	  any malicious PCI devices from being able to perform DMA until the
+	  kernel reenables busmastering after configuring the IOMMU.
+
+	  This option will cause failures with some poorly behaved hardware
+	  and should not be enabled without testing. The kernel commandline
+	  options "efi=disable_early_pci_dma" or "efi=no_disable_early_pci_dma"
+	  may be used to override this option.
+
 endmenu
 
 config UEFI_CPER
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index c35f893897e1..98a81576213d 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -39,7 +39,7 @@ OBJECT_FILES_NON_STANDARD	:= y
 KCOV_INSTRUMENT			:= n
 
 lib-y				:= efi-stub-helper.o gop.o secureboot.o tpm.o \
-				   random.o
+				   random.o pci.o
 
 # include the stub's generic dependencies from lib/ when building for ARM/arm64
 arm-deps-y := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c fdt_empty_tree.c fdt_sw.c
diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index 7bbef4a67350..9857f831638c 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -256,6 +256,7 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table_arg,
 	}
 
 	install_memreserve_table();
+	efi_pci_disable_bridge_busmaster();
 
 	new_fdt_addr = fdt_addr;
 	status = allocate_new_fdt_and_exit_boot(handle,
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index f1b9c36934e9..47dc404675b2 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -33,6 +33,8 @@ static bool __efistub_global efi_nokaslr;
 static bool __efistub_global efi_quiet;
 static bool __efistub_global efi_novamap;
 static bool __efistub_global efi_nosoftreserve;
+static bool __efistub_global efi_disable_pci_dma =
+					IS_ENABLED(CONFIG_EFI_DISABLE_PCI_DMA);
 
 bool __pure nokaslr(void)
 {
@@ -51,6 +53,11 @@ bool __pure __efi_soft_reserve_enabled(void)
 	return !efi_nosoftreserve;
 }
 
+bool __pure disable_pci_dma(void)
+{
+	return efi_disable_pci_dma;
+}
+
 #define EFI_MMAP_NR_SLACK_SLOTS	8
 
 struct file_info {
@@ -493,6 +500,16 @@ efi_status_t efi_parse_options(char const *cmdline)
 			efi_nosoftreserve = true;
 		}
 
+		if (!strncmp(str, "disable_early_pci_dma", 21)) {
+			str += strlen("disable_early_pci_dma");
+			efi_disable_pci_dma = true;
+		}
+
+		if (!strncmp(str, "no_disable_early_pci_dma", 24)) {
+			str += strlen("no_disable_early_pci_dma");
+			efi_disable_pci_dma = false;
+		}
+
 		/* Group words together, delimited by "," */
 		while (*str && *str != ' ' && *str != ',')
 			str++;
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index c244b165005e..2748eb4c7831 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -34,6 +34,7 @@
 extern bool __pure nokaslr(void);
 extern bool __pure is_quiet(void);
 extern bool __pure novamap(void);
+extern bool __pure disable_pci_dma(void);
 
 extern __pure efi_system_table_t  *efi_system_table(void);
 
diff --git a/drivers/firmware/efi/libstub/pci.c b/drivers/firmware/efi/libstub/pci.c
new file mode 100644
index 000000000000..08f03ee7e5ee
--- /dev/null
+++ b/drivers/firmware/efi/libstub/pci.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI-related functions used by the EFI stub on multiple
+ * architectures.
+ *
+ * Copyright 2019 Google, LLC
+ */
+
+#include <linux/efi.h>
+#include <linux/pci.h>
+
+#include <asm/efi.h>
+
+#include "efistub.h"
+
+void efi_pci_disable_bridge_busmaster(void)
+{
+	efi_guid_t pci_proto = EFI_PCI_IO_PROTOCOL_GUID;
+	unsigned long pci_handle_size = 0;
+	efi_handle_t *pci_handle = NULL;
+	efi_handle_t handle;
+	efi_status_t status;
+	u16 class, command;
+	int i;
+
+	if (!disable_pci_dma())
+		return;
+
+	status = efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL, &pci_proto,
+			     NULL, &pci_handle_size, pci_handle);
+
+	if (status != EFI_BUFFER_TOO_SMALL) {
+		if (status != EFI_SUCCESS && status != EFI_NOT_FOUND)
+			pr_efi_err("Failed to locate PCI I/O handles'\n");
+		return;
+	}
+
+	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, pci_handle_size,
+			     (void **)&pci_handle);
+	if (status != EFI_SUCCESS) {
+		pr_efi_err("Failed to allocate memory for 'pci_handle'\n");
+		return;
+	}
+
+	status = efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL, &pci_proto,
+			     NULL, &pci_handle_size, pci_handle);
+	if (status != EFI_SUCCESS) {
+		pr_efi_err("Failed to locate PCI I/O handles'\n");
+		goto free_handle;
+	}
+
+	for_each_efi_handle(handle, pci_handle, pci_handle_size, i) {
+		efi_pci_io_protocol_t *pci = NULL;
+		unsigned long segment_nr, bus_nr, device_nr, func_nr;
+
+		status = efi_bs_call(handle_protocol, handle, &pci_proto,
+				     (void **)&pci);
+		if (status != EFI_SUCCESS)
+			continue;
+
+		/*
+		 * Disregard devices living on bus 0 - these are not behind a
+		 * bridge so no point in disconnecting them from their drivers.
+		 */
+		bus_nr = 0;
+		status = efi_call_proto(pci, get_location, &segment_nr, &bus_nr,
+					&device_nr, &func_nr);
+		if (status != EFI_SUCCESS || bus_nr == 0)
+			continue;
+
+		/*
+		 * Don't disconnect VGA controllers so we don't risk losing
+		 * access to the framebuffer. Drivers for true PCIe graphics
+		 * controllers that are behind a PCIe root port do not use
+		 * DMA to implement the GOP framebuffer anyway [although they
+		 * may use it in their implentation of Gop->Blt()], and so
+		 * disabling DMA in the PCI bridge should not interfere with
+		 * normal operation of the device.
+		 */
+		status = efi_call_proto(pci, pci.read, EfiPciIoWidthUint16,
+					PCI_CLASS_DEVICE, 1, &class);
+		if (status != EFI_SUCCESS || class == PCI_CLASS_DISPLAY_VGA)
+			continue;
+
+		/* Disconnect this handle from all its drivers */
+		efi_bs_call(disconnect_controller, handle, NULL, NULL);
+	}
+
+	for_each_efi_handle(handle, pci_handle, pci_handle_size, i) {
+		efi_pci_io_protocol_t *pci = NULL;
+
+		status = efi_bs_call(handle_protocol, handle, &pci_proto,
+				     (void **)&pci);
+		if (status != EFI_SUCCESS || !pci)
+			continue;
+
+		status = efi_call_proto(pci, pci.read, EfiPciIoWidthUint16,
+					PCI_CLASS_DEVICE, 1, &class);
+
+		if (status != EFI_SUCCESS || class != PCI_CLASS_BRIDGE_PCI)
+			continue;
+
+		/* Disable busmastering */
+		status = efi_call_proto(pci, pci.read, EfiPciIoWidthUint16,
+					PCI_COMMAND, 1, &command);
+		if (status != EFI_SUCCESS || !(command & PCI_COMMAND_MASTER))
+			continue;
+
+		command &= ~PCI_COMMAND_MASTER;
+		status = efi_call_proto(pci, pci.write, EfiPciIoWidthUint16,
+					PCI_COMMAND, 1, &command);
+		if (status != EFI_SUCCESS)
+			pr_efi_err("Failed to disable PCI busmastering\n");
+	}
+
+free_handle:
+	efi_bs_call(free_pool, pci_handle);
+}
diff --git a/include/linux/efi.h b/include/linux/efi.h
index ee68ea6f85ff..7e8e25b1d11c 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -319,7 +319,9 @@ typedef union {
 		void *stall;
 		void *set_watchdog_timer;
 		void *connect_controller;
-		void *disconnect_controller;
+		efi_status_t (__efiapi *disconnect_controller)(efi_handle_t,
+							       efi_handle_t,
+							       efi_handle_t);
 		void *open_protocol;
 		void *close_protocol;
 		void *open_protocol_information;
@@ -1692,4 +1694,6 @@ struct linux_efi_memreserve {
 #define EFI_MEMRESERVE_COUNT(size) (((size) - sizeof(struct linux_efi_memreserve)) \
 	/ sizeof(((struct linux_efi_memreserve *)0)->entry[0]))
 
+void efi_pci_disable_bridge_busmaster(void);
+
 #endif /* _LINUX_EFI_H */
-- 
2.20.1

