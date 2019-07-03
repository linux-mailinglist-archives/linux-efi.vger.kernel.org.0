Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01BA75EDEE
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jul 2019 22:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfGCUz5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 3 Jul 2019 16:55:57 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:37581 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfGCUz5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 3 Jul 2019 16:55:57 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M27Bp-1hgJRq2Gin-002TZ9; Wed, 03 Jul 2019 22:55:31 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Abbott Liu <liuwenliang@huawei.com>,
        linux-arm-kernel@lists.infradead.org, kasan-dev@googlegroups.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Stefan Agner <stefan@agner.ch>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: [PATCH 1/3] ARM: fix kasan link failures
Date:   Wed,  3 Jul 2019 22:54:36 +0200
Message-Id: <20190703205527.955320-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:N0nhNH56c4bAPUvE+lb81hmqvGKzvYovB1gWPnLR0wVZb6l2Cus
 VlcxdC8pK77LU32vdSY3Hh7JVCF2Dn86C7mE5dWcn3mW4hOXnlPLCso1Cp9anA4gdrDrzo5
 Ut7QKtxvDcquKr7d9Bv/USwELBGTW65u6iuQdfFdQsgx+VYAxaDSI2S8DskzTjruoWUa2ES
 iWji7SQpVNS6kv9tSkXzg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kkc3pKM7JBI=:7SfM19cEIrMeD+akm/v6F2
 a7GlFineaNLRR0bDHAg64d4H8VDDp7Z9+1z0wPu6ycgl2veXYMIYLK3ymKqKG4KsWypouYG9r
 mtCXBQ4VLnNmtTGxxFuxJdpI3h2zw4v1U8tAUn4YrVtxSPTXfdIvp75IvfpBXX/UvFQyZ1dp3
 U/VKYT/72+IpBEt1wioAoWf3LlbQGf9SBTdADJK+a4xjGSe3fKWyWBteSoLXu6ryzobEgrfT/
 H00WLhhVLscWXXo5mo/pjrrFTjO/7XZo+uTlJcuSiqSfdPcxYtMHz12+C9S/Z+2HGLOq5uVEg
 DQhJ/O0i8wws7dtN346JYXJBuU/miXvgasyL26bSAp6kAWdEvGPuQv4kdmfMsj2Rw9lg5Y0t7
 R3R01XUVVi1aq89YlWjRoLzbt5hAlFIAd9ilTc+/+QVxtDzzPpenqcaqMjFQubTYDYkRT5SOm
 2tnPirJJacaRkDbQ5bTGJ3Ul32o6ej09+cOCaH0aWrQYPlKKbkU5SGLBNU7s4LARIsVt2Hw4s
 Ii7qWkUVDiwx+d52CbaSbjqmAtNjS+r0w7ri4LGuUhZvHPf08gKYO/WCR80f/kRyUbqfwxENo
 IhhjA/hQkMP7YWhi+VCHHS49JyodFnSForBRio4snDdEmhFwCJpwTHCqNH15yPzgwWJt5lz3z
 AZS6ncqMjqWtz5QOMSnp3u12Dp15VIpniGDr/zVGGmfL/6EJFRba+9xAe2ivD9P0FL/W7RCuG
 awSwZR/Uu8glWMOfQlXU3FQt8a2h94oDitdTGg==
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Getting the redirects for memcpy/memmove/memset functions right
in the decompressor and the efi stub is a bit tricky. Originally
these were meant to prevent the kasan code from calling itself
recursively. The decompressor is built without kasan but uses
the same redirects when CONFIG_KASAN is enabled, except in a few
cases that now cause link failures:

