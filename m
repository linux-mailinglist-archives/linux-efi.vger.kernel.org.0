Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A77326B58
	for <lists+linux-efi@lfdr.de>; Sat, 27 Feb 2021 04:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhB0Dah (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 26 Feb 2021 22:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhB0Dag (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 26 Feb 2021 22:30:36 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BFBC06174A;
        Fri, 26 Feb 2021 19:29:56 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id v206so11307059qkb.3;
        Fri, 26 Feb 2021 19:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c5d+9yX8djWzr6OniWWyp1eF0oq4CO81f7/Et4QLr2Y=;
        b=lt+8w3C9pXrzvS95kNZBSeqac4sFKEV79SA61gYVPpd+Zgg0kUdpI9QBvRc/i9FXBJ
         v2mhK3D/mRSw/RaJ5/aqssbf8uprSFaUO66u1dU0VGu3SHr4V4U1YEulWysdwd1719b4
         C4sRfP4yZQbpT5YTfvlbnPD4cFcD6pAH7aCqHDFMSRSNFZc5sGI7yud2+VWjrz3L1gEu
         oks/atDPq0FvmDzZmmggVWbUkt8Yf4QtVYAKAq1CoIMny9S8s4/n7M0dlXux3tD71JtY
         4YJyCcLaSUu3NDnt1wxPGjduH/jkWvunXhcXkp1lPPykgJKZ+N+ECThZAjRWJtvvJ3EG
         eq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=c5d+9yX8djWzr6OniWWyp1eF0oq4CO81f7/Et4QLr2Y=;
        b=gY5fksewR3rI6HDOSgodyRKYBpHdrGq2jczq0RbDGiR3mcnkDzz+PBTG4yTHjovq3g
         KLsXP416nJMUj7FiigwZUtd3NVf+ogeDAexATQWZnXQITuJy7tqK+rNGXuGJEvehNOV4
         +OSSEqczF70VkWJyQsjlkp6ocRC3zTdCqzMwb7R2LYt3X439V+tqkv2ptMxvua7B2J7b
         wBvnJnsoixrRttYVqO4009Cz0fPGCvYXZOcqi8V++9YqkyYTsLq5VihMLnJnq4Xe7UPD
         d1HJEFyr1+kAYBloWhfnXNEGfZvH0/JIIjqFPadXBIFPXW9c/zDqts810y3fsbap+g6/
         igVQ==
X-Gm-Message-State: AOAM532Rf1riD8WTD0f0ckW/rdfra9fSZ2ovN0GebrIH3+SDtbgYvrJT
        SJtDIM+qZs+GFTOayx3zT4Y=
X-Google-Smtp-Source: ABdhPJxP2HGVHl+jPFirc3us57XKt1SAqfE1rQa5/D20ER2F97+09z2WdCDUT4g2Bve6a8qRPEVL6g==
X-Received: by 2002:a37:a30c:: with SMTP id m12mr3183549qke.300.1614396595626;
        Fri, 26 Feb 2021 19:29:55 -0800 (PST)
Received: from localhost.localdomain (2603-9001-0308-0800-2fc5-b80d-c946-eeda.inf6.spectrum.com. [2603:9001:308:800:2fc5:b80d:c946:eeda])
        by smtp.gmail.com with ESMTPSA id 184sm7979359qki.97.2021.02.26.19.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 19:29:55 -0800 (PST)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     ardb@kernel.org
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: firmware: efi: fix Kconfig dependency on CRYPTO
Date:   Fri, 26 Feb 2021 22:29:49 -0500
Message-Id: <20210227032949.31977-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When EFI_EMBEDDED_FIRMWARE is enabled, and CRYPTO is not enabled,
Kbuild gives the following warning:

WARNING: unmet direct dependencies detected for CRYPTO_LIB_SHA256
  Depends on [n]: CRYPTO [=n]
  Selected by [y]:
  - EFI_EMBEDDED_FIRMWARE [=y] && EFI [=y]

This is because EFI_EMBEDDED_FIRMWARE selects CRYPTO_LIB_SHA256
without selecting or depending on CRYPTO, despite CRYPTO_LIB_SHA256
depending on CRYPTO.

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
2.27.0

