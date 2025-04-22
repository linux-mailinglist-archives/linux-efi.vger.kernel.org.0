Return-Path: <linux-efi+bounces-3410-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A7EA96C52
	for <lists+linux-efi@lfdr.de>; Tue, 22 Apr 2025 15:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F31973A8DF6
	for <lists+linux-efi@lfdr.de>; Tue, 22 Apr 2025 13:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EFE281377;
	Tue, 22 Apr 2025 13:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HkmKTb3L";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HkmKTb3L"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B34F27C172
	for <linux-efi@vger.kernel.org>; Tue, 22 Apr 2025 13:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745327844; cv=none; b=Wod2jGZ7yNQtiHq1PlSwg+3AA4YOcE1BEPmyMfIW/a3ZILK94zsohiV1QWVi0anP8tktH0hRV0FUdDSy6n+442Xml1D5rLOcE3H0kP5YBvBLFCOxWgduDQP5jA7W5mlC8OHZFMauZQMnLtla7BMoqni3g+Q3jHyOCO98L2w2UFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745327844; c=relaxed/simple;
	bh=zZKWoAnEwaeWfNaPxu41iNDLR8Asl3rPaIAFxcJ58xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=phphxCg8vk/U7LvFb5UhWI6Ogv467zM+tFneV8GpRrkMaz6ilIapiOwRarREZas4EYQJ3M39jMb/LLXWXPFjSlOMClwsT1s722naSgzSaEjaJYkq98ZB0HFBTAdqtmEomqWBdW2f/x7rL8ikW6uvjx4sOVfOcM/QZZqs3s80npw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HkmKTb3L; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HkmKTb3L; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 83BF3211B3;
	Tue, 22 Apr 2025 13:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745327839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EX33nKqYUAfA5T5DxjQKtCNUfXLrTj0vy1fYAknnyPk=;
	b=HkmKTb3LRvQXxtR+I1WLh9bQirlo4hWhwrvFgJRYPGXRbd4fg9D39uksVRupmyVOrbo08g
	jU68/rYDZKFH0fapLH617O8d9dFex8WtLgrR0e7qCKbWcfu2nKXL1Z5gwaiNTAbRG9jC8F
	rbYmpnP+gOZcHz/BFFPYLhio2LTFTx8=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745327839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EX33nKqYUAfA5T5DxjQKtCNUfXLrTj0vy1fYAknnyPk=;
	b=HkmKTb3LRvQXxtR+I1WLh9bQirlo4hWhwrvFgJRYPGXRbd4fg9D39uksVRupmyVOrbo08g
	jU68/rYDZKFH0fapLH617O8d9dFex8WtLgrR0e7qCKbWcfu2nKXL1Z5gwaiNTAbRG9jC8F
	rbYmpnP+gOZcHz/BFFPYLhio2LTFTx8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13DFA137CF;
	Tue, 22 Apr 2025 13:17:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kHluA9+WB2hiNAAAD6G6ig
	(envelope-from <jgross@suse.com>); Tue, 22 Apr 2025 13:17:19 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-efi@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	=?UTF-8?q?Petr=20Van=C4=9Bk?= <arkamar@atlas.cz>,
	stable@vger.kernel.org
Subject: [PATCH v2] x86/mm: fix _pgd_alloc() for Xen PV mode
Date: Tue, 22 Apr 2025 15:17:17 +0200
Message-ID: <20250422131717.25724-1-jgross@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

Recently _pgd_alloc() was switched from using __get_free_pages() to
pagetable_alloc_noprof(), which might return a compound page in case
the allocation order is larger than 0.

On x86 this will be the case if CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
is set, even if PTI has been disabled at runtime.

When running as a Xen PV guest (this will always disable PTI), using
a compound page for a PGD will result in VM_BUG_ON_PGFLAGS being
triggered when the Xen code tries to pin the PGD.

Fix the Xen issue together with the not needed 8k allocation for a
PGD with PTI disabled by replacing PGD_ALLOCATION_ORDER with an
inline helper returning the needed order for PGD allocations.

Reported-by: Petr Vaněk <arkamar@atlas.cz>
Fixes: a9b3c355c2e6 ("asm-generic: pgalloc: provide generic __pgd_{alloc,free}")
Cc: stable@vger.kernel.org
Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- use pgd_allocation_order() instead of PGD_ALLOCATION_ORDER (Dave Hansen)
---
 arch/x86/include/asm/pgalloc.h     | 19 +++++++++++--------
 arch/x86/kernel/machine_kexec_32.c |  4 ++--
 arch/x86/mm/pgtable.c              |  4 ++--
 arch/x86/platform/efi/efi_64.c     |  4 ++--
 4 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
