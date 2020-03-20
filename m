Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD1818C502
	for <lists+linux-efi@lfdr.de>; Fri, 20 Mar 2020 03:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbgCTCAc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Mar 2020 22:00:32 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39607 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbgCTCAc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Mar 2020 22:00:32 -0400
Received: by mail-qk1-f194.google.com with SMTP id t17so5410052qkm.6;
        Thu, 19 Mar 2020 19:00:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r6d+yKOCqA+0QeYSPpX1kUL29PTJLI/h9o5LVefuBko=;
        b=VOqNzflR1EnIfL3EaCQlneEMsPZ6O2tvHP3gzJbHtGW8mu3z1yC3ojOLySZSSKvQHy
         ZPRusdKF5wLJgo/TOaQ0CvLp8UuKIDTcivBnBQ8UVLO16Zspou3EsAsOAD5dUqLuPHOS
         VdsQSZLmbLau9FWk2I2pYSJ8IAA/63y3WS4LbWqkgy708Vll20GVNWa+nQok0HDfMwh5
         qXIm4TPetU6+pJfucvxF8h4fw/mAhA1+wAkMJ3+ihcETfLUOzZ9gDIql+z8/g2n0vRqz
         Y080gi5I3Q0yM6vtevkkR4z9ud+ax62bFfo0fVnWhdoU4/4JRe559c5XV5kcYjbYaMqs
         Dh8A==
X-Gm-Message-State: ANhLgQ1zmJSQ7GUcL0SlUX75xR4rVFyFlfSpIy/KDLMjB8M9kPw8YZyO
        NQXbM6m2EsA8po8rMEXuBpY=
X-Google-Smtp-Source: ADFU+vuBTKqMvQou6YVVBTVcXV3EHK+UpOFH9klLr8qB+fkRT++XOzLY4EP1xu3NEm3PABu2//Ul4w==
X-Received: by 2002:ae9:ed56:: with SMTP id c83mr5533781qkg.200.1584669631270;
        Thu, 19 Mar 2020 19:00:31 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n46sm3342198qtb.48.2020.03.19.19.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 19:00:30 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/14] efi/gop: Remove redundant current_fb_base
Date:   Thu, 19 Mar 2020 22:00:15 -0400
Message-Id: <20200320020028.1936003-2-nivedita@alum.mit.edu>
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

