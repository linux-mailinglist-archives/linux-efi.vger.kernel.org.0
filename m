Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1E51B7651
	for <lists+linux-efi@lfdr.de>; Fri, 24 Apr 2020 15:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgDXNGr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Apr 2020 09:06:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728078AbgDXNGp (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 24 Apr 2020 09:06:45 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31D6520736;
        Fri, 24 Apr 2020 13:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587733604;
        bh=uyhOYKI0IzZOH9TUInWJb82FnPnnDAnpamniaeKkaqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=awNILsQ3j53oVpeI85iXkBwXSa33CydycX1VdfoY2H6hpo1rpPB/cqHu4LvVXFcHf
         Pm+1rXBV0xL+PZE+gem1EvcIYa7f6GPRy1aKfwJKXmz2ZHtuO5ymM3WcMQE3T8tEqC
         xOardqYGtN2nHtbKtxledQHW2NRmdBiOGC6+YZA0=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH 15/33] efi/gop: Allow specifying mode number on command line
Date:   Fri, 24 Apr 2020 15:05:13 +0200
Message-Id: <20200424130531.30518-16-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200424130531.30518-1-ardb@kernel.org>
References: <20200424130531.30518-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

Add the ability to choose a video mode for the selected gop by using a
command-line argument of the form
	video=efifb:mode=<n>

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://lore.kernel.org/r/20200320020028.1936003-12-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 Documentation/fb/efifb.rst                    |  20 +++-
 .../firmware/efi/libstub/efi-stub-helper.c    |   3 +
 drivers/firmware/efi/libstub/efistub.h        |   2 +
 drivers/firmware/efi/libstub/gop.c            | 107 ++++++++++++++++++
 4 files changed, 129 insertions(+), 3 deletions(-)

diff --git a/Documentation/fb/efifb.rst b/Documentation/fb/efifb.rst
index 04840331a00e..367fbda2f4da 100644
--- a/Documentation/fb/efifb.rst
+++ b/Documentation/fb/efifb.rst
@@ -2,8 +2,10 @@
 What is efifb?
 ==============
 
-This is a generic EFI platform driver for Intel based Apple computers.
-efifb is only for EFI booted Intel Macs.
+This is a generic EFI platform driver for systems with UEFI firmware. The
+system must be booted via the EFI stub for this to be usable. efifb supports
+both firmware with Graphics Output Protocol (GOP) displays as well as older
+systems with only Universal Graphics Adapter (UGA) displays.
 
 Supported Hardware
 ==================
@@ -12,11 +14,14 @@ Supported Hardware
 - Macbook
 - Macbook Pro 15"/17"
 - MacMini
+- ARM/ARM64/X86 systems with UEFI firmware
 
 How to use it?
 ==============
 
-efifb does not have any kind of autodetection of your machine.
+For UGA displays, efifb does not have any kind of autodetection of your
+machine.
+
 You have to add the following kernel parameters in your elilo.conf::
 
 	Macbook :
@@ -28,6 +33,9 @@ You have to add the following kernel parameters in your elilo.conf::
 	Macbook Pro 17", iMac 20" :
 		video=efifb:i20
 
+For GOP displays, efifb can autodetect the display's resolution and framebuffer
+address, so these should work out of the box without any special parameters.
+
 Accepted options:
 
 ======= ===========================================================
@@ -36,4 +44,10 @@ nowc	Don't map the framebuffer write combined. This can be used
 	when large amounts of console data are written.
 ======= ===========================================================
 
+Options for GOP displays:
+
+mode=n
+        The EFI stub will set the mode of the display to mode number n if
+        possible.
+
 Edgar Hucek <gimli@dark-green.com>
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 9f34c7242939..c6092b6038cf 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -105,6 +105,9 @@ efi_status_t efi_parse_options(char const *cmdline)
 				efi_disable_pci_dma = true;
 			if (parse_option_str(val, "no_disable_early_pci_dma"))
 				efi_disable_pci_dma = false;
