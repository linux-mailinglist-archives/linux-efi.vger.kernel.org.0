Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB0D14F47D
	for <lists+linux-efi@lfdr.de>; Sat, 22 Jun 2019 10:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfFVIvR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 22 Jun 2019 04:51:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43000 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfFVIvQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 22 Jun 2019 04:51:16 -0400
Received: by mail-wr1-f67.google.com with SMTP id x17so8710018wrl.9
        for <linux-efi@vger.kernel.org>; Sat, 22 Jun 2019 01:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OT8SPNHWk4z4I8Pp+icjCJXudD3ZuOCKF+jmfrUNbnE=;
        b=XDAd1wO7ZXP/gkz9tP6VaxixOwMxJNdn94LT+0YFDWEbbHwXz3J0qni/pdrkNShwW+
         iX6TbIyyRSWGcNxHBi7Rf30Oi2htKV3CxWTHG72+lG2m+eYRMeqoOF3yWEetK3cRtcH/
         JILOcF6hfHOM0geAh1PJ7P1jeMzDra6B9baC6Wn3+5/YQ77gSqHUr4+vXObVUxZUyt6t
         SzwC0XKnD5ycOhRK1hduOSRi/XLrQ8QQBgFiF19fp4ANigZM3AkbsCsgdGdgtIARiL8x
         k3ANoZz06BRD3MCxcjYdLQNoLmcwGFx8k23M/J+lCMqCN/+F0K8+1gGkz8PCFLa3va0K
         Mz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OT8SPNHWk4z4I8Pp+icjCJXudD3ZuOCKF+jmfrUNbnE=;
        b=WBZ5sSGihI/HH+Cwj3axIXxzuv36WvbF8FQoirkn6Ku9onZuaWODTImGdC/UyxGPLC
         RukI3sW5OnBMEUcZEuVtn0fljgWYd+ftkmL9ltHQ6RvapdgKgmkgdrc31+pfRambZzNM
         cD2PBH6uW98iIkKtkq6szkyMZoN3tzqtIOVbMI/daQWslZNVAFJqz9yvJke/R7pqqFrF
         g54TQ5PWUXe+Pg+mAQAzxYEbvknd5IMPgcBTfn3CH0MlBu02wF1c96EasOdu7+ftWIDn
         jPQv2+1tTg2omvlufG9zsszdkyB+83L39JO15xgQe5rLznH12dikPw9+tAoBGsA3RYE8
         qd+A==
X-Gm-Message-State: APjAAAUYcU2p9bwevsqBRB9kxyqaVBWUcdm6M/k0can7EHgOrLDCCsej
        tE6RVVZvnVUkI9/P2Xf0IbLgtxaeu2Md5t0z
X-Google-Smtp-Source: APXvYqxuk4LvffOaJ8GkE3qYxtS7zZb3EEA/mB/jdVnyU1h0V18ENYI/mpS0guMTT8+y06baPY/I/g==
X-Received: by 2002:adf:f3cc:: with SMTP id g12mr95195242wrp.149.1561193474094;
        Sat, 22 Jun 2019 01:51:14 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:4bd:3f91:4ef8:ae7e])
        by smtp.gmail.com with ESMTPSA id v15sm4863589wrt.25.2019.06.22.01.51.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Jun 2019 01:51:13 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Jonathan Richardson <jonathan.richardson@broadcom.com>,
        Luo XinanX <xinanx.luo@intel.com>,
        "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>,
        Qian Cai <cai@lca.pw>, Tian Baofeng <baofeng.tian@intel.com>
Subject: [PATCH 2/4] efi/bgrt: Drop BGRT status field reserved bits check
Date:   Sat, 22 Jun 2019 10:51:04 +0200
Message-Id: <20190622085106.24859-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190622085106.24859-1-ard.biesheuvel@linaro.org>
References: <20190622085106.24859-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

Starting with ACPI 6.2 bits 1 and 2 of the BGRT status field are no longer
reserved. These bits are now used to indicate if the image needs to be
rotated before being displayed.

The first device using these bits has now shown up (the GPD MicroPC) and
the reserved bits check causes us to reject the valid BGRT table on this
device.

Rather then changing the reserved bits check, allowing only the 2 new bits,
instead just completely remove it so that we do not end up with a similar
problem when more bits are added in the future.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/efi-bgrt.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/firmware/efi/efi-bgrt.c b/drivers/firmware/efi/efi-bgrt.c
index a2384184a7de..b07c17643210 100644
--- a/drivers/firmware/efi/efi-bgrt.c
+++ b/drivers/firmware/efi/efi-bgrt.c
@@ -47,11 +47,6 @@ void __init efi_bgrt_init(struct acpi_table_header *table)
 		       bgrt->version);
 		goto out;
 	}
-	if (bgrt->status & 0xfe) {
-		pr_notice("Ignoring BGRT: reserved status bits are non-zero %u\n",
-		       bgrt->status);
-		goto out;
-	}
 	if (bgrt->image_type != 0) {
 		pr_notice("Ignoring BGRT: invalid image type %u (expected 0)\n",
 		       bgrt->image_type);
-- 
2.20.1

