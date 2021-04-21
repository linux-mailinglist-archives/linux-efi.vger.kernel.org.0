Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4563673AB
	for <lists+linux-efi@lfdr.de>; Wed, 21 Apr 2021 21:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238060AbhDUTrP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Apr 2021 15:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236672AbhDUTrP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Apr 2021 15:47:15 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42455C06138A
        for <linux-efi@vger.kernel.org>; Wed, 21 Apr 2021 12:46:40 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id j7so13825738eds.8
        for <linux-efi@vger.kernel.org>; Wed, 21 Apr 2021 12:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NH73FcWae9rxMtq6yzD0aN73DnT/UH/+Qs6UurLCK5w=;
        b=huPQRuGRUE4Y4uwKg8uFU1m47r72vEsiaumjmyowVHGX87ArF6sX78MbsPayCF1U08
         NOSegtbcqKB+r/cbPZd/DGnyBhjvcyOfexuNAD50XTomTz2d6nZGjD70o0a1yxHB+PVg
         etrx5r3cPhNKLxSNhKeekOej6PLNDnFbbu9iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NH73FcWae9rxMtq6yzD0aN73DnT/UH/+Qs6UurLCK5w=;
        b=pnj+IlqvFgO1urqesPb+Y/GCXF3zj/Inup+4IdwmNZT5eoJUvo5YbzwG8NvR/wSOK8
         7rVNSuBeeHdi/oxhL7Gd0C33Do5FUgMTu1YlnE5amgmmSt9lprLtk46M+cf/iLz+NXGi
         RghxX4A7uYbmXMgj6xRvuLOSs0Rbz0CL2cHdavlrmpxRQnBsRV3P9tuEnp7mofBHlCwA
         sqYNODLWSi14Hx7zmuNjnH9A0+7B46+7Fo+RIQwgpcPYs43Ud+zI33fdaGM80WNimR/u
         /j5kgbnaEWnPHOr8x8Ix4Lqf/TL+uNO8JliqHxYUztMFa4IeWJdhhJUyYDIhmwgWYlQM
         vnaQ==
X-Gm-Message-State: AOAM531pjxj6GrVTyPPax0r+Z7B7LdiY1qFfHq/KTN1IElKk/7yhp2a8
        leKUtVp12SWt4EpArJ7cYxyGrA==
X-Google-Smtp-Source: ABdhPJx9aQwh5QxZXn4AHbBN6O3GvLRKyoZrRwrGBsP0BnWVQmiYmHwUWBmku3ZQz43Ct3u6LmFqCw==
X-Received: by 2002:a50:fe8c:: with SMTP id d12mr40750422edt.336.1619034398879;
        Wed, 21 Apr 2021 12:46:38 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id cd14sm321684ejb.53.2021.04.21.12.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 12:46:38 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Alex Kluver <alex.kluver@hpe.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] efi: cper: fix snprintf() use in cper_dimm_err_location()
Date:   Wed, 21 Apr 2021 21:46:36 +0200
Message-Id: <20210421194636.1540448-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

snprintf() should be given the full buffer size, not one less. And it
guarantees nul-termination, so doing it manually afterwards is
pointless.

It's even potentially harmful (though probably not in practice because
CPER_REC_LEN is 256), due to the "return how much would have been
written had the buffer been big enough" semantics. I.e., if the bank
and/or device strings are long enough that the "DIMM location ..."
output gets truncated, writing to msg[n] is a buffer overflow.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/firmware/efi/cper.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index e15d484b6a5a..ea7ca74fc173 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -276,8 +276,7 @@ static int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg)
 	if (!msg || !(mem->validation_bits & CPER_MEM_VALID_MODULE_HANDLE))
 		return 0;
 
-	n = 0;
-	len = CPER_REC_LEN - 1;
+	len = CPER_REC_LEN;
 	dmi_memdev_name(mem->mem_dev_handle, &bank, &device);
 	if (bank && device)
 		n = snprintf(msg, len, "DIMM location: %s %s ", bank, device);
@@ -286,7 +285,6 @@ static int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg)
 			     "DIMM location: not present. DMI handle: 0x%.4x ",
 			     mem->mem_dev_handle);
 
-	msg[n] = '\0';
 	return n;
 }
 
-- 
2.29.2

