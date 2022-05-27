Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F258F5358BD
	for <lists+linux-efi@lfdr.de>; Fri, 27 May 2022 07:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243116AbiE0FS1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 May 2022 01:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243270AbiE0FSM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 27 May 2022 01:18:12 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C7831DD9
        for <linux-efi@vger.kernel.org>; Thu, 26 May 2022 22:18:11 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id e66so3033901pgc.8
        for <linux-efi@vger.kernel.org>; Thu, 26 May 2022 22:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P7OLahpm+kkKBEARj4VmqHAWwKE6JWuCb2y1kO4JlMo=;
        b=jbbgWDbwDxjGdcveN5opTsfLAmWPWwGxc3+eVGbfsHWg/8rWmYs56+UOro+RogMEZM
         N62nMVWsUj4S1x1EO9/sOj+RyfnNolADop36vf0W9gI0grwBEj+LHvnS7NObdOChj1fr
         pdp0MAqHt69N2PVB+On0qE0fzZJgaFk0jSAklcoSCwUR6pMoJ4N8ch2kmRJgzYicZ9g8
         nlLrckWV6F2Xf89IfGJjZxykmYvwWKkF7yBDRhpy2/xXY+McSVN22CDwjx0K6bd6/K27
         2TheHSPfI3Q1v5eelfmdXtqX1eqTBKySsvAWD35PX8QXMUzn0ASyQRVsfnxQdZU0In0w
         pjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P7OLahpm+kkKBEARj4VmqHAWwKE6JWuCb2y1kO4JlMo=;
        b=PSqiZOAfoSG3Ek9Qf8NLA4sGYwocae0UOldqi8g6FTcnPb7NiWhruhclync8bcuJ/g
         bDINY4+eJYYIt3hZrUXr3rb7iVl1rlU+/yV+lOMBulCwNjG+yAbUiaYMSWO3JGVK4a1Q
         7tADIqZvOyTEQU9D82lG4cLHf1cXUjIv9YuYjqZf9ue/zQoMSef0z7junyhP4eJgY1/q
         2onksm0vcCV7QZwnnxjvsjdXAqBSYktt01KWR8S2RcwEhswUOhN1WQujjyzltqJa18LB
         KMAcOMTn0jj+qxRQvnTjT5X1jGIn00euYooBPUDa26lS0+3Bcc3568mhUvKDJ1HWccYO
         onQw==
X-Gm-Message-State: AOAM530BASUPn34gMsLFp+SabjoXX86MVbhKggQgs/b6GaECec7eoobh
        72rqboQ0x5q8xaq2B8xbLmXGwg==
X-Google-Smtp-Source: ABdhPJyin/6mDo3jQxnY50FxpZpQL5woePXQ7wxcjU98TpEqhBp6YId9yZPThIcHY/RpYh8wXD0ktw==
X-Received: by 2002:a05:6a00:88f:b0:510:7a49:b72f with SMTP id q15-20020a056a00088f00b005107a49b72fmr41896359pfj.21.1653628691482;
        Thu, 26 May 2022 22:18:11 -0700 (PDT)
Received: from kerodipc.Dlink ([49.206.9.238])
        by smtp.gmail.com with ESMTPSA id j34-20020a634a62000000b003c14af5063fsm2459003pgl.87.2022.05.26.22.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 22:18:11 -0700 (PDT)
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
Subject: [PATCH V3 5/5] riscv/efi_stub: Add 64bit boot-hartid support on RV64
Date:   Fri, 27 May 2022 10:47:43 +0530
Message-Id: <20220527051743.2829940-6-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220527051743.2829940-1-sunilvl@ventanamicro.com>
References: <20220527051743.2829940-1-sunilvl@ventanamicro.com>
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

The boot-hartid can be a 64bit value on RV64 platforms but
the "boot-hartid" in DT is assumed to be 32bit only.

Detect the size of the "boot-hartid" in DT and use 32bit or 64bit
read appropriately.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/firmware/efi/libstub/riscv-stub.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/libstub/riscv-stub.c b/drivers/firmware/efi/libstub/riscv-stub.c
index 9e85e58d1f27..b450ebf95977 100644
--- a/drivers/firmware/efi/libstub/riscv-stub.c
+++ b/drivers/firmware/efi/libstub/riscv-stub.c
@@ -8,6 +8,7 @@
 
 #include <asm/efi.h>
 #include <asm/sections.h>
+#include <asm/unaligned.h>
 
 #include "efistub.h"
 
@@ -29,7 +30,7 @@ static int get_boot_hartid_from_fdt(void)
 {
 	const void *fdt;
 	int chosen_node, len;
-	const fdt32_t *prop;
+	const void *prop;
 
 	fdt = get_efi_config_table(DEVICE_TREE_GUID);
 	if (!fdt)
@@ -40,10 +41,16 @@ static int get_boot_hartid_from_fdt(void)
 		return -EINVAL;
 
 	prop = fdt_getprop((void *)fdt, chosen_node, "boot-hartid", &len);
-	if (!prop || len != sizeof(u32))
+	if (!prop)
+		return -EINVAL;
+
+	if (len == sizeof(u32))
+		hartid = (unsigned long) fdt32_to_cpu(*(fdt32_t *)prop);
+	else if (len == sizeof(u64))
+		hartid = (unsigned long) fdt64_to_cpu(__get_unaligned_t(fdt64_t, prop));
+	else
 		return -EINVAL;
 
-	hartid = fdt32_to_cpu(*prop);
 	return 0;
 }
 
-- 
2.25.1

