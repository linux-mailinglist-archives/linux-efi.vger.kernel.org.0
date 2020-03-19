Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B495918C063
	for <lists+linux-efi@lfdr.de>; Thu, 19 Mar 2020 20:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbgCST3D (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Mar 2020 15:29:03 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46623 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbgCST3C (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Mar 2020 15:29:02 -0400
Received: by mail-qt1-f195.google.com with SMTP id t13so2879204qtn.13;
        Thu, 19 Mar 2020 12:29:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eypfN+K25jzdF1LBfT16FtLYEkY8rsAbd9XPwaPc/Ns=;
        b=HzlL+IeMn/5BLcTUmrJiG0oNPbSZNvpUCX9kcsJIE1rF6NWWOijAX1Ce7m4ya4CdG3
         HpVyDoMKeVUCokdLv8b1SRbxU/HmjQorC6qDdZECIKNVy/j5HufItwYKogPxXrE9eFIC
         r3RskAzBSY+0m6QDnrB9VXxSt9QtSyMuANvHU4d80ck4AkogsDMD97K60SDL+BaGRVTz
         ckezFiMWkkdKsEDi2vI6IeB90mxUXbkVVuvtqHqKbAuI7THgCazTHUh5VfNUKLnwhLYR
         oyVy6LwRq6Kv81gGP8kE9I/YRWSUC9lQIw97PZNhWdwTcRzleNFEm91ZoHOG2RR+CoA0
         iErg==
X-Gm-Message-State: ANhLgQ0qWBC/sXMKBx/P4HgO6LbTXrebqolurA2GYRA7I7qXHQfiFLVI
        K9iRJ4deD3eKaaHVMLaC4zc=
X-Google-Smtp-Source: ADFU+vthboHV5Z3MQrrVoEhbP5+n5awH4+RdC+Yrxuy5skOeK3IJTk4Hyeg+9MR3hTMxBJ3T89KlpA==
X-Received: by 2002:aed:3b4c:: with SMTP id q12mr4568105qte.18.1584646141081;
        Thu, 19 Mar 2020 12:29:01 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id x89sm2292649qtd.43.2020.03.19.12.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 12:29:00 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/14] efi/gop: Factor out locating the gop into a function
Date:   Thu, 19 Mar 2020 15:28:45 -0400
Message-Id: <20200319192855.29876-5-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200319192855.29876-1-nivedita@alum.mit.edu>
References: <20200319192855.29876-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Move the loop to find a gop into its own function.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/gop.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index d692b8c65813..92abcf558845 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -85,19 +85,17 @@ setup_pixel_info(struct screen_info *si, u32 pixels_per_scan_line,
 	}
 }
 
-static efi_status_t setup_gop(struct screen_info *si, efi_guid_t *proto,
-			      unsigned long size, void **handles)
+static efi_graphics_output_protocol_t *
+find_gop(efi_guid_t *proto, unsigned long size, void **handles)
 {
 	efi_graphics_output_protocol_t *gop, *first_gop;
 	efi_graphics_output_protocol_mode_t *mode;
 	efi_graphics_output_mode_info_t *info = NULL;
-	efi_physical_addr_t fb_base;
 	efi_status_t status;
 	efi_handle_t h;
 	int i;
 
 	first_gop = NULL;
-	gop = NULL;
 
 	for_each_efi_handle(h, handles, size, i) {
 		efi_guid_t conout_proto = EFI_CONSOLE_OUT_DEVICE_GUID;
@@ -134,12 +132,25 @@ static efi_status_t setup_gop(struct screen_info *si, efi_guid_t *proto,
 		}
 	}
 
+	return first_gop;
+}
+
+static efi_status_t setup_gop(struct screen_info *si, efi_guid_t *proto,
+			      unsigned long size, void **handles)
+{
+	efi_graphics_output_protocol_t *gop;
+	efi_graphics_output_protocol_mode_t *mode;
+	efi_graphics_output_mode_info_t *info = NULL;
+	efi_physical_addr_t fb_base;
+
+	gop = find_gop(proto, size, handles);
+
 	/* Did we find any GOPs? */
-	if (!first_gop)
+	if (!gop)
 		return EFI_NOT_FOUND;
 
 	/* EFI framebuffer */
-	mode = efi_table_attr(first_gop, mode);
+	mode = efi_table_attr(gop, mode);
 	info = efi_table_attr(mode, info);
 
 	si->orig_video_isVGA = VIDEO_TYPE_EFI;
-- 
2.24.1

