Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEEA42FD5E0
	for <lists+linux-efi@lfdr.de>; Wed, 20 Jan 2021 17:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbhATQkU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Jan 2021 11:40:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:51574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391580AbhATQjf (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 20 Jan 2021 11:39:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE82223358;
        Wed, 20 Jan 2021 16:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611160735;
        bh=iEApgplDtm8lPwRtxhGxbaMnpeicweHkW/js70sakAQ=;
        h=From:To:Cc:Subject:Date:From;
        b=BTfXwMipflxxsNXpiCjD4OOMwgi1I2IJqUhJXejc12D91hnZpUnFBpq7EMhlkjZlN
         LU9TjlooUNK9pZYggydItgz76/sn+AHU//ii8Ls3wRKd4/m8F+9nFM3l6CT/ns0kDm
         TWKziUtDF1N+DJ2flOStF94KGNg1KHTAzu+qCN1s+N4vWdLKt1A72a+1Lg9Sewz/TI
         cHDVMveTNzAdXeubvMSqFhD6Ts96fy7RMbcJ4cY/axptAyAS1FUFXhKChTM67m96oT
         G8s+PsbLwYdXDehZsxofdawpb07Nl7Uj3IdUt9L18qOy/3UG0qeJvp5DqsAul2QOy+
         0ZQUC5EAa+3YQ==
From:   Mark Brown <broonie@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2] efi/arm64: Update debug prints to reflect other entropy sources
Date:   Wed, 20 Jan 2021 16:38:10 +0000
Message-Id: <20210120163810.14973-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Currently the EFI stub prints a diagnostic on boot saying that KASLR will
be disabled if it is unable to use the EFI RNG protocol to obtain a seed
for KASLR.  With the addition of support for v8.5-RNG and the SMCCC RNG
protocol it is now possible for KASLR to obtain entropy even if the EFI
RNG protocol is unsupported in the system, and the main kernel now
explicitly says if KASLR is active itself.  This can result in a boot
log where the stub says KASLR has been disabled and the main kernel says
that it is enabled which is confusing for users.

Remove the explicit reference to KASLR from the diagnostics, the warnings
are still useful as EFI is the only source of entropy the stub uses when
randomizing the physical address of the kernel and the other sources may
not be available.

Signed-off-by: Mark Brown <broonie@kernel.org>
---

v2: Remove all reference to KASLR from the log messages and clarify
    physical address randomization use of the EFI RNG seed.

 drivers/firmware/efi/libstub/arm64-stub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index 22ece1ad68a8..b69d63143e0d 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -61,10 +61,10 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 			status = efi_get_random_bytes(sizeof(phys_seed),
 						      (u8 *)&phys_seed);
 			if (status == EFI_NOT_FOUND) {
-				efi_info("EFI_RNG_PROTOCOL unavailable, KASLR will be disabled\n");
+				efi_info("EFI_RNG_PROTOCOL unavailable\n");
 				efi_nokaslr = true;
 			} else if (status != EFI_SUCCESS) {
-				efi_err("efi_get_random_bytes() failed (0x%lx), KASLR will be disabled\n",
+				efi_err("efi_get_random_bytes() failed (0x%lx)\n",
 					status);
 				efi_nokaslr = true;
 			}
-- 
2.20.1

