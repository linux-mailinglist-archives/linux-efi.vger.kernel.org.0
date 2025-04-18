Return-Path: <linux-efi+bounces-3368-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94983A93872
	for <lists+linux-efi@lfdr.de>; Fri, 18 Apr 2025 16:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A1A692009D
	for <lists+linux-efi@lfdr.de>; Fri, 18 Apr 2025 14:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB8918E76B;
	Fri, 18 Apr 2025 14:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3ecfmuN7"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19324188A0E
	for <linux-efi@vger.kernel.org>; Fri, 18 Apr 2025 14:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744985654; cv=none; b=U7vJ02nHW83O00Cbj6/VN3RKyr4OoP6WZVZhn1V9c+SSXNvdL4blzozCUNovCwkyfM44OKrtzrzRqNYIKgmoW8IAb4tUzw1yoWPnmV1sDtVDHXlpjIHIgZVlhz5E5zJpFEob+aiymlhvJhmgs8yjUI3BDyO4QzDWfwUo3V0zWGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744985654; c=relaxed/simple;
	bh=P4ReMggSVxgS5Vaej7zC7A2LjPP05pRzz7Af2bUsxWI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SQSk9llnUe7/T/wBZC94ajOsW8McMAR6mYMbtoPQ1wiI1zTgcCAmJ8U107yI5N5KiSbzn5dmNnTs0hFVwryrrdj6zoX4o2zuNbRqkn1DihhybeVeklA7APMYTbPiETrZbw5aelfjKvDKyk8bSq6elSagarbE7JaFvlisHloWK3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3ecfmuN7; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43d01024089so12025625e9.1
        for <linux-efi@vger.kernel.org>; Fri, 18 Apr 2025 07:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744985649; x=1745590449; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jXd59l21V7PNNqBzm0kcxDQJSFNdozFPYvjRwM+USt4=;
        b=3ecfmuN7oYJIPwQj9XCS+RHDViKNBa29/x+2mZ7zaq5iOisXGHY+u1uEP7nANqBchr
         fmX7TkF17bmGughZKYdTSpl/N7JUk8DdQz0THssByG3skT1SMDGUswv5QQhuEAggzP+O
         fbmDIA5C0AtLGhCnxOVTSfNSGEyr6f4iUrr97AnqANKYAwzmA0cOY7WHPKxLuGvRH4CH
         5QRY6Gh5fdZcbmljvaUftxkgpEgF4lrpmpEybYylQb5d4inOHOdLSrI/zCjISHYRwoUW
         j/26ipFW3Ju51McExDL80w1IIRB1s7n+eSyoMtVPCjSM4MTllhRkkEXT/13QfdN/Vyak
         rWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744985649; x=1745590449;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jXd59l21V7PNNqBzm0kcxDQJSFNdozFPYvjRwM+USt4=;
        b=oWT9kf42wxXvVaulouqyW+ey6rmMUA4eMjxc6XudplNV+a3onQDg9cfYiMBh+bsuH+
         ckXvmCk4QCaHaI++jFpZsmtSV7Zve32GOvWVDqiI2XvXGRozhFW1UKeMz7K62Az0KmsK
         kuHa1bDFb+rxyjOBSXpC/hvbfnrNRdLrY2et6S4imo793KPxMzAkWIWA6TsVYBmFvohj
         ZsF8JLnw6uadyQGy/fpmGvjtC7n1he8xhhjKK64TXFX/qU0gvdS386agiCgPLpcxRHTm
         GBSOHl2viXDCRoJ1VuskeX7d6lsTzks1QQp2gyVXOhdSidzj0Fu1QjAZ1F5bn0J/t+gZ
         OG0w==
X-Gm-Message-State: AOJu0YxvRCHum/3VNggCvNZ2u1c4F0IkIlUce6YxSWURY83wUpNZFmE7
	3NirolVPamiNxRG2b2GKipzFNT5UoTbFBNz645mo5BTgyBenQPk/IA/cWTiMTrs6QA4HOg==
X-Google-Smtp-Source: AGHT+IF2Os+Q4lirfKb2ZMNmyGCgzprXEbyokqVYMB/YOCMtJInLeS/aR1gGboA+s1hKKCUVBHKDUEBh
X-Received: from wmqi4.prod.google.com ([2002:a05:600c:3544:b0:43c:fcfd:1ce5])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:4284:b0:39c:2678:302e
 with SMTP id ffacd0b85a97d-39efbae5c77mr2450141f8f.45.1744985649382; Fri, 18
 Apr 2025 07:14:09 -0700 (PDT)
