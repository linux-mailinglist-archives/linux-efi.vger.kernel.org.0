Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7AE412D322
	for <lists+linux-efi@lfdr.de>; Mon, 30 Dec 2019 19:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfL3SJc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 30 Dec 2019 13:09:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:38266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727318AbfL3SJc (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 30 Dec 2019 13:09:32 -0500
Received: from localhost.localdomain (91-167-84-221.subs.proxad.net [91.167.84.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82BA7206DB;
        Mon, 30 Dec 2019 18:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577729371;
        bh=v0WViQqJRFNu7UL2rqL2dhJpHY85fCZUO8PDmqwjR4s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2a/S/9u4hNJ4vXDCVyEju5y/mPKD/nmSxqm26Mrd7D0S+GBIvqqX2YOoNOvGR1HQR
         oaQr3lYEeQoo432avhwhCZLLlZZjE6N5VWZcWhxfHDzP9jXZsKeL5IPyLxAux3+rHV
         SpcZfSX6Q2WPvkptpmVhPbnpnrm9aT+xDL7pMBt8=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 06/14] efi/x86: split off some old memmap handling into separate routines
Date:   Mon, 30 Dec 2019 19:08:26 +0100
Message-Id: <20191230180834.75601-7-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191230180834.75601-1-ardb@kernel.org>
References: <20191230180834.75601-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In a subsequent patch, we will fold the prolog/epilog routines that are
part of the support code to call SetVirtualAddressMap() with a 1:1
mapping into the callers. However, the 64-bit version mostly consists
of ugly mapping code that is only used when efi=old_map is in effect,
which is extremely rare. So let's move this code out of the way so it
does not clutter the common code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/efi/efi_64.c | 35 ++++++++++++--------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 03c2ed3c645c..a72bbabbc595 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -72,7 +72,9 @@ static void __init early_code_mapping_set_exec(int executable)
 	}
 }
 
-pgd_t * __init efi_call_phys_prolog(void)
+void __init efi_old_memmap_phys_epilog(pgd_t *save_pgd);
+
+pgd_t * __init efi_old_memmap_phys_prolog(void)
 {
 	unsigned long vaddr, addr_pgd, addr_p4d, addr_pud;
 	pgd_t *save_pgd, *pgd_k, *pgd_efi;
@@ -82,11 +84,6 @@ pgd_t * __init efi_call_phys_prolog(void)
 	int pgd;
 	int n_pgds, i, j;
 
-	if (!efi_enabled(EFI_OLD_MEMMAP)) {
-		efi_switch_mm(&efi_mm);
-		return efi_mm.pgd;
-	}
-
 	early_code_mapping_set_exec(1);
 
 	n_pgds = DIV_ROUND_UP((max_pfn << PAGE_SHIFT), PGDIR_SIZE);
@@ -143,11 +140,11 @@ pgd_t * __init efi_call_phys_prolog(void)
 	__flush_tlb_all();
 	return save_pgd;
 out:
-	efi_call_phys_epilog(save_pgd);
+	efi_old_memmap_phys_epilog(save_pgd);
 	return NULL;
 }
 
-void __init efi_call_phys_epilog(pgd_t *save_pgd)
+void __init efi_old_memmap_phys_epilog(pgd_t *save_pgd)
 {
 	/*
 	 * After the lock is released, the original page table is restored.
@@ -158,11 +155,6 @@ void __init efi_call_phys_epilog(pgd_t *save_pgd)
 	p4d_t *p4d;
 	pud_t *pud;
 
-	if (!efi_enabled(EFI_OLD_MEMMAP)) {
-		efi_switch_mm(efi_scratch.prev_mm);
-		return;
-	}
-
 	nr_pgds = DIV_ROUND_UP((max_pfn << PAGE_SHIFT) , PGDIR_SIZE);
 
 	for (pgd_idx = 0; pgd_idx < nr_pgds; pgd_idx++) {
@@ -193,6 +185,23 @@ void __init efi_call_phys_epilog(pgd_t *save_pgd)
 	early_code_mapping_set_exec(0);
 }
 
+pgd_t * __init efi_call_phys_prolog(void)
+{
+	if (efi_enabled(EFI_OLD_MEMMAP))
+		return efi_old_memmap_phys_prolog();
+
+	efi_switch_mm(&efi_mm);
+	return efi_mm.pgd;
+}
+
+void __init efi_call_phys_epilog(pgd_t *save_pgd)
+{
+	if (efi_enabled(EFI_OLD_MEMMAP))
+		efi_old_memmap_phys_epilog(save_pgd);
+	else
+		efi_switch_mm(efi_scratch.prev_mm);
+}
+
 EXPORT_SYMBOL_GPL(efi_mm);
 
 /*
-- 
2.20.1

