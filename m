Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFD1610FD5F
	for <lists+linux-efi@lfdr.de>; Tue,  3 Dec 2019 13:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfLCMJo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Dec 2019 07:09:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:43824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfLCMJo (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 3 Dec 2019 07:09:44 -0500
Received: from e123331-lin.cambridge.arm.com (fw-tnat-cam5.arm.com [217.140.106.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B276C2073C;
        Tue,  3 Dec 2019 12:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575374983;
        bh=copjafRuSpR3VqMDvYW+aYmE1dOaRIgJtRncgMnwbKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P1OzBsD81YMr4+KqvtFjTVgVKLjymWBk3279dOtTKen0vYxVr07texzrl98g7qPd8
         lR4Qx6t3KYVaBl9BCnDyfu+2Z62bOPIMgumW7aio1ZUiQfFIll41R8g+8Bs7Enx8Ag
         yD/sK12Jg2/Ve85H3mZVY0rFde97OmLRL4qixZOM=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        james.morse@arm.com, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 2/2] efi: move handling of properties table to x86 specific code
Date:   Tue,  3 Dec 2019 12:09:17 +0000
Message-Id: <20191203120917.25981-3-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203120917.25981-1-ardb@kernel.org>
References: <20191203120917.25981-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The EFI properties table defines only a single property called
EFI_PROPERTIES_RUNTIME_MEMORY_PROTECTION_NON_EXECUTABLE_PE_DATA which
was deprecated almost immediately after it was defined, given that
splitting EFI runtime code regions into code and data segments is not
generally possible because the OS may apply a virtual mapping that
corrupts relative references between those segments. Instead, a new
memory attributes table has been defined that supersedes this feature.

Some x86 implementations of this property are known to exist in the field,
and the x86 EFI support code actually takes this property into account if
no memory attributes table is provided, but on other architectures, the
property is ignored entirely. So let's move the code that supports this
feature into the arch/x86 tree.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/efi/efi.c | 22 +++++++++++++++++++-
 drivers/firmware/efi/efi.c  | 19 -----------------
 include/linux/efi.h         |  1 -
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 38d44f36d5ed..dda52770d78a 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -57,10 +57,13 @@
 static struct efi efi_phys __initdata;
 static efi_system_table_t efi_systab __initdata;
 
+static unsigned long properties_table = EFI_INVALID_TABLE_ADDR;
+
 static efi_config_table_type_t arch_tables[] __initdata = {
 #ifdef CONFIG_X86_UV
 	{UV_SYSTEM_TABLE_GUID, "UVsystab", &uv_systab_phys},
 #endif
+	{EFI_PROPERTIES_TABLE_GUID, "PROP", &properties_table},
 	{NULL_GUID, NULL, NULL},
 };
 
@@ -80,7 +83,7 @@ static const unsigned long * const efi_tables[] = {
 	&efi.runtime,
 	&efi.config_table,
 	&efi.esrt,
-	&efi.properties_table,
+	&properties_table,
 	&efi.mem_attr_table,
 #ifdef CONFIG_EFI_RCI2_TABLE
 	&rci2_table_phys,
@@ -585,6 +588,23 @@ void __init efi_init(void)
 	if (efi_config_init(arch_tables))
 		return;
 
+	/* Parse the EFI Properties table if it exists */
+	if (properties_table != EFI_INVALID_TABLE_ADDR) {
+		efi_properties_table_t *tbl;
+
+		tbl = early_memremap(properties_table, sizeof(*tbl));
+		if (tbl == NULL) {
+			pr_err("Could not map Properties table!\n");
+			return -ENOMEM;
+		}
+
+		if (tbl->memory_protection_attribute &
+		    EFI_PROPERTIES_RUNTIME_MEMORY_PROTECTION_NON_EXECUTABLE_PE_DATA)
+			set_bit(EFI_NX_PE_DATA, &efi.flags);
+
+		early_memunmap(tbl, sizeof(*tbl));
+	}
+
 	/*
 	 * Note: We currently don't support runtime services on an EFI
 	 * that doesn't match the kernel 32/64-bit mode.
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index d101f072c8f8..ff35c5533581 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -47,7 +47,6 @@ struct efi __read_mostly efi = {
 	.runtime		= EFI_INVALID_TABLE_ADDR,
 	.config_table		= EFI_INVALID_TABLE_ADDR,
 	.esrt			= EFI_INVALID_TABLE_ADDR,
-	.properties_table	= EFI_INVALID_TABLE_ADDR,
 	.mem_attr_table		= EFI_INVALID_TABLE_ADDR,
 	.rng_seed		= EFI_INVALID_TABLE_ADDR,
 	.tpm_log		= EFI_INVALID_TABLE_ADDR,
@@ -476,7 +475,6 @@ static __initdata efi_config_table_type_t common_tables[] = {
 	{SMBIOS3_TABLE_GUID, "SMBIOS 3.0", &efi.smbios3},
 	{UGA_IO_PROTOCOL_GUID, "UGA", &efi.uga},
 	{EFI_SYSTEM_RESOURCE_TABLE_GUID, "ESRT", &efi.esrt},
-	{EFI_PROPERTIES_TABLE_GUID, "PROP", &efi.properties_table},
 	{EFI_MEMORY_ATTRIBUTES_TABLE_GUID, "MEMATTR", &efi.mem_attr_table},
 	{LINUX_EFI_RANDOM_SEED_TABLE_GUID, "RNG", &efi.rng_seed},
 	{LINUX_EFI_TPM_EVENT_LOG_GUID, "TPMEventLog", &efi.tpm_log},
@@ -575,23 +573,6 @@ int __init efi_config_parse_tables(void *config_tables, int count, int sz,
 
 	efi_tpm_eventlog_init();
 
-	/* Parse the EFI Properties table if it exists */
-	if (efi.properties_table != EFI_INVALID_TABLE_ADDR) {
-		efi_properties_table_t *tbl;
-
-		tbl = early_memremap(efi.properties_table, sizeof(*tbl));
-		if (tbl == NULL) {
-			pr_err("Could not map Properties table!\n");
-			return -ENOMEM;
-		}
-
-		if (tbl->memory_protection_attribute &
-		    EFI_PROPERTIES_RUNTIME_MEMORY_PROTECTION_NON_EXECUTABLE_PE_DATA)
-			set_bit(EFI_NX_PE_DATA, &efi.flags);
-
-		early_memunmap(tbl, sizeof(*tbl));
-	}
-
 	if (efi.mem_reserve != EFI_INVALID_TABLE_ADDR) {
 		unsigned long prsv = efi.mem_reserve;
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 99dfea595c8c..a6a7698a6ad1 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -995,7 +995,6 @@ extern struct efi {
 	unsigned long runtime;		/* runtime table */
 	unsigned long config_table;	/* config tables */
 	unsigned long esrt;		/* ESRT table */
-	unsigned long properties_table;	/* properties table */
 	unsigned long mem_attr_table;	/* memory attributes table */
 	unsigned long rng_seed;		/* UEFI firmware random seed */
 	unsigned long tpm_log;		/* TPM2 Event Log table */
-- 
2.17.1

