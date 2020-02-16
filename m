Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBA6D160553
	for <lists+linux-efi@lfdr.de>; Sun, 16 Feb 2020 19:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgBPSX5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 16 Feb 2020 13:23:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:33080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727691AbgBPSXx (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 16 Feb 2020 13:23:53 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E423222522;
        Sun, 16 Feb 2020 18:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581877433;
        bh=5b5M140echkw/dYLSqSctOwCKM+tl990EFoGSiaFw2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HL5m5V5v7X31CbKPqK9uKYszH3bGqayPB7bHXAdrLRBZiOq8DGY4Jhv29cBpdNayF
         InnfJT+snnuYCP5ROfE/aj+0yO4XsIpvG2m/ZQY83laqD2ZGEmSln35erh20PYer8L
         UlsdVjOHsQp1U8XUgs0oPSgqJfJUbhrWuCuSQmY8=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>, nivedita@alum.mit.edu,
        x86@kernel.org
Subject: [PATCH 04/18] efi: make rng_seed table handling local to efi.c
Date:   Sun, 16 Feb 2020 19:23:20 +0100
Message-Id: <20200216182334.8121-5-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200216182334.8121-1-ardb@kernel.org>
References: <20200216182334.8121-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Move the rng_seed table address from struct efi into a static global
variable in efi.c, which is the only place we ever refer to it anyway.
This reduces the footprint of struct efi, which is a r/w data structure
that is shared with the world.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi.c | 21 ++++++++++----------
 include/linux/efi.h        |  1 -
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 68527fbbe01c..bbb6246d08be 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -44,13 +44,14 @@ struct efi __read_mostly efi = {
 	.config_table		= EFI_INVALID_TABLE_ADDR,
 	.esrt			= EFI_INVALID_TABLE_ADDR,
 	.mem_attr_table		= EFI_INVALID_TABLE_ADDR,
-	.rng_seed		= EFI_INVALID_TABLE_ADDR,
 	.tpm_log		= EFI_INVALID_TABLE_ADDR,
 	.tpm_final_log		= EFI_INVALID_TABLE_ADDR,
 	.mem_reserve		= EFI_INVALID_TABLE_ADDR,
 };
 EXPORT_SYMBOL(efi);
 
+static unsigned long __ro_after_init rng_seed = EFI_INVALID_TABLE_ADDR;
+
 struct mm_struct efi_mm = {
 	.mm_rb			= RB_ROOT,
 	.mm_users		= ATOMIC_INIT(2),
@@ -467,7 +468,7 @@ static __initdata efi_config_table_type_t common_tables[] = {
 	{SMBIOS3_TABLE_GUID, "SMBIOS 3.0", &efi.smbios3},
 	{EFI_SYSTEM_RESOURCE_TABLE_GUID, "ESRT", &efi.esrt},
 	{EFI_MEMORY_ATTRIBUTES_TABLE_GUID, "MEMATTR", &efi.mem_attr_table},
-	{LINUX_EFI_RANDOM_SEED_TABLE_GUID, "RNG", &efi.rng_seed},
+	{LINUX_EFI_RANDOM_SEED_TABLE_GUID, "RNG", &rng_seed},
 	{LINUX_EFI_TPM_EVENT_LOG_GUID, "TPMEventLog", &efi.tpm_log},
 	{LINUX_EFI_TPM_FINAL_LOG_GUID, "TPMFinalLog", &efi.tpm_final_log},
 	{LINUX_EFI_MEMRESERVE_TABLE_GUID, "MEMRESERVE", &efi.mem_reserve},
@@ -535,11 +536,11 @@ int __init efi_config_parse_tables(void *config_tables, int count, int sz,
 	pr_cont("\n");
 	set_bit(EFI_CONFIG_TABLES, &efi.flags);
 
-	if (efi.rng_seed != EFI_INVALID_TABLE_ADDR) {
+	if (rng_seed != EFI_INVALID_TABLE_ADDR) {
 		struct linux_efi_random_seed *seed;
 		u32 size = 0;
 
-		seed = early_memremap(efi.rng_seed, sizeof(*seed));
+		seed = early_memremap(rng_seed, sizeof(*seed));
 		if (seed != NULL) {
 			size = seed->size;
 			early_memunmap(seed, sizeof(*seed));
@@ -547,8 +548,7 @@ int __init efi_config_parse_tables(void *config_tables, int count, int sz,
 			pr_err("Could not map UEFI random seed!\n");
 		}
 		if (size > 0) {
-			seed = early_memremap(efi.rng_seed,
-					      sizeof(*seed) + size);
+			seed = early_memremap(rng_seed, sizeof(*seed) + size);
 			if (seed != NULL) {
 				pr_notice("seeding entropy pool\n");
 				add_bootloader_randomness(seed->bits, seed->size);
@@ -1048,7 +1048,7 @@ static int update_efi_random_seed(struct notifier_block *nb,
 	if (!kexec_in_progress)
 		return NOTIFY_DONE;
 
-	seed = memremap(efi.rng_seed, sizeof(*seed), MEMREMAP_WB);
+	seed = memremap(rng_seed, sizeof(*seed), MEMREMAP_WB);
 	if (seed != NULL) {
 		size = min(seed->size, EFI_RANDOM_SEED_SIZE);
 		memunmap(seed);
@@ -1056,8 +1056,7 @@ static int update_efi_random_seed(struct notifier_block *nb,
 		pr_err("Could not map UEFI random seed!\n");
 	}
 	if (size > 0) {
-		seed = memremap(efi.rng_seed, sizeof(*seed) + size,
-				MEMREMAP_WB);
+		seed = memremap(rng_seed, sizeof(*seed) + size, MEMREMAP_WB);
 		if (seed != NULL) {
 			seed->size = size;
 			get_random_bytes(seed->bits, seed->size);
@@ -1073,9 +1072,9 @@ static struct notifier_block efi_random_seed_nb = {
 	.notifier_call = update_efi_random_seed,
 };
 
-static int register_update_efi_random_seed(void)
+static int __init register_update_efi_random_seed(void)
 {
-	if (efi.rng_seed == EFI_INVALID_TABLE_ADDR)
+	if (rng_seed == EFI_INVALID_TABLE_ADDR)
 		return 0;
 	return register_reboot_notifier(&efi_random_seed_nb);
 }
diff --git a/include/linux/efi.h b/include/linux/efi.h
index e091f2aff61d..36380542e054 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -540,7 +540,6 @@ extern struct efi {
 	unsigned long config_table;	/* config tables */
 	unsigned long esrt;		/* ESRT table */
 	unsigned long mem_attr_table;	/* memory attributes table */
-	unsigned long rng_seed;		/* UEFI firmware random seed */
 	unsigned long tpm_log;		/* TPM2 Event Log table */
 	unsigned long tpm_final_log;	/* TPM2 Final Events Log table */
 	unsigned long mem_reserve;	/* Linux EFI memreserve table */
-- 
2.17.1

