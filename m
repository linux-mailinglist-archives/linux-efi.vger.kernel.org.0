Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFBD9178465
	for <lists+linux-efi@lfdr.de>; Tue,  3 Mar 2020 21:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732094AbgCCUyx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Mar 2020 15:54:53 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:45477 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731387AbgCCUyu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Mar 2020 15:54:50 -0500
Received: by mail-qv1-f65.google.com with SMTP id r8so2336654qvs.12;
        Tue, 03 Mar 2020 12:54:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LpQl3QOx5Q+iwwtomiSeHz+aE8G4tQSvo7FgTI9tPuc=;
        b=PSqdvhd2W9ItnvxRDhJ7TffR6b8U5YbwMkn+rJNsf8NU4SnVlI7b+KD5hP8EbADXuy
         rrGLg2bM1vUkll2IIUDRT5+ZkiXOt9nNBtLP90Y3++sJj0t7qTi5G2UHBR3MBgKnH/8S
         tPQ0FLGFcaK0Oa9hVquZwuYpvpugUO5zHvZOqwBsc+phzSRthRwyrqhfJ95GXPCoY0Ag
         u1nvy7hscs18G8OMTzXYBWnGybSu5C2t2J5Mj3BVZuoOGNK4jrzTAJpLnzMw1oX68CH0
         ZXDk8xlWL3mUjCEazRLF88ByEJ8YueK9SBOH3E9jmUSP+7XPBjjhsg9kw2eAhIc7Xki+
         K0JA==
X-Gm-Message-State: ANhLgQ0u7ed+cMU3Se7L4UNTudW8qUYo/Wi0Pl9zjZxZezRBBqGjKP+p
        3jmIRKnGKrjKFABDKNEOFl0=
X-Google-Smtp-Source: ADFU+vsZniQDhGjqLlXxME0EXoL4+0fXjheAns0z7Q7Ng0aBa8/DycAE2U+TOxoyv1vKlgUcFXZ4GA==
X-Received: by 2002:a05:6214:381:: with SMTP id l1mr5780954qvy.178.1583268889854;
        Tue, 03 Mar 2020 12:54:49 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v12sm11473041qti.84.2020.03.03.12.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 12:54:49 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] x86/mm/pat: Make num_pages consistent in populate_{pte,pud,pgd}
Date:   Tue,  3 Mar 2020 15:54:45 -0500
Message-Id: <20200303205445.3965393-5-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200303205445.3965393-1-nivedita@alum.mit.edu>
References: <20200303205445.3965393-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The number of pages is currently all of int, unsigned int, long and
unsigned long in different places.

Change it to be consistently unsigned long.

Remove the unnecessary min(num_pages, cur_pages), since pre_end has
already been min'd with start + num_pages << PAGE_SHIFT. This gets rid
of two conversions to int/unsigned int.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/include/asm/pgtable_types.h |  2 +-
 arch/x86/mm/pat/set_memory.c         | 13 ++++++-------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 0239998d8cdc..894569255a95 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -574,7 +574,7 @@ extern pmd_t *lookup_pmd_address(unsigned long address);
 extern phys_addr_t slow_virt_to_phys(void *__address);
 extern int __init kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn,
 					  unsigned long address,
-					  unsigned numpages,
+					  unsigned long numpages,
 					  unsigned long page_flags);
 extern int __init kernel_unmap_pages_in_pgd(pgd_t *pgd, unsigned long address,
 					    unsigned long numpages);
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 2f98423ef69a..51b64937cc16 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1230,7 +1230,7 @@ static int alloc_pmd_page(pud_t *pud)
 
 static void populate_pte(struct cpa_data *cpa,
 			 unsigned long start, unsigned long end,
-			 unsigned num_pages, pmd_t *pmd, pgprot_t pgprot)
+			 unsigned long num_pages, pmd_t *pmd, pgprot_t pgprot)
 {
 	pte_t *pte;
 
@@ -1249,9 +1249,9 @@ static void populate_pte(struct cpa_data *cpa,
 
 static int populate_pmd(struct cpa_data *cpa,
 			unsigned long start, unsigned long end,
-			unsigned num_pages, pud_t *pud, pgprot_t pgprot)
+			unsigned long num_pages, pud_t *pud, pgprot_t pgprot)
 {
-	long cur_pages = 0;
+	unsigned long cur_pages = 0;
 	pmd_t *pmd;
 	pgprot_t pmd_pgprot;
 
@@ -1264,7 +1264,6 @@ static int populate_pmd(struct cpa_data *cpa,
 
 		pre_end   = min_t(unsigned long, pre_end, next_page);
 		cur_pages = (pre_end - start) >> PAGE_SHIFT;
-		cur_pages = min_t(unsigned int, num_pages, cur_pages);
 
 		/*
 		 * Need a PTE page?
@@ -1326,7 +1325,7 @@ static int populate_pud(struct cpa_data *cpa, unsigned long start, p4d_t *p4d,
 {
 	pud_t *pud;
 	unsigned long end;
-	long cur_pages = 0;
+	unsigned long cur_pages = 0;
 	pgprot_t pud_pgprot;
 	int ret;
 
@@ -1342,7 +1341,6 @@ static int populate_pud(struct cpa_data *cpa, unsigned long start, p4d_t *p4d,
 
 		pre_end   = min_t(unsigned long, end, next_page);
 		cur_pages = (pre_end - start) >> PAGE_SHIFT;
-		cur_pages = min_t(int, (int)cpa->numpages, cur_pages);
 
 		pud = pud_offset(p4d, start);
 
@@ -2231,7 +2229,8 @@ bool kernel_page_present(struct page *page)
 #endif /* CONFIG_HIBERNATION */
 
 int __init kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
-				   unsigned numpages, unsigned long page_flags)
+				   unsigned long numpages,
+				   unsigned long page_flags)
 {
 	int retval = -EINVAL;
 
-- 
2.24.1

