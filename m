Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AE87BED06
	for <lists+linux-efi@lfdr.de>; Mon,  9 Oct 2023 23:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbjJIVUz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 9 Oct 2023 17:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378530AbjJIVUX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 9 Oct 2023 17:20:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D412AD5F;
        Mon,  9 Oct 2023 14:20:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1D1C433AB;
        Mon,  9 Oct 2023 21:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696886402;
        bh=+K/4NVGKJdI7fsqnuL3ShfcVKPQnZC5TVWEswMxGy9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lDgDyRQdI9tvEdIhgSsvDC1PqgQ6mf5mw4Xm90EPIJyA2xs307RZxBfPUUIMxPBrm
         5+ria/QUhrLqkbyPA5hl2oRgYgQLGdt6Tn2KIgdLbXLIWavgrdNWu8UJSXwlWaU2V2
         5elM7/wYz1+90rmSxTjClRNJ3oPBKctrWLDlfPxqQDXywd1o1HoSFYonHQiQphj0ms
         rvJ11Y7c0DdpC0cYbdqckgyQMZ51B9+i4i25wRq9qV625CxtzVjzUSTNsLUqn/yJb2
         3bl/CRp6o4UOMyt9FrvRvYxGxCy2VeIwLbLyhjursXjwAr1W9VZzLA0UGz5Tz1IXYa
         wZama3UyqCcSQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Deepak Rawat <drawat.floss@gmail.com>,
        Dexuan Cui <decui@microsoft.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guo Ren <guoren@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Helge Deller <deller@gmx.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Khalid Aziz <khalid@gonehiking.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        WANG Xuerui <kernel@xen0n.name>, Wei Liu <wei.liu@kernel.org>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: [PATCH v3 5/9] vgacon: remove screen_info dependency
Date:   Mon,  9 Oct 2023 23:18:41 +0200
Message-Id: <20231009211845.3136536-6-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009211845.3136536-1-arnd@kernel.org>
References: <20231009211845.3136536-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The vga console driver is fairly self-contained, and only used by
architectures that explicitly initialize the screen_info settings.

Chance every instance that picks the vga console by setting conswitchp
to call a function instead, and pass a reference to the screen_info
there.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Khalid Azzi <khalid@gonehiking.org>
Acked-by: Helge Deller <deller@gmx.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/kernel/setup.c      |  2 +-
 arch/arm/kernel/setup.c        |  2 +-
 arch/ia64/kernel/setup.c       |  2 +-
 arch/mips/kernel/setup.c       |  2 +-
 arch/x86/kernel/setup.c        |  2 +-
 drivers/firmware/pcdp.c        |  2 +-
 drivers/video/console/vgacon.c | 68 ++++++++++++++++++++--------------
 include/linux/console.h        |  7 ++++
 8 files changed, 53 insertions(+), 34 deletions(-)

diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
index 85a679ce061c2..c004933468606 100644
--- a/arch/alpha/kernel/setup.c
+++ b/arch/alpha/kernel/setup.c
@@ -654,7 +654,7 @@ setup_arch(char **cmdline_p)
 
 #ifdef CONFIG_VT
 #if defined(CONFIG_VGA_CONSOLE)
-	conswitchp = &vga_con;
+	vgacon_register_screen(&screen_info);
 #endif
 #endif
 
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 5e965cb94dd66..67ba140794bf6 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1197,7 +1197,7 @@ void __init setup_arch(char **cmdline_p)
 
 #ifdef CONFIG_VT
 #if defined(CONFIG_VGA_CONSOLE)
-	conswitchp = &vga_con;
+	vgacon_register_screen(&screen_info);
 #endif
 #endif
 
diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
index d2c66efdde560..2c9283fcd3759 100644
--- a/arch/ia64/kernel/setup.c
+++ b/arch/ia64/kernel/setup.c
@@ -619,7 +619,7 @@ setup_arch (char **cmdline_p)
 		 * memory so we can avoid this problem.
 		 */
 		if (efi_mem_type(0xA0000) != EFI_CONVENTIONAL_MEMORY)
-			conswitchp = &vga_con;
+			vgacon_register_screen(&screen_info);
 # endif
 	}
 #endif
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 7c81366f26068..c395e2a5a2556 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -795,7 +795,7 @@ void __init setup_arch(char **cmdline_p)
 
 #if defined(CONFIG_VT)
 #if defined(CONFIG_VGA_CONSOLE)
-	conswitchp = &vga_con;
+	vgacon_register_screen(&screen_info);
 #endif
 #endif
 
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index d3e43440369ce..8ae0478c24ccb 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1168,7 +1168,7 @@ void __init setup_arch(char **cmdline_p)
 #ifdef CONFIG_VT
 #if defined(CONFIG_VGA_CONSOLE)
 	if (!efi_enabled(EFI_BOOT) || (efi_mem_type(0xa0000) != EFI_CONVENTIONAL_MEMORY))
