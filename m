Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC121B7636
	for <lists+linux-efi@lfdr.de>; Fri, 24 Apr 2020 15:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgDXNGU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Apr 2020 09:06:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727832AbgDXNGT (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 24 Apr 2020 09:06:19 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F99C2087E;
        Fri, 24 Apr 2020 13:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587733579;
        bh=iIYZ6y+8fIMshb4sAwXsJgosnrRrQjMp48lwhrvqprE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mdymKzWHqFLfvy3tgc2lHOEMQSRrdacLw6CiymKLvF3tQI26m90j+KKpyV2eRiqPB
         1gHRzAmUaV/yczHEPLYdixZA7V4WKgXgk51QzhgUXFzLNzS/wbgX+9YtceulekgseM
         3/Q/DvwI6oJQs76/HlfGyi2sOH7vZKlofwO4USf4=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH 03/33] efi/libstub: Unify EFI call wrappers for non-x86
Date:   Fri, 24 Apr 2020 15:05:01 +0200
Message-Id: <20200424130531.30518-4-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200424130531.30518-1-ardb@kernel.org>
References: <20200424130531.30518-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

We have wrappers around EFI calls so that x86 can define special
versions for mixed mode, while all other architectures can use the
same simple definition that just issues the call directly.
In preparation for the arrival of yet another architecture that doesn't
need anything special here (RISC-V), let's move the default definition
into a shared header.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/include/asm/efi.h             |  8 --------
 arch/arm64/include/asm/efi.h           |  8 --------
 drivers/firmware/efi/libstub/efistub.h | 16 ++++++++++++++++
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
index 5ac46e2860bc..9383f236e795 100644
--- a/arch/arm/include/asm/efi.h
+++ b/arch/arm/include/asm/efi.h
@@ -50,14 +50,6 @@ void efi_virtmap_unload(void);
 
 /* arch specific definitions used by the stub code */
 
-#define efi_bs_call(func, ...)	efi_system_table()->boottime->func(__VA_ARGS__)
-#define efi_rt_call(func, ...)	efi_system_table()->runtime->func(__VA_ARGS__)
-#define efi_is_native()		(true)
-
-#define efi_table_attr(inst, attr)	(inst->attr)
-
-#define efi_call_proto(inst, func, ...) inst->func(inst, ##__VA_ARGS__)
-
 struct screen_info *alloc_screen_info(void);
 void free_screen_info(struct screen_info *si);
 
diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 45e821222774..d4ab3f73e7a3 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -86,14 +86,6 @@ static inline unsigned long efi_get_max_initrd_addr(unsigned long dram_base,
 	return (image_addr & ~(SZ_1G - 1UL)) + (1UL << (VA_BITS_MIN - 1));
 }
 
-#define efi_bs_call(func, ...)	efi_system_table()->boottime->func(__VA_ARGS__)
-#define efi_rt_call(func, ...)	efi_system_table()->runtime->func(__VA_ARGS__)
-#define efi_is_native()		(true)
-
-#define efi_table_attr(inst, attr)	(inst->attr)
-
-#define efi_call_proto(inst, func, ...) inst->func(inst, ##__VA_ARGS__)
-
 #define alloc_screen_info(x...)		&screen_info
 
 static inline void free_screen_info(struct screen_info *si)
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 7517683b31e9..d9ad8582dbea 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -39,6 +39,22 @@ extern bool __pure novamap(void);
 
 extern __pure efi_system_table_t  *efi_system_table(void);
 
+#ifndef efi_bs_call
+#define efi_bs_call(func, ...)	efi_system_table()->boottime->func(__VA_ARGS__)
+#endif
+#ifndef efi_rt_call
+#define efi_rt_call(func, ...)	efi_system_table()->runtime->func(__VA_ARGS__)
+#endif
+#ifndef efi_is_native
+#define efi_is_native()		(true)
+#endif
+#ifndef efi_table_attr
+#define efi_table_attr(inst, attr)	(inst->attr)
+#endif
+#ifndef efi_call_proto
+#define efi_call_proto(inst, func, ...) inst->func(inst, ##__VA_ARGS__)
+#endif
+
 #define pr_efi(msg)		do {			\
 	if (!is_quiet()) efi_printk("EFI stub: "msg);	\
 } while (0)
-- 
2.17.1

