Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18AE812D43C
	for <lists+linux-efi@lfdr.de>; Mon, 30 Dec 2019 21:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfL3UAO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 30 Dec 2019 15:00:14 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44287 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727680AbfL3UAO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 30 Dec 2019 15:00:14 -0500
Received: by mail-qk1-f193.google.com with SMTP id w127so26988182qkb.11
        for <linux-efi@vger.kernel.org>; Mon, 30 Dec 2019 12:00:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JrhY9woIaTkGOL2rgrk093k4KuJtcE/LflbaJEnb+no=;
        b=NGwhDCNS0w9m5QnI8ckxuzBDZi4Z3AYSn6bvMVnW4WLDDBLrfV2tJm2+3j/+Qo+mgc
         /F71KhPj/uIHLJ1oQ7JVj0407Dd7DB0QsTsq4k40Wycqbo4CYEmkNAHGAio8PbSRPbjO
         4nOvDRLU/j7muMHM4bI0o2p0b5ZczKLxfdjvR0G6OP4YS6Pdz3TlgdYV9rjindM5bimp
         G2hK9mOvLZzEKYeI+mt+4dvzMw8jZ0ovYNYZoISHel05BMrMpy9y7csHJZV8xUPLWrII
         1L2UDdBnnb/m7SdjaScoSaLI/RkIPHsPRZXcm1bYhPj9M55YStOdWu2Au9lEKvIfHkck
         R/SA==
X-Gm-Message-State: APjAAAVcbbA8n4e3lUvBxvI9XEYoHUVSo+8HnU9+nUlV5AHzixZLPD3i
        DHpalUt6wocvOWy57OaL9nKlWZ62
X-Google-Smtp-Source: APXvYqwVgvbbSG6CqpiJEje4sXRU2JSahbGWKEQ5wxvFE1teMhTzHF3H6Ed8JtldeYJIkJH/xQNi3A==
X-Received: by 2002:a37:6706:: with SMTP id b6mr53285241qkc.461.1577736013139;
        Mon, 30 Dec 2019 12:00:13 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id z141sm12701168qkb.63.2019.12.30.12.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 12:00:12 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [RFC PATCH 2/2] efi/x86: Allow translating 64-bit arguments for mixed mode calls
Date:   Mon, 30 Dec 2019 15:00:11 -0500
Message-Id: <20191230200011.2589934-2-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191230200011.2589934-1-nivedita@alum.mit.edu>
References: <20191230200011.2589934-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When an EFI call takes 64-bit arguments, the mixed-mode call must push
the two 32-bit halves as separate arguments onto the stack.

Introduce the ability to define macros to perform this translation for
the calls that need it, and use it for free_pages.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/eboot.c              | 17 ------------
 arch/x86/include/asm/efi.h                    | 27 +++++++++++++++----
 .../firmware/efi/libstub/efi-stub-helper.c    |  5 +---
 3 files changed, 23 insertions(+), 26 deletions(-)

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
index c9800802894f..5f70499803a1 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -258,22 +258,39 @@ static inline bool efi_is_native(void)
 		: (__typeof__(inst->attr))				\
 			efi_mixed_mode_cast(inst->mixed_mode.attr))
 
+#define __efi64_thunk(inst, func, ...)					\
+	efi64_thunk(inst->mixed_mode.func,				\
+		__efi64_argmap(__efi64_argmap_ ## func, __VA_ARGS__))
+
+#define __efi64_argmap(map, ...)					\
+	__PASTE(__efi64_argmap__,					\
+		__efi64_argmap_def_p(map(__VA_ARGS__)))(map, __VA_ARGS__)
+
+#define __efi64_argmap__undef(map, ...) __VA_ARGS__
+#define __efi64_argmap__def(map, ...) map(__VA_ARGS__)
+
+#define __efi64_argmap_def_p(...)					\
+	__efi64_argmap_def_p_(__VA_ARGS__, __efi_arg_sentinel(undef))
+#define __efi64_argmap_def_p_(_0, n, ...) __take_second_arg(n, def)
+
 #define efi_call_proto(inst, func, ...)					\
 	(efi_is_native()						\
 		? inst->func(inst, ##__VA_ARGS__)			\
-		: efi64_thunk(inst->mixed_mode.func, inst, ##__VA_ARGS__))
+		: __efi64_thunk(inst, func, inst, ##__VA_ARGS__))
 
 #define efi_bs_call(func, ...)						\
 	(efi_is_native()						\
 		? efi_system_table()->boottime->func(__VA_ARGS__)	\
-		: efi64_thunk(efi_table_attr(efi_system_table(),	\
-				boottime)->mixed_mode.func, __VA_ARGS__))
+		: __efi64_thunk(efi_table_attr(efi_system_table(),	\
+				boottime), func, __VA_ARGS__))
 
 #define efi_rt_call(func, ...)						\
 	(efi_is_native()						\
 		? efi_system_table()->runtime->func(__VA_ARGS__)	\
-		: efi64_thunk(efi_table_attr(efi_system_table(),	\
-				runtime)->mixed_mode.func, __VA_ARGS__))
+		: __efi64_thunk(efi_table_attr(efi_system_table(),	\
+				runtime), func, __VA_ARGS__))
+
+#define __efi64_argmap_free_pages(addr, size) (addr), 0, (size)
 
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