Date: Fri, 18 Apr 2025 16:12:56 +0200
In-Reply-To: <20250418141253.2601348-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250418141253.2601348-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=7890; i=ardb@kernel.org;
 h=from:subject; bh=cJ3U0lA1Ib1lwgVLvqMQocit3+qnzqMUPs9O4svCI9s=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYMp9oXNdiaBhC3feT+5XbKNcBDrk/t3Z3aAwJNaUd7mI
 MkVi1M6SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwESE2xn+R/wy2HdpwUK/gMQJ
 Vgsu2VvVd6cdZj1tr/B1tlFM8KxCPYb/MQt92cMeLPux5LXkmoOXtilKvL7alXn1/rzoaLmpe/9 PZwQA
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250418141253.2601348-10-ardb+git@google.com>
Subject: [PATCH v5 2/6] x86/sev: Move noinstr NMI handling code into separate
 source file
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, mingo@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

GCC may ignore the __no_sanitize_address function attribute when
inlining, resulting in KASAN instrumentation in code tagged as
'noinstr'.

Move the SEV NMI handling code, which is noinstr, into a separate source
file so KASAN can be disabled on the whole file without losing coverage
of other SEV core code, once the startup code is split off from it too.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/coco/sev/Makefile  |   5 +-
 arch/x86/coco/sev/core.c    |  89 ----------------
 arch/x86/coco/sev/sev-nmi.c | 108 ++++++++++++++++++++
 3 files changed, 112 insertions(+), 90 deletions(-)

diff --git a/arch/x86/coco/sev/Makefile b/arch/x86/coco/sev/Makefile
index dcb06dc8b5ae..bc4baa400c55 100644
--- a/arch/x86/coco/sev/Makefile
+++ b/arch/x86/coco/sev/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y += core.o
+obj-y += core.o sev-nmi.o
 
 # jump tables are emitted using absolute references in non-PIC code
 # so they cannot be used in the early SEV startup code
@@ -20,3 +20,6 @@ KCSAN_SANITIZE		:= n
 
 # Clang 14 and older may fail to respect __no_sanitize_undefined when inlining
 UBSAN_SANITIZE		:= n
+
+# GCC may fail to respect __no_sanitize_address when inlining
+KASAN_SANITIZE_sev-nmi.o	:= n
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index aeb7731862c0..c7a0f3a2f4ac 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -113,77 +113,6 @@ DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
 DEFINE_PER_CPU(struct svsm_ca *, svsm_caa);
 DEFINE_PER_CPU(u64, svsm_caa_pa);
 
