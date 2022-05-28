Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A15536C2C
	for <lists+linux-efi@lfdr.de>; Sat, 28 May 2022 11:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbiE1Jzw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 28 May 2022 05:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbiE1Jzv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 28 May 2022 05:55:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CE01FCEA
        for <linux-efi@vger.kernel.org>; Sat, 28 May 2022 02:55:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FD7060D58
        for <linux-efi@vger.kernel.org>; Sat, 28 May 2022 09:55:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7233EC34118;
        Sat, 28 May 2022 09:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653731749;
        bh=s+BwhgJtchJjlJBVdbusGgRMhzVsaXuZAgQq4Pu9xjs=;
        h=From:To:Cc:Subject:Date:From;
        b=LD70pVW2NiM3TCi6ksCQmGmUc5oV674WaC71fZgBbPSPJ82UM1YEvOA1HeYIqGFw3
         8GorettvbKdJ7tfElSTFjsUbpAXyy8Cf5MHsTFfvNSbZU1E0idLm63lbQnPqL8EZ4I
         glzQjzpV+wUaTTSnbtxke/kHRiIljrq9gG6m8fBebKY9p3Cw/AwLV0zMTAxNBqOd/i
         V27pgV0ONKlSAqW1bwPKe/YBlOiNd3o49OXcv0/hriET/OKsHhz3WX+YD7OYI4Moz0
         YPvUD6EgQuehwBF+otcZ/+BGZpEW3yTTMqEx/917Pz87Tlewg/BcI7aDYFksG2WW5B
         8DEgR2q7y8Ehw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] efi: clean up Kconfig dependencies on CONFIG_EFI
Date:   Sat, 28 May 2022 11:55:40 +0200
Message-Id: <20220528095540.2002868-1-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3626; h=from:subject; bh=s+BwhgJtchJjlJBVdbusGgRMhzVsaXuZAgQq4Pu9xjs=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBikfGcKh5N6oQiPwt54xY5gvzxbOjBOCoMkcqGL+Ap 8oZACDuJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYpHxnAAKCRDDTyI5ktmPJEJZC/ 47pLHAG+4brE+gZJDmhUIkg1TAemRrn3d4WKrTmr6SghOlUYi0V9CF8/wv5OctcvXGSTGdXQFtQk7+ chXzZkJIJ5ufs3KmpmdF24T7SQHAXFMnjgpFf89o/j9bmL1ShiWoPaYTjCl0RjMznF0S750/b+JcD+ ZbRkjt9Kdzu2z1nV0nV64XoWnxxKlt0/ukA2Pkk52nFv2/qC9N+Oe+bG90Oi9AhK9I43rl2BCSmGJt /mlXirJrggXa7Yl6fGbF9HIQ0ALEGjXwl5A1sa3lDF4AJNxGTns6YQ8uc/fCkhJ9k/mUycDwXZ9F/a 1cHq4JjdXos/9f3vpWSAjPNO2TyPZRF/4AgYoemLnxqlJzMvaN3oaanlpOdk460WQpg6fNmM9BMQyf rBBs0dxPvR4qViE+4tRpVGNnzIBuKlMcTFFjEo/VQhP+33byqMGpiDVysPf2J6oZg45sXraBQQK3lO BMpyxumDNL6ehuKl5sB0PViko93Z92BMO7wJ4kM0ZBhxQ=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Geert reports that the new option CONFIG_EFI_DISABLE_RUNTIME is user
visible even when EFI support is disabled, which is unnecessary and
clutters the Kconfig interface.

So let's move this option into the existing Kconfig submenu that already
depends on CONFIG_EFI, and while at it, give some other options the same
treatment.

Also clean up a small wart where the efi/ subdirectory is listed twice.
Let's just list it unconditionally so that both EFI and UEFI_CPER based
pieces will be built independently (the latter only depends on the
former on !X86)

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/Makefile    |  3 +-
 drivers/firmware/efi/Kconfig | 52 +++++++++-----------
 2 files changed, 25 insertions(+), 30 deletions(-)

diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 4e58cb474a68..dca73826e09a 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -31,8 +31,7 @@ obj-y				+= broadcom/
 obj-y				+= cirrus/
 obj-y				+= meson/
 obj-$(CONFIG_GOOGLE_FIRMWARE)	+= google/
-obj-$(CONFIG_EFI)		+= efi/
-obj-$(CONFIG_UEFI_CPER)		+= efi/
+obj-y				+= efi/
 obj-y				+= imx/
 obj-y				+= psci/
 obj-y				+= smccc/
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 4720ba98cec3..7aa4717cdcac 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -193,6 +193,9 @@ config EFI_TEST
 	  Say Y here to enable the runtime services support via /dev/efi_test.
 	  If unsure, say N.
 
+config EFI_DEV_PATH_PARSER
+	bool
+
 config APPLE_PROPERTIES
 	bool "Apple Device Properties"
 	depends on EFI_STUB && X86
@@ -255,40 +258,15 @@ config EFI_DISABLE_PCI_DMA
 	  options "efi=disable_early_pci_dma" or "efi=no_disable_early_pci_dma"
 	  may be used to override this option.
 
-endmenu
-
-config EFI_EMBEDDED_FIRMWARE
-	bool
-	depends on EFI
-	select CRYPTO_LIB_SHA256
-
-config UEFI_CPER
-	bool
-
-config UEFI_CPER_ARM
-	bool
-	depends on UEFI_CPER && ( ARM || ARM64 )
-	default y
-
-config UEFI_CPER_X86
-	bool
-	depends on UEFI_CPER && X86
-	default y
-
-config EFI_DEV_PATH_PARSER
-	bool
-	depends on ACPI
-	default n
-
 config EFI_EARLYCON
 	def_bool y
-	depends on EFI && SERIAL_EARLYCON && !ARM && !IA64
+	depends on SERIAL_EARLYCON && !ARM && !IA64
 	select FONT_SUPPORT
 	select ARCH_USE_MEMREMAP_PROT
 
 config EFI_CUSTOM_SSDT_OVERLAYS
 	bool "Load custom ACPI SSDT overlay from an EFI variable"
-	depends on EFI && ACPI
+	depends on ACPI
 	default ACPI_TABLE_UPGRADE
 	help
 	  Allow loading of an ACPI SSDT overlay from an EFI variable specified
@@ -314,7 +292,6 @@ config EFI_DISABLE_RUNTIME
 
 config EFI_COCO_SECRET
 	bool "EFI Confidential Computing Secret Area Support"
-	depends on EFI
 	help
 	  Confidential Computing platforms (such as AMD SEV) allow the
 	  Guest Owner to securely inject secrets during guest VM launch.
@@ -327,3 +304,22 @@ config EFI_COCO_SECRET
 	  for usage inside the kernel.  This will allow the
 	  virt/coco/efi_secret module to access the secrets, which in turn
 	  allows userspace programs to access the injected secrets.
+
+config EFI_EMBEDDED_FIRMWARE
+	bool
+	select CRYPTO_LIB_SHA256
+
+endmenu
+
+config UEFI_CPER
+	bool
+
+config UEFI_CPER_ARM
+	bool
+	depends on UEFI_CPER && ( ARM || ARM64 )
+	default y
+
+config UEFI_CPER_X86
+	bool
+	depends on UEFI_CPER && X86
+	default y
-- 
2.30.2

