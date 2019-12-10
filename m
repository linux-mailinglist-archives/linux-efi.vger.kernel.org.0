Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0ECA119F4E
	for <lists+linux-efi@lfdr.de>; Wed, 11 Dec 2019 00:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfLJXYN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 10 Dec 2019 18:24:13 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:46185 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfLJXYN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 10 Dec 2019 18:24:13 -0500
Received: by mail-qv1-f67.google.com with SMTP id t9so4936463qvh.13
        for <linux-efi@vger.kernel.org>; Tue, 10 Dec 2019 15:24:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b6SJDvOHqML+C52vfw385Cd1zf3a3MftR7mdlodewd8=;
        b=ejhf7VEwgeHNRAEaFJOg8I8bpdouBmHF+N8pENsbuUB3sFF+QFKZpO3ZA0dFY2FoFP
         o0juiW76r/JiH8EfmK+UakrFHpvkTft4KPb+1md+3TZYNdXDS032yLtc/7RRr1mXLI5A
         jy7NFjPXDPkGtTLtbUd3xnVrSNohcQTAulD6aY1s90pAwie8oEsQomqaD4fcOtVJS7fa
         wHsRyLzRIduNFmLoXNNN9FHwUSu/xb2Y9E2x+EVPhb3nnr2Pg5vJvgZUsNvgT8plPTyw
         b+8k/qaTfZoKb83labpXiSoPgviykk3QGwQRCbbH1MI/B6ejWlhbSkj6eLad4MKXEPY+
         vdpg==
X-Gm-Message-State: APjAAAUW53ifPCEffy/TL0ELILF+wJKkT1is2nNc3g+11A4xfWqmaARF
        idL0+8cUn6SsjHDdVTCWs5uCXzCq
X-Google-Smtp-Source: APXvYqyvPAJsuXJkFP/9JAeii4rOHOjK5Z9e7EZ7dApaH4/+qnJLQ0EpT/NzrmPiogc86VbOTcMGxA==
X-Received: by 2002:a05:6214:14ad:: with SMTP id bo13mr408097qvb.22.1576020251785;
        Tue, 10 Dec 2019 15:24:11 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id j7sm21001qki.63.2019.12.10.15.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 15:24:11 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Subject: [PATCH] efi/earlycon: Fix write-combine mapping on x86
Date:   Tue, 10 Dec 2019 18:24:10 -0500
Message-Id: <20191210232410.17890-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On x86, until PAT is initialized, WC translates into UC-. Since we
calculate and store pgprot_writecombine(PAGE_KERNEL) when earlycon is
initialized, this means we actually use UC- mappings instead of WC
mappings, which makes scrolling very slow.

Instead store a boolean flag to indicate whether we want to use
writeback or write-combine mappings, and recalculate the actual pgprot_t
we need on every mapping. Once PAT is initialized, we will start using
write-combine mappings, which speeds up the scrolling considerably.

Fixes: 69c1f396f25b ("efi/x86: Convert x86 EFI earlyprintk into generic earlycon implementation")
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
This applies on top of
	efi/earlycon: Remap entire framebuffer after page initialization
	https://git.kernel.org/tip/b418d660bb9798d2249ac6a46c844389ef50b6a5

 drivers/firmware/efi/earlycon.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/efi/earlycon.c b/drivers/firmware/efi/earlycon.c
index ee5a6431fb9c..18f6a61f3e17 100644
--- a/drivers/firmware/efi/earlycon.c
+++ b/drivers/firmware/efi/earlycon.c
@@ -17,7 +17,7 @@ static const struct console *earlycon_console __initdata;
 static const struct font_desc *font;
 static u32 efi_x, efi_y;
 static u64 fb_base;
-static pgprot_t fb_prot;
+static bool fb_wb;
 static void *efi_fb;
 
 /*
@@ -33,10 +33,8 @@ static int __init efi_earlycon_remap_fb(void)
 	if (!earlycon_console || !(earlycon_console->flags & CON_ENABLED))
 		return 0;
 
-	if (pgprot_val(fb_prot) == pgprot_val(PAGE_KERNEL))
-		efi_fb = memremap(fb_base, screen_info.lfb_size, MEMREMAP_WB);
-	else
-		efi_fb = memremap(fb_base, screen_info.lfb_size, MEMREMAP_WC);
+	efi_fb = memremap(fb_base, screen_info.lfb_size,
+			  fb_wb ? MEMREMAP_WB : MEMREMAP_WC);
 
 	pr_info("Mapped earlycon framebuffer\n");
 
@@ -58,9 +56,12 @@ late_initcall(efi_earlycon_unmap_fb);
 
 static __ref void *efi_earlycon_map(unsigned long start, unsigned long len)
 {
+	pgprot_t fb_prot;
+
 	if (efi_fb)
 		return efi_fb + start;
 
+	fb_prot = fb_wb ? PAGE_KERNEL : pgprot_writecombine(PAGE_KERNEL);
 	return early_memremap_prot(fb_base + start, len, pgprot_val(fb_prot));
 }
 
@@ -220,10 +221,7 @@ static int __init efi_earlycon_setup(struct earlycon_device *device,
 	if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
 		fb_base |= (u64)screen_info.ext_lfb_base << 32;
 
-	if (opt && !strcmp(opt, "ram"))
-		fb_prot = PAGE_KERNEL;
-	else
-		fb_prot = pgprot_writecombine(PAGE_KERNEL);
+	fb_wb = opt && !strcmp(opt, "ram");
 
 	si = &screen_info;
 	xres = si->lfb_width;
-- 
2.23.0

