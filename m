Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 451B4E8E67
	for <lists+linux-efi@lfdr.de>; Tue, 29 Oct 2019 18:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbfJ2RjL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 29 Oct 2019 13:39:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbfJ2RjI (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 29 Oct 2019 13:39:08 -0400
Received: from e123331-lin.home (lfbn-mar-1-643-104.w90-118.abo.wanadoo.fr [90.118.215.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3FE921D56;
        Tue, 29 Oct 2019 17:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572370748;
        bh=oymEELGrNns0o0whUE0SGLHo9S3Ex3P+bmLtBPSI21Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UNSs36WotzQfSLtftOWu5CNpX1glfup1NZFoAu80EaDJL8p7NFDxj+7GFLWp2hNDm
         XJtGuCFlUilbTfBFMxdD01fxqY1if911DEbqaaDRSWRGL/gfRw9rMUTdoNWjfyi2pv
         CVDaFhhkuewSOfySwa5xnoga8eS1gYKRMilG8NIA=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] efi/random: treat EFI_RNG_PROTOCOL output as bootloader randomness
Date:   Tue, 29 Oct 2019 18:37:52 +0100
Message-Id: <20191029173755.27149-4-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191029173755.27149-1-ardb@kernel.org>
References: <20191029173755.27149-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Dominik Brodowski <linux@dominikbrodowski.net>

Commit 428826f5358c ("fdt: add support for rng-seed") introduced
add_bootloader_randomness(), permitting randomness provided by the
bootloader or firmware to be credited as entropy. However, the fact
that the UEFI support code was already wired into the RNG subsystem
via a call to add_device_randomness() was overlooked, and so it was
not converted at the same time.

Note that this UEFI (v2.4 or newer) feature is currently only
implemented for EFI stub booting on ARM, and further note that
CONFIG_RANDOM_TRUST_BOOTLOADER must be enabled, and this should be
done only if there indeed is sufficient trust in the bootloader
_and_ its source of randomness.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
[ardb: update commit log]
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 69f00f7453a3..e98bbf8e56d9 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -554,7 +554,7 @@ int __init efi_config_parse_tables(void *config_tables, int count, int sz,
 					      sizeof(*seed) + size);
 			if (seed != NULL) {
 				pr_notice("seeding entropy pool\n");
-				add_device_randomness(seed->bits, seed->size);
+				add_bootloader_randomness(seed->bits, seed->size);
 				early_memunmap(seed, sizeof(*seed) + size);
 			} else {
 				pr_err("Could not map UEFI random seed!\n");
-- 
2.17.1

