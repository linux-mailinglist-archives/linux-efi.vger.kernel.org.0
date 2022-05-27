Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59A85358BC
	for <lists+linux-efi@lfdr.de>; Fri, 27 May 2022 07:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243365AbiE0FSJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 May 2022 01:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243109AbiE0FSB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 27 May 2022 01:18:01 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22FB31388
        for <linux-efi@vger.kernel.org>; Thu, 26 May 2022 22:17:59 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id cs3-20020a17090af50300b001e0808b5838so3442083pjb.1
        for <linux-efi@vger.kernel.org>; Thu, 26 May 2022 22:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a527G06H+rTZVQ9Z54L95xKvwRXeKSz+Vdkmm5vxnGU=;
        b=TzZc0MO6AfCtlteb9bCnmlhRJEVJvMRF3GI1QjfK6DuAUuzHwL6zhWECRnZ2JZl1JY
         Z77nIxa0np9ZOkDHvyfgQcFFUI8ptER4ES5juS2cPeaqTUslq9lNPZC+U7FuXLRK6TWd
         Qzy9wZ479GcfvWsXR1xDEHZK6oA7zDhwdg1oONTDxoMqhfpHKcUIQmqt+549nrdZWid7
         ln0vEhIAy3enxkwU+BHpwnK85yTozOM3ylbmNXqK0dC0fv4bMhROtEtVaeyM1tW4lBXP
         PK8nbF9aa4gb1QSDcJQE5slBaG9QgWoDlQ+mHUizYCzh/JBX14DiPHQMLGLnFIvMhK9B
         342Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a527G06H+rTZVQ9Z54L95xKvwRXeKSz+Vdkmm5vxnGU=;
        b=eej195r69dvpjseTh0A6VZtg4NqOtbTS0/lH4r7J2H5ziKEcu7PNdDIIhQb+T/szXA
         OjLZHN9TJgx0aHT+hGjpOvpPZ/naYZbULql3s1IZrSZRtL1QTzlNF5s6lWfXe765MI99
         tS1XxMIvsBfCPln6h3PaQwOJXv9voGXpqQF0WWh2mqrONB9kc5H2/CizojF6bgzYGu+b
         14fXiq5ZEWcqN+ufy6ufbPzQkKOojJyUtXkvgsLGUsLkHBL0U+9uarGM7KhmIp4LhSl2
         SfaNdbn7HsFFB2VxFn6z/j2Ojx3wlivjPmdqhOCKzTZRHWki53YkRnRUWbBXJ0nsMqj1
         eepQ==
X-Gm-Message-State: AOAM533/VhZBqUjb2XTqGiHfDRpjimO4w58XufyelWw0uhE+Gqfhrp6F
        0tasQB84reUAFzSdGy91aGZbHw==
X-Google-Smtp-Source: ABdhPJww0P7BfKdwPMxOyVsREAc1pWap5/VTK+ciOW5Olpxk9SeJR3sDpMVAMRIM6moUHTH/ZUTdXw==
X-Received: by 2002:a17:902:cecc:b0:162:4d5c:3eac with SMTP id d12-20020a170902cecc00b001624d5c3eacmr15415645plg.82.1653628679351;
        Thu, 26 May 2022 22:17:59 -0700 (PDT)
Received: from kerodipc.Dlink ([49.206.9.238])
        by smtp.gmail.com with ESMTPSA id j34-20020a634a62000000b003c14af5063fsm2459003pgl.87.2022.05.26.22.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 22:17:58 -0700 (PDT)
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
        Sunil V L <sunilvl@ventanamicro.com>, stable@vger.kernel.org
Subject: [PATCH V3 2/5] riscv: spinwait: Fix hartid variable type
Date:   Fri, 27 May 2022 10:47:40 +0530
Message-Id: <20220527051743.2829940-3-sunilvl@ventanamicro.com>
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

The hartid variable is of type int but compared with
ULONG_MAX(INVALID_HARTID). This issue is fixed by changing
the hartid variable type to unsigned long.

Fixes: c78f94f35cf6 ("RISC-V: Use __cpu_up_stack/task_pointer only for spinwait method")
Cc: stable@vger.kernel.org

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kernel/cpu_ops_spinwait.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/cpu_ops_spinwait.c b/arch/riscv/kernel/cpu_ops_spinwait.c
index 346847f6c41c..3ade9152a3c7 100644
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
@@ -27,7 +27,7 @@ static void cpu_update_secondary_bootdata(unsigned int cpuid,
 	 * spinwait booting is not the recommended approach for any platforms
 	 * booting Linux in S-mode and can be disabled in the future.
 	 */
-	if (hartid == INVALID_HARTID || hartid >= NR_CPUS)
+	if (hartid == INVALID_HARTID || hartid >= (unsigned long) NR_CPUS)
 		return;
 
 	/* Make sure tidle is updated */
-- 
2.25.1

