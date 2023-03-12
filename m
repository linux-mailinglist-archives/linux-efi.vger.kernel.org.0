Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C586B6BE8
	for <lists+linux-efi@lfdr.de>; Sun, 12 Mar 2023 23:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjCLWMb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 12 Mar 2023 18:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjCLWMb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 12 Mar 2023 18:12:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EAE298F7
        for <linux-efi@vger.kernel.org>; Sun, 12 Mar 2023 15:12:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 936EC60FC3
        for <linux-efi@vger.kernel.org>; Sun, 12 Mar 2023 22:12:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1EF0C433D2;
        Sun, 12 Mar 2023 22:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678659149;
        bh=8mbI8D3XlDUqs2Z6m01RfnZuIds5N1fyoQdQU6rdyQs=;
        h=From:To:Cc:Subject:Date:From;
        b=uzH7IDcjMtwX+m4VmMX2xWt/mq711kps+yO1w1r91lVk7tVY97hBiotqOFjw+l5Kh
         j4z66gtnZPpwH/4LBBQOHD+PqzB4z3e41cQZ7tjWZmnePQwjXXBybPYQENy9S+8PZe
         k6ZSFBiYr9fbEYQbM6rRv/DR2XgLO24XJf8L0UuU68CeOoKuZAu2/boqhIdqiToNC5
         T8cJ59iajj+R19UoXmZ9z7kf8blmrncN4QoFUVIFXiwQHHqYquTW5OfSw955OTFvSP
         32KBNX45k7Ud7J7Qea9xLiBh24nbLo/AnNBUqt3SYj/S80+n9R6MHzHqjNXIRx2das
         q/07c/8Dr3kUw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] efi: earlycon: Reprobe after parsing config tables
Date:   Sun, 12 Mar 2023 23:12:21 +0100
Message-Id: <20230312221221.3653857-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3323; i=ardb@kernel.org; h=from:subject; bh=8mbI8D3XlDUqs2Z6m01RfnZuIds5N1fyoQdQU6rdyQs=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXPzyXdlVF910Rps3PWDPs0ub+y5k2wm9AsuMhzgurKi idiZ1Z2lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIkITGdkeBYs4rrjG2/UQT6Z Kf8ebtjtEzej2WG30L2X/CsbE8686mT4XxCzaF3J908HJxs1ldWn3Fv6ev19Pp51Yc+Fw2607jz ixA4A
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit 732ea9db9d8a ("efi: libstub: Move screen_info handling to common
code") reorganized the earlycon handling so that all architectures pass
the screen_info data via a EFI config table instead of populating struct
screen_info directly, as the latter is only possible when the EFI stub
is baked into the kernel (and not into the decompressor).

However, this means that struct screen_info may not have been populated
yet by the time the earlycon probe takes place, and this results in a
non-functional early console.

So let's probe again right after parsing the config tables and
populating struct screen_info. Note that this means that earlycon output
starts a bit later than before, and so it may fail to capture issues
that occur while doing the early EFI initialization.

Cc: Xuefeng Li <lixuefeng@loongson.cn>
Cc: Xuerui Wang <kernel@xen0n.name>
Cc: Huacai Chen <chenhuacai@loongson.cn>
Reported-by: Shawn Guo <shawn.guo@linaro.org>
Fixes: 732ea9db9d8a ("efi: libstub: Move screen_info handling to common code")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/earlycon.c | 16 +++++++++++++---
 drivers/firmware/efi/efi-init.c |  2 ++
 include/linux/efi.h             |  1 +
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/earlycon.c b/drivers/firmware/efi/earlycon.c
index f54e6fdf08e2bf4c..f80a9af3d16e94de 100644
--- a/drivers/firmware/efi/earlycon.c
+++ b/drivers/firmware/efi/earlycon.c
@@ -215,6 +215,14 @@ efi_earlycon_write(struct console *con, const char *str, unsigned int num)
 	}
 }
 
+static bool __initdata fb_probed;
+
+void __init efi_earlycon_reprobe(void)
+{
+	if (fb_probed)
+		setup_earlycon("efifb");
+}
+
 static int __init efi_earlycon_setup(struct earlycon_device *device,
 				     const char *opt)
 {
@@ -222,15 +230,17 @@ static int __init efi_earlycon_setup(struct earlycon_device *device,
 	u16 xres, yres;
 	u32 i;
 
-	if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
+	fb_wb = opt && !strcmp(opt, "ram");
+
+	if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI) {
+		fb_probed = true;
 		return -ENODEV;
+	}
 
 	fb_base = screen_info.lfb_base;
 	if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
 		fb_base |= (u64)screen_info.ext_lfb_base << 32;
 
-	fb_wb = opt && !strcmp(opt, "ram");
-
 	si = &screen_info;
 	xres = si->lfb_width;
 	yres = si->lfb_height;
diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
index 2c16080e1f71907c..e6deb3c3ebe67b9f 100644
--- a/drivers/firmware/efi/efi-init.c
+++ b/drivers/firmware/efi/efi-init.c
@@ -72,6 +72,8 @@ static void __init init_screen_info(void)
 		if (memblock_is_map_memory(screen_info.lfb_base))
 			memblock_mark_nomap(screen_info.lfb_base,
 					    screen_info.lfb_size);
+
+		efi_earlycon_reprobe();
 	}
 }
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 04a733f0ba956211..7aa62c92185f6467 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -693,6 +693,7 @@ efi_guid_to_str(efi_guid_t *guid, char *out)
 }
 
 extern void efi_init (void);
+extern void efi_earlycon_reprobe(void);
 #ifdef CONFIG_EFI
 extern void efi_enter_virtual_mode (void);	/* switch EFI to virtual mode, if possible */
 #else
-- 
2.39.2

