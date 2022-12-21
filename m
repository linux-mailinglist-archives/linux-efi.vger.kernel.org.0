Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C97652FF4
	for <lists+linux-efi@lfdr.de>; Wed, 21 Dec 2022 11:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbiLUKzJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Dec 2022 05:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbiLUKyz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Dec 2022 05:54:55 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87C42034D;
        Wed, 21 Dec 2022 02:54:46 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id y16so14538803wrm.2;
        Wed, 21 Dec 2022 02:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EO088aMS/Wq4R54M5yGt0xF6AGfb9mcV1zfE52C298k=;
        b=fadDW8ROx9I5Vz4QIEARmZyYrWo/cLX5a3F8xtL8BfaP84pcoC5SWoqRuKrtlkOGRN
         VJqYE1eaCtQt65oFa5GEIIWvPh2n6XyCauZVpi6Vqr1lq7HEQZRfnk64Cijon1sxEbjc
         a/vc0ro+qtBnnV0Xka1F2G5GrVm2CTgUwtUbyjUoDvaY7CU3EdMQhxZ7DnuEWpjf2hpD
         zX4m7ozFb8jJEpgyrs20Fl26vcZuBRlOCd9cBVPdF3SWAHXnRJEJknkDMA1u6ac07Mcf
         fLS0trCwlfd6Ar9/NywujncHDoGsANYrVeub7I66g3W0HINVMNJAEmrYk4o+ce7HVaQ6
         EWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EO088aMS/Wq4R54M5yGt0xF6AGfb9mcV1zfE52C298k=;
        b=ewrwoVoFAAI6kbq9kiHEY6uyQp14pRm9QoD9AGC1jRQ228RXUoEgHtuo+vn8QPpPQy
         T6SER8V7Gvy+ADR/BM4GntdxopGH3BAcGzUfZqKKouaGed04h4k/SQdP3H2We2Ftwgoe
         K5FHeaFBhAmnSUJx4jGKOP5oAiTKjGgWmmOUfR8IZ4KFHQz11J9EAwCVM4rWz8HPqTke
         7ZopZDokfCbUtEKrZIJxuYLFfva0beeumnuq80ueqqh8zY3vzYNVvnI8ZzpJbwLYcQSL
         I6JAlHBV2Y0Odz7QIlE95fzALexLLSeIAVhCEZ0IqY50fBSwyOxExcTp1rdFMDKUo1l7
         YbYQ==
X-Gm-Message-State: AFqh2kq8csfGtZpHzv25fEqecvx2IeMnFZjH1XEA+4LpH2QekWiMTaQr
        RFBX4GiOrFW1gZoVKf5EdXXpvSYPjYTw7Q==
X-Google-Smtp-Source: AMrXdXtYyM9TCwF56i4wxN7St9ldLZa4yCSkBpyyuV+5F+V0wLSHT855IjJCoBqt93A/C+KYj45lnQ==
X-Received: by 2002:a5d:5508:0:b0:242:865b:903a with SMTP id b8-20020a5d5508000000b00242865b903amr827767wrv.17.1671620086044;
        Wed, 21 Dec 2022 02:54:46 -0800 (PST)
Received: from localhost.localdomain ([37.55.203.63])
        by smtp.gmail.com with ESMTPSA id y5-20020a056000108500b0023657e1b980sm15080156wrw.53.2022.12.21.02.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 02:54:45 -0800 (PST)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jami Kettunen <jami.kettunen@protonmail.com>,
        Markuss Broks <markuss.broks@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Helge Deller <deller@gmx.de>, Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Muchun Song <muchun.song@linux.dev>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Kim Phillips <kim.phillips@amd.com>, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v3 3/3] efi: earlycon: Add support for generic framebuffers
