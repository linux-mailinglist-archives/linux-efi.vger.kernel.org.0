Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 859B111D8A1
	for <lists+linux-efi@lfdr.de>; Thu, 12 Dec 2019 22:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731124AbfLLVet (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Dec 2019 16:34:49 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45823 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731086AbfLLVet (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 Dec 2019 16:34:49 -0500
Received: by mail-qk1-f194.google.com with SMTP id x1so13653qkl.12
        for <linux-efi@vger.kernel.org>; Thu, 12 Dec 2019 13:34:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c3tkn42XWsicwXT+a84kLRsm8bcBCKmboTtzST1zPs8=;
        b=SPk7JCJrWQYMotuwnT7emQTpIoOcjaqWx06djKZtCGLgqNY/PM+ykeEfL50APGo5Ss
         pQaZpIC2dHo8gKDGc/Kft49hq3ajzRU0Xc0HtjCancTx6Rj4IqXAHMyq8T4T26tFt9+x
         bpewu1nRv4UCIzd5tMGnCOrEhfHAWJKR3tCIvo2qBPr3Ydh4wLUZUMPYoY0XT3y2HNAD
         1w5hbMbtHiAqYI6WIw8Bg4hZPJN5Yhy4iIGiBgs4472oS1tFD8u0CYhAIiQ54vqABvkT
         HkmaHZnayfFku1UB1g6fE35BCBz/FKCVYC3Ek5aenVi0SIGYbiVTaXqJ5eNafaySJIVm
         8zNA==
X-Gm-Message-State: APjAAAWYr0Ek+aGB42eH8x94XclAzCzEbLbkwmZZDymCvOuR22ER1GHk
        AYKJ5UTs8ifMkf3Hw9SBu2y6BmYD
X-Google-Smtp-Source: APXvYqzr+8hWfV+AwWnryKdiQwmU56Xr7R+zdeNSnv/lp4HD5rMZK/Nn9Fw7+zaocAzSgq/Mm2q5Wg==
X-Received: by 2002:ae9:f016:: with SMTP id l22mr10443751qkg.101.1576186488715;
        Thu, 12 Dec 2019 13:34:48 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id r5sm2116467qkf.44.2019.12.12.13.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 13:34:48 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [RFC PATCH 5/5] efi/gop: Check that the framebuffer will be accessible
Date:   Thu, 12 Dec 2019 16:34:43 -0500
Message-Id: <20191212213443.24128-6-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191212213443.24128-1-nivedita@alum.mit.edu>
References: <20191212213443.24128-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

If phys_addr_t is only 32 bits, but we somehow have a framebuffer above
4G, we can't access it, and if we let it through, the address will get
silently truncated later. So check to make sure the framebuffer base
fits in phys_addr_t.

Also remove the unnecessary cast of fb_base to u64, as it is already a
64-bit type, and all the cast could have done was truncate it on a
32-bit system.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/gop.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index 94045ab7dd3d..8cce20ff4437 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -7,6 +7,7 @@
 
 #include <linux/efi.h>
 #include <linux/screen_info.h>
+#include <linux/types.h>
 #include <asm/efi.h>
 #include <asm/setup.h>
 
@@ -132,7 +133,8 @@ setup_gop(efi_system_table_t *sys_table_arg, struct screen_info *si,
 		current_fb_base = efi_gop_attr(_mode, frame_buffer_base, mode);
 
 		if ((!first_gop || conout_found) &&
-		    info->pixel_format != PIXEL_BLT_ONLY) {
+		    info->pixel_format != PIXEL_BLT_ONLY &&
+		    (phys_addr_t)current_fb_base == current_fb_base) {
 			/*
 			 * Systems that use the UEFI Console Splitter may
 			 * provide multiple GOP devices, not all of which are
@@ -168,7 +170,7 @@ setup_gop(efi_system_table_t *sys_table_arg, struct screen_info *si,
 	si->lfb_height = height;
 	si->lfb_base = fb_base;
 
-	ext_lfb_base = (u64)(unsigned long)fb_base >> 32;
+	ext_lfb_base = fb_base >> 32;
 	if (ext_lfb_base) {
 		si->capabilities |= VIDEO_CAPABILITY_64BIT_BASE;
 		si->ext_lfb_base = ext_lfb_base;
-- 
2.23.0

