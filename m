Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C14534D0B
	for <lists+linux-efi@lfdr.de>; Thu, 26 May 2022 12:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346986AbiEZKMS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 26 May 2022 06:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346992AbiEZKMH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 26 May 2022 06:12:07 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFD225E1
        for <linux-efi@vger.kernel.org>; Thu, 26 May 2022 03:12:00 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id nn3-20020a17090b38c300b001e0e091cf03so660209pjb.1
        for <linux-efi@vger.kernel.org>; Thu, 26 May 2022 03:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2nXJi7PiDDt9d1NL5JWtAPFwSienZjCWVKHwZcbhaBc=;
        b=JOR9LUUFNgj0IhaBYyG+l5lZ0VF9aY94nwBPk8vRUqj9RK+tdsptxfK3s5B99lnFXk
         2ccRWc8trH74wUOJ225CGHcpTKEsX6ZzpUjc9JKnZV+6ZpPFVKTgKN0tMyqFUu9NIv5s
         SjbVlc6K3Cb4zoXyIamBmKjv/NuHbpn5zZE8I+rMWqlqP8gytbUKBiPlVmalQJoENPVJ
         E0Y615jRLoSaQgCZZ71FCsFsF0sAcF1J5QF36Fe7frEj/tXj+rdciwQp3nGid8lzS5kX
         D1T5HG613dqG7U8xRPU7+o3Ixt+rfgmhXvITxe1fuQ4PEweHuRsDjHSohwiIS43nevOS
         ltiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2nXJi7PiDDt9d1NL5JWtAPFwSienZjCWVKHwZcbhaBc=;
        b=3pQ8V9No2YunRLFo0fKDQLBHzFBDmkrN46Ta91A3Og7We6mDbcoWcFTUiWCvLS4w7L
         VLoFPYL0NPDNIqVfv9NhhiPXXGdHwPelIAdkoopI0FnQD7TsSO3S+KdRwVYHeQppH4lV
         G01DSOUQr+jYmFaNjaHkPaE9FtVOd4DpxbSX8gKSCO1+1eDJu/T/yUnGuA/qCcW4SNMR
         86TTtb1vwyQMiN5qxSKaHhcEgxh+OE0M0peR/F7pOzh0CDdU07+DTnFuN3g6RfYhqmJN
         zG2QLHed7kchpPM7DGxqd6YrxN6TYjZGtYRphC5WeMudbmj7zP0ojCRilkMBfhnhQij+
         JXsA==
X-Gm-Message-State: AOAM5321pFSQVF+u/FM9JY5Enf4qB9VZXpIENvB0FjgXvP+l5apVBEe9
        MF2w2hva/vROLUEUQHv55L/hlg==
X-Google-Smtp-Source: ABdhPJzk38UFvmZ2o5iGTIUaOlnX9TN0YPEZTK04SPZov7Zl3y6PwSIE61Oh2DmJjFw+uDJ03NumjQ==
X-Received: by 2002:a17:90a:408f:b0:1d1:d1ba:2abb with SMTP id l15-20020a17090a408f00b001d1d1ba2abbmr1833141pjg.152.1653559919412;
        Thu, 26 May 2022 03:11:59 -0700 (PDT)
Received: from kerodipc.Dlink ([49.206.9.238])
        by smtp.gmail.com with ESMTPSA id z17-20020a170902d55100b0015f309f14d0sm1114861plf.56.2022.05.26.03.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 03:11:59 -0700 (PDT)
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
Subject: [PATCH V2 5/5] riscv/efi_stub: Support for 64bit boot-hartid
Date:   Thu, 26 May 2022 15:41:31 +0530
Message-Id: <20220526101131.2340729-6-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220526101131.2340729-1-sunilvl@ventanamicro.com>
References: <20220526101131.2340729-1-sunilvl@ventanamicro.com>
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

The boot-hartid can be a 64bit value on RV64 platforms. Currently,
the "boot-hartid" in DT is assumed to be 32bit only. This patch
detects the size of the "boot-hartid" and uses 32bit or 64bit
FDT reads appropriately.

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

