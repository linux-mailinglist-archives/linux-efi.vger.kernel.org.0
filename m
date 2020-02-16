Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B786316056B
	for <lists+linux-efi@lfdr.de>; Sun, 16 Feb 2020 19:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgBPSYk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 16 Feb 2020 13:24:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:33472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727974AbgBPSYF (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 16 Feb 2020 13:24:05 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAE3624125;
        Sun, 16 Feb 2020 18:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581877445;
        bh=535G2Z6StN4Ag1aO0gRi6xti0zt7h38+r39I0O3lAk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sFiyKrgOP9c19cScnbZQghLN4QA0LCqNwm75+aGlG0FUblmVzZv8FqPCDO2ubjczS
         Ed+qzRTyxJ5mXoRvja33ngrr8OrRohFwRgACnrScf/qSmZet864xPbdbqYn92FPQa1
         OnwbKMFZ8bHrSiFCDSNdODl8UvwC3SpRWaifqMwU=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>, nivedita@alum.mit.edu,
        x86@kernel.org
Subject: [PATCH 11/18] efi: make efi_config_init() x86 only
Date:   Sun, 16 Feb 2020 19:23:27 +0100
Message-Id: <20200216182334.8121-12-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200216182334.8121-1-ardb@kernel.org>
References: <20200216182334.8121-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The efi_config_init() routine is no longer shared with ia64 so let's
move it into the x86 arch code before making further x86 specific
changes to it.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/efi/efi.c | 30 +++++++++++++++++++
 drivers/firmware/efi/efi.c  | 31 --------------------
 include/linux/efi.h         |  1 -
 3 files changed, 30 insertions(+), 32 deletions(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 777373423a67..26d905e6b579 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -434,6 +434,36 @@ static int __init efi_systab_init(u64 phys)
 	return 0;
 }
 
+static int __init efi_config_init(efi_config_table_type_t *arch_tables)
+{
+	void *config_tables;
+	int sz, ret;
+
+	if (efi.systab->nr_tables == 0)
+		return 0;
+
+	if (efi_enabled(EFI_64BIT))
+		sz = sizeof(efi_config_table_64_t);
+	else
+		sz = sizeof(efi_config_table_32_t);
+
+	/*
+	 * Let's see what config tables the firmware passed to us.
+	 */
+	config_tables = early_memremap(efi.systab->tables,
+				       efi.systab->nr_tables * sz);
+	if (config_tables == NULL) {
+		pr_err("Could not map Configuration table!\n");
+		return -ENOMEM;
+	}
+
+	ret = efi_config_parse_tables(config_tables, efi.systab->nr_tables, sz,
+				      arch_tables);
+
+	early_memunmap(config_tables, efi.systab->nr_tables * sz);
+	return ret;
+}
+
 void __init efi_init(void)
 {
 	if (IS_ENABLED(CONFIG_X86_32) &&
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 80fe0044f2e2..2bfd6c0806ce 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -601,37 +601,6 @@ int __init efi_config_parse_tables(void *config_tables, int count, int sz,
 	return 0;
 }
 
-int __init efi_config_init(efi_config_table_type_t *arch_tables)
-{
-	void *config_tables;
-	int sz, ret;
-
-	if (efi.systab->nr_tables == 0)
-		return 0;
-
-	if (efi_enabled(EFI_64BIT))
-		sz = sizeof(efi_config_table_64_t);
-	else
-		sz = sizeof(efi_config_table_32_t);
-
-	/*
-	 * Let's see what config tables the firmware passed to us.
-	 */
-	config_tables = early_memremap(efi.systab->tables,
-				       efi.systab->nr_tables * sz);
-	if (config_tables == NULL) {
-		pr_err("Could not map Configuration table!\n");
-		return -ENOMEM;
-	}
-
-	ret = efi_config_parse_tables(config_tables, efi.systab->nr_tables, sz,
-				      arch_tables);
-
-	early_memunmap(config_tables, efi.systab->nr_tables * sz);
-	return ret;
-}
-
-
 int __init efi_systab_check_header(const efi_table_hdr_t *systab_hdr,
 				   int min_major_version)
 {
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 287510e84dfb..d61c25fd5824 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -608,7 +608,6 @@ extern int __init efi_memmap_split_count(efi_memory_desc_t *md,
 extern void __init efi_memmap_insert(struct efi_memory_map *old_memmap,
 				     void *buf, struct efi_mem_range *mem);
 
-extern int efi_config_init(efi_config_table_type_t *arch_tables);
 #ifdef CONFIG_EFI_ESRT
 extern void __init efi_esrt_init(void);
 #else
-- 
2.17.1

