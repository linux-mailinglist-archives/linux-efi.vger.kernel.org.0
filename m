Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7E33201F6
	for <lists+linux-efi@lfdr.de>; Sat, 20 Feb 2021 00:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhBSXqi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 19 Feb 2021 18:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhBSXqi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 19 Feb 2021 18:46:38 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82A4C061574;
        Fri, 19 Feb 2021 15:46:12 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id f17so7321396qkl.5;
        Fri, 19 Feb 2021 15:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hsrbvQJ8oCNo9CXns0BPOL1lI6aXXLZbq6epxOtgln0=;
        b=ROKivxjlURvR8A2s6GnL9exJeOWyHXAOqofcAJaZY0hK9Re8sL4WF9iAHkjiNcq8qo
         +PeCELKdlkxJyLjid2GPiZXYtd2zs0Qa1Usg+eVG11DV74HTB4iTl7gTYArRQ6fIddFG
         shANOrqh7y2zwpyq9TUGNMJy71I9a6HeADowD7kuOraUuorYIwZRYPlWwRyht2Rn6Rm6
         kIoq35v0Tu/0TNT2WBoaXADIcwqpl9A6GQfAT8kAUtJOTFZxymG/H3ExXThdH8JPnPq3
         64YxwsL7bZHOnxHzPBoRxhDEjIPNFxWmOqhdjepTaUWuFB54i5cvnvlhQ711RnGT+Lmi
         0HLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=hsrbvQJ8oCNo9CXns0BPOL1lI6aXXLZbq6epxOtgln0=;
        b=KMeZIwOB3STRcb6Bq3EwabYOAf3LB9Q6UbMXQmAI8E7Nm/K8zCzxS8pNujFgVrwM9C
         XmYHAIXjnzf49KwdYS1iNkfogJzkCuOPZYPZOwLMBQR51lR/6cEg7yhY9d/ReTFSltMu
         sfLCpRaEvp6RpoSOFwKTqZLQoDT78wD13YOvYMZ8f5Q/bcxCJyc3tf+A0vzx4rZH7s+k
         JAbCncOFX/DEsU4UNTXDYnPN2BaozBWYxpwhgqVF0cF+/bqApi14f/cCMw/kpe5MzGO9
         PJaYCGWJ4iu+Ax2Lorw6senYc7371ss8BUlyErzhKXrCH6egYpUev+7OdRMVdKR9Cb+y
         ha8g==
X-Gm-Message-State: AOAM533rH7k9K193nCWHlpzLbml8kFBbjFp19hmn0qwED3e4bf4TkQ5g
        ssJd+WCqfjcMdxQ59tA+WxTMeIozPpX1e5FL
X-Google-Smtp-Source: ABdhPJxrMTDP/K++udPK6ldqDWNTyJMGYNPrKGLwcn4RuHUsR6V801wezDqeRsARgfDnCCYnDHTilQ==
X-Received: by 2002:a05:620a:557:: with SMTP id o23mr12029853qko.28.1613778372191;
        Fri, 19 Feb 2021 15:46:12 -0800 (PST)
Received: from ubuntu-mate-laptop.localnet ([208.64.158.253])
        by smtp.gmail.com with ESMTPSA id f12sm7268222qkl.2.2021.02.19.15.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 15:46:11 -0800 (PST)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     ardb@kernel.org
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: firmware: fix kconfig dependency on CRYPTO
Date:   Fri, 19 Feb 2021 18:46:10 -0500
Message-ID: <3079145.qOpluECk2m@ubuntu-mate-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

commit 72304490d9df7d6af2e6851cc5762908abd52889
Author: Julian Braha <julianbraha@gmail.com>
Date:   Fri Feb 19 18:36:22 2021 -0500

    drivers: firmware: fix kconfig dependency on CRYPTO
    
    When EFI_EMBEDDED_FIRMWARE is enabled and CRYPTO is disabled,
    Kbuild gives the following warning:
    
    WARNING: unmet direct dependencies detected for CRYPTO_LIB_SHA256
      Depends on [n]: CRYPTO [=n]
      Selected by [y]:
      - EFI_EMBEDDED_FIRMWARE [=y] && EFI [=y]
    
    This is because EFI_EMBEDDED_FIRMWARE selects CRYPTO_LIB_SHA256,
    without depending on or selecting CRYPTO, despite that config option
    being subordinate to CRYPTO.
    
    Signed-off-by: Julian Braha <julianbraha@gmail.com>

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 2c3dac5ecb36..f914da9845ac 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -248,6 +248,7 @@ endmenu
 config EFI_EMBEDDED_FIRMWARE
        bool
        depends on EFI
+       select CRYPTO
        select CRYPTO_LIB_SHA256
 
 config UEFI_CPER


