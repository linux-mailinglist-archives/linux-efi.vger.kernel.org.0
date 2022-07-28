Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990BC58413D
	for <lists+linux-efi@lfdr.de>; Thu, 28 Jul 2022 16:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbiG1O3w (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Jul 2022 10:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbiG1O3b (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 Jul 2022 10:29:31 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712A867C9B;
        Thu, 28 Jul 2022 07:29:03 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z15so2394343edc.7;
        Thu, 28 Jul 2022 07:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yEgZLwSNojzjlHThJFtJWVMPDAV4d3Y7zlW15rr2kME=;
        b=WZEhs/KyhuLZEc/Hug69GqwS+mPkSEaYw0/XJQAEW1XiVKBAMX2SD4O18JtIPUAWOs
         1AWxJk1S3GGu4B+ZKRTxuIFhq+o4eP7HGE9VNYDZzJtpgWmDolykISjlgiQO+oLYT8Bg
         XNluILq6jf3s4lNpkTk3oeXwPFNMgXNyT7Td+Faiev06lP+Wv4wRTOhLumMwyukd6nTX
         y7uI9SstX5PPwfhvRVfkb3bNTNXtGOUIVTvLQ7wB2agaMoo744J6lYlrq5rLelmnHP9Z
         XM2XDmS4BvJsl+BhQ7YvhevDynUH/Se7IrBhMHZboN0XiGgs0JkRlcrdFwBWACPA6sGy
         6wvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yEgZLwSNojzjlHThJFtJWVMPDAV4d3Y7zlW15rr2kME=;
        b=bayXweqeEB47CCMeetO1gZkKl4TTpF9S24+ZP0qqIQX8vGFHrNMeH1vmJtSGAUsy6j
         paVmEqDql6h/rCA6Z6jbEweVWkp9RWMEbBYR4sKPoO01IYoSPwjoYSR+2QiewUXO1QNR
         NQGh0SKrvGsCQsT5Gtf7DTp0ZoWRXy8EtIKooAyASdtnEvBb1bhAWDyHjaBocCy9rJ0Y
         E2KkvbD2XAwz9S/QgJuowxwCh0cZIvMSjnw1Oe1rsPWeuIrWBSRdtGooGBQU8V8n3wuT
         GvGtfyTwxyjsXb8Ph+io/hiznceg91gx7ny7iIU1eS65i293bw/iyOuwY9KAaW9kgODi
         IcOQ==
X-Gm-Message-State: AJIora+cVCQIiWwPiKQnfiV2ShmdSyUgl/gWYJCzaFPVBhO7KplR65NX
        Xr2pIPjlSRY5vfFN39AyvQA7ILCVP0MAF68o
X-Google-Smtp-Source: AGRyM1sIO4Fp+YQOasaqJeyHF7woOb9BeSRiNtDnR7PNieIUOrpwtNrRsbMEJKDqiAaDerube8zjNQ==
X-Received: by 2002:a05:6402:11d3:b0:43c:436b:829 with SMTP id j19-20020a05640211d300b0043c436b0829mr13568320edw.324.1659018541031;
        Thu, 28 Jul 2022 07:29:01 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([23.154.177.9])
        by smtp.gmail.com with ESMTPSA id y1-20020aa7d501000000b0043cce1d3a0fsm755949edq.87.2022.07.28.07.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 07:29:00 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Markuss Broks <markuss.broks@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Helge Deller <deller@gmx.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Michal Suchanek <msuchanek@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Wei Ming Chen <jj251510319013@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tony Lindgren <tony@atomide.com>, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 2/2] efi: earlycon: Add support for generic framebuffers and move to fbdev subsystem
Date:   Thu, 28 Jul 2022 17:28:19 +0300
Message-Id: <20220728142824.3836-3-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220728142824.3836-1-markuss.broks@gmail.com>
References: <20220728142824.3836-1-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add early console support for generic linear framebuffer devices.
This driver supports probing from cmdline early parameters
or from the device-tree using information in simple-framebuffer node.
The EFI functionality should be retained in whole.
The driver was disabled on ARM because of a bug in early_ioremap
implementation on ARM.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 .../admin-guide/kernel-parameters.txt         |  12 +-
 MAINTAINERS                                   |   5 +
 drivers/firmware/efi/Kconfig                  |   6 +-
 drivers/firmware/efi/Makefile                 |   1 -
 drivers/firmware/efi/earlycon.c               | 246 --------------
 drivers/video/fbdev/Kconfig                   |  11 +
 drivers/video/fbdev/Makefile                  |   1 +
 drivers/video/fbdev/earlycon.c                | 301 ++++++++++++++++++
 8 files changed, 327 insertions(+), 256 deletions(-)
 delete mode 100644 drivers/firmware/efi/earlycon.c
 create mode 100644 drivers/video/fbdev/earlycon.c

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 8090130b544b0701237a7b657a29c83c000a60f4..22a8625bb342f95e731fcc3a24390fca2c0f194c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1281,12 +1281,9 @@
 			specified address. The serial port must already be
 			setup and configured. Options are not yet supported.
 
-		efifb,[options]
+		efifb
 			Start an early, unaccelerated console on the EFI
-			memory mapped framebuffer (if available). On cache
-			coherent non-x86 systems that use system memory for
-			the framebuffer, pass the 'ram' option so that it is
-			mapped with the correct attributes.
+			memory mapped framebuffer (if available).
 
 		linflex,<addr>
 			Use early console provided by Freescale LINFlexD UART
@@ -1294,6 +1291,11 @@
 			address must be provided, and the serial port must
 			already be setup and configured.
 
+		simplefb,<addr>,<width>,<height>,<bpp>
+			Use early console with simple framebuffer that is
+			pre-initialized by firmware. A valid base address,
+			width, height and pixel size must be provided.
+
 	earlyprintk=	[X86,SH,ARM,M68k,S390]
 			earlyprintk=vga
 			earlyprintk=sclp
diff --git a/MAINTAINERS b/MAINTAINERS
index 1fc9ead83d2aa3e60ccc4cfa8ee16df09ef579bf..140dee7f6920197a895d310afdde67a0de474522 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7033,6 +7033,11 @@ Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 T:	git git://linuxtv.org/anttip/media_tree.git
 F:	drivers/media/tuners/e4000*
 
+EARLY CONSOLE FRAMEBUFFER DRIVER
+M:	Markuss Broks <markuss.broks@gmail.com>
+S:	Maintained
+F:	drivers/video/fbdev/earlycon.c
+
 EARTH_PT1 MEDIA DRIVER
 M:	Akihiro Tsukada <tskd08@gmail.com>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 7aa4717cdcac46f91dd202f868c463388eb02735..56241b2e19383d70387f07114a27bb4f33ac7857 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -259,10 +259,8 @@ config EFI_DISABLE_PCI_DMA
 	  may be used to override this option.
 
 config EFI_EARLYCON
-	def_bool y
-	depends on SERIAL_EARLYCON && !ARM && !IA64
-	select FONT_SUPPORT
-	select ARCH_USE_MEMREMAP_PROT
+	bool "EFI early console support"
+	depends on FB_EARLYCON && !IA64
 
 config EFI_CUSTOM_SSDT_OVERLAYS
 	bool "Load custom ACPI SSDT overlay from an EFI variable"
diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index c02ff25dd47707090a2ab86ee4f330e467f878f5..64eea61fbb43d76ec2d5416d467dfbb9aa21bda0 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -44,6 +44,5 @@ obj-$(CONFIG_ARM64)			+= $(arm-obj-y)
 riscv-obj-$(CONFIG_EFI)			:= efi-init.o riscv-runtime.o
 obj-$(CONFIG_RISCV)			+= $(riscv-obj-y)
 obj-$(CONFIG_EFI_CAPSULE_LOADER)	+= capsule-loader.o
-obj-$(CONFIG_EFI_EARLYCON)		+= earlycon.o
 obj-$(CONFIG_UEFI_CPER_ARM)		+= cper-arm.o
 obj-$(CONFIG_UEFI_CPER_X86)		+= cper-x86.o
diff --git a/drivers/firmware/efi/earlycon.c b/drivers/firmware/efi/earlycon.c
deleted file mode 100644
index a52236e11e5f73ddea5bb1f42ca2ca7c42425dab..0000000000000000000000000000000000000000
--- a/drivers/firmware/efi/earlycon.c
+++ /dev/null
@@ -1,246 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2013 Intel Corporation; author Matt Fleming
- */
-
-#include <linux/console.h>
-#include <linux/efi.h>
-#include <linux/font.h>
-#include <linux/io.h>
-#include <linux/kernel.h>
-#include <linux/serial_core.h>
-#include <linux/screen_info.h>
-
-#include <asm/early_ioremap.h>
-
-static const struct console *earlycon_console __initdata;
-static const struct font_desc *font;
-static u32 efi_x, efi_y;
-static u64 fb_base;
-static bool fb_wb;
-static void *efi_fb;
-
-/*
- * EFI earlycon needs to use early_memremap() to map the framebuffer.
- * But early_memremap() is not usable for 'earlycon=efifb keep_bootcon',
- * memremap() should be used instead. memremap() will be available after
- * paging_init() which is earlier than initcall callbacks. Thus adding this
- * early initcall function early_efi_map_fb() to map the whole EFI framebuffer.
- */
-static int __init efi_earlycon_remap_fb(void)
-{
-	/* bail if there is no bootconsole or it has been disabled already */
-	if (!earlycon_console || !(earlycon_console->flags & CON_ENABLED))
-		return 0;
-
-	efi_fb = memremap(fb_base, screen_info.lfb_size,
-			  fb_wb ? MEMREMAP_WB : MEMREMAP_WC);
-
-	return efi_fb ? 0 : -ENOMEM;
-}
-early_initcall(efi_earlycon_remap_fb);
-
-static int __init efi_earlycon_unmap_fb(void)
-{
-	/* unmap the bootconsole fb unless keep_bootcon has left it enabled */
-	if (efi_fb && !(earlycon_console->flags & CON_ENABLED))
-		memunmap(efi_fb);
-	return 0;
-}
-late_initcall(efi_earlycon_unmap_fb);
-
-static __ref void *efi_earlycon_map(unsigned long start, unsigned long len)
-{
-	pgprot_t fb_prot;
-
-	if (efi_fb)
-		return efi_fb + start;
-
-	fb_prot = fb_wb ? PAGE_KERNEL : pgprot_writecombine(PAGE_KERNEL);
-	return early_memremap_prot(fb_base + start, len, pgprot_val(fb_prot));
-}
-
-static __ref void efi_earlycon_unmap(void *addr, unsigned long len)
-{
-	if (efi_fb)
-		return;
-
-	early_memunmap(addr, len);
-}
-
-static void efi_earlycon_clear_scanline(unsigned int y)
-{
-	unsigned long *dst;
-	u16 len;
-
-	len = screen_info.lfb_linelength;
-	dst = efi_earlycon_map(y*len, len);
-	if (!dst)
-		return;
-
-	memset(dst, 0, len);
-	efi_earlycon_unmap(dst, len);
-}
-
-static void efi_earlycon_scroll_up(void)
-{
-	unsigned long *dst, *src;
-	u16 len;
-	u32 i, height;
-
-	len = screen_info.lfb_linelength;
-	height = screen_info.lfb_height;
-
-	for (i = 0; i < height - font->height; i++) {
-		dst = efi_earlycon_map(i*len, len);
-		if (!dst)
-			return;
-
-		src = efi_earlycon_map((i + font->height) * len, len);
-		if (!src) {
-			efi_earlycon_unmap(dst, len);
-			return;
-		}
-
-		memmove(dst, src, len);
-
-		efi_earlycon_unmap(src, len);
-		efi_earlycon_unmap(dst, len);
-	}
-}
-
-static void efi_earlycon_write_char(u32 *dst, unsigned char c, unsigned int h)
-{
-	const u32 color_black = 0x00000000;
-	const u32 color_white = 0x00ffffff;
-	const u8 *src;
-	int m, n, bytes;
-	u8 x;
-
-	bytes = BITS_TO_BYTES(font->width);
-	src = font->data + c * font->height * bytes + h * bytes;
-
-	for (m = 0; m < font->width; m++) {
-		n = m % 8;
-		x = *(src + m / 8);
-		if ((x >> (7 - n)) & 1)
-			*dst = color_white;
-		else
-			*dst = color_black;
-		dst++;
-	}
-}
-
-static void
-efi_earlycon_write(struct console *con, const char *str, unsigned int num)
-{
-	struct screen_info *si;
-	unsigned int len;
-	const char *s;
-	void *dst;
-
-	si = &screen_info;
-	len = si->lfb_linelength;
-
-	while (num) {
-		unsigned int linemax;
-		unsigned int h, count = 0;
-
-		for (s = str; *s && *s != '\n'; s++) {
-			if (count == num)
-				break;
-			count++;
-		}
-
-		linemax = (si->lfb_width - efi_x) / font->width;
-		if (count > linemax)
-			count = linemax;
-
-		for (h = 0; h < font->height; h++) {
-			unsigned int n, x;
-
-			dst = efi_earlycon_map((efi_y + h) * len, len);
-			if (!dst)
-				return;
-
-			s = str;
-			n = count;
-			x = efi_x;
-
-			while (n-- > 0) {
-				efi_earlycon_write_char(dst + x*4, *s, h);
-				x += font->width;
-				s++;
-			}
-
-			efi_earlycon_unmap(dst, len);
-		}
-
-		num -= count;
-		efi_x += count * font->width;
-		str += count;
-
-		if (num > 0 && *s == '\n') {
-			efi_x = 0;
-			efi_y += font->height;
-			str++;
-			num--;
-		}
-
-		if (efi_x + font->width > si->lfb_width) {
-			efi_x = 0;
-			efi_y += font->height;
-		}
-
-		if (efi_y + font->height > si->lfb_height) {
-			u32 i;
-
-			efi_y -= font->height;
-			efi_earlycon_scroll_up();
-
-			for (i = 0; i < font->height; i++)
-				efi_earlycon_clear_scanline(efi_y + i);
-		}
-	}
-}
-
-static int __init efi_earlycon_setup(struct earlycon_device *device,
-				     const char *opt)
-{
-	struct screen_info *si;
-	u16 xres, yres;
-	u32 i;
-
-	if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
-		return -ENODEV;
-
-	fb_base = screen_info.lfb_base;
-	if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
-		fb_base |= (u64)screen_info.ext_lfb_base << 32;
-
-	fb_wb = opt && !strcmp(opt, "ram");
-
-	si = &screen_info;
-	xres = si->lfb_width;
-	yres = si->lfb_height;
-
-	/*
-	 * efi_earlycon_write_char() implicitly assumes a framebuffer with
-	 * 32 bits per pixel.
-	 */
-	if (si->lfb_depth != 32)
-		return -ENODEV;
-
-	font = get_default_font(xres, yres, -1, -1);
-	if (!font)
-		return -ENODEV;
-
-	efi_y = rounddown(yres, font->height) - font->height;
-	for (i = 0; i < (yres - efi_y) / font->height; i++)
-		efi_earlycon_scroll_up();
-
-	device->con->write = efi_earlycon_write;
-	earlycon_console = device->con;
-	return 0;
-}
-EARLYCON_DECLARE(efifb, efi_earlycon_setup);
diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index f2a6b81e45c41334db71cca35f4fa5a827f728fe..2bb3f7a9e6e0f8ad2e9042d8c602b1cdec30755c 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -627,6 +627,17 @@ config FB_VESA
 	  You will get a boot time penguin logo at no additional cost. Please
 	  read <file:Documentation/fb/vesafb.rst>. If unsure, say Y.
 
+config FB_EARLYCON
+	bool "Generic framebuffer early console"
+	depends on FB && SERIAL_EARLYCON && !ARM
+	select FONT_SUPPORT
+	select ARCH_USE_MEMREMAP_PROT
+	help
+	  Say Y here if you want early console support for firmware established
+	  linear framebuffer. Unless you are using EFI framebuffer, you need to
+	  specify framebuffer geometry and address in device-tree or in kernel
+	  command line.
+
 config FB_EFI
 	bool "EFI-based Framebuffer Support"
 	depends on (FB = y) && !IA64 && EFI
diff --git a/drivers/video/fbdev/Makefile b/drivers/video/fbdev/Makefile
index 7795c4126706fd7bb832d94da5d14b0060849d1f..07406ab45a3f306a07d008a9f0a401347aeaa695 100644
--- a/drivers/video/fbdev/Makefile
+++ b/drivers/video/fbdev/Makefile
@@ -129,6 +129,7 @@ obj-$(CONFIG_FB_MX3)		  += mx3fb.o
 obj-$(CONFIG_FB_DA8XX)		  += da8xx-fb.o
 obj-$(CONFIG_FB_SSD1307)	  += ssd1307fb.o
 obj-$(CONFIG_FB_SIMPLE)           += simplefb.o
+obj-$(CONFIG_FB_EARLYCON)         += earlycon.o
 
 # the test framebuffer is last
 obj-$(CONFIG_FB_VIRTUAL)          += vfb.o
diff --git a/drivers/video/fbdev/earlycon.c b/drivers/video/fbdev/earlycon.c
new file mode 100644
index 0000000000000000000000000000000000000000..5f6f4b228a50f23c1c77cf7ba5d50ff833efdd46
--- /dev/null
+++ b/drivers/video/fbdev/earlycon.c
@@ -0,0 +1,301 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2013 Intel Corporation; author Matt Fleming
+ * Copyright (C) 2022 Markuss Broks <markuss.broks@gmail.com>
+ */
+
+#include <asm/early_ioremap.h>
+#include <linux/console.h>
+#include <linux/efi.h>
+#include <linux/font.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <linux/serial_core.h>
+#include <linux/screen_info.h>
+
+struct fb_earlycon {
+	u32 x, y, curr_x, curr_y, depth, stride;
+	size_t size;
+	phys_addr_t phys_base;
+	void __iomem *virt_base;
+};
+
+static const struct console *earlycon_console __initconst;
+static struct fb_earlycon info;
+static const struct font_desc *font;
+
+static int __init simplefb_earlycon_remap_fb(void)
+{
+	int is_ram;
+	/* bail if there is no bootconsole or it has been disabled already */
+	if (!earlycon_console || !(earlycon_console->flags & CON_ENABLED))
+		return 0;
+
+	is_ram = region_intersects(info.phys_base, info.size,
+				   IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE);
+	is_ram = is_ram == REGION_INTERSECTS;
+
+	info.virt_base = memremap(info.phys_base, info.size,
+				  is_ram ? MEMREMAP_WB : MEMREMAP_WC);
+
+	return info.virt_base ? 0 : -ENOMEM;
+}
+early_initcall(simplefb_earlycon_remap_fb);
+
+static int __init simplefb_earlycon_unmap_fb(void)
+{
+	/* unmap the bootconsole fb unless keep_bootcon has left it enabled */
+	if (info.virt_base && !(earlycon_console->flags & CON_ENABLED))
+		memunmap(info.virt_base);
+	return 0;
+}
+late_initcall(simplefb_earlycon_unmap_fb);
+
+static __ref void *simplefb_earlycon_map(unsigned long start, unsigned long len)
+{
+	pgprot_t fb_prot;
+
+	if (info.virt_base)
+		return info.virt_base + start;
+
+	fb_prot = PAGE_KERNEL;
+	return early_memremap_prot(info.phys_base + start, len, pgprot_val(fb_prot));
+}
+
+static __ref void simplefb_earlycon_unmap(void *addr, unsigned long len)
+{
+	if (info.virt_base)
+		return;
+
+	early_memunmap(addr, len);
+}
+
+static void simplefb_earlycon_clear_scanline(unsigned int y)
+{
+	unsigned long *dst;
+	u16 len;
+
+	len = info.stride;
+	dst = simplefb_earlycon_map(y * len, len);
+	if (!dst)
+		return;
+
+	memset(dst, 0, len);
+	simplefb_earlycon_unmap(dst, len);
+}
+
+static void simplefb_earlycon_scroll_up(void)
+{
+	unsigned long *dst, *src;
+	u16 len;
+	u32 i, height;
+
+	len = info.stride;
+	height = info.y;
+
+	for (i = 0; i < height - font->height; i++) {
+		dst = simplefb_earlycon_map(i * len, len);
+		if (!dst)
+			return;
+
+		src = simplefb_earlycon_map((i + font->height) * len, len);
+		if (!src) {
+			simplefb_earlycon_unmap(dst, len);
+			return;
+		}
+
+		memmove(dst, src, len);
+
+		simplefb_earlycon_unmap(src, len);
+		simplefb_earlycon_unmap(dst, len);
+	}
+}
+
+static void simplefb_earlycon_write_char(u8 *dst, unsigned char c, unsigned int h)
+{
+	const u8 *src;
+	int m, n, bytes;
+	u8 x;
+
+	bytes = BITS_TO_BYTES(font->width);
+	src = font->data + c * font->height * bytes + h * bytes;
+
+	for (m = 0; m < font->width; m++) {
+		n = m % 8;
+		x = *(src + m / 8);
+		if ((x >> (7 - n)) & 1)
+			memset(dst, 0xff, (info.depth / 8));
+		else
+			memset(dst, 0, (info.depth / 8));
+		dst += (info.depth / 8);
+	}
+}
+
+static void
+simplefb_earlycon_write(struct console *con, const char *str, unsigned int num)
+{
+	unsigned int len;
+	const char *s;
+	void *dst;
+
+	len = info.stride;
+
+	while (num) {
+		unsigned int linemax;
+		unsigned int h, count = 0;
+
+		for (s = str; *s && *s != '\n'; s++) {
+			if (count == num)
+				break;
+			count++;
+		}
+
+		linemax = (info.x - info.curr_x) / font->width;
+		if (count > linemax)
+			count = linemax;
+
+		for (h = 0; h < font->height; h++) {
+			unsigned int n, x;
+
+			dst = simplefb_earlycon_map((info.curr_y + h) * len, len);
+			if (!dst)
+				return;
+
+			s = str;
+			n = count;
+			x = info.curr_x;
+
+			while (n-- > 0) {
+				simplefb_earlycon_write_char(dst + (x * 4), *s, h);
+				x += font->width;
+				s++;
+			}
+
+			simplefb_earlycon_unmap(dst, len);
+		}
+
+		num -= count;
+		info.curr_x += count * font->width;
+		str += count;
+
+		if (num > 0 && *s == '\n') {
+			info.curr_x = 0;
+			info.curr_y += font->height;
+			str++;
+			num--;
+		}
+
+		if (info.curr_x + font->width > info.x) {
+			info.curr_x = 0;
+			info.curr_y += font->height;
+		}
+
+		if (info.curr_y + font->height > info.y) {
+			u32 i;
+
+			info.curr_y -= font->height;
+			simplefb_earlycon_scroll_up();
+
+			for (i = 0; i < font->height; i++)
+				simplefb_earlycon_clear_scanline(info.curr_y + i);
+		}
+	}
+}
+
+static int __init simplefb_earlycon_setup_common(struct earlycon_device *device,
+						 const char *opt)
+{
+	int i;
+
+	info.stride = info.x * 4;
+	info.size = info.x * info.y * (info.depth / 8);
+
+	font = get_default_font(info.x, info.y, -1, -1);
+	if (!font)
+		return -ENODEV;
+
+	info.curr_y = rounddown(info.y, font->height) - font->height;
+	for (i = 0; i < (info.y - info.curr_y) / font->height; i++)
+		simplefb_earlycon_scroll_up();
+
+	device->con->write = simplefb_earlycon_write;
+	earlycon_console = device->con;
+	return 0;
+}
+
+static int __init simplefb_earlycon_setup(struct earlycon_device *device,
+					  const char *opt)
+{
+	struct uart_port *port = &device->port;
+	int ret;
+
+	if (!port->mapbase)
+		return -ENODEV;
+
+	info.phys_base = port->mapbase;
+
+	ret = sscanf(device->options, "%u,%u,%u", &info.x, &info.y, &info.depth);
+	if (ret != 3)
+		return -ENODEV;
+
+	return simplefb_earlycon_setup_common(device, opt);
+}
+
+EARLYCON_DECLARE(simplefb, simplefb_earlycon_setup);
+
+#ifdef CONFIG_EFI_EARLYCON
+static int __init simplefb_earlycon_setup_efi(struct earlycon_device *device,
+					      const char *opt)
+{
+	if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
+		return -ENODEV;
+
+	info.phys_base = screen_info.lfb_base;
+	if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
+		info.phys_base |= (u64)screen_info.ext_lfb_base << 32;
+
+	info.x = screen_info.lfb_width;
+	info.y = screen_info.lfb_height;
+	info.depth = screen_info.lfb_depth;
+
+	return simplefb_earlycon_setup_common(device, opt);
+}
+
+EARLYCON_DECLARE(efifb, simplefb_earlycon_setup_efi);
+#endif
+
+#ifdef CONFIG_OF_EARLY_FLATTREE
+static int __init simplefb_earlycon_setup_of(struct earlycon_device *device,
+					     const char *opt)
+{
+	struct uart_port *port = &device->port;
+	const __be32 *val;
+
+	if (!port->mapbase)
+		return -ENODEV;
+
+	info.phys_base = port->mapbase;
+
+	val = of_get_flat_dt_prop(device->node, "width", NULL);
+	if (!val)
+		return -ENODEV;
+	info.x = be32_to_cpu(*val);
+
+	val = of_get_flat_dt_prop(device->node, "height", NULL);
+	if (!val)
+		return -ENODEV;
+	info.y = be32_to_cpu(*val);
+
+	val = of_get_flat_dt_prop(device->node, "stride", NULL);
+	if (!val)
+		return -ENODEV;
+	info.depth = (be32_to_cpu(*val) / info.x) * 8;
+
+	return simplefb_earlycon_setup_common(device, opt);
+}
+
+OF_EARLYCON_DECLARE(simplefb, "simple-framebuffer", simplefb_earlycon_setup_of);
+#endif
-- 
2.37.0

