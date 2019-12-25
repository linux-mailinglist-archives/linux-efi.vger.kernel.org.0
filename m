Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 877CA12A76A
	for <lists+linux-efi@lfdr.de>; Wed, 25 Dec 2019 11:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfLYKjD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Dec 2019 05:39:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40560 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfLYKjD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 25 Dec 2019 05:39:03 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ik446-000865-TP; Wed, 25 Dec 2019 11:38:55 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8B2AC1C2B24;
        Wed, 25 Dec 2019 11:38:54 +0100 (CET)
Date:   Wed, 25 Dec 2019 10:38:54 -0000
From:   "tip-bot2 for Hans de Goede" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/libstub/random: Initialize pointer variables to
 zero for mixed mode
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191224132909.102540-3-ardb@kernel.org>
References: <20191224132909.102540-3-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <157727033445.30329.1314683422943763379.tip-bot2@tip-bot2>
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

Commit-ID:     818c7ce724770fbcdcd43725c81f2b3535f82b76
Gitweb:        https://git.kernel.org/tip/818c7ce724770fbcdcd43725c81f2b3535f82b76
Author:        Hans de Goede <hdegoede@redhat.com>
AuthorDate:    Tue, 24 Dec 2019 14:29:08 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 25 Dec 2019 10:46:06 +01:00

efi/libstub/random: Initialize pointer variables to zero for mixed mode

Commit:

  0d95981438c3 ("x86: efi/random: Invoke EFI_RNG_PROTOCOL to seed the UEFI RNG table")

causes the drivers/efi/libstub/random.c code to get used on x86 for the first time.

But this code was not written with EFI mixed mode in mind (running a 64
bit kernel on 32 bit EFI firmware), this causes the kernel to crash during
early boot when running in mixed mode.

The problem is that in mixed mode pointers are 64 bit, but when running on
a 32 bit firmware, EFI calls which return a pointer value by reference only
fill the lower 32 bits of the passed pointer, leaving the upper 32 bits
uninitialized which leads to crashes.

This commit fixes this by initializing pointers which are passed by
reference to EFI calls to NULL before passing them, so that the upper 32
bits are initialized to 0.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Cc: Arvind Sankar <nivedita@alum.mit.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Fixes: 0d95981438c3 ("x86: efi/random: Invoke EFI_RNG_PROTOCOL to seed the UEFI RNG table")
Link: https://lkml.kernel.org/r/20191224132909.102540-3-ardb@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/libstub/random.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/libstub/random.c b/drivers/firmware/efi/libstub/random.c
index 35edd7c..97378cf 100644
--- a/drivers/firmware/efi/libstub/random.c
+++ b/drivers/firmware/efi/libstub/random.c
@@ -33,7 +33,7 @@ efi_status_t efi_get_random_bytes(efi_system_table_t *sys_table_arg,
 {
 	efi_guid_t rng_proto = EFI_RNG_PROTOCOL_GUID;
 	efi_status_t status;
-	struct efi_rng_protocol *rng;
+	struct efi_rng_protocol *rng = NULL;
 
 	status = efi_call_early(locate_protocol, &rng_proto, NULL,
 				(void **)&rng);
@@ -162,8 +162,8 @@ efi_status_t efi_random_get_seed(efi_system_table_t *sys_table_arg)
 	efi_guid_t rng_proto = EFI_RNG_PROTOCOL_GUID;
 	efi_guid_t rng_algo_raw = EFI_RNG_ALGORITHM_RAW;
 	efi_guid_t rng_table_guid = LINUX_EFI_RANDOM_SEED_TABLE_GUID;
-	struct efi_rng_protocol *rng;
-	struct linux_efi_random_seed *seed;
+	struct efi_rng_protocol *rng = NULL;
+	struct linux_efi_random_seed *seed = NULL;
 	efi_status_t status;
 
 	status = efi_call_early(locate_protocol, &rng_proto, NULL,
