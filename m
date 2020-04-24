Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1DA41B764E
	for <lists+linux-efi@lfdr.de>; Fri, 24 Apr 2020 15:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgDXNGk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Apr 2020 09:06:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727992AbgDXNGj (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 24 Apr 2020 09:06:39 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B87F8208E4;
        Fri, 24 Apr 2020 13:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587733598;
        bh=0qpWo89t4RUFYtV0OfiC2khaAFGlZW45JvYFF4eliFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G88DnnEY9scCFLQuSVLXFRGcseXSxJ4elTjGrjfD3o1tXcMF3L9mQpmPgLc5PzQN9
         kEYFOBc/rGV75yo0pydkgBQLV/L0iCJgo4ZLF9CM0iQMM9N0/OKHIxVSRYCgsywOLZ
         2KlI8jmZlyrMaj1Qflp5oLNOIF8qycnZzCJux+Hc=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH 12/33] efi/gop: Use helper macros for find_bits
Date:   Fri, 24 Apr 2020 15:05:10 +0200
Message-Id: <20200424130531.30518-13-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200424130531.30518-1-ardb@kernel.org>
References: <20200424130531.30518-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

Use the __ffs/__fls macros to calculate the position and size of the
mask.

Correct type of mask to u32 instead of unsigned long.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://lore.kernel.org/r/20200320020028.1936003-9-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/gop.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index 7b0baf9a912f..8bf424f35759 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -5,6 +5,7 @@
  *
  * ----------------------------------------------------------------------- */
 
+#include <linux/bitops.h>
 #include <linux/efi.h>
 #include <linux/screen_info.h>
 #include <asm/efi.h>
@@ -12,27 +13,16 @@
 
 #include "efistub.h"
 
-static void find_bits(unsigned long mask, u8 *pos, u8 *size)
+static void find_bits(u32 mask, u8 *pos, u8 *size)
 {
-	u8 first, len;
-
-	first = 0;
-	len = 0;
-
-	if (mask) {
-		while (!(mask & 0x1)) {
-			mask = mask >> 1;
-			first++;
-		}
-
-		while (mask & 0x1) {
-			mask = mask >> 1;
-			len++;
-		}
+	if (!mask) {
+		*pos = *size = 0;
+		return;
 	}
 
-	*pos = first;
-	*size = len;
+	/* UEFI spec guarantees that the set bits are contiguous */
+	*pos  = __ffs(mask);
+	*size = __fls(mask) - *pos + 1;
 }
 
 static void
-- 
2.17.1

