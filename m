Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7D53B4432
	for <lists+linux-efi@lfdr.de>; Fri, 25 Jun 2021 15:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhFYNQc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 25 Jun 2021 09:16:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52902 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231524AbhFYNQc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 25 Jun 2021 09:16:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624626851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=s7awfWkAS5LAQERp0OJmH9ButVjjbS3AYez2f5Gw2zY=;
        b=HW5a8c1idZopgecZejm+mccKSx3efW7V5EPBOCVlI7LC4cNYRsGyLYUQP5V+khoDhcSTxY
        xKZ4BRgQ60Tzvl6r5j6d3OdlL3BP6/y5EjY8KMwC7sqYcm2A/WNiHkBQmuxeGNLeM2J2S3
        EpIdf1oF1x6o4wRITRgsbxYPYQxN9cE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194--Zfj7HFsM-m5Dm9Gm5ytLA-1; Fri, 25 Jun 2021 09:14:09 -0400
X-MC-Unique: -Zfj7HFsM-m5Dm9Gm5ytLA-1
Received: by mail-wr1-f72.google.com with SMTP id b3-20020a05600018a3b029011a84f85e1cso3489391wri.10
        for <linux-efi@vger.kernel.org>; Fri, 25 Jun 2021 06:14:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s7awfWkAS5LAQERp0OJmH9ButVjjbS3AYez2f5Gw2zY=;
        b=ROZlKOPYXJC38fQDstMjOlrmzRh5vfEBIfp3oL0xq/Wor3LAZWw5mGf/J9Y48Mt3ze
         m6LTnt9PwICkpTEF7TlK19TqWoBW7dFNj9XueujyojUh923FlfUMksiW4sv7SoPRUfbU
         wqXSdwXsQJti0etuepEJ2RuxgXo5iypbHkUoE+oaqmNNs+3sjgJKoUm7/Zou5hWlU6Sp
         /68OTtpM6y/UK5yhlHMe1R5KM/81iRkuWOynNl/1RqrBOUu11ZVzCfjtEOFMEDTM1eYQ
         LavvbIp2hFkpaDXwp/naQo5WxWlPVap56CEH96hRJJ5Ts+TVG9vPsoejWWuW0iI8fC+F
         jDhw==
X-Gm-Message-State: AOAM532IiqhmgeflYXhTuEgfuLq4t9s3NrTCtcrfRtp6GeTyKnenZWLF
        B4EeOvDihNbc3tWVYtx/u8I+Y+tMOUnSkHG0veEpJnsCikHSqMhUQ+CNiX4tCVNtmSv+ykzqGBG
        wcfoSi0tHKTqFMPCQawfu
X-Received: by 2002:a05:600c:1988:: with SMTP id t8mr10997081wmq.23.1624626846528;
        Fri, 25 Jun 2021 06:14:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyB5nqLSDa3qF0D8gBCVt3C2KvjfgHYeT5oQ6LEZ2IVsvkiuwMuWV1U36BkCOhalF/tAJRrDw==
X-Received: by 2002:a05:600c:1988:: with SMTP id t8mr10997033wmq.23.1624626846211;
        Fri, 25 Jun 2021 06:14:06 -0700 (PDT)
Received: from minerva.redhat.com ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id d4sm5815927wmd.42.2021.06.25.06.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 06:14:05 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, Borislav Petkov <bp@suse.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Peter Robinson <pbrobinson@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Atish Patra <atish.patra@wdc.com>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v3 2/2] drivers/firmware: consolidate EFI framebuffer setup for all arches
Date:   Fri, 25 Jun 2021 15:13:59 +0200
Message-Id: <20210625131359.1804394-1-javierm@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The register_gop_device() function registers an "efi-framebuffer" platform
device to match against the efifb driver, to have an early framebuffer for
EFI platforms.

But there is already support to do exactly the same by the Generic System
Framebuffers (sysfb) driver. This used to be only for X86 but it has been
moved to drivers/firmware and could be reused by other architectures.

