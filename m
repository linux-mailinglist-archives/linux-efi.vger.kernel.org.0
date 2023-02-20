Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAFF69C4E0
	for <lists+linux-efi@lfdr.de>; Mon, 20 Feb 2023 06:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjBTFRw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 20 Feb 2023 00:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjBTFRu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 20 Feb 2023 00:17:50 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33AACDCB
        for <linux-efi@vger.kernel.org>; Sun, 19 Feb 2023 21:17:47 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id k29so380657pgm.3
        for <linux-efi@vger.kernel.org>; Sun, 19 Feb 2023 21:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0sLDMeC85ViUoFkMg7Sog4nZA2hj3556Fo2Z4Pqw9Sk=;
        b=qW4W7ZTKa/M15bHAUtsRRLNES3oXoklpkWjqs5Fx6B9FRjBU1n5KqFhbVvQADxrnKR
         zlTi4CUlgJRb029/2MBQBpcKr3aHLxtL3RvnmCEjiNHu9ibVu/R4RQb3J/U0dnklmOET
         LoNnXaxP7mRJWKOWy73OYWkEWfrcxP0MCxpXSd2+dcVJn49NqcDJSgsEerRtdxoiJ1bi
         mo22cNfkQoqfjVKdxZKueuipxw5Wa+mWgO6UHtewlYgryoDkM0YjeeGHntXepBP3krnj
         ZEaTYgVReo8X2YkDNCcSy75di28uVLkw/9pHzprG8SZKyALbRt/++CNQUm0c1B06/8jJ
         UFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0sLDMeC85ViUoFkMg7Sog4nZA2hj3556Fo2Z4Pqw9Sk=;
        b=HgAD1+wNBGmMDCKc4ug/7qAc0twNO4L0+3YJlQAFtiBRJPEpP1fQwVaIDya6Qj+Y/G
         IkC5c54b1ScGGuCH/Int6Zo5BqorLAIrtN8mJPJaS8UggYlI2q7zkhLIe8W3JNeie4QT
         zPWILeh8Qsa8PqOPtADlIDlfYHmx7aOPhFC1xMdDyvHhR/Y5bB2kK0Bld7OOiLKNsH+Y
         4j8Zqim+qNVqnlhvPnN6uqnAd6y29ysNEaHbq07Ow0Ws1sG2e7prSKlr+Jkxt+O5Ypqt
         5Xl3lZziw0WblSrMtGzrugr9c5cr7WD+XE3DuZ3DRINiqXvPo+OB/MgU3hOsj832PBS8
         Eb0A==
X-Gm-Message-State: AO0yUKWAAv9qdCYaXYKDKQOZSL/wh73DK9HtczR1duYH6kJmRX4woKTx
        cyS8v2BgPOld/AijVyqy3Rbaug==
X-Google-Smtp-Source: AK7set9jfzBy1Ucif/YWh1VbkaJWKNpBKxF0ncP18jRXBZW3PqENp5hXsEe6rOPC6ESvPGkAS/700Q==
X-Received: by 2002:aa7:8f1d:0:b0:5a9:9ed0:164 with SMTP id x29-20020aa78f1d000000b005a99ed00164mr1261190pfr.32.1676870267106;
        Sun, 19 Feb 2023 21:17:47 -0800 (PST)
Received: from localhost.localdomain (fp9875a45d.knge128.ap.nuro.jp. [152.117.164.93])
        by smtp.gmail.com with ESMTPSA id h5-20020a62b405000000b005ae8e94b0d5sm3192087pfn.107.2023.02.19.21.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 21:17:46 -0800 (PST)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        linux-efi@vger.kernel.org
Subject: [PATCH v2 1/4] efi: expose efivar generic ops register function
Date:   Mon, 20 Feb 2023 14:17:19 +0900
Message-Id: <20230220051723.1257-2-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230220051723.1257-1-masahisa.kojima@linaro.org>
References: <20230220051723.1257-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 4bb30434ee4a..abaf77773bdd 100644
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
index df88786b5947..7e5239da87bf 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1336,4 +1336,7 @@ bool efi_config_table_is_usable(const efi_guid_t *guid, unsigned long table)
 	return xen_efi_config_table_is_usable(guid, table);
 }
 
+void efivars_generic_ops_register(void);
+void efivars_generic_ops_unregister(void);
+
 #endif /* _LINUX_EFI_H */
-- 
2.30.2