-static __always_inline bool on_vc_stack(struct pt_regs *regs)
-{
-	unsigned long sp = regs->sp;
-
-	/* User-mode RSP is not trusted */
-	if (user_mode(regs))
-		return false;
-
-	/* SYSCALL gap still has user-mode RSP */
-	if (ip_within_syscall_gap(regs))
-		return false;
-
-	return ((sp >= __this_cpu_ist_bottom_va(VC)) && (sp < __this_cpu_ist_top_va(VC)));
-}
-
-/*
- * This function handles the case when an NMI is raised in the #VC
- * exception handler entry code, before the #VC handler has switched off
- * its IST stack. In this case, the IST entry for #VC must be adjusted,
- * so that any nested #VC exception will not overwrite the stack
- * contents of the interrupted #VC handler.
- *
- * The IST entry is adjusted unconditionally so that it can be also be
- * unconditionally adjusted back in __sev_es_ist_exit(). Otherwise a
- * nested sev_es_ist_exit() call may adjust back the IST entry too
- * early.
- *
- * The __sev_es_ist_enter() and __sev_es_ist_exit() functions always run
- * on the NMI IST stack, as they are only called from NMI handling code
- * right now.
- */
-void noinstr __sev_es_ist_enter(struct pt_regs *regs)
-{
-	unsigned long old_ist, new_ist;
-
-	/* Read old IST entry */
-	new_ist = old_ist = __this_cpu_read(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC]);
-
-	/*
-	 * If NMI happened while on the #VC IST stack, set the new IST
-	 * value below regs->sp, so that the interrupted stack frame is
-	 * not overwritten by subsequent #VC exceptions.
-	 */
-	if (on_vc_stack(regs))
-		new_ist = regs->sp;
-
-	/*
-	 * Reserve additional 8 bytes and store old IST value so this
-	 * adjustment can be unrolled in __sev_es_ist_exit().
-	 */
-	new_ist -= sizeof(old_ist);
-	*(unsigned long *)new_ist = old_ist;
-
-	/* Set new IST entry */
-	this_cpu_write(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC], new_ist);
-}
-
-void noinstr __sev_es_ist_exit(void)
-{
-	unsigned long ist;
-
-	/* Read IST entry */
-	ist = __this_cpu_read(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC]);
-
-	if (WARN_ON(ist == __this_cpu_ist_top_va(VC)))
-		return;
-
-	/* Read back old IST entry and write it to the TSS */
-	this_cpu_write(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC], *(unsigned long *)ist);
-}
-
 /*
  * Nothing shall interrupt this code path while holding the per-CPU
  * GHCB. The backup GHCB is only for NMIs interrupting this path.
@@ -608,24 +537,6 @@ int svsm_perform_call_protocol(struct svsm_call *call)
 	return ret;
 }
 
-void noinstr __sev_es_nmi_complete(void)
-{
-	struct ghcb_state state;
-	struct ghcb *ghcb;
-
-	ghcb = __sev_get_ghcb(&state);
-
-	vc_ghcb_invalidate(ghcb);
-	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_NMI_COMPLETE);
-	ghcb_set_sw_exit_info_1(ghcb, 0);
-	ghcb_set_sw_exit_info_2(ghcb, 0);
-
-	sev_es_wr_ghcb_msr(__pa_nodebug(ghcb));
-	VMGEXIT();
-
-	__sev_put_ghcb(&state);
-}
-
 static u64 __init get_snp_jump_table_addr(void)
 {
 	struct snp_secrets_page *secrets;
diff --git a/arch/x86/coco/sev/sev-nmi.c b/arch/x86/coco/sev/sev-nmi.c
new file mode 100644
index 000000000000..d8dfaddfb367
--- /dev/null
+++ b/arch/x86/coco/sev/sev-nmi.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AMD Memory Encryption Support
+ *
+ * Copyright (C) 2019 SUSE
+ *
+ * Author: Joerg Roedel <jroedel@suse.de>
+ */
+
+#define pr_fmt(fmt)	"SEV: " fmt
+
+#include <linux/bug.h>
+#include <linux/kernel.h>
+
+#include <asm/cpu_entry_area.h>
+#include <asm/msr.h>
+#include <asm/ptrace.h>
+#include <asm/sev.h>
+#include <asm/sev-internal.h>
+
+static __always_inline bool on_vc_stack(struct pt_regs *regs)
+{
+	unsigned long sp = regs->sp;
+
+	/* User-mode RSP is not trusted */
+	if (user_mode(regs))
+		return false;
+
+	/* SYSCALL gap still has user-mode RSP */
+	if (ip_within_syscall_gap(regs))
+		return false;
+
+	return ((sp >= __this_cpu_ist_bottom_va(VC)) && (sp < __this_cpu_ist_top_va(VC)));
+}
+
+/*
+ * This function handles the case when an NMI is raised in the #VC
+ * exception handler entry code, before the #VC handler has switched off
+ * its IST stack. In this case, the IST entry for #VC must be adjusted,
+ * so that any nested #VC exception will not overwrite the stack
+ * contents of the interrupted #VC handler.
+ *
+ * The IST entry is adjusted unconditionally so that it can be also be
+ * unconditionally adjusted back in __sev_es_ist_exit(). Otherwise a
+ * nested sev_es_ist_exit() call may adjust back the IST entry too
+ * early.
+ *
+ * The __sev_es_ist_enter() and __sev_es_ist_exit() functions always run
+ * on the NMI IST stack, as they are only called from NMI handling code
+ * right now.
+ */
+void noinstr __sev_es_ist_enter(struct pt_regs *regs)
+{
+	unsigned long old_ist, new_ist;
+
+	/* Read old IST entry */
+	new_ist = old_ist = __this_cpu_read(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC]);
+
+	/*
+	 * If NMI happened while on the #VC IST stack, set the new IST
+	 * value below regs->sp, so that the interrupted stack frame is
+	 * not overwritten by subsequent #VC exceptions.
+	 */
+	if (on_vc_stack(regs))
+		new_ist = regs->sp;
+
+	/*
+	 * Reserve additional 8 bytes and store old IST value so this
+	 * adjustment can be unrolled in __sev_es_ist_exit().
+	 */
+	new_ist -= sizeof(old_ist);
+	*(unsigned long *)new_ist = old_ist;
+
+	/* Set new IST entry */
+	this_cpu_write(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC], new_ist);
+}
+
+void noinstr __sev_es_ist_exit(void)
+{
+	unsigned long ist;
+
+	/* Read IST entry */
+	ist = __this_cpu_read(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC]);
+
+	if (WARN_ON(ist == __this_cpu_ist_top_va(VC)))
+		return;
+
+	/* Read back old IST entry and write it to the TSS */
+	this_cpu_write(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC], *(unsigned long *)ist);
+}
+
+void noinstr __sev_es_nmi_complete(void)
+{
+	struct ghcb_state state;
+	struct ghcb *ghcb;
+
+	ghcb = __sev_get_ghcb(&state);
+
+	vc_ghcb_invalidate(ghcb);
+	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_NMI_COMPLETE);
+	ghcb_set_sw_exit_info_1(ghcb, 0);
+	ghcb_set_sw_exit_info_2(ghcb, 0);
+
+	sev_es_wr_ghcb_msr(__pa_nodebug(ghcb));
+	VMGEXIT();
+
+	__sev_put_ghcb(&state);
+}
-- 
2.49.0.805.g082f7c87e0-goog


