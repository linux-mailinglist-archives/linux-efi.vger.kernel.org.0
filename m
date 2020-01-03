Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5F6A12F77E
	for <lists+linux-efi@lfdr.de>; Fri,  3 Jan 2020 12:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgACLku (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Jan 2020 06:40:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:40644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727876AbgACLku (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 3 Jan 2020 06:40:50 -0500
Received: from localhost.localdomain (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5758C2464E;
        Fri,  3 Jan 2020 11:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578051649;
        bh=WzvkVJw16gcw6hemFqW6TdkXxe+wQNU4zcPETDM7LaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dZ2yUKhucLq1wHv0KO4hMuVe57X/etT+PrLRVUWI0WxTrLidCBlzzNe6FhIScy9Nd
         AwjdNjldZQenDB1Qc8e6M7B3CrJQwFCzAbZUMzbwAxJ9yZNkQLUnTPoNsg+PftJ9xu
         hldK26SVZmmS+rjzpNMo+CoLnBhAxWc/hZLFB++4=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Matthew Garrett <mjg59@google.com>
Subject: [PATCH 16/20] efi/x86: Allow translating 64-bit arguments for mixed mode calls
Date:   Fri,  3 Jan 2020 12:39:49 +0100
Message-Id: <20200103113953.9571-17-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200103113953.9571-1-ardb@kernel.org>
References: <20200103113953.9571-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

Introduce the ability to define macros to perform argument translation
for the calls that need it, and define them for the boot services that
we currently use.

When calling 32-bit firmware methods in mixed mode, all output
parameters that are 32-bit according to the firmware, but 64-bit in the
kernel (ie OUT UINTN * or OUT VOID **) must be initialized in the
kernel, or the upper 32 bits may contain garbage. Define macros that
zero out the upper 32 bits of the output before invoking the firmware
method.

When a 32-bit EFI call takes 64-bit arguments, the mixed-mode call must
push the two 32-bit halves as separate arguments onto the stack. This
can be achieved by splitting the argument into its two halves when
calling the assembler thunk. Define a macro to do this for the
free_pages boot service.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/eboot.c              | 16 -----
 arch/x86/include/asm/efi.h                    | 71 +++++++++++++++++--
 .../firmware/efi/libstub/efi-stub-helper.c    |  5 +-
 3 files changed, 67 insertions(+), 25 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 565ee4733579..4afd29eb5b34 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -891,19 +891,3 @@ struct boot_params *efi_main(efi_handle_t handle,
 	for (;;)
 		asm("hlt");
 }
-
-#ifdef CONFIG_EFI_MIXED
-void efi_free_native(unsigned long size, unsigned long addr);
-
-void efi_free(unsigned long size, unsigned long addr)
-{
-	if (!size)
-		return;
-
-	if (efi_is_native())
-		efi_free_native(size, addr);
-	else
-		efi64_thunk(efi_system_table()->boottime->mixed_mode.free_pages,
-			    addr, 0, DIV_ROUND_UP(size, EFI_PAGE_SIZE));
-}
-#endif
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index cfc450085584..166f0386719e 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -243,22 +243,83 @@ static inline bool efi_is_native(void)
 		: (__typeof__(inst->attr))				\
 			efi_mixed_mode_cast(inst->mixed_mode.attr))
 
+/*
+ * The following macros allow translating arguments if necessary from native to
+ * mixed mode. The use case for this is to initialize the upper 32 bits of
+ * output parameters, and where the 32-bit method requires a 64-bit argument,
+ * which must be split up into two arguments to be thunked properly.
+ *
+ * As examples, the AllocatePool boot service returns the address of the
+ * allocation, but it will not set the high 32 bits of the address. To ensure
+ * that the full 64-bit address is initialized, we zero-init the address before
+ * calling the thunk.
+ *
+ * The FreePages boot service takes a 64-bit physical address even in 32-bit
+ * mode. For the thunk to work correctly, a native 64-bit call of
+ * 	free_pages(addr, size)
+ * must be translated to
+ * 	efi64_thunk(free_pages, addr & U32_MAX, addr >> 32, size)
+ * so that the two 32-bit halves of addr get pushed onto the stack separately.
+ */
+
+static inline void *efi64_zero_upper(void *p)
+{
+	((u32 *)p)[1] = 0;
+	return p;
+}
+
+#define __efi64_argmap_free_pages(addr, size)				\
+	((addr), 0, (size))
+
+#define __efi64_argmap_get_memory_map(mm_size, mm, key, size, ver)	\
+	((mm_size), (mm), efi64_zero_upper(key), efi64_zero_upper(size), (ver))
+
+#define __efi64_argmap_allocate_pool(type, size, buffer)		\
+	((type), (size), efi64_zero_upper(buffer))
+
+#define __efi64_argmap_handle_protocol(handle, protocol, interface)	\
+	((handle), (protocol), efi64_zero_upper(interface))
+
+#define __efi64_argmap_locate_protocol(protocol, reg, interface)	\
+	((protocol), (reg), efi64_zero_upper(interface))
+
+/*
+ * The macros below handle the plumbing for the argument mapping. To add a
+ * mapping for a specific EFI method, simply define a macro
+ * __efi64_argmap_<method name>, following the examples above.
+ */
+
+#define __efi64_thunk_map(inst, func, ...)				\
+	efi64_thunk(inst->mixed_mode.func,				\
+		__efi64_argmap(__efi64_argmap_ ## func(__VA_ARGS__),	\
+			       (__VA_ARGS__)))
+
+#define __efi64_argmap(mapped, args)					\
+	__PASTE(__efi64_argmap__, __efi_nargs(__efi_eat mapped))(mapped, args)
+#define __efi64_argmap__0(mapped, args) __efi_eval mapped
+#define __efi64_argmap__1(mapped, args) __efi_eval args
+
+#define __efi_eat(...)
+#define __efi_eval(...) __VA_ARGS__
+
+/* The three macros below handle dispatching via the thunk if needed */
+
 #define efi_call_proto(inst, func, ...)					\
 	(efi_is_native()						\
 		? inst->func(inst, ##__VA_ARGS__)			\
-		: efi64_thunk(inst->mixed_mode.func, inst, ##__VA_ARGS__))
+		: __efi64_thunk_map(inst, func, inst, ##__VA_ARGS__))
 
 #define efi_bs_call(func, ...)						\
 	(efi_is_native()						\
 		? efi_system_table()->boottime->func(__VA_ARGS__)	\
-		: efi64_thunk(efi_table_attr(efi_system_table(),	\
-				boottime)->mixed_mode.func, __VA_ARGS__))
+		: __efi64_thunk_map(efi_table_attr(efi_system_table(),	\
+				boottime), func, __VA_ARGS__))
 
 #define efi_rt_call(func, ...)						\
 	(efi_is_native()						\
 		? efi_system_table()->runtime->func(__VA_ARGS__)	\
-		: efi64_thunk(efi_table_attr(efi_system_table(),	\
-				runtime)->mixed_mode.func, __VA_ARGS__))
+		: __efi64_thunk_map(efi_table_attr(efi_system_table(),	\
+				runtime), func, __VA_ARGS__))
 
 extern bool efi_reboot_required(void);
 extern bool efi_is_table_address(unsigned long phys_addr);
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index f1b9c36934e9..fcc45ee94e02 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -344,9 +344,6 @@ efi_status_t efi_low_alloc_above(unsigned long size, unsigned long align,
 }
 
 void efi_free(unsigned long size, unsigned long addr)
-	__weak __alias(efi_free_native);
-
-void efi_free_native(unsigned long size, unsigned long addr)
 {
 	unsigned long nr_pages;
 
@@ -354,7 +351,7 @@ void efi_free_native(unsigned long size, unsigned long addr)
 		return;
 
 	nr_pages = round_up(size, EFI_ALLOC_ALIGN) / EFI_PAGE_SIZE;
-	efi_system_table()->boottime->free_pages(addr, nr_pages);
+	efi_bs_call(free_pages, addr, nr_pages);
 }
 
 static efi_status_t efi_file_size(void *__fh, efi_char16_t *filename_16,
-- 
2.20.1

