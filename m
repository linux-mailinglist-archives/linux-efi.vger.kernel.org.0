Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9D51B7676
	for <lists+linux-efi@lfdr.de>; Fri, 24 Apr 2020 15:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgDXNIQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Apr 2020 09:08:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727909AbgDXNGa (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 24 Apr 2020 09:06:30 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28E2B20736;
        Fri, 24 Apr 2020 13:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587733589;
        bh=rRk35WDL+St6SUKwBs+S8eHDu7OxGH5ousr0/ZE+828=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ckIbt3E0RpNdNsX2GKl32F1DnlrnKEehY9g1PBkbcPyoceeIOGVYJt2BYUxH9fGhk
         1znNLxxyKz/xFpJS8OJt8/x90ThsGFdV3EX031LU8Ue1aGyPuZwnBeBH0Mf29lBpIT
         gGpfr5c4jGn0S3s1ZoMeZlOnB+CJv1F5s5wwTk8s=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH 08/33] efi/gop: Factor out locating the gop into a function
Date:   Fri, 24 Apr 2020 15:05:06 +0200
Message-Id: <20200424130531.30518-9-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200424130531.30518-1-ardb@kernel.org>
References: <20200424130531.30518-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

Move the loop to find a gop into its own function.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://lore.kernel.org/r/20200320020028.1936003-5-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/gop.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index d692b8c65813..92abcf558845 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -85,19 +85,17 @@ setup_pixel_info(struct screen_info *si, u32 pixels_per_scan_line,
 	}
 }
 
-static efi_status_t setup_gop(struct screen_info *si, efi_guid_t *proto,
-			      unsigned long size, void **handles)
+static efi_graphics_output_protocol_t *
+find_gop(efi_guid_t *proto, unsigned long size, void **handles)
 {
 	efi_graphics_output_protocol_t *gop, *first_gop;
 	efi_graphics_output_protocol_mode_t *mode;
 	efi_graphics_output_mode_info_t *info = NULL;
-	efi_physical_addr_t fb_base;
 	efi_status_t status;
 	efi_handle_t h;
 	int i;
 
 	first_gop = NULL;
-	gop = NULL;
 
 	for_each_efi_handle(h, handles, size, i) {
 		efi_guid_t conout_proto = EFI_CONSOLE_OUT_DEVICE_GUID;
@@ -134,12 +132,25 @@ static efi_status_t setup_gop(struct screen_info *si, efi_guid_t *proto,
 		}
 	}
 
+	return first_gop;
+}
+
+static efi_status_t setup_gop(struct screen_info *si, efi_guid_t *proto,
+			      unsigned long size, void **handles)
+{
+	efi_graphics_output_protocol_t *gop;
+	efi_graphics_output_protocol_mode_t *mode;
+	efi_graphics_output_mode_info_t *info = NULL;
+	efi_physical_addr_t fb_base;
+
+	gop = find_gop(proto, size, handles);
+
 	/* Did we find any GOPs? */
-	if (!first_gop)
+	if (!gop)
 		return EFI_NOT_FOUND;
 
 	/* EFI framebuffer */
-	mode = efi_table_attr(first_gop, mode);
+	mode = efi_table_attr(gop, mode);
 	info = efi_table_attr(mode, info);
 
 	si->orig_video_isVGA = VIDEO_TYPE_EFI;
-- 
2.17.1

