Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5624012A1C0
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2019 14:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfLXN3q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Dec 2019 08:29:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:58538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbfLXN3q (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 24 Dec 2019 08:29:46 -0500
Received: from localhost.localdomain (91-167-84-221.subs.proxad.net [91.167.84.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40B582071E;
        Tue, 24 Dec 2019 13:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577194185;
        bh=GazPSS+c6B9Kt3+UlWZWQ/BY8A3l+UHzfQLW+rSPTWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CfPfLMO3jmt87QgxhMjBz86DUJKBk4WOZWfR9x/voHeXFtnK+LJ+HgQhEDo1n1X3J
         FuSRv3enqdSIk8xtvFSZDtvnUwfdJOEyh6GideQstDaQsSRZc8CgCT2bZIPU8wK5wU
         exTAzBmNjH+NrglLSwxYGIdHet4USIJChsV6Vz+g=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/3] efi/earlycon: Fix write-combine mapping on x86
Date:   Tue, 24 Dec 2019 14:29:07 +0100
Message-Id: <20191224132909.102540-2-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224132909.102540-1-ardb@kernel.org>
References: <20191224132909.102540-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

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
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/earlycon.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/efi/earlycon.c b/drivers/firmware/efi/earlycon.c
index d4077db6dc97..5d4f84781aa0 100644
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
 
 	return efi_fb ? 0 : -ENOMEM;
 }
@@ -53,9 +51,12 @@ late_initcall(efi_earlycon_unmap_fb);
 
 static __ref void *efi_earlycon_map(unsigned long start, unsigned long len)
 {
+	pgprot_t fb_prot;
+
 	if (efi_fb)
 		return efi_fb + start;
 
+	fb_prot = fb_wb ? PAGE_KERNEL : pgprot_writecombine(PAGE_KERNEL);
 	return early_memremap_prot(fb_base + start, len, pgprot_val(fb_prot));
 }
 
@@ -215,10 +216,7 @@ static int __init efi_earlycon_setup(struct earlycon_device *device,
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
2.20.1

