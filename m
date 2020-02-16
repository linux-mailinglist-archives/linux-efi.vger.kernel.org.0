Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 233DD160556
	for <lists+linux-efi@lfdr.de>; Sun, 16 Feb 2020 19:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgBPSYA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 16 Feb 2020 13:24:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:33380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727891AbgBPSYA (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 16 Feb 2020 13:24:00 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A89CB227BF;
        Sun, 16 Feb 2020 18:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581877440;
        bh=euKJYXOia2rQ9pUwQt2bnN7886DrahmzBis1Tb15+pY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wC6t4Yjbw8Re489VTKrMSSHcLumHV4tFZbfljRUT/T5F5bx1zDZZUV+kSVWl3v2vY
         k0yu0Vrl0Oh5BH3sv/x0qRePNwd5xu619EiK6byRf8/V834vDhERcxZdyxFCJBMiWq
         sxRC/BLI6QtXiGsq2sYAfEEfXiNVXtyr4cBCTfsU=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>, nivedita@alum.mit.edu,
        x86@kernel.org
Subject: [PATCH 08/18] efi/ia64: use existing helpers to locate ESI table
Date:   Sun, 16 Feb 2020 19:23:24 +0100
Message-Id: <20200216182334.8121-9-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200216182334.8121-1-ardb@kernel.org>
References: <20200216182334.8121-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Instead of iterating over the EFI config table array manually,
declare it as an arch table so it gets picked up by the existing
config table handling code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/ia64/kernel/efi.c |  6 ++++++
 arch/ia64/kernel/esi.c | 21 ++++----------------
 2 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/arch/ia64/kernel/efi.c b/arch/ia64/kernel/efi.c
index 292fe354158d..74fad89ae209 100644
--- a/arch/ia64/kernel/efi.c
+++ b/arch/ia64/kernel/efi.c
@@ -45,13 +45,19 @@
 
 #define EFI_DEBUG	0
 
+#define ESI_TABLE_GUID					\
+    EFI_GUID(0x43EA58DC, 0xCF28, 0x4b06, 0xB3,		\
+	     0x91, 0xB7, 0x50, 0x59, 0x34, 0x2B, 0xD4)
+
 static unsigned long mps_phys = EFI_INVALID_TABLE_ADDR;
 static __initdata unsigned long palo_phys;
 
+unsigned long __initdata esi_phys = EFI_INVALID_TABLE_ADDR;
 unsigned long hcdp_phys = EFI_INVALID_TABLE_ADDR;
 unsigned long sal_systab_phys = EFI_INVALID_TABLE_ADDR;
 
 static __initdata efi_config_table_type_t arch_tables[] = {
+	{ESI_TABLE_GUID, "ESI", &esi_phys},
 	{HCDP_TABLE_GUID, "HCDP", &hcdp_phys},
 	{MPS_TABLE_GUID, "MPS", &mps_phys},
 	{PROCESSOR_ABSTRACTION_LAYER_OVERWRITE_GUID, "PALO", &palo_phys},
diff --git a/arch/ia64/kernel/esi.c b/arch/ia64/kernel/esi.c
index cb514126ef7f..4df57c93e0a8 100644
--- a/arch/ia64/kernel/esi.c
+++ b/arch/ia64/kernel/esi.c
@@ -19,10 +19,6 @@ MODULE_LICENSE("GPL");
 
 #define MODULE_NAME	"esi"
 
-#define ESI_TABLE_GUID					\
-    EFI_GUID(0x43EA58DC, 0xCF28, 0x4b06, 0xB3,		\
-	     0x91, 0xB7, 0x50, 0x59, 0x34, 0x2B, 0xD4)
-
 enum esi_systab_entry_type {
 	ESI_DESC_ENTRY_POINT = 0
 };
@@ -48,27 +44,18 @@ struct pdesc {
 
 static struct ia64_sal_systab *esi_systab;
 
+extern unsigned long esi_phys;
+
 static int __init esi_init (void)
 {
-	efi_config_table_t *config_tables;
 	struct ia64_sal_systab *systab;
-	unsigned long esi = 0;
 	char *p;
 	int i;
 
-	config_tables = __va(efi.systab->tables);
-
-	for (i = 0; i < (int) efi.systab->nr_tables; ++i) {
-		if (efi_guidcmp(config_tables[i].guid, ESI_TABLE_GUID) == 0) {
-			esi = config_tables[i].table;
-			break;
-		}
-	}
-
-	if (!esi)
+	if (esi_phys == EFI_INVALID_TABLE_ADDR)
 		return -ENODEV;
 
-	systab = __va(esi);
+	systab = __va(esi_phys);
 
 	if (strncmp(systab->signature, "ESIT", 4) != 0) {
 		printk(KERN_ERR "bad signature in ESI system table!");
-- 
2.17.1

