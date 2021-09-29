Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40AD41C75D
	for <lists+linux-efi@lfdr.de>; Wed, 29 Sep 2021 16:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344767AbhI2Oyb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Sep 2021 10:54:31 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:59972
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344777AbhI2Oy1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Sep 2021 10:54:27 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 02FDC402D9
        for <linux-efi@vger.kernel.org>; Wed, 29 Sep 2021 14:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632927166;
        bh=w+ItQrTCaMVUbpdrDeVWHNI7WQYLMpa9OWlT3PsgkZk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=ZcayT8b8icToo4NFdsYBzeCyxrio+wuE4XvX8jluj2zaUGrLthRdk3yFl2m4ZVl1r
         OjwXsFnQKFHgmEmn/D9dQewKsHFRSK94aJboV5D0pArBpxFzbq2q9QLMxaxSFjjPCT
         gkJc5daEtpAoWjE1OMVfnKuCOYB+VpanDVqaaTjVEBbgn5M6XqkOgVG8DlYt6f2IUZ
         5mhSrseQ/C1dOyCKJuo+JUUTxT2VmHoqN93uWhzI63TlIMcQAhVNvxfWhDeXtuY+Ps
         U0hgH2F5c6epn4k6BZXc/I7ZtbIzOFXmJq16U7IQ8qoU2J9gWFSgwogPW0bQ+40iHl
         OpJsKtzcUKZNQ==
Received: by mail-ed1-f71.google.com with SMTP id 14-20020a508e4e000000b003d84544f33eso2717966edx.2
        for <linux-efi@vger.kernel.org>; Wed, 29 Sep 2021 07:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w+ItQrTCaMVUbpdrDeVWHNI7WQYLMpa9OWlT3PsgkZk=;
        b=6aIDAvDsfFuUg6VcoOswGmptI/NszDlSNiG0P1TFeHGk3hfNPYgaJcgajHiPtPyJuP
         V/LuH3nM3ZrAqYIc+MSyC4EYKJa510Tf3SQmGn1y1j++kr9+U2BTfwh0SqLeM4JRN5sz
         o+uuc+VNKsRCA07vD+QGQlndRcNvByfA5SFJPUbrAlZkemBaV4edrCpYnypGuS1RbLuv
         UDjLBaRR/AclGf50JVNB2Md+6o9GZpjwENkilGsyBsasszEjYzsSXSzxJphD0OkC1GTc
         8+/pUm77IGbAVyA7BuXIHhnLNhFd+rCubwtiOXjwptnRuw2cK9cIKw6eQt9USbN1SpQF
         /pCQ==
X-Gm-Message-State: AOAM532kDOP2Nv4f1krG2RqwarNWw6m57BD0UHVTy5cGNOakeja+UmNW
        GkqIwjN70GH47+6mp4pCtlT8MnXefVamj5t4J/9cOlAX17g2lOS4ryzZwbc+ItvO8g7HFj9MzzA
        Sg02OiosefXzB0/QVkJI8D2skXirgjF6qSBO3/A==
X-Received: by 2002:adf:de86:: with SMTP id w6mr253956wrl.287.1632927155214;
        Wed, 29 Sep 2021 07:52:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtHf+BUoKNP9WjhKmbVbOYrY4zs5f5NWeWpOsBJLJB1JCsonTpkjp5Ui+UI2TvrZXfYZZpmg==
X-Received: by 2002:adf:de86:: with SMTP id w6mr253923wrl.287.1632927155024;
        Wed, 29 Sep 2021 07:52:35 -0700 (PDT)
Received: from alex.home (lfbn-lyo-1-470-249.w2-7.abo.wanadoo.fr. [2.7.60.249])
        by smtp.gmail.com with ESMTPSA id k11sm104889wrn.84.2021.09.29.07.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 07:52:34 -0700 (PDT)
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        Atish Patra <Atish.Patra@wdc.com>,
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
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-efi@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Subject: [PATCH v2 01/10] riscv: Allow to dynamically define VA_BITS
Date:   Wed, 29 Sep 2021 16:51:04 +0200
Message-Id: <20210929145113.1935778-2-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210929145113.1935778-1-alexandre.ghiti@canonical.com>
References: <20210929145113.1935778-1-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

With 4-level page table folding at runtime, we don't know at compile time
the size of the virtual address space so we must set VA_BITS dynamically
so that sparsemem reserves the right amount of memory for struct pages.

Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
---
 arch/riscv/Kconfig                 | 10 ----------
 arch/riscv/include/asm/pgtable.h   | 10 ++++++++--
 arch/riscv/include/asm/sparsemem.h |  6 +++++-
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c1abbc876e5b..ee61ecae3ae0 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -145,16 +145,6 @@ config MMU
 	  Select if you want MMU-based virtualised addressing space
 	  support by paged memory management. If unsure, say 'Y'.
 
-config VA_BITS
-	int
-	default 32 if 32BIT
-	default 39 if 64BIT
-
-config PA_BITS
-	int
-	default 34 if 32BIT
-	default 56 if 64BIT
-
 config PAGE_OFFSET
 	hex
 	default 0xC0000000 if 32BIT && MAXPHYSMEM_1GB
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 39b550310ec6..e3e03226a50a 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -48,8 +48,14 @@
  * struct pages to map half the virtual address space. Then
  * position vmemmap directly below the VMALLOC region.
  */
+#ifdef CONFIG_64BIT
+#define VA_BITS		39
+#else
+#define VA_BITS		32
+#endif
+
 #define VMEMMAP_SHIFT \
-	(CONFIG_VA_BITS - PAGE_SHIFT - 1 + STRUCT_PAGE_MAX_SHIFT)
+	(VA_BITS - PAGE_SHIFT - 1 + STRUCT_PAGE_MAX_SHIFT)
 #define VMEMMAP_SIZE	BIT(VMEMMAP_SHIFT)
 #define VMEMMAP_END	(VMALLOC_START - 1)
 #define VMEMMAP_START	(VMALLOC_START - VMEMMAP_SIZE)
@@ -651,7 +657,7 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
  * and give the kernel the other (upper) half.
  */
 #ifdef CONFIG_64BIT
-#define KERN_VIRT_START	(-(BIT(CONFIG_VA_BITS)) + TASK_SIZE)
+#define KERN_VIRT_START	(-(BIT(VA_BITS)) + TASK_SIZE)
 #else
 #define KERN_VIRT_START	FIXADDR_START
 #endif
diff --git a/arch/riscv/include/asm/sparsemem.h b/arch/riscv/include/asm/sparsemem.h
index 45a7018a8118..63acaecc3374 100644
--- a/arch/riscv/include/asm/sparsemem.h
+++ b/arch/riscv/include/asm/sparsemem.h
@@ -4,7 +4,11 @@
 #define _ASM_RISCV_SPARSEMEM_H
 
 #ifdef CONFIG_SPARSEMEM
-#define MAX_PHYSMEM_BITS	CONFIG_PA_BITS
+#ifdef CONFIG_64BIT
+#define MAX_PHYSMEM_BITS	56
+#else
+#define MAX_PHYSMEM_BITS	34
+#endif /* CONFIG_64BIT */
 #define SECTION_SIZE_BITS	27
 #endif /* CONFIG_SPARSEMEM */
 
-- 
2.30.2

