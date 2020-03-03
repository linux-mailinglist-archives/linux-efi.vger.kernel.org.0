Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C35C6178467
	for <lists+linux-efi@lfdr.de>; Tue,  3 Mar 2020 21:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731387AbgCCUy5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Mar 2020 15:54:57 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:47020 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732066AbgCCUyt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Mar 2020 15:54:49 -0500
Received: by mail-qv1-f67.google.com with SMTP id m2so2340705qvu.13;
        Tue, 03 Mar 2020 12:54:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mDzum8J3wSJ7k00hejDFeBxBo5iSbhH+2swXE9XJREE=;
        b=Jei2ajlTa/rLVuF1/k5p6sLYmCJdJxhQBAdAc5MsFXCMk53/iT7vZgh5vCHHnPS5/F
         XYa5bLjJkYCIyWIjh9xv5yDw/lfOBWfcadWj0XRqlVJALuCJbJONUKEatiTpUKz78FQ5
         xQgO7xBXpDNktqyRPcJQZcjzFC8etk3gFtw+PETF08GhyVG8Ceds+PjCBrThSCQOZeuC
         RSpOKGEORgFu83ahZM6flNSWfalMBHSJwfwKV1FvxzlUDqYb48dY1FIyaRedcDvjXhDJ
         sKlZa4nF6r+sOqDuxA3wiHoUyapcAoMC9cRQwARoSneSUP1cF6xJkl+dxAwFKtJfGTG8
         gNWQ==
X-Gm-Message-State: ANhLgQ1xKJ6VzpL9+S11//kAKvJ/mDL53g35qr4f4+7tcbDfP/6MLUPK
        1F4OapuzCMnDOwZCRcUXF6c=
X-Google-Smtp-Source: ADFU+vv8Agm7Y8s9TquC/U39fkMPcMBgoegSt0tiE9ZctfeiDz4DwCkrwG9CdkB3TMxXwWF5EXP6lA==
X-Received: by 2002:a05:6214:209:: with SMTP id i9mr5644157qvt.54.1583268888083;
        Tue, 03 Mar 2020 12:54:48 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v12sm11473041qti.84.2020.03.03.12.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 12:54:47 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] x86/mm/pat: Ensure that populate_pud only handles one PUD
Date:   Tue,  3 Mar 2020 15:54:43 -0500
Message-Id: <20200303205445.3965393-3-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200303205445.3965393-1-nivedita@alum.mit.edu>
References: <20200303205445.3965393-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add a check in populate_pgd to make sure that populate_pud is called on
a range that actually fits inside a PUD.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/mm/pat/set_memory.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index d0b7b06253a5..a1003bc9fdf6 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1420,6 +1420,7 @@ static int populate_pgd(struct cpa_data *cpa, unsigned long addr)
 	p4d_t *p4d;
 	pgd_t *pgd_entry;
 	long ret;
+	unsigned long end, end_p4d;
 
 	pgd_entry = cpa->pgd + pgd_index(addr);
 
@@ -1443,6 +1444,15 @@ static int populate_pgd(struct cpa_data *cpa, unsigned long addr)
 		set_p4d(p4d, __p4d(__pa(pud) | _KERNPG_TABLE));
 	}
 
+	/*
+	 * Ensure that the range fits inside one p4d entry. If a larger range
+	 * was requested, __change_page_attr_set_clr will loop to finish it.
+	 */
+	end = addr + (cpa->numpages << PAGE_SHIFT);
+	end_p4d = (addr + P4D_SIZE) & P4D_MASK;
+	if (end_p4d < end)
+		cpa->numpages = (end_p4d - addr) >> PAGE_SHIFT;
+
 	pgprot_val(pgprot) &= ~pgprot_val(cpa->mask_clr);
 	pgprot_val(pgprot) |=  pgprot_val(cpa->mask_set);
 
-- 
2.24.1

