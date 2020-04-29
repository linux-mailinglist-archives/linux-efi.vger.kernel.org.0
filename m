Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB671BE585
	for <lists+linux-efi@lfdr.de>; Wed, 29 Apr 2020 19:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgD2Rl5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Apr 2020 13:41:57 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35427 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbgD2Rl0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Apr 2020 13:41:26 -0400
Received: by mail-qk1-f196.google.com with SMTP id c63so2900201qke.2;
        Wed, 29 Apr 2020 10:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6ObA95TOcsUIrsAwh/ldNlUXAoZVqtd9nWst9CXusb4=;
        b=V3UpQ3doY0Arsz3DBvBHiRxIcwbjSYgkc8g9v3xvd0f9RUsdl4u9OSiP+atXx4ceV1
         kYG318qffpqG/zkzowGqda9bphu4ixxOtYTbh6C3ZyKUWZXfTpDh33vbJNCKpv5QlStU
         yR4mUSe+d09W9kgdmp4YajixnHcRCu4A9vaxR2jh7DUbuXrR8EEt51A3mTZVNNzb0Y7w
         n3UlZLwyEeCdQDrILUBrPK+Ak8J0sA1rm9HrTriEBpOj/0n+yNGJSlmglh8yoyd1l9sC
         xE0XEM8C+OpO4OZa98+6y1IedOwoENecaibd/5eDd0PZUAlBoHGVcCVQdRYHijaolDAU
         nhGA==
X-Gm-Message-State: AGi0PubNmkPHU0ckobDGAz6iJp/DpmnLqskHYfSGkzZDUDWlYPwnJjML
        sYQgrjCv0ssP4/XMv+9cr2w=
X-Google-Smtp-Source: APiQypLh3qEgqYqA/M2LWQBpykORff3wmocDzmI569k1Ctt4bKeYFUblTsYxC+EHZ6GSRgOPHlBHGg==
X-Received: by 2002:a05:620a:1395:: with SMTP id k21mr33999791qki.120.1588182085516;
        Wed, 29 Apr 2020 10:41:25 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id z1sm14766448qkz.3.2020.04.29.10.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 10:41:25 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] efi/gop: Use pr_efi_err for error messages
Date:   Wed, 29 Apr 2020 13:41:14 -0400
Message-Id: <20200429174120.1497212-6-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200429174120.1497212-1-nivedita@alum.mit.edu>
References: <20200429174120.1497212-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Use pr_efi_err instead of bare efi_printk for error messages.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/gop.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index 64cee0febae0..1d9bb40acd86 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -134,14 +134,14 @@ static u32 choose_mode_modenum(efi_graphics_output_protocol_t *gop)
 
 	max_mode = efi_table_attr(mode, max_mode);
 	if (cmdline.mode >= max_mode) {
-		efi_printk("Requested mode is invalid\n");
+		pr_efi_err("Requested mode is invalid\n");
 		return cur_mode;
 	}
 
 	status = efi_call_proto(gop, query_mode, cmdline.mode,
 				&info_size, &info);
 	if (status != EFI_SUCCESS) {
-		efi_printk("Couldn't get mode information\n");
+		pr_efi_err("Couldn't get mode information\n");
 		return cur_mode;
 	}
 
@@ -150,7 +150,7 @@ static u32 choose_mode_modenum(efi_graphics_output_protocol_t *gop)
 	efi_bs_call(free_pool, info);
 
 	if (pf == PIXEL_BLT_ONLY || pf >= PIXEL_FORMAT_MAX) {
-		efi_printk("Invalid PixelFormat\n");
+		pr_efi_err("Invalid PixelFormat\n");
 		return cur_mode;
 	}
 
@@ -222,7 +222,7 @@ static u32 choose_mode_res(efi_graphics_output_protocol_t *gop)
 			return m;
 	}
 
-	efi_printk("Couldn't find requested mode\n");
+	pr_efi_err("Couldn't find requested mode\n");
 
 	return cur_mode;
 }
@@ -316,7 +316,7 @@ static void set_mode(efi_graphics_output_protocol_t *gop)
 		return;
 
 	if (efi_call_proto(gop, set_mode, new_mode) != EFI_SUCCESS)
-		efi_printk("Failed to set requested mode\n");
+		pr_efi_err("Failed to set requested mode\n");
 }
 
 static void find_bits(u32 mask, u8 *pos, u8 *size)
-- 
2.26.2

