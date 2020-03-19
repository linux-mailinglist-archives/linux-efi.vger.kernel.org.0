Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7C2A18C05D
	for <lists+linux-efi@lfdr.de>; Thu, 19 Mar 2020 20:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbgCST3F (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Mar 2020 15:29:05 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33774 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbgCST3E (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Mar 2020 15:29:04 -0400
Received: by mail-qk1-f194.google.com with SMTP id p6so4459991qkm.0;
        Thu, 19 Mar 2020 12:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IbeHQl1XqMr+8edKb2icuORkyf9Hpoc/AyZgQ5A8vls=;
        b=idy4yyNwb4MI3FFc5UjJ6ni3QuM/fcDK8Vn/Kzlsf+sH51Ps7xSZOGsELcXuEmzB2d
         dg8MtnzlZOjxZK+AoX1FpMcuBCQPuqTbQ4vKtrVr/qGQah2dyjlnssweF35inTvBFogF
         UIuvXxo6dP3cce2fRZ1ecprLnrilL4AU82QgyET8pwIds0smrxI4exu66CK9rpWa0ZtN
         dYgIsBlVEGdF34Fnc+Txfn2DZWJVwqaUTOnR5Q4CypicqjGgbJCGudCKVcKfnj0UP0/k
         zc+18wLKqVFX18gjKrttpcDMB54dWhUAl945jB7OMlaqqW7YPsnKb/uTCngbtKv5rTVN
         sMUg==
X-Gm-Message-State: ANhLgQ0wJAlhZpzzdiUQQm9VAomHvI9col9py5l5uAbpB8ok/l0BJ3CB
        NDXzs4+tq9kwMIgsHiart6A=
X-Google-Smtp-Source: ADFU+vtwKsHpe8HXrrng0MW3nc/1HKX5Q+tE9VeIO7TdjdXcvqtv3fYWdK5MqLvLLX0+Z3hBbSaYuQ==
X-Received: by 2002:a37:9f58:: with SMTP id i85mr4494627qke.196.1584646143519;
        Thu, 19 Mar 2020 12:29:03 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id x89sm2292649qtd.43.2020.03.19.12.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 12:29:03 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/14] efi/gop: Use helper macros for populating lfb_base
Date:   Thu, 19 Mar 2020 15:28:48 -0400
Message-Id: <20200319192855.29876-8-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200319192855.29876-1-nivedita@alum.mit.edu>
References: <20200319192855.29876-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Use the lower/upper_32_bits macros from kernel.h to initialize
si->lfb_base and si->ext_lfb_base.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/gop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index 0d195060a370..7b0baf9a912f 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -158,8 +158,8 @@ static efi_status_t setup_gop(struct screen_info *si, efi_guid_t *proto,
 	si->lfb_height = info->vertical_resolution;
 
 	fb_base		 = efi_table_attr(mode, frame_buffer_base);
-	si->lfb_base	 = fb_base;
-	si->ext_lfb_base = (u64)(unsigned long)fb_base >> 32;
+	si->lfb_base	 = lower_32_bits(fb_base);
+	si->ext_lfb_base = upper_32_bits(fb_base);
 	if (si->ext_lfb_base)
 		si->capabilities |= VIDEO_CAPABILITY_64BIT_BASE;
 
-- 
2.24.1

