Return-Path: <linux-efi+bounces-3262-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A37A8453C
	for <lists+linux-efi@lfdr.de>; Thu, 10 Apr 2025 15:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABDDA3BCD4A
	for <lists+linux-efi@lfdr.de>; Thu, 10 Apr 2025 13:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FCC28C5B4;
	Thu, 10 Apr 2025 13:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r3zs9AdX"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2206228A40B
	for <linux-efi@vger.kernel.org>; Thu, 10 Apr 2025 13:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744292508; cv=none; b=TZ0yHoRsrOPWojMgsEVNUEIk23TI02uWcW4JJTPVCRrYVQUk15HRJI+3/ZqciLCWKj6JMZCvEYv4U6RYTZBewFEkVWnEo06WVDFKdLsEhCXYKOm24b9Gb6GpO/yqCwVt9U1Htl1VKz3w01W/gnTO99uw301vTNps4QhrO9F3bJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744292508; c=relaxed/simple;
	bh=Z9KU8XxKRScSaHvY2ha9sFr5gN/G6+Xwd8QUfPi9AL0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fG0bpjuf3/OlsxXwDzUaJRxbGIPcL+7ClKpD7QxHZTL8nH18gFlLoUD33gN71Yxlcfm47ZztrNKhdUZN3X14AuTav73+fWaqee7CyuAB3StGGNkXaL4RPn9vxF2dwbZFAOyx4qoveKmM9SdNK3VxC2+DbbxcuAjHsHhah4Ffot4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r3zs9AdX; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3912fc9861cso293365f8f.1
        for <linux-efi@vger.kernel.org>; Thu, 10 Apr 2025 06:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744292504; x=1744897304; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KF3wFyMqFk5OCzQRT3cGNIX8apAV8WuLNqnG519UiK0=;
        b=r3zs9AdX9GsxZMrMhPTPY310M0AOzU1c38MEYgWmYRVOojYRMT2dj5qMTegbXrzA20
         /zMD7KuYbhQ+3tVMoViJRLh2hsegzi33c+RIn34hFF/LZPy3j80PYlI1nKZcxSj5O+wP
         oGyyMpvpkPREy8KeNDD0KG/h5Ts+KUtxt5nbKHG2R60pMq1mViqFgis7x33p65FhXsWU
         8WC5ePFxK4BiU2uesNvxRQvEmdIbxC28PraSEAV7Df7iePMPLPxGZpr3BV5MUCXIKtts
         Kc/BHPsFr0aOmenhOMcC1XC9To2xIo3ErJa0xlk5ATmleXSMoksq1kEKedYAe/kllLcL
         ehNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744292504; x=1744897304;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KF3wFyMqFk5OCzQRT3cGNIX8apAV8WuLNqnG519UiK0=;
        b=ltwZxiCmRb+QkWf2FvGGqKdD2s+xUo4ZFx0Wp6+858JOeNIL57KtP34CsF7i1uOAso
         uI9qR4mMPvI87jRKdTbgz6z8urucEF3WWhXd+wP9Y3CpTtlO9f/RMgzSMad62wy7rVku
         8vWCZci1fCHDMPDqkP82bEbpvij+0t9fYVHGAySXwCao5j3JlGUyL6cXd3lC1h781VL2
         vbrUjNMnFuC0UIJc2faPKaFxs73B57QXomEmFTxCyuNdvdxVDcATiq/++l7vndMthOJf
         FtVZBuldXlyvC7T3tNaCtT+Vaq3bl+LjMaobB5rX9m6aBcOA5u7Y9GSezvyYFRL9Znoz
         lhHQ==
X-Gm-Message-State: AOJu0Yw/i+eDbxK73EEhwEGDCWp5db0HK/K7eCk0mfLiFqW2jZjLpP33
	3x+tNbXpTSL6KoOWaTlCIy49kO+YYT/mpZl5hdova5exbGDWJkdaIr8QoD1nGJ9g+u7yzho9r3Z
	ujb4t24WwFcfC0VcHoRCm0o/+yuCp4XJtocm7i2rJAVyueKm49ui1j0gZYpo2UUjzhWUCEIsDbe
	Fs1De5XUp3Kk/mPTwg4UarEun4Ng==
X-Google-Smtp-Source: AGHT+IGLJ1g9qWYFRLbvfayzPkGURQoNtuE64AN7e/FtM9+0Wx8poeCQDn7dHo9mhHcAXpCVHE9fI77j
X-Received: from wmbh17.prod.google.com ([2002:a05:600c:a111:b0:43d:1c11:4e5d])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:5f4f:0:b0:390:eebc:6f32
 with SMTP id ffacd0b85a97d-39d8fda7660mr2385734f8f.48.1744292504422; Thu, 10
 Apr 2025 06:41:44 -0700 (PDT)
