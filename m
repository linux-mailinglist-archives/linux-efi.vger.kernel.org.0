Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F055358B5
	for <lists+linux-efi@lfdr.de>; Fri, 27 May 2022 07:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243349AbiE0FSQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 May 2022 01:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243240AbiE0FSI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 27 May 2022 01:18:08 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C7531938
        for <linux-efi@vger.kernel.org>; Thu, 26 May 2022 22:18:03 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o9-20020a17090a0a0900b001df3fc52ea7so6202067pjo.3
        for <linux-efi@vger.kernel.org>; Thu, 26 May 2022 22:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y6kuVNgzuJS/Kj6UaKHoVmtYOVzfNBOjCT817HUi7zA=;
        b=oJAxQxrd2Jt3TYFo94eMzAsBg8hvvQFF9aSeDB/A+fB8tsaMUMkb5IXJQ6HbX9tmmG
         tUSqV6uLdpCmBe0FHOICUI8YT/ufNZwQV802XZm4u4C/1nFYr++PzjYw5y3G6Zce3sWB
         F7vMcSuSqs8tppVLuq1oV/IAlVKYTyMcJB2E1dpzFsygxMNja78Uul1LhCqSOu/Ip2+I
         a3pH5HExzRPDEunHrqQRDdBYpqOvPIy6lZlf/4aS+gqLkozivrjUKEPg49r1z9BQgHGt
         sfINzzPOQ4cjOG4T3yMFHP7HeAiUzw32D2U7CUiBF384S//wJoT/oe+c9OrUV5xIXfIF
         20jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y6kuVNgzuJS/Kj6UaKHoVmtYOVzfNBOjCT817HUi7zA=;
        b=vHTnS9emmY75k/WrvrOOS78vqeDBLfuUEbUDqn+XkQUeTtKE28j7O7iue3vmugz5zz
         y4KGBcKT3i8roMTP4mcW5bY0gTpdnr2YDj48tdXxoUt9X5M/EsQWFYCbo/eUSvnxebpI
         pq9YPJm9fyIudF6J+QmW9EI5lB41pC1QA/r43+llbA9o4G0E6/Z3LBIb9nEnDB1mUHzJ
         g0tB9W94cLYH9r6jYPWQwTK7lypwwhnqA+FglxyPymzD/Jm1y/p/AlPdsKjIZk0uGZ5z
         1LtciGYXiw18dLsAAZbnUfEK9xLfjDwP4gtmTkv+mqV3S5MTOc0NHyPAVgou7Hl5cW6p
         dbqw==
X-Gm-Message-State: AOAM530YlaqywIbnqx/DB6D/n1juxeyJykMqgc7m/Cd6zJoU2cDMamBp
        qRnyfNYajjhDi6qZCibxDOCTEhzRB15MDqzd
X-Google-Smtp-Source: ABdhPJxNHAA7YtmlpCTaoLU9Je5eUyJxrNCvecvMqG8B873dWMhvfzophWQNCIAWw+WYsWH8YLAzrg==
X-Received: by 2002:a17:902:c1c6:b0:163:8394:9d34 with SMTP id c6-20020a170902c1c600b0016383949d34mr4742595plc.78.1653628683388;
        Thu, 26 May 2022 22:18:03 -0700 (PDT)
Received: from kerodipc.Dlink ([49.206.9.238])
        by smtp.gmail.com with ESMTPSA id j34-20020a634a62000000b003c14af5063fsm2459003pgl.87.2022.05.26.22.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 22:18:03 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Anup Patel <apatel@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, Sunil V L <sunil.vl@gmail.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH V3 3/5] riscv: smp: Add 64bit hartid support on RV64
Date:   Fri, 27 May 2022 10:47:41 +0530
Message-Id: <20220527051743.2829940-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220527051743.2829940-1-sunilvl@ventanamicro.com>
References: <20220527051743.2829940-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The hartid can be a 64bit value on RV64 platforms.

Modify the hartid parameter in riscv_hartid_to_cpuid() as
unsigned long so that it can hold 64bit value on RV64 platforms.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/smp.h | 4 ++--
 arch/riscv/kernel/smp.c      | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index 23170c933d73..d3443be7eedc 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -42,7 +42,7 @@ void arch_send_call_function_ipi_mask(struct cpumask *mask);
 /* Hook for the generic smp_call_function_single() routine. */
 void arch_send_call_function_single_ipi(int cpu);
 
-int riscv_hartid_to_cpuid(int hartid);
+int riscv_hartid_to_cpuid(unsigned long hartid);
 
 /* Set custom IPI operations */
 void riscv_set_ipi_ops(const struct riscv_ipi_ops *ops);
@@ -70,7 +70,7 @@ static inline void show_ipi_stats(struct seq_file *p, int prec)
 {
 }
 
-static inline int riscv_hartid_to_cpuid(int hartid)
+static inline int riscv_hartid_to_cpuid(unsigned long hartid)
 {
 	if (hartid == boot_cpu_hartid)
 		return 0;
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index b5d30ea92292..018e7dc45df6 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -47,7 +47,7 @@ static struct {
 	unsigned long bits ____cacheline_aligned;
 } ipi_data[NR_CPUS] __cacheline_aligned;
 
-int riscv_hartid_to_cpuid(int hartid)
+int riscv_hartid_to_cpuid(unsigned long hartid)
 {
 	int i;
 
@@ -55,7 +55,7 @@ int riscv_hartid_to_cpuid(int hartid)
 		if (cpuid_to_hartid_map(i) == hartid)
 			return i;
 
-	pr_err("Couldn't find cpu id for hartid [%d]\n", hartid);
+	pr_err("Couldn't find cpu id for hartid [%lu]\n", hartid);
 	return -ENOENT;
 }
 
-- 
2.25.1

