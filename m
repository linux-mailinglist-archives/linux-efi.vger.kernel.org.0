Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F846323AB
	for <lists+linux-efi@lfdr.de>; Mon, 21 Nov 2022 14:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiKUNda (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 21 Nov 2022 08:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiKUNdY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 21 Nov 2022 08:33:24 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AD1A3403
        for <linux-efi@vger.kernel.org>; Mon, 21 Nov 2022 05:33:22 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id bs21so19885373wrb.4
        for <linux-efi@vger.kernel.org>; Mon, 21 Nov 2022 05:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/AZ4ygC1zrywaVeDravJh+79FfEh+MWc17/2b5dHnFI=;
        b=HhtboEGdl6Fk3OyjFtdSC0vRkGcOtA6lwHK46rnl7KucXpugcql4jfN/z4U3fxStX5
         bH2McLqqFK3nsOSLPBvF+vJ3ohKVKs8lNsZH/eCMAFqxFobjfTG4JqClqhFOx4zH4zkf
         YUieQJu9wr5pqkoiA8EApI62I7leQpVCg3C4ZDAeVktkNG6pyeP1g5XtOtoOuCYvjHoD
         OS7b6M/xJeh+UC9q6IxqM8+ttR2lSzKHLt1mtpOWTwkX4hxwHUiN0G5+oPbdPwSJYq1j
         2eAGJs1PBNr+DoWhcmuOy8MuQzq8E1CjjzIvnFmN6mNLdA94eNB2AWory4BsJUyv5Gzp
         UErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/AZ4ygC1zrywaVeDravJh+79FfEh+MWc17/2b5dHnFI=;
        b=nU8+Mu4c+/h6sYp4957o3UHlRdwoX87O49AnU2grmz85OA10gfMAoa3s/MR3QJb9eG
         KLnwWu8l9AfJzIvOEUdHxVqIQfDgWdopC4Mrj1/UEfkemQHX+XQ2p5VFduNTc/6fAElb
         SEE7eI6sX6GrEjdDfURelLHtzLITVW5KWNH5P0JjQ3zobUi/KKlIJqf1WcibHT3T5wO2
         D7XoMLBGQpLF1BYqxZCxvjd0cHj7hX53m71CMDC0EofMXVeiG+B42F7+keeif9hco77O
         wVLKiPvPop4ZbVgWG/UnUTdMA8ivqfLRJenDMtg4dvl4n7Ts2OAV8cRiMnXb6IfVgStl
         5Khg==
X-Gm-Message-State: ANoB5pl3yZYu4I5HS0g6MctAjDCOm2jvUTLgPuw6+GoZ4j+x4oCxSZP+
        2o7fQaFwqkoIrbSoaIwzh186fw==
X-Google-Smtp-Source: AA0mqf65U+hVaWTrA35GMU6HsufKw4fwTxCfsQNgEWiSbacZGQ1vytMt5Bep31zS425r88w5qPgkrg==
X-Received: by 2002:a5d:4577:0:b0:241:c9fc:71bc with SMTP id a23-20020a5d4577000000b00241c9fc71bcmr5324874wrc.317.1669037601244;
        Mon, 21 Nov 2022 05:33:21 -0800 (PST)
Received: from localhost.localdomain (lfbn-gre-1-201-46.w90-112.abo.wanadoo.fr. [90.112.163.46])
        by smtp.gmail.com with ESMTPSA id j18-20020a05600c191200b003c83465ccbfsm20332980wmq.35.2022.11.21.05.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 05:33:20 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-efi@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH] riscv: Sync efi page table's kernel mappings before switching
Date:   Mon, 21 Nov 2022 14:33:03 +0100
Message-Id: <20221121133303.1782246-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The EFI page table is initially created as a copy of the kernel page table.
With VMAP_STACK enabled, kernel stacks are allocated in the vmalloc area:
if the stack is allocated in a new PGD (one that was not present at the
moment of the efi page table creation or not synced in a previous vmalloc
fault), the kernel will take a trap when switching to the efi page table
when the vmalloc kernel stack is accessed, resulting in a kernel panic.

Fix that by updating the efi kernel mappings before switching to the efi
page table.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/efi.h     |  6 +++++-
 arch/riscv/include/asm/pgalloc.h | 11 ++++++++---
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/efi.h b/arch/riscv/include/asm/efi.h
index f74879a8f1ea..e229d7be4b66 100644
--- a/arch/riscv/include/asm/efi.h
+++ b/arch/riscv/include/asm/efi.h
@@ -10,6 +10,7 @@
 #include <asm/mmu_context.h>
 #include <asm/ptrace.h>
 #include <asm/tlbflush.h>
+#include <asm/pgalloc.h>
 
 #ifdef CONFIG_EFI
 extern void efi_init(void);
@@ -20,7 +21,10 @@ extern void efi_init(void);
 int efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md);
 int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md);
 
-#define arch_efi_call_virt_setup()      efi_virtmap_load()
+#define arch_efi_call_virt_setup()      ({		\
+		sync_kernel_mappings(efi_mm.pgd);	\
+		efi_virtmap_load();			\
+	})
 #define arch_efi_call_virt_teardown()   efi_virtmap_unload()
 
 #define ARCH_EFI_IRQ_FLAGS_MASK (SR_IE | SR_SPIE)
diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index 947f23d7b6af..59dc12b5b7e8 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -127,6 +127,13 @@ static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
 #define __p4d_free_tlb(tlb, p4d, addr)  p4d_free((tlb)->mm, p4d)
 #endif /* __PAGETABLE_PMD_FOLDED */
 
+static inline void sync_kernel_mappings(pgd_t *pgd)
+{
+	memcpy(pgd + USER_PTRS_PER_PGD,
+	       init_mm.pgd + USER_PTRS_PER_PGD,
+	       (PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
+}
+
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	pgd_t *pgd;
@@ -135,9 +142,7 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 	if (likely(pgd != NULL)) {
 		memset(pgd, 0, USER_PTRS_PER_PGD * sizeof(pgd_t));
 		/* Copy kernel mappings */
-		memcpy(pgd + USER_PTRS_PER_PGD,
-			init_mm.pgd + USER_PTRS_PER_PGD,
-			(PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
+		sync_kernel_mappings(pgd);
 	}
 	return pgd;
 }
-- 
2.37.2