Also, besides supporting registering an "efi-framebuffer", this driver can
register a "simple-framebuffer" allowing to use the siple{fb,drm} drivers
on non-X86 EFI platforms. For example, on aarch64 these drivers can only
be used with DT and doesn't have code to register a "simple-frambuffer"
platform device when booting with EFI.

For these reasons, let's remove the register_gop_device() duplicated code
and instead move the platform specific logic that's there to sysfb driver.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Borislav Petkov <bp@suse.de>
---

Changes in v3:
- Also update the SYSFB_SIMPLEFB symbol name in drivers/gpu/drm/tiny/Kconfig.
- We have a a max 100 char limit now, use it to avoid multi-line statements.
- Figure out the platform device name before allocating the platform device.

Changes in v2:
- Use "depends on" for the supported architectures instead of selecting it.
- Improve commit message to explain the benefits of reusing sysfb for !X86.

 arch/arm/include/asm/efi.h        |  5 +-
 arch/arm64/include/asm/efi.h      |  5 +-
 arch/riscv/include/asm/efi.h      |  5 +-
 drivers/firmware/Kconfig          |  8 +--
 drivers/firmware/Makefile         |  2 +-
 drivers/firmware/efi/efi-init.c   | 90 -------------------------------
 drivers/firmware/efi/sysfb_efi.c  | 76 +++++++++++++++++++++++++-
 drivers/firmware/sysfb.c          | 35 ++++++++----
 drivers/firmware/sysfb_simplefb.c | 31 +++++++----
 drivers/gpu/drm/tiny/Kconfig      |  4 +-
 include/linux/sysfb.h             | 26 ++++-----
 11 files changed, 143 insertions(+), 144 deletions(-)

diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
index 9de7ab2ce05d..a6f3b179e8a9 100644
--- a/arch/arm/include/asm/efi.h
+++ b/arch/arm/include/asm/efi.h
@@ -17,6 +17,7 @@
 
 #ifdef CONFIG_EFI
 void efi_init(void);
+extern void efifb_setup_from_dmi(struct screen_info *si, const char *opt);
 
 int efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md);
 int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md);
@@ -52,10 +53,6 @@ void efi_virtmap_unload(void);
 struct screen_info *alloc_screen_info(void);
 void free_screen_info(struct screen_info *si);
 
