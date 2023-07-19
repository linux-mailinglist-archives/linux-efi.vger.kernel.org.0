Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC907595B2
	for <lists+linux-efi@lfdr.de>; Wed, 19 Jul 2023 14:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjGSMmR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Jul 2023 08:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjGSMly (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Jul 2023 08:41:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C96F271D;
        Wed, 19 Jul 2023 05:41:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAC766165F;
        Wed, 19 Jul 2023 12:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88321C43391;
        Wed, 19 Jul 2023 12:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689770491;
        bh=9fW6U6BHu4TUL4RWpVUJbdMggGEj9FTfMpLEh+DKB4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bQx8YO5rdZGaGJpL2Tgt6DTW/RbyR/A8QofqucAc+4eXdqqSGZqRJ1SkbMDzh4BLI
         2NLToZZIHIF9hyPL+Cyk9ib9veIe3JFCFQPNi1M5+29webS34B7tOY2yr6coi1kyR9
         68cbQ5j1lku+Y3+WAYkMKAfJYmwUgtN18hZyJw7RPd8HjbKYCKDKOoyZuP0RMlDEPX
         GCkx3VMGRM6F3nmHYu2QILv1caInSzegNyJm5qhaqJg/HU5Vh3+s6GYahBrXTRz+u2
         q5NpRtNW4/xAU+AMW7Nj2hyg2oXsH5ekaaNx3M1dPNTw9WEqMuc5GB/KyGcnL8ktIs
         NotTDXWPm4GSw==
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
Subject: [PATCH v2 8/9] hyperv: avoid dependency on screen_info
Date:   Wed, 19 Jul 2023 14:39:43 +0200
Message-Id: <20230719123944.3438363-9-arnd@kernel.org>
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

The two hyperv framebuffer drivers (hyperv_fb or hyperv_drm_drv) access the
global screen_info in order to take over from the sysfb framebuffer, which
in turn could be handled by simplefb, simpledrm or efifb. Similarly, the
vmbus_drv code marks the original EFI framebuffer as reserved, but this
is not required if there is no sysfb.

As a preparation for making screen_info itself more local to the sysfb
helper code, add a compile-time conditional in all three files that relate
to hyperv fb and just skip this code if there is no sysfb that needs to
be unregistered.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 7 ++++---
 drivers/hv/vmbus_drv.c                  | 6 ++++--
 drivers/video/fbdev/hyperv_fb.c         | 8 ++++----
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
index 8026118c6e033..9a44a00effc24 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
@@ -73,9 +73,10 @@ static int hyperv_setup_vram(struct hyperv_drm_device *hv,
 	struct drm_device *dev = &hv->dev;
 	int ret;
 
-	drm_aperture_remove_conflicting_framebuffers(screen_info.lfb_base,
-						     screen_info.lfb_size,
-						     &hyperv_driver);
+	if (IS_ENABLED(CONFIG_SYSFB))
+		drm_aperture_remove_conflicting_framebuffers(screen_info.lfb_base,
+							     screen_info.lfb_size,
+							     &hyperv_driver);
 
 	hv->fb_size = (unsigned long)hv->mmio_megabytes * 1024 * 1024;
 
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 67f95a29aeca5..5bc059e8a9f5f 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2100,8 +2100,10 @@ static void __maybe_unused vmbus_reserve_fb(void)
 
 	if (efi_enabled(EFI_BOOT)) {
 		/* Gen2 VM: get FB base from EFI framebuffer */
-		start = screen_info.lfb_base;
-		size = max_t(__u32, screen_info.lfb_size, 0x800000);
+		if (IS_ENABLED(CONFIG_SYSFB)) {
+			start = screen_info.lfb_base;
+			size = max_t(__u32, screen_info.lfb_size, 0x800000);
+		}
 	} else {
 		/* Gen1 VM: get FB base from PCI */
 		pdev = pci_get_device(PCI_VENDOR_ID_MICROSOFT,
diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index b331452aab4fb..7e0d1c4235549 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -1030,7 +1030,7 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
 			goto getmem_done;
 		}
 		pr_info("Unable to allocate enough contiguous physical memory on Gen 1 VM. Using MMIO instead.\n");
-	} else {
+	} else if (IS_ENABLED(CONFIG_SYSFB)) {
 		base = screen_info.lfb_base;
 		size = screen_info.lfb_size;
 	}
@@ -1076,13 +1076,13 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
 getmem_done:
 	aperture_remove_conflicting_devices(base, size, KBUILD_MODNAME);
 
-	if (gen2vm) {
+	if (!gen2vm) {
+		pci_dev_put(pdev);
+	} else if (IS_ENABLED(CONFIG_SYSFB)) {
 		/* framebuffer is reallocated, clear screen_info to avoid misuse from kexec */
 		screen_info.lfb_size = 0;
 		screen_info.lfb_base = 0;
 		screen_info.orig_video_isVGA = 0;
-	} else {
-		pci_dev_put(pdev);
 	}
 
 	return 0;
-- 
2.39.2

