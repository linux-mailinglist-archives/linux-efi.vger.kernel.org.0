Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6978AFCCB3
	for <lists+linux-efi@lfdr.de>; Thu, 14 Nov 2019 19:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfKNSEe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 14 Nov 2019 13:04:34 -0500
Received: from mail-wr1-f74.google.com ([209.85.221.74]:45504 "EHLO
        mail-wr1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbfKNSEe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 14 Nov 2019 13:04:34 -0500
Received: by mail-wr1-f74.google.com with SMTP id y3so4882207wrm.12
        for <linux-efi@vger.kernel.org>; Thu, 14 Nov 2019 10:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=V48+CW8SP21nJTw3n511EV0NzIrdGUkA/Mo6H0aYbCQ=;
        b=SnVWFOxrqhGVA3o/oVRrHRlEFYQ66/0SOV/8Wir2hZgl+5XkmZ/VYrGs3JQIw8jFjK
         EelP1k4At5P4DSpgmyTbTKjz36AYnTxrgzc50HLEdcxz9CdC3kdRAT++DeQww7U9K4Fx
         F65Pwx6zhDOIeb5DDoYUhUnHlvwxPP7lw0KWqas8ix+ODavAAHoDwyHrKwheQH1Y8+KG
         CtMtyXRimhLn+hhMV+bRu4XMp/H2LDnj8BU89YwnaQ2OqLD4HoLZeoEv/msHGertNbCi
         APS23YkUBb/261pr9MUO63D6yU8wRcsyN1Xw81gKUJNI7yX+g37aufSxFGTX6lN4mMcO
         T6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=V48+CW8SP21nJTw3n511EV0NzIrdGUkA/Mo6H0aYbCQ=;
        b=hqpyIRg0gOOO7HuC9sM8OeO5JQtyFg6Um48hwjjvY61EL/0UXp9gYf94SDwcqDLb/H
         Sz6ZFVI42vd3tMMFbQqFCIVHNdm1zNWlYS8RP5rKMj7xq7k9jnzTAyxrwpQBwyesWWSr
         xw7jTTO5Uav77aNTfL9RXl17aGGvd77fvP/bTzZ6HnQ52lOnmYt0W1wmcCWb3XBtUQ54
         uU7VPBp1/V4KLcBAEEPPzqYo81vDBg5+gkKZntLPTW+h0A9OcCyKVj6R9qH5UxSe6WaB
         gtZI9l+DpKZg1yMB+xKYT7Rv7o41+DPC9rQdYO8q56lrRNvaZGDY+YfP3G+OQFy0a0r3
         vwtw==
X-Gm-Message-State: APjAAAV4eKQ9tppLSiq376gJW63WwgfTD15rIHtd7lhc8SjTp9unwDce
        +oDwT1CxkdkQAUUPfa4iSY8SkXisZg==
X-Google-Smtp-Source: APXvYqy5QdqQ6wSPNcmJk5EYF5HMESRJSKd4Bgh+yADSSABjRrCnB8uskBN1QWrSyICPt+TlDjVIPnmgEQ==
X-Received: by 2002:adf:e50e:: with SMTP id j14mr8629262wrm.179.1573754670805;
 Thu, 14 Nov 2019 10:04:30 -0800 (PST)
Date:   Thu, 14 Nov 2019 19:03:03 +0100
In-Reply-To: <20191114180303.66955-1-elver@google.com>
Message-Id: <20191114180303.66955-11-elver@google.com>
Mime-Version: 1.0
References: <20191114180303.66955-1-elver@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v4 10/10] x86, kcsan: Enable KCSAN for x86
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     akiyks@gmail.com, stern@rowland.harvard.edu, glider@google.com,
        parri.andrea@gmail.com, andreyknvl@google.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, arnd@arndb.de, boqun.feng@gmail.com,
        bp@alien8.de, dja@axtens.net, dlustig@nvidia.com,
        dave.hansen@linux.intel.com, dhowells@redhat.com,
        dvyukov@google.com, hpa@zytor.com, mingo@redhat.com,
        j.alglave@ucl.ac.uk, joel@joelfernandes.org, corbet@lwn.net,
        jpoimboe@redhat.com, luc.maranget@inria.fr, mark.rutland@arm.com,
        npiggin@gmail.com, paulmck@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, will@kernel.org, edumazet@google.com,
        kasan-dev@googlegroups.com, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This patch enables KCSAN for x86, with updates to build rules to not use
