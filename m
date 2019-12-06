Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68C0F1155E9
	for <lists+linux-efi@lfdr.de>; Fri,  6 Dec 2019 17:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfLFQ4G (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 6 Dec 2019 11:56:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:50826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbfLFQ4F (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 6 Dec 2019 11:56:05 -0500
Received: from e123331-lin.cambridge.arm.com (fw-tnat-cam5.arm.com [217.140.106.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7339E2466E;
        Fri,  6 Dec 2019 16:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575651364;
        bh=PReHa2l/5slFJUHYxmKO7wTlOyr/DkZ+YiOdHmPh9es=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hEdhvXn3PgBXlWSIWEla/gAFvEI56jbplkOPFOg0YvHeYiGIbiC3q349DLy0sEnpJ
         osvzYoq9mQBnpFvu9TvAJwVgutKoeBDzxQPO41rWPIsmKp+8nUsNsXrHfoMUpbNFaR
         6lfyF10R/kQPjy31yRvk7R538W7E9mp6NoSTFi6A=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: [PATCH 2/6] efi/gop: Return EFI_NOT_FOUND if there are no usable GOPs
Date:   Fri,  6 Dec 2019 16:55:38 +0000
Message-Id: <20191206165542.31469-3-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191206165542.31469-1-ardb@kernel.org>
References: <20191206165542.31469-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

If we don't find a usable instance of the Graphics Output Protocol
(GOP) because none of them have a framebuffer (i.e. they were all
PIXEL_BLT_ONLY), but all the efi calls succeeded, we will return
EFI_SUCCESS even though we didn't find a usable GOP.

Fix this by explicitly returning EFI_NOT_FOUND if no usable GOPs are
found, allowing the caller to probe for UGA instead.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/gop.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index 0101ca4c13b1..08f3c1a2fb48 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -119,7 +119,7 @@ setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
 	u64 fb_base;
 	struct efi_pixel_bitmask pixel_info;
 	int pixel_format;
-	efi_status_t status = EFI_NOT_FOUND;
+	efi_status_t status;
 	u32 *handles = (u32 *)(unsigned long)gop_handle;
 	int i;
 
@@ -175,7 +175,7 @@ setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
 
 	/* Did we find any GOPs? */
 	if (!first_gop)
-		goto out;
+		return EFI_NOT_FOUND;
 
 	/* EFI framebuffer */
 	si->orig_video_isVGA = VIDEO_TYPE_EFI;
@@ -197,7 +197,7 @@ setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
 	si->lfb_size = si->lfb_linelength * si->lfb_height;
 
 	si->capabilities |= VIDEO_CAPABILITY_SKIP_QUIRKS;
-out:
+
 	return status;
 }
 
@@ -237,7 +237,7 @@ setup_gop64(efi_system_table_t *sys_table_arg, struct screen_info *si,
 	u64 fb_base;
 	struct efi_pixel_bitmask pixel_info;
 	int pixel_format;
-	efi_status_t status = EFI_NOT_FOUND;
+	efi_status_t status;
 	u64 *handles = (u64 *)(unsigned long)gop_handle;
 	int i;
 
@@ -293,7 +293,7 @@ setup_gop64(efi_system_table_t *sys_table_arg, struct screen_info *si,
 
 	/* Did we find any GOPs? */
 	if (!first_gop)
-		goto out;
+		return EFI_NOT_FOUND;
 
 	/* EFI framebuffer */
 	si->orig_video_isVGA = VIDEO_TYPE_EFI;
@@ -315,7 +315,7 @@ setup_gop64(efi_system_table_t *sys_table_arg, struct screen_info *si,
 	si->lfb_size = si->lfb_linelength * si->lfb_height;
 
 	si->capabilities |= VIDEO_CAPABILITY_SKIP_QUIRKS;
-out:
+
 	return status;
 }
 
-- 
2.17.1

