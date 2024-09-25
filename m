Return-Path: <linux-efi+bounces-1801-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1096E98625E
	for <lists+linux-efi@lfdr.de>; Wed, 25 Sep 2024 17:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0DF81C260C1
	for <lists+linux-efi@lfdr.de>; Wed, 25 Sep 2024 15:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107F718A6AE;
	Wed, 25 Sep 2024 15:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fzK7lDY/"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7751517E919
	for <linux-efi@vger.kernel.org>; Wed, 25 Sep 2024 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276525; cv=none; b=pvKxyfmNbsbMqAXtsZhUgG7Fhr7NamhNmwcbEvtsS54WKZAtKqcqIBuny7cYGSjfit9Q6mVvK/qbq9IjDXDhgi0OtOOWYUpeYmFIi3C4n5darhYydFKPkqd+ncq26xIcfmA9CIYArkHjZ0WgUuZSrAncH4MtsGHuJcKt2aH62qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276525; c=relaxed/simple;
	bh=E/ekk1rehkbBpUh1L7h/NGwV62IOjSTKuZGPf/08C+4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ESRX3EuFbHkU44QWWR6k6/X3av9dWf1i5/m5wLu9ChHXTv7cHEph1gD099ncumrNmgqC0XRATmZu0gD8z6PdzFp+EO1TGBMxp5sDcwg2siHnwBARmYDa4XqHSCxKdusHtnmpqmVmPJOfcCZnLhsipV7wpwGTPj3oVJ5AE4xWJuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fzK7lDY/; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e035949cc4eso10634838276.1
        for <linux-efi@vger.kernel.org>; Wed, 25 Sep 2024 08:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727276522; x=1727881322; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hcBJaG4CjYcevMfAnFyKwMdAr3oBLta0TuXom4JmDi8=;
        b=fzK7lDY/T6qPwo1r7GQEYwhSXVfvWqdperrVUsFRMT/3la27zD4W4ba937y/+GWeDt
         8JpngM4iRo/c4yMyIn9mHwNiucOLHRqSrPuk8iA/zC3LNjnbWM+Bi1aaxW3IshnN3Ri3
         BvmpMhPh3S0NyUZvw/Ex6NkkdCp1p6fuGS5ptoGcEtbOzxt9V2i02Td09h9LXmQbP3/b
         iJ19pHtN4Z/lRz5Zp1irRecr1YrXL01NkRQLLc0nQz7CA17O2ux1kLDicjO/8vFyTmGz
         x0aOiAzX4h38PTDOx28g+6E6RVcgpUly4u2XdWbrXvyVEmXSA+RoL6R29jQJc/XfcJod
         hN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727276522; x=1727881322;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hcBJaG4CjYcevMfAnFyKwMdAr3oBLta0TuXom4JmDi8=;
        b=kSndbVuEcH4rraIA0/LGuDJC7VhF/5Du/H+nw8fnRZo0CKxaXCgdlKkzyL2mpiIcFP
         zBy8XlZylcl2KI1dgabEOmKqDYrl+2pH4ZbHNvBvvh9nWviRXiYoqb3JN8wvJZdMkjid
         f9G93shA1wvhocASdUjnxBVjheM/7sWOPaasYSWpFXfZyIS1bUv2Si+tvEzd+XkZIhgu
         DaOFBQgkQhuFEIi4xwHXXmaVHgtfCEpz6yBKyrrsRoTRo3VpquyO7HePl8ChUzygC5op
         0yJcwgPEyKPIfqAiXWEPibFW8L28Hxlh1256BxH9tjjowgRX/zjggKPBiY5yoxRUdypj
         Oq8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUt/XcAkB2D+MrdLXobP+DfG8zh0YNZXNVKqpujo0bXmhwo3ipX4fIJGPBjrI9XqMmbuwFWZNHICLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBMe22t8meP4oe1432GQz53sb0x+zqPTU5J7+x6rykLe3XZxbP
	XTP+kwqLitqiKHGELkiqgOiF5gktPOeEjcGvRGAb7BULS1catQEmGY3RrgpMaxKUm6UksA==
X-Google-Smtp-Source: AGHT+IHVPP/hq0VdoG8mz8zZDpKENYQvppd12tQOBs96+ky0ZuGKlW9zxaw1GBiDRtGEwfqJMJeN7cfB
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a25:d695:0:b0:e1a:70ed:6ec9 with SMTP id
 3f1490d57ef6-e24d7352785mr29529276.2.1727276522332; Wed, 25 Sep 2024 08:02:02
 -0700 (PDT)
