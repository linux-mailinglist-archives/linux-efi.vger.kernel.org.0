Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91AFF12F783
	for <lists+linux-efi@lfdr.de>; Fri,  3 Jan 2020 12:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgACLk6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Jan 2020 06:40:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:40996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727911AbgACLk6 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 3 Jan 2020 06:40:58 -0500
Received: from localhost.localdomain (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFFB12253D;
        Fri,  3 Jan 2020 11:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578051657;
        bh=9JvlvhrYK9Wi6Gf4HX7L9oP4Ov8eQJKYU945ho6O46s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rm2lVDV7hYQ9IlNzawwmUknp0H0x967nUlEoCK69j/1MXLn5h3AzPHfsdqs3bWz2Q
         DA4uBLpfRSKwBxpyt7ToCc91MzDmfG+EgUFzYiwgIM2ua0N7TTyoNTImOpuLk6kjTS
         LFUypxMhtNuGtr6yxPC/7RArXOr3/sUXy+R39MMs=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Matthew Garrett <mjg59@google.com>
Subject: [PATCH 20/20] efi/x86: avoid RWX mappings for all of DRAM
Date:   Fri,  3 Jan 2020 12:39:53 +0100
Message-Id: <20200103113953.9571-21-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200103113953.9571-1-ardb@kernel.org>
References: <20200103113953.9571-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The EFI code creates RWX mappings for all memory regions that are
occupied after the stub completes, and in the mixed mode case, it
even creates RWX mappings for all of the remaining DRAM as well.

Let's try to avoid this, by setting the NX bit for all memory
regions except the ones that are marked as EFI runtime services
code [which means text+rodata+data in practice, so we cannot mark
them read-only right away]

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/efi/efi_64.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 6ec58ff60b56..a974f8a17f73 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -365,10 +365,6 @@ int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages)
 	 * as trim_bios_range() will reserve the first page and isolate it away
 	 * from memory allocators anyway.
 	 */
-	pf = _PAGE_RW;
-	if (sev_active())
-		pf |= _PAGE_ENC;
-
 	if (kernel_map_pages_in_pgd(pgd, 0x0, 0x0, 1, pf)) {
 		pr_err("Failed to create 1:1 mapping for the first page!\n");
 		return 1;
@@ -410,6 +406,19 @@ static void __init __map_region(efi_memory_desc_t *md, u64 va)
 	unsigned long pfn;
 	pgd_t *pgd = efi_mm.pgd;
 
+	/*
+	 * EFI_RUNTIME_SERVICES_CODE regions typically cover PE/COFF
+	 * executable images in memory that consist of both R-X and
+	 * RW- sections, so we cannot apply read-only or non-exec
+	 * permissions just yet. However, modern EFI systems provide
+	 * a memory attributes table that describes those sections
+	 * with the appropriate restricted permissions, which are
+	 * applied in efi_runtime_update_mappings() below. All other
+	 * regions can be mapped non-executable at this point.
+	 */
+	if (md->type != EFI_RUNTIME_SERVICES_CODE)
+		flags |= _PAGE_NX;
+
 	if (!(md->attribute & EFI_MEMORY_WB))
 		flags |= _PAGE_PCD;
 
-- 
2.20.1

