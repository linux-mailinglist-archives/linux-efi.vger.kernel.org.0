Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2806A75C067
	for <lists+linux-efi@lfdr.de>; Fri, 21 Jul 2023 09:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjGUHu6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Jul 2023 03:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjGUHu5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 Jul 2023 03:50:57 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC42711D
        for <linux-efi@vger.kernel.org>; Fri, 21 Jul 2023 00:50:55 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f95bf5c493so2632011e87.3
        for <linux-efi@vger.kernel.org>; Fri, 21 Jul 2023 00:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689925854; x=1690530654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxS6XaVGyfGeiOx9hXopxfMKjoMTvLr9eO536Fwx3rg=;
        b=FuIuG5F4egNRevOQo+6wwRSnOxo0KBD0oT8VOhBXLieWHdRBZnSiWdKZCNZg46D6AF
         AihIrzMNV/sZayu29ejj/Wyn25jK4ayzrGK7AYGp1sy1XimY3uCtC98lCdySX5aqmkc2
         Y0aXQUhWCPhyVVKWlr8NyrEX2KHmdnY0XKzJ52H0reHMRoro9nUb3zLP8jc0nfjHj1zt
         VVi+02n1jelhREmyEpgW3wEFbIDpVlB/bLdxJZ6tSxNUTyQsQSTQ7xBfwJtNMbAKnvLQ
         wUDg1mf5TWbek5N0zhZgNzIrsj2Qe7hyO0bSGX3PNeSMZkCuXqu4m11RZ3Xaudmy1Bwr
         WSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689925854; x=1690530654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxS6XaVGyfGeiOx9hXopxfMKjoMTvLr9eO536Fwx3rg=;
        b=XsVBjtgDYyaehXmx6BFhcXCgtuPmOLWh1nnb3IKKoQKk08cymWtwOkaLDGraQxkId2
         NForST7Q0QH5gueU5NDlmgOsiaV8nuyyVCNbkJOmvZYAUPnyYZ3bjhk20+cjmaC6xjqb
         vXuDpVq91zmaBBfo7e9A7oKYhHxWgQ9g3kxV6TYD8Y9A3KgJLd/zHcgkXpV4ny3fY2YR
         qbUtSTL+M371L18vtZ8P/1QeUGnuYl487xYVLY83P9x39bjSUYQPGt4kM6d9UApLNdQ6
         AjNP933/2gBvdw0A68QD+ZedjHrFij4Jfn9cS401l6rwR7ynlkkt24bGtYWlEVc9SoMr
         wRfA==
X-Gm-Message-State: ABy/qLbdk7NCWyOueDl2JmZaMYAdzUFATEzQVAG8+16qZ96BQNRo3CIo
        EqM8AGSkJkiFa9mR9mlgTfZJjg==
X-Google-Smtp-Source: APBJJlGhpT0mQ/ntHDEaEovmLhAgZBu5dcNsqDym6bEEDs/WbnY/X6NAtRB9XdQ23SlM0Tkw117j+g==
X-Received: by 2002:a19:384d:0:b0:4f8:67f0:7253 with SMTP id d13-20020a19384d000000b004f867f07253mr544009lfj.49.1689925854156;
        Fri, 21 Jul 2023 00:50:54 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id a5-20020a05600c224500b003fbc9b9699dsm2861183wmm.45.2023.07.21.00.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 00:50:53 -0700 (PDT)
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
Subject: [PATCH v5 2/5] riscv: Dump out kernel offset information on panic
Date:   Fri, 21 Jul 2023 09:48:47 +0200
Message-Id: <20230721074850.310644-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230721074850.310644-1-alexghiti@rivosinc.com>
References: <20230721074850.310644-1-alexghiti@rivosinc.com>
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

