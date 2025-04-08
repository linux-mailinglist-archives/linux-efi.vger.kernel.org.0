Return-Path: <linux-efi+bounces-3223-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEF0A7F8BA
	for <lists+linux-efi@lfdr.de>; Tue,  8 Apr 2025 10:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6FC84416CE
	for <lists+linux-efi@lfdr.de>; Tue,  8 Apr 2025 08:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E537266581;
	Tue,  8 Apr 2025 08:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v2cyxuKy"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FCF266576
	for <linux-efi@vger.kernel.org>; Tue,  8 Apr 2025 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744102405; cv=none; b=HgvkyPm6A9MdJL4CnM2cgqgRBDPbgn37wKYjpHEaN4ZBPcSCaIZbeHJ/4LnOtO5HZ+BV5b8iPWQ99lztIz4Zc5/V1jUPjs0KUGvnQGS+6XkmXmz2OejpFD+Rz4851rQZwu68ANjzyVzPJn14EYh7Yr5dXhA5iwq8e55dXOGPh9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744102405; c=relaxed/simple;
	bh=UiIXbFws/N6MPsHfKXBZbL6qTKO+a2tli2uXvgO59Zw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lE64oiLSguHTPg9Upm2G9xUPLxPxVcpPbfJ9OtHhyTiLfgejaMLjWPHRluzpUd1SKxB7Caj+lJ6d5BrUUqF0d4HQPgWR7kDPJR4nda8EOwjefL877Nx9FK9/aCbKHXsjFOy3XFLWGT4UgGB99F6RCkop+sxMK93xJzIGcJ4qP6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v2cyxuKy; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43ce245c5acso66633215e9.2
        for <linux-efi@vger.kernel.org>; Tue, 08 Apr 2025 01:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744102401; x=1744707201; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/8h58VkhTYicfCFIDEXpeboAkqejErVKkEny/lhByfs=;
        b=v2cyxuKyhZEO0ltZiQPdrWRiONt7u28QlImF42wO/858KQoMDu6w18eE7NRbQZQGeK
         i/gJGd97zerH1R6MIqCOwQ7RUaYfDNwITRZ3q5rspYPWaDl3/mfAWR79tYI/Zivsjgwl
         +KOeXe8OPZgIPZStJAESucVIrrURJd1mW7PW2YCUfydU5Lt37ron4+f926LHZNPm/+hh
         P7O5MWKZKN4QByK+aKmzjoKLSj+xA08gipkREJ6h08bz4DX2x0/RII6qkfmP+vlrT/X9
         B2+zm2KosHN0CnJKd/dxzaVsmizE3qi0I6s+zzq3LVGx1Vgp9CTZ1I4HkPkPEJSOYocI
         H1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744102401; x=1744707201;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/8h58VkhTYicfCFIDEXpeboAkqejErVKkEny/lhByfs=;
        b=vBtkTXXNggdTs0M76EHtQqGQReRzr3jjlPiL0LbAh4eghLnQGT8qiLWr/QT3mKxGon
         ERTMaSu3vQiGLREcske5AeDbepE7KOJoIPo8G1gC6oExIN/AUrbvgx7LyJb4th3N2da8
         sZe7rCBQX/biHkjUdlcfwvXYdqJYG13HrJNkCw5/e9yGjD4a9FZzcgfJ9LpT8ldSxXOv
         +H+xTgXbuZs8nvEkXsGQG4ZBCjH3IkD+p5sEFhGT16+MTNqRYxrUePwACXcG1rIS9uz1
         KCy/hCFSLbIWDDW67A7uN3+VndKOohgF14QkhDZZMiVwnzXky3WwvPyRnlTBSKjTY1a+
         t2gA==
X-Gm-Message-State: AOJu0Yy4MMkJXdsE06cLq+Leyq+NqSDZdYEmRfefZ/wqgYQB3xj+y5EI
	451E2L++yLA7i4ln3RuhS4TtMYjQKHKgFvg8dV7cRkjMNCwUHeJ5B3MRINBKksaXqfAgkqyBtzZ
	SI49QC3MepDvO4VJi/vpxOvjVc/mHcbKaf7TsmGHLQysPHa8H8iykvARVAgIBMF5Ec1GCBqFDRh
	vfXeHZva9Jfse1Gpj90QOEhRgWOw==
X-Google-Smtp-Source: AGHT+IG3GQ7ePdBsYmKoAHohsV/UHUomyI8w9MTYX++5d0ywPwjqNOuD9XKzu57+zaj/o4O6b/FxTDHq
X-Received: from wmby22.prod.google.com ([2002:a05:600c:c056:b0:43c:f517:ac4e])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1387:b0:43c:f513:9585
 with SMTP id 5b1f17b1804b1-43ed0bde88amr162598975e9.13.1744102401474; Tue, 08
 Apr 2025 01:53:21 -0700 (PDT)
Date: Tue,  8 Apr 2025 10:52:58 +0200
In-Reply-To: <20250408085254.836788-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250408085254.836788-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=7715; i=ardb@kernel.org;
 h=from:subject; bh=pEPidM8yfOLc4MnQp//TasJ2kFqyO78dPBz+ZrxAL10=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf3L4zdi4W69nYZ3FBoqnrSw5KqXZCdOLFbrmHn1+sMLv
 a6CFgs6SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwEQc/jIy/Lw7Ver/5mcv1x0U
 FLn3aXUY87mZX8ueccipFu/9IW8f95qRYVvwunNF2hst+y/O9srqMb/GdC/xj0xQKuOBvgYGvkP zuAA=
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250408085254.836788-12-ardb+git@google.com>
Subject: [PATCH v3 3/7] x86/boot: Move the early GDT/IDT setup code into startup/
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
 arch/x86/boot/startup/gdt_idt.c   | 83 ++++++++++++++++++++
 arch/x86/kernel/head64.c          | 73 -----------------
 4 files changed, 99 insertions(+), 74 deletions(-)

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
index 000000000000..1ba6bd5786fe
--- /dev/null
+++ b/arch/x86/boot/startup/gdt_idt.c
@@ -0,0 +1,83 @@
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
+	void *handler = NULL;
+
+	struct desc_ptr startup_gdt_descr = {
+		.address = (unsigned long)rip_rel_ptr((__force void *)&gdt_page),
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
index 3fb23d805cef..9b2ffec4bbad 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -512,76 +512,3 @@ void __init __noreturn x86_64_start_reservations(char *real_mode_data)
 
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
-	void *handler = NULL;
-
-	struct desc_ptr startup_gdt_descr = {
-		.address = (unsigned long)rip_rel_ptr((__force void *)&gdt_page),
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


