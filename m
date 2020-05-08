Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C7F1CB699
	for <lists+linux-efi@lfdr.de>; Fri,  8 May 2020 20:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgEHSDD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 May 2020 14:03:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728021AbgEHSDA (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 May 2020 14:03:00 -0400
Received: from e123331-lin.nice.arm.com (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2ED024956;
        Fri,  8 May 2020 18:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588960980;
        bh=Ciz6cGqRWSQBYdBDzNC/bjGbGKvmMvh2ZJIHO54bhtc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VMY0aJTmwc6t9qpd2+OOuFn/TtgB/PeXvYYc13DZkbJb/oGSkIkOlxopzsq45BIdO
         W9GJa3H75aH+x4bzPrCiAnhRWE1B9j8aZbWajIOTDt0/vFlUjLkK65din6I71CnVXu
         Y8Ibihl/uMO3kYqJkhZ36TS/9RWeO+f2VrGd2g14=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Guenter Roeck <linux@roeck-us.net>,
        Joe Perches <joe@perches.com>
Subject: [PATCH 15/15] efi/libstub: Correct comment typos
Date:   Fri,  8 May 2020 20:01:57 +0200
Message-Id: <20200508180157.1816-16-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508180157.1816-1-ardb@kernel.org>
References: <20200508180157.1816-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Joe Perches <joe@perches.com>

Fix a couple typos in comments.

Signed-off-by: Joe Perches <joe@perches.com>
Link: https://lore.kernel.org/r/ec53e67b3ac928922807db3cb1585e911971dadc.1588273612.git.joe@perches.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/pci.c      | 2 +-
 drivers/firmware/efi/libstub/relocate.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/pci.c b/drivers/firmware/efi/libstub/pci.c
index 60af51bed573..99fb25d2bcf5 100644
--- a/drivers/firmware/efi/libstub/pci.c
+++ b/drivers/firmware/efi/libstub/pci.c
@@ -69,7 +69,7 @@ void efi_pci_disable_bridge_busmaster(void)
 		 * access to the framebuffer. Drivers for true PCIe graphics
 		 * controllers that are behind a PCIe root port do not use
 		 * DMA to implement the GOP framebuffer anyway [although they
-		 * may use it in their implentation of Gop->Blt()], and so
+		 * may use it in their implementation of Gop->Blt()], and so
 		 * disabling DMA in the PCI bridge should not interfere with
 		 * normal operation of the device.
 		 */
diff --git a/drivers/firmware/efi/libstub/relocate.c b/drivers/firmware/efi/libstub/relocate.c
index 93c04d6aaed1..9b1aaf8b123f 100644
--- a/drivers/firmware/efi/libstub/relocate.c
+++ b/drivers/firmware/efi/libstub/relocate.c
@@ -140,7 +140,7 @@ efi_status_t efi_relocate_kernel(unsigned long *image_addr,
 	 * The EFI firmware loader could have placed the kernel image
 	 * anywhere in memory, but the kernel has restrictions on the
 	 * max physical address it can run at.  Some architectures
-	 * also have a prefered address, so first try to relocate
+	 * also have a preferred address, so first try to relocate
 	 * to the preferred address.  If that fails, allocate as low
 	 * as possible while respecting the required alignment.
 	 */
-- 
2.17.1

