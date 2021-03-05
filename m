Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A039432E286
	for <lists+linux-efi@lfdr.de>; Fri,  5 Mar 2021 07:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbhCEGvb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Mar 2021 01:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhCEGva (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 5 Mar 2021 01:51:30 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783CDC061574
        for <linux-efi@vger.kernel.org>; Thu,  4 Mar 2021 22:51:30 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id cl21-20020a17090af695b02900c61ac0f0e9so1727981pjb.1
        for <linux-efi@vger.kernel.org>; Thu, 04 Mar 2021 22:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ylMLa5HeZunolCrxNpnLV11Rpx2fup4TKTrVHiQOU3U=;
        b=rNisq513EGCX6tfWkzogcERqNZsSkzqFclF5sVaaAfKds223kD+oHMEqP3UDlZQvvG
         O3cT/fUPoCfA+jS6hpsC1rT/tgbIG6iwUN7+eWBjaUI6zqPDMul4RUV6oV1l/2fXnF8l
         gAtN2m4uFckt0n7pbj6PlHfJMhnfzHUZmcKIblB4XW7GS5MzOPZcR5Q2vIbDS7QuwaUr
         cYngL2N6xBMxwIgddHgzYAnj8xFcgAbRHvgdkXluioGbsPO9t8DJPRCKHJKvZw3nMbEU
         Bp+cgxOh0+TlfeM/1KfIVuoHF74o5I+WAKD2tjeoJrzWLC1sRo1gpJzLP3uOpf9zDTdw
         B58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ylMLa5HeZunolCrxNpnLV11Rpx2fup4TKTrVHiQOU3U=;
        b=tMRV6aYVBIQrdF3YExCOcGQMGJWdNIQ1vcA6inCLEvRK8ZP4HO2IOovCKEp5Ysbw/e
         QpYkjjWXEuPeNE1Q32ppyUSDQZWfOWTx0RJqNLjnlZOhKI+dThnWtZpfo1dEQrIp5RGi
         3pBPUIEhlIGqiayZcVUVG6duP8XIAKL8XhO8UtpLAiZkw/iPZoTY9O7rjF9fKzjfLIv0
         WRy4/ih38BMX7CLItz1hAUEyJWgLAQ+v9Kj05Nf1shb/WSncQBicCNvAn3K1dtmcHHwd
         TSMHsDVy0J8UGeS/5SAZywKlPVcNKyCoH1PgI9y65TXaiuWoijkztWhs0SPM0on18H/C
         aJhQ==
X-Gm-Message-State: AOAM531KYfQS3tFgbx0fra+1Wc7xnm2zC1fQbd4zVtzxNp+Lfzgaw2kU
        p5NyaRCQuABpbvNZ/P35dW11Ow==
X-Google-Smtp-Source: ABdhPJy28iWsl4+zhRYFn1OA9ZMqc+2MnS79adEhS2kTGg18DVBGP1cvaMahUT5uWDForWgwDEP3Ww==
X-Received: by 2002:a17:902:7c8e:b029:e5:f70f:b7ab with SMTP id y14-20020a1709027c8eb02900e5f70fb7abmr860503pll.32.1614927090074;
        Thu, 04 Mar 2021 22:51:30 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id c4sm1472874pfo.2.2021.03.04.22.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 22:51:27 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] arm64: efi: add check for broken efi poweroff
Date:   Fri,  5 Mar 2021 14:51:20 +0800
Message-Id: <20210305065120.11355-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Poweroff via UEFI Runtime Services doesn't always work on every single
arm64 machine.  For example, on Lenovo Flex 5G laptop, it results in
a system reboot rather than shutdown.  Add a DMI check to keep such
system stay with the original poweroff method (PSCI).

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm64/kernel/efi.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index fa02efb28e88..8ae0002c72f1 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -7,6 +7,7 @@
  * Copyright (C) 2013, 2014 Linaro Ltd.
  */
 
+#include <linux/dmi.h>
 #include <linux/efi.h>
 #include <linux/init.h>
 
@@ -113,12 +114,26 @@ int __init efi_set_mapping_permissions(struct mm_struct *mm,
 				   set_permissions, md);
 }
 
+static const struct dmi_system_id efi_reboot_broken_table[] = {
+	{
+		.ident = "Lenovo Flex 5G",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "Flex 5G"),
+		},
+	},
+	{ } /* terminator */
+};
+
 /*
  * UpdateCapsule() depends on the system being shutdown via
  * ResetSystem().
  */
 bool efi_poweroff_required(void)
 {
+	if (dmi_check_system(efi_reboot_broken_table))
+		return false;
+
 	return efi_enabled(EFI_RUNTIME_SERVICES);
 }
 
-- 
2.17.1

