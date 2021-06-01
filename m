Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3563975ED
	for <lists+linux-efi@lfdr.de>; Tue,  1 Jun 2021 16:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbhFAPBM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Jun 2021 11:01:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40023 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234387AbhFAPBK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Jun 2021 11:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622559568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gmQ5sapNm/J3W6mK4f4jmCWQiczf9fEBrpQYFqEuvNI=;
        b=BBQ/HprJ5D573XrQI/9nbc4GmcrUlDfiEqvIUjaz2RPxNZWN7lJoRVkmYzgNdqLEp5Nlhf
        iNZ6DfMk5pCj5FHIjU4t7dC+B64v9+5YXqtQAOGhW+XybIemyIa2PNk5pFBeXrIY7dH06R
        F4MxJvpEquuXLUwS4CeaurJQQyLSJRk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-MxV7o5xlNRy-0x2VGPNxbQ-1; Tue, 01 Jun 2021 10:59:27 -0400
X-MC-Unique: MxV7o5xlNRy-0x2VGPNxbQ-1
Received: by mail-wr1-f69.google.com with SMTP id k25-20020a5d52590000b0290114dee5b660so3316135wrc.16
        for <linux-efi@vger.kernel.org>; Tue, 01 Jun 2021 07:59:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gmQ5sapNm/J3W6mK4f4jmCWQiczf9fEBrpQYFqEuvNI=;
        b=ho0Kd3pO/176eVxYXsltkV+R3+SA/NGpg95ImP2519FTtclxkIt7o00YDMVjcD7GQd
         WOccaFarVC/4GKXCxq0v8F5OpuxdNgoY/9SdvRaKbp/fHRW/aOWaeEaTouqOPFYHZHNu
         auVqxn/NcStQeiYFiUnMABztAyNmCVhqDj7zrhp/scf3LfOgBNIgraRfcDtpbc+M89hk
         Gd+ZJYH+rZQcelHRRqgv89jUz4dLX8ZFh8muwwvcszFRDOHlifaLnLlEnEPN/ACN6EIZ
         OlJEnnIwAWy9qsZECgTqVw3vc9hCPEQD+m0meZOpVtaxS/yjhkwAqh1cKC97tazHuMOm
         JBJA==
X-Gm-Message-State: AOAM533mWAv1z3I9Mg+d6m+gR9FqVs4hsF9cBaMpJZbmWLJCp1DaAYrJ
        J0wvD59D5MyEU06BKTH913+vP/lt1UWlYBsceJCd1MgZQOe9BVv2YZbK393o7dTQb/nxab0S4y8
        rRIoOVhl3NbtfJrZ1nYsp
X-Received: by 2002:adf:8bd4:: with SMTP id w20mr15579520wra.310.1622559566221;
        Tue, 01 Jun 2021 07:59:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQHrKdO567c3olyoWc4lzbbNuTy4CMdhBLpG2aYelB09sF8IxFHqikVKvNNAfTaXCw3YhB1Q==
X-Received: by 2002:adf:8bd4:: with SMTP id w20mr15579486wra.310.1622559565948;
        Tue, 01 Jun 2021 07:59:25 -0700 (PDT)
Received: from minerva.redhat.com ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id h6sm3533153wrt.6.2021.06.01.07.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 07:59:25 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Chester Lin <clin@suse.com>, Dinh Nguyen <dinguyen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        John Stultz <john.stultz@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org, x86@kernel.org
Subject: [PATCH v2 1/2] drivers/firmware: move x86 Generic System Framebuffers support
Date:   Tue,  1 Jun 2021 16:59:11 +0200
Message-Id: <20210601145912.774054-2-javierm@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210601145912.774054-1-javierm@redhat.com>
References: <20210601145912.774054-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The x86 architecture has generic support to register a system framebuffer
platform device. It either registers a "simple-framebuffer" if the config
option CONFIG_X86_SYSFB is enabled, or a legacy VGA/VBE/EFI FB device.

But the code is generic enough to be reused by other architectures and can
be moved out of the arch/x86 directory.

This will allow to also support the simple{fb,drm} drivers on non-x86 EFI
platforms, such as aarch64 where these drivers are only supported with DT.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

