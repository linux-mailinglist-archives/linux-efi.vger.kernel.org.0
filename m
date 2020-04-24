Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936591B7634
	for <lists+linux-efi@lfdr.de>; Fri, 24 Apr 2020 15:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgDXNGS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Apr 2020 09:06:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:56544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbgDXNGR (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 24 Apr 2020 09:06:17 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D7F320736;
        Fri, 24 Apr 2020 13:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587733577;
        bh=/SaENcmpX64RmJ+qKH6iETdVCvEB9U8MqVfSzhEvTPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hjNPec/KrHVaqtSvSomqAl53yyRYO2AwRQDDPRyx1Q6PcnRIXysgmdUy0krLrr47x
         vRM0Sb+jjiKE1Zp2G8kSlKC7wMo9bq5E3JPulC6egKAQqjoIa59yguCnstYY8SsTQk
         O2SiIgqV+xiaCofFeuNEwBqJvx/oixATG9ocb1bM=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH 02/33] efi/libstub: Make initrd file loader configurable
Date:   Fri, 24 Apr 2020 15:05:00 +0200
Message-Id: <20200424130531.30518-3-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200424130531.30518-1-ardb@kernel.org>
References: <20200424130531.30518-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Loading an initrd passed via the kernel command line is deprecated: it
is limited to files that reside in the same volume as the one the kernel
itself was loaded from, and we have more flexible ways to achieve the
same. So make it configurable so new architectures can decide not to
enable it.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/Kconfig           | 11 ++++++++
 drivers/firmware/efi/libstub/efistub.h | 38 ++++++++++++++++++++------
 drivers/firmware/efi/libstub/file.c    | 32 +++++-----------------
 3 files changed, 47 insertions(+), 34 deletions(-)

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 2a2b2b96a1dc..4e788dd55b03 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -124,6 +124,17 @@ config EFI_ARMSTUB_DTB_LOADER
 	  functionality for bootloaders that do not have such support
 	  this option is necessary.
 
+config EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER
+	bool "Enable the command line initrd loader"
+	depends on EFI_GENERIC_STUB
+	default y
+	help
+	  Select this config option to add support for the initrd= command
+	  line parameter, allowing an initrd that resides on the same volume
+	  as the kernel image to be loaded into memory.
+
+	  This method is deprecated.
+
 config EFI_BOOTLOADER_CONTROL
 	tristate "EFI Bootloader Control"
 	depends on EFI_VARS
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 67d26949fd26..7517683b31e9 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -651,15 +651,35 @@ efi_status_t efi_parse_options(char const *cmdline);
 efi_status_t efi_setup_gop(struct screen_info *si, efi_guid_t *proto,
 			   unsigned long size);
 
-efi_status_t efi_load_dtb(efi_loaded_image_t *image,
-			  unsigned long *load_addr,
-			  unsigned long *load_size);
-
-efi_status_t efi_load_initrd(efi_loaded_image_t *image,
-			     unsigned long *load_addr,
-			     unsigned long *load_size,
-			     unsigned long soft_limit,
-			     unsigned long hard_limit);
+efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
+				  const efi_char16_t *optstr,
+				  int optstr_size,
+				  unsigned long soft_limit,
+				  unsigned long hard_limit,
+				  unsigned long *load_addr,
+				  unsigned long *load_size);
+
+
+static inline efi_status_t efi_load_dtb(efi_loaded_image_t *image,
+					unsigned long *load_addr,
+					unsigned long *load_size)
+{
+	return handle_cmdline_files(image, L"dtb=", sizeof(L"dtb=") - 2,
+				    ULONG_MAX, ULONG_MAX, load_addr, load_size);
+}
+
+static inline efi_status_t efi_load_initrd(efi_loaded_image_t *image,
+					   unsigned long *load_addr,
+					   unsigned long *load_size,
+					   unsigned long soft_limit,
+					   unsigned long hard_limit)
+{
+	if (!IS_ENABLED(CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER))
+		return EFI_SUCCESS;
+
+	return handle_cmdline_files(image, L"initrd=", sizeof(L"initrd=") - 2,
+				    soft_limit, hard_limit, load_addr, load_size);
+}
 
 efi_status_t efi_load_initrd_dev_path(unsigned long *load_addr,
 				      unsigned long *load_size,
diff --git a/drivers/firmware/efi/libstub/file.c b/drivers/firmware/efi/libstub/file.c
index ea66b1f16a79..27e014ea4459 100644
--- a/drivers/firmware/efi/libstub/file.c
+++ b/drivers/firmware/efi/libstub/file.c
@@ -121,13 +121,13 @@ static int find_file_option(const efi_char16_t *cmdline, int cmdline_len,
  * We only support loading a file from the same filesystem as
  * the kernel image.
  */
-static efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
-					 const efi_char16_t *optstr,
-					 int optstr_size,
-					 unsigned long soft_limit,
-					 unsigned long hard_limit,
-					 unsigned long *load_addr,
-					 unsigned long *load_size)
+efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
+				  const efi_char16_t *optstr,
+				  int optstr_size,
+				  unsigned long soft_limit,
+				  unsigned long hard_limit,
+				  unsigned long *load_addr,
+				  unsigned long *load_size)
 {
 	const efi_char16_t *cmdline = image->load_options;
 	int cmdline_len = image->load_options_size / 2;
@@ -239,21 +239,3 @@ static efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
 	efi_free(alloc_size, alloc_addr);
 	return status;
 }
-
-efi_status_t efi_load_dtb(efi_loaded_image_t *image,
-			  unsigned long *load_addr,
-			  unsigned long *load_size)
-{
-	return handle_cmdline_files(image, L"dtb=", sizeof(L"dtb=") - 2,
-				    ULONG_MAX, ULONG_MAX, load_addr, load_size);
-}
-
-efi_status_t efi_load_initrd(efi_loaded_image_t *image,
-			     unsigned long *load_addr,
-			     unsigned long *load_size,
-			     unsigned long soft_limit,
-			     unsigned long hard_limit)
-{
-	return handle_cmdline_files(image, L"initrd=", sizeof(L"initrd=") - 2,
-				    soft_limit, hard_limit, load_addr, load_size);
-}
-- 
2.17.1

