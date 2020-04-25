Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5271B8595
	for <lists+linux-efi@lfdr.de>; Sat, 25 Apr 2020 12:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgDYKWJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 25 Apr 2020 06:22:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbgDYKWI (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 25 Apr 2020 06:22:08 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A394E20704;
        Sat, 25 Apr 2020 10:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587810128;
        bh=dFCaNrXN3xWy41YIO/NxyOuEa912fJ0KV82OjFF7K+4=;
        h=From:To:Cc:Subject:Date:From;
        b=B1VZbBLVrdpFCD8RM1dDeGdWobkF7h3ogOINGJxCGG3JmRdgUAlDFP+wsB2F3rgIi
         dyKjThm95pfrkMwGC5sbLzhFsd9XDFfxcfhuv9+iStJfxpQBcdUvo0it57xXj5q3xi
         eexV4R2hSY0QK9K3A6l+XeHDEpAkoXmExKxAWE+I=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, mingo@kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] efi/libstub: Re-enable command line initrd loading for x86
Date:   Sat, 25 Apr 2020 12:22:04 +0200
Message-Id: <20200425102204.2622-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit

  cf6b83664895a5 ("efi/libstub: Make initrd file loader configurable")

inadvertently disabled support on x86 for loading an initrd passed via
the initrd= option on the kernel command line.

Add X86 to the newly introduced Kconfig option's title and depends
declarations, so it gets enabled by default, as before.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---

Ingo,

Mind taking this directly into tip/efi/core? Thanks.


 drivers/firmware/efi/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 4e788dd55b03..9e6ff0743bc1 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -125,8 +125,8 @@ config EFI_ARMSTUB_DTB_LOADER
 	  this option is necessary.
 
 config EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER
-	bool "Enable the command line initrd loader"
-	depends on EFI_GENERIC_STUB
+	bool "Enable the command line initrd loader" if !X86
+	depends on EFI_STUB && (EFI_GENERIC_STUB || X86)
 	default y
 	help
 	  Select this config option to add support for the initrd= command
-- 
2.17.1

