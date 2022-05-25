Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DAA534007
	for <lists+linux-efi@lfdr.de>; Wed, 25 May 2022 17:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245017AbiEYPMX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 May 2022 11:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245066AbiEYPLu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 25 May 2022 11:11:50 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A56B0A7E
        for <linux-efi@vger.kernel.org>; Wed, 25 May 2022 08:11:41 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id q92-20020a17090a17e500b001e0817e77f6so1905798pja.5
        for <linux-efi@vger.kernel.org>; Wed, 25 May 2022 08:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qOKTXeNWDM3OWSCFHqvRVjau9Hc7oDvh7tjC+k8jq/o=;
        b=UBPZWH+TATz2VkNVjv3l2uIGgs0f1hNmfKu7UsCQSpxOzNfX5uqFHquZe8kNsXXQt3
         BBCLl7nupfFq0WQFWWHfPkBOiIa9/ew/QhkawAL+2nW1czDfTbqXjob/WnYtw5XrT+jg
         B1xb4KceFpgK1vSRD9I1CLCGHyHo03oThdHhNh8BuL19b7UyfuhcqLvsfTNVoKdHuw7z
         U7dYiJnG03VkJJdBriok+RoqEbdYmn/kJ8GgPr/WvK3g51iR00AhGx385tiqh/+cShSw
         l0MgmcAbdSlv76GMNFW5D0zhfaUPWjXU7Hq5cZ2nuurJFE+SiUluGvCiOSRw4kON6eaV
         dtzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qOKTXeNWDM3OWSCFHqvRVjau9Hc7oDvh7tjC+k8jq/o=;
        b=FREdKr5na3cSm2D44RmyoNgHtdNS2fMxBDaQKKiT7BMjyziyxv3nwGX0hTN+aPD7RK
         i6Pgr/1RWxW9NlK3FPMTZRyhu40ih30EokR54GEz0X11yK1HlTNnKPXPyftLIt/4aZA4
         rL/IiMdxTUmFGlLcu1KYojyl3A1WnfcUNgq7PYBZTnUmDbiH4P9ykRc3d5LQx+Oskp1U
         lqOviskzYoNgQMvbYPcXR2uU70x4ljy4eW3YNwv24S6VYvNhxcdDvGILi6KaLqnkA+gR
         uVy7oguYcrKEDGWP27xrpKNu0ai6fvPh0JAxcf1qkvcqMeer9UaqSAd8Txj7Uo0by4Nx
         KC0g==
X-Gm-Message-State: AOAM531xDqF/SW/+tsAXXnQGHbEjUfw6WacC03SKiPGIRxRXOsH8235v
        bvnKPm+EFnsQBjr5kICQfvcsdw==
X-Google-Smtp-Source: ABdhPJzFV9KXkmRnt8/Y7g7Ea3f3WGAs/0un5724uAJwdas6wB2yfb1D/0UbPM5JfoAR9HFPwLVd2g==
X-Received: by 2002:a17:902:d707:b0:15f:42a:bc62 with SMTP id w7-20020a170902d70700b0015f042abc62mr33373118ply.98.1653491500360;
        Wed, 25 May 2022 08:11:40 -0700 (PDT)
Received: from kerodipc.Dlink ([49.206.9.238])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902eb9000b00161b50c3db4sm9383129plg.94.2022.05.25.08.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 08:11:40 -0700 (PDT)
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
Subject: [PATCH 5/5] riscv/efi_stub: Support for 64bit boot-hartid
Date:   Wed, 25 May 2022 20:41:06 +0530
Message-Id: <20220525151106.2176147-6-sunilvl@ventanamicro.com>
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

The boot-hartid can be a 64bit value on RV64 platforms. Currently,
the "boot-hartid" in DT is assumed to be 32bit only. This patch
detects the size of the "boot-hartid" and uses 32bit or 64bit
FDT reads appropriately.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/firmware/efi/libstub/riscv-stub.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/libstub/riscv-stub.c b/drivers/firmware/efi/libstub/riscv-stub.c
index 9e85e58d1f27..d748533f1329 100644
--- a/drivers/firmware/efi/libstub/riscv-stub.c
+++ b/drivers/firmware/efi/libstub/riscv-stub.c
@@ -29,7 +29,7 @@ static int get_boot_hartid_from_fdt(void)
 {
 	const void *fdt;
 	int chosen_node, len;
-	const fdt32_t *prop;
+	const void *prop;
 
 	fdt = get_efi_config_table(DEVICE_TREE_GUID);
 	if (!fdt)
@@ -40,10 +40,16 @@ static int get_boot_hartid_from_fdt(void)
 		return -EINVAL;
 
 	prop = fdt_getprop((void *)fdt, chosen_node, "boot-hartid", &len);
-	if (!prop || len != sizeof(u32))
+	if (!prop)
+		return -EINVAL;
+
+	if (len == sizeof(u32))
+		hartid = (unsigned long) fdt32_to_cpu(*(fdt32_t *)prop);
+	else if (len == sizeof(u64))
+		hartid = (unsigned long) fdt64_to_cpu(*(fdt64_t *)prop);
+	else
 		return -EINVAL;
 
-	hartid = fdt32_to_cpu(*prop);
 	return 0;
 }
 
-- 
2.25.1

