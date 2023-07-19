Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47137595A6
	for <lists+linux-efi@lfdr.de>; Wed, 19 Jul 2023 14:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjGSMmA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Jul 2023 08:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjGSMli (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Jul 2023 08:41:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB241737;
        Wed, 19 Jul 2023 05:41:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE212616DA;
        Wed, 19 Jul 2023 12:41:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72B0C43395;
        Wed, 19 Jul 2023 12:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689770481;
        bh=v4M0j8Y9+LzNwuF8nVwMAulIi63E5C7p3UByRxJEuxo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vKNV9sNTUJTcnOk/TL1KoiaHwQQWXHhoPLKo9L7gVUY2yHAnPr3rQfnX/Hso6oJB+
         CVdZjSwY/u59qA7uEwriqWsna0VDWCA/aNy3xTaAcHxVapcawxYk8rr49rerGskgYx
         EJQDb1y5KekinNzg4lX8z5NxO4z5mTup06SfWlkpBZ68CgccaIITSkVOcz/btQ61id
         eAtCGgCQBOga8OpRGnTyyB54IQWyww6fUqyA5eClL00d32lpYcqM2IQB1PufsqqvYg
         1quMka/+qOF+lFoyojoKihE+OHdIXdpDavOUO4HdjzNycQivZ6VIEN22J9iVg/xnEl
         TF7iPTAVjg67A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>
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
        Huacai Chen <chenhuacai@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
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
        sparclinux@vger.kernel.org, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 7/9] vga16fb: drop powerpc support
Date:   Wed, 19 Jul 2023 14:39:42 +0200
Message-Id: <20230719123944.3438363-8-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230719123944.3438363-1-arnd@kernel.org>
References: <20230719123944.3438363-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

I noticed that commit 0db5b61e0dc07 ("fbdev/vga16fb: Create
EGA/VGA devices in sysfb code") broke vga16fb on non-x86 platforms,
because the sysfb code never creates a vga-framebuffer device when
screen_info.orig_video_isVGA is set to '1' instead of VIDEO_TYPE_VGAC.

However, it turns out that the only architecture that has allowed
building vga16fb in the past 20 years is powerpc, and this only worked
on two 32-bit platforms and never on 64-bit powerpc. The last machine
that actually used this was removed in linux-3.10, so this is all dead
code and can be removed.

The big-endian support in vga16fb.c could also be removed, but I'd just
leave this in place.

Fixes: 933ee7119fb14 ("powerpc: remove PReP platform")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/kernel/setup-common.c | 16 ----------------
 drivers/video/fbdev/Kconfig        |  2 +-
 drivers/video/fbdev/vga16fb.c      |  9 +--------
 3 files changed, 2 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index d2a446216444f..81a6313927228 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -22,7 +22,6 @@
 #include <linux/seq_file.h>
 #include <linux/ioport.h>
 #include <linux/console.h>
-#include <linux/screen_info.h>
 #include <linux/root_dev.h>
 #include <linux/cpu.h>
 #include <linux/unistd.h>
@@ -98,21 +97,6 @@ int boot_cpu_hwid = -1;
 int dcache_bsize;
 int icache_bsize;
 
-/*
- * This still seems to be needed... -- paulus
- */ 
-struct screen_info screen_info = {
-	.orig_x = 0,
-	.orig_y = 25,
-	.orig_video_cols = 80,
-	.orig_video_lines = 25,
-	.orig_video_isVGA = 1,
-	.orig_video_points = 16
-};
-#if defined(CONFIG_FB_VGA16_MODULE)
-EXPORT_SYMBOL(screen_info);
-#endif
-
 /* Variables required to store legacy IO irq routing */
 int of_i8042_kbd_irq;
 EXPORT_SYMBOL_GPL(of_i8042_kbd_irq);
diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 9169ee532baf7..ebc3cdfdfca07 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -368,7 +368,7 @@ config FB_IMSTT
 
 config FB_VGA16
 	tristate "VGA 16-color graphics support"
-	depends on FB && (X86 || PPC)
+	depends on FB && X86
 	select APERTURE_HELPERS
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
diff --git a/drivers/video/fbdev/vga16fb.c b/drivers/video/fbdev/vga16fb.c
index 34d00347ad58a..8e28f9dd19044 100644
--- a/drivers/video/fbdev/vga16fb.c
+++ b/drivers/video/fbdev/vga16fb.c
@@ -185,8 +185,6 @@ static inline void setindex(int index)
 /* Check if the video mode is supported by the driver */
 static inline int check_mode_supported(const struct screen_info *si)
 {
-	/* non-x86 architectures treat orig_video_isVGA as a boolean flag */
-#if defined(CONFIG_X86)
 	/* only EGA and VGA in 16 color graphic mode are supported */
 	if (si->orig_video_isVGA != VIDEO_TYPE_EGAC &&
 	    si->orig_video_isVGA != VIDEO_TYPE_VGAC)
@@ -197,7 +195,7 @@ static inline int check_mode_supported(const struct screen_info *si)
 	    si->orig_video_mode != 0x10 &&	/* 640x350/4 (EGA) */
 	    si->orig_video_mode != 0x12)	/* 640x480/4 (VGA) */
 		return -ENODEV;
-#endif
+
 	return 0;
 }
 
@@ -1338,12 +1336,7 @@ static int vga16fb_probe(struct platform_device *dev)
 	printk(KERN_INFO "vga16fb: mapped to 0x%p\n", info->screen_base);
 	par = info->par;
 
-#if defined(CONFIG_X86)
 	par->isVGA = si->orig_video_isVGA == VIDEO_TYPE_VGAC;
-#else
-	/* non-x86 architectures treat orig_video_isVGA as a boolean flag */
-	par->isVGA = si->orig_video_isVGA;
-#endif
 	par->palette_blanked = 0;
 	par->vesa_blanked = 0;
 
-- 
2.39.2

