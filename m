Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3276E12A78A
	for <lists+linux-efi@lfdr.de>; Wed, 25 Dec 2019 11:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfLYKjF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Dec 2019 05:39:05 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40579 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfLYKjE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 25 Dec 2019 05:39:04 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ik447-000866-3n; Wed, 25 Dec 2019 11:38:55 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BC26F1C2BA3;
        Wed, 25 Dec 2019 11:38:54 +0100 (CET)
Date:   Wed, 25 Dec 2019 10:38:54 -0000
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/earlycon: Fix write-combine mapping on x86
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191224132909.102540-2-ardb@kernel.org>
References: <20191224132909.102540-2-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <157727033465.30329.13576323770465814572.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     d92b54570d24d017d2630e314b525ed792f5aa6c
Gitweb:        https://git.kernel.org/tip/d92b54570d24d017d2630e314b525ed792f5aa6c
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Tue, 24 Dec 2019 14:29:07 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 25 Dec 2019 10:46:06 +01:00

efi/earlycon: Fix write-combine mapping on x86

On x86, until PAT is initialized, WC translates into UC-. Since we
calculate and store pgprot_writecombine(PAGE_KERNEL) when earlycon is
initialized, this means we actually use UC- mappings instead of WC
mappings, which makes scrolling very slow.

Instead store a boolean flag to indicate whether we want to use
writeback or write-combine mappings, and recalculate the actual pgprot_t
we need on every mapping. Once PAT is initialized, we will start using
write-combine mappings, which speeds up the scrolling considerably.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Fixes: 69c1f396f25b ("efi/x86: Convert x86 EFI earlyprintk into generic earlycon implementation")
Link: https://lkml.kernel.org/r/20191224132909.102540-2-ardb@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/earlycon.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/efi/earlycon.c b/drivers/firmware/efi/earlycon.c
index d4077db..5d4f847 100644
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
