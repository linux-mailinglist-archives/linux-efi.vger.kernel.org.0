Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE57167CBEF
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jan 2023 14:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236540AbjAZNWi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 26 Jan 2023 08:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236584AbjAZNWh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 26 Jan 2023 08:22:37 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2B66951D
        for <linux-efi@vger.kernel.org>; Thu, 26 Jan 2023 05:22:36 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id c6so1793207pls.4
        for <linux-efi@vger.kernel.org>; Thu, 26 Jan 2023 05:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nb1TjdSBROKgpzfUeVaUTyHesAuYGunU6yuolHrwpSc=;
        b=IG25tEZgrlag046v1zrPHOE/87wEkDPEUGw7LgsuqaxIi9eznt61ned3E0VT6UR2yl
         8ENDLo/NNu0gtwL2QpcGj/fLYJ62gfWGfmdON2jnAIKvfu6Cko7X35bfteF90Zina7rm
         0gcl4sPN8lJqWAuipMtcMT0OtQZw2GMOaLT8PxA38Cwa/m+ZgtjbMedwalJo9VkwR1tU
         Wew6HiKrawGpNcfRzdql2OX9Q8vfnumb4jcVAwhJqKlz6Wk0KqVfZoTmLX6IFADpakJm
         oDYsdArI1rUkEO+O/tzRg7QI2f/jJZdhAN+atkFVPFVMpNdlHF3G6Bp84bC1ofgTwHRl
         630w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nb1TjdSBROKgpzfUeVaUTyHesAuYGunU6yuolHrwpSc=;
        b=4rpZ1c42/EPd8Z8WcMgiacUgrYRJy9KkSUuGY0+9lTXFwG4SVzUWGCMUiv+mmLYoPf
         nESI7lEjiRe7pOSD6hWcTI+w+X7UR8odbxh8YHR3LSG2Iw7SEXAVYe6HjvIcVVQIG0/0
         FmrTMblS2pOaan+QOh6JxPTaEb0v5rXENgXZpNApP1WOWb9NOykGJh07eBEv1/JxTjtq
         ihG8MUeP3Zd2dV70DhW9sj0ha8UZlSw7/rXVow159osMR9CRmoX7w23E9u8GQBXJy016
         Nxw8NIIbRtHYpY6rM7s1nrl3yIKD5FJysqOV4hXj10e6e3b2d/33wIDe2Qa+58fS6WeX
         bl+A==
X-Gm-Message-State: AO0yUKWEEtQd3KZD2WgBMzREZMbW+S/qb5Sgs3kEnkJoYBaya34PFa5R
        PDeaCtYC4ukusIsd8eogEw7Ncw==
X-Google-Smtp-Source: AK7set9LCkZZzzPRiJxmpocQsfdZqzBDZZ18FSGyY5me355QHzO2xZyiU9Ele7W4ZLpYWzdnELgXTQ==
X-Received: by 2002:a05:6a20:3f93:b0:b9:5fc6:9ed6 with SMTP id ay19-20020a056a203f9300b000b95fc69ed6mr1557169pzb.37.1674739355870;
        Thu, 26 Jan 2023 05:22:35 -0800 (PST)
Received: from localhost.localdomain (fp9875a45d.knge128.ap.nuro.jp. [152.117.164.93])
        by smtp.gmail.com with ESMTPSA id l6-20020a656806000000b00478dad38eacsm736047pgt.38.2023.01.26.05.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 05:22:35 -0800 (PST)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        linux-efi@vger.kernel.org
Subject: [RFC PATCH 1/2] efi: expose efivar generic ops register function
Date:   Thu, 26 Jan 2023 22:21:18 +0900
Message-Id: <20230126132120.1661-2-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230126132120.1661-1-masahisa.kojima@linaro.org>
References: <20230126132120.1661-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

Co-developed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 drivers/firmware/efi/efi.c | 12 ++++++++++++
 include/linux/efi.h        |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 52146f95d58e..4e576b62c170 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -227,6 +227,18 @@ static void generic_ops_unregister(void)
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
index 1a1adc8d3ba3..5e301c00e9b0 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1332,4 +1332,7 @@ bool efi_config_table_is_usable(const efi_guid_t *guid, unsigned long table)
 	return xen_efi_config_table_is_usable(guid, table);
 }
 
+void efivars_generic_ops_register(void);
+void efivars_generic_ops_unregister(void);
+
 #endif /* _LINUX_EFI_H */
-- 
2.30.2