Date: Wed, 25 Sep 2024 17:01:05 +0200
In-Reply-To: <20240925150059.3955569-30-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4340; i=ardb@kernel.org;
 h=from:subject; bh=I7lWAHThqqqqnrpiqIQsu32XeIcDrKE8EBFU/14ypJ4=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIe2L6manxvx6ho28axaYV4atC9wvG5Igfbri2+G3gWYqn
 maGuz52lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIl4nmVkaA1czF6Uafzbsi92
 efGhdw7lev3pD99ze/Rc9uE4U+u6lZHhb2nzhL8Z7seME5YcX8rFdHZX6uJJe7jF87S7K1vP1Mh zAQA=
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240925150059.3955569-35-ardb+git@google.com>
Subject: [RFC PATCH 05/28] x86: Define the stack protector guard symbol explicitly
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Uros Bizjak <ubizjak@gmail.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Keith Packard <keithp@keithp.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-efi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Specify the guard symbol for the stack cookie explicitly, rather than
positioning it exactly 40 bytes into the per-CPU area. Doing so removes
the need for the per-CPU region to be absolute rather than relative to
the placement of the per-CPU template region in the kernel image, and
this allows the special handling for absolute per-CPU symbols to be
removed entirely.

This is a worthwhile cleanup in itself, but it is also a prerequisite
for PIE codegen and PIE linking, which can replace our bespoke and
rather clunky runtime relocation handling.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/Makefile                     |  4 ++++
 arch/x86/include/asm/init.h           |  2 +-
 arch/x86/include/asm/processor.h      | 11 +++--------
 arch/x86/include/asm/stackprotector.h |  4 ----
 tools/perf/util/annotate.c            |  4 ++--
 5 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 6b3fe6e2aadd..b78b7623a4a9 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -193,6 +193,10 @@ else
         KBUILD_RUSTFLAGS += -Cno-redzone=y
         KBUILD_RUSTFLAGS += -Ccode-model=kernel
 
+        ifeq ($(CONFIG_STACKPROTECTOR),y)
+                KBUILD_CFLAGS += -mstack-protector-guard-symbol=fixed_percpu_data
+        endif
+
         # Don't emit relaxable GOTPCREL relocations
         KBUILD_AFLAGS_KERNEL += -Wa,-mrelax-relocations=no
         KBUILD_CFLAGS_KERNEL += -Wa,-mrelax-relocations=no
diff --git a/arch/x86/include/asm/init.h b/arch/x86/include/asm/init.h
index 14d72727d7ee..3ed0e8ec973f 100644
--- a/arch/x86/include/asm/init.h
+++ b/arch/x86/include/asm/init.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_INIT_H
 #define _ASM_X86_INIT_H
 
-#define __head	__section(".head.text")
+#define __head	__section(".head.text") __no_stack_protector
 
 struct x86_mapping_info {
 	void *(*alloc_pgt_page)(void *); /* allocate buf for page table */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 4a686f0e5dbf..56bc36116814 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -402,14 +402,9 @@ struct irq_stack {
 #ifdef CONFIG_X86_64
 struct fixed_percpu_data {
 	/*
-	 * GCC hardcodes the stack canary as %gs:40.  Since the
-	 * irq_stack is the object at %gs:0, we reserve the bottom
-	 * 48 bytes of the irq stack for the canary.
-	 *
-	 * Once we are willing to require -mstack-protector-guard-symbol=
-	 * support for x86_64 stackprotector, we can get rid of this.
+	 * Since the irq_stack is the object at %gs:0, the bottom 8 bytes of
+	 * the irq stack are reserved for the canary.
 	 */
-	char		gs_base[40];
 	unsigned long	stack_canary;
 };
 
@@ -418,7 +413,7 @@ DECLARE_INIT_PER_CPU(fixed_percpu_data);
 
 static inline unsigned long cpu_kernelmode_gs_base(int cpu)
 {
-	return (unsigned long)per_cpu(fixed_percpu_data.gs_base, cpu);
+	return (unsigned long)&per_cpu(fixed_percpu_data, cpu);
 }
 
 extern asmlinkage void entry_SYSCALL32_ignore(void);
diff --git a/arch/x86/include/asm/stackprotector.h b/arch/x86/include/asm/stackprotector.h
index 00473a650f51..d1dcd22a0a4c 100644
--- a/arch/x86/include/asm/stackprotector.h
+++ b/arch/x86/include/asm/stackprotector.h
@@ -51,10 +51,6 @@ static __always_inline void boot_init_stack_canary(void)
 {
 	unsigned long canary = get_random_canary();
 
-#ifdef CONFIG_X86_64
-	BUILD_BUG_ON(offsetof(struct fixed_percpu_data, stack_canary) != 40);
-#endif
-
 	current->stack_canary = canary;
 #ifdef CONFIG_X86_64
 	this_cpu_write(fixed_percpu_data.stack_canary, canary);
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 37ce43c4eb8f..7ecfedf5edb9 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2485,10 +2485,10 @@ static bool is_stack_operation(struct arch *arch, struct disasm_line *dl)
 
 static bool is_stack_canary(struct arch *arch, struct annotated_op_loc *loc)
 {
-	/* On x86_64, %gs:40 is used for stack canary */
+	/* On x86_64, %gs:0 is used for stack canary */
 	if (arch__is(arch, "x86")) {
 		if (loc->segment == INSN_SEG_X86_GS && loc->imm &&
-		    loc->offset == 40)
+		    loc->offset == 0)
 			return true;
 	}
 
-- 
2.46.0.792.g87dc391469-goog


