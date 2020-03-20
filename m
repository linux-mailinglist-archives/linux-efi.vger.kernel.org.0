Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3FF118C511
	for <lists+linux-efi@lfdr.de>; Fri, 20 Mar 2020 03:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgCTCAi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Mar 2020 22:00:38 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43113 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbgCTCAi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Mar 2020 22:00:38 -0400
Received: by mail-qt1-f193.google.com with SMTP id l13so3727588qtv.10;
        Thu, 19 Mar 2020 19:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dCY4pcQQ/duoAuYSGzQpiC4wbuyHn31kQSsl0gZlWOc=;
        b=Tt/3n3QqhhdMgCk69MkeRisJ3ybSs4PBEUsaSkZQpKX9/i8YuWbIlvcW/+mqkpfyXM
         AwEUj9M2++iIWyYHP8rbvs+ZON38s6UMu3AVAua9eZsk+VMdU2xsXaf6kF96ZDc3uyZe
         kVDXq0opJT3NYsUhNjjcRCk5XT+QlaH/C2VOID7sCaIVWOyLLvgbHhCBXYAi6Oloqnyd
         F+JKzrGI2hcnv93Jkm6OPurc7BpSzx4xbMIMvRiL1p08/T8zKT2EXfbgTBGcm3ifAL77
         MCBzgydmZ4GKjKyYDU3CmKIMIw2RH+GjV1cNgxsNA72YuRkERlXQ9rvITlBOPbGOpsdd
         BCfw==
X-Gm-Message-State: ANhLgQ0uH3+wM+1Ds+u6pG/6JDTmOxhCzAvP62MM3dLRviiPGItZNBpJ
        F/pTAhzu/H+78PLdzIO8iyY=
X-Google-Smtp-Source: ADFU+vtxi+jBVrnp2o7KKK44IB7clGMxHLmgo1xIZDGx6U3IQjm3ufj4lAjSKCLw8JXKi//PktAI+g==
X-Received: by 2002:ac8:545a:: with SMTP id d26mr6011921qtq.238.1584669637023;
        Thu, 19 Mar 2020 19:00:37 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n46sm3342198qtb.48.2020.03.19.19.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 19:00:36 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/14] efi/gop: Use helper macros for find_bits
Date:   Thu, 19 Mar 2020 22:00:22 -0400
Message-Id: <20200320020028.1936003-9-nivedita@alum.mit.edu>
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

