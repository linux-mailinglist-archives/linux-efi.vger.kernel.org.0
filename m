Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15D41B7672
	for <lists+linux-efi@lfdr.de>; Fri, 24 Apr 2020 15:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgDXNIH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Apr 2020 09:08:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727944AbgDXNGg (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 24 Apr 2020 09:06:36 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 943342084D;
        Fri, 24 Apr 2020 13:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587733596;
        bh=/CU1+viO/uOybhD5LiOXrjT4uUpGVaPMVAz8QFIUCS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mByKs0XWRT34GyGlM7bG32xsGOHGwCQdgqKVT2iqsHeJnjO2wYdNUxZ0NuwKvXmXH
         sESujs1zvVhibhkzgSuwlPFAVKTcZwqCTPgA6MFPdhAwqo4iOltImqu3b7M3aer5Sv
         RW/y4KGIi9u0u5UeiRk+U63mFjb5YmyIzPaYeDgE=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH 11/33] efi/gop: Use helper macros for populating lfb_base
Date:   Fri, 24 Apr 2020 15:05:09 +0200
Message-Id: <20200424130531.30518-12-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200424130531.30518-1-ardb@kernel.org>
References: <20200424130531.30518-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

Use the lower/upper_32_bits macros from kernel.h to initialize
si->lfb_base and si->ext_lfb_base.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://lore.kernel.org/r/20200320020028.1936003-8-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/gop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index 0d195060a370..7b0baf9a912f 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -158,8 +158,8 @@ static efi_status_t setup_gop(struct screen_info *si, efi_guid_t *proto,
 	si->lfb_height = info->vertical_resolution;
 
 	fb_base		 = efi_table_attr(mode, frame_buffer_base);
-	si->lfb_base	 = fb_base;
-	si->ext_lfb_base = (u64)(unsigned long)fb_base >> 32;
+	si->lfb_base	 = lower_32_bits(fb_base);
+	si->ext_lfb_base = upper_32_bits(fb_base);
 	if (si->ext_lfb_base)
 		si->capabilities |= VIDEO_CAPABILITY_64BIT_BASE;
 
-- 
2.17.1

