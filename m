Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2BAC160574
	for <lists+linux-efi@lfdr.de>; Sun, 16 Feb 2020 19:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbgBPSYt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 16 Feb 2020 13:24:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:33286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727797AbgBPSX5 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 16 Feb 2020 13:23:57 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DAE6206D6;
        Sun, 16 Feb 2020 18:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581877436;
        bh=bvY7jkOH4eGGLIFXLY5eHChKYaTowEdHN1ApObhP+M4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VocnGw1e6dD8Q4xB9HaV8zimojU5yPjH0C6Xx5XWMaf6PVA5YhmiEpLytQSeRod05
         OjU5RMws0nqm9HZQdDkgg8S5cFvpv7Hm/d5yb1YILEyBE92a0hdqH+5yEEM+ywn0GQ
         nNCnkdRN85vDgn0/Zh6Jcmid2Fvi2VBWTRzF+EHw=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>, nivedita@alum.mit.edu,
        x86@kernel.org
Subject: [PATCH 06/18] efi: make memreserve table handling local to efi.c
Date:   Sun, 16 Feb 2020 19:23:22 +0100
Message-Id: <20200216182334.8121-7-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200216182334.8121-1-ardb@kernel.org>
References: <20200216182334.8121-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

There is no need for struct efi to carry the address of the memreserve
table and share it with the world. So move it out and make it
__initdata as well.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi.c | 12 ++++++------
 include/linux/efi.h        |  1 -
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 1fc4e174f11d..41bb2c44cea4 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -45,11 +45,11 @@ struct efi __read_mostly efi = {
 	.esrt			= EFI_INVALID_TABLE_ADDR,
 	.tpm_log		= EFI_INVALID_TABLE_ADDR,
 	.tpm_final_log		= EFI_INVALID_TABLE_ADDR,
-	.mem_reserve		= EFI_INVALID_TABLE_ADDR,
 };
 EXPORT_SYMBOL(efi);
 
 static unsigned long __ro_after_init rng_seed = EFI_INVALID_TABLE_ADDR;
+static unsigned long __initdata mem_reserve = EFI_INVALID_TABLE_ADDR;
 
 struct mm_struct efi_mm = {
 	.mm_rb			= RB_ROOT,
@@ -470,7 +470,7 @@ static __initdata efi_config_table_type_t common_tables[] = {
 	{LINUX_EFI_RANDOM_SEED_TABLE_GUID, "RNG", &rng_seed},
 	{LINUX_EFI_TPM_EVENT_LOG_GUID, "TPMEventLog", &efi.tpm_log},
 	{LINUX_EFI_TPM_FINAL_LOG_GUID, "TPMFinalLog", &efi.tpm_final_log},
-	{LINUX_EFI_MEMRESERVE_TABLE_GUID, "MEMRESERVE", &efi.mem_reserve},
+	{LINUX_EFI_MEMRESERVE_TABLE_GUID, "MEMRESERVE", &mem_reserve},
 #ifdef CONFIG_EFI_RCI2_TABLE
 	{DELLEMC_EFI_RCI2_TABLE_GUID, NULL, &rci2_table_phys},
 #endif
@@ -563,8 +563,8 @@ int __init efi_config_parse_tables(void *config_tables, int count, int sz,
 
 	efi_tpm_eventlog_init();
 
-	if (efi.mem_reserve != EFI_INVALID_TABLE_ADDR) {
-		unsigned long prsv = efi.mem_reserve;
+	if (mem_reserve != EFI_INVALID_TABLE_ADDR) {
+		unsigned long prsv = mem_reserve;
 
 		while (prsv) {
 			struct linux_efi_memreserve *rsv;
@@ -939,10 +939,10 @@ static struct linux_efi_memreserve *efi_memreserve_root __ro_after_init;
 
 static int __init efi_memreserve_map_root(void)
 {
-	if (efi.mem_reserve == EFI_INVALID_TABLE_ADDR)
+	if (mem_reserve == EFI_INVALID_TABLE_ADDR)
 		return -ENODEV;
 
-	efi_memreserve_root = memremap(efi.mem_reserve,
+	efi_memreserve_root = memremap(mem_reserve,
 				       sizeof(*efi_memreserve_root),
 				       MEMREMAP_WB);
 	if (WARN_ON_ONCE(!efi_memreserve_root))
diff --git a/include/linux/efi.h b/include/linux/efi.h
index b093fce1cf59..a5e210abe4ca 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -541,7 +541,6 @@ extern struct efi {
 	unsigned long esrt;		/* ESRT table */
 	unsigned long tpm_log;		/* TPM2 Event Log table */
 	unsigned long tpm_final_log;	/* TPM2 Final Events Log table */
-	unsigned long mem_reserve;	/* Linux EFI memreserve table */
 	efi_get_time_t *get_time;
 	efi_set_time_t *set_time;
 	efi_get_wakeup_time_t *get_wakeup_time;
-- 
2.17.1

