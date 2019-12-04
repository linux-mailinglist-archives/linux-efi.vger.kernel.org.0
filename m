Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2676113391
	for <lists+linux-efi@lfdr.de>; Wed,  4 Dec 2019 19:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbfLDSRu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Dec 2019 13:17:50 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:32791 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729052AbfLDSRt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Dec 2019 13:17:49 -0500
Received: by mail-qk1-f195.google.com with SMTP id c124so897526qkg.0
        for <linux-efi@vger.kernel.org>; Wed, 04 Dec 2019 10:17:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gzomWh8xjoi21A3gfLuDiDBmKGStkUDN6z5Fo4YMjpk=;
        b=XaFw8Yg37/a5Uli3QD49Kmy3ltgkTnF+ZF42n5X4m4yXB5mkzxFMxuaV7cKTrp2RNX
         /2JA6jkom4tmfpoMpGS1KprvBuR//1EL88wUGt4ezv6PfGhdTH1EnInke9/n6YOA9FMC
         9fJlokCgs/OCKG/cVr9SF1GV6ayAkiXP10hOUmzm94t817RyHK2RxGUV4WQvVmdgUF0j
         2oYbNDYTWjrUhzK9h6t8V8avkGSAZP1VcM/MU6s2ZnGqIjldFAf6thk3+HPOPHsU82iY
         xslC0FRUkhHh4P1vYBGpeXYR6N/4TcZk6ky652c7v7nCIxKpdMaSAu+1TyQqt91cl58P
         FHmA==
X-Gm-Message-State: APjAAAUV6EfeliK6N748eEmCLPR7MT+iP/Z9tAQMVbQkoSnsAD19mBwB
        Z7Mq9PG6kyooq5BXAByG6oZqQiz3d7M=
X-Google-Smtp-Source: APXvYqy4dAbmXcjs7gnPBXkqlFmximIgLagWeUwlhhhN40qpZ4IZ3P7b8OImOlKPf0tYHilsFlOo4g==
X-Received: by 2002:a37:61c6:: with SMTP id v189mr4340324qkb.158.1575483467381;
        Wed, 04 Dec 2019 10:17:47 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id c6sm4072506qka.111.2019.12.04.10.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 10:17:46 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [PATCH v2 1/3] efi/gop: Return EFI_NOT_FOUND if there are no usable GOP's
Date:   Wed,  4 Dec 2019 13:17:42 -0500
Message-Id: <20191204181744.14326-2-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191203214728.19264-1-nivedita@alum.mit.edu>
References: <20191203214728.19264-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

If we don't find a usable GOP because none of them have a framebuffer
(i.e. they were all PIXEL_BLT_ONLY), but all the efi calls succeeded, we
will return EFI_SUCCESS even though we didn't find a usable GOP.

Fix this by explicitly returning EFI_NOT_FOUND if no usable GOP's are
found, allowing the caller to probe for UGA instead.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/gop.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index 0101ca4c13b1..62e8b7cff72f 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -175,7 +175,7 @@ setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
 
 	/* Did we find any GOPs? */
 	if (!first_gop)
-		goto out;
+		return EFI_NOT_FOUND;
 
 	/* EFI framebuffer */
 	si->orig_video_isVGA = VIDEO_TYPE_EFI;
@@ -197,7 +197,7 @@ setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
 	si->lfb_size = si->lfb_linelength * si->lfb_height;
 
 	si->capabilities |= VIDEO_CAPABILITY_SKIP_QUIRKS;
-out:
+
 	return status;
 }
 
@@ -293,7 +293,7 @@ setup_gop64(efi_system_table_t *sys_table_arg, struct screen_info *si,
 
 	/* Did we find any GOPs? */
 	if (!first_gop)
-		goto out;
+		return EFI_NOT_FOUND;
 
 	/* EFI framebuffer */
 	si->orig_video_isVGA = VIDEO_TYPE_EFI;
@@ -315,7 +315,7 @@ setup_gop64(efi_system_table_t *sys_table_arg, struct screen_info *si,
 	si->lfb_size = si->lfb_linelength * si->lfb_height;
 
 	si->capabilities |= VIDEO_CAPABILITY_SKIP_QUIRKS;
-out:
+
 	return status;
 }
 
-- 
2.23.0

