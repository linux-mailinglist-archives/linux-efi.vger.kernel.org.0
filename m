Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A982E18C05F
	for <lists+linux-efi@lfdr.de>; Thu, 19 Mar 2020 20:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgCST3n (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Mar 2020 15:29:43 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44755 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbgCST3F (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Mar 2020 15:29:05 -0400
Received: by mail-qk1-f195.google.com with SMTP id j4so4361083qkc.11;
        Thu, 19 Mar 2020 12:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dCY4pcQQ/duoAuYSGzQpiC4wbuyHn31kQSsl0gZlWOc=;
        b=kbulQfOLEr2KCq3sg9vk+/sXQeyjFqankmDJlfS0zRCmK8QZpj8BVxf2wlKbXVrCka
         ctTflcgQDzYTwlybcF4TxZVoxzSDVZSpLkwu/DZCYrWe9FWpBEQrgGWI0w0YsbTCHqFa
         pQYLHjls6S7N1npAvQum60nuceatdbdOqWb76GuQaWqN/7/stVAJbvDfvZAzIE0W7WVO
         U5+3hCfCUjyHUy2WjaMaxXc1nxqkvqiGnFTWArjiPbPIeI3I0HKGGgGMjjQ+52aQrPpE
         ivqZzD5D7fm67Wh+ie+ZfE13AjCqnaIIT+Zr/aHpgiiR3fBEDy6WL8Wz0/WSuIfDm2G/
         6VCQ==
X-Gm-Message-State: ANhLgQ3uK9uTObmh89Z8mV4C/r2EUvnOJPu07koNStGlOWlabMu58B1j
        Z7AHIe3Z0WXgcIthnsWfwuM=
X-Google-Smtp-Source: ADFU+vtJ6oGM1bhgupBGOgnakoKxFd0uf2M+73eCVi0HKswRLjqTfW/gNW2Yt4a/GWDgi07/AAPXlw==
X-Received: by 2002:a37:b305:: with SMTP id c5mr4646140qkf.213.1584646144376;
        Thu, 19 Mar 2020 12:29:04 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id x89sm2292649qtd.43.2020.03.19.12.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 12:29:03 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/14] efi/gop: Use helper macros for find_bits
Date:   Thu, 19 Mar 2020 15:28:49 -0400
Message-Id: <20200319192855.29876-9-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200319192855.29876-1-nivedita@alum.mit.edu>
References: <20200319192855.29876-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Use the __ffs/__fls macros to calculate the position and size of the
mask.

Correct type of mask to u32 instead of unsigned long.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
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
2.24.1