arch/arm/boot/compressed/fdt_rw.o: In function `fdt_set_name':
fdt_rw.c:(.text+0x3d4): undefined reference to `memcpy'
arch/arm/boot/compressed/fdt_rw.o: In function `fdt_add_property_':
fdt_rw.c:(.text+0x121c): undefined reference to `memmove'
arch/arm/boot/compressed/fdt_rw.o: In function `fdt_splice_':
fdt_rw.c:(.text+0x1460): undefined reference to `memmove'
arch/arm/boot/compressed/fdt_ro.o: In function `fdt_get_path':
fdt_ro.c:(.text+0x1384): undefined reference to `memcpy'
arch/arm/boot/compressed/fdt_wip.o: In function `fdt_setprop_inplace_namelen_partial':
fdt_wip.c:(.text+0x48): undefined reference to `memcpy'
arch/arm/boot/compressed/fdt_wip.o: In function `fdt_setprop_inplace':
fdt_wip.c:(.text+0x100): undefined reference to `memcpy'
arch/arm/boot/compressed/fdt.o: In function `fdt_move':
fdt.c:(.text+0xa04): undefined reference to `memmove'
arch/arm/boot/compressed/atags_to_fdt.o: In function `atags_to_fdt':
atags_to_fdt.c:(.text+0x404): undefined reference to `memcpy'
atags_to_fdt.c:(.text+0x450): undefined reference to `memcpy'

I tried to make everything use them, but ran into other problems:

drivers/firmware/efi/libstub/lib-fdt_sw.stub.o: In function `fdt_create_with_flags':
fdt_sw.c:(.text+0x34): undefined reference to `__memset'
arch/arm/boot/compressed/decompress.o: In function `lzo1x_decompress_safe':
decompress.c:(.text+0x290): undefined reference to `__memset'

This makes all the early boot code not use the redirects, which
works because we don't sanitize that code.

Setting -D__SANITIZE_ADDRESS__ is a bit confusing here, but it
does the trick.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/compressed/Makefile     | 1 +
 arch/arm/boot/compressed/decompress.c | 2 --
 arch/arm/boot/compressed/libfdt_env.h | 2 --
 drivers/firmware/efi/libstub/Makefile | 3 ++-
 4 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index dcc27fb24fbb..d91c2ded0e3d 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -25,6 +25,7 @@ endif
 
 GCOV_PROFILE		:= n
 KASAN_SANITIZE		:= n
+CFLAGS_KERNEL += -D__SANITIZE_ADDRESS__
 
 # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
 KCOV_INSTRUMENT		:= n
diff --git a/arch/arm/boot/compressed/decompress.c b/arch/arm/boot/compressed/decompress.c
index 3794fae5f818..aa075d8372ea 100644
--- a/arch/arm/boot/compressed/decompress.c
+++ b/arch/arm/boot/compressed/decompress.c
@@ -47,10 +47,8 @@ extern char * strchrnul(const char *, int);
 #endif
 
 #ifdef CONFIG_KERNEL_XZ
-#ifndef CONFIG_KASAN
 #define memmove memmove
 #define memcpy memcpy
-#endif
 #include "../../../../lib/decompress_unxz.c"
 #endif
 
diff --git a/arch/arm/boot/compressed/libfdt_env.h b/arch/arm/boot/compressed/libfdt_env.h
index 8091efc21407..b36c0289a308 100644
--- a/arch/arm/boot/compressed/libfdt_env.h
+++ b/arch/arm/boot/compressed/libfdt_env.h
@@ -19,6 +19,4 @@ typedef __be64 fdt64_t;
 #define fdt64_to_cpu(x)		be64_to_cpu(x)
 #define cpu_to_fdt64(x)		cpu_to_be64(x)
 
-#undef memset
-
 #endif
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 0460c7581220..fd1d72ea04dd 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -20,7 +20,8 @@ cflags-$(CONFIG_ARM64)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
 				   -fpie $(DISABLE_STACKLEAK_PLUGIN)
 cflags-$(CONFIG_ARM)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
 				   -fno-builtin -fpic \
-				   $(call cc-option,-mno-single-pic-base)
+				   $(call cc-option,-mno-single-pic-base) \
+				   -D__SANITIZE_ADDRESS__
 
 cflags-$(CONFIG_EFI_ARMSTUB)	+= -I$(srctree)/scripts/dtc/libfdt
 
-- 
2.20.0

