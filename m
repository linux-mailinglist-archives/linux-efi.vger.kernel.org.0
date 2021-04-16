Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6D7361897
	for <lists+linux-efi@lfdr.de>; Fri, 16 Apr 2021 06:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238478AbhDPEKN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Apr 2021 00:10:13 -0400
Received: from rcdn-iport-2.cisco.com ([173.37.86.73]:51651 "EHLO
        rcdn-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237255AbhDPEKI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 16 Apr 2021 00:10:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=6345; q=dns/txt; s=iport;
  t=1618546184; x=1619755784;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T0dqf2G5BwtvYRMNblg5cdJ5G97sKXyBbLO+A5ot9gQ=;
  b=mZiUAbMQdPMs3Swk5M3k0eO++KbtBYv1PuiQrf6EOjIwuOwFn8yOn1aP
   rdWE1ij83j4719opjXqbzPRQ2jGBQhMdaqv1g8X3IO0mS8vY8O8P0Vmyv
   csfhdmsfrUlD4RZgnIeVqbsbvC1mVg0GX7XQByKdeZKwbd0J0HcLmOX5F
   A=;
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AHWICPaoLSHeSlS+2WqACRv0aV5t2L9V00z?=
 =?us-ascii?q?AX/kB9WHVpW+aT/vrDoN0w0xjohDENHEw6kdebN6WaBV/a/5h54Y4eVI3SOD?=
 =?us-ascii?q?XOlWO0IOhZg7fK7CbnH0TFnNJ19aAlSKRmDc21MF4St7eY3CCdM/INhOaK67?=
 =?us-ascii?q?qpg+C29QYJcShPZ7t75wl0TiaXe3cWeCB8CZA0FIWR66N8zlLKRV0tYsu2HX?=
 =?us-ascii?q?UDVeTYzue79q7OWwIMBBIs9WC14g+A1biSKXWl9yZbey9Tx/MY/XLdlQvi6u?=
 =?us-ascii?q?GYr+ij0RPHzQbonvNrseqk7tNCAcCW4/J0FhzcziC1eY9mR7qO+Bcyre3H0i?=
 =?us-ascii?q?dSrPD85zE9Is9093TdOluQnCKo8Qzh3DEygkWSr2OlvQ=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AYAACIDXlg/4sNJK1aGwEBAQEBAQE?=
 =?us-ascii?q?BBQEBARIBAQEDAwEBAYF+BgEBAQsBAYIpgU0BOTGMZ4lOmm6BfAsBAQEPNAQ?=
 =?us-ascii?q?BAYRQAoFzAiU0CQ4CAwEBDAEBBQEBAQIBBgRxE4VdQxYBhWsGJwsBRhBRVwY?=
 =?us-ascii?q?BEoJxgwisB4F4M4EBiDOBRBSBJQGHW4EQdAaDbyccgUlChHOKOQSCRz1SSwK?=
 =?us-ascii?q?CUpA7FAaNV4EgmXmBFIMWgSaYZoJrDyOkfJUYnldghCuBVDqBWTMaCBsVgyR?=
 =?us-ascii?q?QGQ6OKxaNawFbIQMvOAIGCgEBAwmJToNAAQE?=
X-IronPort-AV: E=Sophos;i="5.82,226,1613433600"; 
   d="scan'208";a="888361936"
Received: from alln-core-6.cisco.com ([173.36.13.139])
  by rcdn-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 16 Apr 2021 04:09:37 +0000
Received: from zorba.cisco.com ([10.24.7.67])
        by alln-core-6.cisco.com (8.15.2/8.15.2) with ESMTP id 13G49OHk016753;
        Fri, 16 Apr 2021 04:09:36 GMT
From:   Daniel Walker <danielwa@cisco.com>
To:     Will Deacon <will@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rob Herring <robh@kernel.org>,
        Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     xe-linux-external@cisco.com, Ard Biesheuvel <ardb@kernel.org>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] drivers: firmware: efi: libstub: enable generic commandline
Date:   Thu, 15 Apr 2021 21:09:16 -0700
Message-Id: <20210416040924.2882771-6-danielwa@cisco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210416040924.2882771-1-danielwa@cisco.com>
References: <20210416040924.2882771-1-danielwa@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.24.7.67, [10.24.7.67]
X-Outbound-Node: alln-core-6.cisco.com
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This adds code to handle the generic command line changes.
The efi code appears that it doesn't benefit as much from this design
as it could.

For example, if you had a prepend command line with "nokaslr" then
you might be helpful to re-enable it in the boot loader or dts,
but there appears to be no way to re-enable kaslr or some of the
other options.

The efi command line handling is incorrect. x86 and arm have an append
system however the efi code prepends the command line.

For example, you could have a non-upgradable bios which sends

efi=disable_early_pci_dma

This hypothetically could have been set because early pci dma caused
issues on early versions of the product.

Then later the early pci dma was made to work and the company desired
to start using it. To override the bios you could set the CONFIG_CMDLINE
to,

efi=no_disable_early_pci_dma

then parsing would normally start with the bios command line, then move
to the CONFIG_CMDLINE and you would end up with early pci dma turned on.

however, current efi code keeps early pci dma off because the bios
arguments always override the built in.

Per my reading this is different from the main body of x86, arm, and
arm64.

The generic command line provides both append and prepend, so it
alleviates this issue if it's used. However not all architectures use
it.

