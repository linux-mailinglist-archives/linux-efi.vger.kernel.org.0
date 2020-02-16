Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 767FB160550
	for <lists+linux-efi@lfdr.de>; Sun, 16 Feb 2020 19:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgBPSXv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 16 Feb 2020 13:23:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:33036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbgBPSXu (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 16 Feb 2020 13:23:50 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8754824125;
        Sun, 16 Feb 2020 18:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581877429;
        bh=srgV34DC2k2w8oyiazTKv2a8VEvgMopbnQ7ijtTNbq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g82ivEIOh9SW8JZ/kamQlmJnuVmGy3beFTHzQ/ySeP2koY4anpljn4NHBdBgdUdKo
         t5dInKkhHI2tAx1pMY7T0IwI8/UlFSBzzxUiWqfVWstZZdDVGFcm0Co+XwbGbcq8dU
         vkDlQSAhsx+NIkRrV7MeTE+Mb18vmquNM/o5KpTU=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>, nivedita@alum.mit.edu,
        x86@kernel.org
Subject: [PATCH 02/18] efi/ia64: move HCDP and MPS table handling into IA64 arch code
Date:   Sun, 16 Feb 2020 19:23:18 +0100
Message-Id: <20200216182334.8121-3-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200216182334.8121-1-ardb@kernel.org>
References: <20200216182334.8121-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The HCDP and MPS tables are Itanium specific EFI config tables, so
move their handling to ia64 arch code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/ia64/kernel/efi.c      | 13 +++++++++++++
 arch/x86/platform/efi/efi.c |  2 --
 drivers/firmware/efi/efi.c  | 14 ++++++--------
 drivers/firmware/pcdp.c     |  8 +++++---
 include/linux/efi.h         |  2 --
 5 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/arch/ia64/kernel/efi.c b/arch/ia64/kernel/efi.c
index 0a34dcc435c6..312308967a9d 100644
--- a/arch/ia64/kernel/efi.c
+++ b/arch/ia64/kernel/efi.c
@@ -45,11 +45,15 @@
 
 #define EFI_DEBUG	0
 
+static unsigned long mps_phys = EFI_INVALID_TABLE_ADDR;
 static __initdata unsigned long palo_phys;
 
+unsigned long hcdp_phys = EFI_INVALID_TABLE_ADDR;
 unsigned long sal_systab_phys = EFI_INVALID_TABLE_ADDR;
 
 static __initdata efi_config_table_type_t arch_tables[] = {
+	{HCDP_TABLE_GUID, "HCDP", &hcdp_phys},
+	{MPS_TABLE_GUID, "MPS", &mps_phys},
 	{PROCESSOR_ABSTRACTION_LAYER_OVERWRITE_GUID, "PALO", &palo_phys},
 	{SAL_SYSTEM_TABLE_GUID, "SALsystab", &sal_systab_phys},
 	{NULL_GUID, NULL, 0},
@@ -1351,3 +1355,12 @@ vmcore_find_descriptor_size (unsigned long address)
 	return ret;
 }
 #endif
+
+char *efi_systab_show_arch(char *str)
+{
+	if (mps_phys != EFI_INVALID_TABLE_ADDR)
+		str += sprintf(str, "MPS=0x%lx\n", mps_phys);
+	if (hcdp_phys != EFI_INVALID_TABLE_ADDR)
+		str += sprintf(str, "HCDP=0x%lx\n", hcdp_phys);
+	return str;
+}
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 383d1003c3dc..bb45fd9f221c 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -65,12 +65,10 @@ static efi_config_table_type_t arch_tables[] __initdata = {
 };
 
 static const unsigned long * const efi_tables[] = {
-	&efi.mps,
 	&efi.acpi,
 	&efi.acpi20,
 	&efi.smbios,
 	&efi.smbios3,
-	&efi.hcdp,
 	&efi.uga,
 #ifdef CONFIG_X86_UV
 	&uv_systab_phys,
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 5464e3849ee4..8129a52f8ef5 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -35,12 +35,10 @@
 #include <asm/early_ioremap.h>
 
 struct efi __read_mostly efi = {
-	.mps			= EFI_INVALID_TABLE_ADDR,
 	.acpi			= EFI_INVALID_TABLE_ADDR,
 	.acpi20			= EFI_INVALID_TABLE_ADDR,
 	.smbios			= EFI_INVALID_TABLE_ADDR,
 	.smbios3		= EFI_INVALID_TABLE_ADDR,
-	.hcdp			= EFI_INVALID_TABLE_ADDR,
 	.uga			= EFI_INVALID_TABLE_ADDR,
 	.fw_vendor		= EFI_INVALID_TABLE_ADDR,
 	.runtime		= EFI_INVALID_TABLE_ADDR,
@@ -121,8 +119,6 @@ static ssize_t systab_show(struct kobject *kobj,
 	if (!kobj || !buf)
 		return -EINVAL;
 
-	if (efi.mps != EFI_INVALID_TABLE_ADDR)
-		str += sprintf(str, "MPS=0x%lx\n", efi.mps);
 	if (efi.acpi20 != EFI_INVALID_TABLE_ADDR)
 		str += sprintf(str, "ACPI20=0x%lx\n", efi.acpi20);
 	if (efi.acpi != EFI_INVALID_TABLE_ADDR)
@@ -136,11 +132,15 @@ static ssize_t systab_show(struct kobject *kobj,
 		str += sprintf(str, "SMBIOS3=0x%lx\n", efi.smbios3);
 	if (efi.smbios != EFI_INVALID_TABLE_ADDR)
 		str += sprintf(str, "SMBIOS=0x%lx\n", efi.smbios);
-	if (efi.hcdp != EFI_INVALID_TABLE_ADDR)
-		str += sprintf(str, "HCDP=0x%lx\n", efi.hcdp);
 	if (efi.uga != EFI_INVALID_TABLE_ADDR)
 		str += sprintf(str, "UGA=0x%lx\n", efi.uga);
 
+	if (IS_ENABLED(CONFIG_IA64)) {
+		extern char *efi_systab_show_arch(char *str);
+
+		str = efi_systab_show_arch(str);
+	}
+
 	return str - buf;
 }
 
@@ -467,8 +467,6 @@ void __init efi_mem_reserve(phys_addr_t addr, u64 size)
 static __initdata efi_config_table_type_t common_tables[] = {
 	{ACPI_20_TABLE_GUID, "ACPI 2.0", &efi.acpi20},
 	{ACPI_TABLE_GUID, "ACPI", &efi.acpi},
-	{HCDP_TABLE_GUID, "HCDP", &efi.hcdp},
-	{MPS_TABLE_GUID, "MPS", &efi.mps},
 	{SMBIOS_TABLE_GUID, "SMBIOS", &efi.smbios},
 	{SMBIOS3_TABLE_GUID, "SMBIOS 3.0", &efi.smbios3},
 	{UGA_IO_PROTOCOL_GUID, "UGA", &efi.uga},
diff --git a/drivers/firmware/pcdp.c b/drivers/firmware/pcdp.c
index 4adeb7a2bdf5..715a45442d1c 100644
--- a/drivers/firmware/pcdp.c
+++ b/drivers/firmware/pcdp.c
@@ -80,6 +80,8 @@ setup_vga_console(struct pcdp_device *dev)
 #endif
 }
 
+extern unsigned long hcdp_phys;
+
 int __init
 efi_setup_pcdp_console(char *cmdline)
 {
@@ -89,11 +91,11 @@ efi_setup_pcdp_console(char *cmdline)
 	int i, serial = 0;
 	int rc = -ENODEV;
 
-	if (efi.hcdp == EFI_INVALID_TABLE_ADDR)
+	if (hcdp_phys == EFI_INVALID_TABLE_ADDR)
 		return -ENODEV;
 
-	pcdp = early_memremap(efi.hcdp, 4096);
-	printk(KERN_INFO "PCDP: v%d at 0x%lx\n", pcdp->rev, efi.hcdp);
+	pcdp = early_memremap(hcdp_phys, 4096);
+	printk(KERN_INFO "PCDP: v%d at 0x%lx\n", pcdp->rev, hcdp_phys);
 
 	if (strstr(cmdline, "console=hcdp")) {
 		if (pcdp->rev < 3)
diff --git a/include/linux/efi.h b/include/linux/efi.h
index c517d3b7986b..45443932104f 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -531,12 +531,10 @@ typedef struct {
 extern struct efi {
 	efi_system_table_t *systab;	/* EFI system table */
 	unsigned int runtime_version;	/* Runtime services version */
-	unsigned long mps;		/* MPS table */
 	unsigned long acpi;		/* ACPI table  (IA64 ext 0.71) */
 	unsigned long acpi20;		/* ACPI table  (ACPI 2.0) */
 	unsigned long smbios;		/* SMBIOS table (32 bit entry point) */
 	unsigned long smbios3;		/* SMBIOS table (64 bit entry point) */
-	unsigned long hcdp;		/* HCDP table */
 	unsigned long uga;		/* UGA table */
 	unsigned long fw_vendor;	/* fw_vendor */
 	unsigned long runtime;		/* runtime table */
-- 
2.17.1

