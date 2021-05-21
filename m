Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C0E38CE42
	for <lists+linux-efi@lfdr.de>; Fri, 21 May 2021 21:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239111AbhEUTim (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 May 2021 15:38:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24214 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232214AbhEUTil (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 May 2021 15:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621625837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fa9C0WBJ+BnUNnfdYZgP3Jm6YVcpbeVEclTRzpQPr2o=;
        b=WTDc8Z+LEZ47eMKujWEBpWaGVt81+MHUtoAOjAmhztEFjO4ckoXEvLjcDWUcuNN6io91pC
        Y4w07IJYp0dPcIYnGomsRduebuodK8bktYtqGI9kiZn8f11OFZyQqDjxElMUrr5LHRcvrj
        KAi2ohgwsZ3PnrV+sDQCRF+rsseSKGY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-SYTaxt88MqqFLXifPjPLwA-1; Fri, 21 May 2021 15:37:16 -0400
X-MC-Unique: SYTaxt88MqqFLXifPjPLwA-1
Received: by mail-wm1-f70.google.com with SMTP id o10-20020a05600c4fcab029014ae7fdec90so2964144wmq.5
        for <linux-efi@vger.kernel.org>; Fri, 21 May 2021 12:37:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fa9C0WBJ+BnUNnfdYZgP3Jm6YVcpbeVEclTRzpQPr2o=;
        b=UDr+UQ9mnnJt3GEUPzfUOngFD5XuGALAyvTKHRYwlr2ddMKgk3MmCxSiHyLfTa2en7
         BIZ7GgfI7I2fzEv1h2oJi4pXrF6zF5xQfUHHfRb2Qt2CMMKq0h23oxSwXHnwlalnSHOo
         v0TTQP3QYFcThqiG9Af/3Fv9v1o6xITcbCuGaTo5KGNp4xEj47wjbUH45BJnTJLhKcAu
         70/mm5bju9XmMQuolYnUgrZUH7E3lzYqPcP7D+6wEfqOFQY+QTOp87wbmZKWY0waQ47p
         mhS71PJFQQ1lDgNknxrvQ4TiTLZj2Wu3B69yYmEEOuK+z6Wys/yNTPDJPIzJcHojzAwX
         l2BA==
X-Gm-Message-State: AOAM533MMB+q+f0E4WsSqCAmH6nC0scLY4zCkj3uuYGgrYSoVKXe9RKG
        X8MivBZt04oUuhV9FdkAnNVJ99hnRmghBeFrNAFgGUhjplRZW2GzqT2HSTIs+lFWnzJmcWrH36J
        FfEYBb2QIekXCmN6+IViN
X-Received: by 2002:adf:db42:: with SMTP id f2mr11191480wrj.5.1621625832004;
        Fri, 21 May 2021 12:37:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3HfDJ+Myl8DK5jwFpKZQMElYR3LkrRBKtdRai0WCVmyZONtDS/OcsNp1IUI4McOUzKgde9w==
X-Received: by 2002:adf:db42:: with SMTP id f2mr11191460wrj.5.1621625831732;
        Fri, 21 May 2021 12:37:11 -0700 (PDT)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id s11sm475226wmf.14.2021.05.21.12.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 12:37:11 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH 2/2] drivers/firmware: consolidate EFI framebuffer setup for all arches
Date:   Fri, 21 May 2021 21:37:04 +0200
Message-Id: <20210521193704.3042024-1-javierm@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The register_gop_device() function registers an "efi-framebuffer" platform
device to match against the efifb driver, to have an early framebuffer for
EFI platforms.

But the Generic System Framebuffers (sysfb) already has support for this.

Instead of having duplicated logic for x86 and other architectures using
EFI, consolidate the two in sysfb and remove it from the EFI init logic.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 arch/arm/Kconfig                  |  1 +
 arch/arm/include/asm/efi.h        |  5 +-
 arch/arm64/Kconfig                |  1 +
 arch/arm64/include/asm/efi.h      |  5 +-
 arch/riscv/Kconfig                |  1 +
 arch/riscv/include/asm/efi.h      |  5 +-
 drivers/firmware/Kconfig          |  7 ++-
 drivers/firmware/Makefile         |  2 +-
 drivers/firmware/efi/efi-init.c   | 90 -------------------------------
 drivers/firmware/efi/sysfb_efi.c  | 77 +++++++++++++++++++++++++-
 drivers/firmware/sysfb.c          | 40 +++++++++-----
 drivers/firmware/sysfb_simplefb.c | 29 ++++++----
 include/linux/sysfb.h             | 28 +++++-----
 13 files changed, 145 insertions(+), 146 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 24804f11302..30ba195ca72 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -127,6 +127,7 @@ config ARM
 	select PERF_USE_VMALLOC
 	select RTC_LIB
 	select SET_FS
+	select SYSFB
 	select SYS_SUPPORTS_APM_EMULATION
 	# Above selects are sorted alphabetically; please add new ones
 	# according to that.  Thanks.
diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
index 9de7ab2ce05..a6f3b179e8a 100644
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
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9f1d8566bbf..20886eb48ab 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1884,6 +1884,7 @@ config EFI
 	select EFI_RUNTIME_WRAPPERS
 	select EFI_STUB
 	select EFI_GENERIC_STUB
+	select SYSFB
 	imply IMA_SECURE_AND_OR_TRUSTED_BOOT
 	default y
 	help
diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 3578aba9c60..42d673a011c 100644
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
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a8ad8eb7612..f4bc6736c4e 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -474,6 +474,7 @@ config EFI
 	select EFI_GENERIC_STUB
 	select EFI_RUNTIME_WRAPPERS
 	select RISCV_ISA_C
+	select SYSFB
 	depends on MMU
 	default y
 	help
diff --git a/arch/riscv/include/asm/efi.h b/arch/riscv/include/asm/efi.h
index 6d98cd99968..7a8f0d45b13 100644
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
index 396bd1d5cbf..cc1a61f6d57 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -253,9 +253,8 @@ config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
 
 config SYSFB
 	bool
-	depends on X86
 
-config X86_SYSFB
+config SYSFB_SIMPLEFB
 	bool "Mark VGA/VBE/EFI FB as generic system framebuffer"
 	depends on SYSFB
 	help
@@ -263,10 +262,10 @@ config X86_SYSFB
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
index ad78f78ffa8..6ac637e422b 100644
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
index a552a08a174..b19ce1a83f9 100644
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
index 9f035b15501..2814af6baf1 100644
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
@@ -281,4 +348,10 @@ __init void sysfb_apply_efi_quirks(void)
 		screen_info.lfb_height = temp;
 		screen_info.lfb_linelength = 4 * screen_info.lfb_width;
 	}
