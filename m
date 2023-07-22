Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0C975DC9E
	for <lists+linux-efi@lfdr.de>; Sat, 22 Jul 2023 14:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjGVMlC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 22 Jul 2023 08:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjGVMlB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 22 Jul 2023 08:41:01 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8705210F4
        for <linux-efi@vger.kernel.org>; Sat, 22 Jul 2023 05:41:00 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fd190065a8so25963185e9.3
        for <linux-efi@vger.kernel.org>; Sat, 22 Jul 2023 05:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690029659; x=1690634459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxS6XaVGyfGeiOx9hXopxfMKjoMTvLr9eO536Fwx3rg=;
        b=ubHJsOakNyi6ANYSEfY1jfibGRvwTsZC06/UPIVijfttHEqAybPhZWsu6n+csh9e0l
         KaIDc/ee0jK34IeIOvDhwfUvuorT/jUT+Lc3zNxBn+AFfH+l6yOjUQS6Rd2/e9MeozK8
         jR6YwmPhQ5kiYHNZBD01SLTO+1i4GVi5HibdyOu1QDcm7enIRNuwvCmftfPhFB4ORToz
         C3U1P2sZ72Wp31FcMQjOrO914SUZBYVecMSN8Qop2CKKpKdGOgRcP2cjNUw+bUa13u7l
         pcgT1XbQw+oZgWUOaur9xb2fkMtbRtf+60eB0JYS02Rjcnqsw6yCAIkTP8eryqK7lSVB
         wLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690029659; x=1690634459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxS6XaVGyfGeiOx9hXopxfMKjoMTvLr9eO536Fwx3rg=;
        b=bWYTuiMLcVLV63LfXf3/rJqIqGhYSqe95jftHe7v8M5j48mYMth0yYlzRBmSxrk3r4
         xJflGXBDBuQxfiYOUnOMvnAROqc08hh61pAHXBfxa5AnuRzpmR9zO9pdG9ayw8D11SM/
         6QD0Ntf1UOkWjH4fozrZPgPsdKb0mEwW7g8wsnSlIxdFnnUNjBIqChMkjsT8bbq4H7JA
         UueUYvCEMTxbTp4EW54jqtpn2DF3GhWpZqRn0p2yDhUklHsSR4sl4DtcKjr0xV48dYO2
         zE66+GMn0cCbMprLBMoTsnmYTxYfFCRmFHXMiRc2MT6kx8Jzr/hnneiAd2jcWiMe5Vto
         oU8A==
X-Gm-Message-State: ABy/qLbpteNZI7l7GzZ2C73UOdt35Ws5TsYIg2k8fvVq1KfmUsHbjnmq
        CgChrr8GZbYrvCAzJT1+AZqTVg==
X-Google-Smtp-Source: APBJJlHszG7MkK5M/s+gCn2cPnro3+GaotN/R+BKeRaTosXlQG7ZToDZHwzuzw4UhADn6GJDjqPH2w==
X-Received: by 2002:a7b:ca52:0:b0:3f6:1474:905 with SMTP id m18-20020a7bca52000000b003f614740905mr3713142wml.29.1690029658973;
        Sat, 22 Jul 2023 05:40:58 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id p24-20020a1c7418000000b003fc07e17d4esm7988080wmc.2.2023.07.22.05.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 05:40:58 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Zong Li <zong.li@sifive.com>
Subject: [PATCH v6 2/5] riscv: Dump out kernel offset information on panic
Date:   Sat, 22 Jul 2023 14:38:47 +0200
Message-Id: <20230722123850.634544-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230722123850.634544-1-alexghiti@rivosinc.com>
References: <20230722123850.634544-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