Date:   Wed, 21 Dec 2022 12:54:00 +0200
Message-Id: <20221221105402.6598-4-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221221105402.6598-1-markuss.broks@gmail.com>
References: <20221221105402.6598-1-markuss.broks@gmail.com>
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
implementation on ARM and on IA64 because of lack of early_memremap_prot.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 .../admin-guide/kernel-parameters.txt         |  12 +-
 MAINTAINERS                                   |   5 +
 drivers/firmware/efi/Kconfig                  |   7 +-
 drivers/firmware/efi/Makefile                 |   1 -
 drivers/video/console/Kconfig                 |  11 +
 drivers/video/console/Makefile                |   1 +
 drivers/video/console/earlycon.c              | 247 +++++++++++-------
 7 files changed, 180 insertions(+), 104 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6cfa6e3996cf..3bfac80f9075 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1302,12 +1302,9 @@
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
@@ -1315,6 +1312,11 @@
 			address must be provided, and the serial port must
 			already be setup and configured.
 
+		simplefb,<addr>,<width>x<height>x<bpp>
+			Use early console with simple framebuffer that is
+			pre-initialized by firmware. A valid base address,
+			width, height and pixel size must be provided.
+
 	earlyprintk=	[X86,SH,ARM,M68k,S390]
 			earlyprintk=vga
 			earlyprintk=sclp
diff --git a/MAINTAINERS b/MAINTAINERS
index 30e032abd196..270a4eecadec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7373,6 +7373,11 @@ Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 T:	git git://linuxtv.org/anttip/media_tree.git
 F:	drivers/media/tuners/e4000*
 
+EARLY CONSOLE FRAMEBUFFER DRIVER
+M:	Markuss Broks <markuss.broks@gmail.com>
+S:	Maintained
+F:	drivers/video/console/earlycon.c
+
 EARTH_PT1 MEDIA DRIVER
 M:	Akihiro Tsukada <tskd08@gmail.com>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 043ca31c114e..cedb718fab78 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -223,10 +223,9 @@ config EFI_DISABLE_PCI_DMA
 	  may be used to override this option.
 
 config EFI_EARLYCON
-	def_bool y
-	depends on SERIAL_EARLYCON && !ARM && !IA64
-	select FONT_SUPPORT
-	select ARCH_USE_MEMREMAP_PROT
+	bool "EFI early console support"
+	select FB_EARLYCON
+	default y
 
 config EFI_CUSTOM_SSDT_OVERLAYS
 	bool "Load custom ACPI SSDT overlay from an EFI variable"
diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index b51f2a4c821e..ec46351ce79b 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -38,6 +38,5 @@ obj-$(CONFIG_ARM64)			+= $(arm-obj-y)
 riscv-obj-$(CONFIG_EFI)			:= efi-init.o riscv-runtime.o
 obj-$(CONFIG_RISCV)			+= $(riscv-obj-y)
 obj-$(CONFIG_EFI_CAPSULE_LOADER)	+= capsule-loader.o
-obj-$(CONFIG_EFI_EARLYCON)		+= earlycon.o
 obj-$(CONFIG_UEFI_CPER_ARM)		+= cper-arm.o
 obj-$(CONFIG_UEFI_CPER_X86)		+= cper-x86.o
diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index 22cea5082ac4..6edfeddfe5ec 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -70,6 +70,17 @@ config DUMMY_CONSOLE_ROWS
 	  monitor.
 	  Select 25 if you use a 640x480 resolution by default.
 
+config FB_EARLYCON
+	bool "Generic framebuffer early console"
+	depends on SERIAL_EARLYCON && !ARM && !IA64
+	select FONT_SUPPORT
+	select ARCH_USE_MEMREMAP_PROT
+	help
+	  Say Y here if you want early console support for firmware established
+	  linear framebuffer. Unless you are using EFI framebuffer, you need to
+	  specify framebuffer geometry and address in device-tree or in kernel
+	  command line.
+
 config FRAMEBUFFER_CONSOLE
 	bool "Framebuffer Console support"
 	depends on FB && !UML
diff --git a/drivers/video/console/Makefile b/drivers/video/console/Makefile
index db07b784bd2c..7818faee587f 100644
--- a/drivers/video/console/Makefile
+++ b/drivers/video/console/Makefile
@@ -9,4 +9,5 @@ obj-$(CONFIG_STI_CONSOLE)         += sticon.o sticore.o
 obj-$(CONFIG_VGA_CONSOLE)         += vgacon.o
 obj-$(CONFIG_MDA_CONSOLE)         += mdacon.o
 
