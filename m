Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1203012DC31
	for <lists+linux-efi@lfdr.de>; Tue, 31 Dec 2019 23:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfLaWr7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Dec 2019 17:47:59 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:35100 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbfLaWr6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Dec 2019 17:47:58 -0500
Received: by mail-qv1-f65.google.com with SMTP id u10so13704311qvi.2
        for <linux-efi@vger.kernel.org>; Tue, 31 Dec 2019 14:47:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fdMNPwBqWxRAmxwkQZx8IOhqMeTfhFKEE23k1B9GzsQ=;
        b=o9u7oXcVWugKwU+l5uPC136tsIO+6ShBJe3ewkk29Mf4D34yp9DiS2RTqcf9vRSD0u
         n03H9X+ssH8MNY38D9HZV2vFmzsLH+fyBNnyZaG72UAJNEhz74+yY1vjtuMNYu07YgTT
         8VPhfCuLj36mAHQPzsWMl9Ta8XMKXA+xpfTon42yAwmzDssIU8910j78VnY0NRDj8XJp
         vfSZQAQQjGej+RXbF88ebcAwgxIlMpDu5cANIG6ZUPwobJ6nsHrB+J/PecoaMlm1mEw9
         FM1gpiq2GFoD0qxuBnrRc1jmXoJ5Dhw/h3SGv/JBewJ3ln5IUtU92BLP6mjXU6hGD07D
         Wegg==
X-Gm-Message-State: APjAAAVfnQc4zp7Sq7DwQj5kEpsXCtRm/lQzisA7LL2nYyWXbpNovfwe
        OR3Zru1U2usJS0FiNzn5s2NJxwqH
X-Google-Smtp-Source: APXvYqxWsAJpiKrvI24DRt37oj2kBZZwZxnkela/RCx7un/CctApLe02Nl/dUCBaNYq9VnP8BTE1HA==
X-Received: by 2002:a05:6214:13a8:: with SMTP id h8mr55202544qvz.41.1577832477351;
        Tue, 31 Dec 2019 14:47:57 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o7sm13746085qkd.119.2019.12.31.14.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 14:47:57 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [PATCH 2/2] efi/x86: Allow translating 64-bit arguments for mixed mode calls
Date:   Tue, 31 Dec 2019 17:47:55 -0500
Message-Id: <20191231224755.77310-2-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191231224755.77310-1-nivedita@alum.mit.edu>
References: <CAKv+Gu_7KxS2--Zy7vky7zZ4bQchLJ6Vv+kceKDwjAvYVeXL9A@mail.gmail.com>
 <20191231224755.77310-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

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
---
 arch/x86/boot/compressed/eboot.c              | 17 -----
 arch/x86/include/asm/efi.h                    | 71 +++++++++++++++++--
 .../firmware/efi/libstub/efi-stub-helper.c    |  5 +-
 3 files changed, 67 insertions(+), 26 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 98477f3529f6..4884483ec093 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -889,20 +889,3 @@ struct boot_params *efi_main(efi_handle_t handle,
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
-		efi64_thunk(efi_table_attr(efi_system_table(),
-					   boottime)->mixed_mode.free_pages,
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
2.24.1

