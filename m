Return-Path: <linux-efi+bounces-204-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA47E81200A
	for <lists+linux-efi@lfdr.de>; Wed, 13 Dec 2023 21:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCAC21C20BB3
	for <lists+linux-efi@lfdr.de>; Wed, 13 Dec 2023 20:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFD7381BD;
	Wed, 13 Dec 2023 20:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="tvLg0qc3"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E896DDC
	for <linux-efi@vger.kernel.org>; Wed, 13 Dec 2023 12:32:21 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40c3fe6c1b5so44090695e9.2
        for <linux-efi@vger.kernel.org>; Wed, 13 Dec 2023 12:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702499540; x=1703104340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUqvcHnbHjun3bdBJPfvf0B8JWy5i7uak5v/0Wh9cSk=;
        b=tvLg0qc3/fTYkGAGuKpUnAKHTew2uRcRyChSM07vme5fcKGFB3WN+ZKItdscpxbwfa
         ehcQkusNpeGUf/DG8eCkbWaEd4o5DNzpCazXppUhkUmtXyXlzSan80df7lp6eZDmsyeb
         H2k7IQS5DBz+U8VkSIlSP1nfBRyKB4qhNGwhQPVKrXEdvxohAguSom7TARUOFvQYjxVV
         veMHqPF/djlN/1P3QdGGdZiri9G7FUBleOGLLVCztdJYcy1xhQdks+vXGPmCX2BhZl42
         e70uHg0HClSw4RZ9TqaiqgiPe+7tPl/QE99gls0Te+IHpbszjf0smAcOW3ZCRH9c3ngm
         qSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702499540; x=1703104340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUqvcHnbHjun3bdBJPfvf0B8JWy5i7uak5v/0Wh9cSk=;
        b=PK2pdnGR4cAp0x9zDs06fhsAUk8cCSDfWNcSffyc2KFgqJ86t67r8VmyCA52i2Uu5n
         hm0j2bMw7SWEsm15zYVeH7SPcPFLyXVKTQMqxmp8Xjeykldeic53jMtqbSYJ8hSM0aMP
         1BJuCkev9UW97feS+W09qdrndikFKbRlfcpIggEb25To4spf9MOAPGWcVI7jRg8hA4db
         oLvF/4y7Oq+uVB1A4KhmgWF2G5dJSAe/3vLbB/+P7pyzyQdj9WtLbGKYL1uwzvwr0nMI
         xRsjyDEmywJal49pDETeuFjpPXFl1vq/4Y9h01fDzTz5zeZO1WKXkqqRBtv00GUff8W5
         04CQ==
X-Gm-Message-State: AOJu0YwA7tZFfBrVHUk9rzMS9yOPksBtr8lF9y3YJMqDgt+Kk02qNHoP
	1Aw3ihVQl7S9xy6QQeWdLPs15A==
X-Google-Smtp-Source: AGHT+IGeWwb4mZTjVlnfL3Tc7x0njpKhguH1T5u5o7xiWbZOuJ+qDIheC5NMdpL6eYcBnXpv6MaCcA==
X-Received: by 2002:a5d:51cc:0:b0:336:353b:2193 with SMTP id n12-20020a5d51cc000000b00336353b2193mr1550679wrv.61.1702499540379;
        Wed, 13 Dec 2023 12:32:20 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d4c4a000000b003333abf3edfsm14139649wrt.47.2023.12.13.12.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 12:32:20 -0800 (PST)
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
Subject: [PATCH v2 2/4] mm: Introduce pudp/p4dp/pgdp_get() functions
Date: Wed, 13 Dec 2023 21:29:59 +0100
Message-Id: <20231213203001.179237-3-alexghiti@rivosinc.com>
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

Instead of directly dereferencing page tables entries, which can cause
issues (see commit 20a004e7b017 ("arm64: mm: Use READ_ONCE/WRITE_ONCE when
accessing page tables"), let's introduce new functions to get the
pud/p4d/pgd entries (the pte and pmd versions already exist).

Note that arm pgd_t is actually an array so pgdp_get() is defined as a
macro to avoid a build error.

Those new functions will be used in subsequent commits by the riscv
architecture.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/arm/include/asm/pgtable.h |  2 ++
 include/linux/pgtable.h        | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 16b02f44c7d3..d657b84b6bf7 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -151,6 +151,8 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 
+#define pgdp_get(pgpd)		READ_ONCE(*pgdp)
+
 #define pud_page(pud)		pmd_page(__pmd(pud_val(pud)))
 #define pud_write(pud)		pmd_write(__pmd(pud_val(pud)))
 
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index af7639c3b0a3..8b7daccd11be 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -292,6 +292,27 @@ static inline pmd_t pmdp_get(pmd_t *pmdp)
 }
 #endif
 
+#ifndef pudp_get
+static inline pud_t pudp_get(pud_t *pudp)
+{
+	return READ_ONCE(*pudp);
+}
+#endif
+
+#ifndef p4dp_get
+static inline p4d_t p4dp_get(p4d_t *p4dp)
+{
+	return READ_ONCE(*p4dp);
+}
+#endif
+
+#ifndef pgdp_get
+static inline pgd_t pgdp_get(pgd_t *pgdp)
+{
+	return READ_ONCE(*pgdp);
+}
+#endif
+
 #ifndef __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
 					    unsigned long address,
-- 
2.39.2


