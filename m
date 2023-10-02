Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10B27B5684
	for <lists+linux-efi@lfdr.de>; Mon,  2 Oct 2023 17:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237999AbjJBPLn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Oct 2023 11:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237966AbjJBPLm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 2 Oct 2023 11:11:42 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370C8DA
        for <linux-efi@vger.kernel.org>; Mon,  2 Oct 2023 08:11:39 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4060b623e64so19752995e9.0
        for <linux-efi@vger.kernel.org>; Mon, 02 Oct 2023 08:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696259497; x=1696864297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CH5x2RpAAFVf+XEG+0f6TamSE9fPT169LwjSjxAPY4U=;
        b=sZYLZdW1sqyhuGnlVwuGihDYW6v5O4P88fRBV5P0IldYQjc9PTJ7jtDmFdUYLz2uf1
         vVOe8Ks/EjlyPz2IcPzxF+RjHEbn4kU6KcnsE99CT+IYCStO5QY0sm0C1oOPHc9arvnd
         LSg3kshb4uk4e4idEjZNWSqUwGo+3b2L0J3TWvu+Nm0KMm+GwJpqNwEelW7aaCs3CSsS
         G9l5JBOi9wPPKHHpTbFHolpiBf2lOGS1WakzP9iYL7FzUM6pmO1SGofuim14BH/bOO5b
         dxrppG0t6v/x8a+hieXfqNWUANAbRRJTVrLNV8/V4UmNJRnqSDVTVvkd+VB1KKZOhSXi
         Erlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696259497; x=1696864297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CH5x2RpAAFVf+XEG+0f6TamSE9fPT169LwjSjxAPY4U=;
        b=ECMtxRWGPvHJkX29dtoFK6e7RCMFEAyGdlxkdTHJrzDHazx0o6/+Cl/MgtnD3Asztl
         zxpIs2HBDiZNthqdhl9NepE03fZxc02vSRkCGgwbHXMhqnGIFdG8BZ0fvpTdQcx520S3
         dKtDZLyDcBmxGhWq0XleRHLY+4vVCz0VFzR5FoJpW4bqT+OXIjsxsYw9h12gNsF8Nt2k
         +BH1B0yYLPcy4Bldu3KbRdnXrqzCDLWhz1cZ58eSl0HiruqAc0dT/maPM0gNlAnHQy/k
         oeD96xvIXTwlYok8iS7j/q+EVjfXZ3Zkpjey50W1prsagnKLtScovzV0MLv5/Wx7gCXd
         BBQg==
X-Gm-Message-State: AOJu0Yx1WKWMd9tGa6FuvSTV3K8SKG6bxuJJAp2gGzpCd+d6wggLNScZ
        H3qxfnuehZkZqPCkFNrgPV0Z0w==
X-Google-Smtp-Source: AGHT+IE3cvPQyM2FMWspPhPjMKub5vjeWt6/Vb1fFmHzwxugTPglcumTh9TgVZ+QYgvakVdrqaJiiQ==
X-Received: by 2002:a05:600c:1c9d:b0:401:609f:7f9a with SMTP id k29-20020a05600c1c9d00b00401609f7f9amr10681875wms.8.1696259497220;
        Mon, 02 Oct 2023 08:11:37 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id o14-20020a05600c4fce00b004065d67c3c9sm7473193wmq.8.2023.10.02.08.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 08:11:36 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-efi@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 1/5] riscv: Use WRITE_ONCE() when setting page table entries
Date:   Mon,  2 Oct 2023 17:10:27 +0200
Message-Id: <20231002151031.110551-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231002151031.110551-1-alexghiti@rivosinc.com>
References: <20231002151031.110551-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

To avoid any compiler "weirdness" when accessing page table entries which
are concurrently modified by the HW, let's use WRITE_ONCE() macro
(commit 20a004e7b017 ("arm64: mm: Use READ_ONCE/WRITE_ONCE when accessing
page tables") gives a great explanation with more details).

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/pgtable-64.h | 6 +++---
 arch/riscv/include/asm/pgtable.h    | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index 7a5097202e15..a65a352dcfbf 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -198,7 +198,7 @@ static inline int pud_user(pud_t pud)
 
 static inline void set_pud(pud_t *pudp, pud_t pud)
 {
-	*pudp = pud;
+	WRITE_ONCE(*pudp, pud);
 }
 
 static inline void pud_clear(pud_t *pudp)
@@ -274,7 +274,7 @@ static inline unsigned long _pmd_pfn(pmd_t pmd)
 static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
 {
 	if (pgtable_l4_enabled)
-		*p4dp = p4d;
+		WRITE_ONCE(*p4dp, p4d);
 	else
 		set_pud((pud_t *)p4dp, (pud_t){ p4d_val(p4d) });
 }
@@ -347,7 +347,7 @@ static inline pud_t *pud_offset(p4d_t *p4d, unsigned long address)
 static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
 {
 	if (pgtable_l5_enabled)
-		*pgdp = pgd;
+		WRITE_ONCE(*pgdp, pgd);
 	else
 		set_p4d((p4d_t *)pgdp, (p4d_t){ pgd_val(pgd) });
 }
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index b2ba3f79cfe9..b820775f4973 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -248,7 +248,7 @@ static inline int pmd_leaf(pmd_t pmd)
 
 static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
 {
-	*pmdp = pmd;
+	WRITE_ONCE(*pmdp, pmd);
 }
 
 static inline void pmd_clear(pmd_t *pmdp)
@@ -509,7 +509,7 @@ static inline int pte_same(pte_t pte_a, pte_t pte_b)
  */
 static inline void set_pte(pte_t *ptep, pte_t pteval)
 {
-	*ptep = pteval;
+	WRITE_ONCE(*ptep, pteval);
 }
 
 void flush_icache_pte(pte_t pte);
-- 
2.39.2

