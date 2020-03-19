Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B03A218C05B
	for <lists+linux-efi@lfdr.de>; Thu, 19 Mar 2020 20:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbgCST3D (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Mar 2020 15:29:03 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39160 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbgCST3C (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Mar 2020 15:29:02 -0400
Received: by mail-qt1-f194.google.com with SMTP id f20so2918233qtq.6;
        Thu, 19 Mar 2020 12:29:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yf/d6z5fDqSiUAa0pPPTXtMy3f41r+NjRTZ8TYCHO5A=;
        b=OnkO+kRvovEyjx8v3vWFioxV0WC0OvzCg4mG8Oaw3HurzWHblq+LsAu/gIQfjAD5SC
         9SYVWgBbX7isM+hen3kmHgNBOV0Z3PkJi+tANdPZcYxoM2zUGtSadVgoWuf2WrH6MMcC
         H+/ZS45rzFVzvFFjq/IGIdYMCe37xjGHzMFHGr7DYHEZzbK7qoi3Eo9CibIUwPl0NGRs
         ZeG/J0YHFZ1Vwk3GKncnFTGJifj7vfl+8Uc5izLHiicBdsB3UZU1OnUEfjfGAF/OESj5
         QT94C7EuxDoC8aTdyB1g6cyYUaQlKO/ZXj2/ONcQ3tflpW433Iwkvfw9O07KmlUgOby+
         ILIQ==
X-Gm-Message-State: ANhLgQ2SFr4XEZZwcNcQvFeWxQo4kfHfiADYxHVEL+nGbhYuOKWXZHIc
        lOI6brVtSZtx21ix3FYww8g=
X-Google-Smtp-Source: ADFU+vsg+zJNdwu4si9Dhykje5h7zicQ9+6CqRFfPqd7fkuPBk4axUxo+s57pU1Ljqkgo8FWImAvGA==
X-Received: by 2002:ac8:17ab:: with SMTP id o40mr4646748qtj.308.1584646139493;
        Thu, 19 Mar 2020 12:28:59 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id x89sm2292649qtd.43.2020.03.19.12.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 12:28:58 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/14] efi/gop: Move check for framebuffer before con_out
Date:   Thu, 19 Mar 2020 15:28:43 -0400
Message-Id: <20200319192855.29876-3-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200319192855.29876-1-nivedita@alum.mit.edu>
References: <20200319192855.29876-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

If the gop doesn't have a framebuffer, there's no point in checking for
con_out support.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/gop.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index f40d535dccb8..201b66970b2b 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -113,15 +113,16 @@ static efi_status_t setup_gop(struct screen_info *si, efi_guid_t *proto,
 		if (status != EFI_SUCCESS)
 			continue;
 
+		mode = efi_table_attr(gop, mode);
+		info = efi_table_attr(mode, info);
+		if (info->pixel_format == PIXEL_BLT_ONLY)
+			continue;
+
 		status = efi_bs_call(handle_protocol, h, &conout_proto, &dummy);
 		if (status == EFI_SUCCESS)
 			conout_found = true;
 
-		mode = efi_table_attr(gop, mode);
-		info = efi_table_attr(mode, info);
-
-		if ((!first_gop || conout_found) &&
-		    info->pixel_format != PIXEL_BLT_ONLY) {
+		if (!first_gop || conout_found) {
 			/*
 			 * Systems that use the UEFI Console Splitter may
 			 * provide multiple GOP devices, not all of which are
-- 
2.24.1

