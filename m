Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2192729DB56
	for <lists+linux-efi@lfdr.de>; Thu, 29 Oct 2020 00:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389280AbgJ1XwA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 28 Oct 2020 19:52:00 -0400
Received: from leibniz.telenet-ops.be ([195.130.137.77]:54450 "EHLO
        leibniz.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389277AbgJ1Xv7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 28 Oct 2020 19:51:59 -0400
X-Greylist: delayed 4201 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Oct 2020 19:51:58 EDT
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by leibniz.telenet-ops.be (Postfix) with ESMTPS id 4CLt0F15k1zMyShy
        for <linux-efi@vger.kernel.org>; Wed, 28 Oct 2020 16:34:05 +0100 (CET)
Received: from ramsan.of.borg ([84.195.186.194])
        by michel.telenet-ops.be with bizsmtp
        id lTa42300Q4C55Sk06Ta4mw; Wed, 28 Oct 2020 16:34:04 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kXnSe-000pOh-6j; Wed, 28 Oct 2020 16:34:04 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kXnSd-007HeQ-O3; Wed, 28 Oct 2020 16:34:03 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] efi/libstub: EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER should not default to yes
Date:   Wed, 28 Oct 2020 16:34:02 +0100
Message-Id: <20201028153402.1736103-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER is deprecated, so it should not
be enabled by default.

In light of commit 4da0b2b7e67524cc ("efi/libstub: Re-enable command
line initrd loading for x86"), keep the default for X86.

Fixes: cf6b83664895a5c7 ("efi/libstub: Make initrd file loader configurable")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Hopefully kernelCI has updated its QEMU firmware since v1 was posted...

v2:
  - Rebase on top of commit d7071743db31b4f6 ("RISC-V: Add EFI stub
    support.") in v5.10-rc1.
---
 drivers/firmware/efi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 36ec1f7188934ca4..b452cfa2100b401c 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -122,7 +122,7 @@ config EFI_ARMSTUB_DTB_LOADER
 config EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER
 	bool "Enable the command line initrd loader" if !X86
 	depends on EFI_STUB && (EFI_GENERIC_STUB || X86)
-	default y
+	default y if X86
 	depends on !RISCV
 	help
 	  Select this config option to add support for the initrd= command
-- 
2.25.1

