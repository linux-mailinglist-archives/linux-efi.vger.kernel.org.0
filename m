Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1088847669F
	for <lists+linux-efi@lfdr.de>; Thu, 16 Dec 2021 00:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbhLOXis (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Dec 2021 18:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbhLOXir (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Dec 2021 18:38:47 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AED1C061574;
        Wed, 15 Dec 2021 15:38:47 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id l8so23653132qtk.6;
        Wed, 15 Dec 2021 15:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OSVGDDzO92lqSQffaQhZlmWxTiRExIyh6URv1T7rZjo=;
        b=B/qQ6EVvoRVP4yi0TgPldtfEFLr8zRkoaIMoMkQOAlMyAm44EwWvCOtdojQ28v6Wj5
         ABI2RtT+g6sZPqEcnW9R8xX/3D6Msv1T2kgKrxeZMelmHbNdrtZh1p4ZnscZzcuWXSto
         SWOc54OwbOU3Mw2SyCLQW5yGDp79K4mH1VS4C7SNW3Y5bcB/LsCIInkcl9zvSPqhqIqj
         6XsxT67ccHe7+DCRrit8remd7Zafl6HHjRBJzgT47b0M/HKVp1o3JstdTDCBNkGr73u9
         ffKGCebJAtS6QJEBa5AlUHNB8Tnvr7mWusdffgauIsaRtWKjSQ8mHlUCFCfhqXyXqe3h
         qovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=OSVGDDzO92lqSQffaQhZlmWxTiRExIyh6URv1T7rZjo=;
        b=Wm+r39GfrBqjmU0CyYNG+bhAZ6tDOd0Zolyx3A8h6Pdq7bHmYExIFS5MwFMnb3kwxp
         0G9ojGMG5eAPsOz52j5tGXFxfF/hjxtTx+Jny8LzrTFYHmZK9tirEScDULWWV7qLIWnX
         aixNqturV1r6AGsfq3oqo6jvRZw9Fgh0W8j2OTcUSNxPJz81jaF5xmrzQ7XW8RCv1Jz+
         ZShPErVDxKcxFaCy0yUWmrBSU8GEYKRcC/D+xLtVg31DGMKv/Trgkjnf7i3i5OLN7GFw
         x/HxuErObpfOv0J50bvoXGBKnDzfLoPjICQ1Lu5IumGcTFnEt86m9yEnJbKX0XcWyAtG
         VINA==
X-Gm-Message-State: AOAM53022ZZlONqI6U2iUNBQF4lNtRq+/vPDGiSdK5mclqcgNkp8k8GB
        riJ2WGGSXaeZH0m6pco9Yxg=
X-Google-Smtp-Source: ABdhPJy+M1xjZQ5dwWVIj1caO5qxCq71ERl/ipxPKJtp/+/4bOHRpMH2MBRchg/9Z3Xp4EoNPCupVA==
X-Received: by 2002:a05:622a:28b:: with SMTP id z11mr14803008qtw.242.1639611526336;
        Wed, 15 Dec 2021 15:38:46 -0800 (PST)
Received: from kubuntu-laptop.. ([67.8.38.84])
        by smtp.gmail.com with ESMTPSA id j124sm1869848qkd.98.2021.12.15.15.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 15:38:46 -0800 (PST)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     ardb@kernel.org
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        fazilyildiran@gmail.com
Subject: [PATCH] efi: fix unmet dependency on CRYPTO for CRYPTO_LIB_SHA256
Date:   Wed, 15 Dec 2021 18:38:44 -0500
Message-Id: <20211215233844.164092-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When EFI_EMBEDDED_FIRMWARE is selected,
and CRYPTO is not selected,
Kbuild gives the following warning:

WARNING: unmet direct dependencies detected for CRYPTO_LIB_SHA256
  Depends on [n]: CRYPTO [=n]
  Selected by [y]:
  - EFI_EMBEDDED_FIRMWARE [=y] && EFI [=y]

This is because EFI_EMBEDDED_FIRMWARE selects CRYPTO_LIB_SHA256,
without selecting or depending on CRYPTO, despite
CRYPTO_LIB_SHA256 depending on CRYPTO.

This unmet dependency bug was detected by Kismet,
a static analysis tool for Kconfig. Please advise
if this is not the appropriate solution.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 drivers/firmware/efi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 2c3dac5ecb36..f914da9845ac 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -248,6 +248,7 @@ endmenu
 config EFI_EMBEDDED_FIRMWARE
 	bool
 	depends on EFI
+	select CRYPTO
 	select CRYPTO_LIB_SHA256
 
 config UEFI_CPER
-- 
2.32.0