KCSAN for several incompatible compilation units.

Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
---
v4:
* Fix code generation with clang (KCSAN_SANITIZE := n for affected
  compilation units).

v3:
* Moved EFI stub build exception hunk to generic build exception patch,
  since it's not x86-specific.

v2:
* Document build exceptions where no previous above comment explained
  why we cannot instrument.
---
 arch/x86/Kconfig                  | 1 +
 arch/x86/boot/Makefile            | 2 ++
 arch/x86/boot/compressed/Makefile | 2 ++
 arch/x86/entry/vdso/Makefile      | 3 +++
 arch/x86/include/asm/bitops.h     | 6 +++++-
 arch/x86/kernel/Makefile          | 4 ++++
 arch/x86/kernel/cpu/Makefile      | 3 +++
 arch/x86/lib/Makefile             | 4 ++++
 arch/x86/mm/Makefile              | 4 ++++
 arch/x86/purgatory/Makefile       | 2 ++
 arch/x86/realmode/Makefile        | 3 +++
 arch/x86/realmode/rm/Makefile     | 3 +++
 12 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 8ef85139553f..9933ca8ffe16 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -226,6 +226,7 @@ config X86
 	select VIRT_TO_BUS
 	select X86_FEATURE_NAMES		if PROC_FS
 	select PROC_PID_ARCH_STATUS		if PROC_FS
+	select HAVE_ARCH_KCSAN if X86_64
 
 config INSTRUCTION_DECODER
 	def_bool y
diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index e2839b5c246c..9c7942794164 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -9,7 +9,9 @@
 # Changed by many, many contributors over the years.
 #
 
+# Sanitizer runtimes are unavailable and cannot be linked for early boot code.
 KASAN_SANITIZE			:= n
+KCSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
 
 # Kernel does not boot with kcov instrumentation here.
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 6b84afdd7538..a1c248b8439f 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -17,7 +17,9 @@
 #	(see scripts/Makefile.lib size_append)
 #	compressed vmlinux.bin.all + u32 size of vmlinux.bin.all
 
+# Sanitizer runtimes are unavailable and cannot be linked for early boot code.
 KASAN_SANITIZE			:= n
+KCSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
 
 # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 0f2154106d01..a23debaad5b9 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -10,8 +10,11 @@ ARCH_REL_TYPE_ABS += R_386_GLOB_DAT|R_386_JMP_SLOT|R_386_RELATIVE
 include $(srctree)/lib/vdso/Makefile
 
 KBUILD_CFLAGS += $(DISABLE_LTO)
+
+# Sanitizer runtimes are unavailable and cannot be linked here.
 KASAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
+KCSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
 
 # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index 7d1f6a49bfae..542b63ddc8aa 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -201,8 +201,12 @@ arch_test_and_change_bit(long nr, volatile unsigned long *addr)
 	return GEN_BINARY_RMWcc(LOCK_PREFIX __ASM_SIZE(btc), *addr, c, "Ir", nr);
 }
 
-static __always_inline bool constant_test_bit(long nr, const volatile unsigned long *addr)
+static __no_kcsan_or_inline bool constant_test_bit(long nr, const volatile unsigned long *addr)
 {
+	/*
+	 * Because this is a plain access, we need to disable KCSAN here to
+	 * avoid double instrumentation via instrumented bitops.
+	 */
 	return ((1UL << (nr & (BITS_PER_LONG-1))) &
 		(addr[nr >> _BITOPS_LONG_SHIFT])) != 0;
 }
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 3578ad248bc9..a9a1cab437bc 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -28,6 +28,10 @@ KASAN_SANITIZE_dumpstack_$(BITS).o			:= n
 KASAN_SANITIZE_stacktrace.o				:= n
 KASAN_SANITIZE_paravirt.o				:= n
 
