Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50F0DFE143
	for <lists+linux-efi@lfdr.de>; Fri, 15 Nov 2019 16:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfKOPbH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 Nov 2019 10:31:07 -0500
Received: from mga03.intel.com ([134.134.136.65]:22089 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727443AbfKOPbH (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 15 Nov 2019 10:31:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 07:31:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,308,1569308400"; 
   d="scan'208";a="203609015"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 15 Nov 2019 07:31:04 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 70EDDEB; Fri, 15 Nov 2019 17:31:03 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-efi@vger.kernel.org, mika.westerberg@linux.intel.com
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Matt Fleming <matt@codeblueprint.co.uk>
Subject: [PATCH v3] efi/earlycon: Remap entire framebuffer after page initialization
Date:   Fri, 15 Nov 2019 17:31:02 +0200
Message-Id: <20191115153102.51921-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When the commit 69c1f396f25b ("efi/x86: Convert x86 EFI earlyprintk
into generic earlycon implementation") moved x86 specific EFI earlyprintk
implementation to shared location it also tweaked the behaviour. In particular
it dropped a trick with full framebuffer remapping after page initialization.
This lead to two regressions:
1) very slow scrolling after page initialization;
2) kernel hang when keep_bootcon parameter is being provided.

Returning the trick back fixes #2 and mitigates, i.e. reduces the window when
slowness appears, #1 presumably due to eliminating heavy map()/unmap()
operations per each pixel line on the screen.

Fixes: 69c1f396f25b ("efi/x86: Convert x86 EFI earlyprintk into generic earlycon implementation")
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Alexander Graf <agraf@suse.de>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3:
- assign size in efi_earlycon_setup()
- check base and size before mapping in early_efi_map_fb()
 drivers/firmware/efi/earlycon.c | 37 +++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/firmware/efi/earlycon.c b/drivers/firmware/efi/earlycon.c
index c9a0efca17b0..60b5350c6105 100644
--- a/drivers/firmware/efi/earlycon.c
+++ b/drivers/firmware/efi/earlycon.c
@@ -16,15 +16,50 @@
 static const struct font_desc *font;
 static u32 efi_x, efi_y;
 static u64 fb_base;
+static u32 fb_size;
 static pgprot_t fb_prot;
+static void *efi_fb;
+
+/*
+ * efi earlycon needs to use early_memremap() to map the framebuffer.
+ * But early_memremap() is not usable for 'earlycon=efifb keep_bootcon',
+ * memremap() should be used instead. memremap() will be available after
+ * paging_init() which is earlier than initcall callbacks. Thus adding this
+ * early initcall function early_efi_map_fb() to map the whole efi framebuffer.
+ */
+static int __init early_efi_map_fb(void)
+{
+	if (!fb_base || !fb_size)
+		return NULL;
+
+	if (pgprot_val(fb_prot) == pgprot_val(PAGE_KERNEL))
+		efi_fb = memremap(fb_base, fb_size, MEMREMAP_WB);
+	else
+		efi_fb = memremap(fb_base, fb_size, MEMREMAP_WC);
+
+	return efi_fb ? 0 : -ENOMEM;
+}
+early_initcall(early_efi_map_fb);
+
+static void __exit early_efi_unmap_fb(void)
+{
+	memunmap(efi_fb);
+}
+__exitcall(early_efi_unmap_fb);
 
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
 
@@ -176,6 +211,8 @@ static int __init efi_earlycon_setup(struct earlycon_device *device,
 	if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
 		fb_base |= (u64)screen_info.ext_lfb_base << 32;
 
+	fb_size = screen_info.lfb_size;
+
 	if (opt && !strcmp(opt, "ram"))
 		fb_prot = PAGE_KERNEL;
 	else
-- 
2.24.0

