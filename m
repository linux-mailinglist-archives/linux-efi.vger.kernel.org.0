Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C835EEBCC
	for <lists+linux-efi@lfdr.de>; Thu, 29 Sep 2022 04:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbiI2Cdj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 28 Sep 2022 22:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234606AbiI2CdT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 28 Sep 2022 22:33:19 -0400
Received: from rcdn-iport-4.cisco.com (rcdn-iport-4.cisco.com [173.37.86.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC031251AC;
        Wed, 28 Sep 2022 19:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=6315; q=dns/txt; s=iport;
  t=1664418796; x=1665628396;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dDhqyaDJ+MXMe2acHtMHzWXvHbaqQ8HyZ9ES4pfw6CY=;
  b=GAqu0pmeC3HLRiV4BnrHZ7jea4uCtP6bY7rh5M9kGDHi5lVVXWOwlpdx
   c1xMdyS+/J9DvIoW5ddnmcXFR10neo4uRZO0qpDA2oGF9Sr7lsbLP2V1c
   D6DRWppTuYflM+4K463liCpHIuZPGxtC05+V8faq1i8zVzDQIjTVcEXU7
   o=;
IronPort-Data: =?us-ascii?q?A9a23=3AEfh1Lq11zbdvY4hbE/bD5bpwkn2cJEfYwER7X?=
 =?us-ascii?q?KvMYLTBsI5bp2MHyWBMWTqGOvvbZWf8eNh1Pou29UkC7cPVmoVhTwI/3Hw8F?=
 =?us-ascii?q?HgiRegpqji6wuYcB84ZRyH6ZBoPA/42N5+RdajYcleG/k33auW48yElvU21b?=
 =?us-ascii?q?uOU5NDsa3gZqTBMEE/NuTo78wIIqtYAbeqRWmthivuqyyHrA2JJ7hYvWo4iB?=
 =?us-ascii?q?w1vnzs01Bj6kGtwUlXT/pmntneG/5UeJMp3ya1csxLFrodo8u6SH44vzZmj9?=
 =?us-ascii?q?W/fuhwqEN7gwvDwc1YBRfjZOg3mZnh+Avf5xEMd4H1plP9naJLwam8P49mNt?=
 =?us-ascii?q?9x4ztRAsYO5YQwoJabL3u8aVnG0FgknZfAdoO+deiLv2SCU5wicG5f2+N1qD?=
 =?us-ascii?q?UcrLcgb9/xxDGVm6/MVMnYOYwqFiubwx6i0IsFoh8I+PIzmMoI3pH5t13faA?=
 =?us-ascii?q?OwgTJSFRL/FjfdRxjs6rsNDB/DTY4weczUHRA/NahsJM1EbBYglm+GAnXT0d?=
 =?us-ascii?q?HtTr1f9jaM0+237yA13zaioPt3IfNCDWcRSmACfvG2u12jwBBAXMPSQyD+d/?=
 =?us-ascii?q?3ahmO7EnWXgUYRXGqex8PVrm1aUgGcaTgANPXOhpvO5ok2zQdRSLwoT4CVGh?=
 =?us-ascii?q?aMy7k2wUt7lXxD+pHOeuQ80UMFfCeon8EeA18L8/AedAkAHQyRHZdhgs9U5L?=
 =?us-ascii?q?QHGfHfhc8jBHzdjtvieTmiQs+fSpjKpMi9TJmgHDRLohDAtu7HLyLzfRDqWJ?=
 =?us-ascii?q?jq7LJOIsw=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ACEoQ2qEvk2MOKUx1pLqE08eALOsnbusQ8z?=
 =?us-ascii?q?AXPo5KJSC9Ffbo8/xG88506faZslwssTQb6LO90cq7MBbhHOBOgLX5VI3KNG?=
 =?us-ascii?q?LbUSmTXeNfBODZrAEIdReSygd179YGT0EHMr3N5ZwQt7eC3OF+eOxQpuW6zA?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0A5AAAHbIJi/5BdJa1aHQEBAQEJARI?=
 =?us-ascii?q?BBQUBgXsIAQsBgiqBSz1DjG+IapxngXwLAQEBD0IEAQGFAgKFPgIlNAkOAQI?=
 =?us-ascii?q?EAQEBEgEBBQEBAQIBBwSBCROFdYZDBicLAUYQUVcGARKCfYMYq1aBeTKBAYg?=
 =?us-ascii?q?ZgWUUgSgBiB6BJYEIhBQnHIFJRIJRgiyKfwSTc4IrAwkGBwWBPhKBIXEBCAY?=
 =?us-ascii?q?GBwoFMgYCDBgUBAITEk0GDBICEwwKBhYODjQSGQwPAxIDEQEHAgsSCBUsCAM?=
 =?us-ascii?q?CAwgDAgMjCwIDGAkHCgMdCAocEhAUAgQTHwsIAxofLQkCBA4DQwgLCgMRBAM?=
 =?us-ascii?q?TGAsWCBAEBgMJLw0oCwMFDw8BBgMGAgUFAQMgAxQDBScHAyEHCyYNDQQjHQM?=
 =?us-ascii?q?DBSYDAgIbBwICAwIGFwYCAhknMQooDQgECAQYBB4lDgUFAgcxBQQvAh4EBQY?=
 =?us-ascii?q?RCQIWAgYEBQIEBBYCAhIIAggnGwcWNhkBBV0GCwkjFgYsEQUGFgMmUgYiHZd?=
 =?us-ascii?q?iPVJLAoJVkXUVBwIBkCiBL5tLgTCDVoFDmy2DABoxqFeWZiChU2aEToFhPIF?=
 =?us-ascii?q?ZMxoIGxWDI1EZD44sFo1xAVwkMTsCBgsBAQMJkRoBAQ?=
X-IronPort-AV: E=Sophos;i="5.91,230,1647302400"; 
   d="scan'208";a="1053082328"
Received: from rcdn-core-8.cisco.com ([173.37.93.144])
  by rcdn-iport-4.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 29 Sep 2022 02:33:16 +0000
Received: from zorba.cisco.com ([10.25.129.98])
        by rcdn-core-8.cisco.com (8.15.2/8.15.2) with ESMTP id 28T2X1Yu007711;
        Thu, 29 Sep 2022 02:33:15 GMT
From:   Daniel Walker <danielwa@cisco.com>
To:     Will Deacon <will@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rob Herring <robh@kernel.org>,
        Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sean Anderson <sean.anderson@seco.com>
Cc:     xe-linux-external@cisco.com, Ard Biesheuvel <ardb@kernel.org>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] drivers: firmware: efi: libstub: enable generic commandline
Date:   Wed, 28 Sep 2022 19:32:51 -0700
Message-Id: <20220929023301.3344694-6-danielwa@cisco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220929023301.3344694-1-danielwa@cisco.com>
References: <20220929023301.3344694-1-danielwa@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.25.129.98, [10.25.129.98]
X-Outbound-Node: rcdn-core-8.cisco.com
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 3d972061c1b0..372f06ec8c49 100644
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
index f515394cce6e..ea52ebd99ea6 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -173,6 +173,14 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
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
@@ -190,6 +198,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 			goto fail_free_cmdline;
 		}
 	}
