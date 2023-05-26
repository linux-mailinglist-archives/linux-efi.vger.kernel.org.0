Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81049711C18
	for <lists+linux-efi@lfdr.de>; Fri, 26 May 2023 03:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbjEZBJF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 25 May 2023 21:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbjEZBJE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 25 May 2023 21:09:04 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4E2195
        for <linux-efi@vger.kernel.org>; Thu, 25 May 2023 18:09:02 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64d57cd373fso1192361b3a.1
        for <linux-efi@vger.kernel.org>; Thu, 25 May 2023 18:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685063342; x=1687655342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6VIqHMJjbPJ2+kSt8mFPdVYdMkgW/SzHqSQYoGPKEM=;
        b=xkKhKN48kdT1xEQO9pDlwjn0r0P+dC37CX6M4/10Wemi8mBIDIkcWf2e4DM2q+YPE+
         X6XovLHQCa4E+htGX69AMhO01E/9P7T4rNuvR2vfkRrze0o04yQVncSEC7IR99yGZ0iZ
         G9H0VL1JZDLFrbqTFZ7hLgxJEuGQfM+D5JryYZ5AcYkPf5kglpAnEF2XsVUYwqhJnWJ3
         RwaR5Vuq4hO7bT37euZS1dxA46QcJ5v/SHv0UDtMT7ewxHCOsFUV5rc459AyRNG3w5En
         usr/OHSlyt6gJBsBJDV6SwcAoiLtAQlOerBQequPnLgCLZWblRg9QBisHRlsdJRTntod
         EYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685063342; x=1687655342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G6VIqHMJjbPJ2+kSt8mFPdVYdMkgW/SzHqSQYoGPKEM=;
        b=O7R2nePXp/B9HNzlHXDu6jY/LBrbRp9/ZhuG7F33bbherjfb7wicH8IO3VfGyDzlzh
         ZLxXT9qMXZj9nxL+apNijuvK53d3dUtNAsVOZCTR7lBBeRPjJql9vDUh+JcTUtu3GeVj
         hR0vWO1OKMBDYCgSpK/B6ZEjMwO0u8g/34OL/qbgittzSiJAqLKbu3K9y93n1NZKGQqi
         HHMjjgvv81U+V3Pu7KLQzhCKLJ9xdQPDIa6lbcr1LriZf97PlM//7fi6DxTJdy5Tw6+v
         h76JhvVnFu89H2NarEQ/TplVECCrFY8Zx7mkkQJ3RR25vo6BtXOQotBLXdwfo9IBJ/nI
         9/FQ==
X-Gm-Message-State: AC+VfDyfMWR0GG435QZGbB+iw4Irc1YwagFGyCrVzjzB0mw9Z8ixleCB
        ZkPp4ssMy4+00XOnVdL6880Arg==
X-Google-Smtp-Source: ACHHUZ4xD136A4qfcrhz8/rbZPWO4pmcOrd1euNJQ+2a5PC/YpAOFZ4vFjjhRc2bfBs8PP4X1prmIA==
X-Received: by 2002:a05:6a20:548a:b0:10d:951f:58bd with SMTP id i10-20020a056a20548a00b0010d951f58bdmr140391pzk.19.1685063341787;
        Thu, 25 May 2023 18:09:01 -0700 (PDT)
Received: from localhost ([164.70.16.189])
        by smtp.gmail.com with ESMTPSA id fe22-20020a056a002f1600b0064d31ddb5e4sm1711436pfb.43.2023.05.25.18.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 18:09:01 -0700 (PDT)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        linux-efi@vger.kernel.org
Subject: [PATCH v5 1/3] efi: expose efivar generic ops register function
Date:   Fri, 26 May 2023 10:07:45 +0900
Message-Id: <20230526010748.1222-2-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230526010748.1222-1-masahisa.kojima@linaro.org>
References: <20230526010748.1222-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