-static inline void efifb_setup_from_dmi(struct screen_info *si, const char *opt)
-{
-}
-
 /*
  * A reasonable upper bound for the uncompressed kernel size is 32 MBytes,
  * so we will reserve that amount of memory. We have no easy way to tell what
diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 1bed37eb013a..d3e1825337be 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -14,6 +14,7 @@
 
 #ifdef CONFIG_EFI
 extern void efi_init(void);
+extern void efifb_setup_from_dmi(struct screen_info *si, const char *opt);
 #else
 #define efi_init()
 #endif
@@ -85,10 +86,6 @@ static inline void free_screen_info(struct screen_info *si)
 {
 }
 
-static inline void efifb_setup_from_dmi(struct screen_info *si, const char *opt)
-{
-}
-
 #define EFI_ALLOC_ALIGN		SZ_64K
 
 /*
diff --git a/arch/riscv/include/asm/efi.h b/arch/riscv/include/asm/efi.h
index 6d98cd999680..7a8f0d45b13a 100644
--- a/arch/riscv/include/asm/efi.h
+++ b/arch/riscv/include/asm/efi.h
@@ -13,6 +13,7 @@
 
 #ifdef CONFIG_EFI
 extern void efi_init(void);
+extern void efifb_setup_from_dmi(struct screen_info *si, const char *opt);
 #else
 #define efi_init()
 #endif
@@ -39,10 +40,6 @@ static inline void free_screen_info(struct screen_info *si)
 {
 }
 
-static inline void efifb_setup_from_dmi(struct screen_info *si, const char *opt)
-{
-}
-
 void efi_virtmap_load(void);
 void efi_virtmap_unload(void);
 
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 5991071e9d7f..6822727a5e98 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -254,9 +254,9 @@ config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
 config SYSFB
 	bool
 	default y
-	depends on X86 || COMPILE_TEST
+	depends on X86 || ARM || ARM64 || RISCV || COMPILE_TEST
 
-config X86_SYSFB
+config SYSFB_SIMPLEFB
 	bool "Mark VGA/VBE/EFI FB as generic system framebuffer"
 	depends on SYSFB
 	help
@@ -264,10 +264,10 @@ config X86_SYSFB
 	  bootloader or kernel can show basic video-output during boot for
 	  user-guidance and debugging. Historically, x86 used the VESA BIOS
 	  Extensions and EFI-framebuffers for this, which are mostly limited
-	  to x86.
+	  to x86 BIOS or EFI systems.
 	  This option, if enabled, marks VGA/VBE/EFI framebuffers as generic
 	  framebuffers so the new generic system-framebuffer drivers can be
-	  used on x86. If the framebuffer is not compatible with the generic
+	  used instead. If the framebuffer is not compatible with the generic
 	  modes, it is advertised as fallback platform framebuffer so legacy
 	  drivers like efifb, vesafb and uvesafb can pick it up.
 	  If this option is not selected, all system framebuffers are always
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 946dda07443d..705fabe88156 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -19,7 +19,7 @@ obj-$(CONFIG_RASPBERRYPI_FIRMWARE) += raspberrypi.o
 obj-$(CONFIG_FW_CFG_SYSFS)	+= qemu_fw_cfg.o
 obj-$(CONFIG_QCOM_SCM)		+= qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
 obj-$(CONFIG_SYSFB)		+= sysfb.o
-obj-$(CONFIG_X86_SYSFB)		+= sysfb_simplefb.o
+obj-$(CONFIG_SYSFB_SIMPLEFB)	+= sysfb_simplefb.o
 obj-$(CONFIG_TI_SCI_PROTOCOL)	+= ti_sci.o
 obj-$(CONFIG_TRUSTED_FOUNDATIONS) += trusted_foundations.o
 obj-$(CONFIG_TURRIS_MOX_RWTM)	+= turris-mox-rwtm.o
diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
index a552a08a1741..b19ce1a83f91 100644
--- a/drivers/firmware/efi/efi-init.c
+++ b/drivers/firmware/efi/efi-init.c
@@ -275,93 +275,3 @@ void __init efi_init(void)
 	}
 #endif
 }
-
-static bool efifb_overlaps_pci_range(const struct of_pci_range *range)
-{
-	u64 fb_base = screen_info.lfb_base;
-
-	if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
-		fb_base |= (u64)(unsigned long)screen_info.ext_lfb_base << 32;
-
-	return fb_base >= range->cpu_addr &&
-	       fb_base < (range->cpu_addr + range->size);
-}
-
-static struct device_node *find_pci_overlap_node(void)
-{
-	struct device_node *np;
-
-	for_each_node_by_type(np, "pci") {
-		struct of_pci_range_parser parser;
-		struct of_pci_range range;
-		int err;
-
-		err = of_pci_range_parser_init(&parser, np);
-		if (err) {
-			pr_warn("of_pci_range_parser_init() failed: %d\n", err);
-			continue;
-		}
-
-		for_each_of_pci_range(&parser, &range)
-			if (efifb_overlaps_pci_range(&range))
-				return np;
-	}
-	return NULL;
-}
-
-/*
- * If the efifb framebuffer is backed by a PCI graphics controller, we have
- * to ensure that this relation is expressed using a device link when
- * running in DT mode, or the probe order may be reversed, resulting in a
- * resource reservation conflict on the memory window that the efifb
- * framebuffer steals from the PCIe host bridge.
- */
-static int efifb_add_links(struct fwnode_handle *fwnode)
-{
-	struct device_node *sup_np;
-
-	sup_np = find_pci_overlap_node();
-
-	/*
-	 * If there's no PCI graphics controller backing the efifb, we are
-	 * done here.
-	 */
-	if (!sup_np)
-		return 0;
-
-	fwnode_link_add(fwnode, of_fwnode_handle(sup_np));
-	of_node_put(sup_np);
-
-	return 0;
-}
-
-static const struct fwnode_operations efifb_fwnode_ops = {
-	.add_links = efifb_add_links,
-};
-
-static struct fwnode_handle efifb_fwnode;
-
-static int __init register_gop_device(void)
-{
-	struct platform_device *pd;
-	int err;
-
-	if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
-		return 0;
-
-	pd = platform_device_alloc("efi-framebuffer", 0);
-	if (!pd)
-		return -ENOMEM;
-
-	if (IS_ENABLED(CONFIG_PCI)) {
-		fwnode_init(&efifb_fwnode, &efifb_fwnode_ops);
-		pd->dev.fwnode = &efifb_fwnode;
-	}
-
-	err = platform_device_add_data(pd, &screen_info, sizeof(screen_info));
-	if (err)
-		return err;
-
-	return platform_device_add(pd);
-}
-subsys_initcall(register_gop_device);
diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
index 9f035b15501c..f51865e1b876 100644
--- a/drivers/firmware/efi/sysfb_efi.c
+++ b/drivers/firmware/efi/sysfb_efi.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Generic System Framebuffers on x86
+ * Generic System Framebuffers
  * Copyright (c) 2012-2013 David Herrmann <dh.herrmann@gmail.com>
  *
  * EFI Quirks Copyright (c) 2006 Edgar Hucek <gimli@dark-green.com>
