Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8897F275D14
	for <lists+linux-efi@lfdr.de>; Wed, 23 Sep 2020 18:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgIWQPK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 23 Sep 2020 12:15:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:42116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbgIWQPH (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 23 Sep 2020 12:15:07 -0400
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F8B520936;
        Wed, 23 Sep 2020 16:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600877707;
        bh=HORO4TYQh0n5xyJmt9DuvWW1jd+OsLPkVApF2GDMtMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s+JX9BZmY3oa4Efk4QNgu/1Y0UsFiXoR2rxIgMwvrG83RSBLLrghnTVwu3Y6Ml1E7
         hLGz+myix28LLB6TXIwThXuPtKY2JSBoKCq04ZQnQoY/2e0UAAY2Npk0GhQp4QBRTa
         TWMBm0AUVztwNwYVgmJJ/oMq2NkRU8VIEGbSHIGI=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        Peter Jones <pjones@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH 5/7] efi: remove some false dependencies on CONFIG_EFI_VARS
Date:   Wed, 23 Sep 2020 18:14:02 +0200
Message-Id: <20200923161404.17811-6-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200923161404.17811-1-ardb@kernel.org>
References: <20200923161404.17811-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Remove some false dependencies on CONFIG_EFI_VARS, which only controls
the creation of the sysfs entries, whereas the underlying functionality
that these modules rely on is enabled unconditionally when CONFIG_EFI
is set.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index dd8d10817bdf..80f5c67e3638 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -137,7 +137,6 @@ config EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER
 
 config EFI_BOOTLOADER_CONTROL
 	tristate "EFI Bootloader Control"
-	depends on EFI_VARS
 	default n
 	help
 	  This module installs a reboot hook, such that if reboot() is
@@ -281,7 +280,7 @@ config EFI_EARLYCON
 
 config EFI_CUSTOM_SSDT_OVERLAYS
 	bool "Load custom ACPI SSDT overlay from an EFI variable"
-	depends on EFI_VARS && ACPI
+	depends on EFI && ACPI
 	default ACPI_TABLE_UPGRADE
 	help
 	  Allow loading of an ACPI SSDT overlay from an EFI variable specified
-- 
2.17.1

