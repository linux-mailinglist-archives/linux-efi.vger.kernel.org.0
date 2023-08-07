Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F95B77187A
	for <lists+linux-efi@lfdr.de>; Mon,  7 Aug 2023 04:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjHGCyG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 6 Aug 2023 22:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjHGCyF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 6 Aug 2023 22:54:05 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90577172C
        for <linux-efi@vger.kernel.org>; Sun,  6 Aug 2023 19:54:04 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bc63ef9959so10024705ad.2
        for <linux-efi@vger.kernel.org>; Sun, 06 Aug 2023 19:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691376844; x=1691981644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGsOagw0C9AFCmrPzx7vMQmPgfV2zqYdX4uVR8HZb40=;
        b=GZtO+pdiMrxxlE325qzZ6L+M7/5l1Qd/fq9WW+bbMuTU6myRjCCraVjC10pNc+taui
         rfEFomCSKtrec/1ZiUS58tHGuYHn2de4VYaVVq6VdXlwppxAzOLAY2WW4P0nhrUrH+gf
         H9GstGBZDfvaciOMLgZanLdH820RdH2QZVLgKPmCMExyGR6vkl0KGWf+iR71Dd9obSJ/
         xyDU/Bn3Ec9ngL7m/amgzxdok9q4QMtorX/x9SEoObjuw4YLS/ecNSWidX3zNLZKsCjd
         7pE7TdZuB0HctNRdftmBEu5pME4WeHDLJPPrsNLtBKOUPcaDNTwa7K2lg2SLqdrHahi1
         srsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691376844; x=1691981644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGsOagw0C9AFCmrPzx7vMQmPgfV2zqYdX4uVR8HZb40=;
        b=kdlKyA6qMOnnYBZ8RdKjbqybToVLDfpCV+QRYJDFodDEMs1G/8l9oN+HXVc2C8+DAx
         AkZL+T2Dxw0uvgquFFyRE0vQ7bSxPMoNZdjo18R3d1NaMdN083F/e2Lhwkrdt70s0qR2
         WH30Cyo1lnbovQLCAnJ6WeQGvMQfYpC8sO1QbgVYSbNQIrDtClPYfnmwsHmXWTt3vEuU
         34hN7okKAZRVgd0YsD2lbat4scGcqRz93yAfV4Pim5DwwxosQy6GD9mpbvHg+hYDu5yr
         hC5ajgrn6AIplM/7Ih0derHMqWWT7njAKYWlU4qW69UltgbhuuNuo0P3KYiJAZdHyIPV
         H0zQ==
X-Gm-Message-State: AOJu0YwfIFjhdNgEEacT7OvXAbq1RF+eXyWhvfymGq7nOCCx7m9bXi7f
        OgkI1e7DSEEP1ZjkrNkIk8YOdg==
X-Google-Smtp-Source: AGHT+IGk6WDTHksGPaG+Srx9mpWgO6lYmaZnUI6RmhT8WBnQR5nOAL+WchaOWpnGgGl72Ee+oYdkiQ==
X-Received: by 2002:a17:902:6b89:b0:1bb:1494:f7f7 with SMTP id p9-20020a1709026b8900b001bb1494f7f7mr8251784plk.23.1691376844080;
        Sun, 06 Aug 2023 19:54:04 -0700 (PDT)
Received: from localhost ([164.70.16.189])
        by smtp.gmail.com with ESMTPSA id jj6-20020a170903048600b001b9ecee9f81sm5574953plb.129.2023.08.06.19.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 19:54:03 -0700 (PDT)
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
Subject: [PATCH v8 1/5] efi: expose efivar generic ops register function
Date:   Mon,  7 Aug 2023 11:53:38 +0900
Message-Id: <20230807025343.1939-2-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230807025343.1939-1-masahisa.kojima@linaro.org>
References: <20230807025343.1939-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
index e9004358f7bd..faea18b42c08 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1364,4 +1364,7 @@ bool efi_config_table_is_usable(const efi_guid_t *guid, unsigned long table)
 
 umode_t efi_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n);
 
+void efivars_generic_ops_register(void);
+void efivars_generic_ops_unregister(void);
+
 #endif /* _LINUX_EFI_H */
-- 
2.30.2