@@ -19,7 +19,9 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
+#include <linux/of_address.h>
 #include <linux/pci.h>
+#include <linux/platform_device.h>
 #include <linux/screen_info.h>
 #include <linux/sysfb.h>
 #include <video/vga.h>
@@ -267,7 +269,72 @@ static const struct dmi_system_id efifb_dmi_swap_width_height[] __initconst = {
 	{},
 };
 
-__init void sysfb_apply_efi_quirks(void)
+static bool efifb_overlaps_pci_range(const struct of_pci_range *range)
+{
+	u64 fb_base = screen_info.lfb_base;
+
+	if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
+		fb_base |= (u64)(unsigned long)screen_info.ext_lfb_base << 32;
+
+	return fb_base >= range->cpu_addr &&
+	       fb_base < (range->cpu_addr + range->size);
+}
+
+static struct device_node *find_pci_overlap_node(void)
+{
+	struct device_node *np;
+
+	for_each_node_by_type(np, "pci") {
+		struct of_pci_range_parser parser;
+		struct of_pci_range range;
+		int err;
+
+		err = of_pci_range_parser_init(&parser, np);
+		if (err) {
+			pr_warn("of_pci_range_parser_init() failed: %d\n", err);
+			continue;
+		}
+
+		for_each_of_pci_range(&parser, &range)
+			if (efifb_overlaps_pci_range(&range))
+				return np;
+	}
+	return NULL;
+}
+
+/*
+ * If the efifb framebuffer is backed by a PCI graphics controller, we have
+ * to ensure that this relation is expressed using a device link when
+ * running in DT mode, or the probe order may be reversed, resulting in a
+ * resource reservation conflict on the memory window that the efifb
+ * framebuffer steals from the PCIe host bridge.
+ */
+static int efifb_add_links(struct fwnode_handle *fwnode)
+{
+	struct device_node *sup_np;
+
+	sup_np = find_pci_overlap_node();
+
+	/*
+	 * If there's no PCI graphics controller backing the efifb, we are
+	 * done here.
+	 */
+	if (!sup_np)
+		return 0;
+
+	fwnode_link_add(fwnode, of_fwnode_handle(sup_np));
+	of_node_put(sup_np);
+
+	return 0;
+}
+
+static const struct fwnode_operations efifb_fwnode_ops = {
+	.add_links = efifb_add_links,
+};
+
+static struct fwnode_handle efifb_fwnode;
+
+__init void sysfb_apply_efi_quirks(struct platform_device *pd)
 {
 	if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI ||
 	    !(screen_info.capabilities & VIDEO_CAPABILITY_SKIP_QUIRKS))
@@ -281,4 +348,9 @@ __init void sysfb_apply_efi_quirks(void)
 		screen_info.lfb_height = temp;
 		screen_info.lfb_linelength = 4 * screen_info.lfb_width;
 	}
+
+	if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI && IS_ENABLED(CONFIG_PCI)) {
+		fwnode_init(&efifb_fwnode, &efifb_fwnode_ops);
+		pd->dev.fwnode = &efifb_fwnode;
+	}
 }
diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
index 1337515963d5..2bfbb05f7d89 100644
--- a/drivers/firmware/sysfb.c
+++ b/drivers/firmware/sysfb.c
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Generic System Framebuffers on x86
+ * Generic System Framebuffers
  * Copyright (c) 2012-2013 David Herrmann <dh.herrmann@gmail.com>
  */
 
 /*
- * Simple-Framebuffer support for x86 systems
+ * Simple-Framebuffer support
  * Create a platform-device for any available boot framebuffer. The
  * simple-framebuffer platform device is already available on DT systems, so
  * this module parses the global "screen_info" object and creates a suitable
@@ -16,12 +16,12 @@
  * to pick these devices up without messing with simple-framebuffer drivers.
  * The global "screen_info" is still valid at all times.
  *
- * If CONFIG_X86_SYSFB is not selected, we never register "simple-framebuffer"
+ * If CONFIG_SYSFB_SIMPLEFB is not selected, never register "simple-framebuffer"
  * platform devices, but only use legacy framebuffer devices for
  * backwards compatibility.
  *
  * TODO: We set the dev_id field of all platform-devices to 0. This allows
- * other x86 OF/DT parsers to create such devices, too. However, they must
+ * other OF/DT parsers to create such devices, too. However, they must
  * start at offset 1 for this to work.
  */
 
@@ -43,12 +43,10 @@ static __init int sysfb_init(void)
 	bool compatible;
 	int ret;
 
-	sysfb_apply_efi_quirks();
-
 	/* try to create a simple-framebuffer device */
-	compatible = parse_mode(si, &mode);
+	compatible = sysfb_parse_mode(si, &mode);
 	if (compatible) {
-		ret = create_simplefb(si, &mode);
+		ret = sysfb_create_simplefb(si, &mode);
 		if (!ret)
 			return 0;
 	}
@@ -61,9 +59,24 @@ static __init int sysfb_init(void)
 	else
 		name = "platform-framebuffer";
 
-	pd = platform_device_register_resndata(NULL, name, 0,
-					       NULL, 0, si, sizeof(*si));
-	return PTR_ERR_OR_ZERO(pd);
+	pd = platform_device_alloc(name, 0);
+	if (!pd)
+		return -ENOMEM;
+
+	sysfb_apply_efi_quirks(pd);
+
+	ret = platform_device_add_data(pd, si, sizeof(*si));
+	if (ret)
+		goto err;
+
+	ret = platform_device_add(pd);
+	if (ret)
+		goto err;
+
+	return 0;
+err:
+	platform_device_put(pd);
+	return ret;
 }
 
 /* must execute after PCI subsystem for EFI quirks */
diff --git a/drivers/firmware/sysfb_simplefb.c b/drivers/firmware/sysfb_simplefb.c
index df892444ea17..b86761904949 100644
--- a/drivers/firmware/sysfb_simplefb.c
+++ b/drivers/firmware/sysfb_simplefb.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Generic System Framebuffers on x86
+ * Generic System Framebuffers
  * Copyright (c) 2012-2013 David Herrmann <dh.herrmann@gmail.com>
  */
 
@@ -23,9 +23,9 @@
 static const char simplefb_resname[] = "BOOTFB";
 static const struct simplefb_format formats[] = SIMPLEFB_FORMATS;
 
