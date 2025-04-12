Return-Path: <linux-efi+bounces-3307-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F908A86DBE
	for <lists+linux-efi@lfdr.de>; Sat, 12 Apr 2025 16:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D88E444155
	for <lists+linux-efi@lfdr.de>; Sat, 12 Apr 2025 14:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F16D1EFF82;
	Sat, 12 Apr 2025 14:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tq1b+06B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6YFpJidz"
X-Original-To: linux-efi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F7A1EDA2E;
	Sat, 12 Apr 2025 14:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744468428; cv=none; b=paF2EsxggsLKa29+FJPZogsUgM9hn3t30ja8vt3vdnIsRAjLw94gccilt/ggD6KHuRWc71B7RCxqB5NMisFazWwHLuffOZnxwpCBjw0Bi5jy9R0sJSVTOc4gdSxTM/C7YwgD4gg6B9Q3AeQqg7HF006kqvVYyO9O/FsPzsURvWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744468428; c=relaxed/simple;
	bh=q1JRr6b3ZKcMcAkRdF63nEXUlxfz7WNSAzgwZlM2aiY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=A7oMSjvD9MB7vT5goV/tnNAgqORAyTgzoqFHv9mUkzPE9iP1ugQYfNvIQXiPosa1gzEs2Gj6BjRB1enBCOA57yr4jxRuD1rOLDUyvopbop4DoKVXzlYEknWHb1ykI5+yOfA0meSphSmv6WIu6BpLIxmsiMKfg3ijtsq5XjIndMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tq1b+06B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6YFpJidz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 12 Apr 2025 14:33:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744468418;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y+Z+b4s2Oq7ZWP2JDxr5vRhZQID0J1/076Zoc2i+RvQ=;
	b=tq1b+06BWhP7KDrUTTlyZBpC1ACybR+CAbSPuRoLYMU4ihKU7uWmdeNRij6d97ZMXzrIsT
	doLLJePS3AnFna4NEVjcHL2FPC5PVh6Zsb2FEpRqN4Rqw50kjNZHKkuUt6EANmWNOoLhG8
	MUeQbLEsucTlujifQKzG0yTBdTeawvLlg1qlGW4VBYCzns7EE5MtO/8e9y85Ce0mqDaWIJ
	IY6xAmv/tvOoi2XCyh+zQ5+tEzBBkfNY8yxdhnCH6KGHNrqnd+hLQvFyf3sIu65YmU5NKt
	HBORyakHBtGWLr2+wSpRw4LUt+GGEJONC//fEdRoc7OSDNQL77lYA73YDnBrWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744468418;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y+Z+b4s2Oq7ZWP2JDxr5vRhZQID0J1/076Zoc2i+RvQ=;
	b=6YFpJidzJOJCg6GJ1w9ppSPqDJyv28ol9zf0PAIpomJzt55d+3/39eBZ2Sa+TPs6jDUTrk
	oDdWhwez7jGqTOCg==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] x86/boot: Move the early GDT/IDT setup code into startup/
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Dionna Amalie Glaze <dionnaglaze@google.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>,
 Kevin Loughlin <kevinloughlin@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Tom Lendacky <thomas.lendacky@amd.com>, linux-efi@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250410134117.3713574-15-ardb+git@google.com>
References: <20250410134117.3713574-15-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174446841819.31282.8764856250190579208.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     4cecebf200efea0fc865b5656f6d12ead2eb5573
Gitweb:        https://git.kernel.org/tip/4cecebf200efea0fc865b5656f6d12ead2eb5573
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 10 Apr 2025 15:41:20 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 12 Apr 2025 11:13:04 +02:00

x86/boot: Move the early GDT/IDT setup code into startup/

Move the early GDT/IDT setup code that runs long before the kernel
virtual mapping is up into arch/x86/boot/startup/, and build it in a way
that ensures that the code tolerates being called from the 1:1 mapping
of memory. The code itself is left unchanged by this patch.

Also tweak the sed symbol matching pattern in the decompressor to match
on lower case 't' or 'b', as these will be emitted by Clang for symbols
with hidden linkage.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Kevin Loughlin <kevinloughlin@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-efi@vger.kernel.org
Link: https://lore.kernel.org/r/20250410134117.3713574-15-ardb+git@google.com
---
 arch/x86/boot/compressed/Makefile |  2 +-
 arch/x86/boot/startup/Makefile    | 15 +++++-
 arch/x86/boot/startup/gdt_idt.c   | 84 ++++++++++++++++++++++++++++++-
 arch/x86/kernel/head64.c          | 74 +--------------------------
 4 files changed, 100 insertions(+), 75 deletions(-)
 create mode 100644 arch/x86/boot/startup/gdt_idt.c

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 37b85ce..0fcad7b 100644
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
index 8919a1c..1beb5de 100644
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
index 0000000..7e34d0b
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
index 954d093..9b2ffec 100644
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

