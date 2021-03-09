Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF39E331B48
	for <lists+linux-efi@lfdr.de>; Tue,  9 Mar 2021 01:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbhCIADM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 8 Mar 2021 19:03:12 -0500
Received: from rcdn-iport-4.cisco.com ([173.37.86.75]:14880 "EHLO
        rcdn-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbhCIADG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 8 Mar 2021 19:03:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=4760; q=dns/txt; s=iport;
  t=1615248185; x=1616457785;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tQ2KjkNmJ1N6aeJwFCAC+GVVOXowsaBAtY9t5Zi/wUA=;
  b=FpTIOXrHD+a0Dp7e01vzytK9EKfE0rLIzCHYMuqsAljdo+EAfb1wUn2K
   mA0q1cFc7PBZv2oOKyboG6FFd1PxlvC/s8rY9KYnAS5p0iyZIvAti/IYM
   /sUFBgNelkb2nk8o4X/EJqYIvC5KeT7mRh5ATh1IKLQhTf7iaRlStcL2A
   w=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0BIAwAiukZg/4cNJK1iHAEBAQEBAQc?=
 =?us-ascii?q?BARIBAQQEAQGCD4IrgUwBOTGWG4opkicLAQEBDzQEAQGETYF8AiU4EwIDAQE?=
 =?us-ascii?q?LAQEFAQEBAgEGBHGFboZ9ATgOgQI8ARKCcIJWAy+sJIIoiBsNYoFFFIEliFx?=
 =?us-ascii?q?0hBgcgUlCgRGDWIIaiBkEgkYBdRkBCiUBgVSBG5AlBgSCbYozgR2aCluDCIE?=
 =?us-ascii?q?flVuFHQ8io2yUXY5HlA6BayOBVzMaCBsVgyRQGQ2OKxaNagFcIAMvOAIGCgE?=
 =?us-ascii?q?BAwmPJgEB?=
X-IronPort-AV: E=Sophos;i="5.81,233,1610409600"; 
   d="scan'208";a="846417833"
Received: from alln-core-2.cisco.com ([173.36.13.135])
  by rcdn-iport-4.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 09 Mar 2021 00:03:03 +0000
Received: from zorba.cisco.com ([10.24.7.91])
        by alln-core-2.cisco.com (8.15.2/8.15.2) with ESMTP id 12902mKh014497;
        Tue, 9 Mar 2021 00:03:01 GMT
From:   Daniel Walker <danielwa@cisco.com>
To:     Will Deacon <will@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rob Herring <robh@kernel.org>,
        Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        xe-linux-external@cisco.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Ruslan Ruslichenko <rruslich@cisco.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Subject: [PATCH v2 7/7] CMDLINE: x86: convert to generic builtin command line
Date:   Mon,  8 Mar 2021 16:02:43 -0800
Message-Id: <20210309000247.2989531-8-danielwa@cisco.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.24.7.91, [10.24.7.91]
X-Outbound-Node: alln-core-2.cisco.com
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This updates the x86 code to use the CONFIG_GENERIC_CMDLINE
option.

Cc: xe-linux-external@cisco.com
Signed-off-by: Ruslan Ruslichenko <rruslich@cisco.com>
Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Signed-off-by: Daniel Walker <danielwa@cisco.com>
---
 arch/x86/Kconfig                        | 44 +------------------------
 arch/x86/kernel/setup.c                 | 18 ++--------
 drivers/firmware/efi/libstub/x86-stub.c |  2 +-
 3 files changed, 4 insertions(+), 60 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 21f851179ff0..3950f9bf9855 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -115,6 +115,7 @@ config X86
 	select EDAC_SUPPORT
 	select GENERIC_CLOCKEVENTS_BROADCAST	if X86_64 || (X86_32 && X86_LOCAL_APIC)
 	select GENERIC_CLOCKEVENTS_MIN_ADJUST
+	select GENERIC_CMDLINE
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_CPU_VULNERABILITIES
@@ -2368,49 +2369,6 @@ choice
 
 endchoice
 
-config CMDLINE_BOOL
-	bool "Built-in kernel command line"
-	help
-	  Allow for specifying boot arguments to the kernel at
-	  build time.  On some systems (e.g. embedded ones), it is
-	  necessary or convenient to provide some or all of the
-	  kernel boot arguments with the kernel itself (that is,
-	  to not rely on the boot loader to provide them.)
-
-	  To compile command line arguments into the kernel,
-	  set this option to 'Y', then fill in the
-	  boot arguments in CONFIG_CMDLINE.
-
-	  Systems with fully functional boot loaders (i.e. non-embedded)
-	  should leave this option set to 'N'.
-
-config CMDLINE
-	string "Built-in kernel command string"
-	depends on CMDLINE_BOOL
-	default ""
-	help
-	  Enter arguments here that should be compiled into the kernel
-	  image and used at boot time.  If the boot loader provides a
-	  command line at boot time, it is appended to this string to
-	  form the full kernel command line, when the system boots.
-
-	  However, you can use the CONFIG_CMDLINE_OVERRIDE option to
-	  change this behavior.
-
-	  In most cases, the command line (whether built-in or provided
-	  by the boot loader) should specify the device for the root
-	  file system.
-
-config CMDLINE_OVERRIDE
-	bool "Built-in command line overrides boot loader arguments"
-	depends on CMDLINE_BOOL && CMDLINE != ""
-	help
-	  Set this option to 'Y' to have the kernel ignore the boot loader
-	  command line, and use ONLY the built-in command line.
-
-	  This is used to work around broken boot loaders.  This should
-	  be set to 'N' under normal conditions.
-
 config MODIFY_LDT_SYSCALL
 	bool "Enable the LDT (local descriptor table)" if EXPERT
 	default y
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 740f3bdb3f61..e748c3e5c1ae 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -48,6 +48,7 @@
 #include <asm/unwind.h>
 #include <asm/vsyscall.h>
 #include <linux/vmalloc.h>
+#include <linux/cmdline.h>
 
 /*
  * max_low_pfn_mapped: highest directly mapped pfn < 4 GB
@@ -162,9 +163,6 @@ unsigned long saved_video_mode;
 #define RAMDISK_LOAD_FLAG		0x4000
 
 static char __initdata command_line[COMMAND_LINE_SIZE];
-#ifdef CONFIG_CMDLINE_BOOL
-static char __initdata builtin_cmdline[COMMAND_LINE_SIZE] = CONFIG_CMDLINE;
-#endif
 
 #if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
 struct edd edd;
@@ -884,19 +882,7 @@ void __init setup_arch(char **cmdline_p)
 	bss_resource.start = __pa_symbol(__bss_start);
 	bss_resource.end = __pa_symbol(__bss_stop)-1;
 
-#ifdef CONFIG_CMDLINE_BOOL
-#ifdef CONFIG_CMDLINE_OVERRIDE
-	strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
-#else
-	if (builtin_cmdline[0]) {
-		/* append boot loader cmdline to builtin */
-		strlcat(builtin_cmdline, " ", COMMAND_LINE_SIZE);
-		strlcat(builtin_cmdline, boot_command_line, COMMAND_LINE_SIZE);
-		strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
-	}
-#endif
-#endif
-
+	cmdline_add_builtin(boot_command_line, NULL, COMMAND_LINE_SIZE);
 	strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
 	*cmdline_p = command_line;
 
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index f14c4ff5839f..9538c9d4a0bc 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -736,7 +736,7 @@ unsigned long efi_main(efi_handle_t handle,
 	}
 
 #ifdef CONFIG_CMDLINE_BOOL
-	status = efi_parse_options(CONFIG_CMDLINE);
+	status = efi_parse_options(CONFIG_CMDLINE_PREPEND " " CONFIG_CMDLINE_APPEND);
 	if (status != EFI_SUCCESS) {
 		efi_err("Failed to parse options\n");
 		goto fail;
-- 
2.25.1

