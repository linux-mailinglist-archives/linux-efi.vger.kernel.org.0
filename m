Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358DB275D1F
	for <lists+linux-efi@lfdr.de>; Wed, 23 Sep 2020 18:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgIWQPL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 23 Sep 2020 12:15:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbgIWQPJ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 23 Sep 2020 12:15:09 -0400
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D11D2223E;
        Wed, 23 Sep 2020 16:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600877709;
        bh=H9yseVXOZkuxMQi1C3SGB2Eins76vUkEAUkZJZSniHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sGWTzRnt6gX0XYyOGVoX7Sfz/L+1nWkp9PKH/BC0bwS4Yrg+Oej+pxxj4UWzAgK/C
         ukCjyt6rDvLPfcagqb9MkLfc6XPsTTUOjmhxew1/6Xi3Kti1j56+OKmnlikBt/i+B/
         zkg+OZ8IZTN6f5kpfeuLF1jc4x0Hm65xvMJcAuZc=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        Peter Jones <pjones@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH 6/7] efi: efivars: limit availability to X86 builds
Date:   Wed, 23 Sep 2020 18:14:03 +0200
Message-Id: <20200923161404.17811-7-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200923161404.17811-1-ardb@kernel.org>
References: <20200923161404.17811-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

CONFIG_EFI_VARS controls the code that exposes EFI variables via
sysfs entries, which was deprecated before support for non-Intel
architectures was added to EFI. So let's limit its availability
to Intel architectures for the time being, and hopefully remove
it entirely in the not too distant future.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 Documentation/arm/uefi.rst   |  2 +-
 drivers/firmware/efi/Kconfig | 13 ++++---------
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/Documentation/arm/uefi.rst b/Documentation/arm/uefi.rst
index f868330df6be..f732f957421f 100644
--- a/Documentation/arm/uefi.rst
+++ b/Documentation/arm/uefi.rst
@@ -23,7 +23,7 @@ makes it possible for the kernel to support additional features:
 For actually enabling [U]EFI support, enable:
 
 - CONFIG_EFI=y
-- CONFIG_EFI_VARS=y or m
+- CONFIG_EFIVAR_FS=y or m
 
 The implementation depends on receiving information about the UEFI environment
 in a Flattened Device Tree (FDT) - so is only available with CONFIG_OF.
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 80f5c67e3638..da1887f72a51 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -4,20 +4,15 @@ menu "EFI (Extensible Firmware Interface) Support"
 
 config EFI_VARS
 	tristate "EFI Variable Support via sysfs"
-	depends on EFI
+	depends on EFI && (X86 || IA64)
 	default n
 	help
 	  If you say Y here, you are able to get EFI (Extensible Firmware
 	  Interface) variable information via sysfs.  You may read,
 	  write, create, and destroy EFI variables through this interface.
-
-	  Note that using this driver in concert with efibootmgr requires
-	  at least test release version 0.5.0-test3 or later, which is
-	  available from:
-	  <http://linux.dell.com/efibootmgr/testing/efibootmgr-0.5.0-test3.tar.gz>
-
-	  Subsequent efibootmgr releases may be found at:
-	  <http://github.com/vathpela/efibootmgr>
+	  Note that this driver is only retained for compatibility with
+	  legacy users: new users should use the efivarfs filesystem
+	  instead.
 
 config EFI_ESRT
 	bool
-- 
2.17.1

