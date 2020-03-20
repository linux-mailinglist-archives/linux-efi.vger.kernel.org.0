Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E02318C51C
	for <lists+linux-efi@lfdr.de>; Fri, 20 Mar 2020 03:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbgCTCBT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Mar 2020 22:01:19 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:34177 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727438AbgCTCAf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Mar 2020 22:00:35 -0400
Received: by mail-qv1-f67.google.com with SMTP id o18so2215914qvf.1;
        Thu, 19 Mar 2020 19:00:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eypfN+K25jzdF1LBfT16FtLYEkY8rsAbd9XPwaPc/Ns=;
        b=keiV4ZBPaomb6Xrp3EhLu+NszRYJYC3rBfNWqae3uc7FzUhP/pzMEcXg7GBtGgUN7/
         FBPJ+TlSRfH4CbLeeBafZVEf/55BRmr7UVA0vkA1EOkdSGhpWxEjINR6sZfmdOi059uo
         XvDyMc7rbKRV6cLMz3d8sYWLLIA9qQmvxPyJLdTaypPh/7OqF9UlvTAzUhOLNK10KAwF
         WoqaCmWMvg+bqCVrF2d6ZtzLrhiVW/leJqCw0c2YevWzwQPlD/bTYCClMZfoB3ivTN2E
         Jyl2B3Uf4xBzezv17t1C5NAbtxIf1xwgLJhErozpfEhz23f/J1AlUnRdKiiU7vI8YC/6
         RfUA==
X-Gm-Message-State: ANhLgQ2NroSL87BzYWRRxNYyoiypdixIjiOC9yCbjmkCjXt6LIxMr2iD
        Uk++OuJyWXz1yMQRFGSlSWmY4Vfw
X-Google-Smtp-Source: ADFU+vuR/UVvBf2qErNf/0Je+K7jCbyq/HuIfxcblcSPfdk7WhZWvaX+BNnPW7opNgvjyVK9WH2HRQ==
X-Received: by 2002:a05:6214:611:: with SMTP id z17mr4186982qvw.125.1584669633798;
        Thu, 19 Mar 2020 19:00:33 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n46sm3342198qtb.48.2020.03.19.19.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 19:00:33 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/14] efi/gop: Factor out locating the gop into a function
Date:   Thu, 19 Mar 2020 22:00:18 -0400
Message-Id: <20200320020028.1936003-5-nivedita@alum.mit.edu>
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