+obj-$(CONFIG_FB_EARLYCON)         += earlycon.o
 obj-$(CONFIG_FB_STI)              += sticore.o
diff --git a/drivers/video/console/earlycon.c b/drivers/video/console/earlycon.c
index 4d6c5327471a..afba921e2222 100644
--- a/drivers/video/console/earlycon.c
+++ b/drivers/video/console/earlycon.c
@@ -1,118 +1,122 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2013 Intel Corporation; author Matt Fleming
+ * Copyright (C) 2022 Markuss Broks <markuss.broks@gmail.com>
  */
 
+#include <asm/early_ioremap.h>
 #include <linux/console.h>
 #include <linux/efi.h>
 #include <linux/font.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
 #include <linux/serial_core.h>
 #include <linux/screen_info.h>
 
-#include <asm/early_ioremap.h>
+struct fb_earlycon {
+	u32 x, y, curr_x, curr_y, depth, stride;
+	size_t size;
+	phys_addr_t phys_base;
+	void __iomem *virt_base;
+};
 
-static const struct console *earlycon_console __initdata;
+static const struct console *earlycon_console __initconst;
+static struct fb_earlycon info;
 static const struct font_desc *font;
-static u32 efi_x, efi_y;
-static u64 fb_base;
-static bool fb_wb;
-static void *efi_fb;
 
-/*
- * EFI earlycon needs to use early_memremap() to map the framebuffer.
- * But early_memremap() is not usable for 'earlycon=efifb keep_bootcon',
- * memremap() should be used instead. memremap() will be available after
- * paging_init() which is earlier than initcall callbacks. Thus adding this
- * early initcall function early_efi_map_fb() to map the whole EFI framebuffer.
- */
-static int __init efi_earlycon_remap_fb(void)
+static int __init simplefb_earlycon_remap_fb(void)
 {
-	/* bail if there is no bootconsole or it was unregistered already */
-	if (!earlycon_console || !console_is_registered(earlycon_console))
+	unsigned long mapping;
+	/* bail if there is no bootconsole or it has been disabled already */
+	if (!earlycon_console || !(earlycon_console->flags & CON_ENABLED))
 		return 0;
 
-	efi_fb = memremap(fb_base, screen_info.lfb_size,
-			  fb_wb ? MEMREMAP_WB : MEMREMAP_WC);
+	if (region_intersects(info.phys_base, info.size,
+			      IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE) == REGION_INTERSECTS)
+		mapping = MEMREMAP_WB;
+	else
+		mapping = MEMREMAP_WC;
+
+	info.virt_base = memremap(info.phys_base, info.size, mapping);
 
-	return efi_fb ? 0 : -ENOMEM;
+	return info.virt_base ? 0 : -ENOMEM;
 }
-early_initcall(efi_earlycon_remap_fb);
+early_initcall(simplefb_earlycon_remap_fb);
 
-static int __init efi_earlycon_unmap_fb(void)
+static int __init simplefb_earlycon_unmap_fb(void)
 {
-	/* unmap the bootconsole fb unless keep_bootcon left it registered */
-	if (efi_fb && !console_is_registered(earlycon_console))
-		memunmap(efi_fb);
+	/* unmap the bootconsole fb unless keep_bootcon has left it enabled */
+	if (info.virt_base && !(earlycon_console->flags & CON_ENABLED))
+		memunmap(info.virt_base);
 	return 0;
 }
-late_initcall(efi_earlycon_unmap_fb);
+late_initcall(simplefb_earlycon_unmap_fb);
 
-static __ref void *efi_earlycon_map(unsigned long start, unsigned long len)
+static __ref void *simplefb_earlycon_map(unsigned long start, unsigned long len)
 {
 	pgprot_t fb_prot;
 
-	if (efi_fb)
-		return efi_fb + start;
+	if (info.virt_base)
+		return info.virt_base + start;
 
-	fb_prot = fb_wb ? PAGE_KERNEL : pgprot_writecombine(PAGE_KERNEL);
-	return early_memremap_prot(fb_base + start, len, pgprot_val(fb_prot));
+	fb_prot = PAGE_KERNEL;
+	return early_memremap_prot(info.phys_base + start, len, pgprot_val(fb_prot));
 }
 
