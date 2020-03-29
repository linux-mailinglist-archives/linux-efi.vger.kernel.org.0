Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE0D196BD0
	for <lists+linux-efi@lfdr.de>; Sun, 29 Mar 2020 10:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgC2IGD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 29 Mar 2020 04:06:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbgC2IGD (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 29 Mar 2020 04:06:03 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FECF20781;
        Sun, 29 Mar 2020 08:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585469162;
        bh=X5cIBfHwpsTFUJFdIop7vTAf2qO10L+TXiiakFrcIl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OKiSF8ptWTp9+s+Vp9JqSSPuQHeB4QIuiIYEceG2aPi6uMxXcT3C4imf+vsqRaGoE
         XjQAR//8EzT+Dezb7fkQ9aX9Hz9CrHZxDmfNVtwsT4Z8KamEBzV2MucB2JEBIbbE7A
         DK7E6g6ghMG7SH7QdmSEl/2rck0num4fh1p7tI2g=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 2/2] efi/libstub/arm: fix spurious message that an initrd was loaded
Date:   Sun, 29 Mar 2020 10:05:44 +0200
Message-Id: <20200329080544.25715-3-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200329080544.25715-1-ardb@kernel.org>
References: <20200329080544.25715-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit ec93fc371f014a6f ("efi/libstub: Add support for loading the initrd
from a device path") added a diagnostic print to the ARM version of the
EFI stub that reports whether an initrd has been loaded that was passed
via the command line using initrd=. However, it failed to take into
account that, for historical reasons, the file loading routines return
EFI_SUCCESS when no file was found, and the only way to decide whether
a file was loaded is to inspect the 'size' argument that is passed by
reference. So let's inspect this returned size, to prevent the print
from being emitted even if no initrd was loaded at all.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/arm-stub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index 13559c7e6643..99a5cde7c2d8 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -277,7 +277,7 @@ efi_status_t efi_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg)
 		} else if (status == EFI_NOT_FOUND) {
 			status = efi_load_initrd(image, &initrd_addr, &initrd_size,
 						 ULONG_MAX, max_addr);
-			if (status == EFI_SUCCESS)
+			if (status == EFI_SUCCESS && initrd_size > 0)
 				pr_efi("Loaded initrd from command line option\n");
 		}
 		if (status != EFI_SUCCESS)
-- 
2.17.1

