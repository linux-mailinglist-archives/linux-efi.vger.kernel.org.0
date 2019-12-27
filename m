Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90A8612B5DD
	for <lists+linux-efi@lfdr.de>; Fri, 27 Dec 2019 17:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfL0QeU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Dec 2019 11:34:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:46606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbfL0QeU (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 27 Dec 2019 11:34:20 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49BDC208C4;
        Fri, 27 Dec 2019 16:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577464460;
        bh=KMKz3JRO3m4xT+40cZnaELN0AXYg2a2e2zFE8E4Dqsc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JVVDe5ybf49LzEYakTG3JZfugZcy/LkJZ9WDWMEZktUKLhiLEmIInrKaOauqCXbsk
         wxIueHWqQylpR+/VyZx7alD+k7/Dbv8I3MH3zMOwve8O6+7mpNcQdbBpYSzb50T3Cn
         V5TagQCT0upQnGh5R+3TF64G4uTGjA5URsQiPw9g=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     nivedita@alum.mit.edu, hdegoede@redhat.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH 3/3] efi/x86: avoid RWX mappings for all of DRAM
Date:   Fri, 27 Dec 2019 17:34:18 +0100
Message-Id: <20191227163418.16139-4-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191227163418.16139-1-ardb@kernel.org>
References: <20191227163418.16139-1-ardb@kernel.org>
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
index 9e9a4b31f74b..efdad1052457 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -377,10 +377,6 @@ int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages)
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
@@ -421,6 +417,19 @@ static void __init __map_region(efi_memory_desc_t *md, u64 va)
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
2.17.1

