Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611E13D5C22
	for <lists+linux-efi@lfdr.de>; Mon, 26 Jul 2021 16:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbhGZOLo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 26 Jul 2021 10:11:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:53118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234679AbhGZOLj (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 26 Jul 2021 10:11:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4A8060F55;
        Mon, 26 Jul 2021 14:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627311128;
        bh=FL4XscM/XE1HlSxzzIgal5E9ANumuP+Cm/xIkiJYOxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MtiPxwUzhbv1NycIDYzPr/+wphukJlZG1AllhC03Y+kim9P5uVjKZS6EuiX6eBAir
         JJipAXDq/lcGVSbubMsqCQvZyXj0hMYl83O0jrOhbI0VoWwtoMXhdMV5VjvppBQqlG
         c1kLrcgwDoxR38YEnQHSEnSvgqIcXEbCvNTIA734Ce61rZgloe93ONK4xnDgrOVIVg
         GibqZlTfGdRLPGbdQR9B2JROk2BxwmJ8wdMi7Bu3WmdoFYUv7UuIvRjj6bgCTdWj63
         xG2/kK2mu0KfQuCHQRIJITSTTmA2FexD9KwRXeo5TFZlIU8xg9/Z00ELLQtyuWF1vL
         51lZvu79s1/iQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v3 3/4] efi/libstub: arm64: Warn when efi_random_alloc() fails
Date:   Mon, 26 Jul 2021 16:51:55 +0200
Message-Id: <20210726145156.12006-4-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210726145156.12006-1-ardb@kernel.org>
References: <20210726145156.12006-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Randomization of the physical load address of the kernel image relies on
efi_random_alloc() returning successfully, and currently, we ignore any
failures and just carry on, using the ordinary, non-randomized page
allocator routine. This means we never find out if a failure occurs,
which could harm security, so let's at least warn about this condition.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/arm64-stub.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index 6f214c9c303e..010564f8bbc4 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -130,6 +130,8 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 		 */
 		status = efi_random_alloc(*reserve_size, min_kimg_align,
 					  reserve_addr, phys_seed);
+		if (status != EFI_SUCCESS)
+			efi_warn("efi_random_alloc() failed: 0x%lx\n", status);
 	} else {
 		status = EFI_OUT_OF_RESOURCES;
 	}
-- 
2.20.1

