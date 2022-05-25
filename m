Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866C0533FF6
	for <lists+linux-efi@lfdr.de>; Wed, 25 May 2022 17:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbiEYPLe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 May 2022 11:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244928AbiEYPLc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 25 May 2022 11:11:32 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6FEB042E
        for <linux-efi@vger.kernel.org>; Wed, 25 May 2022 08:11:28 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id gk22so1536829pjb.1
        for <linux-efi@vger.kernel.org>; Wed, 25 May 2022 08:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oVcwfs7LaLIcj8lD0NxblPY5TrT7/xc4rcWLu0GbH70=;
        b=coceHEo+uv0xofNyutF8KiY+u4PV6Q6q9xmbXvvXEGUoUIAew/qQzpeRkD/GbADPdv
         rMRlGpgN3VAC2YJjmyNiRZWOiFsXecrEerYxZmn+m/Y5NeGUWYcDxnh8umnlU/jvMjYd
         d8sc1IlKcPL6MFLm5Vv1tMCWqG+ZVsFgOFgt6bnci0h+K0TzBhy9UY8adMbssZYWIX/F
         ZSAMTANEQJtrQainm/5YfOp+Iq7f6c0ZsiCoAjkRJy+uDdeMt88mPVyUYJkDEf7OlZeD
         sgObM/VXLGHpbKfWbhP00sd+0gSX+i/RtUWiWU+Zfi7sBZMIOpI6/LCkdgF5Wh64Opvd
         qVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oVcwfs7LaLIcj8lD0NxblPY5TrT7/xc4rcWLu0GbH70=;
        b=QohlHp4a0/hOeNOGhXmal0qYHS3LaTH16mLFbJkgXszsgsE9cT4TSwpVzwmDRL9yL3
         i6tC82fQ3pZnxFts4KF9y6S4iIgBO7xz6jfuQtE9Gp8MKkOYfh9PJiILOWCTjkTnA8rK
         ZV7zuwbywdnU3oqxfzSeulpOHJGZ68NLVsujx5NkscMPazo40lJ3+O1DZ8ZIVIFiSbSg
         l0vbLxdsQg940oYAf7ULeEQ5H5fzO2p2YutQLv6V5RY7Gu4aEyzr44+b3o5D0piFicjT
         TYMNVoJ5Vd59cI8E5v244CXjzCFk3FQdVuqgRaBDyoDskpKN3X93fHPS8wYFPdito0VP
         bd3w==
X-Gm-Message-State: AOAM532RS07Mn3GC+JsW+K7uJMIGrRg72zQeTakUvzsGiW84TTrFsE+T
        Op6jG7BXde7HCyA1hley3245GQ==
X-Google-Smtp-Source: ABdhPJxNl6pWvjOH0gmcPXnjFKnF2aho/BIbIKdow5euUMkaXYfoVmFi2m9UhxAJyH5LYHt6hHL3Gg==
X-Received: by 2002:a17:90b:4d12:b0:1e0:44a8:4a09 with SMTP id mw18-20020a17090b4d1200b001e044a84a09mr10865887pjb.189.1653491487665;
        Wed, 25 May 2022 08:11:27 -0700 (PDT)
Received: from kerodipc.Dlink ([49.206.9.238])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902eb9000b00161b50c3db4sm9383129plg.94.2022.05.25.08.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 08:11:27 -0700 (PDT)
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
Subject: [PATCH 2/5] riscv: cpu_ops_spinwait: Support for 64bit hartid
Date:   Wed, 25 May 2022 20:41:03 +0530
Message-Id: <20220525151106.2176147-3-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220525151106.2176147-1-sunilvl@ventanamicro.com>
References: <20220525151106.2176147-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The hartid can be a 64bit value on RV64 platforms. This patch modifies
the hartid variable type to unsigned long so that it can hold 64bit
value on RV64 platforms.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/riscv/kernel/cpu_ops_spinwait.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/cpu_ops_spinwait.c b/arch/riscv/kernel/cpu_ops_spinwait.c
index 346847f6c41c..51ac07514a62 100644
--- a/arch/riscv/kernel/cpu_ops_spinwait.c
+++ b/arch/riscv/kernel/cpu_ops_spinwait.c
@@ -18,7 +18,7 @@ void *__cpu_spinwait_task_pointer[NR_CPUS] __section(".data");
 static void cpu_update_secondary_bootdata(unsigned int cpuid,
 				   struct task_struct *tidle)
 {
-	int hartid = cpuid_to_hartid_map(cpuid);
+	unsigned long hartid = cpuid_to_hartid_map(cpuid);
 
 	/*
 	 * The hartid must be less than NR_CPUS to avoid out-of-bound access
-- 
2.25.1

