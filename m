Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8359139788
	for <lists+linux-efi@lfdr.de>; Mon, 13 Jan 2020 18:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgAMRXY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Jan 2020 12:23:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:41888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728873AbgAMRXU (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 13 Jan 2020 12:23:20 -0500
Received: from dogfood.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C959214AF;
        Mon, 13 Jan 2020 17:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578936200;
        bh=MVe9e5VC7SvtShd7dyIhPx2HpG1JLgDlBrxjy8ZUlSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ac1KvcWjdAcdmg5YbZ+vsNC+isxtg0/6KrqTVTKwCbz+P6pIJNBWaKnGtOzgA3qR4
         p9fKwtbtdeNgghon2V3vV0t0zqgPwXm39AC2QjadIAE4RF7DrlYjDdupxMz1W+Hjz6
         HHc+PvxprBSZ1piJ+w7HLeCFrI03Y1JudFJdg+HY=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Young <dyoung@redhat.com>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH 06/13] efi/x86: avoid RWX mappings for all of DRAM
Date:   Mon, 13 Jan 2020 18:22:38 +0100
Message-Id: <20200113172245.27925-7-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200113172245.27925-1-ardb@kernel.org>
References: <20200113172245.27925-1-ardb@kernel.org>
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
them read-only right away]. For cases of buggy firmware where boot
services code is called during SetVirtualAddressMap(), map those
regions with exec permissions as well - they will be unmapped in
efi_free_boot_services().

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/efi/efi_64.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 6ec58ff60b56..3eb23966e30a 100644
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
@@ -410,6 +406,22 @@ static void __init __map_region(efi_memory_desc_t *md, u64 va)
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
+	 * regions can be mapped non-executable at this point, with
+	 * the exception of boot services code regions, but those will
+	 * be unmapped again entirely in efi_free_boot_services().
+	 */
+	if (md->type != EFI_BOOT_SERVICES_CODE &&
+	    md->type != EFI_RUNTIME_SERVICES_CODE)
+		flags |= _PAGE_NX;
+
 	if (!(md->attribute & EFI_MEMORY_WB))
 		flags |= _PAGE_PCD;
 
-- 
2.20.1

