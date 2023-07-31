Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098AD768C4A
	for <lists+linux-efi@lfdr.de>; Mon, 31 Jul 2023 08:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjGaGvC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 31 Jul 2023 02:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjGaGvB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 31 Jul 2023 02:51:01 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEA910DC
        for <linux-efi@vger.kernel.org>; Sun, 30 Jul 2023 23:50:56 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bb119be881so35394175ad.3
        for <linux-efi@vger.kernel.org>; Sun, 30 Jul 2023 23:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690786256; x=1691391056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6VIqHMJjbPJ2+kSt8mFPdVYdMkgW/SzHqSQYoGPKEM=;
        b=T5buIxyILe4ykudiAie7IlVVfBycY8Ftm1WzbRxuA1VOz32nsJkVSoCsAjGAYF/Blz
         6mwdaN0UAoPCLpZbvafanW63xvt6kO1M23c9821e8EucYj62GHbchKCcleRWaVjthlRa
         55UdVr2XknfSEU1zlIp6KXpKNFpk5grAJyvNLjdlT8B8Kor6uSuw4GVRphpJLv1vOJDn
         Z+YwsJNpQWEkatgqW3bdFV+Sq9Uu8ZrqmMTD/8DwNvZ2gldwQL7WlQMZJ911CoSt2EW8
         m6r9adnkDBfbjkriBOX5it9nKDWC5NRzZYCPdtJdaX8zXsbFiaKPFT60Lt1lFwM0tfGq
         1I9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690786256; x=1691391056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G6VIqHMJjbPJ2+kSt8mFPdVYdMkgW/SzHqSQYoGPKEM=;
        b=WvU6KYxDJdcfR262l6t6AnrJvteQvi1cvWC7JQ1JEa+/+SbzYB1Vy00pvBZDdCm6VD
         qN/T3UKuzAZB+uGE52R75bpW9udibLJzBVqTmia+EtX2S89s8Ocsrr7zAyRoZCZX7nmh
         Uy6W9ChP1UhA+FUlbSV0GV75lP+N2UDB6aRn2PXwZNgSe12dDPePsNlc05jG86keXGMU
         KVdJ+RDSj5TFcxlSRPz9/fq6n/MyLdbNEQ65qlYKkt4tipbbeQYVzonb4fBOXE//XULB
         GLQQxhg3wLlHWhKOkzDXtVlSDvJwQAtfUfgY8okfTX0JS3peghHkY1IjbxJDRlgZgjMU
         hloQ==
X-Gm-Message-State: ABy/qLaUeBN+XMvFQqYCPmzEutGRhrI5ynyFstI+pbf3TeNbQPhf3HS5
        3rL7AzgK+3DZfwj/tSjO50tNkg==
X-Google-Smtp-Source: APBJJlH6IpcE5HQnq4W0PRkuw3VfpQBbPeZRYJyG/syrIaXHu0xrFwzWjYkA1jkSisbWMDtSyfwPEQ==
X-Received: by 2002:a17:903:11d0:b0:1b8:6a09:9cf9 with SMTP id q16-20020a17090311d000b001b86a099cf9mr11263259plh.26.1690786256347;
        Sun, 30 Jul 2023 23:50:56 -0700 (PDT)
Received: from localhost.localdomain (fp9875a45d.knge128.ap.nuro.jp. [152.117.164.93])
        by smtp.gmail.com with ESMTPSA id kb14-20020a170903338e00b001b8ad8382a4sm7706245plb.216.2023.07.30.23.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 23:50:55 -0700 (PDT)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        linux-efi@vger.kernel.org
Subject: [PATCH v7 1/5] efi: expose efivar generic ops register function
Date:   Mon, 31 Jul 2023 15:50:36 +0900
Message-Id: <20230731065041.1447-2-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230731065041.1447-1-masahisa.kojima@linaro.org>
References: <20230731065041.1447-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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