-		conswitchp = &vga_con;
+		vgacon_register_screen(&screen_info);
 #endif
 #endif
 	x86_init.oem.banner();
diff --git a/drivers/firmware/pcdp.c b/drivers/firmware/pcdp.c
index 715a45442d1cf..667a595373b2d 100644
--- a/drivers/firmware/pcdp.c
+++ b/drivers/firmware/pcdp.c
@@ -72,7 +72,7 @@ setup_vga_console(struct pcdp_device *dev)
 		return -ENODEV;
 	}
 
-	conswitchp = &vga_con;
+	vgacon_register_screen(&screen_info);
 	printk(KERN_INFO "PCDP: VGA console\n");
 	return 0;
 #else
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 7ad047bcae171..8ef1579fa57fd 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -89,6 +89,8 @@ static int 		vga_video_font_height;
 static int 		vga_scan_lines		__read_mostly;
 static unsigned int 	vga_rolled_over; /* last vc_origin offset before wrap */
 
+static struct screen_info *vga_si;
+
 static bool vga_hardscroll_enabled;
 static bool vga_hardscroll_user_enable = true;
 
@@ -153,8 +155,9 @@ static const char *vgacon_startup(void)
 	u16 saved1, saved2;
 	volatile u16 *p;
 
-	if (screen_info.orig_video_isVGA == VIDEO_TYPE_VLFB ||
-	    screen_info.orig_video_isVGA == VIDEO_TYPE_EFI) {
+	if (!vga_si ||
+	    vga_si->orig_video_isVGA == VIDEO_TYPE_VLFB ||
+	    vga_si->orig_video_isVGA == VIDEO_TYPE_EFI) {
 	      no_vga:
 #ifdef CONFIG_DUMMY_CONSOLE
 		conswitchp = &dummy_con;
@@ -164,29 +167,29 @@ static const char *vgacon_startup(void)
 #endif
 	}
 
-	/* boot_params.screen_info reasonably initialized? */
-	if ((screen_info.orig_video_lines == 0) ||
-	    (screen_info.orig_video_cols  == 0))
+	/* vga_si reasonably initialized? */
+	if ((vga_si->orig_video_lines == 0) ||
+	    (vga_si->orig_video_cols  == 0))
 		goto no_vga;
 
 	/* VGA16 modes are not handled by VGACON */
-	if ((screen_info.orig_video_mode == 0x0D) ||	/* 320x200/4 */
-	    (screen_info.orig_video_mode == 0x0E) ||	/* 640x200/4 */
-	    (screen_info.orig_video_mode == 0x10) ||	/* 640x350/4 */
-	    (screen_info.orig_video_mode == 0x12) ||	/* 640x480/4 */
-	    (screen_info.orig_video_mode == 0x6A))	/* 800x600/4 (VESA) */
+	if ((vga_si->orig_video_mode == 0x0D) ||	/* 320x200/4 */
+	    (vga_si->orig_video_mode == 0x0E) ||	/* 640x200/4 */
+	    (vga_si->orig_video_mode == 0x10) ||	/* 640x350/4 */
+	    (vga_si->orig_video_mode == 0x12) ||	/* 640x480/4 */
+	    (vga_si->orig_video_mode == 0x6A))	/* 800x600/4 (VESA) */
 		goto no_vga;
 
-	vga_video_num_lines = screen_info.orig_video_lines;
-	vga_video_num_columns = screen_info.orig_video_cols;
+	vga_video_num_lines = vga_si->orig_video_lines;
+	vga_video_num_columns = vga_si->orig_video_cols;
 	vgastate.vgabase = NULL;
 
-	if (screen_info.orig_video_mode == 7) {
+	if (vga_si->orig_video_mode == 7) {
 		/* Monochrome display */
 		vga_vram_base = 0xb0000;
 		vga_video_port_reg = VGA_CRT_IM;
 		vga_video_port_val = VGA_CRT_DM;
-		if ((screen_info.orig_video_ega_bx & 0xff) != 0x10) {
+		if ((vga_si->orig_video_ega_bx & 0xff) != 0x10) {
 			static struct resource ega_console_resource =
 			    { .name	= "ega",
 			      .flags	= IORESOURCE_IO,
@@ -223,12 +226,12 @@ static const char *vgacon_startup(void)
 		vga_vram_base = 0xb8000;
 		vga_video_port_reg = VGA_CRT_IC;
 		vga_video_port_val = VGA_CRT_DC;
-		if ((screen_info.orig_video_ega_bx & 0xff) != 0x10) {
+		if ((vga_si->orig_video_ega_bx & 0xff) != 0x10) {
 			int i;
 
 			vga_vram_size = 0x8000;
 
-			if (!screen_info.orig_video_isVGA) {
+			if (!vga_si->orig_video_isVGA) {
 				static struct resource ega_console_resource =
 				    { .name	= "ega",
 				      .flags	= IORESOURCE_IO,
@@ -319,14 +322,14 @@ static const char *vgacon_startup(void)
 	    || vga_video_type == VIDEO_TYPE_VGAC
 	    || vga_video_type == VIDEO_TYPE_EGAM) {
 		vga_hardscroll_enabled = vga_hardscroll_user_enable;
-		vga_default_font_height = screen_info.orig_video_points;
-		vga_video_font_height = screen_info.orig_video_points;
+		vga_default_font_height = vga_si->orig_video_points;
+		vga_video_font_height = vga_si->orig_video_points;
 		/* This may be suboptimal but is a safe bet - go with it */
 		vga_scan_lines =
 		    vga_video_font_height * vga_video_num_lines;
 	}
 
-	vgacon_xres = screen_info.orig_video_cols * VGA_FONTWIDTH;
+	vgacon_xres = vga_si->orig_video_cols * VGA_FONTWIDTH;
 	vgacon_yres = vga_scan_lines;
 
 	return display_desc;
@@ -371,7 +374,7 @@ static void vgacon_init(struct vc_data *c, int init)
 	/* Only set the default if the user didn't deliberately override it */
 	if (global_cursor_default == -1)
 		global_cursor_default =
-			!(screen_info.flags & VIDEO_FLAGS_NOCURSOR);
+			!(vga_si->flags & VIDEO_FLAGS_NOCURSOR);
 }
 
 static void vgacon_deinit(struct vc_data *c)
@@ -589,7 +592,7 @@ static int vgacon_switch(struct vc_data *c)
 {
 	int x = c->vc_cols * VGA_FONTWIDTH;
 	int y = c->vc_rows * c->vc_cell_height;
-	int rows = screen_info.orig_video_lines * vga_default_font_height/
+	int rows = vga_si->orig_video_lines * vga_default_font_height/
 		c->vc_cell_height;
 	/*
 	 * We need to save screen size here as it's the only way
@@ -609,7 +612,7 @@ static int vgacon_switch(struct vc_data *c)
 
 		if ((vgacon_xres != x || vgacon_yres != y) &&
 		    (!(vga_video_num_columns % 2) &&
-		     vga_video_num_columns <= screen_info.orig_video_cols &&
+		     vga_video_num_columns <= vga_si->orig_video_cols &&
 		     vga_video_num_lines <= rows))
 			vgacon_doresize(c, c->vc_cols, c->vc_rows);
 	}
@@ -1056,13 +1059,13 @@ static int vgacon_resize(struct vc_data *c, unsigned int width,
 		 * Ho ho!  Someone (svgatextmode, eh?) may have reprogrammed
 		 * the video mode!  Set the new defaults then and go away.
 		 */
-		screen_info.orig_video_cols = width;
-		screen_info.orig_video_lines = height;
+		vga_si->orig_video_cols = width;
+		vga_si->orig_video_lines = height;
 		vga_default_font_height = c->vc_cell_height;
 		return 0;
 	}
-	if (width % 2 || width > screen_info.orig_video_cols ||
-	    height > (screen_info.orig_video_lines * vga_default_font_height)/
+	if (width % 2 || width > vga_si->orig_video_cols ||
+	    height > (vga_si->orig_video_lines * vga_default_font_height)/
 	    c->vc_cell_height)
 		return -EINVAL;
 
@@ -1092,8 +1095,8 @@ static void vgacon_save_screen(struct vc_data *c)
 		 * console initialization routines.
 		 */
 		vga_bootup_console = 1;
-		c->state.x = screen_info.orig_x;
-		c->state.y = screen_info.orig_y;
+		c->state.x = vga_si->orig_x;
+		c->state.y = vga_si->orig_y;
 	}
 
 	/* We can't copy in more than the size of the video buffer,
@@ -1186,4 +1189,13 @@ const struct consw vga_con = {
 };
 EXPORT_SYMBOL(vga_con);
 
+void vgacon_register_screen(struct screen_info *si)
+{
+	if (!si || vga_si)
+		return;
+
+	conswitchp = &vga_con;
+	vga_si = si;
+}
+
 MODULE_LICENSE("GPL");
diff --git a/include/linux/console.h b/include/linux/console.h
index e4fc6f7c14961..060be989ae261 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -101,6 +101,13 @@ extern const struct consw dummy_con;	/* dummy console buffer */
 extern const struct consw vga_con;	/* VGA text console */
 extern const struct consw newport_con;	/* SGI Newport console  */
 
+struct screen_info;
+#ifdef CONFIG_VGA_CONSOLE
+void vgacon_register_screen(struct screen_info *si);
+#else
+static inline void vgacon_register_screen(struct screen_info *si) { }
+#endif
+
 int con_is_bound(const struct consw *csw);
 int do_unregister_con_driver(const struct consw *csw);
 int do_take_over_console(const struct consw *sw, int first, int last, int deflt);
-- 
2.39.2