Changes in v2:
- Use default y and depends on X86 instead doing a select in arch/x86/Kconfig.
- Also enable the SYSFB Kconfig option when COMPILE_TEST.
- Improve commit message to explain why is useful for other arches to use this.

 arch/x86/Kconfig                              | 26 ---------------
 arch/x86/kernel/Makefile                      |  3 --
 drivers/firmware/Kconfig                      | 32 +++++++++++++++++++
 drivers/firmware/Makefile                     |  2 ++
 drivers/firmware/efi/Makefile                 |  2 ++
 .../firmware/efi}/sysfb_efi.c                 |  2 +-
 {arch/x86/kernel => drivers/firmware}/sysfb.c |  2 +-
 .../firmware}/sysfb_simplefb.c                |  2 +-
 .../x86/include/asm => include/linux}/sysfb.h |  6 ++--
 9 files changed, 42 insertions(+), 35 deletions(-)
 rename {arch/x86/kernel => drivers/firmware/efi}/sysfb_efi.c (99%)
 rename {arch/x86/kernel => drivers/firmware}/sysfb.c (98%)
 rename {arch/x86/kernel => drivers/firmware}/sysfb_simplefb.c (99%)
 rename {arch/x86/include/asm => include/linux}/sysfb.h (95%)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 39175aa072e..9907d4bed70 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2796,32 +2796,6 @@ config AMD_NB
 	def_bool y
 	depends on CPU_SUP_AMD && PCI
 
-config X86_SYSFB
-	bool "Mark VGA/VBE/EFI FB as generic system framebuffer"
-	help
-	  Firmwares often provide initial graphics framebuffers so the BIOS,
-	  bootloader or kernel can show basic video-output during boot for
-	  user-guidance and debugging. Historically, x86 used the VESA BIOS
-	  Extensions and EFI-framebuffers for this, which are mostly limited
-	  to x86.
-	  This option, if enabled, marks VGA/VBE/EFI framebuffers as generic
-	  framebuffers so the new generic system-framebuffer drivers can be
-	  used on x86. If the framebuffer is not compatible with the generic
-	  modes, it is advertised as fallback platform framebuffer so legacy
-	  drivers like efifb, vesafb and uvesafb can pick it up.
-	  If this option is not selected, all system framebuffers are always
-	  marked as fallback platform framebuffers as usual.
-
-	  Note: Legacy fbdev drivers, including vesafb, efifb, uvesafb, will
-	  not be able to pick up generic system framebuffers if this option
-	  is selected. You are highly encouraged to enable simplefb as
-	  replacement if you select this option. simplefb can correctly deal
-	  with generic system framebuffers. But you should still keep vesafb
-	  and others enabled as fallback if a system framebuffer is
-	  incompatible with simplefb.
-
-	  If unsure, say Y.
-
 endmenu
 
 
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 0f66682ac02..4114ea47def 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -135,9 +135,6 @@ obj-$(CONFIG_X86_CHECK_BIOS_CORRUPTION) += check.o
 obj-$(CONFIG_SWIOTLB)			+= pci-swiotlb.o
 obj-$(CONFIG_OF)			+= devicetree.o
 obj-$(CONFIG_UPROBES)			+= uprobes.o
-obj-y					+= sysfb.o
-obj-$(CONFIG_X86_SYSFB)			+= sysfb_simplefb.o
-obj-$(CONFIG_EFI)			+= sysfb_efi.o
 
 obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o
 obj-$(CONFIG_TRACING)			+= tracepoint.o
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index b53ac9fc770..4392fc57cf3 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -251,6 +251,38 @@ config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
 
 	  Say Y here to enable "download mode" by default.
 
+config SYSFB
+	bool
+	default y
+	depends on X86 || COMPILE_TEST
+
+config X86_SYSFB
+	bool "Mark VGA/VBE/EFI FB as generic system framebuffer"
+	depends on SYSFB
+	help
+	  Firmwares often provide initial graphics framebuffers so the BIOS,
+	  bootloader or kernel can show basic video-output during boot for
+	  user-guidance and debugging. Historically, x86 used the VESA BIOS
+	  Extensions and EFI-framebuffers for this, which are mostly limited
+	  to x86.
+	  This option, if enabled, marks VGA/VBE/EFI framebuffers as generic
+	  framebuffers so the new generic system-framebuffer drivers can be
+	  used on x86. If the framebuffer is not compatible with the generic
+	  modes, it is advertised as fallback platform framebuffer so legacy
+	  drivers like efifb, vesafb and uvesafb can pick it up.
+	  If this option is not selected, all system framebuffers are always
+	  marked as fallback platform framebuffers as usual.
+
+	  Note: Legacy fbdev drivers, including vesafb, efifb, uvesafb, will
+	  not be able to pick up generic system framebuffers if this option
+	  is selected. You are highly encouraged to enable simplefb as
+	  replacement if you select this option. simplefb can correctly deal
+	  with generic system framebuffers. But you should still keep vesafb
+	  and others enabled as fallback if a system framebuffer is
+	  incompatible with simplefb.
+
+	  If unsure, say Y.
+
 config TI_SCI_PROTOCOL
 	tristate "TI System Control Interface (TISCI) Message Protocol"
 	depends on TI_MESSAGE_MANAGER
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 546ac8e7f6d..946dda07443 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -18,6 +18,8 @@ obj-$(CONFIG_FIRMWARE_MEMMAP)	+= memmap.o
 obj-$(CONFIG_RASPBERRYPI_FIRMWARE) += raspberrypi.o
 obj-$(CONFIG_FW_CFG_SYSFS)	+= qemu_fw_cfg.o
 obj-$(CONFIG_QCOM_SCM)		+= qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
