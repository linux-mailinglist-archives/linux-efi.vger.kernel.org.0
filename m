Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8D17523F5
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jul 2023 15:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbjGMNgY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Jul 2023 09:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbjGMNgX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Jul 2023 09:36:23 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCE7213B
        for <linux-efi@vger.kernel.org>; Thu, 13 Jul 2023 06:36:10 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fb7dc16ff0so1295600e87.2
        for <linux-efi@vger.kernel.org>; Thu, 13 Jul 2023 06:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689255369; x=1691847369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxS6XaVGyfGeiOx9hXopxfMKjoMTvLr9eO536Fwx3rg=;
        b=jwVx+V0ogGkW0aEN54ZQobLLRXwn8vCBHhmodz8Ha6uj/mSvL4pdLZ9N1UPlCkvwOS
         Gkir7LIbHfOeM6TAflctVq6Gi6B3Wxg1aboYtqRpcgw1ptOVT6hNxltcITDGeaRUzjuT
         VLRMTq7sJEwGjsKRXJlRZ25bTpMJ6hQPaG5XffpYIHJfzBKFJfcdAJqftlC9m9ul0ZNx
         V4/XGUzfKtKj3IFt4E2jP2BZ3keJnlnq8oIl8cP/kt9tr8MYHxLUzW8Y+FoQOcmOHXRO
         DqXNEn78J1C9zM6dVo58oJaM25bS+5C9izq/lgjX8i0FTWeIt7e6s++yNtwzg51x0LG5
         0sYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689255369; x=1691847369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxS6XaVGyfGeiOx9hXopxfMKjoMTvLr9eO536Fwx3rg=;
        b=XzMZFo+XRjL1ONs54uwVz0ByUWx6BBO8h1XSz+hzBOjHlhQRNgBmvWaMAiy1E1R37n
         HC5hoyCbwG11aEnPELo2V5xobiyE+MGz9F6MvS18P022se7mmxSsCkBfOP5+fx7UnX9B
         rsGm/0RDhvRTzlF6dPsr8+WeYOvZeROWGQVqhnAlBQ+LdcBOM/daurwiRisQ4c4jDw1j
         emtVe8yDX8FuhAz88X25KgWLoRMM2g8hxaIq+YKwNPuqoRcXZoQg6i6g3ma7TKENou8r
         o/Wj/Fc0VRjlu19kHZK4aSBYM5SAOMPxz7WOKwP/w2jQ5+tefEjzXTYyR9TtBl4sEiSk
         cBPw==
X-Gm-Message-State: ABy/qLZEW4vr74B66/aNEUI3tPYQ9g+6PdBCjpM1P3Cn5x6JhGSMxpml
        Uk5R9Ug44v546lf+C1SHUezVYg==
X-Google-Smtp-Source: APBJJlGe1A2FQhbLQQs/bw67Zg5g5fp+vzL9/ZQNrKrsgHf72aeA8Jk91OXhzlgJpOQt412vheDiVg==
X-Received: by 2002:ac2:4546:0:b0:4fa:d522:a38e with SMTP id j6-20020ac24546000000b004fad522a38emr1204828lfm.35.1689255368674;
        Thu, 13 Jul 2023 06:36:08 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com ([93.23.19.53])
        by smtp.gmail.com with ESMTPSA id bf19-20020a0564021a5300b0051873c201a0sm4279132edb.26.2023.07.13.06.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 06:36:08 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Zong Li <zong.li@sifive.com>
Subject: [PATCH v4 2/5] riscv: Dump out kernel offset information on panic
Date:   Thu, 13 Jul 2023 15:33:58 +0200
Message-Id: <20230713133401.116506-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230713133401.116506-1-alexghiti@rivosinc.com>
References: <20230713133401.116506-1-alexghiti@rivosinc.com>
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

