Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8053124EBA
	for <lists+linux-efi@lfdr.de>; Wed, 18 Dec 2019 18:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfLRRDY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Dec 2019 12:03:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:53950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727697AbfLRRDY (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 18 Dec 2019 12:03:24 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 359392176D;
        Wed, 18 Dec 2019 17:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576688604;
        bh=gkcmrrMgd2uBQPQcT63K/3R04IKfdK4A6T0qrHhlYso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oMbnoJi/bOKBI2u+0rK43KdfWzlkJEicmB+8fSVVJjtGZIQmyxLhdQO5Wan4UUN6a
         NtcBNnrBmNOL8QjxWUSiEleWPn1xtN2+He+SrKrhTEpK3wKUu4Y6RMMir18NKV44oq
         1heDoO3Ym54VD6TFP+pqUwXrSlIxr+wVez3Bv9DU=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH v2 18/21] efi/libstub: use 'func' not 'f' as macro parameter
Date:   Wed, 18 Dec 2019 19:01:36 +0200
Message-Id: <20191218170139.9468-19-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191218170139.9468-1-ardb@kernel.org>
References: <20191218170139.9468-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Use 'func' as the macro parameter name for the efi_call() macros
which is less likely to collide and cause weird build errors.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/efi.h |  4 ++--
 arch/x86/include/asm/efi.h   | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 6f041ae446d2..d06305590ac5 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -93,8 +93,8 @@ static inline unsigned long efi_get_max_initrd_addr(unsigned long dram_base,
 	return (image_addr & ~(SZ_1G - 1UL)) + (1UL << (VA_BITS_MIN - 1));
 }
 
-#define efi_call_early(f, ...)		efi_system_table()->boottime->f(__VA_ARGS__)
-#define efi_call_runtime(f, ...)	efi_system_table()->runtime->f(__VA_ARGS__)
+#define efi_call_early(func, ...)	efi_system_table()->boottime->func(__VA_ARGS__)
+#define efi_call_runtime(func, ...)	efi_system_table()->runtime->func(__VA_ARGS__)
 #define efi_is_native()			(true)
 
 #define efi_table_attr(inst, attr)	(inst->attr)
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 593a8cda8361..ba3f8a98e156 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -236,17 +236,17 @@ static inline bool efi_is_native(void)
 		? inst->func(inst, ##__VA_ARGS__)			\
 		: efi64_thunk(inst->mixed_mode.func, inst, ##__VA_ARGS__))
 
-#define efi_call_early(f, ...)						\
+#define efi_call_early(func, ...)					\
 	(efi_is_native()						\
-		? efi_system_table()->boottime->f(__VA_ARGS__)		\
+		? efi_system_table()->boottime->func(__VA_ARGS__)	\
 		: efi64_thunk(efi_table_attr(efi_system_table(),	\
-				boottime)->mixed_mode.f, __VA_ARGS__))
+				boottime)->mixed_mode.func, __VA_ARGS__))
 
-#define efi_call_runtime(f, ...)					\
+#define efi_call_runtime(func, ...)					\
 	(efi_is_native()						\
-		? efi_system_table()->runtime->f(__VA_ARGS__)		\
+		? efi_system_table()->runtime->func(__VA_ARGS__)	\
 		: efi64_thunk(efi_table_attr(efi_system_table(),	\
-				runtime)->mixed_mode.f, __VA_ARGS__))
+				runtime)->mixed_mode.func, __VA_ARGS__))
 
 extern bool efi_reboot_required(void);
 extern bool efi_is_table_address(unsigned long phys_addr);
-- 
2.17.1

