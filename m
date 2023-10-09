Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11F87BECF7
	for <lists+linux-efi@lfdr.de>; Mon,  9 Oct 2023 23:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378721AbjJIVUa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 9 Oct 2023 17:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378722AbjJIVUH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 9 Oct 2023 17:20:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B62136;
        Mon,  9 Oct 2023 14:19:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11ACEC4339A;
        Mon,  9 Oct 2023 21:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696886391;
        bh=Y6nnyfmtTcWoPREzqbIFTBI+9WLOEmya+e4ZqStyynQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KIVyWshcorp4nyq4Qk8+l0N1N8+nlUOM6IHaO+AooXEfX9m85kJLXCLn75X4Qr9ox
         G4sPNTfqWNhVMkCj2BOx94nD/0py2qYjiSpQFth1je1eVBkTQ88qLiLMHg+b/babCq
         +LhuxXndG6txOrnhrIxYrR4rksZxoPuZOvtjtURC5mPPqGVCFSB8odMDjbooOR75+t
         aoDnY8GZzp+1s+3o84/onKNQTMcrpjC/XU1u6lNHnNpEsQXgX7ZpElKu3I1YwR9eSR
         sfTOjmKNG31tAW19dyOMjcoA1T271m2UFMWkp6F9XUTJ3PERoQ4K1KW4ad1WnkCYie
         SgV4Viirn0LbQ==
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
        sparclinux@vger.kernel.org, linux-hyperv@vger.kernel.org,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v3 4/9] vgacon, arch/*: remove unused screen_info definitions
Date:   Mon,  9 Oct 2023 23:18:40 +0200
Message-Id: <20231009211845.3136536-5-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009211845.3136536-1-arnd@kernel.org>
References: <20231009211845.3136536-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

A number of architectures either kept the screen_info definition for
historical purposes as it used to be required by the generic VT code, or
they copied it from another architecture in order to build the VGA console
driver in an allmodconfig build. The mips definition is used by some
platforms, but the initialization on jazz is not needed.

Now that vgacon no longer builds on these architectures, remove the
stale definitions and initializations.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Dinh Nguyen <dinguyen@kernel.org>
Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Guo Ren <guoren@kernel.org>
Acked-by: Helge Deller <deller@gmx.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/kernel/setup.c          | 12 ------------
 arch/hexagon/kernel/Makefile      |  2 --
 arch/hexagon/kernel/screen_info.c |  3 ---
 arch/mips/jazz/setup.c            |  9 ---------
 arch/nios2/kernel/setup.c         |  5 -----
 arch/sh/kernel/setup.c            |  5 -----
 arch/sparc/kernel/setup_32.c      | 13 -------------
 arch/sparc/kernel/setup_64.c      | 13 -------------
 arch/xtensa/kernel/setup.c        | 12 ------------
 9 files changed, 74 deletions(-)
 delete mode 100644 arch/hexagon/kernel/screen_info.c

diff --git a/arch/csky/kernel/setup.c b/arch/csky/kernel/setup.c
index 106fbf0b6f3b4..51012e90780d6 100644
--- a/arch/csky/kernel/setup.c
+++ b/arch/csky/kernel/setup.c
@@ -8,22 +8,10 @@
 #include <linux/of_fdt.h>
 #include <linux/start_kernel.h>
 #include <linux/dma-map-ops.h>
-#include <linux/screen_info.h>
 #include <asm/sections.h>
 #include <asm/mmu_context.h>
 #include <asm/pgalloc.h>
 
-#ifdef CONFIG_DUMMY_CONSOLE
-struct screen_info screen_info = {
-	.orig_video_lines	= 30,
-	.orig_video_cols	= 80,
-	.orig_video_mode	= 0,
-	.orig_video_ega_bx	= 0,
-	.orig_video_isVGA	= 1,
-	.orig_video_points	= 8
-};
-#endif
-
 static void __init csky_memblock_init(void)
 {
 	unsigned long lowmem_size = PFN_DOWN(LOWMEM_LIMIT - PHYS_OFFSET_OFFSET);
diff --git a/arch/hexagon/kernel/Makefile b/arch/hexagon/kernel/Makefile
index e73cb321630ec..3fdf937eb572e 100644
--- a/arch/hexagon/kernel/Makefile
+++ b/arch/hexagon/kernel/Makefile
@@ -17,5 +17,3 @@ obj-y += vm_vectors.o
 obj-$(CONFIG_HAS_DMA) += dma.o
 
 obj-$(CONFIG_STACKTRACE) += stacktrace.o
-
-obj-$(CONFIG_VGA_CONSOLE) += screen_info.o
diff --git a/arch/hexagon/kernel/screen_info.c b/arch/hexagon/kernel/screen_info.c
deleted file mode 100644
index 1e1ceb18bafe7..0000000000000
--- a/arch/hexagon/kernel/screen_info.c
+++ /dev/null
@@ -1,3 +0,0 @@
-#include <linux/screen_info.h>
-
-struct screen_info screen_info;
diff --git a/arch/mips/jazz/setup.c b/arch/mips/jazz/setup.c
index ee044261eb223..23059ead773fc 100644
--- a/arch/mips/jazz/setup.c
+++ b/arch/mips/jazz/setup.c
@@ -13,7 +13,6 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/console.h>
-#include <linux/screen_info.h>
 #include <linux/platform_device.h>
 #include <linux/serial_8250.h>
 #include <linux/dma-mapping.h>
@@ -76,14 +75,6 @@ void __init plat_mem_setup(void)
 
 	_machine_restart = jazz_machine_restart;
 
-#ifdef CONFIG_VT
-	screen_info = (struct screen_info) {
-		.orig_video_cols	= 160,
-		.orig_video_lines	= 64,
-		.orig_video_points	= 16,
-	};
-#endif
-
 	add_preferred_console("ttyS", 0, "9600");
 }
 
diff --git a/arch/nios2/kernel/setup.c b/arch/nios2/kernel/setup.c
index 8582ed9658447..da122a5fa43b2 100644
--- a/arch/nios2/kernel/setup.c
+++ b/arch/nios2/kernel/setup.c
@@ -19,7 +19,6 @@
 #include <linux/memblock.h>
 #include <linux/initrd.h>
 #include <linux/of_fdt.h>
-#include <linux/screen_info.h>
 
 #include <asm/mmu_context.h>
 #include <asm/sections.h>
@@ -36,10 +35,6 @@ static struct pt_regs fake_regs = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 					0, 0, 0, 0, 0, 0,
 					0};
 
-#ifdef CONFIG_VT
-struct screen_info screen_info;
-#endif
-
 /* Copy a short hook instruction sequence to the exception address */
 static inline void copy_exception_handler(unsigned int addr)
 {
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index b3da2757faaf3..3d80515298d26 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -7,7 +7,6 @@
  *  Copyright (C) 1999  Niibe Yutaka
  *  Copyright (C) 2002 - 2010 Paul Mundt
  */
-#include <linux/screen_info.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
 #include <linux/initrd.h>
@@ -69,10 +68,6 @@ EXPORT_SYMBOL(cpu_data);
 struct sh_machine_vector sh_mv = { .mv_name = "generic", };
 EXPORT_SYMBOL(sh_mv);
 
-#ifdef CONFIG_VT
-struct screen_info screen_info;
-#endif
-
 extern int root_mountflags;
 
 #define RAMDISK_IMAGE_START_MASK	0x07FF
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index 34ef7febf0d56..e3b72a7b46d37 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -17,7 +17,6 @@
 #include <linux/initrd.h>
 #include <asm/smp.h>
 #include <linux/user.h>
-#include <linux/screen_info.h>
 #include <linux/delay.h>
 #include <linux/fs.h>
 #include <linux/seq_file.h>
@@ -51,18 +50,6 @@
 
 #include "kernel.h"
 
-struct screen_info screen_info = {
-	0, 0,			/* orig-x, orig-y */
-	0,			/* unused */
-	0,			/* orig-video-page */
-	0,			/* orig-video-mode */
-	128,			/* orig-video-cols */
-	0,0,0,			/* ega_ax, ega_bx, ega_cx */
-	54,			/* orig-video-lines */
-	0,                      /* orig-video-isVGA */
-	16                      /* orig-video-points */
-};
-
 /* Typing sync at the prom prompt calls the function pointed to by
  * romvec->pv_synchook which I set to the following function.
  * This should sync all filesystems and return, for now it just
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 6546ca9d4d3f1..6a4797dec34b4 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -15,7 +15,6 @@
 #include <linux/ptrace.h>
 #include <asm/smp.h>
 #include <linux/user.h>
-#include <linux/screen_info.h>
 #include <linux/delay.h>
 #include <linux/fs.h>
 #include <linux/seq_file.h>
@@ -68,18 +67,6 @@
 DEFINE_SPINLOCK(ns87303_lock);
 EXPORT_SYMBOL(ns87303_lock);
 
-struct screen_info screen_info = {
-	0, 0,			/* orig-x, orig-y */
-	0,			/* unused */
-	0,			/* orig-video-page */
-	0,			/* orig-video-mode */
-	128,			/* orig-video-cols */
-	0, 0, 0,		/* unused, ega_bx, unused */
-	54,			/* orig-video-lines */
-	0,                      /* orig-video-isVGA */
-	16                      /* orig-video-points */
-};
-
 static void
 prom_console_write(struct console *con, const char *s, unsigned int n)
 {
diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
index 52d6e4870a04c..bdec4a773af09 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -19,7 +19,6 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/proc_fs.h>
-#include <linux/screen_info.h>
 #include <linux/kernel.h>
 #include <linux/percpu.h>
 #include <linux/reboot.h>
@@ -49,17 +48,6 @@
 #include <asm/timex.h>
 #include <asm/traps.h>
 
-#if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_DUMMY_CONSOLE)
-struct screen_info screen_info = {
-	.orig_x = 0,
-	.orig_y = 24,
-	.orig_video_cols = 80,
-	.orig_video_lines = 24,
-	.orig_video_isVGA = 1,
-	.orig_video_points = 16,
-};
-#endif
-
 #ifdef CONFIG_BLK_DEV_INITRD
 extern unsigned long initrd_start;
 extern unsigned long initrd_end;
-- 
2.39.2

