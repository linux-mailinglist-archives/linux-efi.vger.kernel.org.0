Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0EA7BED29
	for <lists+linux-efi@lfdr.de>; Mon,  9 Oct 2023 23:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378804AbjJIVVy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 9 Oct 2023 17:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378703AbjJIVVS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 9 Oct 2023 17:21:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41216133;
        Mon,  9 Oct 2023 14:20:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57782C433A9;
        Mon,  9 Oct 2023 21:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696886434;
        bh=IUe9zQKsuCSW8PZPXBcaUGQEXOnvJDkNFrZmACx/Wc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NmSWIJiIMcyJjUfY5qC1+UVpedpmfmM66fmZu9OPQGX55nM5F1ijugpZATvGMMYLN
         4OtJ68KWwnxC5sKEJHnXB0aPfh+L7jtRdvG3Ur9gFXkeieGSWAIA5v1RDLallZ7LaF
         ECZ4HTzfRXUiKmQKck0yRmHpvNA52NglqFMVnZjDkiAdX+Jc8CuUNLPfTEUBovYWNI
         KCj8GVKYtCzYKzH0wh/izBEtRrF1Kby4mGFn1lYaWezV/u9j863swaEgD7FOiPVxvg
         rv5hmStNIP5G+DhKDG1qddwfAUsgPb2O3uS107yfh00B9t616gUllJtrSz0BpX17wX
         Z9rWHJNyiE9Iw==
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
Subject: [PATCH v3 8/9] hyperv: avoid dependency on screen_info
Date:   Mon,  9 Oct 2023 23:18:44 +0200
Message-Id: <20231009211845.3136536-9-arnd@kernel.org>
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

The two hyperv framebuffer drivers (hyperv_fb or hyperv_drm_drv) access the
global screen_info in order to take over from the sysfb framebuffer, which
in turn could be handled by simplefb, simpledrm or efifb. Similarly, the
vmbus_drv code marks the original EFI framebuffer as reserved, but this
is not required if there is no sysfb.

As a preparation for making screen_info itself more local to the sysfb
helper code, add a compile-time conditional in all three files that relate
to hyperv fb and just skip this code if there is no sysfb that needs to
be unregistered.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Helge Deller <deller@gmx.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 7 ++++---
 drivers/hv/vmbus_drv.c                  | 6 ++++--
 drivers/video/fbdev/hyperv_fb.c         | 8 ++++----
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
index 58b0b46a21e68..d511d17c5bdfc 100644
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
index edbb38f6956b9..b33d5abd9beb2 100644
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
index 2e27c6bd80442..bf59daf862fc7 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -1010,7 +1010,7 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
 			goto getmem_done;
 		}
 		pr_info("Unable to allocate enough contiguous physical memory on Gen 1 VM. Using MMIO instead.\n");
-	} else {
+	} else if (IS_ENABLED(CONFIG_SYSFB)) {
 		base = screen_info.lfb_base;
 		size = screen_info.lfb_size;
 	}
@@ -1056,13 +1056,13 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
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

