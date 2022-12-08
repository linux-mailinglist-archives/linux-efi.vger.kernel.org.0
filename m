Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BD86478A8
	for <lists+linux-efi@lfdr.de>; Thu,  8 Dec 2022 23:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiLHWMN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Dec 2022 17:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiLHWMD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 8 Dec 2022 17:12:03 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2DB27DE5;
        Thu,  8 Dec 2022 14:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670537522; x=1702073522;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vvU4PeGKvcYxDi2SGTd4kcVlxgzXOYX6SRbtggkIuPw=;
  b=ae/SWJ3Y2JnS7cvEQi/jUCcnM9H3ovnCOnSuo5XnjS2ZTOdnis1B91md
   FMdKCzIpvlogbG/vPfNg+1wHILv+6ct98S+mtFwUrvHYGcpywy0HKsBDa
   G8aQ9yLza194DmtqYwdWXYURLvxY0xXrx4ot03b9bV83VRHpYRbnzfQzw
   I3ioZFJwGG81Ku7RtDzuN476HFzBMksfGHNLpTPHMxHAH0ooxZLGlQDux
   ir7dLf+qXBRcXqzvK/dHNkMzId+VkmuhDcDacfr1oJcymsBg96dJJ4uew
   dzYVfnSh1XjW8QiOkktGkjbzjzghgOVbKNBQX89S0k10EPu6NLFBJHm11
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="300735872"
X-IronPort-AV: E=Sophos;i="5.96,228,1665471600"; 
   d="scan'208";a="300735872"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 14:11:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="649335508"
X-IronPort-AV: E=Sophos;i="5.96,228,1665471600"; 
   d="scan'208";a="649335508"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 08 Dec 2022 14:11:56 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C3423433; Fri,  9 Dec 2022 00:12:24 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v1 2/2] efi/earlycon: Speed up scrolling by skiping moving empty space
Date:   Fri,  9 Dec 2022 00:12:17 +0200
Message-Id: <20221208221217.56354-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221208221217.56354-1-andriy.shevchenko@linux.intel.com>
References: <20221208221217.56354-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Currently the scroll copies the full screen which is slow on
the hi-resolution displays. At the same time most of the screen
is an empty space which has no need to be copied over and over.

Optimize the scrolling algorithm by caching the x coordinates
of the last printed lines and scroll in accordance with the
maximum x in that cache.

On my Microsoft Surface Book (the first version) this produces
a significant speedup of the console 90 seconds vs. 168 seconds
with the kernel command line having

	ignore_loglevel earlycon=efifb keep_bootcon

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/firmware/efi/earlycon.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/earlycon.c b/drivers/firmware/efi/earlycon.c
index be7c83b6cd10..f54e6fdf08e2 100644
--- a/drivers/firmware/efi/earlycon.c
+++ b/drivers/firmware/efi/earlycon.c
@@ -16,6 +16,8 @@
 
 static const struct console *earlycon_console __initdata;
 static const struct font_desc *font;
+static u16 cur_line_y, max_line_y;
+static u32 efi_x_array[1024];
 static u32 efi_x, efi_y;
 static u64 fb_base;
 static bool fb_wb;
@@ -86,9 +88,17 @@ static void efi_earlycon_clear_scanline(unsigned int y)
 static void efi_earlycon_scroll_up(void)
 {
 	unsigned long *dst, *src;
+	u16 maxlen = 0;
 	u16 len;
 	u32 i, height;
 
+	/* Find the cached maximum x coordinate */
+	for (i = 0; i < max_line_y; i++) {
+		if (efi_x_array[i] > maxlen)
+			maxlen = efi_x_array[i];
+	}
+	maxlen *= 4;
+
 	len = screen_info.lfb_linelength;
 	height = screen_info.lfb_height;
 
@@ -103,7 +113,7 @@ static void efi_earlycon_scroll_up(void)
 			return;
 		}
 
-		memmove(dst, src, len);
+		memmove(dst, src, maxlen);
 
 		efi_earlycon_unmap(src, len);
 		efi_earlycon_unmap(dst, len);
@@ -136,6 +146,7 @@ static void
 efi_earlycon_write(struct console *con, const char *str, unsigned int num)
 {
 	struct screen_info *si;
+	u32 cur_efi_x = efi_x;
 	unsigned int len;
 	const char *s;
 	void *dst;
@@ -176,6 +187,7 @@ efi_earlycon_write(struct console *con, const char *str, unsigned int num)
 		str += count;
 
 		if (num > 0 && *s == '\n') {
+			cur_efi_x = efi_x;
 			efi_x = 0;
 			efi_y += font->height;
 			str++;
@@ -183,6 +195,7 @@ efi_earlycon_write(struct console *con, const char *str, unsigned int num)
 		}
 
 		if (efi_x + font->width > si->lfb_width) {
+			cur_efi_x = efi_x;
 			efi_x = 0;
 			efi_y += font->height;
 		}
@@ -190,6 +203,9 @@ efi_earlycon_write(struct console *con, const char *str, unsigned int num)
 		if (efi_y + font->height > si->lfb_height) {
 			u32 i;
 
+			efi_x_array[cur_line_y] = cur_efi_x;
+			cur_line_y = (cur_line_y + 1) % max_line_y;
+
 			efi_y -= font->height;
 			efi_earlycon_scroll_up();
 
@@ -230,7 +246,15 @@ static int __init efi_earlycon_setup(struct earlycon_device *device,
 	if (!font)
 		return -ENODEV;
 
-	efi_y = rounddown(yres, font->height) - font->height;
+	/* Fill the cache with maximum possible value of x coordinate */
+	memset32(efi_x_array, rounddown(xres, font->width), ARRAY_SIZE(efi_x_array));
+	efi_y = rounddown(yres, font->height);
+
+	/* Make sure we have cache for the x coordinate for the full screen */
+	max_line_y = efi_y / font->height + 1;
+	cur_line_y = 0;
+
+	efi_y -= font->height;
 	for (i = 0; i < (yres - efi_y) / font->height; i++)
 		efi_earlycon_scroll_up();
 
-- 
2.35.1

