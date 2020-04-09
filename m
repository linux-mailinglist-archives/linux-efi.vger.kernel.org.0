Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4FEB1A3487
	for <lists+linux-efi@lfdr.de>; Thu,  9 Apr 2020 15:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgDINFA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Apr 2020 09:05:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:43810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbgDINFA (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 9 Apr 2020 09:05:00 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C5532145D;
        Thu,  9 Apr 2020 13:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586437500;
        bh=s0BcahdYY8q86hUtZsg5RZ5S4I6Vs3eEU8W8z2AxMt8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J3E99niXy8+9vp7aIJal9abB2VG2QCunrWkzk43NjrJdglRTUPnav4OG95gSz0pfo
         +XcaZRXQhxjpnXFCxjMgVVbkIRC7sdAUc8vb24LTa7D7cbOP+1o60nAo8oqylZeMZR
         IX62zGTf3UhQ7BxCLEBLnKMuNVP1/fRH5gKJCRF0=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>,
        Colin Ian King <colin.king@canonical.com>,
        Gary Lin <glin@suse.com>, Jiri Slaby <jslaby@suse.cz>,
        Sergey Shatunov <me@prok.pw>, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/9] efi/libstub/x86: remove redundant assignment to pointer hdr
Date:   Thu,  9 Apr 2020 15:04:27 +0200
Message-Id: <20200409130434.6736-3-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200409130434.6736-1-ardb@kernel.org>
References: <20200409130434.6736-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The pointer hdr is being assigned a value that is never read and
it is being updated later with a new value. The assignment is
redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Link: https://lore.kernel.org/r/20200402102537.503103-1-colin.king@canonical.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 8d3a707789de..e02ea51273ff 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -392,8 +392,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	image_base = efi_table_attr(image, image_base);
 	image_offset = (void *)startup_32 - image_base;
 
-	hdr = &((struct boot_params *)image_base)->hdr;
-
 	status = efi_allocate_pages(0x4000, (unsigned long *)&boot_params, ULONG_MAX);
 	if (status != EFI_SUCCESS) {
 		efi_printk("Failed to allocate lowmem for boot params\n");
-- 
2.17.1

