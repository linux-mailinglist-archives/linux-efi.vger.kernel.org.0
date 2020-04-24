Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E1F1B763F
	for <lists+linux-efi@lfdr.de>; Fri, 24 Apr 2020 15:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgDXNGh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Apr 2020 09:06:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:57030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726954AbgDXNGe (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 24 Apr 2020 09:06:34 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E6CE2087E;
        Fri, 24 Apr 2020 13:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587733594;
        bh=yay0uhlPeCbb5DfEc5mFmXom1uk+kOvAdVyPNt6cF54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wzbFd25zAetEclcdoX0kwTQWtGxGmfKmhaWLjUn3DiuagH9hEEBDwzVf33cvJ0Lr6
         LFqMrxCBz0Q+g3SDG85TSN+SFDVTcZq/qrEFPYEe9jplA+g/G7roxGyfcA8FR18aGS
         DlEEftcmrW23kLWKp68eQ8jYrTCMcjBbRygRt654=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH 10/33] efi/gop: Move variable declarations into loop block
Date:   Fri, 24 Apr 2020 15:05:08 +0200
Message-Id: <20200424130531.30518-11-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200424130531.30518-1-ardb@kernel.org>
References: <20200424130531.30518-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

Declare the variables inside the block where they're used.

Get rid of a couple of redundant initializers.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://lore.kernel.org/r/20200320020028.1936003-7-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/gop.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index a7d3efe36c78..0d195060a370 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -88,16 +88,19 @@ setup_pixel_info(struct screen_info *si, u32 pixels_per_scan_line,
 static efi_graphics_output_protocol_t *
 find_gop(efi_guid_t *proto, unsigned long size, void **handles)
 {
-	efi_graphics_output_protocol_t *gop, *first_gop;
-	efi_graphics_output_protocol_mode_t *mode;
-	efi_graphics_output_mode_info_t *info = NULL;
-	efi_status_t status;
+	efi_graphics_output_protocol_t *first_gop;
 	efi_handle_t h;
 	int i;
 
 	first_gop = NULL;
 
 	for_each_efi_handle(h, handles, size, i) {
+		efi_status_t status;
+
+		efi_graphics_output_protocol_t *gop;
+		efi_graphics_output_protocol_mode_t *mode;
+		efi_graphics_output_mode_info_t *info;
+
 		efi_guid_t conout_proto = EFI_CONSOLE_OUT_DEVICE_GUID;
 		void *dummy = NULL;
 
@@ -136,7 +139,7 @@ static efi_status_t setup_gop(struct screen_info *si, efi_guid_t *proto,
 {
 	efi_graphics_output_protocol_t *gop;
 	efi_graphics_output_protocol_mode_t *mode;
-	efi_graphics_output_mode_info_t *info = NULL;
+	efi_graphics_output_mode_info_t *info;
 	efi_physical_addr_t fb_base;
 
 	gop = find_gop(proto, size, handles);
-- 
2.17.1

