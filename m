Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0FEE178463
	for <lists+linux-efi@lfdr.de>; Tue,  3 Mar 2020 21:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732103AbgCCUyu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Mar 2020 15:54:50 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:42831 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732094AbgCCUyu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Mar 2020 15:54:50 -0500
Received: by mail-qv1-f65.google.com with SMTP id e7so2343687qvy.9;
        Tue, 03 Mar 2020 12:54:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XrJj+32a4u1g/+qGhJSOQLI9T64Z8GnmPgV9eQzjWGw=;
        b=TbAn8A4P4LM4DxLA68gAb72gtulbgR2HnjbCb701rC6lT1VRnt2866KM2BOnlHs18i
         RauGNASbtnJRXpMz7ZoISlLadS5AXR9VhPC9M0CdNemJcDRsrvbJ9+8UbBvlmoYa9NkS
         qPbe7+CBWdhSqIo6FE5VAYVplq3h4qeyPTlypMTPtCoPOJTw+T00S7MQtGzEYYlLjECr
         6Q+mVWqLyD10NL9xUgyrQBCYDSCWnaZpcLjNOMygDoZtoBYwoTqmYeX3hEz6xuXeZZeD
         6u/5Zc/q7LElgWo5yDSBUc2RgNjJmpizTrW78SGqrHJpwgjJWp4/YbKX8o1jQCp9QozV
         IA4w==
X-Gm-Message-State: ANhLgQ3FquwhHfsKkJXsrIpjDIH9Thdho9X8nB2ZdEbvRJuTFKpf7Hfy
        mDRZ756cRW2HvpWwPdTwiww=
X-Google-Smtp-Source: ADFU+vuuPzHDymFpuKFWXB+axrHh/7mbR+A7tfWqpdAgtLEP9MQDghKh0PoegHqG46ptyG6yfcadgA==
X-Received: by 2002:a0c:bf05:: with SMTP id m5mr5688837qvi.26.1583268888930;
        Tue, 03 Mar 2020 12:54:48 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v12sm11473041qti.84.2020.03.03.12.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 12:54:48 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] x86/mm/pat: Propagate all errors out of populate_pud
Date:   Tue,  3 Mar 2020 15:54:44 -0500
Message-Id: <20200303205445.3965393-4-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200303205445.3965393-1-nivedita@alum.mit.edu>
References: <20200303205445.3965393-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

populate_pud tries to return the number of pages mapped so far if
populate_pmd fails. This is of dubious utility, since if populate_pmd
did any work before failing, the returned number of pages will be
inconsistent with cpa->pfn, and the loop in __change_page_attr_set_clr
will retry with that inconsistent state. Further, if the number of pages
mapped before failure is zero, that will trigger the BUG_ON in
__change_page_attr_set_clr.

Just return all errors up the stack and let the original caller deal
with it.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/mm/pat/set_memory.c | 43 ++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index a1003bc9fdf6..2f98423ef69a 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1247,9 +1247,9 @@ static void populate_pte(struct cpa_data *cpa,
 	}
 }
 
-static long populate_pmd(struct cpa_data *cpa,
-			 unsigned long start, unsigned long end,
-			 unsigned num_pages, pud_t *pud, pgprot_t pgprot)
+static int populate_pmd(struct cpa_data *cpa,
+			unsigned long start, unsigned long end,
+			unsigned num_pages, pud_t *pud, pgprot_t pgprot)
 {
 	long cur_pages = 0;
 	pmd_t *pmd;
@@ -1283,7 +1283,7 @@ static long populate_pmd(struct cpa_data *cpa,
 	 * We mapped them all?
 	 */
 	if (num_pages == cur_pages)
-		return cur_pages;
+		return 0;
 
 	pmd_pgprot = pgprot_4k_2_large(pgprot);
 
@@ -1318,7 +1318,7 @@ static long populate_pmd(struct cpa_data *cpa,
 		populate_pte(cpa, start, end, num_pages - cur_pages,
 			     pmd, pgprot);
 	}
-	return num_pages;
+	return 0;
 }
 
 static int populate_pud(struct cpa_data *cpa, unsigned long start, p4d_t *p4d,
@@ -1328,6 +1328,7 @@ static int populate_pud(struct cpa_data *cpa, unsigned long start, p4d_t *p4d,
 	unsigned long end;
 	long cur_pages = 0;
 	pgprot_t pud_pgprot;
+	int ret;
 
 	end = start + (cpa->numpages << PAGE_SHIFT);
 
@@ -1352,17 +1353,16 @@ static int populate_pud(struct cpa_data *cpa, unsigned long start, p4d_t *p4d,
 			if (alloc_pmd_page(pud))
 				return -1;
 
-		cur_pages = populate_pmd(cpa, start, pre_end, cur_pages,
-					 pud, pgprot);
-		if (cur_pages < 0)
-			return cur_pages;
+		ret = populate_pmd(cpa, start, pre_end, cur_pages, pud, pgprot);
+		if (ret < 0)
+			return ret;
 
 		start = pre_end;
 	}
 
 	/* We mapped them all? */
 	if (cpa->numpages == cur_pages)
-		return cur_pages;
+		return 0;
 
 	pud = pud_offset(p4d, start);
 	pud_pgprot = pgprot_4k_2_large(pgprot);
@@ -1379,10 +1379,10 @@ static int populate_pud(struct cpa_data *cpa, unsigned long start, p4d_t *p4d,
 			if (pud_none(*pud))
 				if (alloc_pmd_page(pud))
 					return -1;
-			if (populate_pmd(cpa, start, start + PUD_SIZE,
-					 PUD_SIZE >> PAGE_SHIFT,
-					 pud, pgprot) < 0)
-				return cur_pages;
+			ret = populate_pmd(cpa, start, start + PUD_SIZE,
+					   PUD_SIZE >> PAGE_SHIFT, pud, pgprot);
+			if (ret < 0)
+				return ret;
 		}
 
 		start	  += PUD_SIZE;
@@ -1392,21 +1392,17 @@ static int populate_pud(struct cpa_data *cpa, unsigned long start, p4d_t *p4d,
 
 	/* Map trailing leftover */
 	if (start < end) {
-		long tmp;
-
 		pud = pud_offset(p4d, start);
 		if (pud_none(*pud))
 			if (alloc_pmd_page(pud))
 				return -1;
 
-		tmp = populate_pmd(cpa, start, end, cpa->numpages - cur_pages,
+		ret = populate_pmd(cpa, start, end, cpa->numpages - cur_pages,
 				   pud, pgprot);
-		if (tmp < 0)
-			return cur_pages;
-
-		cur_pages += tmp;
+		if (ret < 0)
+			return ret;
 	}
-	return cur_pages;
+	return 0;
 }
 
 /*
@@ -1419,7 +1415,7 @@ static int populate_pgd(struct cpa_data *cpa, unsigned long addr)
 	pud_t *pud = NULL;	/* shut up gcc */
 	p4d_t *p4d;
 	pgd_t *pgd_entry;
-	long ret;
+	int ret;
 	unsigned long end, end_p4d;
 
 	pgd_entry = cpa->pgd + pgd_index(addr);
@@ -1468,7 +1464,6 @@ static int populate_pgd(struct cpa_data *cpa, unsigned long addr)
 		return ret;
 	}
 
-	cpa->numpages = ret;
 	return 0;
 }
 
-- 
2.24.1

