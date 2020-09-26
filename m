Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C256C279805
	for <lists+linux-efi@lfdr.de>; Sat, 26 Sep 2020 10:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgIZI6y (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 26 Sep 2020 04:58:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbgIZI6y (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 26 Sep 2020 04:58:54 -0400
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92B472177B;
        Sat, 26 Sep 2020 08:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601110734;
        bh=5tpLjtiQEJbwoQqgSrQExoWGbqQoo4F0YTDW+ygpaT0=;
        h=From:To:Cc:Subject:Date:From;
        b=1csmmm1qIgXRyMiPNDxV8fHapwbtXBkLlrBiSFKe/cpL/esj9E1xfoxJowl3Snzmv
         9ggJIOo+Le4W/bb6SQyTR5epF3g0gwZK1iat4JH+ezX1BIoxOPU0KOMBQhzfTr4Mgf
         4BNkYS/xEvJ4anT8ilkeaG0046wgnT/Khi7/07No=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     xypron.glpk@gmx.de, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] efi/arm64: libstub: Deal gracefully with EFI_RNG_PROTOCOL failure
Date:   Sat, 26 Sep 2020 10:58:50 +0200
Message-Id: <20200926085850.16342-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Currently, on arm64, we abort on any failure from efi_get_random_bytes()
other than EFI_NOT_FOUND when it comes to setting the physical seed for
KASLR, but ignore such failures when obtaining the seed for virtual
KASLR or for early seeding of the kernel's entropy pool via the config
table. This is inconsistent, and may lead to unexpected boot failures.

So let's permit any failure for the physical seed, and simply report
the error code if it does not equal EFI_NOT_FOUND.

Reported-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/arm64-stub.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index e5bfac79e5ac..21692a986beb 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -62,10 +62,10 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 			status = efi_get_random_bytes(sizeof(phys_seed),
 						      (u8 *)&phys_seed);
 			if (status == EFI_NOT_FOUND) {
-				efi_info("EFI_RNG_PROTOCOL unavailable, no randomness supplied\n");
+				efi_info("EFI_RNG_PROTOCOL unavailable, KASLR will be disabled\n");
 			} else if (status != EFI_SUCCESS) {
-				efi_err("efi_get_random_bytes() failed\n");
-				return status;
+				efi_err("efi_get_random_bytes() failed (0x%lx), KASLR will be disabled\n",
+					status);
 			}
 		} else {
 			efi_info("KASLR disabled on kernel command line\n");
-- 
2.17.1

