Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA2D836326
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jun 2019 20:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfFESLq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 5 Jun 2019 14:11:46 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:45769 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfFESLq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 5 Jun 2019 14:11:46 -0400
Received: by mail-oi1-f201.google.com with SMTP id i6so573838oib.12
        for <linux-efi@vger.kernel.org>; Wed, 05 Jun 2019 11:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=IUDyCsceSXPXSWjwfPm5Qgx7aA6PYOLxueNpOxuiB3c=;
        b=mJbuTQhgGgNcUnwfXeomxPb44808Ea2BX9rZI0TxVGCc/SgQRSfjMpLpiKqT7ggtDv
         VAerZFzSEtT3KyL5cm2l1I0fhWJvxl3RdbY1fTN6IZ0C3eCuWrKiavQEJ5r6bYYdZ52B
         qMUqEVo5HpDLCQy+zC1DlAm6veklTHOYcHf1VsgBz5Ah8GIDn7jTrYmp8X+gOPjUuXuK
         0TB1FBMDSHT1MRZmGnXtIyw6LU246vrUjC43pHSsoE73XrkY4Ixq94Vn5nq4x8SQihUF
         kZBusYopE4G0vVoKIVkLceOgd3P6XhpL3ZZ4DXiTlLnCivCypIc4XlSpmRYQODRmDUAP
         NgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=IUDyCsceSXPXSWjwfPm5Qgx7aA6PYOLxueNpOxuiB3c=;
        b=WZnK2Fr7rRxKeotTUduKcw98gZJNVzEs06BfDGBNA0Ziv8SGxyurZn0EQcevMro4qB
         P1iZmNoPsRFBEiBAmtq6QgOlHd9AsTn+1Lda4eztQ6jPDxwiUGklVukqRHmkGKmbo6ON
         x6irSZP1ecW2JHNPXcs2ZtQPiOvZa+8nJ6CA5gHWcSPh9Ad+ItS6eVWo4jEzS7Q2Mpxt
         kEC6GTGRyWUoZ21HwUNeTAueaYxoR/O7naSVdtRfguicSBQ2hP03bEtFzGHZje3zz386
         BcwEXG5wyep3umtbWlpTCUO4XAqFnzRKydOzR1CqUX/Ym1XAV370vm18euMLRQdPZH4p
         oRpA==
X-Gm-Message-State: APjAAAXqLozhDhmKlcZQfIq3/poKEqFHSIO6kxyAx/IwBGDqtkazj/5M
        UZJlgnwoLrkxCfpDoe4Q+/V6Cn1mVGswTGTDjfy82A==
X-Google-Smtp-Source: APXvYqyduJ6HLN0q0QIElOqgaSufST5mMN3dV7e9/vaN0SqCzEomB48iPYHVUBk9gCw37BffevsMUotu3InrcNuPJ1DecQ==
X-Received: by 2002:aca:40c1:: with SMTP id n184mr5654465oia.73.1559758305705;
 Wed, 05 Jun 2019 11:11:45 -0700 (PDT)
Date:   Wed,  5 Jun 2019 11:11:40 -0700
Message-Id: <20190605181140.35559-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH] efi: Fix TPM code build failure on ARM
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        linux-efi@vger.kernel.org, ard.biesheuvel@linaro.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

asm/early_ioremap.h needs to be #included before tpm_eventlog.h in order
to ensure that early_memremap is available.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 drivers/firmware/efi/tpm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
index 0bdceb5913aa..1d3f5ca3eaaf 100644
--- a/drivers/firmware/efi/tpm.c
+++ b/drivers/firmware/efi/tpm.c
@@ -7,13 +7,12 @@
 #define TPM_MEMREMAP(start, size) early_memremap(start, size)
 #define TPM_MEMUNMAP(start, size) early_memunmap(start, size)
 
+#include <asm/early_ioremap.h>
 #include <linux/efi.h>
 #include <linux/init.h>
 #include <linux/memblock.h>
 #include <linux/tpm_eventlog.h>
 
-#include <asm/early_ioremap.h>
-
 int efi_tpm_final_log_size;
 EXPORT_SYMBOL(efi_tpm_final_log_size);
 
-- 
2.22.0.rc1.311.g5d7573a151-goog

