Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CFB739AC3
	for <lists+linux-efi@lfdr.de>; Thu, 22 Jun 2023 10:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjFVIwX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 22 Jun 2023 04:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjFVIvw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 22 Jun 2023 04:51:52 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB45198B
        for <linux-efi@vger.kernel.org>; Thu, 22 Jun 2023 01:51:46 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b4f9583404so52500645ad.2
        for <linux-efi@vger.kernel.org>; Thu, 22 Jun 2023 01:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687423906; x=1690015906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6VIqHMJjbPJ2+kSt8mFPdVYdMkgW/SzHqSQYoGPKEM=;
        b=wqnos1kQXIlYDMwSX+DB4v+FgHGghStFMrk1XPLjd386273R+BURAt7Ta1Iv7TQvK5
         TiJ00WcIKO2Sr9SCqM+IaqTi2BcIG1NwJyPrWvmHIoZgk9vxsB0ErPuUxVhPXanU3Xsf
         7GZlt+jcPJsyZJrKOpy+9gdQgAk/wwYK4cKltuxSHDh9WOV5+h+jI1vSiQ57RO3msCqv
         Qav8Dr8HPy6oMzFquvwlJ8RnhYmpiGDZctaRuwyZXpBVgN5AhVpLFKCKLo2u665MEGPP
         Nl8EMRA1+GFp9C99J5ZzuWl+6WTThFhmb4ET83cll2ONU5bJ5KdbBEMhA/CNr+GWwTxu
         v9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687423906; x=1690015906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G6VIqHMJjbPJ2+kSt8mFPdVYdMkgW/SzHqSQYoGPKEM=;
        b=W2P3dimK7KLLqqRVvMaMlaIpOS11vfz8EQ6SIipWJmT79r884bCMp5nGLfWIL5Ca/E
         2oO4EunCx9ixDyomuk53aS5hbksSv5CQF4CAyNcvxBBhRJCLZbHmuSP0qb4TKU6CrBZt
         Jp7R59dbuJxc8m5Joz/2RhuuSzJjWxBfITk0Am2EkjqHjtQBaMIuZh+kCTcm4m47D8KT
         eMNG/e/mk3EOoNJalGP3ccc9M5m8M5qxODRn2SdJDo+h8Ga7aRGz7hecSux/28VaDv6J
         cuuAZhSJ71NAoIWRShv2XYg2SAnlJoCRxrl8oFnNgt7gVw2ZElB4EGrcls7CAxYf7hbn
         YJwQ==
X-Gm-Message-State: AC+VfDzg+QJna5Wqv/1VJkGDfK/wRpRs1xrHhm2uIIKIskSUKRoEI/qq
        xDnzolSSGum5ZmvxpKp998cwGQ==
X-Google-Smtp-Source: ACHHUZ43wKi0UadAPMlWAEUU78mMWB2pE69KCoHeXSrql+fGDV4Qijc7wD3EQtKzZbCBo55DUQ1ihA==
X-Received: by 2002:a17:902:7fce:b0:1b5:2ae4:9c7d with SMTP id t14-20020a1709027fce00b001b52ae49c7dmr16283464plb.38.1687423905985;
        Thu, 22 Jun 2023 01:51:45 -0700 (PDT)
Received: from localhost.localdomain (fp9875a45d.knge128.ap.nuro.jp. [152.117.164.93])
        by smtp.gmail.com with ESMTPSA id z6-20020a170903018600b001b02bd00c61sm4820154plg.237.2023.06.22.01.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 01:51:45 -0700 (PDT)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>, linux-efi@vger.kernel.org
Subject: [PATCH v6 1/4] efi: expose efivar generic ops register function
Date:   Thu, 22 Jun 2023 17:51:08 +0900
Message-Id: <20230622085112.1521-2-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230622085112.1521-1-masahisa.kojima@linaro.org>
References: <20230622085112.1521-1-masahisa.kojima@linaro.org>
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
index d0dfa007bffc..d108cf03e19d 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -228,6 +228,18 @@ static void generic_ops_unregister(void)
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
index bed3c92cbc31..b8ba9c5adc7a 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1349,4 +1349,7 @@ bool efi_config_table_is_usable(const efi_guid_t *guid, unsigned long table)
 	return xen_efi_config_table_is_usable(guid, table);
 }
 
+void efivars_generic_ops_register(void);
+void efivars_generic_ops_unregister(void);
+
 #endif /* _LINUX_EFI_H */
-- 
2.30.2

