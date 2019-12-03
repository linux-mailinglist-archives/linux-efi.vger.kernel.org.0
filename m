Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C32FD111B20
	for <lists+linux-efi@lfdr.de>; Tue,  3 Dec 2019 22:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfLCVrb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Dec 2019 16:47:31 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:41326 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbfLCVra (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Dec 2019 16:47:30 -0500
Received: by mail-qv1-f67.google.com with SMTP id b18so2226944qvo.8
        for <linux-efi@vger.kernel.org>; Tue, 03 Dec 2019 13:47:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OdULmxzkIB+68EcM1qg8n/7BC/1d6BpnRkxbpXHszXs=;
        b=oSwk9g9PeCbZoua85HR7WQQWZbvCGXwp8+Dz/k5jpRZT6C1lErdzNQtn+lFs0AvN6c
         gU1gKo7NHWwthpQ0oFdOck7FJofiKxQDZlhCGpzzavtBfDhpm6E+CeypkNfyYzWElF1h
         X+V9mkzZS8ulnce4fvLTvN8YuixCEWOFVih20fd7xYRQnUOClqetgEMMupF6D8WjYtsZ
         LRpBD/FB6TIupygVF5axITfBBFs3fFT9Oh0Sb5+fjZNNTRwqOVON+ck+TLOz862ODeID
         tnDGoDQkUfngGiAJdEanBtceY9EZTCCOjkNNG6EqSJ3fNi/OXu1gng0rZRldagC4X0E9
         vxCg==
X-Gm-Message-State: APjAAAXQ9xp3TdC7Q4CrubDrWuu3N9P6cg4R8sEbUHtusuaBhpvn781a
        knrpJnbpRJ/UZAPfIcZp29wydARlIcg=
X-Google-Smtp-Source: APXvYqzQ8sI6rjBUpPWNm3n0RU4VKlfg8vO88ImljIgfC4rzbrOG2ZU2Dc9cFp64XLO6laoTzHt+yw==
X-Received: by 2002:a05:6214:1029:: with SMTP id k9mr7551286qvr.106.1575409649595;
        Tue, 03 Dec 2019 13:47:29 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id j89sm2491188qte.72.2019.12.03.13.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 13:47:28 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Subject: [PATCH 1/2] efi/gop: Fix return value of setup_gop32/64
Date:   Tue,  3 Dec 2019 16:47:27 -0500
Message-Id: <20191203214728.19264-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

There are two ways the status return of setup_gop32/64 could be
incorrect.

1. If we don't find a usable GOP because none of them have a framebuffer
(i.e. they were all PIXEL_BLT_ONLY), but all the efi calls succeeded, we
will return EFI_SUCCESS even though we didn't find a usable GOP. Return
EFI_NOT_FOUND instead, allowing the caller to probe for UGA instead.

2. If we do find a usable GOP, but one of the subsequent ones fails in
an EFI call while checking if any support console output, we may return
an EFI error code even though we found a usable GOP. Fix this by always
returning EFI_SUCCESS if we got a usable GOP.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/gop.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index 0101ca4c13b1..235a98797105 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -119,7 +119,6 @@ setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
 	u64 fb_base;
 	struct efi_pixel_bitmask pixel_info;
 	int pixel_format;
-	efi_status_t status = EFI_NOT_FOUND;
 	u32 *handles = (u32 *)(unsigned long)gop_handle;
 	int i;
 
@@ -134,6 +133,7 @@ setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
 		void *dummy = NULL;
 		efi_handle_t h = (efi_handle_t)(unsigned long)handles[i];
 		u64 current_fb_base;
+		efi_status_t status;
 
 		status = efi_call_early(handle_protocol, h,
 					proto, (void **)&gop32);
@@ -175,7 +175,7 @@ setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
 
 	/* Did we find any GOPs? */
 	if (!first_gop)
-		goto out;
+		return EFI_NOT_FOUND;
 
 	/* EFI framebuffer */
 	si->orig_video_isVGA = VIDEO_TYPE_EFI;
@@ -197,8 +197,8 @@ setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
 	si->lfb_size = si->lfb_linelength * si->lfb_height;
 
 	si->capabilities |= VIDEO_CAPABILITY_SKIP_QUIRKS;
-out:
-	return status;
+
+	return EFI_SUCCESS;
 }
 
 static efi_status_t
@@ -237,7 +237,6 @@ setup_gop64(efi_system_table_t *sys_table_arg, struct screen_info *si,
 	u64 fb_base;
 	struct efi_pixel_bitmask pixel_info;
 	int pixel_format;
-	efi_status_t status = EFI_NOT_FOUND;
 	u64 *handles = (u64 *)(unsigned long)gop_handle;
 	int i;
 
@@ -252,6 +251,7 @@ setup_gop64(efi_system_table_t *sys_table_arg, struct screen_info *si,
 		void *dummy = NULL;
 		efi_handle_t h = (efi_handle_t)(unsigned long)handles[i];
 		u64 current_fb_base;
+		efi_status_t status;
 
 		status = efi_call_early(handle_protocol, h,
 					proto, (void **)&gop64);
@@ -293,7 +293,7 @@ setup_gop64(efi_system_table_t *sys_table_arg, struct screen_info *si,
 
 	/* Did we find any GOPs? */
 	if (!first_gop)
-		goto out;
+		return EFI_NOT_FOUND;
 
 	/* EFI framebuffer */
 	si->orig_video_isVGA = VIDEO_TYPE_EFI;
@@ -315,8 +315,8 @@ setup_gop64(efi_system_table_t *sys_table_arg, struct screen_info *si,
 	si->lfb_size = si->lfb_linelength * si->lfb_height;
 
 	si->capabilities |= VIDEO_CAPABILITY_SKIP_QUIRKS;
-out:
-	return status;
+
+	return EFI_SUCCESS;
 }
 
 /*
-- 
2.23.0

