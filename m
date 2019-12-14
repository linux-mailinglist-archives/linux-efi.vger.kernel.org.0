Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B43D211F001
	for <lists+linux-efi@lfdr.de>; Sat, 14 Dec 2019 03:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfLNCgC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Dec 2019 21:36:02 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:42792 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfLNCgB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Dec 2019 21:36:01 -0500
Received: by mail-pf1-f202.google.com with SMTP id s25so2701245pfd.9
        for <linux-efi@vger.kernel.org>; Fri, 13 Dec 2019 18:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=BzuOkp85Fyup3EI4GheCT5kaG1/F1s80DIcONtC1OgQ=;
        b=V0BCuAS0cvtGQ1FBO2my973/nI2b8vxzKdmGgoJ4Y0o2hTaclY1TdmzrWnGaFOhtV4
         rWoY5M/EnP6w5spmasPSlGhocmc7xpz4ErdUTgKHmOw76llQwXbeHq3GFNFSDfEMOots
         oD0s1g9e/fv7oAnnzKtUQed/ySPrURl+Ak29/HsAPN7INALTyObIz3Ncdzuj66mHQqu9
         hNp812TiLrU75lu/+B8xT8RTNli/N6oYpNdz4MUkxgj+X0gc4Ay2RUiwzYLWDpr0bxYZ
         LMElqLrFYMEAemSZ1L12bxfBITSyeUJLEdgUxXO9MXCFgUzYReN6SfxG994Bvx6MAWS+
         kO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=BzuOkp85Fyup3EI4GheCT5kaG1/F1s80DIcONtC1OgQ=;
        b=oqfGY5C0gOc9dhL8geVWMImqS462zPf3w44/zGfEc+oEXD/BQDU0P5uRZ5KRJcXOoM
         YObVLqEm/caC0ae2EtUZfQyAVdbkRu802pr/ddRBl4/LYiBw5VkYOqLjshpqQsAOYBLu
         vdV4/DSw3n2oPVH5Rlk26rz5UT0Tr2N1HNbHxV8Gta2v4ln/HN7sChXKcVvDuoZSDChD
         iu0O4WycH9JL/geYDAIjIe/yRf/Ong8IFhnGiIQZaia/lBodUOnpkjBfn0ikNpqA8LI2
         8gfPd2WHDQhVZtQwMOuvICb4yjBr89/gapkXSuRNsChjE660a5Bh8f8gCMWd9DRJVuex
         fCZg==
X-Gm-Message-State: APjAAAUay+S4VkEG0p+Kz5UEDO/Zj7cKGzVLDMrEt0ntgdBUTghHGWZR
        WkxzkYbrL6YvGjomgcte5kqBYscPGNBBinnHd+9yJIbE3XvZGGl0AKRQOL95q1wmUjX+UAvCC9f
        4rcv1zjp5r5Vczay+H7GMq791zEhq/tIKQ1Ezl9UV9QM4FIKDbp7GqhGeANGU4h6hpsro5AU/0a
        OBNI4fhCf0ABE=
X-Google-Smtp-Source: APXvYqw1Ub/Z+O3jHcMEB46RIHlKwXB2iWX+yWYDGRmVFXK8kuxqatdFjZXNtTudLmVR+z0LGMEogfliBJ/w3zo57XbORQ==
X-Received: by 2002:a63:f202:: with SMTP id v2mr3139369pgh.420.1576290960550;
 Fri, 13 Dec 2019 18:36:00 -0800 (PST)
Date:   Fri, 13 Dec 2019 18:35:43 -0800
Message-Id: <20191214023543.24933-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH V2] efi: Allow disabling PCI busmastering on bridges during boot
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-efi@vger.kernel.org
Cc:     ard.biesheuvel@linaro.org, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add an option to disable the busmaster bit in the control register on
all PCI bridges before calling ExitBootServices() and passing control to
the runtime kernel. System firmware may configure the IOMMU to prevent
malicious PCI devices from being able to attack the OS via DMA. However,
since firmware can't guarantee that the OS is IOMMU-aware, it will tear
down IOMMU configuration when ExitBootServices() is called. This leaves
a window between where a hostile device could still cause damage before
Linux configures the IOMMU again.

