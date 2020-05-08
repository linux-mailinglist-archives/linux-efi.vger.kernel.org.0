Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31211CB686
	for <lists+linux-efi@lfdr.de>; Fri,  8 May 2020 20:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgEHSCh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 May 2020 14:02:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:47996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727845AbgEHSCd (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 May 2020 14:02:33 -0400
Received: from e123331-lin.nice.arm.com (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A833F24957;
        Fri,  8 May 2020 18:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588960952;
        bh=NXgOr8+IDDJ86JzwJlupV+Xks7Oz1oRGnMkA9Se54V0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=chkI37xlMKjCwq9IVeoRBZlXmxOvdEHVCnMZ6tvXyXMjvAPUkOiwbTf9A8MAqpAQJ
         8jMQPfk0NtJCL40bsAoyK6emepc7g7pMvvKy72YdtUfuVeSCMgro3xghsupLUqj3yU
         PteWy90qjB3hrVrZEGW8wi40UKrktVd9CRFiDo+Q=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Guenter Roeck <linux@roeck-us.net>,
        Joe Perches <joe@perches.com>
Subject: [PATCH 05/15] efi/gop: Use efi_err for error messages
Date:   Fri,  8 May 2020 20:01:47 +0200
Message-Id: <20200508180157.1816-6-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508180157.1816-1-ardb@kernel.org>
References: <20200508180157.1816-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

Use efi_err instead of bare efi_printk for error messages.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://lore.kernel.org/r/20200430182843.2510180-6-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/gop.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index 64cee0febae0..34c0cba2c8bf 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -134,14 +134,14 @@ static u32 choose_mode_modenum(efi_graphics_output_protocol_t *gop)
 
 	max_mode = efi_table_attr(mode, max_mode);
 	if (cmdline.mode >= max_mode) {
-		efi_printk("Requested mode is invalid\n");
+		efi_err("Requested mode is invalid\n");
 		return cur_mode;
 	}
 
 	status = efi_call_proto(gop, query_mode, cmdline.mode,
 				&info_size, &info);
 	if (status != EFI_SUCCESS) {
-		efi_printk("Couldn't get mode information\n");
+		efi_err("Couldn't get mode information\n");
 		return cur_mode;
 	}
 
@@ -150,7 +150,7 @@ static u32 choose_mode_modenum(efi_graphics_output_protocol_t *gop)
 	efi_bs_call(free_pool, info);
 
 	if (pf == PIXEL_BLT_ONLY || pf >= PIXEL_FORMAT_MAX) {
-		efi_printk("Invalid PixelFormat\n");
+		efi_err("Invalid PixelFormat\n");
 		return cur_mode;
 	}
 
@@ -222,7 +222,7 @@ static u32 choose_mode_res(efi_graphics_output_protocol_t *gop)
 			return m;
 	}
 
-	efi_printk("Couldn't find requested mode\n");
+	efi_err("Couldn't find requested mode\n");
 
 	return cur_mode;
 }
@@ -316,7 +316,7 @@ static void set_mode(efi_graphics_output_protocol_t *gop)
 		return;
 
 	if (efi_call_proto(gop, set_mode, new_mode) != EFI_SUCCESS)
-		efi_printk("Failed to set requested mode\n");
+		efi_err("Failed to set requested mode\n");
 }
 
 static void find_bits(u32 mask, u8 *pos, u8 *size)
-- 
2.17.1

