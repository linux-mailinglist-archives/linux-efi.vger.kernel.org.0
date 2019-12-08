Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3C531161AB
	for <lists+linux-efi@lfdr.de>; Sun,  8 Dec 2019 14:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfLHNdu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 8 Dec 2019 08:33:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36605 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbfLHNdu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 8 Dec 2019 08:33:50 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1idwgr-0007gM-6O; Sun, 08 Dec 2019 14:33:37 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 62C3D1C269D;
        Sun,  8 Dec 2019 14:33:33 +0100 (CET)
Date:   Sun, 08 Dec 2019 13:33:33 -0000
From:   "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/earlycon: Remap entire framebuffer after page
 initialization
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191206165542.31469-7-ardb@kernel.org>
References: <20191206165542.31469-7-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <157581201321.21853.9033877797032028086.tip-bot2@tip-bot2>
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

Commit-ID:     b418d660bb9798d2249ac6a46c844389ef50b6a5
Gitweb:        https://git.kernel.org/tip/b418d660bb9798d2249ac6a46c844389ef50b6a5
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Fri, 06 Dec 2019 16:55:42 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 08 Dec 2019 12:42:19 +01:00

efi/earlycon: Remap entire framebuffer after page initialization

When commit:

  69c1f396f25b ("efi/x86: Convert x86 EFI earlyprintk into generic earlycon implementation")

moved the x86 specific EFI earlyprintk implementation to a shared location,
it also tweaked the behaviour. In particular, it dropped a trick with full
framebuffer remapping after page initialization, leading to two regressions:

  1) very slow scrolling after page initialization,
  2) kernel hang when the 'keep_bootcon' command line argument is passed.

Putting the tweak back fixes #2 and mitigates #1, i.e., it limits the slow
behavior to the early boot stages, presumably due to eliminating heavy
map()/unmap() operations per each pixel line on the screen.

 [ ardb: ensure efifb is unmapped again unless keep_bootcon is in effect. ]
 [ mingo: speling fixes. ]

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Cc: Arvind Sankar <nivedita@alum.mit.edu>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Cc: linux-efi@vger.kernel.org
Fixes: 69c1f396f25b ("efi/x86: Convert x86 EFI earlyprintk into generic earlycon implementation")
Link: https://lkml.kernel.org/r/20191206165542.31469-7-ardb@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/earlycon.c | 40 ++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+)

diff --git a/drivers/firmware/efi/earlycon.c b/drivers/firmware/efi/earlycon.c
index c9a0efc..d4077db 100644
--- a/drivers/firmware/efi/earlycon.c
+++ b/drivers/firmware/efi/earlycon.c
@@ -13,18 +13,57 @@
 
 #include <asm/early_ioremap.h>
 
+static const struct console *earlycon_console __initdata;
 static const struct font_desc *font;
 static u32 efi_x, efi_y;
 static u64 fb_base;
 static pgprot_t fb_prot;
+static void *efi_fb;
+
+/*
+ * EFI earlycon needs to use early_memremap() to map the framebuffer.
+ * But early_memremap() is not usable for 'earlycon=efifb keep_bootcon',
+ * memremap() should be used instead. memremap() will be available after
+ * paging_init() which is earlier than initcall callbacks. Thus adding this
+ * early initcall function early_efi_map_fb() to map the whole EFI framebuffer.
+ */
+static int __init efi_earlycon_remap_fb(void)
+{
+	/* bail if there is no bootconsole or it has been disabled already */
+	if (!earlycon_console || !(earlycon_console->flags & CON_ENABLED))
+		return 0;
+
+	if (pgprot_val(fb_prot) == pgprot_val(PAGE_KERNEL))
+		efi_fb = memremap(fb_base, screen_info.lfb_size, MEMREMAP_WB);
+	else
+		efi_fb = memremap(fb_base, screen_info.lfb_size, MEMREMAP_WC);
+
+	return efi_fb ? 0 : -ENOMEM;
+}
+early_initcall(efi_earlycon_remap_fb);
+
+static int __init efi_earlycon_unmap_fb(void)
+{
+	/* unmap the bootconsole fb unless keep_bootcon has left it enabled */
+	if (efi_fb && !(earlycon_console->flags & CON_ENABLED))
+		memunmap(efi_fb);
+	return 0;
+}
+late_initcall(efi_earlycon_unmap_fb);
 
 static __ref void *efi_earlycon_map(unsigned long start, unsigned long len)
 {
+	if (efi_fb)
+		return efi_fb + start;
+
 	return early_memremap_prot(fb_base + start, len, pgprot_val(fb_prot));
 }
 
 static __ref void efi_earlycon_unmap(void *addr, unsigned long len)
 {
+	if (efi_fb)
+		return;
+
 	early_memunmap(addr, len);
 }
 
@@ -201,6 +240,7 @@ static int __init efi_earlycon_setup(struct earlycon_device *device,
 		efi_earlycon_scroll_up();
 
 	device->con->write = efi_earlycon_write;
+	earlycon_console = device->con;
 	return 0;
 }
 EARLYCON_DECLARE(efifb, efi_earlycon_setup);
