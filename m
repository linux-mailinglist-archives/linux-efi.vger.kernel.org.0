Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3381D14FC72
	for <lists+linux-efi@lfdr.de>; Sun,  2 Feb 2020 10:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbgBBJjt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-efi@lfdr.de>); Sun, 2 Feb 2020 04:39:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57746 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgBBJjs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 2 Feb 2020 04:39:48 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iyBjA-0000MD-TY; Sun, 02 Feb 2020 10:39:41 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 384551C1CE2;
        Sun,  2 Feb 2020 10:39:40 +0100 (CET)
Date:   Sun, 02 Feb 2020 09:39:39 -0000
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/x86: Fix boot regression on systems with
 invalid memmap entries
Cc:     jrg.otte@gmail.com, Dan Williams <dan.j.williams@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, linux-efi@vger.kernel.org,
        torvalds@linux-foundation.org, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200201233304.18322-1-ardb@kernel.org>
References: <20200201233304.18322-1-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <158063637918.411.14525312464973256998.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     59365cadfbcd299b8cdbe0c165faf15767c5f166
Gitweb:        https://git.kernel.org/tip/59365cadfbcd299b8cdbe0c165faf15767c5f166
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Sun, 02 Feb 2020 00:33:04 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 02 Feb 2020 10:25:43 +01:00

efi/x86: Fix boot regression on systems with invalid memmap entries

In efi_clean_memmap(), we do a pass over the EFI memory map to remove
bogus entries that may be returned on certain systems.

This recent commit:

  1db91035d01aa8bf ("efi: Add tracking for dynamically allocated memmaps")

refactored this code to pass the input to efi_memmap_install() via a
temporary struct on the stack, which is populated using an initializer
which inadvertently defines the value of its size field in terms of its
desc_size field, which value cannot be relied upon yet in the initializer
itself.

Fix this by using efi.memmap.desc_size instead, which is where we get
the value for desc_size from in the first place.

Reported-by: Jörg Otte <jrg.otte@gmail.com>
Tested-by: Jörg Otte <jrg.otte@gmail.com>
Tested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: linux-efi@vger.kernel.org
Cc: jrg.otte@gmail.com
Cc: torvalds@linux-foundation.org
Cc: mingo@kernel.org
Link: https://lore.kernel.org/r/20200201233304.18322-1-ardb@kernel.org
---
 arch/x86/platform/efi/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 59f7f6d..ae923ee 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -308,7 +308,7 @@ static void __init efi_clean_memmap(void)
 			.phys_map = efi.memmap.phys_map,
 			.desc_version = efi.memmap.desc_version,
 			.desc_size = efi.memmap.desc_size,
-			.size = data.desc_size * (efi.memmap.nr_map - n_removal),
+			.size = efi.memmap.desc_size * (efi.memmap.nr_map - n_removal),
 			.flags = 0,
 		};
 
