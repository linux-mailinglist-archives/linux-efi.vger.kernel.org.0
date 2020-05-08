Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD98B1CB693
	for <lists+linux-efi@lfdr.de>; Fri,  8 May 2020 20:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgEHSCx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 May 2020 14:02:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728025AbgEHSCw (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 May 2020 14:02:52 -0400
Received: from e123331-lin.nice.arm.com (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC95624954;
        Fri,  8 May 2020 18:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588960972;
        bh=cy0V4lbi7zDsWS5x9DClkcbqGwBIYKZEuTAbd1OIDjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P+hLRZUFTbB4uFWZe8W30e+YZrzPx19vd8lF3lwHs7ucirq+tAYNfvxXk7GGmB+LA
         Tp8Z3dII1VHWvDP6jwt2Cezqm86N0ur0mocRGbyIrHwBDZUE3SJRGYdT+sSYkqsoVk
         1TGTuEXYPRVWbEPNKup2qFuQTEVCoZr67VYh+j0Q=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Guenter Roeck <linux@roeck-us.net>,
        Joe Perches <joe@perches.com>
Subject: [PATCH 12/15] efi/libstub: Fix mixed mode boot issue after macro refactor
Date:   Fri,  8 May 2020 20:01:54 +0200
Message-Id: <20200508180157.1816-13-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508180157.1816-1-ardb@kernel.org>
References: <20200508180157.1816-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

Commit

  22090f84bc3f ("efi/libstub: unify EFI call wrappers for non-x86")

refactored the macros that are used to provide wrappers for mixed-mode
calls on x86, allowing us to boot a 64-bit kernel on 32-bit firmware.

Unfortunately, this broke mixed mode boot due to the fact that
efi_is_native() is not a macro on x86.

All of these macros should go together, so rather than testing each one
to see if it is defined, condition the generic macro definitions on a
new ARCH_HAS_EFISTUB_WRAPPERS, and remove the wrapper definitions on x86
as well if CONFIG_EFI_MIXED is not enabled.

Fixes: 22090f84bc3f ("efi/libstub: unify EFI call wrappers for non-x86")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://lore.kernel.org/r/20200504150248.62482-1-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/efi.h             | 19 +++++++++++++++----
 drivers/firmware/efi/libstub/efistub.h | 14 ++++----------
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index cd0c3fbf6156..6b9ab0d8b2a7 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -225,13 +225,15 @@ efi_status_t efi_set_virtual_address_map(unsigned long memory_map_size,
 
 /* arch specific definitions used by the stub code */
 
-extern const bool efi_is64;
+#ifdef CONFIG_EFI_MIXED
+
+#define ARCH_HAS_EFISTUB_WRAPPERS
 
 static inline bool efi_is_64bit(void)
 {
-	if (IS_ENABLED(CONFIG_EFI_MIXED))
-		return efi_is64;
-	return IS_ENABLED(CONFIG_X86_64);
+	extern const bool efi_is64;
+
+	return efi_is64;
 }
 
 static inline bool efi_is_native(void)
@@ -356,6 +358,15 @@ static inline u32 efi64_convert_status(efi_status_t status)
 						   runtime),		\
 				    func, __VA_ARGS__))
 
+#else /* CONFIG_EFI_MIXED */
+
+static inline bool efi_is_64bit(void)
+{
+	return IS_ENABLED(CONFIG_X86_64);
+}
+
+#endif /* CONFIG_EFI_MIXED */
+
 extern bool efi_reboot_required(void);
 extern bool efi_is_table_address(unsigned long phys_addr);
 
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 874233cf8820..4f10a09563f3 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -33,20 +33,14 @@ extern bool efi_novamap;
 
 extern const efi_system_table_t *efi_system_table;
 
-#ifndef efi_bs_call
+#ifndef ARCH_HAS_EFISTUB_WRAPPERS
+
+#define efi_is_native()		(true)
 #define efi_bs_call(func, ...)	efi_system_table->boottime->func(__VA_ARGS__)
-#endif
-#ifndef efi_rt_call
 #define efi_rt_call(func, ...)	efi_system_table->runtime->func(__VA_ARGS__)
-#endif
-#ifndef efi_is_native
-#define efi_is_native()		(true)
-#endif
-#ifndef efi_table_attr
 #define efi_table_attr(inst, attr)	(inst->attr)
-#endif
-#ifndef efi_call_proto
 #define efi_call_proto(inst, func, ...) inst->func(inst, ##__VA_ARGS__)
+
 #endif
 
 #define efi_info(msg)		do {			\
-- 
2.17.1