Date: Thu, 10 Apr 2025 15:41:20 +0200
In-Reply-To: <20250410134117.3713574-13-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250410134117.3713574-13-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=7814; i=ardb@kernel.org;
 h=from:subject; bh=9hD4nc9XUYWvD6V2ufz0yp8+oHtK4mbTifqG6gyUMrw=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf37qcZJmX2CITdv/wrNT9sSPzNXhEtxS07kzGu3+iIl+
 uIXcMd2lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIl8zmJkeGe789WWFUf7Txne
 u32yVehgyC7v5ZqCu9J+nJ0X8GFWRxjD/2D5NIuPG4y2r13ueFaxcsfH18q64jlvVJR3MR1jqTH pYgcA
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250410134117.3713574-15-ardb+git@google.com>
Subject: [PATCH v4 02/11] x86/boot: Move the early GDT/IDT setup code into startup/
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: x86@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Move the early GDT/IDT setup code that runs long before the kernel
virtual mapping is up into arch/x86/boot/startup/, and build it in a way
that ensures that the code tolerates being called from the 1:1 mapping
of memory. The code itself is left unchanged by this patch.

Also tweak the sed symbol matching pattern in the decompressor to match
on lower case 't' or 'b', as these will be emitted by Clang for symbols
with hidden linkage.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/Makefile |  2 +-
 arch/x86/boot/startup/Makefile    | 15 ++++
 arch/x86/boot/startup/gdt_idt.c   | 84 ++++++++++++++++++++
 arch/x86/kernel/head64.c          | 74 -----------------
 4 files changed, 100 insertions(+), 75 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 37b85ce9b2a3..0fcad7b7e007 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -73,7 +73,7 @@ LDFLAGS_vmlinux += -T
 hostprogs	:= mkpiggy
 HOST_EXTRACFLAGS += -I$(srctree)/tools/include
 
-sed-voffset := -e 's/^\([0-9a-fA-F]*\) [ABCDGRSTVW] \(_text\|__start_rodata\|__bss_start\|_end\)$$/\#define VO_\2 _AC(0x\1,UL)/p'
+sed-voffset := -e 's/^\([0-9a-fA-F]*\) [ABbCDGRSTtVW] \(_text\|__start_rodata\|__bss_start\|_end\)$$/\#define VO_\2 _AC(0x\1,UL)/p'
 
 quiet_cmd_voffset = VOFFSET $@
       cmd_voffset = $(NM) $< | sed -n $(sed-voffset) > $@
diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index 8919a1cbcb5a..1beb5de30735 100644
--- a/arch/x86/boot/startup/Makefile
+++ b/arch/x86/boot/startup/Makefile
@@ -1,6 +1,21 @@
 # SPDX-License-Identifier: GPL-2.0
 
 KBUILD_AFLAGS		+= -D__DISABLE_EXPORTS
+KBUILD_CFLAGS		+= -D__DISABLE_EXPORTS -mcmodel=small -fPIC \
+			   -Os -DDISABLE_BRANCH_PROFILING \
+			   $(DISABLE_STACKLEAK_PLUGIN) \
+			   -fno-stack-protector -D__NO_FORTIFY \
+			   -include $(srctree)/include/linux/hidden.h
+
+# disable ftrace hooks
+KBUILD_CFLAGS	:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS))
+KASAN_SANITIZE	:= n
+KCSAN_SANITIZE	:= n
+KMSAN_SANITIZE	:= n
+UBSAN_SANITIZE	:= n
+KCOV_INSTRUMENT	:= n
+
+obj-$(CONFIG_X86_64)		+= gdt_idt.o
 
 lib-$(CONFIG_X86_64)		+= la57toggle.o
 lib-$(CONFIG_EFI_MIXED)		+= efi-mixed.o