+		} else if (!strcmp(param, "video") &&
+			   val && strstarts(val, "efifb:")) {
+			efi_parse_option_graphics(val + strlen("efifb:"));
 		}
 	}
 	efi_bs_call(free_pool, buf);
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 321244ed20a4..9af65be3b278 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -666,6 +666,8 @@ efi_status_t efi_relocate_kernel(unsigned long *image_addr,
 
 efi_status_t efi_parse_options(char const *cmdline);
 
+void efi_parse_option_graphics(char *option);
+
 efi_status_t efi_setup_gop(struct screen_info *si, efi_guid_t *proto,
 			   unsigned long size);
 
diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index 2d91699e3061..a32b784b4577 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -8,11 +8,115 @@
 #include <linux/bitops.h>
 #include <linux/efi.h>
 #include <linux/screen_info.h>
+#include <linux/string.h>
 #include <asm/efi.h>
 #include <asm/setup.h>
 
 #include "efistub.h"
 
+enum efi_cmdline_option {
+	EFI_CMDLINE_NONE,
+	EFI_CMDLINE_MODE_NUM,
+};
+
+static struct {
+	enum efi_cmdline_option option;
+	u32 mode;
+} cmdline __efistub_global = { .option = EFI_CMDLINE_NONE };
+
+static bool parse_modenum(char *option, char **next)
+{
+	u32 m;
+
+	if (!strstarts(option, "mode="))
+		return false;
+	option += strlen("mode=");
+	m = simple_strtoull(option, &option, 0);
+	if (*option && *option++ != ',')
+		return false;
+	cmdline.option = EFI_CMDLINE_MODE_NUM;
+	cmdline.mode   = m;
+
+	*next = option;
+	return true;
+}
+
+void efi_parse_option_graphics(char *option)
+{
+	while (*option) {
+		if (parse_modenum(option, &option))
+			continue;
+
+		while (*option && *option++ != ',')
+			;
+	}
+}
+
+static u32 choose_mode_modenum(efi_graphics_output_protocol_t *gop)
+{
+	efi_status_t status;
+
+	efi_graphics_output_protocol_mode_t *mode;
+	efi_graphics_output_mode_info_t *info;
+	unsigned long info_size;
+
+	u32 max_mode, cur_mode;
+	int pf;
+
+	mode = efi_table_attr(gop, mode);
+
+	cur_mode = efi_table_attr(mode, mode);
+	if (cmdline.mode == cur_mode)
+		return cur_mode;
+
+	max_mode = efi_table_attr(mode, max_mode);
+	if (cmdline.mode >= max_mode) {
+		efi_printk("Requested mode is invalid\n");
+		return cur_mode;
+	}
+
+	status = efi_call_proto(gop, query_mode, cmdline.mode,
+				&info_size, &info);
+	if (status != EFI_SUCCESS) {
+		efi_printk("Couldn't get mode information\n");
+		return cur_mode;
+	}
+
+	pf = info->pixel_format;
+
+	efi_bs_call(free_pool, info);
+
+	if (pf == PIXEL_BLT_ONLY || pf >= PIXEL_FORMAT_MAX) {
+		efi_printk("Invalid PixelFormat\n");
+		return cur_mode;
+	}
+
+	return cmdline.mode;
+}
+
+static void set_mode(efi_graphics_output_protocol_t *gop)
+{
+	efi_graphics_output_protocol_mode_t *mode;
+	u32 cur_mode, new_mode;
+
+	switch (cmdline.option) {
+	case EFI_CMDLINE_MODE_NUM:
+		new_mode = choose_mode_modenum(gop);
+		break;
+	default:
+		return;
+	}
+
+	mode = efi_table_attr(gop, mode);
+	cur_mode = efi_table_attr(mode, mode);
+
+	if (new_mode == cur_mode)
+		return;
+
+	if (efi_call_proto(gop, set_mode, new_mode) != EFI_SUCCESS)
+		efi_printk("Failed to set requested mode\n");
+}
+
 static void find_bits(u32 mask, u8 *pos, u8 *size)
 {
 	if (!mask) {
@@ -124,6 +228,9 @@ static efi_status_t setup_gop(struct screen_info *si, efi_guid_t *proto,
 	if (!gop)
 		return EFI_NOT_FOUND;
 
+	/* Change mode if requested */
+	set_mode(gop);
+
 	/* EFI framebuffer */
 	mode = efi_table_attr(gop, mode);
 	info = efi_table_attr(mode, info);
-- 
2.17.1

