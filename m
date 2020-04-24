Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00FC1B7678
	for <lists+linux-efi@lfdr.de>; Fri, 24 Apr 2020 15:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgDXNIU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Apr 2020 09:08:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727832AbgDXNGY (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 24 Apr 2020 09:06:24 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3E7F208E4;
        Fri, 24 Apr 2020 13:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587733583;
        bh=N8WHCZTXoYVd4HikAPCUeH5omQc/d7QvplV5w5DjrJc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lHjiZgxdXjR19WURXyNO0lmUEVNnlAOHUwUbY/wnZ9QUEfvIXfzoQaf/FxL7Gxaow
         YHxRRUXYI5n4PO7+K9PgHIUiqwUKVq+QRby0CsAHuMABoznxKpPd/M9AWpMknbZTSx
         UDxM/ZdgfG1pbrCToQjt6uoH6sk2L8J1y+zw8El8=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH 05/33] efi/gop: Remove redundant current_fb_base
Date:   Fri, 24 Apr 2020 15:05:03 +0200
Message-Id: <20200424130531.30518-6-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200424130531.30518-1-ardb@kernel.org>
References: <20200424130531.30518-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

current_fb_base isn't used for anything except assigning to fb_base if
we locate a suitable gop.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://lore.kernel.org/r/20200320020028.1936003-2-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/gop.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index 55e6b3f286fe..f40d535dccb8 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -108,7 +108,6 @@ static efi_status_t setup_gop(struct screen_info *si, efi_guid_t *proto,
 		efi_guid_t conout_proto = EFI_CONSOLE_OUT_DEVICE_GUID;
 		bool conout_found = false;
 		void *dummy = NULL;
-		efi_physical_addr_t current_fb_base;
 
 		status = efi_bs_call(handle_protocol, h, proto, (void **)&gop);
 		if (status != EFI_SUCCESS)
@@ -120,7 +119,6 @@ static efi_status_t setup_gop(struct screen_info *si, efi_guid_t *proto,
 
 		mode = efi_table_attr(gop, mode);
 		info = efi_table_attr(mode, info);
-		current_fb_base = efi_table_attr(mode, frame_buffer_base);
 
 		if ((!first_gop || conout_found) &&
 		    info->pixel_format != PIXEL_BLT_ONLY) {
@@ -136,7 +134,7 @@ static efi_status_t setup_gop(struct screen_info *si, efi_guid_t *proto,
 			pixel_format = info->pixel_format;
 			pixel_info = info->pixel_information;
 			pixels_per_scan_line = info->pixels_per_scan_line;
-			fb_base = current_fb_base;
+			fb_base = efi_table_attr(mode, frame_buffer_base);
 
 			/*
 			 * Once we've found a GOP supporting ConOut,
-- 
2.17.1

