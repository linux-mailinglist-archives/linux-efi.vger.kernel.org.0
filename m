Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF215CE60D
	for <lists+linux-efi@lfdr.de>; Mon,  7 Oct 2019 16:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbfJGOwA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Oct 2019 10:52:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44245 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbfJGOt0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Oct 2019 10:49:26 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iHUJx-0005pP-Uc; Mon, 07 Oct 2019 16:49:10 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 92D991C079B;
        Mon,  7 Oct 2019 16:49:09 +0200 (CEST)
Date:   Mon, 07 Oct 2019 14:49:09 -0000
From:   "tip-bot2 for Ben Dooks" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi: Make unexported efi_rci2_sysfs_init() static
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Young <dyoung@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lukas Wunner <lukas@wunner.de>, Lyude Paul <lyude@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Octavian Purdila <octavian.purdila@intel.com>,
        Peter Jones <pjones@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Scott Talbert <swt@techie.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191002165904.8819-7-ard.biesheuvel@linaro.org>
References: <20191002165904.8819-7-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Message-ID: <157045974955.9978.506280741956101710.tip-bot2@tip-bot2>
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

Commit-ID:     1ed121e61630fbf23fc0df1b8aa76debede5032b
Gitweb:        https://git.kernel.org/tip/1ed121e61630fbf23fc0df1b8aa76debede5032b
Author:        Ben Dooks <ben.dooks@codethink.co.uk>
AuthorDate:    Wed, 02 Oct 2019 18:59:03 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 07 Oct 2019 15:24:36 +02:00

efi: Make unexported efi_rci2_sysfs_init() static

The efi_rci2_sysfs_init() is not used outside of rci2-table.c so
make it static to silence the following Sparse warning:

  drivers/firmware/efi/rci2-table.c:79:12: warning: symbol 'efi_rci2_sysfs_init' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Matthew Garrett <mjg59@google.com>
Cc: Octavian Purdila <octavian.purdila@intel.com>
Cc: Peter Jones <pjones@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Scott Talbert <swt@techie.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Link: https://lkml.kernel.org/r/20191002165904.8819-7-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/rci2-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/rci2-table.c b/drivers/firmware/efi/rci2-table.c
index 3e290f9..76b0c35 100644
--- a/drivers/firmware/efi/rci2-table.c
+++ b/drivers/firmware/efi/rci2-table.c
@@ -76,7 +76,7 @@ static u16 checksum(void)
 	return chksum;
 }
 
-int __init efi_rci2_sysfs_init(void)
+static int __init efi_rci2_sysfs_init(void)
 {
 	struct kobject *tables_kobj;
 	int ret = -ENOMEM;