+# With some compiler versions the generated code results in boot hangs, caused
+# by several compilation units. To be safe, disable all instrumentation.
+KCSAN_SANITIZE := n
+
 OBJECT_FILES_NON_STANDARD_relocate_kernel_$(BITS).o	:= y
 OBJECT_FILES_NON_STANDARD_test_nx.o			:= y
 OBJECT_FILES_NON_STANDARD_paravirt_patch.o		:= y
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 890f60083eca..a704fb9ee98e 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -13,6 +13,9 @@ endif
 KCOV_INSTRUMENT_common.o := n
 KCOV_INSTRUMENT_perf_event.o := n
 
+# As above, instrumenting secondary CPU boot code causes boot hangs.
+KCSAN_SANITIZE_common.o := n
+
 # Make sure load_percpu_segment has no stackprotector
 nostackp := $(call cc-option, -fno-stack-protector)
 CFLAGS_common.o		:= $(nostackp)
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 5246db42de45..432a07705677 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -6,10 +6,14 @@
 # Produces uninteresting flaky coverage.
 KCOV_INSTRUMENT_delay.o	:= n
 
+# KCSAN uses udelay for introducing watchpoint delay; avoid recursion.
+KCSAN_SANITIZE_delay.o := n
+
 # Early boot use of cmdline; don't instrument it
 ifdef CONFIG_AMD_MEM_ENCRYPT
 KCOV_INSTRUMENT_cmdline.o := n
 KASAN_SANITIZE_cmdline.o  := n
+KCSAN_SANITIZE_cmdline.o  := n
 
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_cmdline.o = -pg
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 84373dc9b341..3559f4297ee1 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -7,6 +7,10 @@ KCOV_INSTRUMENT_mem_encrypt_identity.o	:= n
 KASAN_SANITIZE_mem_encrypt.o		:= n
 KASAN_SANITIZE_mem_encrypt_identity.o	:= n
 
+# Disable KCSAN entirely, because otherwise we get warnings that some functions
+# reference __initdata sections.
+KCSAN_SANITIZE := n
+
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_mem_encrypt.o		= -pg
 CFLAGS_REMOVE_mem_encrypt_identity.o	= -pg
diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index fb4ee5444379..69379bce9574 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -17,7 +17,9 @@ CFLAGS_sha256.o := -D__DISABLE_EXPORTS
 LDFLAGS_purgatory.ro := -e purgatory_start -r --no-undefined -nostdlib -z nodefaultlib
 targets += purgatory.ro
 
+# Sanitizer runtimes are unavailable and cannot be linked here.
 KASAN_SANITIZE	:= n
+KCSAN_SANITIZE	:= n
 KCOV_INSTRUMENT := n
 
 # These are adjustments to the compiler flags used for objects that
diff --git a/arch/x86/realmode/Makefile b/arch/x86/realmode/Makefile
index 682c895753d9..6b1f3a4eeb44 100644
--- a/arch/x86/realmode/Makefile
+++ b/arch/x86/realmode/Makefile
@@ -6,7 +6,10 @@
 # for more details.
 #
 #
+
+# Sanitizer runtimes are unavailable and cannot be linked here.
 KASAN_SANITIZE			:= n
+KCSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
 
 subdir- := rm
diff --git a/arch/x86/realmode/rm/Makefile b/arch/x86/realmode/rm/Makefile
index f60501a384f9..fdbbb945c216 100644
--- a/arch/x86/realmode/rm/Makefile
+++ b/arch/x86/realmode/rm/Makefile
@@ -6,7 +6,10 @@
 # for more details.
 #
 #
+
+# Sanitizer runtimes are unavailable and cannot be linked here.
 KASAN_SANITIZE			:= n
+KCSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
 
 # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

