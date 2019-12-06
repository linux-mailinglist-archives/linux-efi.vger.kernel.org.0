Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F37A1155E6
	for <lists+linux-efi@lfdr.de>; Fri,  6 Dec 2019 17:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfLFQ4J (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 6 Dec 2019 11:56:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:50870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbfLFQ4H (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 6 Dec 2019 11:56:07 -0500
Received: from e123331-lin.cambridge.arm.com (fw-tnat-cam5.arm.com [217.140.106.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D45321835;
        Fri,  6 Dec 2019 16:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575651366;
        bh=6gNDENZcJSQ67bgbdxuc4p2V01c4z4mpbBlsh9e0gpk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RW2LcMsM49xw3lMKdLuz+3b5IEOpXrl1+aU4tapnfxNmtGZ+XLlBPRzRA2r/HU7cc
         tKYxyCryQgOfGfe+q8NQlr+S4HiX784JqD3zdeZIStl4krWoBqL2GUE5BMoZ+dJ6ov
         A7Eq8IV0wXTRjOCa1SQyviRwppvp1W8Ukbl3/F0U=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: [PATCH 3/6] efi/gop: Return EFI_SUCCESS if a usable GOP was found
Date:   Fri,  6 Dec 2019 16:55:39 +0000
Message-Id: <20191206165542.31469-4-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191206165542.31469-1-ardb@kernel.org>
References: <20191206165542.31469-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

If we've found a usable instance of the Graphics Output Protocol
(GOP) with a framebuffer, it is possible that one of the later EFI
calls fails while checking if any support console output. In this
case status may be an EFI error code even though we found a usable
GOP.

Fix this by explicitly return EFI_SUCCESS if a usable GOP has been
located.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/gop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index 08f3c1a2fb48..69b2b019a1d0 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -198,7 +198,7 @@ setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
 
 	si->capabilities |= VIDEO_CAPABILITY_SKIP_QUIRKS;
 
-	return status;
+	return EFI_SUCCESS;
 }
 
 static efi_status_t
@@ -316,7 +316,7 @@ setup_gop64(efi_system_table_t *sys_table_arg, struct screen_info *si,
 
 	si->capabilities |= VIDEO_CAPABILITY_SKIP_QUIRKS;
 
-	return status;
+	return EFI_SUCCESS;
 }
 
 /*
-- 
2.17.1