-static __ref void efi_earlycon_unmap(void *addr, unsigned long len)
+static __ref void simplefb_earlycon_unmap(void *addr, unsigned long len)
 {
-	if (efi_fb)
+	if (info.virt_base)
 		return;
 
 	early_memunmap(addr, len);
 }
 
-static void efi_earlycon_clear_scanline(unsigned int y)
+static void simplefb_earlycon_clear_scanline(unsigned int y)
 {
 	unsigned long *dst;
 	u16 len;
 
-	len = screen_info.lfb_linelength;
-	dst = efi_earlycon_map(y*len, len);
+	len = info.stride;
+	dst = simplefb_earlycon_map(y * len, len);
 	if (!dst)
 		return;
 
 	memset(dst, 0, len);
-	efi_earlycon_unmap(dst, len);
+	simplefb_earlycon_unmap(dst, len);
 }
 
-static void efi_earlycon_scroll_up(void)
+static void simplefb_earlycon_scroll_up(void)
 {
 	unsigned long *dst, *src;
 	u16 len;
 	u32 i, height;
 
-	len = screen_info.lfb_linelength;
-	height = screen_info.lfb_height;
+	len = info.stride;
+	height = info.y;
 
 	for (i = 0; i < height - font->height; i++) {
-		dst = efi_earlycon_map(i*len, len);
+		dst = simplefb_earlycon_map(i * len, len);
 		if (!dst)
 			return;
 
-		src = efi_earlycon_map((i + font->height) * len, len);
+		src = simplefb_earlycon_map((i + font->height) * len, len);
 		if (!src) {
-			efi_earlycon_unmap(dst, len);
+			simplefb_earlycon_unmap(dst, len);
 			return;
 		}
 
 		memmove(dst, src, len);
 
-		efi_earlycon_unmap(src, len);
-		efi_earlycon_unmap(dst, len);
+		simplefb_earlycon_unmap(src, len);
+		simplefb_earlycon_unmap(dst, len);
 	}
 }
 
-static void efi_earlycon_write_char(u32 *dst, unsigned char c, unsigned int h)
+static void simplefb_earlycon_write_char(u8 *dst, unsigned char c, unsigned int h)
 {
-	const u32 color_black = 0x00000000;
-	const u32 color_white = 0x00ffffff;
 	const u8 *src;
 	int m, n, bytes;
 	u8 x;
@@ -124,23 +128,21 @@ static void efi_earlycon_write_char(u32 *dst, unsigned char c, unsigned int h)
 		n = m % 8;
 		x = *(src + m / 8);
 		if ((x >> (7 - n)) & 1)
-			*dst = color_white;
+			memset(dst, 0xff, (info.depth / 8));
 		else
-			*dst = color_black;
-		dst++;
+			memset(dst, 0, (info.depth / 8));
+		dst += (info.depth / 8);
 	}
 }
 
 static void