If CONFIG_EFI_NO_PCI_BUSMASTER is enabled or the
"efi=disable_pci_busmaster" commandline argument is passed, the EFI stub
will clear the busmaster bit on all PCI bridges before
ExitBootServices() is called. This will prevent any malicious PCI
devices from being able to perform DMA until the kernel reenables
busmastering after configuring the IOMMU.

This option is disabled when in EFI mixed mode environments (ie, 64-bit
kernels with a 32-bit EFI implementation). The current thunking code is
unable to handle cases where 64-bit values are required, and is also
hard to integrate with code that should run on both ARM and x86.

This option will cause failures with some poorly behaved hardware and
should not be enabled without testing. The kernel commandline option
"efi=disable_pci_busmaster" or "efi=enable_pci_busmaster" may be used to
override the default.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
---

V2: Fix up support for ARM, add a helper to identify whether we're in
mixed mode and exit gracefully if so, modify the naming and command line
arguments to make it clearer that it's restricted to EFI and PCI.

 .../admin-guide/kernel-parameters.txt         |  4 +
 arch/arm64/include/asm/efi.h                  |  1 +
 arch/x86/boot/compressed/eboot.c              |  2 +
 arch/x86/include/asm/efi.h                    | 11 +++
 drivers/firmware/efi/Kconfig                  | 22 +++++
 drivers/firmware/efi/libstub/Makefile         |  2 +-
 .../firmware/efi/libstub/efi-stub-helper.c    | 17 ++++
 drivers/firmware/efi/libstub/efistub.h        |  1 +
 drivers/firmware/efi/libstub/pci.c            | 90 +++++++++++++++++++
 include/linux/efi.h                           | 31 +++++--
 10 files changed, 175 insertions(+), 6 deletions(-)
 create mode 100644 drivers/firmware/efi/libstub/pci.c

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ade4e6ec23e0..e4faa52c5abd 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1180,6 +1180,10 @@
 			claim. Specify efi=nosoftreserve to disable this
 			reservation and treat the memory by its base type
 			(i.e. EFI_CONVENTIONAL_MEMORY / "System RAM").
+			disable_busmaster: Disable the busmaster bit on all
+			PCI bridges while in the EFI boot stub
+			enable_busmaster: Leave the busmaster bit set on all
+			PCI bridges while in the EFI boot stub
 
 	efi_no_storage_paranoia [EFI; X86]
 			Using this parameter you can use more than 50% of
diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index b54d3a86c444..e14e9ad35b55 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -97,6 +97,7 @@ static inline unsigned long efi_get_max_initrd_addr(unsigned long dram_base,
 #define __efi_call_early(f, ...)	f(__VA_ARGS__)
 #define efi_call_runtime(f, ...)	sys_table_arg->runtime->f(__VA_ARGS__)
 #define efi_is_64bit()			(true)
+#define efi_is_mixed_mode()		(false)
 
 #define efi_table_attr(table, attr, instance)				\
 	((table##_t *)instance)->attr
diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 72b08fde6de6..0f1edd2c49fc 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -137,6 +137,8 @@ static void setup_efi_pci(struct boot_params *params)
 	struct setup_data *data;
 	int i;
 
+	efi_pci_disable_bridge_busmaster(sys_table);
+
 	status = efi_call_early(locate_handle,
 				EFI_LOCATE_BY_PROTOCOL,
 				&pci_proto, NULL, &size, pci_handle);
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index d028e9acdf1c..eeee0bb3caee 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -220,6 +220,17 @@ static inline bool efi_is_64bit(void)
 	return __efi_early()->is64;
 }
 
+static inline bool efi_is_mixed_mode(void)
+{
+	if (!IS_ENABLED(CONFIG_EFI_MIXED))
+		return false;
+
+	if (!IS_ENABLED(CONFIG_X86_64))
+		return false;
+
+	return !(__efi_early()->is64);
+}
+
 #define efi_table_attr(table, attr, instance)				\
 	(efi_is_64bit() ?						\
 		((table##_64_t *)(unsigned long)instance)->attr :	\
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index bcc378c19ebe..e8b432b2d94a 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -215,6 +215,28 @@ config EFI_RCI2_TABLE
 
 	  Say Y here for Dell EMC PowerEdge systems.
 
+config EFI_DISABLE_PCI_BUSMASTER
+       bool "Clear Busmaster bit on PCI bridges before ExitBootServices()"
+       help
+	  Disable the busmaster bit in the control register on all PCI bridges
+	  before calling ExitBootServices() and passing control to the runtime
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
+	  option "efi=disable_pci_busmaster" or "efi=enable_busmaster" may
+	  be used to override this option.
+
 endmenu
 
 config UEFI_CPER
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 33535252605a..f14b7636323a 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -39,7 +39,7 @@ OBJECT_FILES_NON_STANDARD	:= y
 KCOV_INSTRUMENT			:= n
 
 lib-y				:= efi-stub-helper.o gop.o secureboot.o tpm.o \
-				   random.o
+				   random.o pci.o
 
 # include the stub's generic dependencies from lib/ when building for ARM/arm64
 arm-deps-y := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c fdt_empty_tree.c fdt_sw.c
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index b1e220a124ea..852f1b8247ca 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -32,6 +32,8 @@ static unsigned long __chunk_size = EFI_READ_CHUNK_SIZE;
 static int __section(.data) __nokaslr;
 static int __section(.data) __quiet;
 static bool __section(.data) efi_nosoftreserve;
+static int __section(.data) __disable_pci_busmaster =
+	IS_ENABLED(CONFIG_EFI_DISABLE_PCI_BUSMASTER);
 
 static u16 efi_supported_rt_services_mask = EFI_RT_SUPPORTED_ALL;
 
@@ -54,6 +56,11 @@ bool __pure __efi_soft_reserve_enabled(void)
 	return !efi_nosoftreserve;
 }
 
+int __pure disable_pci_busmaster(void)
+{
+	return __disable_pci_busmaster;
+}
+
 #define EFI_MMAP_NR_SLACK_SLOTS	8
 
 struct file_info {
@@ -507,6 +514,16 @@ efi_status_t efi_parse_options(char const *cmdline)
 			efi_nosoftreserve = 1;
 		}
 
+		if (!strncmp(str, "disable_pci_busmaster", 21)) {
+			str += strlen("disable_pci_busmaster");
+			__disable_pci_busmaster = 1;
+		}
+
+		if (!strncmp(str, "enable_pci_busmaster", 20)) {
+			str += strlen("enable_pci_busmaster");
+			__disable_pci_busmaster = 0;
+		}
+
 		/* Group words together, delimited by "," */
 		while (*str && *str != ' ' && *str != ',')
 			str++;
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index e2948667fa66..b7e04ab71fc2 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -28,6 +28,7 @@
 extern int __pure nokaslr(void);
 extern int __pure is_quiet(void);
 extern int __pure novamap(void);
+extern int __pure disable_pci_busmaster(void);
 
 #define pr_efi(sys_table, msg)		do {				\
 	if (!is_quiet()) efi_printk(sys_table, "EFI stub: "msg);	\
diff --git a/drivers/firmware/efi/libstub/pci.c b/drivers/firmware/efi/libstub/pci.c
new file mode 100644
index 000000000000..a8472481a509
--- /dev/null
+++ b/drivers/firmware/efi/libstub/pci.c
@@ -0,0 +1,90 @@
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
+void efi_pci_disable_bridge_busmaster(efi_system_table_t *sys_table_arg)
+{
+	efi_status_t status;
+	void **pci_handle = NULL;
+	efi_guid_t pci_proto = EFI_PCI_IO_PROTOCOL_GUID;
+	unsigned long size = 0;
+	unsigned long nr_pci;
+	u16 class, command;
+	int i;
+
+	if (efi_is_mixed_mode())
+		return;
+
+	if (!disable_pci_busmaster())
+		return;
+
+	status = efi_call_early(locate_handle,
+				EFI_LOCATE_BY_PROTOCOL,
+				&pci_proto, NULL, &size, pci_handle);
+
+	if (status == EFI_BUFFER_TOO_SMALL) {
+		status = efi_call_early(allocate_pool,
+					EFI_LOADER_DATA,
+					size, (void **)&pci_handle);
+
+		if (status != EFI_SUCCESS) {
+			pr_efi_err(sys_table_arg,
+				   "Failed to allocate memory for 'pci_handle'\n");
+			return;
+		}
+
+		status = efi_call_early(locate_handle,
+					EFI_LOCATE_BY_PROTOCOL, &pci_proto,
+					NULL, &size, pci_handle);
+	}
+
+	if (status != EFI_SUCCESS)
+		goto free_handle;
+
+	nr_pci = size / sizeof(void *);
+	for (i = 0; i < nr_pci; i++) {
+		efi_pci_io_protocol_t *pci = NULL;
+		unsigned long handle = (unsigned long)pci_handle[i];
+
+		status = efi_call_early(handle_protocol, (efi_handle_t)handle,
+					&pci_proto, (void **)&pci);
+		if (status != EFI_SUCCESS || !pci)
+			continue;
+
+		status = efi_call_proto(efi_pci_io_protocol, pci.read, pci,
+					EfiPciIoWidthUint16, PCI_CLASS_DEVICE,
+					1, &class);
+
+		if (status != EFI_SUCCESS || class != PCI_CLASS_BRIDGE_PCI)
+			continue;
+
+		/* Disable busmastering */
+		status = efi_call_proto(efi_pci_io_protocol, pci.read, pci,
+					EfiPciIoWidthUint16, PCI_COMMAND, 1,
+					&command);
+		if (status != EFI_SUCCESS || !(command & PCI_COMMAND_MASTER))
+			continue;
+
+		command &= ~PCI_COMMAND_MASTER;
+		status = efi_call_proto(efi_pci_io_protocol, pci.write, pci,
+					EfiPciIoWidthUint16, PCI_COMMAND, 1,
+					&command);
+		if (status != EFI_SUCCESS)
+			pr_efi_err(sys_table_arg,
+				   "Failed to disable PCI busmastering\n");
+	}
+
+free_handle:
+	efi_call_early(free_pool, pci_handle);
+}
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 80b504958941..234afa333a6f 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -388,11 +388,30 @@ typedef struct {
 	u64 write;
 } efi_pci_io_protocol_access_64_t;
 
+typedef struct efi_pci_io_protocol efi_pci_io_protocol_t;
+
+typedef
+efi_status_t (*efi_pci_io_protocol_mem_t)(struct efi_pci_io_protocol *,
+					  EFI_PCI_IO_PROTOCOL_WIDTH,
+					  u8 bar_index, u64 offset,
+					  unsigned long count, void *buffer);
+
+typedef
+efi_status_t (*efi_pci_io_protocol_cfg_t)(struct efi_pci_io_protocol *,
+					  EFI_PCI_IO_PROTOCOL_WIDTH,
+					  u32 offset, unsigned long count,
+					  void *buffer);
+
 typedef struct {
-	void *read;
-	void *write;
+	efi_pci_io_protocol_mem_t read;
+	efi_pci_io_protocol_mem_t write;
 } efi_pci_io_protocol_access_t;
 
+typedef struct {
+	efi_pci_io_protocol_cfg_t read;
+	efi_pci_io_protocol_cfg_t write;
+} efi_pci_io_protocol_config_access_t;
+
 typedef struct {
 	u32 poll_mem;
 	u32 poll_io;
@@ -433,12 +452,12 @@ typedef struct {
 	u64 romimage;
 } efi_pci_io_protocol_64_t;
 
-typedef struct {
+struct efi_pci_io_protocol {
 	void *poll_mem;
 	void *poll_io;
 	efi_pci_io_protocol_access_t mem;
 	efi_pci_io_protocol_access_t io;
-	efi_pci_io_protocol_access_t pci;
+	efi_pci_io_protocol_config_access_t pci;
 	void *copy_mem;
 	void *map;
 	void *unmap;
@@ -451,7 +470,7 @@ typedef struct {
 	void *set_bar_attributes;
 	uint64_t romsize;
 	void *romimage;
-} efi_pci_io_protocol_t;
+};
 
 #define EFI_PCI_IO_ATTRIBUTE_ISA_MOTHERBOARD_IO 0x0001
 #define EFI_PCI_IO_ATTRIBUTE_ISA_IO 0x0002
@@ -1662,6 +1681,8 @@ efi_status_t efi_random_get_seed(efi_system_table_t *sys_table_arg);
 
 void efi_retrieve_tpm2_eventlog(efi_system_table_t *sys_table);
 
+void efi_pci_disable_bridge_busmaster(efi_system_table_t *sys_table);
+
 /*
  * Arch code can implement the following three template macros, avoiding
  * reptition for the void/non-void return cases of {__,}efi_call_virt():
-- 
2.24.1.735.g03f4e72817-goog

