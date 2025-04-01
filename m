Return-Path: <linux-efi+bounces-3167-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BB1A77C39
	for <lists+linux-efi@lfdr.de>; Tue,  1 Apr 2025 15:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25AFE188F919
	for <lists+linux-efi@lfdr.de>; Tue,  1 Apr 2025 13:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6149204C0A;
	Tue,  1 Apr 2025 13:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QwueR8CX"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE11204864
	for <linux-efi@vger.kernel.org>; Tue,  1 Apr 2025 13:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743514482; cv=none; b=b6WFBFYq7qUss0sOdfo7+GLTnNVfk+xG4UnfoRkLBGoKGZ4FigOreN6mJMMDsP6JuXEcxygDrA14osH9v+nomST8Gb0L2OvAFbgQI95mx0vS6a0exAF95d/iTE6M4/59uGeM4KVy6bSMDwQr4Tn38GYt51KxobgMCnbmo6dZiRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743514482; c=relaxed/simple;
	bh=13dN6LyMDIRJPZtbLc4Qnlwfujaf8mnCxnGVXar+9i0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B24I+i6/DzJnoSkAHJITqc9D/7UcbwMFNfL6UDPSUGLpRRgTXMnDRkg+BmrlnODq5J2Ma7OJBGfVBkszfQTd9yytOwrneX5Is4EqZm55w4njWwIwgy/pFezSIZPpbeT2gsqlsEJFOntRhCy+llQsTg6DDSsFpBMfeTKbijsIJaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QwueR8CX; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43cec217977so32269345e9.0
        for <linux-efi@vger.kernel.org>; Tue, 01 Apr 2025 06:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743514479; x=1744119279; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iwpNwL234IC9yWIvSwlZhIgKkylOGfUY/NpW29/ZOa0=;
        b=QwueR8CXE1SHDXlMcssYhXj9RaibADn4mGnqJICY/KwI20FhSua7niARSlPKhVvhZp
         zAUMeZC49YZ/KUhutUZDXFdMnk0Ekl3uKt1wsMctwtl/LUYQwD//quAS4M8JhFBU9Oqu
         /yY+yoEu0T41n0gqQs/ZA+OFvUV7PS2REsLmpAmB6MO4AUSiljQ6raRsH2fhbakaY+Vz
         45uehrYRKMmAWFBQUjtFviYl2AXZwsVwQVoe0bfCjiZnhhY6riwnd0BV6iamCN1meiPC
         vAT98+qM6SkvENKDLrepy23uT40hksxvVdsj60/HCGNIG+FKLGXkNWcVduZnIOJ90LUJ
         f2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743514479; x=1744119279;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iwpNwL234IC9yWIvSwlZhIgKkylOGfUY/NpW29/ZOa0=;
        b=wU23T+ghha9SDI4o/M/Ob1eaidvL6dC3jJQICxlQzZWSaDXkNc5FAHFob4sOiU90Fo
         o7/i1KeKocERHbNCiC93n58ydVpHfu4zNFPmMNnqg0eWY2wGe0D7CWD/KV1pKV404WJC
         ITfQ2V5cwZiDoECsuKGyoEepYHCEzPqcoIn0Ql+KsxnlHw5Fs6Mq3jqu2IFbCQf98BDE
         mhlhZTAK0kfLNMoHEJ0eeyDOF+wAndNgLeSmj9b2PLfuZUR2e05TIUeDR1nX91qI4YjW
         ROovry9omrIHmmE3cZRNBtFZ1JwHUJZGoJFg1muJHBhPAVtBH4WUrYbqhGO1KmkQjA6r
         1KbQ==
X-Gm-Message-State: AOJu0Yw6Ctlu/zPNKArDtiM7KMTje1M3mgGvfOuBgewOLq4ZB0e4ar0X
	7jpK2vrROsvQiQVGQdpc5WLYm5RtOUBsImriXTujuRSE6OxMjuzFGLctqSwywl50kaPg+hJ02cE
	4A5UOrUMVIWWXtabcPG5lX3L7bIAnjI+knKrONv/LwuWGtIJg6G8Na0yvCo4Xv1ikD6YK9oF4Sz
	UfnxpMIc7rW7QNNQyJUmqkkrDrWg==
