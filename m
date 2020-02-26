Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89B031704F6
	for <lists+linux-efi@lfdr.de>; Wed, 26 Feb 2020 17:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbgBZQzR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Feb 2020 11:55:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58288 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgBZQzQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 26 Feb 2020 11:55:16 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j6zxp-0002Dj-BO; Wed, 26 Feb 2020 17:55:13 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EB54E1C215C;
        Wed, 26 Feb 2020 17:55:12 +0100 (CET)
Date:   Wed, 26 Feb 2020 16:55:12 -0000
From:   "tip-bot2 for Jason A. Donenfeld" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi: READ_ONCE rng seed size before munmap
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, linux-efi@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200217123354.21140-1-Jason@zx2c4.com>
References: <20200217123354.21140-1-Jason@zx2c4.com>
MIME-Version: 1.0
Message-ID: <158273611261.28353.8523357540114932134.tip-bot2@tip-bot2>
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

Commit-ID:     be36f9e7517e17810ec369626a128d7948942259
Gitweb:        https://git.kernel.org/tip/be36f9e7517e17810ec369626a128d7948942259
Author:        Jason A. Donenfeld <Jason@zx2c4.com>
AuthorDate:    Fri, 21 Feb 2020 09:48:49 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 26 Feb 2020 15:31:43 +01:00

efi: READ_ONCE rng seed size before munmap

This function is consistent with using size instead of seed->size
(except for one place that this patch fixes), but it reads seed->size
without using READ_ONCE, which means the compiler might still do
something unwanted. So, this commit simply adds the READ_ONCE
wrapper.

Fixes: 636259880a7e ("efi: Add support for seeding the RNG from a UEFI ...")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: linux-efi@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20200217123354.21140-1-Jason@zx2c4.com
Link: https://lore.kernel.org/r/20200221084849.26878-5-ardb@kernel.org
---
 drivers/firmware/efi/efi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 621220a..21ea99f 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -552,7 +552,7 @@ int __init efi_config_parse_tables(void *config_tables, int count, int sz,
 
 		seed = early_memremap(efi.rng_seed, sizeof(*seed));
 		if (seed != NULL) {
-			size = seed->size;
+			size = READ_ONCE(seed->size);
 			early_memunmap(seed, sizeof(*seed));
 		} else {
 			pr_err("Could not map UEFI random seed!\n");
@@ -562,7 +562,7 @@ int __init efi_config_parse_tables(void *config_tables, int count, int sz,
 					      sizeof(*seed) + size);
 			if (seed != NULL) {
 				pr_notice("seeding entropy pool\n");
-				add_bootloader_randomness(seed->bits, seed->size);
+				add_bootloader_randomness(seed->bits, size);
 				early_memunmap(seed, sizeof(*seed) + size);
 			} else {
 				pr_err("Could not map UEFI random seed!\n");
