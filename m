Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623B17C7ECC
	for <lists+linux-efi@lfdr.de>; Fri, 13 Oct 2023 09:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjJMHq2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Oct 2023 03:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjJMHqZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Oct 2023 03:46:25 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA96BD
        for <linux-efi@vger.kernel.org>; Fri, 13 Oct 2023 00:46:23 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c9c5a1b87bso14652745ad.3
        for <linux-efi@vger.kernel.org>; Fri, 13 Oct 2023 00:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697183183; x=1697787983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUHrMuKSEIYnUr6cycu2qdhPfdBvJRkunGZgZ8wI0WU=;
        b=xslFL2SWi/CNbPUQ3kZj3Jyfi8wERT4y7O/SvFsREGLRdiD1pMBpVqD8mT8QHY3Xjn
         ZsykZ88QaBAUQttJhWjY0L/BYyoa6iVHExVliwxoB7Kyn7TXIP53VYjSHvD6S25wCNGv
         dCFGvn/oFZaMwjzADMlh+0v6SbdKwY6V1JTnx/34c2wKMZFoNbP1JpVU/ZeCgh6t8MH6
         BAYwXzZziW6oejlgcYPVXkvJQmJT6BNDRbfWvIvK245vgSSAgpuMEZyrxr3XUOv/KyYc
         p6IaQhwWmbrw/2qIAm9SOv3HQXggcLq9H7iwUzFGvmMFT4NFquo4WCK4/jM8d6JiWEc7
         9/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697183183; x=1697787983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BUHrMuKSEIYnUr6cycu2qdhPfdBvJRkunGZgZ8wI0WU=;
        b=xITDC8s22ljRaQTsoIGRbNExcNs35cAIXtVahPg6ZcxTyHDLa0ODfAAZGuSZr4aDeE
         2HvXO5GWKewtj2VyVkRj4WJZ4DLtiYdu5SLlHuCRqlZaa52IkNPfAGma2K2a+pkvuNcC
         zXvt89jb+B1H2JHazgXGoMl5XZQk3lBjgUW3G6cQxips4uzVVHl+Eh3VPRKCO+GJ/iw0
         7EPYQxsrtmV2xT7s97WD4isZsxGe5vPHfivZMJe9h1MNwWnQ5bO5A9Ygm8vFhA7rdZoC
         sTC/62e2lH2wk0EBfUJN1CWs4WcDEIs8/OH/GgbadEb4Og9hz6NoeDGJzzBxgflrSu9H
         KsWg==
X-Gm-Message-State: AOJu0YzzcFixv7yMqyA6F/oi7tVviEMABeWsyLoOoQqDZKE4Msn100Qz
        CXvhQmi0aYQ5GyOksfqWxmPzUg==
X-Google-Smtp-Source: AGHT+IH2z6H7/P2GvH2fYKauGA7C8L1gBLp7yJy3vsxjRNiXoEaO39MaOUpxifVVrbT+p2S/OIuY8Q==
X-Received: by 2002:a17:902:6ac4:b0:1c6:d34:5279 with SMTP id i4-20020a1709026ac400b001c60d345279mr22261943plt.13.1697183183210;
        Fri, 13 Oct 2023 00:46:23 -0700 (PDT)
Received: from localhost.localdomain (fp9875a45d.knge128.ap.nuro.jp. [152.117.164.93])
        by smtp.gmail.com with ESMTPSA id z8-20020a170903018800b001c9ccbb8fdasm3200548plg.260.2023.10.13.00.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 00:46:22 -0700 (PDT)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-efi@vger.kernel.org
Subject: [PATCH v9 1/6] efi: expose efivar generic ops register function
Date:   Fri, 13 Oct 2023 16:45:34 +0900
Message-Id: <20231013074540.8980-2-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231013074540.8980-1-masahisa.kojima@linaro.org>
References: <20231013074540.8980-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This is a preparation for supporting efivar operations
provided by other than efi subsystem.
Both register and unregister functions are exposed
so that non-efi subsystem can revert the efi generic
operation.

Acked-by: Sumit Garg <sumit.garg@linaro.org>
Co-developed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 drivers/firmware/efi/efi.c | 12 ++++++++++++
 include/linux/efi.h        |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 1599f1176842..53ae25bbb6ac 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -231,6 +231,18 @@ static void generic_ops_unregister(void)
 	efivars_unregister(&generic_efivars);
 }
 
+void efivars_generic_ops_register(void)
+{
+	generic_ops_register();
+}
+EXPORT_SYMBOL_GPL(efivars_generic_ops_register);
+
+void efivars_generic_ops_unregister(void)
+{
+	generic_ops_unregister();
+}
+EXPORT_SYMBOL_GPL(efivars_generic_ops_unregister);
+
 #ifdef CONFIG_EFI_CUSTOM_SSDT_OVERLAYS
 #define EFIVAR_SSDT_NAME_MAX	16UL
 static char efivar_ssdt[EFIVAR_SSDT_NAME_MAX] __initdata;
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 5a1e39df8b26..3ade74795ea9 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1354,4 +1354,7 @@ bool efi_config_table_is_usable(const efi_guid_t *guid, unsigned long table)
 
 umode_t efi_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n);
 
+void efivars_generic_ops_register(void);
+void efivars_generic_ops_unregister(void);
+
 #endif /* _LINUX_EFI_H */
-- 
2.30.2

