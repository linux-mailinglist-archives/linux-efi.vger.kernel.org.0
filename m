Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A62738CE2E
	for <lists+linux-efi@lfdr.de>; Fri, 21 May 2021 21:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238825AbhEUTbP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 May 2021 15:31:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55284 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231740AbhEUTbO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 May 2021 15:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621625391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/8NKN0w5GHfdskk80apLWz7YtekHX6q4NsuQJAhpw00=;
        b=OV3hmkZzofINA4E/pUqtUPmxeuGPcqO8qIcqh/vREGvVrTj1IjZdIZJFdrHEj7PGMZqkhP
        nAje9822AZPfqlk5ncznV4FsCD6rO5sy1pGegc1e7XAkfBH56fo/erBLyhbuxR3/s7D7XJ
        nAvwE4vU3FMASZAT/2icalFyzg+gBe4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-OLdfIG30OUSgh_9tmHyulQ-1; Fri, 21 May 2021 15:29:49 -0400
X-MC-Unique: OLdfIG30OUSgh_9tmHyulQ-1
Received: by mail-wm1-f71.google.com with SMTP id f141-20020a1c1f930000b029017ce5240ed6so1402177wmf.5
        for <linux-efi@vger.kernel.org>; Fri, 21 May 2021 12:29:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/8NKN0w5GHfdskk80apLWz7YtekHX6q4NsuQJAhpw00=;
        b=IA0IwkQlyo6BexXgRJVbCmq/xkgv46qorpbN6F5eaxvM2dpd30dTP5oMIXcCICez0O
         F8hkg7q2gFDi2fXOdPa9fswuYWSogS3KI18+kqHiJ4h8TK5unxwhGoZvOiPHdMEBiBTd
         mKbA7sjNFMHLTnR96G5atICh7B3kMRWztTf4vRWdvDTSx3Pu7xprU/z2DWUIf5oVG2qt
         +SiORtS5cCb9ygwxPRFZrLVb5ZGgK9Pk9CFGnt5y5UltwNBMxmet0mrdc5C4j3SZnMgM
         wg1VUDI1zUUKH9ZECkwHROEmxzMnjRtKLd/lB6WURcQmNPUCqRpZZih1KPOX9Lu/Vg0v
         rZSw==
X-Gm-Message-State: AOAM530OFdrRA0aEH6euAjotxI9ToS47xQQgm1i/XRYE+GPzqp81/nxu
        5uBm9QnV5JRMJwx5esJ1uNpORxKtK2+3cjdLo8Cis+xxLx5aQPLBY9BCkbRtoZn9Sfsx48DXx9m
        LOaMYIxKouSa2jqllzcVB
X-Received: by 2002:a5d:5306:: with SMTP id e6mr10633342wrv.324.1621625386439;
        Fri, 21 May 2021 12:29:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyem/U4BZ3sK3T5jbmdBM7ZSEmSzlS0nLM/lV3Rjx1ipXZ1Ox9ipyhoTfkAlPi0JAydciwMBA==
X-Received: by 2002:a5d:5306:: with SMTP id e6mr10633322wrv.324.1621625386206;
        Fri, 21 May 2021 12:29:46 -0700 (PDT)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id s7sm434402wmh.35.2021.05.21.12.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 12:29:45 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Peter Robinson <pbrobinson@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Hans de Goede <hdegoede@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org, x86@kernel.org
Subject: [PATCH 1/2] drivers/firmware: move x86 Generic System Framebuffers support
Date:   Fri, 21 May 2021 21:29:05 +0200
Message-Id: <20210521192907.3040644-2-javierm@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210521192907.3040644-1-javierm@redhat.com>
References: <20210521192907.3040644-1-javierm@redhat.com>
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

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 arch/x86/Kconfig                              | 27 +---------------
 arch/x86/kernel/Makefile                      |  3 --
 drivers/firmware/Kconfig                      | 31 +++++++++++++++++++
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
index 0045e1b4419..40816b5be27 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -257,6 +257,7 @@ config X86
 	select SRCU
 	select STACK_VALIDATION			if HAVE_STACK_VALIDATION && (HAVE_STATIC_CALL_INLINE || RETPOLINE)
 	select SYSCTL_EXCEPTION_TRACE
+	select SYSFB
 	select THREAD_INFO_IN_TASK
 	select USER_STACKTRACE_SUPPORT
 	select VIRT_TO_BUS
@@ -2806,32 +2807,6 @@ config AMD_NB
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
index 0704c2a9427..149a0f8e89d 100644
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
index db0ea2d2d75..396bd1d5cbf 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -251,6 +251,37 @@ config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
 
 	  Say Y here to enable "download mode" by default.
 
+config SYSFB
+	bool
+	depends on X86
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
index 5e013b6a369..ad78f78ffa8 100644
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

