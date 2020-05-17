Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDE81D6814
	for <lists+linux-efi@lfdr.de>; Sun, 17 May 2020 14:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbgEQM6k (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 17 May 2020 08:58:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:51584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728019AbgEQM6k (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 17 May 2020 08:58:40 -0400
Received: from e123331-lin.nice.arm.com (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF29A207D4;
        Sun, 17 May 2020 12:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589720319;
        bh=JFADzI+bFJI+qlwWMdKUY00z9kgPZExBs/0rCBkTIhM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ju+Tp6asCB7nzRU2CbbVhiOH+xYnaQJ8GlIfdcUPGOp5blK9vXI6sGf7LIeNv6Rej
         qkRUsF4rx4kAaU/zBxmBFjuX6YsDM1KiBWh4MjXbllG2haQtcdpC199CjQHANHta8i
         k7sIEHGMY3XBT93FXDAsKZdRVL2jfyA9rqP/d8Ms=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Benjamin Thiel <b.thiel@posteo.de>,
        Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        linux-acpi@vger.kernel.org, Loic Yhuel <loic.yhuel@gmail.com>,
        Matthew Garrett <mjg59@google.com>,
        Mike Lothian <mike@fireburn.co.uk>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Subject: [PATCH 2/7] efi/earlycon: Fix early printk for wider fonts
Date:   Sun, 17 May 2020 14:57:49 +0200
Message-Id: <20200517125754.8934-3-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200517125754.8934-1-ardb@kernel.org>
References: <20200517125754.8934-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Dave Young <dyoung@redhat.com>

When I play with terminus fonts I noticed the efi early printk does
not work because the earlycon code assumes font width is 8.

Here add the code to adapt with larger fonts.  Tested with all kinds
of kernel built-in fonts on my laptop. Also tested with a local draft
patch for 14x28 !bold terminus font.

Signed-off-by: Dave Young <dyoung@redhat.com>
Link: https://lore.kernel.org/r/20200412024927.GA6884@dhcp-128-65.nay.redhat.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/earlycon.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/efi/earlycon.c b/drivers/firmware/efi/earlycon.c
index 5d4f84781aa0..a52236e11e5f 100644
--- a/drivers/firmware/efi/earlycon.c
+++ b/drivers/firmware/efi/earlycon.c
@@ -114,14 +114,16 @@ static void efi_earlycon_write_char(u32 *dst, unsigned char c, unsigned int h)
 	const u32 color_black = 0x00000000;
 	const u32 color_white = 0x00ffffff;
 	const u8 *src;
-	u8 s8;
-	int m;
+	int m, n, bytes;
+	u8 x;
 
-	src = font->data + c * font->height;
-	s8 = *(src + h);
+	bytes = BITS_TO_BYTES(font->width);
+	src = font->data + c * font->height * bytes + h * bytes;
 
-	for (m = 0; m < 8; m++) {
-		if ((s8 >> (7 - m)) & 1)
+	for (m = 0; m < font->width; m++) {
+		n = m % 8;
+		x = *(src + m / 8);
+		if ((x >> (7 - n)) & 1)
 			*dst = color_white;
 		else
 			*dst = color_black;
-- 
2.17.1

