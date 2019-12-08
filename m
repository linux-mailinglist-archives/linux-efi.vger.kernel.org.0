Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 148841161A1
	for <lists+linux-efi@lfdr.de>; Sun,  8 Dec 2019 14:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfLHNdu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 8 Dec 2019 08:33:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36601 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfLHNdu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 8 Dec 2019 08:33:50 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1idwgo-0007gP-F3; Sun, 08 Dec 2019 14:33:34 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id ED5F21C2881;
        Sun,  8 Dec 2019 14:33:33 +0100 (CET)
Date:   Sun, 08 Dec 2019 13:33:33 -0000
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/gop: Return EFI_SUCCESS if a usable GOP was found
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191206165542.31469-4-ardb@kernel.org>
References: <20191206165542.31469-4-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <157581201386.21853.1924891590520317702.tip-bot2@tip-bot2>
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

Commit-ID:     dbd89c303b4420f6cdb689fd398349fc83b059dd
Gitweb:        https://git.kernel.org/tip/dbd89c303b4420f6cdb689fd398349fc83b059dd
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Fri, 06 Dec 2019 16:55:39 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 08 Dec 2019 12:42:18 +01:00

efi/gop: Return EFI_SUCCESS if a usable GOP was found

If we've found a usable instance of the Graphics Output Protocol
(GOP) with a framebuffer, it is possible that one of the later EFI
calls fails while checking if any support console output. In this
case status may be an EFI error code even though we found a usable
GOP.

Fix this by explicitly return EFI_SUCCESS if a usable GOP has been
located.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Cc: linux-efi@vger.kernel.org
Link: https://lkml.kernel.org/r/20191206165542.31469-4-ardb@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/libstub/gop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index 08f3c1a..69b2b01 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -198,7 +198,7 @@ setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
 
 	si->capabilities |= VIDEO_CAPABILITY_SKIP_QUIRKS;
 
-	return status;
+	return EFI_SUCCESS;
 }
 
 static efi_status_t
@@ -316,7 +316,7 @@ setup_gop64(efi_system_table_t *sys_table_arg, struct screen_info *si,
 
 	si->capabilities |= VIDEO_CAPABILITY_SKIP_QUIRKS;
 
-	return status;
+	return EFI_SUCCESS;
 }
 
 /*