+obj-$(CONFIG_SYSFB)		+= sysfb.o
+obj-$(CONFIG_X86_SYSFB)		+= sysfb_simplefb.o
 obj-$(CONFIG_TI_SCI_PROTOCOL)	+= ti_sci.o
 obj-$(CONFIG_TRUSTED_FOUNDATIONS) += trusted_foundations.o
 obj-$(CONFIG_TURRIS_MOX_RWTM)	+= turris-mox-rwtm.o
diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index 467e9425967..c02ff25dd47 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -36,6 +36,8 @@ obj-$(CONFIG_LOAD_UEFI_KEYS)		+= mokvar-table.o
 fake_map-y				+= fake_mem.o
 fake_map-$(CONFIG_X86)			+= x86_fake_mem.o
 
+obj-$(CONFIG_SYSFB)			+= sysfb_efi.o
+
 arm-obj-$(CONFIG_EFI)			:= efi-init.o arm-runtime.o
 obj-$(CONFIG_ARM)			+= $(arm-obj-y)
 obj-$(CONFIG_ARM64)			+= $(arm-obj-y)
diff --git a/arch/x86/kernel/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
similarity index 99%
rename from arch/x86/kernel/sysfb_efi.c
rename to drivers/firmware/efi/sysfb_efi.c
index 8a56a6d8009..9f035b15501 100644
--- a/arch/x86/kernel/sysfb_efi.c
+++ b/drivers/firmware/efi/sysfb_efi.c
@@ -21,10 +21,10 @@
 #include <linux/mm.h>
 #include <linux/pci.h>
 #include <linux/screen_info.h>
+#include <linux/sysfb.h>
 #include <video/vga.h>
 
 #include <asm/efi.h>
-#include <asm/sysfb.h>
 
 enum {
 	OVERRIDE_NONE = 0x0,
diff --git a/arch/x86/kernel/sysfb.c b/drivers/firmware/sysfb.c
similarity index 98%
rename from arch/x86/kernel/sysfb.c
rename to drivers/firmware/sysfb.c
index 014ebd8ca86..1337515963d 100644
--- a/arch/x86/kernel/sysfb.c
+++ b/drivers/firmware/sysfb.c
@@ -32,7 +32,7 @@
 #include <linux/platform_data/simplefb.h>
 #include <linux/platform_device.h>
 #include <linux/screen_info.h>
-#include <asm/sysfb.h>
+#include <linux/sysfb.h>
 
 static __init int sysfb_init(void)
 {
diff --git a/arch/x86/kernel/sysfb_simplefb.c b/drivers/firmware/sysfb_simplefb.c
similarity index 99%
rename from arch/x86/kernel/sysfb_simplefb.c
rename to drivers/firmware/sysfb_simplefb.c
index 298fc1edd9c..df892444ea1 100644
--- a/arch/x86/kernel/sysfb_simplefb.c
+++ b/drivers/firmware/sysfb_simplefb.c
@@ -18,7 +18,7 @@
 #include <linux/platform_data/simplefb.h>
 #include <linux/platform_device.h>
 #include <linux/screen_info.h>
-#include <asm/sysfb.h>
+#include <linux/sysfb.h>
 
 static const char simplefb_resname[] = "BOOTFB";
 static const struct simplefb_format formats[] = SIMPLEFB_FORMATS;
diff --git a/arch/x86/include/asm/sysfb.h b/include/linux/sysfb.h
similarity index 95%
rename from arch/x86/include/asm/sysfb.h
rename to include/linux/sysfb.h
index 9834eef7f03..3e5355769dc 100644
--- a/arch/x86/include/asm/sysfb.h
+++ b/include/linux/sysfb.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-#ifndef _ARCH_X86_KERNEL_SYSFB_H
-#define _ARCH_X86_KERNEL_SYSFB_H
+#ifndef _LINUX_SYSFB_H
+#define _LINUX_SYSFB_H
 
 /*
  * Generic System Framebuffers on x86
@@ -91,4 +91,4 @@ static inline int create_simplefb(const struct screen_info *si,
 
 #endif /* CONFIG_X86_SYSFB */
 
-#endif /* _ARCH_X86_KERNEL_SYSFB_H */
+#endif /* _LINUX_SYSFB_H */
-- 
2.31.1

