Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB066CD190
	for <lists+linux-efi@lfdr.de>; Wed, 29 Mar 2023 07:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjC2Fbj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Mar 2023 01:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjC2Fbg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Mar 2023 01:31:36 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A5D358E
        for <linux-efi@vger.kernel.org>; Tue, 28 Mar 2023 22:31:35 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id q19so11305985wrc.5
        for <linux-efi@vger.kernel.org>; Tue, 28 Mar 2023 22:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1680067893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znueE8Pjz+VVSGWqY7Odv2deVORd+PQf1G9dvU2f580=;
        b=RcfUdvTQifKB0+AVdk8JrXzwaJMK7YuAUA/YSj1CZ942v2C8skCQf7YhZm05RsyrBB
         B4HSFLSRrBz63LT+rYM4DoyzUKm2uGte1JmKH8/renUTipLEaoHQUHVAmwyN3w8/qk5j
         H00QzeWAI11ziHELL2oHdjOYApjcBfP2BTFqRF5oXalAE3WxwDc+4kCfca+NKq6ZF4Tw
         O5q9PHLvTF0t34WBg7Zr1zC7RybtgVm1Nooi4PcYYqQUJYU4h/zDifnGN22opyBF7GTi
         8WsqMiVm1PoYyXx1GQ4NDpmyH10auRIjgiRlN8E50jY8S1cm/pjpS0uWWIPa63rLLXJZ
         g//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680067893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=znueE8Pjz+VVSGWqY7Odv2deVORd+PQf1G9dvU2f580=;
        b=ixic54Id3KwLuMlSALfxUQo0cRPXN/xqGvdXNrWn+VXYdtiVmefggmr1eMLmavohmV
         1w7QubO16dmrWiQmd3btypL2DdRJewri66+Xl5BMPpD4L4Khx1QliQ962doRwwcwtMcF
         nz9tebmx2YLNsGixoAgRvAtEPG92Ks054j9RVRVqVC6plRIGjN8i0jz2Olm/pJPfpSA2
         LKRu0ardeYOb1WAKo9YHIuzMKLgYFPTVFN0l0QgnCs/8eefm8GT7H6UwZ6P+tN5zvvgQ
         7Pnc5JyKtAj56972yNxnpgu3ELynEzdz7LgdnUFAwpliqaSzVtZIfy0gdnlqqhCDhmKN
         jX5g==
X-Gm-Message-State: AAQBX9f6H1IwvET8HY/tJ9ai1zfyJa/di/zbjpB3pR6dCrr7sLT81BTS
        paNCLSHtW6ZS3hbpaACBravfzw==
X-Google-Smtp-Source: AKy350ZQA2X3X6P/fk/NYMnW9OxEeG65DsaOPoXSAsl+epZ0EvGOmNiFwst6GIavVoNURPbPTM+gLw==
X-Received: by 2002:a5d:4041:0:b0:2d7:a1e2:f5 with SMTP id w1-20020a5d4041000000b002d7a1e200f5mr12656353wrp.55.1680067893656;
        Tue, 28 Mar 2023 22:31:33 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id e11-20020a5d65cb000000b002c55de1c72bsm29119956wrw.62.2023.03.28.22.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 22:31:33 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Zong Li <zong.li@sifive.com>
Subject: [PATCH v2 2/4] riscv: Dump out kernel offset information on panic
Date:   Wed, 29 Mar 2023 07:29:24 +0200
Message-Id: <20230329052926.69632-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230329052926.69632-1-alexghiti@rivosinc.com>
References: <20230329052926.69632-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
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
index 376d2827e736..c6937839bbd8 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -20,6 +20,7 @@
 #include <linux/smp.h>
 #include <linux/efi.h>
 #include <linux/crash_dump.h>
+#include <linux/panic_notifier.h>
 
 #include <asm/alternative.h>
 #include <asm/cacheflush.h>
@@ -333,3 +334,27 @@ void free_initmem(void)
 
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
2.37.2