index a33147520044..c88691b15f3c 100644
--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -6,6 +6,8 @@
 #include <linux/mm.h>		/* for struct page */
 #include <linux/pagemap.h>
 
+#include <asm/cpufeature.h>
+
 #define __HAVE_ARCH_PTE_ALLOC_ONE
 #define __HAVE_ARCH_PGD_FREE
 #include <asm-generic/pgalloc.h>
@@ -29,16 +31,17 @@ static inline void paravirt_release_pud(unsigned long pfn) {}
 static inline void paravirt_release_p4d(unsigned long pfn) {}
 #endif
 
-#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 /*
- * Instead of one PGD, we acquire two PGDs.  Being order-1, it is
- * both 8k in size and 8k-aligned.  That lets us just flip bit 12
- * in a pointer to swap between the two 4k halves.
+ * In case of Page Table Isolation active, we acquire two PGDs instead of one.
+ * Being order-1, it is both 8k in size and 8k-aligned.  That lets us just
+ * flip bit 12 in a pointer to swap between the two 4k halves.
  */
-#define PGD_ALLOCATION_ORDER 1
-#else
-#define PGD_ALLOCATION_ORDER 0
-#endif
+static inline unsigned int pgd_allocation_order(void)
+{
+	if (cpu_feature_enabled(X86_FEATURE_PTI))
+		return 1;
+	return 0;
+}
 
 /*
  * Allocate and free page tables.
diff --git a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_kexec_32.c
index 80265162aeff..1f325304c4a8 100644
--- a/arch/x86/kernel/machine_kexec_32.c
+++ b/arch/x86/kernel/machine_kexec_32.c
@@ -42,7 +42,7 @@ static void load_segments(void)
 
 static void machine_kexec_free_page_tables(struct kimage *image)
 {
-	free_pages((unsigned long)image->arch.pgd, PGD_ALLOCATION_ORDER);
+	free_pages((unsigned long)image->arch.pgd, pgd_allocation_order());
 	image->arch.pgd = NULL;
 #ifdef CONFIG_X86_PAE
 	free_page((unsigned long)image->arch.pmd0);
@@ -59,7 +59,7 @@ static void machine_kexec_free_page_tables(struct kimage *image)
 static int machine_kexec_alloc_page_tables(struct kimage *image)
 {
 	image->arch.pgd = (pgd_t *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
-						    PGD_ALLOCATION_ORDER);
+						    pgd_allocation_order());
 #ifdef CONFIG_X86_PAE
 	image->arch.pmd0 = (pmd_t *)get_zeroed_page(GFP_KERNEL);
 	image->arch.pmd1 = (pmd_t *)get_zeroed_page(GFP_KERNEL);
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index a05fcddfc811..f7ae44d3dd9e 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -360,7 +360,7 @@ static inline pgd_t *_pgd_alloc(struct mm_struct *mm)
 	 * We allocate one page for pgd.
 	 */
 	if (!SHARED_KERNEL_PMD)
-		return __pgd_alloc(mm, PGD_ALLOCATION_ORDER);
+		return __pgd_alloc(mm, pgd_allocation_order());
 
 	/*
 	 * Now PAE kernel is not running as a Xen domain. We can allocate
@@ -380,7 +380,7 @@ static inline void _pgd_free(struct mm_struct *mm, pgd_t *pgd)
 
 static inline pgd_t *_pgd_alloc(struct mm_struct *mm)
 {
-	return __pgd_alloc(mm, PGD_ALLOCATION_ORDER);
+	return __pgd_alloc(mm, pgd_allocation_order());
 }
 
 static inline void _pgd_free(struct mm_struct *mm, pgd_t *pgd)
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index ac57259a432b..a4b4ebd41b8f 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -73,7 +73,7 @@ int __init efi_alloc_page_tables(void)
 	gfp_t gfp_mask;
 
 	gfp_mask = GFP_KERNEL | __GFP_ZERO;
-	efi_pgd = (pgd_t *)__get_free_pages(gfp_mask, PGD_ALLOCATION_ORDER);
+	efi_pgd = (pgd_t *)__get_free_pages(gfp_mask, pgd_allocation_order());
 	if (!efi_pgd)
 		goto fail;
 
@@ -96,7 +96,7 @@ int __init efi_alloc_page_tables(void)
 	if (pgtable_l5_enabled())
 		free_page((unsigned long)pgd_page_vaddr(*pgd));
 free_pgd:
-	free_pages((unsigned long)efi_pgd, PGD_ALLOCATION_ORDER);
+	free_pages((unsigned long)efi_pgd, pgd_allocation_order());
 fail:
 	return -ENOMEM;
 }
-- 
2.43.0


