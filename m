Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A811C04CA
	for <lists+linux-efi@lfdr.de>; Thu, 30 Apr 2020 20:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgD3S3R (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Apr 2020 14:29:17 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39038 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbgD3S2u (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 30 Apr 2020 14:28:50 -0400
Received: by mail-qk1-f195.google.com with SMTP id s9so4061108qkm.6;
        Thu, 30 Apr 2020 11:28:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NQhHSNtY0vezURhJk0yw+5OcfGlry+C8ov4uNw/k5ks=;
        b=DShknItERdZ6lF8kur4JBpTkj9TT+Cx9OQplL/jdZ9KzRE10nR0R1pKvabt1UdyaQu
         KyDxEG05f6VYRkkd4QjIka82FKAwgNZkAMmLON0eMRt5LhGMe3Z2bS4g46JK72uoYY2Z
         09nOYYNYsQJNmRqlUoSpVjP1ns66LmAjtTNSw4s4huvCGktj9hy1girXjBMxxiO/9TZ0
         g1LKBc3Iyd7HbwXYyoJVmKk0aR8VvYJSFI2v0b1wnq2Dh0c7Lt1SYIFtYMAA3wf39S4W
         lAUFkoGxmWrTpfr8vXzKS/FLVcZe8CzUvcvzDQ0sJYxLulCC5XDIQZHz99zLdG+qkk4R
         u31w==
X-Gm-Message-State: AGi0PuaE35mRQtctD+qX5ncCdVq3BB6G8xS65ABRA9ajjhYyF0LBjy0K
        cyztouNXg2xHZWCt14P9SVQ=
X-Google-Smtp-Source: APiQypIp01WxfedSDS4RfLD6rKukPIqIf6lq7MmSNK537iTj5OcY60CjktxCHnJ7tXAPQa7kM5qsrA==
X-Received: by 2002:a37:a509:: with SMTP id o9mr4907433qke.460.1588271329080;
        Thu, 30 Apr 2020 11:28:49 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v27sm449785qtb.35.2020.04.30.11.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 11:28:48 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/11] efi/gop: Use efi_err for error messages
Date:   Thu, 30 Apr 2020 14:28:37 -0400
Message-Id: <20200430182843.2510180-6-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200430182843.2510180-1-nivedita@alum.mit.edu>
References: <20200429174120.1497212-1-nivedita@alum.mit.edu>
 <20200430182843.2510180-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Use efi_err instead of bare efi_printk for error messages.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/gop.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index 64cee0febae0..34c0cba2c8bf 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -134,14 +134,14 @@ static u32 choose_mode_modenum(efi_graphics_output_protocol_t *gop)
 
 	max_mode = efi_table_attr(mode, max_mode);
 	if (cmdline.mode >= max_mode) {
-		efi_printk("Requested mode is invalid\n");
+		efi_err("Requested mode is invalid\n");
 		return cur_mode;
 	}
 
 	status = efi_call_proto(gop, query_mode, cmdline.mode,
 				&info_size, &info);
 	if (status != EFI_SUCCESS) {
-		efi_printk("Couldn't get mode information\n");
+		efi_err("Couldn't get mode information\n");
 		return cur_mode;
 	}
 
@@ -150,7 +150,7 @@ static u32 choose_mode_modenum(efi_graphics_output_protocol_t *gop)
 	efi_bs_call(free_pool, info);
 
 	if (pf == PIXEL_BLT_ONLY || pf >= PIXEL_FORMAT_MAX) {
-		efi_printk("Invalid PixelFormat\n");
+		efi_err("Invalid PixelFormat\n");
 		return cur_mode;
 	}
 
@@ -222,7 +222,7 @@ static u32 choose_mode_res(efi_graphics_output_protocol_t *gop)
 			return m;
 	}
 
-	efi_printk("Couldn't find requested mode\n");
+	efi_err("Couldn't find requested mode\n");
 
 	return cur_mode;
 }
@@ -316,7 +316,7 @@ static void set_mode(efi_graphics_output_protocol_t *gop)
 		return;
 
 	if (efi_call_proto(gop, set_mode, new_mode) != EFI_SUCCESS)
-		efi_printk("Failed to set requested mode\n");
+		efi_err("Failed to set requested mode\n");
 }
 
 static void find_bits(u32 mask, u8 *pos, u8 *size)
-- 
2.26.2

