Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3717018C064
	for <lists+linux-efi@lfdr.de>; Thu, 19 Mar 2020 20:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgCST27 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Mar 2020 15:28:59 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35549 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbgCST27 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Mar 2020 15:28:59 -0400
Received: by mail-qt1-f193.google.com with SMTP id v15so2937106qto.2;
        Thu, 19 Mar 2020 12:28:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r6d+yKOCqA+0QeYSPpX1kUL29PTJLI/h9o5LVefuBko=;
        b=R1K6PGoNtFyb1gpzTHsOA/zDl+4SOsoClZIcTmOo7gLCobxgIFYu/vlSgjwFY/wQE3
         mCY46aN9pmvvoO6kbFOxd/hLMcFeWmDwxsxpsON8UhsCq0nLKubo3tHjHUb1Tb+fa1ga
         VSkchQb4uy3vpwYcVRZIVP8ApZcY1wuccDJioePBm0izFg+8hT7eZ2H7aPm18Qb7cIhQ
         ydnENRsDXSkCBJAmkwlQrypRDT63vb//h3kzZR5H/9VmZZ9pgpnvV6tRicpxbx/fb5ar
         KX7UwoUa4U+i5c3QllviNgeSqC/dJmpUil0pXenRWK3eK7OXgf+C5Y0Y9rxnnCmi/RTd
         T9mw==
X-Gm-Message-State: ANhLgQ0UU5Q3dUIO69HGuv94ydYdmGZByBI4/3bS8EnXxcQ+ha4BzCHb
        R4UClO07N/Gf5mmKnaDJht9b/Zan
X-Google-Smtp-Source: ADFU+vvbNlW2iFC8Dg30XlNMdBCNkU2rerS86XnyXa/VDu3nJi0Sy1RZXgeAnupQd8md8itwZc7/JA==
X-Received: by 2002:ac8:2bf9:: with SMTP id n54mr4662595qtn.280.1584646138192;
        Thu, 19 Mar 2020 12:28:58 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id x89sm2292649qtd.43.2020.03.19.12.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 12:28:57 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/14] efi/gop: Remove redundant current_fb_base
Date:   Thu, 19 Mar 2020 15:28:42 -0400
Message-Id: <20200319192855.29876-2-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200319192855.29876-1-nivedita@alum.mit.edu>
References: <20200319192855.29876-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

current_fb_base isn't used for anything except assigning to fb_base if
we locate a suitable gop.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/gop.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index 55e6b3f286fe..f40d535dccb8 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -108,7 +108,6 @@ static efi_status_t setup_gop(struct screen_info *si, efi_guid_t *proto,
 		efi_guid_t conout_proto = EFI_CONSOLE_OUT_DEVICE_GUID;
 		bool conout_found = false;
 		void *dummy = NULL;
-		efi_physical_addr_t current_fb_base;
 
 		status = efi_bs_call(handle_protocol, h, proto, (void **)&gop);
 		if (status != EFI_SUCCESS)
@@ -120,7 +119,6 @@ static efi_status_t setup_gop(struct screen_info *si, efi_guid_t *proto,
 
 		mode = efi_table_attr(gop, mode);
 		info = efi_table_attr(mode, info);
-		current_fb_base = efi_table_attr(mode, frame_buffer_base);
 
 		if ((!first_gop || conout_found) &&
 		    info->pixel_format != PIXEL_BLT_ONLY) {
@@ -136,7 +134,7 @@ static efi_status_t setup_gop(struct screen_info *si, efi_guid_t *proto,
 			pixel_format = info->pixel_format;
 			pixel_info = info->pixel_information;
 			pixels_per_scan_line = info->pixels_per_scan_line;
-			fb_base = current_fb_base;
+			fb_base = efi_table_attr(mode, frame_buffer_base);
 
 			/*
 			 * Once we've found a GOP supporting ConOut,
-- 
2.24.1