+
+	if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI &&
+	    IS_ENABLED(CONFIG_PCI)) {
+		fwnode_init(&efifb_fwnode, &efifb_fwnode_ops);
+		pd->dev.fwnode = &efifb_fwnode;
+	}
 }
diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
index 1337515963d..3ecd60a0215 100644
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
 
@@ -39,31 +39,43 @@ static __init int sysfb_init(void)
 	struct screen_info *si = &screen_info;
 	struct simplefb_platform_data mode;
 	struct platform_device *pd;
-	const char *name;
 	bool compatible;
 	int ret;
 
-	sysfb_apply_efi_quirks();
+	pd = platform_device_alloc("", 0);
+	if (!pd)
+		return -ENOMEM;
+
+	sysfb_apply_efi_quirks(pd);
 
 	/* try to create a simple-framebuffer device */
-	compatible = parse_mode(si, &mode);
+	compatible = sysfb_parse_mode(si, &mode);
 	if (compatible) {
-		ret = create_simplefb(si, &mode);
+		ret = sysfb_create_simplefb(si, &mode, pd);
 		if (!ret)
 			return 0;
 	}
 
 	/* if the FB is incompatible, create a legacy framebuffer device */
 	if (si->orig_video_isVGA == VIDEO_TYPE_EFI)
-		name = "efi-framebuffer";
+		pd->name = "efi-framebuffer";
 	else if (si->orig_video_isVGA == VIDEO_TYPE_VLFB)
-		name = "vesa-framebuffer";
+		pd->name = "vesa-framebuffer";
 	else
-		name = "platform-framebuffer";
+		pd->name = "platform-framebuffer";
+
+	ret = platform_device_add_data(pd, si, sizeof(*si));
+	if (ret)
+		goto err;
+
+	ret = platform_device_add(pd);
+	if (ret)
+		goto err;
 
-	pd = platform_device_register_resndata(NULL, name, 0,
-					       NULL, 0, si, sizeof(*si));
-	return PTR_ERR_OR_ZERO(pd);
+	return 0;
+err:
+	platform_device_put(pd);
+	return ret;
 }
 
 /* must execute after PCI subsystem for EFI quirks */
diff --git a/drivers/firmware/sysfb_simplefb.c b/drivers/firmware/sysfb_simplefb.c
index df892444ea1..cffff4283f3 100644
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
+				 const struct simplefb_platform_data *mode,
+				 struct platform_device *pd)
 {
-	struct platform_device *pd;
 	struct resource res;
 	u64 base, size;
 	u32 length;
+	int ret;
 
 	/*
 	 * If the 64BIT_BASE capability is set, ext_lfb_base will contain the
@@ -105,7 +106,15 @@ __init int create_simplefb(const struct screen_info *si,
 	if (res.end <= res.start)
 		return -EINVAL;
 
-	pd = platform_device_register_resndata(NULL, "simple-framebuffer", 0,
-					       &res, 1, mode, sizeof(*mode));
-	return PTR_ERR_OR_ZERO(pd);
+	pd->name = "simple-framebuffer";
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
diff --git a/include/linux/sysfb.h b/include/linux/sysfb.h
index 3e5355769dc..d97162f4b97 100644
--- a/include/linux/sysfb.h
+++ b/include/linux/sysfb.h
@@ -58,37 +58,39 @@ struct efifb_dmi_info {
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
+			  const struct simplefb_platform_data *mode,
+			  struct platform_device *pd);
 
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
+					 const struct simplefb_platform_data *mode,
+					 struct platform_device *pd)
 {
 	return -EINVAL;
 }
 
-#endif /* CONFIG_X86_SYSFB */
+#endif /* CONFIG_SYSFB_SIMPLE */
 
 #endif /* _LINUX_SYSFB_H */
-- 
2.31.1

