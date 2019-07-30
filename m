Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED2D97B4F0
	for <lists+linux-efi@lfdr.de>; Tue, 30 Jul 2019 23:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387696AbfG3VYH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 30 Jul 2019 17:24:07 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37526 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387690AbfG3VYH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 30 Jul 2019 17:24:07 -0400
Received: by mail-qk1-f194.google.com with SMTP id d15so47631633qkl.4
        for <linux-efi@vger.kernel.org>; Tue, 30 Jul 2019 14:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=fLyVZXsTtfD1Xe1hWNe3oAIm1grhCSch4p5oOUN1k6U=;
        b=ogU3+0aYpayj2LlsZEQy0gKpRlrbB5anGsga45tY0zPJv18dr6xElrw7ZTngtw80F6
         xAysXhDMZS3bSrqmwSLvz6/FdhW7uJMmZyeYt3DjhokEphewaFV+UQ387K5X72bVy1im
         6+8r6GlpluXaC1iiYYq7j1gbDfb/a4BOM4dYFuTzjEUHBHtA1TgiUe5VJM9nslxIVzs2
         lYByorPyXH6H3+znbp+YM9ydGqdJBRzz7LTEdmctUOc/14MRWpCTQq+w8WLhByAnmL3C
         7TkvMkKta1s76Yk7Ocu3F9QstZWqfr1AM705WiFkgZwATc/GkJSAMH1tR8xeD8HZwDwS
         ubRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fLyVZXsTtfD1Xe1hWNe3oAIm1grhCSch4p5oOUN1k6U=;
        b=FZLp1jFSuB8LcJziDdQjg4z7tAClpmmDMzDV1AeYC5fJJNR6vwLouydwjFGaTe0WA1
         HMZj58VJq9mMbxN801vBH3PuGvPA6wOkTx3SyeSzQ1uozTKqlgFZkJglO/n2iQSCZyhJ
         33kP9HEDaYgF1HIGwfaiV+qD3HK4XrKZZsNSRcnYsgajMgm0VRG/fsDzbptTbV1iupp6
         dnZNE6Xux8mj9kcn+wRX9m++yY8RBFmn2jecJ40uD806X7feOieKXDBDT+r46aPK8nGN
         uV3oUGulDvFOiS8s/Ok2K/lYdLY/ZxT5QUuCsSOIKh1OSbKbO7XZF+gj3evoVbDGdiea
         v5+g==
X-Gm-Message-State: APjAAAWkj+757aq295MgSUcGnxRj84BXcGy++xbS15JnCwAob9hO5RFV
        pth9kEpBJ2JMODyzq91MEN61tmj0nnCU0A==
X-Google-Smtp-Source: APXvYqzGGzOl293rhLB2qxiR8WZ4xNszIZjsNseUBLKyYrY8Ml809POIZeuGW/8BcsF1e891maSxWg==
X-Received: by 2002:a37:6243:: with SMTP id w64mr74090146qkb.444.1564521845978;
        Tue, 30 Jul 2019 14:24:05 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id q9sm26738659qkm.63.2019.07.30.14.24.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 14:24:05 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     ard.biesheuvel@linaro.org
Cc:     will@kernel.org, catalin.marinas@arm.com,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] arm64/efi: fix variable 'si' set but not used
Date:   Tue, 30 Jul 2019 17:23:48 -0400
Message-Id: <1564521828-4528-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

GCC throws out this warning on arm64.

drivers/firmware/efi/libstub/arm-stub.c: In function 'efi_entry':
drivers/firmware/efi/libstub/arm-stub.c:132:22: warning: variable 'si'
set but not used [-Wunused-but-set-variable]

Fix it by making free_screen_info() a static inline function.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/arm64/include/asm/efi.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 8e79ce9c3f5c..76a144702586 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -105,7 +105,11 @@ static inline unsigned long efi_get_max_initrd_addr(unsigned long dram_base,
 	((protocol##_t *)instance)->f(instance, ##__VA_ARGS__)
 
 #define alloc_screen_info(x...)		&screen_info
-#define free_screen_info(x...)
+
+static inline void free_screen_info(efi_system_table_t *sys_table_arg,
+				    struct screen_info *si)
+{
+}
 
 /* redeclare as 'hidden' so the compiler will generate relative references */
 extern struct screen_info screen_info __attribute__((__visibility__("hidden")));
-- 
1.8.3.1

