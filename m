Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC4528A1EB
	for <lists+linux-efi@lfdr.de>; Mon, 12 Aug 2019 17:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfHLPFW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 12 Aug 2019 11:05:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34512 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbfHLPFW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 12 Aug 2019 11:05:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id 31so104902190wrm.1
        for <linux-efi@vger.kernel.org>; Mon, 12 Aug 2019 08:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mw/C8Rv74Rs9Z8D8xgtIZbTZrAIiewQWsEQksFJ9Oxc=;
        b=Z4SZO6J55tcT2ZmWIyBqrjMv1mONKctnnAE4ILQAcZxQstHa+Wk1cbagSXu57FQMp9
         IoiJ6xGMm9IJGbEnxKoifCnuYujHbu8dISq6zezzED7b8AIzh4iM4yKjjkq9M9l2eFds
         CQLuReoG9vZjODg5wisvrJw/73CzG39vOjJbGefADv9LgbcoDxCMb1WyvjyfhgPMx3V4
         vr/8hlAnkiGr8pPXtYya7gEkbvjSmsGwuiUx6cwPvYICESeyumQ0GXc/Ikp5wQhGAEAV
         A1EJOE4XN9JYCMTNrWxFXViwLhOpR8oHKdZ49bMoOUq+/TsV8RCF7JWOxZc01DHs5IUX
         gA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mw/C8Rv74Rs9Z8D8xgtIZbTZrAIiewQWsEQksFJ9Oxc=;
        b=jWldOfw7gXKBKYhrLnuoGb3Ip43pEV0tjfePqnYBT+X9lpA7g19wK+bgbMJSNEClzN
         e+Gys6JF6shCrNPl73DxmBskEh15mpBsp4ZKsYSUS8+CQ2GeEqticmXfeqrALdgG9rBL
         ldgq64A8vfP+eIYfXrtFik3PoXbNkbgd8KEv/+yFkr+va7k8IWpcd485coaNGtoZQtHM
         tMt0jyh3cGa1YvxDhefz3ghvcfMv3AOgYtHb1qEQzpWWO9u33osD2JZhXLiPYLS1JTme
         XVd+4X65Qup7E9zb1SlZP9KrvZx248Nc3EwFZBHhGjAGYsQl4VRAsi497XNe2C0b63ez
         yaQQ==
X-Gm-Message-State: APjAAAVLbbT3QJmGDi/yJ0Mm0T14yBjnHJMEsGt9sIDtazuCsRTkhGHv
        aigogJ9Q0ipVdRAC7FdQTnhPNwRw46kdJA==
X-Google-Smtp-Source: APXvYqwWjxHx1e1BUKi8g6P9FEgS14HF2nq8EYmv7BaX864AqM/QgUxDzXI2ZtXnHL9JtFwyud2gqQ==
X-Received: by 2002:a05:6000:104c:: with SMTP id c12mr8401919wrx.328.1565622319728;
        Mon, 12 Aug 2019 08:05:19 -0700 (PDT)
Received: from localhost.localdomain ([2a02:587:a407:da00:1c0e:f938:89a1:8e17])
        by smtp.gmail.com with ESMTPSA id h97sm31027269wrh.74.2019.08.12.08.05.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 08:05:19 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Narendra K <Narendra.K@dell.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH 5/5] efi: cper: print AER info of PCIe fatal error
Date:   Mon, 12 Aug 2019 18:04:52 +0300
Message-Id: <20190812150452.27983-6-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190812150452.27983-1-ard.biesheuvel@linaro.org>
References: <20190812150452.27983-1-ard.biesheuvel@linaro.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Xiaofei Tan <tanxiaofei@huawei.com>

AER info of PCIe fatal error is not printed in the current driver.
Because APEI driver will panic directly for fatal error, and can't
run to the place of printing AER info.

An example log is as following:
{763}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 11
{763}[Hardware Error]: event severity: fatal
{763}[Hardware Error]:  Error 0, type: fatal
{763}[Hardware Error]:   section_type: PCIe error
{763}[Hardware Error]:   port_type: 0, PCIe end point
{763}[Hardware Error]:   version: 4.0
{763}[Hardware Error]:   command: 0x0000, status: 0x0010
{763}[Hardware Error]:   device_id: 0000:82:00.0
{763}[Hardware Error]:   slot: 0
{763}[Hardware Error]:   secondary_bus: 0x00
{763}[Hardware Error]:   vendor_id: 0x8086, device_id: 0x10fb
{763}[Hardware Error]:   class_code: 000002
Kernel panic - not syncing: Fatal hardware error!

This issue was imported by the patch, '37448adfc7ce ("aerdrv: Move
cper_print_aer() call out of interrupt context")'. To fix this issue,
this patch adds print of AER info in cper_print_pcie() for fatal error.

Here is the example log after this patch applied:
{24}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 10
{24}[Hardware Error]: event severity: fatal
{24}[Hardware Error]:  Error 0, type: fatal
{24}[Hardware Error]:   section_type: PCIe error
{24}[Hardware Error]:   port_type: 0, PCIe end point
{24}[Hardware Error]:   version: 4.0
{24}[Hardware Error]:   command: 0x0546, status: 0x4010
{24}[Hardware Error]:   device_id: 0000:01:00.0
{24}[Hardware Error]:   slot: 0
{24}[Hardware Error]:   secondary_bus: 0x00
{24}[Hardware Error]:   vendor_id: 0x15b3, device_id: 0x1019
{24}[Hardware Error]:   class_code: 000002
{24}[Hardware Error]:   aer_uncor_status: 0x00040000, aer_uncor_mask: 0x00000000
{24}[Hardware Error]:   aer_uncor_severity: 0x00062010
{24}[Hardware Error]:   TLP Header: 000000c0 01010000 00000001 00000000
Kernel panic - not syncing: Fatal hardware error!

Fixes: 37448adfc7ce ("aerdrv: Move cper_print_aer() call out of interrupt context")
Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
Reviewed-by: James Morse <james.morse@arm.com>
[ardb: put parens around terms of && operator]
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/cper.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 8fa977c7861f..addf0749dd8b 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -390,6 +390,21 @@ static void cper_print_pcie(const char *pfx, const struct cper_sec_pcie *pcie,
 		printk(
 	"%s""bridge: secondary_status: 0x%04x, control: 0x%04x\n",
 	pfx, pcie->bridge.secondary_status, pcie->bridge.control);
+
+	/* Fatal errors call __ghes_panic() before AER handler prints this */
+	if ((pcie->validation_bits & CPER_PCIE_VALID_AER_INFO) &&
+	    (gdata->error_severity & CPER_SEV_FATAL)) {
+		struct aer_capability_regs *aer;
+
+		aer = (struct aer_capability_regs *)pcie->aer_info;
+		printk("%saer_uncor_status: 0x%08x, aer_uncor_mask: 0x%08x\n",
+		       pfx, aer->uncor_status, aer->uncor_mask);
+		printk("%saer_uncor_severity: 0x%08x\n",
+		       pfx, aer->uncor_severity);
+		printk("%sTLP Header: %08x %08x %08x %08x\n", pfx,
+		       aer->header_log.dw0, aer->header_log.dw1,
+		       aer->header_log.dw2, aer->header_log.dw3);
+	}
 }
 
 static void cper_print_tstamp(const char *pfx,
-- 
2.17.1

