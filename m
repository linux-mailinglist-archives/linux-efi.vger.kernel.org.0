Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4483D145C53
	for <lists+linux-efi@lfdr.de>; Wed, 22 Jan 2020 20:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgAVTPB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 22 Jan 2020 14:15:01 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33075 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgAVTPB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 22 Jan 2020 14:15:01 -0500
Received: by mail-qt1-f196.google.com with SMTP id d5so491121qto.0
        for <linux-efi@vger.kernel.org>; Wed, 22 Jan 2020 11:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wcZLBHfSelzBLql9iR2p8F2YLeGA3mb8mja49ZN5f84=;
        b=J7d0NSFAdOvdf1j3I+XMD9gglB+MgxwDGbKrjQxGqVjK7ZlWBJe3XlQ+UM2YPmX2ey
         2pC5v5rFRhefoIv1YdWzENhSjJ4RIbI9phPgOlr12qlSaQKqBtrryWzNBK2rFIbd2wZh
         3MBH72tqFRpSsTashv+5PBH00zJhhzfZkzGxzB8McWgRVSi1ZUl4yGC3TzJXY+QcnYih
         8ePmwtMbjp4HR8G3S1O/s3FUWD1qpvZ5Z/tBNeWASu8vQz/1uvuMIXRV4r0IGwHaA1tf
         rGQjJpQe0rAG3jBAskRX6lg8oelt5D3h1DRvD84WAZGB7dtlzRwDQPp0RpMlYPrGxJO5
         GNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wcZLBHfSelzBLql9iR2p8F2YLeGA3mb8mja49ZN5f84=;
        b=Ip19jstUrpNRZ3yBJajfNtBHZcePPvCcY4N3uB3cvks90ptimQvSC1GL3TSRxRBRlj
         OkpLoCGMgkOkdmS+pav2MuFLy5N8jkHJ1p/SFIhUtO4N71fXjQ7OnQTuvnZA3nv6pDGZ
         qoelsUqEshwFUqFrgIJndm8Ank3Be6SHUdPuq2b0/v/f696elfVBYpULeOwQHt6NMbiK
         YlOuJ3A817L4srJjHM73bb4UfP7AJ44MuXUGMyJVz4W6RTAsOf//6KuPEq1NPrlj9+GX
         782UVVovcISNNCpQ3ksgYFrob8vjx6dogIPW/G+tBL9qM9w+WSbv9IFX6weLFFLMbus1
         BlUQ==
X-Gm-Message-State: APjAAAW+nrEBszorS9DlhHCm9zqBy8lky70SEzO0xjLDPeZ2r4coumEo
        j0FVtfA/x2aAzTubdX+/mPtxgQ==
X-Google-Smtp-Source: APXvYqwF1rSoKbNyZjLl+is8u3JtESZR7y/+4GcKotqz8S/YtN8UZsOQ4+qJJ4ecO/nonjUj8cWmvw==
X-Received: by 2002:ac8:2e4b:: with SMTP id s11mr12035146qta.389.1579720499968;
        Wed, 22 Jan 2020 11:14:59 -0800 (PST)
Received: from ovpn-123-97.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id k50sm21675998qtc.90.2020.01.22.11.14.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jan 2020 11:14:59 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     mingo@redhat.com
Cc:     ardb@kernel.org, tglx@linutronix.de, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next] efi/libstub/x86: fix an EFI server boot failure
Date:   Wed, 22 Jan 2020 14:14:30 -0500
Message-Id: <20200122191430.4888-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

x86_64 EFI systems are unable to boot due to a typo in the recent commit.

EFI config tables not found.
 -- System halted

Fixes: 796eb8d26a57 ("efi/libstub/x86: Use const attribute for efi_is_64bit()")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/x86/boot/compressed/eboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 82e26d0ff075..287393d725f0 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -32,7 +32,7 @@ __attribute_const__ bool efi_is_64bit(void)
 {
 	if (IS_ENABLED(CONFIG_EFI_MIXED))
 		return efi_is64;
-	return IS_ENABLED(CONFIG_X64_64);
+	return IS_ENABLED(CONFIG_X86_64);
 }
 
 static efi_status_t
-- 
2.21.0 (Apple Git-122.2)

