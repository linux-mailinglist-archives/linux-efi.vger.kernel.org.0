Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2271B763D
	for <lists+linux-efi@lfdr.de>; Fri, 24 Apr 2020 15:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgDXNGd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Apr 2020 09:06:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:56974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727944AbgDXNGc (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 24 Apr 2020 09:06:32 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D1DA21707;
        Fri, 24 Apr 2020 13:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587733592;
        bh=TNWAxJyW0WzLjFKU9UbDEglaA+vPGGUMfbqFjByO0gw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LS8jSE4HUu6zkdXflAT5Q528ydQrIVCFC6ej7SfVOcXeesYOT6fyntIYkxpnRZMB8
         gplj0heGPFk8eOrOI9Ht++YRJUsX8RmPq3biWAqMB4bWD2i1uXhsHBsy96hTqYNmHv
         Q4i006tag/jNy6tjwiYHml7imwaG8SJZVYmxysaE=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH 09/33] efi/gop: Slightly re-arrange logic of find_gop
Date:   Fri, 24 Apr 2020 15:05:07 +0200
Message-Id: <20200424130531.30518-10-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200424130531.30518-1-ardb@kernel.org>
References: <20200424130531.30518-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

Small cleanup to get rid of conout_found.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://lore.kernel.org/r/20200320020028.1936003-6-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/gop.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index 92abcf558845..a7d3efe36c78 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -99,7 +99,6 @@ find_gop(efi_guid_t *proto, unsigned long size, void **handles)
 
 	for_each_efi_handle(h, handles, size, i) {
 		efi_guid_t conout_proto = EFI_CONSOLE_OUT_DEVICE_GUID;
-		bool conout_found = false;
 		void *dummy = NULL;
 
 		status = efi_bs_call(handle_protocol, h, proto, (void **)&gop);
@@ -111,25 +110,22 @@ find_gop(efi_guid_t *proto, unsigned long size, void **handles)
 		if (info->pixel_format == PIXEL_BLT_ONLY)
 			continue;
 
+		/*
+		 * Systems that use the UEFI Console Splitter may
+		 * provide multiple GOP devices, not all of which are
+		 * backed by real hardware. The workaround is to search
+		 * for a GOP implementing the ConOut protocol, and if
+		 * one isn't found, to just fall back to the first GOP.
+		 *
+		 * Once we've found a GOP supporting ConOut,
+		 * don't bother looking any further.
+		 */
 		status = efi_bs_call(handle_protocol, h, &conout_proto, &dummy);
 		if (status == EFI_SUCCESS)
-			conout_found = true;
-
-		if (!first_gop || conout_found) {
-			/*
-			 * Systems that use the UEFI Console Splitter may
-			 * provide multiple GOP devices, not all of which are
-			 * backed by real hardware. The workaround is to search
-			 * for a GOP implementing the ConOut protocol, and if
-			 * one isn't found, to just fall back to the first GOP.
-			 *
-			 * Once we've found a GOP supporting ConOut,
-			 * don't bother looking any further.
-			 */
+			return gop;
+
+		if (!first_gop)
 			first_gop = gop;
-			if (conout_found)
-				break;
-		}
 	}
 
 	return first_gop;
-- 
2.17.1

