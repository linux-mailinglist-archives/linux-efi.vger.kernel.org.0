Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B093AEAF77
	for <lists+linux-efi@lfdr.de>; Thu, 31 Oct 2019 12:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbfJaL4H (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 31 Oct 2019 07:56:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55517 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbfJaLzl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 31 Oct 2019 07:55:41 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iQ935-0003BV-IN; Thu, 31 Oct 2019 12:55:31 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id ECD041C06D9;
        Thu, 31 Oct 2019 12:55:14 +0100 (CET)
Date:   Thu, 31 Oct 2019 11:55:14 -0000
From:   "tip-bot2 for Dominik Brodowski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/random: Treat EFI_RNG_PROTOCOL output as
 bootloader randomness
Cc:     Bhupesh Sharma <bhsharma@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20191029173755.27149-4-ardb@kernel.org>
References: <20191029173755.27149-4-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <157252291463.29376.12147960542860975670.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     18b915ac6b0ac5ba7ded03156860f60a9f16df2b
Gitweb:        https://git.kernel.org/tip/18b915ac6b0ac5ba7ded03156860f60a9f16df2b
Author:        Dominik Brodowski <linux@dominikbrodowski.net>
AuthorDate:    Tue, 29 Oct 2019 18:37:52 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 31 Oct 2019 09:40:18 +01:00

efi/random: Treat EFI_RNG_PROTOCOL output as bootloader randomness

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

[ ardb: update commit log ]

Tested-by: Bhupesh Sharma <bhsharma@redhat.com>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: https://lkml.kernel.org/r/20191029173755.27149-4-ardb@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 69f00f7..e98bbf8 100644
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
