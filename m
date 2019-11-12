Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18BC6F9543
	for <lists+linux-efi@lfdr.de>; Tue, 12 Nov 2019 17:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfKLQMr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 12 Nov 2019 11:12:47 -0500
Received: from mga05.intel.com ([192.55.52.43]:24455 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbfKLQMr (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 12 Nov 2019 11:12:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2019 08:12:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,297,1569308400"; 
   d="scan'208";a="202458465"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 12 Nov 2019 08:12:44 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 96EF0FD; Tue, 12 Nov 2019 18:12:43 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-efi@vger.kernel.org, mika.westerberg@linux.intel.com
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Matt Fleming <matt@codeblueprint.co.uk>
Subject: [PATCH v2] efi/earlycon: Remap entire framebuffer after page initialization
Date:   Tue, 12 Nov 2019 18:12:40 +0200
Message-Id: <20191112161240.4734-1-andriy.shevchenko@linux.intel.com>
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
This led to two regressions:
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
v2:
- add __exitcall()
- swap type and attribute for __init / __exit functions as most used in the kernel
 drivers/firmware/efi/earlycon.c | 34 +++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/firmware/efi/earlycon.c b/drivers/firmware/efi/earlycon.c
index c9a0efca17b0..8c6a3c67b7f2 100644
--- a/drivers/firmware/efi/earlycon.c
+++ b/drivers/firmware/efi/earlycon.c
@@ -17,14 +17,48 @@ static const struct font_desc *font;
 static u32 efi_x, efi_y;
 static u64 fb_base;
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
+	u32 size;
+
+	size = screen_info.lfb_size;
+	if (pgprot_val(fb_prot) == pgprot_val(PAGE_KERNEL))
+		efi_fb = memremap(fb_base, size, MEMREMAP_WB);
+	else
+		efi_fb = memremap(fb_base, size, MEMREMAP_WC);
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
 
-- 
2.24.0

