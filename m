Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA929277636
	for <lists+linux-efi@lfdr.de>; Thu, 24 Sep 2020 18:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgIXQFx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Sep 2020 12:05:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728485AbgIXQFx (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 24 Sep 2020 12:05:53 -0400
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CC392311E;
        Thu, 24 Sep 2020 16:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600963552;
        bh=UXUkGst6cOaWET9ftf5U8ucbqcEERbnEI0h8unjDu30=;
        h=From:To:Cc:Subject:Date:From;
        b=TS/BkY6JjbY2qlU2+m0daFuSoO1dPmdSCYmELHQ0RAJy/qeuyTgWn0I2IjtCQBzKJ
         /rUxIM0Ocij8MrQ+YYb+SUCnsjhJzla3E6qpBpFnoNjomFFvYC1JKMS0+3p5BSe6hO
         LNg9ppC1c9HHGCngW9lEtY30kSu1AgCsAuduv6k0=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH] efi: mokvar-table: fix some issues in new code
Date:   Thu, 24 Sep 2020 18:05:46 +0200
Message-Id: <20200924160546.8967-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Fix a couple of issues in the new mokvar-table handling code, as
pointed out by Arvind and Boris:
- don't bother checking the end of the physical region against the start
  address of the mokvar table,
- ensure that we enter the loop with err = -EINVAL,
- replace size_t with unsigned long to appease pedantic type equality
  checks.

Cc: Lenny Szubowicz <lszubowi@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/mokvar-table.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/firmware/efi/mokvar-table.c b/drivers/firmware/efi/mokvar-table.c
index b1cd49893d4d..72a9e1736fef 100644
--- a/drivers/firmware/efi/mokvar-table.c
+++ b/drivers/firmware/efi/mokvar-table.c
@@ -98,15 +98,14 @@ static struct kobject *mokvar_kobj;
 void __init efi_mokvar_table_init(void)
 {
 	efi_memory_desc_t md;
-	u64 end_pa;
 	void *va = NULL;
-	size_t cur_offset = 0;
-	size_t offset_limit;
-	size_t map_size = 0;
-	size_t map_size_needed = 0;
-	size_t size;
+	unsigned long cur_offset = 0;
+	unsigned long offset_limit;
+	unsigned long map_size = 0;
+	unsigned long map_size_needed = 0;
+	unsigned long size;
 	struct efi_mokvar_table_entry *mokvar_entry;
-	int err = -EINVAL;
+	int err;
 
 	if (!efi_enabled(EFI_MEMMAP))
 		return;
@@ -122,18 +121,16 @@ void __init efi_mokvar_table_init(void)
 		pr_warn("EFI MOKvar config table is not within the EFI memory map\n");
 		return;
 	}
-	end_pa = efi_mem_desc_end(&md);
-	if (efi.mokvar_table >= end_pa) {
-		pr_err("EFI memory descriptor containing MOKvar config table is invalid\n");
-		return;
-	}
-	offset_limit = end_pa - efi.mokvar_table;
+
+	offset_limit = efi_mem_desc_end(&md) - efi.mokvar_table;
+
 	/*
 	 * Validate the MOK config table. Since there is no table header
 	 * from which we could get the total size of the MOK config table,
 	 * we compute the total size as we validate each variably sized
 	 * entry, remapping as necessary.
 	 */
+	err = -EINVAL;
 	while (cur_offset + sizeof(*mokvar_entry) <= offset_limit) {
 		mokvar_entry = va + cur_offset;
 		map_size_needed = cur_offset + sizeof(*mokvar_entry);
@@ -150,7 +147,7 @@ void __init efi_mokvar_table_init(void)
 				       offset_limit);
 			va = early_memremap(efi.mokvar_table, map_size);
 			if (!va) {
-				pr_err("Failed to map EFI MOKvar config table pa=0x%lx, size=%zu.\n",
+				pr_err("Failed to map EFI MOKvar config table pa=0x%lx, size=%lu.\n",
 				       efi.mokvar_table, map_size);
 				return;
 			}
-- 
2.17.1