diff --git a/arch/x86/boot/startup/gdt_idt.c b/arch/x86/boot/startup/gdt_idt.c
new file mode 100644
index 000000000000..7e34d0b426b1
--- /dev/null
+++ b/arch/x86/boot/startup/gdt_idt.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/linkage.h>
+#include <linux/types.h>
+
+#include <asm/desc.h>
+#include <asm/init.h>
+#include <asm/setup.h>
+#include <asm/sev.h>
+#include <asm/trapnr.h>
+
+/*
+ * Data structures and code used for IDT setup in head_64.S. The bringup-IDT is
+ * used until the idt_table takes over. On the boot CPU this happens in
+ * x86_64_start_kernel(), on secondary CPUs in start_secondary(). In both cases
+ * this happens in the functions called from head_64.S.
+ *
+ * The idt_table can't be used that early because all the code modifying it is
+ * in idt.c and can be instrumented by tracing or KASAN, which both don't work
+ * during early CPU bringup. Also the idt_table has the runtime vectors
+ * configured which require certain CPU state to be setup already (like TSS),
+ * which also hasn't happened yet in early CPU bringup.
+ */
+static gate_desc bringup_idt_table[NUM_EXCEPTION_VECTORS] __page_aligned_data;
+
+/* This may run while still in the direct mapping */
+static void __head startup_64_load_idt(void *vc_handler)
+{
+	struct desc_ptr desc = {
+		.address = (unsigned long)rip_rel_ptr(bringup_idt_table),
+		.size    = sizeof(bringup_idt_table) - 1,
+	};
+	struct idt_data data;
+	gate_desc idt_desc;
+
+	/* @vc_handler is set only for a VMM Communication Exception */
+	if (vc_handler) {
+		init_idt_data(&data, X86_TRAP_VC, vc_handler);
+		idt_init_desc(&idt_desc, &data);
+		native_write_idt_entry((gate_desc *)desc.address, X86_TRAP_VC, &idt_desc);
+	}
+
+	native_load_idt(&desc);
+}
+
+/* This is used when running on kernel addresses */
+void early_setup_idt(void)
+{
+	void *handler = NULL;
+
+	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
+		setup_ghcb();
+		handler = vc_boot_ghcb;
+	}
+
+	startup_64_load_idt(handler);
+}
+
+/*
+ * Setup boot CPU state needed before kernel switches to virtual addresses.
+ */
+void __head startup_64_setup_gdt_idt(void)
+{
+	struct gdt_page *gp = rip_rel_ptr((void *)(__force unsigned long)&gdt_page);
+	void *handler = NULL;
+
+	struct desc_ptr startup_gdt_descr = {
+		.address = (unsigned long)gp->gdt,
+		.size    = GDT_SIZE - 1,
+	};
+
+	/* Load GDT */
+	native_load_gdt(&startup_gdt_descr);
+
+	/* New GDT is live - reload data segment registers */
+	asm volatile("movl %%eax, %%ds\n"
+		     "movl %%eax, %%ss\n"
+		     "movl %%eax, %%es\n" : : "a"(__KERNEL_DS) : "memory");
+
+	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))
+		handler = rip_rel_ptr(vc_no_ghcb);
+
+	startup_64_load_idt(handler);
+}
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 954d093f187b..9b2ffec4bbad 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -512,77 +512,3 @@ void __init __noreturn x86_64_start_reservations(char *real_mode_data)
 
 	start_kernel();
 }
-
-/*
- * Data structures and code used for IDT setup in head_64.S. The bringup-IDT is
- * used until the idt_table takes over. On the boot CPU this happens in
- * x86_64_start_kernel(), on secondary CPUs in start_secondary(). In both cases
- * this happens in the functions called from head_64.S.
- *
- * The idt_table can't be used that early because all the code modifying it is
- * in idt.c and can be instrumented by tracing or KASAN, which both don't work
- * during early CPU bringup. Also the idt_table has the runtime vectors
- * configured which require certain CPU state to be setup already (like TSS),
- * which also hasn't happened yet in early CPU bringup.
- */
-static gate_desc bringup_idt_table[NUM_EXCEPTION_VECTORS] __page_aligned_data;
-
-/* This may run while still in the direct mapping */
-static void __head startup_64_load_idt(void *vc_handler)
-{
-	struct desc_ptr desc = {
-		.address = (unsigned long)rip_rel_ptr(bringup_idt_table),
-		.size    = sizeof(bringup_idt_table) - 1,
-	};
-	struct idt_data data;
-	gate_desc idt_desc;
-
-	/* @vc_handler is set only for a VMM Communication Exception */
-	if (vc_handler) {
-		init_idt_data(&data, X86_TRAP_VC, vc_handler);
-		idt_init_desc(&idt_desc, &data);
-		native_write_idt_entry((gate_desc *)desc.address, X86_TRAP_VC, &idt_desc);
-	}
-
-	native_load_idt(&desc);
-}
-
-/* This is used when running on kernel addresses */
-void early_setup_idt(void)
-{
-	void *handler = NULL;
-
-	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
-		setup_ghcb();
-		handler = vc_boot_ghcb;
-	}
-
-	startup_64_load_idt(handler);
-}
-
-/*
- * Setup boot CPU state needed before kernel switches to virtual addresses.
- */
-void __head startup_64_setup_gdt_idt(void)
-{
-	struct gdt_page *gp = rip_rel_ptr((void *)(__force unsigned long)&gdt_page);
-	void *handler = NULL;
-
-	struct desc_ptr startup_gdt_descr = {
-		.address = (unsigned long)gp->gdt,
-		.size    = GDT_SIZE - 1,
-	};
-
-	/* Load GDT */
-	native_load_gdt(&startup_gdt_descr);
-
-	/* New GDT is live - reload data segment registers */
-	asm volatile("movl %%eax, %%ds\n"
-		     "movl %%eax, %%ss\n"
-		     "movl %%eax, %%es\n" : : "a"(__KERNEL_DS) : "memory");
-
-	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))
-		handler = rip_rel_ptr(vc_no_ghcb);
-
-	startup_64_load_idt(handler);
-}
-- 
2.49.0.504.g3bcea36a83-goog


