Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7798141C7C0
	for <lists+linux-efi@lfdr.de>; Wed, 29 Sep 2021 17:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344966AbhI2PDc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Sep 2021 11:03:32 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:60962
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344965AbhI2PDb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Sep 2021 11:03:31 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1D74640609
        for <linux-efi@vger.kernel.org>; Wed, 29 Sep 2021 15:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632927710;
        bh=ZHeeeZbiilEHhtw/jMIzJY6AU5jy7F+74b86hE2E++U=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=IqVMhivacICVvtfXFPLsefCxbRQycylQxHhKhEredFyZFYFT8hiY0VEJZ13lazvsy
         Gm0OaW2uGF+CFqGUwMZ25+isYdS5UeP3eF2IhVMRCd5hObxkhYH8dJcttjEKIcH/oT
         +ORiiPB32oFK1BLPvtqM9j/l/m23fP/U1/3vd7lcLnHwZGM6FSfJDZyroMoc+6Wf/y
         AzbUZVB3s9rpYLH8RxvBDdO3xMWNwWbwa0kgHKNWcrILNN3h+qAo7q23cGEfhiwcLL
         b3s5fg0JrLZQEGVUPHKeC+gSlDFoSGwSfsEXA0CfiRUNeozCt/h5OnGnUrgAiH9z2V
         mkd4aX7/TXKUw==
Received: by mail-wm1-f70.google.com with SMTP id m9-20020a05600c4f4900b003057c761567so2844116wmq.1
        for <linux-efi@vger.kernel.org>; Wed, 29 Sep 2021 08:01:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZHeeeZbiilEHhtw/jMIzJY6AU5jy7F+74b86hE2E++U=;
        b=aa+VUISiQje2NXjpnlKmxFetUsNbQparjA3NwVq2lr6fLf2PfHCOongTH5P7jd+8eN
         9awhklzInstWigYyDy1190opX1s/HlRVPjRa6d5h+jEPk2L5ykD25e0nx+txT+lEdOva
         +NmKNwLVe5nMqnYr3qMcArp8qaMOU8t958OFbp+Hp4kes5NAXPKJFou+199AsVhgcVRa
         a51wInUsdrd28VggijjPFlnUkwb0wbm3nhKXPr2wnrBgMR2Quj3qezAB8wQ1mRCzbGic
         C4zrc8HcXmgKQpdjX6mCC2gTqfJMz0DRELo5WZNKVYUVSZV6RIat9tq4pOykSQgIwjem
         BDcg==
X-Gm-Message-State: AOAM532nx0KCwEVObCPoGXYgMdMdQJBs5S3GHtnMgwGBspNaRmLlLFvm
        TvteeosN2PcaHENQb3rmGNL+1kuFgdxkNuK+U3F8tK2ID2CuR3zVTYPq1gKh4ZyYRfp2mesnQOX
        BdT26L6yHqwhHPMlyGx3HJqXA84M/lHE8zZ7aTg==
X-Received: by 2002:a05:6000:2c6:: with SMTP id o6mr377157wry.292.1632927708056;
        Wed, 29 Sep 2021 08:01:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9V/fnO21N7p3bEFVhHIvHS/0Ily74/OnTsvsnaHKo/n2patag3dfQoebfGKaZ+3ZNnDo6Og==
X-Received: by 2002:a05:6000:2c6:: with SMTP id o6mr377109wry.292.1632927707834;
        Wed, 29 Sep 2021 08:01:47 -0700 (PDT)
Received: from alex.home (lfbn-lyo-1-470-249.w2-7.abo.wanadoo.fr. [2.7.60.249])
        by smtp.gmail.com with ESMTPSA id h18sm133008wrs.75.2021.09.29.08.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 08:01:47 -0700 (PDT)
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
Subject: [PATCH v2 10/10] riscv: Allow user to downgrade to sv39 when hw supports sv48
Date:   Wed, 29 Sep 2021 16:51:13 +0200
Message-Id: <20210929145113.1935778-11-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210929145113.1935778-1-alexandre.ghiti@canonical.com>
References: <20210929145113.1935778-1-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This is made possible by using the mmu-type property of the cpu node of
the device tree.

By default, the kernel will boot with 4-level page table if the hw supports
it but it can be interesting for the user to select 3-level page table as
it is less memory consuming and faster since it requires less memory
accesses in case of a TLB miss.

Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
---
 arch/riscv/mm/init.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index a304f2b3c178..676635f5d98a 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -641,10 +641,31 @@ static void __init disable_pgtable_l4(void)
  * then read SATP to see if the configuration was taken into account
  * meaning sv48 is supported.
  */
-static __init void set_satp_mode(void)
+static __init void set_satp_mode(uintptr_t dtb_pa)
 {
 	u64 identity_satp, hw_satp;
 	uintptr_t set_satp_mode_pmd;
+	int cpus_node;
+
+	/* Check if the user asked for sv39 explicitly in the device tree */
+	cpus_node = fdt_path_offset((void *)dtb_pa, "/cpus");
+	if (cpus_node >= 0) {
+		int node;
+
+		fdt_for_each_subnode(node, (void *)dtb_pa, cpus_node) {
+			const char *mmu_type = fdt_getprop((void *)dtb_pa, node,
+					"mmu-type", NULL);
+			if (!mmu_type)
+				continue;
+
+			if (!strcmp(mmu_type, "riscv,sv39")) {
+				disable_pgtable_l4();
+				return;
+			}
+
+			break;
+		}
+	}
 
 	set_satp_mode_pmd = ((unsigned long)set_satp_mode) & PMD_MASK;
 	create_pgd_mapping(early_pg_dir,
@@ -802,7 +823,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 #endif
 
 #if defined(CONFIG_64BIT) && !defined(CONFIG_XIP_KERNEL)
-	set_satp_mode();
+	set_satp_mode(dtb_pa);
 #endif
 
 	kernel_map.va_pa_offset = PAGE_OFFSET - kernel_map.phys_addr;
-- 
2.30.2

