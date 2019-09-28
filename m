Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFE7C1094
	for <lists+linux-efi@lfdr.de>; Sat, 28 Sep 2019 12:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbfI1KYg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 28 Sep 2019 06:24:36 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:45376 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfI1KYg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 28 Sep 2019 06:24:36 -0400
X-Greylist: delayed 600 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 Sep 2019 06:24:35 EDT
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 57A7B2005D4;
        Sat, 28 Sep 2019 10:14:34 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 6152B2054C; Sat, 28 Sep 2019 12:14:28 +0200 (CEST)
Date:   Sat, 28 Sep 2019 12:14:28 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     ard.biesheuvel@linaro.org, hsinyi@chromium.org,
        swboyd@chromium.org, robh@kernel.org, tytso@mit.edu,
        keescook@chromium.org, joeyli.kernel@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: [RFC] random: UEFI RNG input is bootloader randomness
Message-ID: <20190928101428.GA222453@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Depending on RANDOM_TRUST_BOOTLOADER, bootloader-provided randomness
is credited as entropy. As the UEFI seeding entropy pool is seeded by
the UEFI firmware/bootloader, add its content as bootloader randomness.

Note that this UEFI (v2.4 or newer) feature is currently only
implemented for EFI stub booting on ARM, and further note that
RANDOM_TRUST_BOOTLOADER must only be enabled if there indeed is
sufficient trust in the bootloader _and_ its source of randomness.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Stephen Boyd <swboyd@chromium.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Lee, Chun-Yi <joeyli.kernel@gmail.com>

---

Untested patch, as efi_random_get_seed() is only hooked up on ARM,
and the firmware on my old x86 laptop only has UEFI v2.31 anyway.

Thanks,
	Dominik

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 8f1ab04f6743..db0bffce754e 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -545,7 +545,7 @@ int __init efi_config_parse_tables(void *config_tables, int count, int sz,
 					      sizeof(*seed) + size);
 			if (seed != NULL) {
 				pr_notice("seeding entropy pool\n");
-				add_device_randomness(seed->bits, seed->size);
+				add_bootloader_randomness(seed->bits, seed->size);
 				early_memunmap(seed, sizeof(*seed) + size);
 			} else {
 				pr_err("Could not map UEFI random seed!\n");
