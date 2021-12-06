Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44DEA469466
	for <lists+linux-efi@lfdr.de>; Mon,  6 Dec 2021 11:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241814AbhLFK5F (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Dec 2021 05:57:05 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:45878
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241873AbhLFK5E (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Dec 2021 05:57:04 -0500
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0B1823F1EE
        for <linux-efi@vger.kernel.org>; Mon,  6 Dec 2021 10:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638788015;
        bh=gG/WhBjtCMK9Juy/cpLoUS+Fz+e97sYPeCnLmIYCPu8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=a2mccLycwS8Ep7fYQGR+6U331hBLGDwEtitJx+KSiFqspXUfGApjxQ60nWoJKHV0U
         Kv2AIUUSxtZhhH2EdzG2Uw5eexqGCD1c2H/5BtFG73VSK4YM1PVTqqZuQT0BXHT2xa
         e5x/dGgNZ6jbKbUUY1bXYkNMyzDqFbDExNUijS/t2EsMrcoQyZGm6FakgsDiL2BnW4
         HgrW+dul0eBBm4Lxqq3KcI5NnmwIq08zv1iuAA5RgxuaJhPiDsunBc4Xy+K0sGTTVU
         FPMHkyld/UHFmSroXFwsEFE6hmWj6Hp/fdJ9qINl/yVU/E4fyC/ComrjXlxcxkv6tK
         28eFjClooNzrg==
Received: by mail-wm1-f72.google.com with SMTP id a64-20020a1c7f43000000b003335e5dc26bso5910719wmd.8
        for <linux-efi@vger.kernel.org>; Mon, 06 Dec 2021 02:53:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gG/WhBjtCMK9Juy/cpLoUS+Fz+e97sYPeCnLmIYCPu8=;
        b=10DhiN44FCw39QVR9wljjpQN2GLi5H4ehPOPVr6vdPrdCy2a8ugesSwpvCLr/nXAwx
         bgE7MnDW4FmIJWL6vc45L/r6TwPtwm+OmMTeYZBIvD8lt2kjhy3C29MpG5HEcve2OMW7
         MFXmKBpRh32O80a3qP4HIUyUPFYW9DcZ+8B6ZQLLBKbtr0iXprNB9Qvit9njCqTO4Wbu
         4FitvXQdVejppMO7cLzNOUf68cWhXCnK2RenoXyY73Htr88kfvcjqjVPqwbIOsZ0xJvN
         GFm29PLeFUj8RDp76MRBD2v70eND8n+pCIkxV7vD5L++ZYLMOthTw3YNmbCRiWf348jN
         1kww==
X-Gm-Message-State: AOAM532aGJQnQP9nSFe8SfyBAA8mhgAHhGoDBBZww9lRdo2Q7e7/iRBy
        p2sYucNDAGqBZVTg0CyjggcnA3Kc6F0Jbp8YN1ROo3MhfRPtgVDgA3Kpu7t7FtbNb+E0asrlhmg
        NIzwiTcQ0fSoP9kVDUljtz3Ij0dPkAF1a1k1bvA==
X-Received: by 2002:a7b:c102:: with SMTP id w2mr37750674wmi.151.1638788003996;
        Mon, 06 Dec 2021 02:53:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxopdWj9u1iMI/f8aQI95EBYjbHFU9+o6qbVXkckCCLscAAHiW0VAZVryb3dDIQkey6IRVgJg==
X-Received: by 2002:a7b:c102:: with SMTP id w2mr37750632wmi.151.1638788003798;
        Mon, 06 Dec 2021 02:53:23 -0800 (PST)
Received: from localhost.localdomain (lfbn-lyo-1-470-249.w2-7.abo.wanadoo.fr. [2.7.60.249])
        by smtp.gmail.com with ESMTPSA id p5sm11021231wrd.13.2021.12.06.02.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 02:53:23 -0800 (PST)
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        Atish Patra <Atish.Patra@rivosinc.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        panqinglin2020@iscas.ac.cn, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org,
        linux-arch@vger.kernel.org
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Subject: [PATCH v3 06/13] asm-generic: Prepare for riscv use of pud_alloc_one and pud_free
Date:   Mon,  6 Dec 2021 11:46:50 +0100
Message-Id: <20211206104657.433304-7-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211206104657.433304-1-alexandre.ghiti@canonical.com>
References: <20211206104657.433304-1-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In the following commits, riscv will almost use the generic versions of
pud_alloc_one and pud_free but an additional check is required since those
functions are only relevant when using at least a 4-level page table, which
will be determined at runtime on riscv.

So move the content of those functions into other functions that riscv
can use without duplicating code.

Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
---
 include/asm-generic/pgalloc.h | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 02932efad3ab..977bea16cf1b 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -147,6 +147,15 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 
 #if CONFIG_PGTABLE_LEVELS > 3
 
+static inline pud_t *__pud_alloc_one(struct mm_struct *mm, unsigned long addr)
+{
+	gfp_t gfp = GFP_PGTABLE_USER;
+
+	if (mm == &init_mm)
+		gfp = GFP_PGTABLE_KERNEL;
+	return (pud_t *)get_zeroed_page(gfp);
+}
+
 #ifndef __HAVE_ARCH_PUD_ALLOC_ONE
 /**
  * pud_alloc_one - allocate a page for PUD-level page table
@@ -159,20 +168,23 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
  */
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	gfp_t gfp = GFP_PGTABLE_USER;
-
-	if (mm == &init_mm)
-		gfp = GFP_PGTABLE_KERNEL;
-	return (pud_t *)get_zeroed_page(gfp);
+	return __pud_alloc_one(mm, addr);
 }
 #endif
 
-static inline void pud_free(struct mm_struct *mm, pud_t *pud)
+static inline void __pud_free(struct mm_struct *mm, pud_t *pud)
 {
 	BUG_ON((unsigned long)pud & (PAGE_SIZE-1));
 	free_page((unsigned long)pud);
 }
 
+#ifndef __HAVE_ARCH_PUD_FREE
+static inline void pud_free(struct mm_struct *mm, pud_t *pud)
+{
+	__pud_free(mm, pud);
+}
+#endif
+
 #endif /* CONFIG_PGTABLE_LEVELS > 3 */
 
 #ifndef __HAVE_ARCH_PGD_FREE
-- 
2.32.0