-efi_earlycon_write(struct console *con, const char *str, unsigned int num)
+simplefb_earlycon_write(struct console *con, const char *str, unsigned int num)
 {
-	struct screen_info *si;
 	unsigned int len;
 	const char *s;
 	void *dst;
 
-	si = &screen_info;
-	len = si->lfb_linelength;
+	len = info.stride;
 
 	while (num) {
 		unsigned int linemax;
@@ -152,95 +154,152 @@ efi_earlycon_write(struct console *con, const char *str, unsigned int num)
 			count++;
 		}
 
-		linemax = (si->lfb_width - efi_x) / font->width;
+		linemax = (info.x - info.curr_x) / font->width;
 		if (count > linemax)
 			count = linemax;
 
 		for (h = 0; h < font->height; h++) {
 			unsigned int n, x;
 
-			dst = efi_earlycon_map((efi_y + h) * len, len);
+			dst = simplefb_earlycon_map((info.curr_y + h) * len, len);
 			if (!dst)
 				return;
 
 			s = str;
 			n = count;
-			x = efi_x;
+			x = info.curr_x;
 
 			while (n-- > 0) {
-				efi_earlycon_write_char(dst + x*4, *s, h);
+				simplefb_earlycon_write_char(dst + (x * 4), *s, h);
 				x += font->width;
 				s++;
 			}
 
-			efi_earlycon_unmap(dst, len);
+			simplefb_earlycon_unmap(dst, len);
 		}
 
 		num -= count;
-		efi_x += count * font->width;
+		info.curr_x += count * font->width;
 		str += count;
 
 		if (num > 0 && *s == '\n') {
-			efi_x = 0;
-			efi_y += font->height;
+			info.curr_x = 0;
+			info.curr_y += font->height;
 			str++;
 			num--;
 		}
 
-		if (efi_x + font->width > si->lfb_width) {
-			efi_x = 0;
-			efi_y += font->height;
+		if (info.curr_x + font->width > info.x) {
+			info.curr_x = 0;
+			info.curr_y += font->height;
 		}
 
-		if (efi_y + font->height > si->lfb_height) {
+		if (info.curr_y + font->height > info.y) {
 			u32 i;
 
-			efi_y -= font->height;
-			efi_earlycon_scroll_up();
+			info.curr_y -= font->height;
+			simplefb_earlycon_scroll_up();
 
 			for (i = 0; i < font->height; i++)
-				efi_earlycon_clear_scanline(efi_y + i);
+				simplefb_earlycon_clear_scanline(info.curr_y + i);
 		}
 	}
 }
 
-static int __init efi_earlycon_setup(struct earlycon_device *device,
-				     const char *opt)
+static int __init simplefb_earlycon_setup_common(struct earlycon_device *device,
+						 const char *opt)
 {
-	struct screen_info *si;
-	u16 xres, yres;
-	u32 i;
+	int i;
+
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
 
+	ret = sscanf(device->options, "%ux%ux%u", &info.x, &info.y, &info.depth);
+	if (ret != 3)
+		return -ENODEV;
+
+	info.stride = info.x * (info.depth / 8);
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
 	if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
 		return -ENODEV;
 
-	fb_base = screen_info.lfb_base;
+	info.phys_base = screen_info.lfb_base;
 	if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
-		fb_base |= (u64)screen_info.ext_lfb_base << 32;
+		info.phys_base |= (u64)screen_info.ext_lfb_base << 32;
 
-	fb_wb = opt && !strcmp(opt, "ram");
+	info.x = screen_info.lfb_width;
+	info.y = screen_info.lfb_height;
+	info.depth = screen_info.lfb_depth;
+	info.stride = screen_info.lfb_linelength;
 
-	si = &screen_info;
-	xres = si->lfb_width;
-	yres = si->lfb_height;
+	return simplefb_earlycon_setup_common(device, opt);
+}
 
-	/*
-	 * efi_earlycon_write_char() implicitly assumes a framebuffer with
-	 * 32 bits per pixel.
-	 */
-	if (si->lfb_depth != 32)
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
 		return -ENODEV;
 
-	font = get_default_font(xres, yres, -1, -1);
-	if (!font)
+	info.phys_base = port->mapbase;
+
+	val = of_get_flat_dt_prop(device->node, "width", NULL);
+	if (!val)
 		return -ENODEV;
+	info.x = be32_to_cpu(*val);
 
-	efi_y = rounddown(yres, font->height) - font->height;
-	for (i = 0; i < (yres - efi_y) / font->height; i++)
-		efi_earlycon_scroll_up();
+	val = of_get_flat_dt_prop(device->node, "height", NULL);
+	if (!val)
+		return -ENODEV;
+	info.y = be32_to_cpu(*val);
 
-	device->con->write = efi_earlycon_write;
-	earlycon_console = device->con;
-	return 0;
+	val = of_get_flat_dt_prop(device->node, "stride", NULL);
+	if (!val)
+		return -ENODEV;
+	info.stride = be32_to_cpu(*val);
+	info.depth = (info.stride / info.x) * 8;
+
+	return simplefb_earlycon_setup_common(device, opt);
 }
-EARLYCON_DECLARE(efifb, efi_earlycon_setup);
+
+OF_EARLYCON_DECLARE(simplefb, "simple-framebuffer", simplefb_earlycon_setup_of);
+#endif
-- 
2.39.0