X-Google-Smtp-Source: AGHT+IG4QK2ZXVU8OaDJZrpd4jbGOh2SrGi1jhRE/dSVG0kTZPTHVEXeqFIKnFD0vg8+XQ7RAPuxGyya
X-Received: from wmbhc8.prod.google.com ([2002:a05:600c:8708:b0:43d:8244:7f6d])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3c8a:b0:43d:45a:8fca
 with SMTP id 5b1f17b1804b1-43db62bf4e4mr119197335e9.30.1743514479363; Tue, 01
 Apr 2025 06:34:39 -0700 (PDT)
Date: Tue,  1 Apr 2025 15:34:21 +0200
In-Reply-To: <20250401133416.1436741-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250401133416.1436741-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=7788; i=ardb@kernel.org;
 h=from:subject; bh=7CqWOqUn0owfJx93vqlZ0MaFHl2+UzXGIVwFFUz3Lwk=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf3167hzdUZKs0sL7l6c+eF38RwBCUHBG/u/zop/KD77r
 c38xTwMHaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAiJxgZ/qnz/Ft1teKvVpBB
 YjCn2DvGlkkRuyR2btO1Nw99bLdoyQ6Gf1oK/bUCaofNbidkMIkt6b2Wtmy5vc02t19T3QVfyxy +wgEA
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250401133416.1436741-12-ardb+git@google.com>
Subject: [RFC PATCH 4/6] x86/boot: Move early GDT/IDT setup code into startup/
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Move the early GDT/IDT setup code that runs long before the kernel
virtual mapping is up into arch/x86/boot/startup/, and build it in a way
that ensures that the code tolerates being called from the 1:1 mapping
of memory.

This allows the RIP_REL_REF() macro uses to be dropped, and removes the
need for emitting the code into the special .head.text section.

Also tweak the sed symbol matching pattern in the decompressor to match
on lower case 't' or 'b', as these will be emitted by Clang for symbols
with hidden linkage.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/Makefile |  2 +-
 arch/x86/boot/startup/Makefile    | 15 ++++
 arch/x86/boot/startup/gdt_idt.c   | 82 ++++++++++++++++++++
 arch/x86/kernel/head64.c          | 74 ------------------
 4 files changed, 98 insertions(+), 75 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 468e135de88e..48541cf54790 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -74,7 +74,7 @@ LDFLAGS_vmlinux += -T
 hostprogs	:= mkpiggy
 HOST_EXTRACFLAGS += -I$(srctree)/tools/include
 
-sed-voffset := -e 's/^\([0-9a-fA-F]*\) [ABCDGRSTVW] \(_text\|__start_rodata\|__bss_start\|_end\)$$/\#define VO_\2 _AC(0x\1,UL)/p'
+sed-voffset := -e 's/^\([0-9a-fA-F]*\) [ABbCDGRSTtVW] \(_text\|__start_rodata\|__bss_start\|_end\)$$/\#define VO_\2 _AC(0x\1,UL)/p'
 
 quiet_cmd_voffset = VOFFSET $@
       cmd_voffset = $(NM) $< | sed -n $(sed-voffset) > $@
diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index 73946a3f6b3b..34b324cbd5a4 100644
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
index 000000000000..b382d5db2586
--- /dev/null
+++ b/arch/x86/boot/startup/gdt_idt.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/linkage.h>
+#include <linux/types.h>
+
+#include <asm/desc.h>
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
+static void startup_64_load_idt(void *vc_handler)
+{
+	struct desc_ptr desc = {
+		.address = (unsigned long)bringup_idt_table,
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
+void __init startup_64_setup_gdt_idt(void)
+{
+	void *handler = NULL;
+
+	struct desc_ptr startup_gdt_descr = {
+		.address = (__force unsigned long)gdt_page.gdt,
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
+		handler = vc_no_ghcb;
+
+	startup_64_load_idt(handler);
+}
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index fa9b6339975f..5b993b545c7e 100644
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
-		.address = (unsigned long)&RIP_REL_REF(bringup_idt_table),
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
-	struct desc_struct *gdt = (void *)(__force unsigned long)gdt_page.gdt;
-	void *handler = NULL;
-
-	struct desc_ptr startup_gdt_descr = {
-		.address = (unsigned long)&RIP_REL_REF(*gdt),
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
-		handler = &RIP_REL_REF(vc_no_ghcb);
-
-	startup_64_load_idt(handler);
-}
-- 
2.49.0.472.ge94155a9ec-goog


