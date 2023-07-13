Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D8575263F
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jul 2023 17:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbjGMPKN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Jul 2023 11:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbjGMPKJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Jul 2023 11:10:09 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9D0272E
        for <linux-efi@vger.kernel.org>; Thu, 13 Jul 2023 08:10:06 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3141c3a7547so966095f8f.2
        for <linux-efi@vger.kernel.org>; Thu, 13 Jul 2023 08:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689261005; x=1691853005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxS6XaVGyfGeiOx9hXopxfMKjoMTvLr9eO536Fwx3rg=;
        b=12G3+2Y00Sqmy3C4bHK2R4sUiuSMiHP21QdzHVQmMjgUKvRryyZ8lP4R3HAMAoanJO
         md8q9aAd47Acuc0fmNXsDZzKEQAEfWUZ+5ZTvY2oiRa4EOUJUDhMHV8RxcGqwc5aoZzi
         1BJWHAtsnqguVT2wn/jpEX/M9Zz8yzQNyD6n4oU4M7/UBXDKc5IPkFgdfS/pxy6DR69o
         aiJ2wG4wTVjVDvJ3AJ/QPf4oFV9fg4zfOb+6GnaftHgah9MEmL65yonE/OU0DSLUj9nW
         n7MgYSa0mC8KWKrfozAz11cuYBW4qjohOukU8U5wIN/4Ph02tmk/xDT+hk82OSEXhwf4
         iNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689261005; x=1691853005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxS6XaVGyfGeiOx9hXopxfMKjoMTvLr9eO536Fwx3rg=;
        b=lwgp0LA7jnyr1lryD8EGkdXyRvQTmnI7A+6QBGqvje/N4DjYqeeKRr0FpQWtylHj9x
         2z33Dv8M7ijK/SsWUHFTDGlmFgy9hgZ6rTYGaartBfrQgfqBx4FbpXaA0AA1X//x7Vs7
         C5dQ1rAybGyJXMwExYgKdLrioQJUB80Cpq5cfgK82fZ8x9J9f7aO9s9vuEQnUii+QY2R
         ZthNi6xSIiWfm1+8KKOevpj9ctFMlRGO44YSpMOCiQDrD3XM3pwCYahXSjgxbNeChDsf
         +4Vs9bZR1dLcNbgdGfakY5Bv3OBg8CFfAs7dXiofOxYdhgkBSrd3SY4xctvALQKdMM4O
         zllA==
X-Gm-Message-State: ABy/qLYjv13lrTuraYpWm9Xo0F3GU0FKBCc6Oa3e6n26wBY073dv4laT
        cQlqDX9ubo5rwWehn2xEU8al4Q==
X-Google-Smtp-Source: APBJJlEFMrP0/qw3uxLKCVQPZAJw7F36JXx2A1kJbs6oGdJIWClw3b1SF7al95mzWxvu1hXdlj929Q==
X-Received: by 2002:a05:6000:1009:b0:313:f990:c631 with SMTP id a9-20020a056000100900b00313f990c631mr1408913wrx.44.1689261004976;
        Thu, 13 Jul 2023 08:10:04 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id q14-20020adfea0e000000b003063a92bbf5sm8173091wrm.70.2023.07.13.08.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 08:10:04 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Zong Li <zong.li@sifive.com>
Subject: [PATCH RESEND v4 2/5] riscv: Dump out kernel offset information on panic
Date:   Thu, 13 Jul 2023 17:07:57 +0200
Message-Id: <20230713150800.120821-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230713150800.120821-1-alexghiti@rivosinc.com>
References: <20230713150800.120821-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Dump out the KASLR virtual kernel offset when panic to help debug kernel.

Signed-off-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/kernel/setup.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 971fe776e2f8..0fb5a26ca4cc 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -21,6 +21,7 @@
 #include <linux/smp.h>
 #include <linux/efi.h>
 #include <linux/crash_dump.h>
+#include <linux/panic_notifier.h>
 
 #include <asm/acpi.h>
 #include <asm/alternative.h>
@@ -341,3 +342,27 @@ void free_initmem(void)
 
 	free_initmem_default(POISON_FREE_INITMEM);
 }
+
+static int dump_kernel_offset(struct notifier_block *self,
+			      unsigned long v, void *p)
+{
+	pr_emerg("Kernel Offset: 0x%lx from 0x%lx\n",
+		 kernel_map.virt_offset,
+		 KERNEL_LINK_ADDR);
+
+	return 0;
+}
+
+static struct notifier_block kernel_offset_notifier = {
+	.notifier_call = dump_kernel_offset
+};
+
+static int __init register_kernel_offset_dumper(void)
+{
+	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
+		atomic_notifier_chain_register(&panic_notifier_list,
+					       &kernel_offset_notifier);
+
+	return 0;
+}
+device_initcall(register_kernel_offset_dumper);
-- 
2.39.2