+#endif
 
 	efi_info("Booting Linux Kernel...\n");
 
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index b0ae0a454404..44c2e1194378 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -907,6 +907,7 @@ efi_status_t efi_relocate_kernel(unsigned long *image_addr,
 				 unsigned long alignment,
 				 unsigned long min_addr);
 
+efi_status_t efi_handle_cmdline(char const *cmdline);
 efi_status_t efi_parse_options(char const *cmdline);
 
 void efi_parse_option_graphics(char *option);
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 7a7abc8959d2..87196bb9c3bb 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -783,6 +783,8 @@ unsigned long efi_main(efi_handle_t handle,
 	unsigned long buffer_start, buffer_end;
 	struct setup_header *hdr = &boot_params->hdr;
 	unsigned long addr, size;
+	unsigned long cmdline_paddr = ((u64)hdr->cmd_line_ptr |
+				       ((u64)boot_params->ext_cmd_line_ptr << 32));
 	efi_status_t status;
 
 	efi_system_table = sys_table_arg;
@@ -851,6 +853,14 @@ unsigned long efi_main(efi_handle_t handle,
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
@@ -859,8 +869,6 @@ unsigned long efi_main(efi_handle_t handle,
 	}
 #endif
 	if (!IS_ENABLED(CONFIG_CMDLINE_OVERRIDE)) {
-		unsigned long cmdline_paddr = ((u64)hdr->cmd_line_ptr |
-					       ((u64)boot_params->ext_cmd_line_ptr << 32));
 		status = efi_parse_options((char *)cmdline_paddr);
 		if (status != EFI_SUCCESS) {
 			efi_err("Failed to parse options\n");
@@ -868,6 +876,7 @@ unsigned long efi_main(efi_handle_t handle,
 		}
 	}
 
+#endif
 	/*
 	 * At this point, an initrd may already have been loaded by the
 	 * bootloader and passed via bootparams. We permit an initrd loaded
-- 
2.25.1