-/* try parsing x86 screen_info into a simple-framebuffer mode struct */
-__init bool parse_mode(const struct screen_info *si,
-		       struct simplefb_platform_data *mode)
+/* try parsing screen_info into a simple-framebuffer mode struct */
+__init bool sysfb_parse_mode(const struct screen_info *si,
+			     struct simplefb_platform_data *mode)
 {
 	const struct simplefb_format *f;
 	__u8 type;
@@ -57,13 +57,14 @@ __init bool parse_mode(const struct screen_info *si,
 	return false;
 }
 
-__init int create_simplefb(const struct screen_info *si,
-			   const struct simplefb_platform_data *mode)
+__init int sysfb_create_simplefb(const struct screen_info *si,
+				 const struct simplefb_platform_data *mode)
 {
 	struct platform_device *pd;
 	struct resource res;
 	u64 base, size;
 	u32 length;
+	int ret;
 
 	/*
 	 * If the 64BIT_BASE capability is set, ext_lfb_base will contain the
@@ -105,7 +106,19 @@ __init int create_simplefb(const struct screen_info *si,
 	if (res.end <= res.start)
 		return -EINVAL;
 
-	pd = platform_device_register_resndata(NULL, "simple-framebuffer", 0,
-					       &res, 1, mode, sizeof(*mode));
-	return PTR_ERR_OR_ZERO(pd);
+	pd = platform_device_alloc("simple-framebuffer", 0);
+	if (!pd)
+		return -ENOMEM;
+
+	sysfb_apply_efi_quirks(pd);
+
+	ret = platform_device_add_resources(pd, &res, 1);
+	if (ret)
+		return ret;
+
+	ret = platform_device_add_data(pd, mode, sizeof(*mode));
+	if (ret)
+		return ret;
+
+	return platform_device_add(pd);
 }
diff --git a/drivers/gpu/drm/tiny/Kconfig b/drivers/gpu/drm/tiny/Kconfig
index d46f95d9196d..3583ae598b57 100644
--- a/drivers/gpu/drm/tiny/Kconfig
+++ b/drivers/gpu/drm/tiny/Kconfig
@@ -51,8 +51,8 @@ config DRM_SIMPLEDRM
 	  buffer, size, and display format must be provided via device tree,
 	  UEFI, VESA, etc.
 
-	  On x86 and compatible, you should also select CONFIG_X86_SYSFB to
-	  use UEFI and VESA framebuffers.
+	  On x86 BIOS or UEFI systems, you should also select SYSFB_SIMPLEFB
+	  to use UEFI and VESA framebuffers.
 
 config TINYDRM_HX8357D
 	tristate "DRM support for HX8357D display panels"
diff --git a/include/linux/sysfb.h b/include/linux/sysfb.h
index 3e5355769dc3..b0dcfa26d07b 100644
--- a/include/linux/sysfb.h
+++ b/include/linux/sysfb.h
@@ -58,37 +58,37 @@ struct efifb_dmi_info {
 #ifdef CONFIG_EFI
 
 extern struct efifb_dmi_info efifb_dmi_list[];
-void sysfb_apply_efi_quirks(void);
+void sysfb_apply_efi_quirks(struct platform_device *pd);
 
 #else /* CONFIG_EFI */
 
-static inline void sysfb_apply_efi_quirks(void)
+static inline void sysfb_apply_efi_quirks(struct platform_device *pd)
 {
 }
 
 #endif /* CONFIG_EFI */
 
-#ifdef CONFIG_X86_SYSFB
+#ifdef CONFIG_SYSFB_SIMPLEFB
 
-bool parse_mode(const struct screen_info *si,
-		struct simplefb_platform_data *mode);
-int create_simplefb(const struct screen_info *si,
-		    const struct simplefb_platform_data *mode);
+bool sysfb_parse_mode(const struct screen_info *si,
+		      struct simplefb_platform_data *mode);
+int sysfb_create_simplefb(const struct screen_info *si,
+			  const struct simplefb_platform_data *mode);
 
-#else /* CONFIG_X86_SYSFB */
+#else /* CONFIG_SYSFB_SIMPLE */
 
-static inline bool parse_mode(const struct screen_info *si,
-			      struct simplefb_platform_data *mode)
+static inline bool sysfb_parse_mode(const struct screen_info *si,
+				    struct simplefb_platform_data *mode)
 {
 	return false;
 }
 
-static inline int create_simplefb(const struct screen_info *si,
-				  const struct simplefb_platform_data *mode)
+static inline int sysfb_create_simplefb(const struct screen_info *si,
+					 const struct simplefb_platform_data *mode)
 {
 	return -EINVAL;
 }
 
-#endif /* CONFIG_X86_SYSFB */
+#endif /* CONFIG_SYSFB_SIMPLE */
 
 #endif /* _LINUX_SYSFB_H */
-- 
2.31.1

