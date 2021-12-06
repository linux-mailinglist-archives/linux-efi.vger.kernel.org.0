Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC494694A6
	for <lists+linux-efi@lfdr.de>; Mon,  6 Dec 2021 12:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242061AbhLFLEO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Dec 2021 06:04:14 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:46696
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242113AbhLFLEN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Dec 2021 06:04:13 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BFCC03F19E
        for <linux-efi@vger.kernel.org>; Mon,  6 Dec 2021 11:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638788444;
        bh=LLLQM2eTCRvnVYbUZLcWpcb1BJMpiZdjxDv6AB/KJWI=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=EyX3R9zpVnZlebtsqXexPUFnD7V/chaVa7dUolt4OMPcJGgf3zwR1xK4NThl4D1Q6
         KrcI+dI4/XKdkCVyAWTpxx3cardjdj3IwfiyyfG4FeUAWUEirOMfEcyQHXlltGBjoW
         ekzkLmRGMYLK1Nco+V4f6ZW3HIqCUviwD0JQ4F2kxoZ2NSGXjgGIfjO/5/yLLkfjyp
         ibZBnrViXh0fdHrfRkRjFxO1tKNBZ4Fodfs7AtTuhtdNNuWLtfpTQdmYYB6nWFx63/
         LIOq9ltxIyyllGWMrSa1mEepXLYjrTaKkNJztY6Wnalgf1cjiJh8PY33t/41ZLvurX
         OchdcB2cBLnbA==
Received: by mail-ed1-f70.google.com with SMTP id i19-20020a05640242d300b003e7d13ebeedso8020278edc.7
        for <linux-efi@vger.kernel.org>; Mon, 06 Dec 2021 03:00:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LLLQM2eTCRvnVYbUZLcWpcb1BJMpiZdjxDv6AB/KJWI=;
        b=b4dwjort+GiCQOfMHSvto/ke5KZ46QMCbqy5VdoZJStzmhn22vk6xPfqp64oHMkSoQ
         C9eyfkl9JQ1ivfd7PFSfcBq4jFEDPKS3/Q9L6QAOAPNSr6SsmH+axn9iBsDlKoFlMG0t
         UlnhY6nISxvdZuVVsK9/GLz5cZFfAWsWBlJ1a46M7i1Kz3c09mqkcguzOUBg7EXftBN8
         jXSRzkduyHM58l7PWi2d23c4mCfLRlqO3kAO5ESwuzG8q9jdr3q05/5LzAywsla0Vr53
         d4SzqmSefUCcWnYFK2G1wfPA7Yqt5Qt2jeXtMEg6lq7cTxxUDVSdT54vJztfx2pTwLcO
         ciIg==
X-Gm-Message-State: AOAM532Tcp6mmGLwhKv3ULbSKlniKsiAb2fhKZD0ih3PM5HJWu8Jjddv
        0DShJY/xfaurqIDnroZ3JXAaB8bcOkDGzZiMEUG+/wWNfx9qVMXkBCvZudML1oTItE8xzxeYj+U
        m7jBAJMDRQz//L1YUfbG/TZyioPqL4AAkz+/fCQ==
X-Received: by 2002:a05:6000:1a41:: with SMTP id t1mr42771124wry.261.1638788433114;
        Mon, 06 Dec 2021 03:00:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyZdYEUZOPlIAH/Cikburq8WbdJN819bb7un7RTFQfzoFZY+ymdSWm8xf6/Muh02DAod5q3Cw==
X-Received: by 2002:a05:6000:1a41:: with SMTP id t1mr42771065wry.261.1638788432820;
        Mon, 06 Dec 2021 03:00:32 -0800 (PST)
Received: from localhost.localdomain (lfbn-lyo-1-470-249.w2-7.abo.wanadoo.fr. [2.7.60.249])
        by smtp.gmail.com with ESMTPSA id g198sm11262997wme.23.2021.12.06.03.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 03:00:32 -0800 (PST)
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
Subject: [PATCH v3 13/13] riscv: Allow user to downgrade to sv39 when hw supports sv48 if !KASAN
Date:   Mon,  6 Dec 2021 11:46:57 +0100
Message-Id: <20211206104657.433304-14-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211206104657.433304-1-alexandre.ghiti@canonical.com>
References: <20211206104657.433304-1-alexandre.ghiti@canonical.com>
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

This functionality requires that kasan is disabled since calling the fdt
functions that are kasan instrumented with the MMU off can't work.

Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
---
 arch/riscv/mm/init.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 28de6ea0a720..299b5a44f902 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -633,10 +633,38 @@ static void __init disable_pgtable_l4(void)
  * then read SATP to see if the configuration was taken into account
  * meaning sv48 is supported.
  */
-static __init void set_satp_mode(void)
+static __init void set_satp_mode(uintptr_t dtb_pa)
 {
 	u64 identity_satp, hw_satp;
 	uintptr_t set_satp_mode_pmd;
+#ifndef CONFIG_KASAN
+	/*
+	 * The below fdt functions are kasan instrumented, since at this point
+	 * there is no mapping for the kasan shadow memory, this can't be used
+	 * when kasan is enabled otherwise it traps.
+	 */
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
+#endif
 
 	set_satp_mode_pmd = ((unsigned long)set_satp_mode) & PMD_MASK;
 	create_pgd_mapping(early_pg_dir,
@@ -838,7 +866,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 #endif
 
 #if defined(CONFIG_64BIT) && !defined(CONFIG_XIP_KERNEL)
-	set_satp_mode();
+	set_satp_mode(dtb_pa);
 #endif
 
 	kernel_map.va_pa_offset = PAGE_OFFSET - kernel_map.phys_addr;
-- 
2.32.0

