Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD3501944CD
	for <lists+linux-efi@lfdr.de>; Thu, 26 Mar 2020 17:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbgCZQ74 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 26 Mar 2020 12:59:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:59388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727393AbgCZQ74 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 26 Mar 2020 12:59:56 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C249A2076A;
        Thu, 26 Mar 2020 16:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585241996;
        bh=WOxWjfDmGgg1+ZblWxXKQ7OejY4FNXMxB6c3NNDo23Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a5yS6UI+qIXaocfR3tO4kOzpDdfzRknly4fV8lN/Y+PTW38wpngB7+Kd9aHPD6wNf
         zpF/TOJg8TJ+YEla3iNTKBnNBcoPVTdzIDMrpikCjVr43EkanYnwZv+9HdSQPySgxF
         QtlG8IXCFTTfpDnQ48/jz68+2S8GYYvxaPl0dkHk=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 1/2] efi/libstub/arm64: avoid copying the kernel unnecessarily
Date:   Thu, 26 Mar 2020 17:59:04 +0100
Message-Id: <20200326165905.2240-2-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326165905.2240-1-ardb@kernel.org>
References: <20200326165905.2240-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

If the UEFI firmware has loaded the kernel at the right alignment, and
we are running a relocatable kernel, there is no point in copying the
kernel to a different place in memory, and instead, we can just run it
in place.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/arm64-stub.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index 9254cd8ab2d3..d263f504dcf0 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -104,6 +104,15 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 					  (u32)phys_seed);
 
 		*image_addr = *reserve_addr + offset;
+	} else if (IS_ENABLED(CONFIG_RELOCATABLE) &&
+		   IS_ALIGNED((u64)_text - TEXT_OFFSET, EFI_KIMG_ALIGN)) {
+		/*
+		 * If we are relocatable and were loaded at a suitable offset,
+		 * there is no need to do anything and we can just execute in
+		 * place.
+		 */
+		*image_addr = (u64)_text;
+		return EFI_SUCCESS;
 	} else {
 		/*
 		 * Else, try a straight allocation at the preferred offset.
-- 
2.17.1

