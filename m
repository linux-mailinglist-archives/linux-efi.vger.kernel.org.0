Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 413F71B4B98
	for <lists+linux-efi@lfdr.de>; Wed, 22 Apr 2020 19:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgDVRYm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 22 Apr 2020 13:24:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:41232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbgDVRYl (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 22 Apr 2020 13:24:41 -0400
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0029F20776;
        Wed, 22 Apr 2020 17:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587576281;
        bh=VEbcVR+7QZ/PYnwd2O1oLeCPzDhFMpwwHDPF8q+T0CI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R07/Fn6kP2LSVbAqdS6J71pMci97ArrszezDwfrjti1NEg9DJ7QLAxwP0BNOow2B5
         flvWqxYghEZZlM4KmGEq0SOPLX5nF0ysKlcrrDE2ZQ3dyHxLRZkQH1vzVxEoWBH0pA
         xo+cmCSlBIyvwa3tq35NApTErz+ndw2oI8/DJhe8=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: [PATCH v5 2/7] efi/libstub: Make initrd file loader configurable
Date:   Wed, 22 Apr 2020 19:24:09 +0200
Message-Id: <20200422172414.6662-3-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200422172414.6662-1-ardb@kernel.org>
References: <20200422172414.6662-1-ardb@kernel.org>
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
 drivers/firmware/efi/Kconfig        | 11 +++++++++++
 drivers/firmware/efi/libstub/file.c |  3 +++
 2 files changed, 14 insertions(+)

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
diff --git a/drivers/firmware/efi/libstub/file.c b/drivers/firmware/efi/libstub/file.c
index ea66b1f16a79..ccdc36aaaa97 100644
--- a/drivers/firmware/efi/libstub/file.c
+++ b/drivers/firmware/efi/libstub/file.c
@@ -254,6 +254,9 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
 			     unsigned long soft_limit,
 			     unsigned long hard_limit)
 {
+	if (!IS_ENABLED(CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER))
+		return EFI_SUCCESS;
+
 	return handle_cmdline_files(image, L"initrd=", sizeof(L"initrd=") - 2,
 				    soft_limit, hard_limit, load_addr, load_size);
 }
-- 
2.17.1