It would be desirable to allow the efi stub to have it's builtin command
line to be modified after compile, but I don't see a feasible way to do
that currently.

Cc: xe-linux-external@cisco.com
Signed-off-by: Daniel Walker <danielwa@cisco.com>
---
 .../firmware/efi/libstub/efi-stub-helper.c    | 29 +++++++++++++++++++
 drivers/firmware/efi/libstub/efi-stub.c       |  9 ++++++
 drivers/firmware/efi/libstub/efistub.h        |  1 +
 drivers/firmware/efi/libstub/x86-stub.c       | 13 +++++++--
 4 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index aa8da0a49829..16318f55f187 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -13,6 +13,7 @@
 #include <linux/efi.h>
 #include <linux/kernel.h>
 #include <linux/printk.h> /* For CONSOLE_LOGLEVEL_* */
+#include <linux/cmdline.h>
 #include <asm/efi.h>
 #include <asm/setup.h>
 
@@ -172,6 +173,34 @@ int efi_printk(const char *fmt, ...)
 	return printed;
 }
 
+/**
+ * efi_handle_cmdline() - handle adding in building parts of the command line
+ * @cmdline:	kernel command line
+ *
+ * Add in the generic parts of the commandline and start the parsing of the
+ * command line.
+ *
+ * Return:	status code
+ */
+efi_status_t efi_handle_cmdline(char const *cmdline)
+{
+	efi_status_t status = EFI_SUCCESS;
+
+	if (sizeof(CMDLINE_STATIC_PREPEND) > 1)
+		status |= efi_parse_options(CMDLINE_STATIC_PREPEND);
+
+	if (!IS_ENABLED(CONFIG_CMDLINE_OVERRIDE))
+		status |= efi_parse_options(cmdline);
+
+	if (sizeof(CMDLINE_STATIC_APPEND) > 1)
+		status |= efi_parse_options(CMDLINE_STATIC_APPEND);
+
+	if (status != EFI_SUCCESS)
+		efi_err("Failed to parse options\n");
+
+	return status;
+}
+
 /**
  * efi_parse_options() - Parse EFI command line options
  * @cmdline:	kernel command line
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 26e69788f27a..baa69b24cfdd 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -172,6 +172,14 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 		goto fail;
 	}
 
+#ifdef CONFIG_GENERIC_CMDLINE
+	status = efi_handle_cmdline(cmdline_ptr);
+	if (status != EFI_SUCCESS) {
+		goto fail_free_cmdline;
+	}
+#endif
+
+#ifdef CONFIG_CMDLINE
 	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) ||
 	    IS_ENABLED(CONFIG_CMDLINE_FORCE) ||
 	    cmdline_size == 0) {
@@ -189,6 +197,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 			goto fail_free_cmdline;
 		}
 	}
+#endif
 
 	efi_info("Booting Linux Kernel...\n");
 
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index cde0a2ef507d..07c7f9fdfffc 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -800,6 +800,7 @@ efi_status_t efi_relocate_kernel(unsigned long *image_addr,
 				 unsigned long alignment,
 				 unsigned long min_addr);
 
+efi_status_t efi_handle_cmdline(char const *cmdline);
 efi_status_t efi_parse_options(char const *cmdline);
 
 void efi_parse_option_graphics(char *option);
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index f14c4ff5839f..30ad8fb7122d 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -673,6 +673,8 @@ unsigned long efi_main(efi_handle_t handle,
 	unsigned long bzimage_addr = (unsigned long)startup_32;
 	unsigned long buffer_start, buffer_end;
 	struct setup_header *hdr = &boot_params->hdr;
+	unsigned long cmdline_paddr = ((u64)hdr->cmd_line_ptr |
+				       ((u64)boot_params->ext_cmd_line_ptr << 32));
 	efi_status_t status;
 
 	efi_system_table = sys_table_arg;
@@ -735,6 +737,14 @@ unsigned long efi_main(efi_handle_t handle,
 		image_offset = 0;
 	}
 
+#ifdef CONFIG_GENERIC_CMDLINE
+	status = efi_handle_cmdline((char *)cmdline_paddr);
+	if (status != EFI_SUCCESS) {
+		efi_err("Failed to parse options\n");
+		goto fail;
+	}
+#else /* CONFIG_GENERIC_CMDLINE */
+
 #ifdef CONFIG_CMDLINE_BOOL
 	status = efi_parse_options(CONFIG_CMDLINE);
 	if (status != EFI_SUCCESS) {
@@ -743,8 +753,6 @@ unsigned long efi_main(efi_handle_t handle,
 	}
 #endif
 	if (!IS_ENABLED(CONFIG_CMDLINE_OVERRIDE)) {
-		unsigned long cmdline_paddr = ((u64)hdr->cmd_line_ptr |
-					       ((u64)boot_params->ext_cmd_line_ptr << 32));
 		status = efi_parse_options((char *)cmdline_paddr);
 		if (status != EFI_SUCCESS) {
 			efi_err("Failed to parse options\n");
@@ -752,6 +760,7 @@ unsigned long efi_main(efi_handle_t handle,
 		}
 	}
 
+#endif
 	/*
 	 * At this point, an initrd may already have been loaded by the
 	 * bootloader and passed via bootparams. We permit an initrd loaded
-- 
2.25.1

