Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17178EAF47
	for <lists+linux-efi@lfdr.de>; Thu, 31 Oct 2019 12:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfJaLzh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 31 Oct 2019 07:55:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55508 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbfJaLzg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 31 Oct 2019 07:55:36 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iQ933-0003CN-4R; Thu, 31 Oct 2019 12:55:29 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id AF3F01C04F3;
        Thu, 31 Oct 2019 12:55:15 +0100 (CET)
Date:   Thu, 31 Oct 2019 11:55:15 -0000
From:   "tip-bot2 for Narendra K" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi: Make CONFIG_EFI_RCI2_TABLE selectable on x86 only
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Narendra K <Narendra.K@dell.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20191029173755.27149-2-ardb@kernel.org>
References: <20191029173755.27149-2-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <157252291543.29376.8913809191549096088.tip-bot2@tip-bot2>
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

Commit-ID:     0b6b30c65621fc11a799ca71241f52d8fd9e334c
Gitweb:        https://git.kernel.org/tip/0b6b30c65621fc11a799ca71241f52d8fd9e334c
Author:        Narendra K <Narendra.K@dell.com>
AuthorDate:    Tue, 29 Oct 2019 18:37:50 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 31 Oct 2019 09:40:16 +01:00

efi: Make CONFIG_EFI_RCI2_TABLE selectable on x86 only

For the EFI_RCI2_TABLE Kconfig option, 'make oldconfig' asks the user
for input on platforms where the option may not be applicable. This patch
modifies the Kconfig option to ask the user for input only when CONFIG_X86
or CONFIG_COMPILE_TEST is set to y.

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Narendra K <Narendra.K@dell.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: https://lkml.kernel.org/r/20191029173755.27149-2-ardb@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 178ee81..b248870 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -182,6 +182,7 @@ config RESET_ATTACK_MITIGATION
 
 config EFI_RCI2_TABLE
 	bool "EFI Runtime Configuration Interface Table Version 2 Support"
+	depends on X86 || COMPILE_TEST
 	help
 	  Displays the content of the Runtime Configuration Interface
 	  Table version 2 on Dell EMC PowerEdge systems as a binary
