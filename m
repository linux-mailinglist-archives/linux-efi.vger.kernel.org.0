Return-Path: <linux-efi+bounces-203-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11637812004
	for <lists+linux-efi@lfdr.de>; Wed, 13 Dec 2023 21:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE8461F21849
	for <lists+linux-efi@lfdr.de>; Wed, 13 Dec 2023 20:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F24381BD;
	Wed, 13 Dec 2023 20:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="OF+hrUMD"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFCDDD
	for <linux-efi@vger.kernel.org>; Wed, 13 Dec 2023 12:31:20 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3333b46f26aso6625373f8f.1
        for <linux-efi@vger.kernel.org>; Wed, 13 Dec 2023 12:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702499478; x=1703104278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E15RwjGwh0jg6//BOgBWUm8VeEPhhxkhRr12JTaACPU=;
        b=OF+hrUMDO1WDgo25gRINqm8tt4IJOo30AwXe7ElgLxjc8MhNhG5j+NLC1fcPU0USNE
         6IzGOWwIjEN6XNZu/K2eJFANsI14nVKWUJloCCVP/vUxv6jVMujvSmj8+TK4ACfFbzz0
         aFJUGMNCrpIc8agIsfaosP43snv9/Piozb5A/aWKppcriqqgnkBa4WgUPlKcMNMfkvk+
         vbetLn8AXoQ/5Jx5ey6Zlgvh5ZFC1sOc76EGmtlPykOVi6YDST0QcPRclh1UuCTpvoYS
         Csj3G5/1NHSKgVXB73+Trjhutx4Iea/0MAc/bNH3L9X7RS6B2Zq+vU6BHZe4yQvQsWOV
         jwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702499478; x=1703104278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E15RwjGwh0jg6//BOgBWUm8VeEPhhxkhRr12JTaACPU=;
        b=FA7sKBBIx5hSvGL0ib7NW8xKNRb9J6aYW8QOT4nb84XG0vJSUGCNVxfIwa+o2kOof3
         mtF3IhiDkT2GDrEJEW5D+z63au87UjNa4aV9WSF739BuopQbiMkrMW76Vs+QOos+IQiH
         uWWAX7w/jMQ+FwPOCitxcBg27gUAYzAXJULlPV/KP6QCbznUUWzv1Qa5TkVscX6sLOL6
         hR92Yo+ZUCWf8wVe5BrkdUj0I5uqCzzlbWjRdPpw1B6ZzlfogDJNbpfT62kkiHQu1miw
         27vxVno7uOcvKHbd9JsPZr6iD81m76CuvV3CjJOmoZkXWhVN0p8CyeJx2q7Q4RhvUc6j
         95ag==
X-Gm-Message-State: AOJu0YwtI7PXbOb2hxldNlg2dB3vCPTqGJpEKcV9Va2YKURqpESCcQ6f
	FZZhIQhrOvW5B8YfLRzgaJzxHQ==
X-Google-Smtp-Source: AGHT+IHJ9RU792w4DCZZx9hZPdAspSn4SI/uXWC5g1BlHgB2r11Rp2Nl7fP233w9pzamiUzq2saHcQ==
X-Received: by 2002:a5d:5742:0:b0:336:370d:4c4f with SMTP id q2-20020a5d5742000000b00336370d4c4fmr973590wrw.60.1702499478475;
        Wed, 13 Dec 2023 12:31:18 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id h3-20020a5d4303000000b0033629538fa2sm5560888wrq.18.2023.12.13.12.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 12:31:18 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Russell King <linux@armlinux.org.uk>,
	Ryan Roberts <ryan.roberts@arm.com>,
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
	kasan-dev@googlegroups.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-efi@vger.kernel.org,
	linux-mm@kvack.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2 1/4] riscv: Use WRITE_ONCE() when setting page table entries
Date: Wed, 13 Dec 2023 21:29:58 +0100
Message-Id: <20231213203001.179237-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231213203001.179237-1-alexghiti@rivosinc.com>
References: <20231213203001.179237-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index 9a2c780a11e9..5d8431a390dd 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -202,7 +202,7 @@ static inline int pud_user(pud_t pud)
 
 static inline void set_pud(pud_t *pudp, pud_t pud)
 {
-	*pudp = pud;
+	WRITE_ONCE(*pudp, pud);
 }
 
 static inline void pud_clear(pud_t *pudp)
@@ -278,7 +278,7 @@ static inline unsigned long _pmd_pfn(pmd_t pmd)
 static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
 {
 	if (pgtable_l4_enabled)
-		*p4dp = p4d;
+		WRITE_ONCE(*p4dp, p4d);
 	else
 		set_pud((pud_t *)p4dp, (pud_t){ p4d_val(p4d) });
 }
@@ -351,7 +351,7 @@ static inline pud_t *pud_offset(p4d_t *p4d, unsigned long address)
 static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
 {
 	if (pgtable_l5_enabled)
-		*pgdp = pgd;
+		WRITE_ONCE(*pgdp, pgd);
 	else
 		set_p4d((p4d_t *)pgdp, (p4d_t){ pgd_val(pgd) });
 }
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 294044429e8e..c9f4b250b4ee 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -248,7 +248,7 @@ static inline int pmd_leaf(pmd_t pmd)
 
 static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
 {
-	*pmdp = pmd;
+	WRITE_ONCE(*pmdp, pmd);
 }
 
 static inline void pmd_clear(pmd_t *pmdp)
@@ -510,7 +510,7 @@ static inline int pte_same(pte_t pte_a, pte_t pte_b)
  */
 static inline void set_pte(pte_t *ptep, pte_t pteval)
 {
-	*ptep = pteval;
+	WRITE_ONCE(*ptep, pteval);
 }
 
 void flush_icache_pte(pte_t pte);
-- 
2.39.2


