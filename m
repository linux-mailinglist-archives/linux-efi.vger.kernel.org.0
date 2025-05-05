Return-Path: <linux-efi+bounces-3590-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 950ECAA8BAB
	for <lists+linux-efi@lfdr.de>; Mon,  5 May 2025 07:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF0BD1890BD0
	for <lists+linux-efi@lfdr.de>; Mon,  5 May 2025 05:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41351A0B08;
	Mon,  5 May 2025 05:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ll3pErj3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OB5M20wx"
X-Original-To: linux-efi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F83D1684AC;
	Mon,  5 May 2025 05:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746423094; cv=none; b=bufLXVs0BwW9Sklcd3tN0cHP2+46MBtxCP9wCrjovmwNdQ94QCvKNbRIvRVFbFG597sWFph2weIzWEzK3sa5bvBoqSopfowA+uRrbvbLN+89jnyi9cRGbepz7wDWPw4GUgou1QUeddNYyGvpijoP4+8mCjQOqUYKeuCPSUQC3Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746423094; c=relaxed/simple;
	bh=sZ98NXMABLGzwZ+Pz/6pR8Uy8qMbZRUNBhsn654tdK8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=b1y7upHwwIl+9K95CbVy+5dKcVjw53dba6O2AEq8hedPHeIHwp0c9lcGhM/729mDR0O+EhdJAXw2gVx/CkVj7yYZ7R2C0YWkhT6CayNg1yzIwfocJPjooJHFvVTvDDJ1IAASapPiFX7Yw1TDEyOskhDNARYK1JuPah7c0Nco7SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ll3pErj3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OB5M20wx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 May 2025 05:31:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746423087;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fTAWxORLdjH7DEQZc+bcQMk0rq5l6yKVK1rOMTzbpHM=;
	b=Ll3pErj3LPVzsuOfx2h7FAqD5CylUp7CzXOMjTFI+e1L34h63iMBE3j1jnmNlfq7HteOed
	XqkBxXk9mx3Xw9dVk/t/+DbVRzfStztTikXLjpvD5I4Ghs2WUu/ne2RiEof0eIY7UThFOE
	AdFeJ2xd/Y4g692zOpCdbiKzBxKq03gytDuVzE0lU78gJagfNyfZn+LofOv5L7x5dl6Jxw
	LBAQmkk1P2hUVG56e0M14ts8g3XFaiaZdh86iPU+Zzha350nzUObUoZt3P9IeMX7pyD0VA
	+tCDCWydJcWjpW0iAtOEWS33ZIDGixOK09WsyzJMCgfPt+ASb8I7p9hJVailyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746423087;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fTAWxORLdjH7DEQZc+bcQMk0rq5l6yKVK1rOMTzbpHM=;
	b=OB5M20wxZSf4J/2JuXvNUxxA418lj5gLVi6OmXPf2HbayG/ohO6tq6UBTBUNzO5VJkDqYU
	AfEhk1hCAQ4hKVDA==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] x86/sev: Disentangle #VC handling code from startup code
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, David Woodhouse <dwmw@amazon.co.uk>,
 Dionna Amalie Glaze <dionnaglaze@google.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>,
 Kevin Loughlin <kevinloughlin@google.com>, Len Brown <len.brown@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, linux-efi@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250504095230.2932860-31-ardb+git@google.com>
References: <20250504095230.2932860-31-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174642307814.22196.7469514245717727866.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     ed4d95d033e359f9445e85bf5a768a5859a5830b
Gitweb:        https://git.kernel.org/tip/ed4d95d033e359f9445e85bf5a768a5859a5830b
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Sun, 04 May 2025 11:52:36 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 05 May 2025 07:07:29 +02:00

x86/sev: Disentangle #VC handling code from startup code

Most of the SEV support code used to reside in a single C source file
that was included in two places: the core kernel, and the decompressor.

The code that is actually shared with the decompressor was moved into a
separate, shared source file under startup/, on the basis that the
decompressor also executes from the early 1:1 mapping of memory.

However, while the elaborate #VC handling and instruction decoding that
it involves is also performed by the decompressor, it does not actually
occur in the core kernel at early boot, and therefore, does not need to
be part of the confined early startup code.

So split off the #VC handling code and move it back into arch/x86/coco
where it came from, into another C source file that is included from
both the decompressor and the core kernel.

Code movement only - no functional change intended.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Kevin Loughlin <kevinloughlin@google.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-efi@vger.kernel.org
Link: https://lore.kernel.org/r/20250504095230.2932860-31-ardb+git@google.com
---
 arch/x86/boot/compressed/misc.h          |    1 +-
 arch/x86/boot/compressed/sev-handle-vc.c |   83 ++-
 arch/x86/boot/compressed/sev.c           |   96 +--
 arch/x86/boot/compressed/sev.h           |   19 +-
 arch/x86/boot/startup/sev-shared.c       |  519 +----------
 arch/x86/boot/startup/sev-startup.c      | 1022 +--------------------
 arch/x86/coco/sev/Makefile               |    2 +-
 arch/x86/coco/sev/vc-handle.c            | 1061 +++++++++++++++++++++-
 arch/x86/coco/sev/vc-shared.c            |  504 ++++++++++-
 arch/x86/include/asm/sev-internal.h      |    8 +-
 arch/x86/include/asm/sev.h               |   22 +-
 11 files changed, 1694 insertions(+), 1643 deletions(-)
 create mode 100644 arch/x86/coco/sev/vc-handle.c
 create mode 100644 arch/x86/coco/sev/vc-shared.c

diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 04de48c..db10486 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -150,6 +150,7 @@ void sev_prep_identity_maps(unsigned long top_level_pgt);
 enum es_result vc_decode_insn(struct es_em_ctxt *ctxt);
 bool insn_has_rep_prefix(struct insn *insn);
 void sev_insn_decode_init(void);
+bool early_setup_ghcb(void);
 #else
 static inline void sev_enable(struct boot_params *bp)
 {
diff --git a/arch/x86/boot/compressed/sev-handle-vc.c b/arch/x86/boot/compressed/sev-handle-vc.c
index b1aa073..89dd02d 100644
--- a/arch/x86/boot/compressed/sev-handle-vc.c
+++ b/arch/x86/boot/compressed/sev-handle-vc.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include "misc.h"
+#include "sev.h"
 
 #include <linux/kernel.h>
 #include <linux/string.h>
@@ -8,6 +9,9 @@
 #include <asm/pgtable_types.h>
 #include <asm/ptrace.h>
 #include <asm/sev.h>
+#include <asm/trapnr.h>
+#include <asm/trap_pf.h>
+#include <asm/fpu/xcr.h>
 
 #define __BOOT_COMPRESSED
 
@@ -49,3 +53,82 @@ enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
 }
 
 extern void sev_insn_decode_init(void) __alias(inat_init_tables);
+
+/*
+ * Only a dummy for insn_get_seg_base() - Early boot-code is 64bit only and
+ * doesn't use segments.
+ */
+static unsigned long insn_get_seg_base(struct pt_regs *regs, int seg_reg_idx)
+{
+	return 0UL;
+}
+
+static enum es_result vc_write_mem(struct es_em_ctxt *ctxt,
+				   void *dst, char *buf, size_t size)
+{
+	memcpy(dst, buf, size);
+
+	return ES_OK;
+}
+
+static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
+				  void *src, char *buf, size_t size)
+{
+	memcpy(buf, src, size);
+
+	return ES_OK;
+}
+
+static enum es_result vc_ioio_check(struct es_em_ctxt *ctxt, u16 port, size_t size)
+{
+	return ES_OK;
+}
+
+static bool fault_in_kernel_space(unsigned long address)
+{
+	return false;
+}
+
+#define sev_printk(fmt, ...)
+
+#include "../../coco/sev/vc-shared.c"
+
+void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
+{
+	struct es_em_ctxt ctxt;
+	enum es_result result;
+
+	if (!boot_ghcb && !early_setup_ghcb())
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
+
+	vc_ghcb_invalidate(boot_ghcb);
+	result = vc_init_em_ctxt(&ctxt, regs, exit_code);
+	if (result != ES_OK)
+		goto finish;
+
+	result = vc_check_opcode_bytes(&ctxt, exit_code);
+	if (result != ES_OK)
+		goto finish;
+
+	switch (exit_code) {
+	case SVM_EXIT_RDTSC:
+	case SVM_EXIT_RDTSCP:
+		result = vc_handle_rdtsc(boot_ghcb, &ctxt, exit_code);
+		break;
+	case SVM_EXIT_IOIO:
+		result = vc_handle_ioio(boot_ghcb, &ctxt);
+		break;
+	case SVM_EXIT_CPUID:
+		result = vc_handle_cpuid(boot_ghcb, &ctxt);
+		break;
+	default:
+		result = ES_UNSUPPORTED;
+		break;
+	}
+
+finish:
+	if (result == ES_OK)
+		vc_finish_insn(&ctxt);
+	else if (result != ES_RETRY)
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
+}
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 6fe7e85..612b443 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -24,63 +24,11 @@
 #include <asm/cpuid.h>
 
 #include "error.h"
-#include "../msr.h"
+#include "sev.h"
 
 static struct ghcb boot_ghcb_page __aligned(PAGE_SIZE);
 struct ghcb *boot_ghcb;
 
-/*
- * Only a dummy for insn_get_seg_base() - Early boot-code is 64bit only and
- * doesn't use segments.
- */
-static unsigned long insn_get_seg_base(struct pt_regs *regs, int seg_reg_idx)
-{
-	return 0UL;
-}
-
-static inline u64 sev_es_rd_ghcb_msr(void)
-{
-	struct msr m;
-
-	boot_rdmsr(MSR_AMD64_SEV_ES_GHCB, &m);
-
-	return m.q;
-}
-
-static inline void sev_es_wr_ghcb_msr(u64 val)
-{
-	struct msr m;
-
-	m.q = val;
-	boot_wrmsr(MSR_AMD64_SEV_ES_GHCB, &m);
-}
-
-static enum es_result vc_write_mem(struct es_em_ctxt *ctxt,
-				   void *dst, char *buf, size_t size)
-{
-	memcpy(dst, buf, size);
-
-	return ES_OK;
-}
-
-static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
-				  void *src, char *buf, size_t size)
-{
-	memcpy(buf, src, size);
-
-	return ES_OK;
-}
-
-static enum es_result vc_ioio_check(struct es_em_ctxt *ctxt, u16 port, size_t size)
-{
-	return ES_OK;
-}
-
-static bool fault_in_kernel_space(unsigned long address)
-{
-	return false;
-}
-
 #undef __init
 #define __init
 
@@ -182,7 +130,7 @@ void snp_set_page_shared(unsigned long paddr)
 	__page_state_change(paddr, SNP_PAGE_STATE_SHARED);
 }
 
-static bool early_setup_ghcb(void)
+bool early_setup_ghcb(void)
 {
 	if (set_page_decrypted((unsigned long)&boot_ghcb_page))
 		return false;
@@ -266,46 +214,6 @@ bool sev_es_check_ghcb_fault(unsigned long address)
 	return ((address & PAGE_MASK) == (unsigned long)&boot_ghcb_page);
 }
 
-void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
-{
-	struct es_em_ctxt ctxt;
-	enum es_result result;
-
-	if (!boot_ghcb && !early_setup_ghcb())
-		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
-
-	vc_ghcb_invalidate(boot_ghcb);
-	result = vc_init_em_ctxt(&ctxt, regs, exit_code);
-	if (result != ES_OK)
-		goto finish;
-
-	result = vc_check_opcode_bytes(&ctxt, exit_code);
-	if (result != ES_OK)
-		goto finish;
-
-	switch (exit_code) {
-	case SVM_EXIT_RDTSC:
-	case SVM_EXIT_RDTSCP:
-		result = vc_handle_rdtsc(boot_ghcb, &ctxt, exit_code);
-		break;
-	case SVM_EXIT_IOIO:
-		result = vc_handle_ioio(boot_ghcb, &ctxt);
-		break;
-	case SVM_EXIT_CPUID:
-		result = vc_handle_cpuid(boot_ghcb, &ctxt);
-		break;
-	default:
-		result = ES_UNSUPPORTED;
-		break;
-	}
-
-finish:
-	if (result == ES_OK)
-		vc_finish_insn(&ctxt);
-	else if (result != ES_RETRY)
-		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
-}
-
 /*
  * SNP_FEATURES_IMPL_REQ is the mask of SNP features that will need
  * guest side implementation for proper functioning of the guest. If any
diff --git a/arch/x86/boot/compressed/sev.h b/arch/x86/boot/compressed/sev.h
index e87af54..92f79c2 100644
--- a/arch/x86/boot/compressed/sev.h
+++ b/arch/x86/boot/compressed/sev.h
@@ -10,10 +10,29 @@
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 
+#include "../msr.h"
+
 void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 u64 sev_get_status(void);
 bool early_is_sevsnp_guest(void);
 
+static inline u64 sev_es_rd_ghcb_msr(void)
+{
+	struct msr m;
+
+	boot_rdmsr(MSR_AMD64_SEV_ES_GHCB, &m);
+
+	return m.q;
+}
+
+static inline void sev_es_wr_ghcb_msr(u64 val)
+{
+	struct msr m;
+
+	m.q = val;
+	boot_wrmsr(MSR_AMD64_SEV_ES_GHCB, &m);
+}
+
 #else
 
 static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index 173f3d1..7a706db 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -14,13 +14,9 @@
 #ifndef __BOOT_COMPRESSED
 #define error(v)			pr_err(v)
 #define has_cpuflag(f)			boot_cpu_has(f)
-#define sev_printk(fmt, ...)		printk(fmt, ##__VA_ARGS__)
-#define sev_printk_rtl(fmt, ...)	printk_ratelimited(fmt, ##__VA_ARGS__)
 #else
 #undef WARN
 #define WARN(condition, format...) (!!(condition))
-#define sev_printk(fmt, ...)
-#define sev_printk_rtl(fmt, ...)
 #undef vc_forward_exception
 #define vc_forward_exception(c)		panic("SNP: Hypervisor requested exception\n")
 #endif
@@ -36,16 +32,6 @@
 struct svsm_ca *boot_svsm_caa __ro_after_init;
 u64 boot_svsm_caa_pa __ro_after_init;
 
-/* I/O parameters for CPUID-related helpers */
-struct cpuid_leaf {
-	u32 fn;
-	u32 subfn;
-	u32 eax;
-	u32 ebx;
-	u32 ecx;
-	u32 edx;
-};
-
 /*
  * Since feature negotiation related variables are set early in the boot
  * process they must reside in the .data section so as not to be zeroed
@@ -151,33 +137,6 @@ bool sev_es_negotiate_protocol(void)
 	return true;
 }
 
-static bool vc_decoding_needed(unsigned long exit_code)
-{
-	/* Exceptions don't require to decode the instruction */
-	return !(exit_code >= SVM_EXIT_EXCP_BASE &&
-		 exit_code <= SVM_EXIT_LAST_EXCP);
-}
-
-static enum es_result vc_init_em_ctxt(struct es_em_ctxt *ctxt,
-				      struct pt_regs *regs,
-				      unsigned long exit_code)
-{
-	enum es_result ret = ES_OK;
-
-	memset(ctxt, 0, sizeof(*ctxt));
-	ctxt->regs = regs;
-
-	if (vc_decoding_needed(exit_code))
-		ret = vc_decode_insn(ctxt);
-
-	return ret;
-}
-
-static void vc_finish_insn(struct es_em_ctxt *ctxt)
-{
-	ctxt->regs->ip += ctxt->insn.length;
-}
-
 static enum es_result verify_exception_info(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 {
 	u32 ret;
@@ -627,7 +586,7 @@ snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
  * Returns -EOPNOTSUPP if feature not enabled. Any other non-zero return value
  * should be treated as fatal by caller.
  */
-static int __head
+int __head
 snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
 {
 	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
@@ -737,391 +696,6 @@ fail:
 	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 }
 
-static enum es_result vc_insn_string_check(struct es_em_ctxt *ctxt,
-					   unsigned long address,
-					   bool write)
-{
-	if (user_mode(ctxt->regs) && fault_in_kernel_space(address)) {
-		ctxt->fi.vector     = X86_TRAP_PF;
-		ctxt->fi.error_code = X86_PF_USER;
-		ctxt->fi.cr2        = address;
-		if (write)
-			ctxt->fi.error_code |= X86_PF_WRITE;
-
-		return ES_EXCEPTION;
-	}
-
-	return ES_OK;
-}
-
-static enum es_result vc_insn_string_read(struct es_em_ctxt *ctxt,
-					  void *src, char *buf,
-					  unsigned int data_size,
-					  unsigned int count,
-					  bool backwards)
-{
-	int i, b = backwards ? -1 : 1;
-	unsigned long address = (unsigned long)src;
-	enum es_result ret;
-
-	ret = vc_insn_string_check(ctxt, address, false);
-	if (ret != ES_OK)
-		return ret;
-
-	for (i = 0; i < count; i++) {
-		void *s = src + (i * data_size * b);
-		char *d = buf + (i * data_size);
-
-		ret = vc_read_mem(ctxt, s, d, data_size);
-		if (ret != ES_OK)
-			break;
-	}
-
-	return ret;
-}
-
-static enum es_result vc_insn_string_write(struct es_em_ctxt *ctxt,
-					   void *dst, char *buf,
-					   unsigned int data_size,
-					   unsigned int count,
-					   bool backwards)
-{
-	int i, s = backwards ? -1 : 1;
-	unsigned long address = (unsigned long)dst;
-	enum es_result ret;
-
-	ret = vc_insn_string_check(ctxt, address, true);
-	if (ret != ES_OK)
-		return ret;
-
-	for (i = 0; i < count; i++) {
-		void *d = dst + (i * data_size * s);
-		char *b = buf + (i * data_size);
-
-		ret = vc_write_mem(ctxt, d, b, data_size);
-		if (ret != ES_OK)
-			break;
-	}
-
-	return ret;
-}
-
-#define IOIO_TYPE_STR  BIT(2)
-#define IOIO_TYPE_IN   1
-#define IOIO_TYPE_INS  (IOIO_TYPE_IN | IOIO_TYPE_STR)
-#define IOIO_TYPE_OUT  0
-#define IOIO_TYPE_OUTS (IOIO_TYPE_OUT | IOIO_TYPE_STR)
-
-#define IOIO_REP       BIT(3)
-
-#define IOIO_ADDR_64   BIT(9)
-#define IOIO_ADDR_32   BIT(8)
-#define IOIO_ADDR_16   BIT(7)
-
-#define IOIO_DATA_32   BIT(6)
-#define IOIO_DATA_16   BIT(5)
-#define IOIO_DATA_8    BIT(4)
-
-#define IOIO_SEG_ES    (0 << 10)
-#define IOIO_SEG_DS    (3 << 10)
-
-static enum es_result vc_ioio_exitinfo(struct es_em_ctxt *ctxt, u64 *exitinfo)
-{
-	struct insn *insn = &ctxt->insn;
-	size_t size;
-	u64 port;
-
-	*exitinfo = 0;
-
-	switch (insn->opcode.bytes[0]) {
-	/* INS opcodes */
-	case 0x6c:
-	case 0x6d:
-		*exitinfo |= IOIO_TYPE_INS;
-		*exitinfo |= IOIO_SEG_ES;
-		port	   = ctxt->regs->dx & 0xffff;
-		break;
-
-	/* OUTS opcodes */
-	case 0x6e:
-	case 0x6f:
-		*exitinfo |= IOIO_TYPE_OUTS;
-		*exitinfo |= IOIO_SEG_DS;
-		port	   = ctxt->regs->dx & 0xffff;
-		break;
-
-	/* IN immediate opcodes */
-	case 0xe4:
-	case 0xe5:
-		*exitinfo |= IOIO_TYPE_IN;
-		port	   = (u8)insn->immediate.value & 0xffff;
-		break;
-
-	/* OUT immediate opcodes */
-	case 0xe6:
-	case 0xe7:
-		*exitinfo |= IOIO_TYPE_OUT;
-		port	   = (u8)insn->immediate.value & 0xffff;
-		break;
-
-	/* IN register opcodes */
-	case 0xec:
-	case 0xed:
-		*exitinfo |= IOIO_TYPE_IN;
-		port	   = ctxt->regs->dx & 0xffff;
-		break;
-
-	/* OUT register opcodes */
-	case 0xee:
-	case 0xef:
-		*exitinfo |= IOIO_TYPE_OUT;
-		port	   = ctxt->regs->dx & 0xffff;
-		break;
-
-	default:
-		return ES_DECODE_FAILED;
-	}
-
-	*exitinfo |= port << 16;
-
-	switch (insn->opcode.bytes[0]) {
-	case 0x6c:
-	case 0x6e:
-	case 0xe4:
-	case 0xe6:
-	case 0xec:
-	case 0xee:
-		/* Single byte opcodes */
-		*exitinfo |= IOIO_DATA_8;
-		size       = 1;
-		break;
-	default:
-		/* Length determined by instruction parsing */
-		*exitinfo |= (insn->opnd_bytes == 2) ? IOIO_DATA_16
-						     : IOIO_DATA_32;
-		size       = (insn->opnd_bytes == 2) ? 2 : 4;
-	}
-
-	switch (insn->addr_bytes) {
-	case 2:
-		*exitinfo |= IOIO_ADDR_16;
-		break;
-	case 4:
-		*exitinfo |= IOIO_ADDR_32;
-		break;
-	case 8:
-		*exitinfo |= IOIO_ADDR_64;
-		break;
-	}
-
-	if (insn_has_rep_prefix(insn))
-		*exitinfo |= IOIO_REP;
-
-	return vc_ioio_check(ctxt, (u16)port, size);
-}
-
-static enum es_result vc_handle_ioio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
-{
-	struct pt_regs *regs = ctxt->regs;
-	u64 exit_info_1, exit_info_2;
-	enum es_result ret;
-
-	ret = vc_ioio_exitinfo(ctxt, &exit_info_1);
-	if (ret != ES_OK)
-		return ret;
-
-	if (exit_info_1 & IOIO_TYPE_STR) {
-
-		/* (REP) INS/OUTS */
-
-		bool df = ((regs->flags & X86_EFLAGS_DF) == X86_EFLAGS_DF);
-		unsigned int io_bytes, exit_bytes;
-		unsigned int ghcb_count, op_count;
-		unsigned long es_base;
-		u64 sw_scratch;
-
-		/*
-		 * For the string variants with rep prefix the amount of in/out
-		 * operations per #VC exception is limited so that the kernel
-		 * has a chance to take interrupts and re-schedule while the
-		 * instruction is emulated.
-		 */
-		io_bytes   = (exit_info_1 >> 4) & 0x7;
-		ghcb_count = sizeof(ghcb->shared_buffer) / io_bytes;
-
-		op_count    = (exit_info_1 & IOIO_REP) ? regs->cx : 1;
-		exit_info_2 = min(op_count, ghcb_count);
-		exit_bytes  = exit_info_2 * io_bytes;
-
-		es_base = insn_get_seg_base(ctxt->regs, INAT_SEG_REG_ES);
-
-		/* Read bytes of OUTS into the shared buffer */
-		if (!(exit_info_1 & IOIO_TYPE_IN)) {
-			ret = vc_insn_string_read(ctxt,
-					       (void *)(es_base + regs->si),
-					       ghcb->shared_buffer, io_bytes,
-					       exit_info_2, df);
-			if (ret)
-				return ret;
-		}
-
-		/*
-		 * Issue an VMGEXIT to the HV to consume the bytes from the
-		 * shared buffer or to have it write them into the shared buffer
-		 * depending on the instruction: OUTS or INS.
-		 */
-		sw_scratch = __pa(ghcb) + offsetof(struct ghcb, shared_buffer);
-		ghcb_set_sw_scratch(ghcb, sw_scratch);
-		ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_IOIO,
-					  exit_info_1, exit_info_2);
-		if (ret != ES_OK)
-			return ret;
-
-		/* Read bytes from shared buffer into the guest's destination. */
-		if (exit_info_1 & IOIO_TYPE_IN) {
-			ret = vc_insn_string_write(ctxt,
-						   (void *)(es_base + regs->di),
-						   ghcb->shared_buffer, io_bytes,
-						   exit_info_2, df);
-			if (ret)
-				return ret;
-
-			if (df)
-				regs->di -= exit_bytes;
-			else
-				regs->di += exit_bytes;
-		} else {
-			if (df)
-				regs->si -= exit_bytes;
-			else
-				regs->si += exit_bytes;
-		}
-
-		if (exit_info_1 & IOIO_REP)
-			regs->cx -= exit_info_2;
-
-		ret = regs->cx ? ES_RETRY : ES_OK;
-
-	} else {
-
-		/* IN/OUT into/from rAX */
-
-		int bits = (exit_info_1 & 0x70) >> 1;
-		u64 rax = 0;
-
-		if (!(exit_info_1 & IOIO_TYPE_IN))
-			rax = lower_bits(regs->ax, bits);
-
-		ghcb_set_rax(ghcb, rax);
-
-		ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_IOIO, exit_info_1, 0);
-		if (ret != ES_OK)
-			return ret;
-
-		if (exit_info_1 & IOIO_TYPE_IN) {
-			if (!ghcb_rax_is_valid(ghcb))
-				return ES_VMM_ERROR;
-			regs->ax = lower_bits(ghcb->save.rax, bits);
-		}
-	}
-
-	return ret;
-}
-
-static int vc_handle_cpuid_snp(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
-{
-	struct pt_regs *regs = ctxt->regs;
-	struct cpuid_leaf leaf;
-	int ret;
-
-	leaf.fn = regs->ax;
-	leaf.subfn = regs->cx;
-	ret = snp_cpuid(ghcb, ctxt, &leaf);
-	if (!ret) {
-		regs->ax = leaf.eax;
-		regs->bx = leaf.ebx;
-		regs->cx = leaf.ecx;
-		regs->dx = leaf.edx;
-	}
-
-	return ret;
-}
-
-static enum es_result vc_handle_cpuid(struct ghcb *ghcb,
-				      struct es_em_ctxt *ctxt)
-{
-	struct pt_regs *regs = ctxt->regs;
-	u32 cr4 = native_read_cr4();
-	enum es_result ret;
-	int snp_cpuid_ret;
-
-	snp_cpuid_ret = vc_handle_cpuid_snp(ghcb, ctxt);
-	if (!snp_cpuid_ret)
-		return ES_OK;
-	if (snp_cpuid_ret != -EOPNOTSUPP)
-		return ES_VMM_ERROR;
-
-	ghcb_set_rax(ghcb, regs->ax);
-	ghcb_set_rcx(ghcb, regs->cx);
-
-	if (cr4 & X86_CR4_OSXSAVE)
-		/* Safe to read xcr0 */
-		ghcb_set_xcr0(ghcb, xgetbv(XCR_XFEATURE_ENABLED_MASK));
-	else
-		/* xgetbv will cause #GP - use reset value for xcr0 */
-		ghcb_set_xcr0(ghcb, 1);
-
-	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_CPUID, 0, 0);
-	if (ret != ES_OK)
-		return ret;
-
-	if (!(ghcb_rax_is_valid(ghcb) &&
-	      ghcb_rbx_is_valid(ghcb) &&
-	      ghcb_rcx_is_valid(ghcb) &&
-	      ghcb_rdx_is_valid(ghcb)))
-		return ES_VMM_ERROR;
-
-	regs->ax = ghcb->save.rax;
-	regs->bx = ghcb->save.rbx;
-	regs->cx = ghcb->save.rcx;
-	regs->dx = ghcb->save.rdx;
-
-	return ES_OK;
-}
-
-static enum es_result vc_handle_rdtsc(struct ghcb *ghcb,
-				      struct es_em_ctxt *ctxt,
-				      unsigned long exit_code)
-{
-	bool rdtscp = (exit_code == SVM_EXIT_RDTSCP);
-	enum es_result ret;
-
-	/*
-	 * The hypervisor should not be intercepting RDTSC/RDTSCP when Secure
-	 * TSC is enabled. A #VC exception will be generated if the RDTSC/RDTSCP
-	 * instructions are being intercepted. If this should occur and Secure
-	 * TSC is enabled, guest execution should be terminated as the guest
-	 * cannot rely on the TSC value provided by the hypervisor.
-	 */
-	if (sev_status & MSR_AMD64_SNP_SECURE_TSC)
-		return ES_VMM_ERROR;
-
-	ret = sev_es_ghcb_hv_call(ghcb, ctxt, exit_code, 0, 0);
-	if (ret != ES_OK)
-		return ret;
-
-	if (!(ghcb_rax_is_valid(ghcb) && ghcb_rdx_is_valid(ghcb) &&
-	     (!rdtscp || ghcb_rcx_is_valid(ghcb))))
-		return ES_VMM_ERROR;
-
-	ctxt->regs->ax = ghcb->save.rax;
-	ctxt->regs->dx = ghcb->save.rdx;
-	if (rdtscp)
-		ctxt->regs->cx = ghcb->save.rcx;
-
-	return ES_OK;
-}
-
 struct cc_setup_data {
 	struct setup_data header;
 	u32 cc_blob_address;
@@ -1238,97 +812,6 @@ static void __head pvalidate_4k_page(unsigned long vaddr, unsigned long paddr,
 	}
 }
 
-static enum es_result vc_check_opcode_bytes(struct es_em_ctxt *ctxt,
-					    unsigned long exit_code)
-{
-	unsigned int opcode = (unsigned int)ctxt->insn.opcode.value;
-	u8 modrm = ctxt->insn.modrm.value;
-
-	switch (exit_code) {
-
-	case SVM_EXIT_IOIO:
-	case SVM_EXIT_NPF:
-		/* handled separately */
-		return ES_OK;
-
-	case SVM_EXIT_CPUID:
-		if (opcode == 0xa20f)
-			return ES_OK;
-		break;
-
-	case SVM_EXIT_INVD:
-		if (opcode == 0x080f)
-			return ES_OK;
-		break;
-
-	case SVM_EXIT_MONITOR:
-		/* MONITOR and MONITORX instructions generate the same error code */
-		if (opcode == 0x010f && (modrm == 0xc8 || modrm == 0xfa))
-			return ES_OK;
-		break;
-
-	case SVM_EXIT_MWAIT:
-		/* MWAIT and MWAITX instructions generate the same error code */
-		if (opcode == 0x010f && (modrm == 0xc9 || modrm == 0xfb))
-			return ES_OK;
-		break;
-
-	case SVM_EXIT_MSR:
-		/* RDMSR */
-		if (opcode == 0x320f ||
-		/* WRMSR */
-		    opcode == 0x300f)
-			return ES_OK;
-		break;
-
-	case SVM_EXIT_RDPMC:
-		if (opcode == 0x330f)
-			return ES_OK;
-		break;
-
-	case SVM_EXIT_RDTSC:
-		if (opcode == 0x310f)
-			return ES_OK;
-		break;
-
-	case SVM_EXIT_RDTSCP:
-		if (opcode == 0x010f && modrm == 0xf9)
-			return ES_OK;
-		break;
-
-	case SVM_EXIT_READ_DR7:
-		if (opcode == 0x210f &&
-		    X86_MODRM_REG(ctxt->insn.modrm.value) == 7)
-			return ES_OK;
-		break;
-
-	case SVM_EXIT_VMMCALL:
-		if (opcode == 0x010f && modrm == 0xd9)
-			return ES_OK;
-
-		break;
-
-	case SVM_EXIT_WRITE_DR7:
-		if (opcode == 0x230f &&
-		    X86_MODRM_REG(ctxt->insn.modrm.value) == 7)
-			return ES_OK;
-		break;
-
-	case SVM_EXIT_WBINVD:
-		if (opcode == 0x90f)
-			return ES_OK;
-		break;
-
-	default:
-		break;
-	}
-
-	sev_printk(KERN_ERR "Wrong/unhandled opcode bytes: 0x%x, exit_code: 0x%lx, rIP: 0x%lx\n",
-		   opcode, exit_code, ctxt->regs->ip);
-
-	return ES_UNSUPPORTED;
-}
-
 /*
  * Maintain the GPA of the SVSM Calling Area (CA) in order to utilize the SVSM
  * services needed when not running in VMPL0.
diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index f901ce9..435853a 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -9,7 +9,6 @@
 
 #define pr_fmt(fmt)	"SEV: " fmt
 
-#include <linux/sched/debug.h>	/* For show_regs() */
 #include <linux/percpu-defs.h>
 #include <linux/cc_platform.h>
 #include <linux/printk.h>
@@ -112,315 +111,6 @@ noinstr struct ghcb *__sev_get_ghcb(struct ghcb_state *state)
 	return ghcb;
 }
 
-static int vc_fetch_insn_kernel(struct es_em_ctxt *ctxt,
-				unsigned char *buffer)
-{
-	return copy_from_kernel_nofault(buffer, (unsigned char *)ctxt->regs->ip, MAX_INSN_SIZE);
-}
-
-static enum es_result __vc_decode_user_insn(struct es_em_ctxt *ctxt)
-{
-	char buffer[MAX_INSN_SIZE];
-	int insn_bytes;
-
-	insn_bytes = insn_fetch_from_user_inatomic(ctxt->regs, buffer);
-	if (insn_bytes == 0) {
-		/* Nothing could be copied */
-		ctxt->fi.vector     = X86_TRAP_PF;
-		ctxt->fi.error_code = X86_PF_INSTR | X86_PF_USER;
-		ctxt->fi.cr2        = ctxt->regs->ip;
-		return ES_EXCEPTION;
-	} else if (insn_bytes == -EINVAL) {
-		/* Effective RIP could not be calculated */
-		ctxt->fi.vector     = X86_TRAP_GP;
-		ctxt->fi.error_code = 0;
-		ctxt->fi.cr2        = 0;
-		return ES_EXCEPTION;
-	}
-
-	if (!insn_decode_from_regs(&ctxt->insn, ctxt->regs, buffer, insn_bytes))
-		return ES_DECODE_FAILED;
-
-	if (ctxt->insn.immediate.got)
-		return ES_OK;
-	else
-		return ES_DECODE_FAILED;
-}
-
-static enum es_result __vc_decode_kern_insn(struct es_em_ctxt *ctxt)
-{
-	char buffer[MAX_INSN_SIZE];
-	int res, ret;
-
-	res = vc_fetch_insn_kernel(ctxt, buffer);
-	if (res) {
-		ctxt->fi.vector     = X86_TRAP_PF;
-		ctxt->fi.error_code = X86_PF_INSTR;
-		ctxt->fi.cr2        = ctxt->regs->ip;
-		return ES_EXCEPTION;
-	}
-
-	ret = insn_decode(&ctxt->insn, buffer, MAX_INSN_SIZE, INSN_MODE_64);
-	if (ret < 0)
-		return ES_DECODE_FAILED;
-	else
-		return ES_OK;
-}
-
-static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
-{
-	if (user_mode(ctxt->regs))
-		return __vc_decode_user_insn(ctxt);
-	else
-		return __vc_decode_kern_insn(ctxt);
-}
-
-static enum es_result vc_write_mem(struct es_em_ctxt *ctxt,
-				   char *dst, char *buf, size_t size)
-{
-	unsigned long error_code = X86_PF_PROT | X86_PF_WRITE;
-
-	/*
-	 * This function uses __put_user() independent of whether kernel or user
-	 * memory is accessed. This works fine because __put_user() does no
-	 * sanity checks of the pointer being accessed. All that it does is
-	 * to report when the access failed.
-	 *
-	 * Also, this function runs in atomic context, so __put_user() is not
-	 * allowed to sleep. The page-fault handler detects that it is running
-	 * in atomic context and will not try to take mmap_sem and handle the
-	 * fault, so additional pagefault_enable()/disable() calls are not
-	 * needed.
-	 *
-	 * The access can't be done via copy_to_user() here because
-	 * vc_write_mem() must not use string instructions to access unsafe
-	 * memory. The reason is that MOVS is emulated by the #VC handler by
-	 * splitting the move up into a read and a write and taking a nested #VC
-	 * exception on whatever of them is the MMIO access. Using string
-	 * instructions here would cause infinite nesting.
-	 */
-	switch (size) {
-	case 1: {
-		u8 d1;
-		u8 __user *target = (u8 __user *)dst;
-
-		memcpy(&d1, buf, 1);
-		if (__put_user(d1, target))
-			goto fault;
-		break;
-	}
-	case 2: {
-		u16 d2;
-		u16 __user *target = (u16 __user *)dst;
-
-		memcpy(&d2, buf, 2);
-		if (__put_user(d2, target))
-			goto fault;
-		break;
-	}
-	case 4: {
-		u32 d4;
-		u32 __user *target = (u32 __user *)dst;
-
-		memcpy(&d4, buf, 4);
-		if (__put_user(d4, target))
-			goto fault;
-		break;
-	}
-	case 8: {
-		u64 d8;
-		u64 __user *target = (u64 __user *)dst;
-
-		memcpy(&d8, buf, 8);
-		if (__put_user(d8, target))
-			goto fault;
-		break;
-	}
-	default:
-		WARN_ONCE(1, "%s: Invalid size: %zu\n", __func__, size);
-		return ES_UNSUPPORTED;
-	}
-
-	return ES_OK;
-
-fault:
-	if (user_mode(ctxt->regs))
-		error_code |= X86_PF_USER;
-
-	ctxt->fi.vector = X86_TRAP_PF;
-	ctxt->fi.error_code = error_code;
-	ctxt->fi.cr2 = (unsigned long)dst;
-
-	return ES_EXCEPTION;
-}
-
-static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
-				  char *src, char *buf, size_t size)
-{
-	unsigned long error_code = X86_PF_PROT;
-
-	/*
-	 * This function uses __get_user() independent of whether kernel or user
-	 * memory is accessed. This works fine because __get_user() does no
-	 * sanity checks of the pointer being accessed. All that it does is
-	 * to report when the access failed.
-	 *
-	 * Also, this function runs in atomic context, so __get_user() is not
-	 * allowed to sleep. The page-fault handler detects that it is running
-	 * in atomic context and will not try to take mmap_sem and handle the
-	 * fault, so additional pagefault_enable()/disable() calls are not
-	 * needed.
-	 *
-	 * The access can't be done via copy_from_user() here because
-	 * vc_read_mem() must not use string instructions to access unsafe
-	 * memory. The reason is that MOVS is emulated by the #VC handler by
-	 * splitting the move up into a read and a write and taking a nested #VC
-	 * exception on whatever of them is the MMIO access. Using string
-	 * instructions here would cause infinite nesting.
-	 */
-	switch (size) {
-	case 1: {
-		u8 d1;
-		u8 __user *s = (u8 __user *)src;
-
-		if (__get_user(d1, s))
-			goto fault;
-		memcpy(buf, &d1, 1);
-		break;
-	}
-	case 2: {
-		u16 d2;
-		u16 __user *s = (u16 __user *)src;
-
-		if (__get_user(d2, s))
-			goto fault;
-		memcpy(buf, &d2, 2);
-		break;
-	}
-	case 4: {
-		u32 d4;
-		u32 __user *s = (u32 __user *)src;
-
-		if (__get_user(d4, s))
-			goto fault;
-		memcpy(buf, &d4, 4);
-		break;
-	}
-	case 8: {
-		u64 d8;
-		u64 __user *s = (u64 __user *)src;
-		if (__get_user(d8, s))
-			goto fault;
-		memcpy(buf, &d8, 8);
-		break;
-	}
-	default:
-		WARN_ONCE(1, "%s: Invalid size: %zu\n", __func__, size);
-		return ES_UNSUPPORTED;
-	}
-
-	return ES_OK;
-
-fault:
-	if (user_mode(ctxt->regs))
-		error_code |= X86_PF_USER;
-
-	ctxt->fi.vector = X86_TRAP_PF;
-	ctxt->fi.error_code = error_code;
-	ctxt->fi.cr2 = (unsigned long)src;
-
-	return ES_EXCEPTION;
-}
-
-static enum es_result vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
-					   unsigned long vaddr, phys_addr_t *paddr)
-{
-	unsigned long va = (unsigned long)vaddr;
-	unsigned int level;
-	phys_addr_t pa;
-	pgd_t *pgd;
-	pte_t *pte;
-
-	pgd = __va(read_cr3_pa());
-	pgd = &pgd[pgd_index(va)];
-	pte = lookup_address_in_pgd(pgd, va, &level);
-	if (!pte) {
-		ctxt->fi.vector     = X86_TRAP_PF;
-		ctxt->fi.cr2        = vaddr;
-		ctxt->fi.error_code = 0;
-
-		if (user_mode(ctxt->regs))
-			ctxt->fi.error_code |= X86_PF_USER;
-
-		return ES_EXCEPTION;
-	}
-
-	if (WARN_ON_ONCE(pte_val(*pte) & _PAGE_ENC))
-		/* Emulated MMIO to/from encrypted memory not supported */
-		return ES_UNSUPPORTED;
-
-	pa = (phys_addr_t)pte_pfn(*pte) << PAGE_SHIFT;
-	pa |= va & ~page_level_mask(level);
-
-	*paddr = pa;
-
-	return ES_OK;
-}
-
-static enum es_result vc_ioio_check(struct es_em_ctxt *ctxt, u16 port, size_t size)
-{
-	BUG_ON(size > 4);
-
-	if (user_mode(ctxt->regs)) {
-		struct thread_struct *t = &current->thread;
-		struct io_bitmap *iobm = t->io_bitmap;
-		size_t idx;
-
-		if (!iobm)
-			goto fault;
-
-		for (idx = port; idx < port + size; ++idx) {
-			if (test_bit(idx, iobm->bitmap))
-				goto fault;
-		}
-	}
-
-	return ES_OK;
-
-fault:
-	ctxt->fi.vector = X86_TRAP_GP;
-	ctxt->fi.error_code = 0;
-
-	return ES_EXCEPTION;
-}
-
-static __always_inline void vc_forward_exception(struct es_em_ctxt *ctxt)
-{
-	long error_code = ctxt->fi.error_code;
-	int trapnr = ctxt->fi.vector;
-
-	ctxt->regs->orig_ax = ctxt->fi.error_code;
-
-	switch (trapnr) {
-	case X86_TRAP_GP:
-		exc_general_protection(ctxt->regs, error_code);
-		break;
-	case X86_TRAP_UD:
-		exc_invalid_op(ctxt->regs);
-		break;
-	case X86_TRAP_PF:
-		write_cr2(ctxt->fi.cr2);
-		exc_page_fault(ctxt->regs, error_code);
-		break;
-	case X86_TRAP_AC:
-		exc_alignment_check(ctxt->regs, error_code);
-		break;
-	default:
-		pr_emerg("Unsupported exception in #VC instruction emulation - can't continue\n");
-		BUG();
-	}
-}
-
 /* Include code shared with pre-decompression boot stage */
 #include "sev-shared.c"
 
@@ -563,718 +253,6 @@ void __head early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr
 	early_set_pages_state(vaddr, paddr, npages, SNP_PAGE_STATE_SHARED);
 }
 
-/* Writes to the SVSM CAA MSR are ignored */
-static enum es_result __vc_handle_msr_caa(struct pt_regs *regs, bool write)
-{
-	if (write)
-		return ES_OK;
-
-	regs->ax = lower_32_bits(this_cpu_read(svsm_caa_pa));
-	regs->dx = upper_32_bits(this_cpu_read(svsm_caa_pa));
-
-	return ES_OK;
-}
-
-/*
- * TSC related accesses should not exit to the hypervisor when a guest is
- * executing with Secure TSC enabled, so special handling is required for
- * accesses of MSR_IA32_TSC and MSR_AMD64_GUEST_TSC_FREQ.
- */
-static enum es_result __vc_handle_secure_tsc_msrs(struct pt_regs *regs, bool write)
-{
-	u64 tsc;
-
-	/*
-	 * GUEST_TSC_FREQ should not be intercepted when Secure TSC is enabled.
-	 * Terminate the SNP guest when the interception is enabled.
-	 */
-	if (regs->cx == MSR_AMD64_GUEST_TSC_FREQ)
-		return ES_VMM_ERROR;
-
-	/*
-	 * Writes: Writing to MSR_IA32_TSC can cause subsequent reads of the TSC
-	 *         to return undefined values, so ignore all writes.
-	 *
-	 * Reads: Reads of MSR_IA32_TSC should return the current TSC value, use
-	 *        the value returned by rdtsc_ordered().
-	 */
-	if (write) {
-		WARN_ONCE(1, "TSC MSR writes are verboten!\n");
-		return ES_OK;
-	}
-
-	tsc = rdtsc_ordered();
-	regs->ax = lower_32_bits(tsc);
-	regs->dx = upper_32_bits(tsc);
-
-	return ES_OK;
-}
-
-static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
-{
-	struct pt_regs *regs = ctxt->regs;
-	enum es_result ret;
-	bool write;
-
-	/* Is it a WRMSR? */
-	write = ctxt->insn.opcode.bytes[1] == 0x30;
-
-	switch (regs->cx) {
-	case MSR_SVSM_CAA:
-		return __vc_handle_msr_caa(regs, write);
-	case MSR_IA32_TSC:
-	case MSR_AMD64_GUEST_TSC_FREQ:
-		if (sev_status & MSR_AMD64_SNP_SECURE_TSC)
-			return __vc_handle_secure_tsc_msrs(regs, write);
-		break;
-	default:
-		break;
-	}
-
-	ghcb_set_rcx(ghcb, regs->cx);
-	if (write) {
-		ghcb_set_rax(ghcb, regs->ax);
-		ghcb_set_rdx(ghcb, regs->dx);
-	}
-
-	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_MSR, write, 0);
-
-	if ((ret == ES_OK) && !write) {
-		regs->ax = ghcb->save.rax;
-		regs->dx = ghcb->save.rdx;
-	}
-
-	return ret;
-}
-
-static void __init vc_early_forward_exception(struct es_em_ctxt *ctxt)
-{
-	int trapnr = ctxt->fi.vector;
-
-	if (trapnr == X86_TRAP_PF)
-		native_write_cr2(ctxt->fi.cr2);
-
-	ctxt->regs->orig_ax = ctxt->fi.error_code;
-	do_early_exception(ctxt->regs, trapnr);
-}
-
-static long *vc_insn_get_rm(struct es_em_ctxt *ctxt)
-{
-	long *reg_array;
-	int offset;
-
-	reg_array = (long *)ctxt->regs;
-	offset    = insn_get_modrm_rm_off(&ctxt->insn, ctxt->regs);
-
-	if (offset < 0)
-		return NULL;
-
-	offset /= sizeof(long);
-
-	return reg_array + offset;
-}
-static enum es_result vc_do_mmio(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
-				 unsigned int bytes, bool read)
-{
-	u64 exit_code, exit_info_1, exit_info_2;
-	unsigned long ghcb_pa = __pa(ghcb);
-	enum es_result res;
-	phys_addr_t paddr;
-	void __user *ref;
-
-	ref = insn_get_addr_ref(&ctxt->insn, ctxt->regs);
-	if (ref == (void __user *)-1L)
-		return ES_UNSUPPORTED;
-
-	exit_code = read ? SVM_VMGEXIT_MMIO_READ : SVM_VMGEXIT_MMIO_WRITE;
-
-	res = vc_slow_virt_to_phys(ghcb, ctxt, (unsigned long)ref, &paddr);
-	if (res != ES_OK) {
-		if (res == ES_EXCEPTION && !read)
-			ctxt->fi.error_code |= X86_PF_WRITE;
-
-		return res;
-	}
-
-	exit_info_1 = paddr;
-	/* Can never be greater than 8 */
-	exit_info_2 = bytes;
-
-	ghcb_set_sw_scratch(ghcb, ghcb_pa + offsetof(struct ghcb, shared_buffer));
-
-	return sev_es_ghcb_hv_call(ghcb, ctxt, exit_code, exit_info_1, exit_info_2);
-}
-
-/*
- * The MOVS instruction has two memory operands, which raises the
- * problem that it is not known whether the access to the source or the
- * destination caused the #VC exception (and hence whether an MMIO read
- * or write operation needs to be emulated).
- *
- * Instead of playing games with walking page-tables and trying to guess
- * whether the source or destination is an MMIO range, split the move
- * into two operations, a read and a write with only one memory operand.
- * This will cause a nested #VC exception on the MMIO address which can
- * then be handled.
- *
- * This implementation has the benefit that it also supports MOVS where
- * source _and_ destination are MMIO regions.
- *
- * It will slow MOVS on MMIO down a lot, but in SEV-ES guests it is a
- * rare operation. If it turns out to be a performance problem the split
- * operations can be moved to memcpy_fromio() and memcpy_toio().
- */
-static enum es_result vc_handle_mmio_movs(struct es_em_ctxt *ctxt,
-					  unsigned int bytes)
-{
-	unsigned long ds_base, es_base;
-	unsigned char *src, *dst;
-	unsigned char buffer[8];
-	enum es_result ret;
-	bool rep;
-	int off;
-
-	ds_base = insn_get_seg_base(ctxt->regs, INAT_SEG_REG_DS);
-	es_base = insn_get_seg_base(ctxt->regs, INAT_SEG_REG_ES);
-
-	if (ds_base == -1L || es_base == -1L) {
-		ctxt->fi.vector = X86_TRAP_GP;
-		ctxt->fi.error_code = 0;
-		return ES_EXCEPTION;
-	}
-
-	src = ds_base + (unsigned char *)ctxt->regs->si;
-	dst = es_base + (unsigned char *)ctxt->regs->di;
-
-	ret = vc_read_mem(ctxt, src, buffer, bytes);
-	if (ret != ES_OK)
-		return ret;
-
-	ret = vc_write_mem(ctxt, dst, buffer, bytes);
-	if (ret != ES_OK)
-		return ret;
-
-	if (ctxt->regs->flags & X86_EFLAGS_DF)
-		off = -bytes;
-	else
-		off =  bytes;
-
-	ctxt->regs->si += off;
-	ctxt->regs->di += off;
-
-	rep = insn_has_rep_prefix(&ctxt->insn);
-	if (rep)
-		ctxt->regs->cx -= 1;
-
-	if (!rep || ctxt->regs->cx == 0)
-		return ES_OK;
-	else
-		return ES_RETRY;
-}
-
-static enum es_result vc_handle_mmio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
-{
-	struct insn *insn = &ctxt->insn;
-	enum insn_mmio_type mmio;
-	unsigned int bytes = 0;
-	enum es_result ret;
-	u8 sign_byte;
-	long *reg_data;
-
-	mmio = insn_decode_mmio(insn, &bytes);
-	if (mmio == INSN_MMIO_DECODE_FAILED)
-		return ES_DECODE_FAILED;
-
-	if (mmio != INSN_MMIO_WRITE_IMM && mmio != INSN_MMIO_MOVS) {
-		reg_data = insn_get_modrm_reg_ptr(insn, ctxt->regs);
-		if (!reg_data)
-			return ES_DECODE_FAILED;
-	}
-
-	if (user_mode(ctxt->regs))
-		return ES_UNSUPPORTED;
-
-	switch (mmio) {
-	case INSN_MMIO_WRITE:
-		memcpy(ghcb->shared_buffer, reg_data, bytes);
-		ret = vc_do_mmio(ghcb, ctxt, bytes, false);
-		break;
-	case INSN_MMIO_WRITE_IMM:
-		memcpy(ghcb->shared_buffer, insn->immediate1.bytes, bytes);
-		ret = vc_do_mmio(ghcb, ctxt, bytes, false);
-		break;
-	case INSN_MMIO_READ:
-		ret = vc_do_mmio(ghcb, ctxt, bytes, true);
-		if (ret)
-			break;
-
-		/* Zero-extend for 32-bit operation */
-		if (bytes == 4)
-			*reg_data = 0;
-
-		memcpy(reg_data, ghcb->shared_buffer, bytes);
-		break;
-	case INSN_MMIO_READ_ZERO_EXTEND:
-		ret = vc_do_mmio(ghcb, ctxt, bytes, true);
-		if (ret)
-			break;
-
-		/* Zero extend based on operand size */
-		memset(reg_data, 0, insn->opnd_bytes);
-		memcpy(reg_data, ghcb->shared_buffer, bytes);
-		break;
-	case INSN_MMIO_READ_SIGN_EXTEND:
-		ret = vc_do_mmio(ghcb, ctxt, bytes, true);
-		if (ret)
-			break;
-
-		if (bytes == 1) {
-			u8 *val = (u8 *)ghcb->shared_buffer;
-
-			sign_byte = (*val & 0x80) ? 0xff : 0x00;
-		} else {
-			u16 *val = (u16 *)ghcb->shared_buffer;
-
-			sign_byte = (*val & 0x8000) ? 0xff : 0x00;
-		}
-
-		/* Sign extend based on operand size */
-		memset(reg_data, sign_byte, insn->opnd_bytes);
-		memcpy(reg_data, ghcb->shared_buffer, bytes);
-		break;
-	case INSN_MMIO_MOVS:
-		ret = vc_handle_mmio_movs(ctxt, bytes);
-		break;
-	default:
-		ret = ES_UNSUPPORTED;
-		break;
-	}
-
-	return ret;
-}
-
-static enum es_result vc_handle_dr7_write(struct ghcb *ghcb,
-					  struct es_em_ctxt *ctxt)
-{
-	struct sev_es_runtime_data *data = this_cpu_read(runtime_data);
-	long val, *reg = vc_insn_get_rm(ctxt);
-	enum es_result ret;
-
-	if (sev_status & MSR_AMD64_SNP_DEBUG_SWAP)
-		return ES_VMM_ERROR;
-
-	if (!reg)
-		return ES_DECODE_FAILED;
-
-	val = *reg;
-
-	/* Upper 32 bits must be written as zeroes */
-	if (val >> 32) {
-		ctxt->fi.vector = X86_TRAP_GP;
-		ctxt->fi.error_code = 0;
-		return ES_EXCEPTION;
-	}
-
-	/* Clear out other reserved bits and set bit 10 */
-	val = (val & 0xffff23ffL) | BIT(10);
-
-	/* Early non-zero writes to DR7 are not supported */
-	if (!data && (val & ~DR7_RESET_VALUE))
-		return ES_UNSUPPORTED;
-
-	/* Using a value of 0 for ExitInfo1 means RAX holds the value */
-	ghcb_set_rax(ghcb, val);
-	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_WRITE_DR7, 0, 0);
-	if (ret != ES_OK)
-		return ret;
-
-	if (data)
-		data->dr7 = val;
-
-	return ES_OK;
-}
-
-static enum es_result vc_handle_dr7_read(struct ghcb *ghcb,
-					 struct es_em_ctxt *ctxt)
-{
-	struct sev_es_runtime_data *data = this_cpu_read(runtime_data);
-	long *reg = vc_insn_get_rm(ctxt);
-
-	if (sev_status & MSR_AMD64_SNP_DEBUG_SWAP)
-		return ES_VMM_ERROR;
-
-	if (!reg)
-		return ES_DECODE_FAILED;
-
-	if (data)
-		*reg = data->dr7;
-	else
-		*reg = DR7_RESET_VALUE;
-
-	return ES_OK;
-}
-
-static enum es_result vc_handle_wbinvd(struct ghcb *ghcb,
-				       struct es_em_ctxt *ctxt)
-{
-	return sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_WBINVD, 0, 0);
-}
-
-static enum es_result vc_handle_rdpmc(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
-{
-	enum es_result ret;
-
-	ghcb_set_rcx(ghcb, ctxt->regs->cx);
-
-	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_RDPMC, 0, 0);
-	if (ret != ES_OK)
-		return ret;
-
-	if (!(ghcb_rax_is_valid(ghcb) && ghcb_rdx_is_valid(ghcb)))
-		return ES_VMM_ERROR;
-
-	ctxt->regs->ax = ghcb->save.rax;
-	ctxt->regs->dx = ghcb->save.rdx;
-
-	return ES_OK;
-}
-
-static enum es_result vc_handle_monitor(struct ghcb *ghcb,
-					struct es_em_ctxt *ctxt)
-{
-	/*
-	 * Treat it as a NOP and do not leak a physical address to the
-	 * hypervisor.
-	 */
-	return ES_OK;
-}
-
-static enum es_result vc_handle_mwait(struct ghcb *ghcb,
-				      struct es_em_ctxt *ctxt)
-{
-	/* Treat the same as MONITOR/MONITORX */
-	return ES_OK;
-}
-
-static enum es_result vc_handle_vmmcall(struct ghcb *ghcb,
-					struct es_em_ctxt *ctxt)
-{
-	enum es_result ret;
-
-	ghcb_set_rax(ghcb, ctxt->regs->ax);
-	ghcb_set_cpl(ghcb, user_mode(ctxt->regs) ? 3 : 0);
-
-	if (x86_platform.hyper.sev_es_hcall_prepare)
-		x86_platform.hyper.sev_es_hcall_prepare(ghcb, ctxt->regs);
-
-	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_VMMCALL, 0, 0);
-	if (ret != ES_OK)
-		return ret;
-
-	if (!ghcb_rax_is_valid(ghcb))
-		return ES_VMM_ERROR;
-
-	ctxt->regs->ax = ghcb->save.rax;
-
-	/*
-	 * Call sev_es_hcall_finish() after regs->ax is already set.
-	 * This allows the hypervisor handler to overwrite it again if
-	 * necessary.
-	 */
-	if (x86_platform.hyper.sev_es_hcall_finish &&
-	    !x86_platform.hyper.sev_es_hcall_finish(ghcb, ctxt->regs))
-		return ES_VMM_ERROR;
-
-	return ES_OK;
-}
-
-static enum es_result vc_handle_trap_ac(struct ghcb *ghcb,
-					struct es_em_ctxt *ctxt)
-{
-	/*
-	 * Calling ecx_alignment_check() directly does not work, because it
-	 * enables IRQs and the GHCB is active. Forward the exception and call
-	 * it later from vc_forward_exception().
-	 */
-	ctxt->fi.vector = X86_TRAP_AC;
-	ctxt->fi.error_code = 0;
-	return ES_EXCEPTION;
-}
-
-static enum es_result vc_handle_exitcode(struct es_em_ctxt *ctxt,
-					 struct ghcb *ghcb,
-					 unsigned long exit_code)
-{
-	enum es_result result = vc_check_opcode_bytes(ctxt, exit_code);
-
-	if (result != ES_OK)
-		return result;
-
-	switch (exit_code) {
-	case SVM_EXIT_READ_DR7:
-		result = vc_handle_dr7_read(ghcb, ctxt);
-		break;
-	case SVM_EXIT_WRITE_DR7:
-		result = vc_handle_dr7_write(ghcb, ctxt);
-		break;
-	case SVM_EXIT_EXCP_BASE + X86_TRAP_AC:
-		result = vc_handle_trap_ac(ghcb, ctxt);
-		break;
-	case SVM_EXIT_RDTSC:
-	case SVM_EXIT_RDTSCP:
-		result = vc_handle_rdtsc(ghcb, ctxt, exit_code);
-		break;
-	case SVM_EXIT_RDPMC:
-		result = vc_handle_rdpmc(ghcb, ctxt);
-		break;
-	case SVM_EXIT_INVD:
-		pr_err_ratelimited("#VC exception for INVD??? Seriously???\n");
-		result = ES_UNSUPPORTED;
-		break;
-	case SVM_EXIT_CPUID:
-		result = vc_handle_cpuid(ghcb, ctxt);
-		break;
-	case SVM_EXIT_IOIO:
-		result = vc_handle_ioio(ghcb, ctxt);
-		break;
-	case SVM_EXIT_MSR:
-		result = vc_handle_msr(ghcb, ctxt);
-		break;
-	case SVM_EXIT_VMMCALL:
-		result = vc_handle_vmmcall(ghcb, ctxt);
-		break;
-	case SVM_EXIT_WBINVD:
-		result = vc_handle_wbinvd(ghcb, ctxt);
-		break;
-	case SVM_EXIT_MONITOR:
-		result = vc_handle_monitor(ghcb, ctxt);
-		break;
-	case SVM_EXIT_MWAIT:
-		result = vc_handle_mwait(ghcb, ctxt);
-		break;
-	case SVM_EXIT_NPF:
-		result = vc_handle_mmio(ghcb, ctxt);
-		break;
-	default:
-		/*
-		 * Unexpected #VC exception
-		 */
-		result = ES_UNSUPPORTED;
-	}
-
-	return result;
-}
-
-static __always_inline bool is_vc2_stack(unsigned long sp)
-{
-	return (sp >= __this_cpu_ist_bottom_va(VC2) && sp < __this_cpu_ist_top_va(VC2));
-}
-
-static __always_inline bool vc_from_invalid_context(struct pt_regs *regs)
-{
-	unsigned long sp, prev_sp;
-
-	sp      = (unsigned long)regs;
-	prev_sp = regs->sp;
-
-	/*
-	 * If the code was already executing on the VC2 stack when the #VC
-	 * happened, let it proceed to the normal handling routine. This way the
-	 * code executing on the VC2 stack can cause #VC exceptions to get handled.
-	 */
-	return is_vc2_stack(sp) && !is_vc2_stack(prev_sp);
-}
-
-static bool vc_raw_handle_exception(struct pt_regs *regs, unsigned long error_code)
-{
-	struct ghcb_state state;
-	struct es_em_ctxt ctxt;
-	enum es_result result;
-	struct ghcb *ghcb;
-	bool ret = true;
-
-	ghcb = __sev_get_ghcb(&state);
-
-	vc_ghcb_invalidate(ghcb);
-	result = vc_init_em_ctxt(&ctxt, regs, error_code);
-
-	if (result == ES_OK)
-		result = vc_handle_exitcode(&ctxt, ghcb, error_code);
-
-	__sev_put_ghcb(&state);
-
-	/* Done - now check the result */
-	switch (result) {
-	case ES_OK:
-		vc_finish_insn(&ctxt);
-		break;
-	case ES_UNSUPPORTED:
-		pr_err_ratelimited("Unsupported exit-code 0x%02lx in #VC exception (IP: 0x%lx)\n",
-				   error_code, regs->ip);
-		ret = false;
-		break;
-	case ES_VMM_ERROR:
-		pr_err_ratelimited("Failure in communication with VMM (exit-code 0x%02lx IP: 0x%lx)\n",
-				   error_code, regs->ip);
-		ret = false;
-		break;
-	case ES_DECODE_FAILED:
-		pr_err_ratelimited("Failed to decode instruction (exit-code 0x%02lx IP: 0x%lx)\n",
-				   error_code, regs->ip);
-		ret = false;
-		break;
-	case ES_EXCEPTION:
-		vc_forward_exception(&ctxt);
-		break;
-	case ES_RETRY:
-		/* Nothing to do */
-		break;
-	default:
-		pr_emerg("Unknown result in %s():%d\n", __func__, result);
-		/*
-		 * Emulating the instruction which caused the #VC exception
-		 * failed - can't continue so print debug information
-		 */
-		BUG();
-	}
-
-	return ret;
-}
-
-static __always_inline bool vc_is_db(unsigned long error_code)
-{
-	return error_code == SVM_EXIT_EXCP_BASE + X86_TRAP_DB;
-}
-
-/*
- * Runtime #VC exception handler when raised from kernel mode. Runs in NMI mode
- * and will panic when an error happens.
- */
-DEFINE_IDTENTRY_VC_KERNEL(exc_vmm_communication)
-{
-	irqentry_state_t irq_state;
-
-	/*
-	 * With the current implementation it is always possible to switch to a
-	 * safe stack because #VC exceptions only happen at known places, like
-	 * intercepted instructions or accesses to MMIO areas/IO ports. They can
-	 * also happen with code instrumentation when the hypervisor intercepts
-	 * #DB, but the critical paths are forbidden to be instrumented, so #DB
-	 * exceptions currently also only happen in safe places.
-	 *
-	 * But keep this here in case the noinstr annotations are violated due
-	 * to bug elsewhere.
-	 */
-	if (unlikely(vc_from_invalid_context(regs))) {
-		instrumentation_begin();
-		panic("Can't handle #VC exception from unsupported context\n");
-		instrumentation_end();
-	}
-
-	/*
-	 * Handle #DB before calling into !noinstr code to avoid recursive #DB.
-	 */
-	if (vc_is_db(error_code)) {
-		exc_debug(regs);
-		return;
-	}
-
-	irq_state = irqentry_nmi_enter(regs);
-
-	instrumentation_begin();
-
-	if (!vc_raw_handle_exception(regs, error_code)) {
-		/* Show some debug info */
-		show_regs(regs);
-
-		/* Ask hypervisor to sev_es_terminate */
-		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
-
-		/* If that fails and we get here - just panic */
-		panic("Returned from Terminate-Request to Hypervisor\n");
-	}
-
-	instrumentation_end();
-	irqentry_nmi_exit(regs, irq_state);
-}
-
-/*
- * Runtime #VC exception handler when raised from user mode. Runs in IRQ mode
- * and will kill the current task with SIGBUS when an error happens.
- */
-DEFINE_IDTENTRY_VC_USER(exc_vmm_communication)
-{
-	/*
-	 * Handle #DB before calling into !noinstr code to avoid recursive #DB.
-	 */
-	if (vc_is_db(error_code)) {
-		noist_exc_debug(regs);
-		return;
-	}
-
-	irqentry_enter_from_user_mode(regs);
-	instrumentation_begin();
-
-	if (!vc_raw_handle_exception(regs, error_code)) {
-		/*
-		 * Do not kill the machine if user-space triggered the
-		 * exception. Send SIGBUS instead and let user-space deal with
-		 * it.
-		 */
-		force_sig_fault(SIGBUS, BUS_OBJERR, (void __user *)0);
-	}
-
-	instrumentation_end();
-	irqentry_exit_to_user_mode(regs);
-}
-
-bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
-{
-	unsigned long exit_code = regs->orig_ax;
-	struct es_em_ctxt ctxt;
-	enum es_result result;
-
-	vc_ghcb_invalidate(boot_ghcb);
-
-	result = vc_init_em_ctxt(&ctxt, regs, exit_code);
-	if (result == ES_OK)
-		result = vc_handle_exitcode(&ctxt, boot_ghcb, exit_code);
-
-	/* Done - now check the result */
-	switch (result) {
-	case ES_OK:
-		vc_finish_insn(&ctxt);
-		break;
-	case ES_UNSUPPORTED:
-		early_printk("PANIC: Unsupported exit-code 0x%02lx in early #VC exception (IP: 0x%lx)\n",
-				exit_code, regs->ip);
-		goto fail;
-	case ES_VMM_ERROR:
-		early_printk("PANIC: Failure in communication with VMM (exit-code 0x%02lx IP: 0x%lx)\n",
-				exit_code, regs->ip);
-		goto fail;
-	case ES_DECODE_FAILED:
-		early_printk("PANIC: Failed to decode instruction (exit-code 0x%02lx IP: 0x%lx)\n",
-				exit_code, regs->ip);
-		goto fail;
-	case ES_EXCEPTION:
-		vc_early_forward_exception(&ctxt);
-		break;
-	case ES_RETRY:
-		/* Nothing to do */
-		break;
-	default:
-		BUG();
-	}
-
-	return true;
-
-fail:
-	show_regs(regs);
-
-	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
-}
-
 /*
  * Initial set up of SNP relies on information provided by the
  * Confidential Computing blob, which can be passed to the kernel
diff --git a/arch/x86/coco/sev/Makefile b/arch/x86/coco/sev/Makefile
index 2919dcf..db3255b 100644
--- a/arch/x86/coco/sev/Makefile
+++ b/arch/x86/coco/sev/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y += core.o sev-nmi.o
+obj-y += core.o sev-nmi.o vc-handle.o
 
 # Clang 14 and older may fail to respect __no_sanitize_undefined when inlining
 UBSAN_SANITIZE_sev-nmi.o	:= n
diff --git a/arch/x86/coco/sev/vc-handle.c b/arch/x86/coco/sev/vc-handle.c
new file mode 100644
index 0000000..b4895c6
--- /dev/null
+++ b/arch/x86/coco/sev/vc-handle.c
@@ -0,0 +1,1061 @@
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
+#include <linux/sched/debug.h>	/* For show_regs() */
+#include <linux/cc_platform.h>
+#include <linux/printk.h>
+#include <linux/mm_types.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/io.h>
+#include <linux/psp-sev.h>
+#include <uapi/linux/sev-guest.h>
+
+#include <asm/init.h>
+#include <asm/stacktrace.h>
+#include <asm/sev.h>
+#include <asm/sev-internal.h>
+#include <asm/insn-eval.h>
+#include <asm/fpu/xcr.h>
+#include <asm/processor.h>
+#include <asm/setup.h>
+#include <asm/traps.h>
+#include <asm/svm.h>
+#include <asm/smp.h>
+#include <asm/cpu.h>
+#include <asm/apic.h>
+#include <asm/cpuid.h>
+
+static enum es_result vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
+					   unsigned long vaddr, phys_addr_t *paddr)
+{
+	unsigned long va = (unsigned long)vaddr;
+	unsigned int level;
+	phys_addr_t pa;
+	pgd_t *pgd;
+	pte_t *pte;
+
+	pgd = __va(read_cr3_pa());
+	pgd = &pgd[pgd_index(va)];
+	pte = lookup_address_in_pgd(pgd, va, &level);
+	if (!pte) {
+		ctxt->fi.vector     = X86_TRAP_PF;
+		ctxt->fi.cr2        = vaddr;
+		ctxt->fi.error_code = 0;
+
+		if (user_mode(ctxt->regs))
+			ctxt->fi.error_code |= X86_PF_USER;
+
+		return ES_EXCEPTION;
+	}
+
+	if (WARN_ON_ONCE(pte_val(*pte) & _PAGE_ENC))
+		/* Emulated MMIO to/from encrypted memory not supported */
+		return ES_UNSUPPORTED;
+
+	pa = (phys_addr_t)pte_pfn(*pte) << PAGE_SHIFT;
+	pa |= va & ~page_level_mask(level);
+
+	*paddr = pa;
+
+	return ES_OK;
+}
+
+static enum es_result vc_ioio_check(struct es_em_ctxt *ctxt, u16 port, size_t size)
+{
+	BUG_ON(size > 4);
+
+	if (user_mode(ctxt->regs)) {
+		struct thread_struct *t = &current->thread;
+		struct io_bitmap *iobm = t->io_bitmap;
+		size_t idx;
+
+		if (!iobm)
+			goto fault;
+
+		for (idx = port; idx < port + size; ++idx) {
+			if (test_bit(idx, iobm->bitmap))
+				goto fault;
+		}
+	}
+
+	return ES_OK;
+
+fault:
+	ctxt->fi.vector = X86_TRAP_GP;
+	ctxt->fi.error_code = 0;
+
+	return ES_EXCEPTION;
+}
+
+void vc_forward_exception(struct es_em_ctxt *ctxt)
+{
+	long error_code = ctxt->fi.error_code;
+	int trapnr = ctxt->fi.vector;
+
+	ctxt->regs->orig_ax = ctxt->fi.error_code;
+
+	switch (trapnr) {
+	case X86_TRAP_GP:
+		exc_general_protection(ctxt->regs, error_code);
+		break;
+	case X86_TRAP_UD:
+		exc_invalid_op(ctxt->regs);
+		break;
+	case X86_TRAP_PF:
+		write_cr2(ctxt->fi.cr2);
+		exc_page_fault(ctxt->regs, error_code);
+		break;
+	case X86_TRAP_AC:
+		exc_alignment_check(ctxt->regs, error_code);
+		break;
+	default:
+		pr_emerg("Unsupported exception in #VC instruction emulation - can't continue\n");
+		BUG();
+	}
+}
+
+static int vc_fetch_insn_kernel(struct es_em_ctxt *ctxt,
+				unsigned char *buffer)
+{
+	return copy_from_kernel_nofault(buffer, (unsigned char *)ctxt->regs->ip, MAX_INSN_SIZE);
+}
+
+static enum es_result __vc_decode_user_insn(struct es_em_ctxt *ctxt)
+{
+	char buffer[MAX_INSN_SIZE];
+	int insn_bytes;
+
+	insn_bytes = insn_fetch_from_user_inatomic(ctxt->regs, buffer);
+	if (insn_bytes == 0) {
+		/* Nothing could be copied */
+		ctxt->fi.vector     = X86_TRAP_PF;
+		ctxt->fi.error_code = X86_PF_INSTR | X86_PF_USER;
+		ctxt->fi.cr2        = ctxt->regs->ip;
+		return ES_EXCEPTION;
+	} else if (insn_bytes == -EINVAL) {
+		/* Effective RIP could not be calculated */
+		ctxt->fi.vector     = X86_TRAP_GP;
+		ctxt->fi.error_code = 0;
+		ctxt->fi.cr2        = 0;
+		return ES_EXCEPTION;
+	}
+
+	if (!insn_decode_from_regs(&ctxt->insn, ctxt->regs, buffer, insn_bytes))
+		return ES_DECODE_FAILED;
+
+	if (ctxt->insn.immediate.got)
+		return ES_OK;
+	else
+		return ES_DECODE_FAILED;
+}
+
+static enum es_result __vc_decode_kern_insn(struct es_em_ctxt *ctxt)
+{
+	char buffer[MAX_INSN_SIZE];
+	int res, ret;
+
+	res = vc_fetch_insn_kernel(ctxt, buffer);
+	if (res) {
+		ctxt->fi.vector     = X86_TRAP_PF;
+		ctxt->fi.error_code = X86_PF_INSTR;
+		ctxt->fi.cr2        = ctxt->regs->ip;
+		return ES_EXCEPTION;
+	}
+
+	ret = insn_decode(&ctxt->insn, buffer, MAX_INSN_SIZE, INSN_MODE_64);
+	if (ret < 0)
+		return ES_DECODE_FAILED;
+	else
+		return ES_OK;
+}
+
+static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
+{
+	if (user_mode(ctxt->regs))
+		return __vc_decode_user_insn(ctxt);
+	else
+		return __vc_decode_kern_insn(ctxt);
+}
+
+static enum es_result vc_write_mem(struct es_em_ctxt *ctxt,
+				   char *dst, char *buf, size_t size)
+{
+	unsigned long error_code = X86_PF_PROT | X86_PF_WRITE;
+
+	/*
+	 * This function uses __put_user() independent of whether kernel or user
+	 * memory is accessed. This works fine because __put_user() does no
+	 * sanity checks of the pointer being accessed. All that it does is
+	 * to report when the access failed.
+	 *
+	 * Also, this function runs in atomic context, so __put_user() is not
+	 * allowed to sleep. The page-fault handler detects that it is running
+	 * in atomic context and will not try to take mmap_sem and handle the
+	 * fault, so additional pagefault_enable()/disable() calls are not
+	 * needed.
+	 *
+	 * The access can't be done via copy_to_user() here because
+	 * vc_write_mem() must not use string instructions to access unsafe
+	 * memory. The reason is that MOVS is emulated by the #VC handler by
+	 * splitting the move up into a read and a write and taking a nested #VC
+	 * exception on whatever of them is the MMIO access. Using string
+	 * instructions here would cause infinite nesting.
+	 */
+	switch (size) {
+	case 1: {
+		u8 d1;
+		u8 __user *target = (u8 __user *)dst;
+
+		memcpy(&d1, buf, 1);
+		if (__put_user(d1, target))
+			goto fault;
+		break;
+	}
+	case 2: {
+		u16 d2;
+		u16 __user *target = (u16 __user *)dst;
+
+		memcpy(&d2, buf, 2);
+		if (__put_user(d2, target))
+			goto fault;
+		break;
+	}
+	case 4: {
+		u32 d4;
+		u32 __user *target = (u32 __user *)dst;
+
+		memcpy(&d4, buf, 4);
+		if (__put_user(d4, target))
+			goto fault;
+		break;
+	}
+	case 8: {
+		u64 d8;
+		u64 __user *target = (u64 __user *)dst;
+
+		memcpy(&d8, buf, 8);
+		if (__put_user(d8, target))
+			goto fault;
+		break;
+	}
+	default:
+		WARN_ONCE(1, "%s: Invalid size: %zu\n", __func__, size);
+		return ES_UNSUPPORTED;
+	}
+
+	return ES_OK;
+
+fault:
+	if (user_mode(ctxt->regs))
+		error_code |= X86_PF_USER;
+
+	ctxt->fi.vector = X86_TRAP_PF;
+	ctxt->fi.error_code = error_code;
+	ctxt->fi.cr2 = (unsigned long)dst;
+
+	return ES_EXCEPTION;
+}
+
+static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
+				  char *src, char *buf, size_t size)
+{
+	unsigned long error_code = X86_PF_PROT;
+
+	/*
+	 * This function uses __get_user() independent of whether kernel or user
+	 * memory is accessed. This works fine because __get_user() does no
+	 * sanity checks of the pointer being accessed. All that it does is
+	 * to report when the access failed.
+	 *
+	 * Also, this function runs in atomic context, so __get_user() is not
+	 * allowed to sleep. The page-fault handler detects that it is running
+	 * in atomic context and will not try to take mmap_sem and handle the
+	 * fault, so additional pagefault_enable()/disable() calls are not
+	 * needed.
+	 *
+	 * The access can't be done via copy_from_user() here because
+	 * vc_read_mem() must not use string instructions to access unsafe
+	 * memory. The reason is that MOVS is emulated by the #VC handler by
+	 * splitting the move up into a read and a write and taking a nested #VC
+	 * exception on whatever of them is the MMIO access. Using string
+	 * instructions here would cause infinite nesting.
+	 */
+	switch (size) {
+	case 1: {
+		u8 d1;
+		u8 __user *s = (u8 __user *)src;
+
+		if (__get_user(d1, s))
+			goto fault;
+		memcpy(buf, &d1, 1);
+		break;
+	}
+	case 2: {
+		u16 d2;
+		u16 __user *s = (u16 __user *)src;
+
+		if (__get_user(d2, s))
+			goto fault;
+		memcpy(buf, &d2, 2);
+		break;
+	}
+	case 4: {
+		u32 d4;
+		u32 __user *s = (u32 __user *)src;
+
+		if (__get_user(d4, s))
+			goto fault;
+		memcpy(buf, &d4, 4);
+		break;
+	}
+	case 8: {
+		u64 d8;
+		u64 __user *s = (u64 __user *)src;
+		if (__get_user(d8, s))
+			goto fault;
+		memcpy(buf, &d8, 8);
+		break;
+	}
+	default:
+		WARN_ONCE(1, "%s: Invalid size: %zu\n", __func__, size);
+		return ES_UNSUPPORTED;
+	}
+
+	return ES_OK;
+
+fault:
+	if (user_mode(ctxt->regs))
+		error_code |= X86_PF_USER;
+
+	ctxt->fi.vector = X86_TRAP_PF;
+	ctxt->fi.error_code = error_code;
+	ctxt->fi.cr2 = (unsigned long)src;
+
+	return ES_EXCEPTION;
+}
+
+#define sev_printk(fmt, ...)		printk(fmt, ##__VA_ARGS__)
+
+#include "vc-shared.c"
+
+/* Writes to the SVSM CAA MSR are ignored */
+static enum es_result __vc_handle_msr_caa(struct pt_regs *regs, bool write)
+{
+	if (write)
+		return ES_OK;
+
+	regs->ax = lower_32_bits(this_cpu_read(svsm_caa_pa));
+	regs->dx = upper_32_bits(this_cpu_read(svsm_caa_pa));
+
+	return ES_OK;
+}
+
+/*
+ * TSC related accesses should not exit to the hypervisor when a guest is
+ * executing with Secure TSC enabled, so special handling is required for
+ * accesses of MSR_IA32_TSC and MSR_AMD64_GUEST_TSC_FREQ.
+ */
+static enum es_result __vc_handle_secure_tsc_msrs(struct pt_regs *regs, bool write)
+{
+	u64 tsc;
+
+	/*
+	 * GUEST_TSC_FREQ should not be intercepted when Secure TSC is enabled.
+	 * Terminate the SNP guest when the interception is enabled.
+	 */
+	if (regs->cx == MSR_AMD64_GUEST_TSC_FREQ)
+		return ES_VMM_ERROR;
+
+	/*
+	 * Writes: Writing to MSR_IA32_TSC can cause subsequent reads of the TSC
+	 *         to return undefined values, so ignore all writes.
+	 *
+	 * Reads: Reads of MSR_IA32_TSC should return the current TSC value, use
+	 *        the value returned by rdtsc_ordered().
+	 */
+	if (write) {
+		WARN_ONCE(1, "TSC MSR writes are verboten!\n");
+		return ES_OK;
+	}
+
+	tsc = rdtsc_ordered();
+	regs->ax = lower_32_bits(tsc);
+	regs->dx = upper_32_bits(tsc);
+
+	return ES_OK;
+}
+
+static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
+{
+	struct pt_regs *regs = ctxt->regs;
+	enum es_result ret;
+	bool write;
+
+	/* Is it a WRMSR? */
+	write = ctxt->insn.opcode.bytes[1] == 0x30;
+
+	switch (regs->cx) {
+	case MSR_SVSM_CAA:
+		return __vc_handle_msr_caa(regs, write);
+	case MSR_IA32_TSC:
+	case MSR_AMD64_GUEST_TSC_FREQ:
+		if (sev_status & MSR_AMD64_SNP_SECURE_TSC)
+			return __vc_handle_secure_tsc_msrs(regs, write);
+		break;
+	default:
+		break;
+	}
+
+	ghcb_set_rcx(ghcb, regs->cx);
+	if (write) {
+		ghcb_set_rax(ghcb, regs->ax);
+		ghcb_set_rdx(ghcb, regs->dx);
+	}
+
+	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_MSR, write, 0);
+
+	if ((ret == ES_OK) && !write) {
+		regs->ax = ghcb->save.rax;
+		regs->dx = ghcb->save.rdx;
+	}
+
+	return ret;
+}
+
+static void __init vc_early_forward_exception(struct es_em_ctxt *ctxt)
+{
+	int trapnr = ctxt->fi.vector;
+
+	if (trapnr == X86_TRAP_PF)
+		native_write_cr2(ctxt->fi.cr2);
+
+	ctxt->regs->orig_ax = ctxt->fi.error_code;
+	do_early_exception(ctxt->regs, trapnr);
+}
+
+static long *vc_insn_get_rm(struct es_em_ctxt *ctxt)
+{
+	long *reg_array;
+	int offset;
+
+	reg_array = (long *)ctxt->regs;
+	offset    = insn_get_modrm_rm_off(&ctxt->insn, ctxt->regs);
+
+	if (offset < 0)
+		return NULL;
+
+	offset /= sizeof(long);
+
+	return reg_array + offset;
+}
+static enum es_result vc_do_mmio(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
+				 unsigned int bytes, bool read)
+{
+	u64 exit_code, exit_info_1, exit_info_2;
+	unsigned long ghcb_pa = __pa(ghcb);
+	enum es_result res;
+	phys_addr_t paddr;
+	void __user *ref;
+
+	ref = insn_get_addr_ref(&ctxt->insn, ctxt->regs);
+	if (ref == (void __user *)-1L)
+		return ES_UNSUPPORTED;
+
+	exit_code = read ? SVM_VMGEXIT_MMIO_READ : SVM_VMGEXIT_MMIO_WRITE;
+
+	res = vc_slow_virt_to_phys(ghcb, ctxt, (unsigned long)ref, &paddr);
+	if (res != ES_OK) {
+		if (res == ES_EXCEPTION && !read)
+			ctxt->fi.error_code |= X86_PF_WRITE;
+
+		return res;
+	}
+
+	exit_info_1 = paddr;
+	/* Can never be greater than 8 */
+	exit_info_2 = bytes;
+
+	ghcb_set_sw_scratch(ghcb, ghcb_pa + offsetof(struct ghcb, shared_buffer));
+
+	return sev_es_ghcb_hv_call(ghcb, ctxt, exit_code, exit_info_1, exit_info_2);
+}
+
+/*
+ * The MOVS instruction has two memory operands, which raises the
+ * problem that it is not known whether the access to the source or the
+ * destination caused the #VC exception (and hence whether an MMIO read
+ * or write operation needs to be emulated).
+ *
+ * Instead of playing games with walking page-tables and trying to guess
+ * whether the source or destination is an MMIO range, split the move
+ * into two operations, a read and a write with only one memory operand.
+ * This will cause a nested #VC exception on the MMIO address which can
+ * then be handled.
+ *
+ * This implementation has the benefit that it also supports MOVS where
+ * source _and_ destination are MMIO regions.
+ *
+ * It will slow MOVS on MMIO down a lot, but in SEV-ES guests it is a
+ * rare operation. If it turns out to be a performance problem the split
+ * operations can be moved to memcpy_fromio() and memcpy_toio().
+ */
+static enum es_result vc_handle_mmio_movs(struct es_em_ctxt *ctxt,
+					  unsigned int bytes)
+{
+	unsigned long ds_base, es_base;
+	unsigned char *src, *dst;
+	unsigned char buffer[8];
+	enum es_result ret;
+	bool rep;
+	int off;
+
+	ds_base = insn_get_seg_base(ctxt->regs, INAT_SEG_REG_DS);
+	es_base = insn_get_seg_base(ctxt->regs, INAT_SEG_REG_ES);
+
+	if (ds_base == -1L || es_base == -1L) {
+		ctxt->fi.vector = X86_TRAP_GP;
+		ctxt->fi.error_code = 0;
+		return ES_EXCEPTION;
+	}
+
+	src = ds_base + (unsigned char *)ctxt->regs->si;
+	dst = es_base + (unsigned char *)ctxt->regs->di;
+
+	ret = vc_read_mem(ctxt, src, buffer, bytes);
+	if (ret != ES_OK)
+		return ret;
+
+	ret = vc_write_mem(ctxt, dst, buffer, bytes);
+	if (ret != ES_OK)
+		return ret;
+
+	if (ctxt->regs->flags & X86_EFLAGS_DF)
+		off = -bytes;
+	else
+		off =  bytes;
+
+	ctxt->regs->si += off;
+	ctxt->regs->di += off;
+
+	rep = insn_has_rep_prefix(&ctxt->insn);
+	if (rep)
+		ctxt->regs->cx -= 1;
+
+	if (!rep || ctxt->regs->cx == 0)
+		return ES_OK;
+	else
+		return ES_RETRY;
+}
+
+static enum es_result vc_handle_mmio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
+{
+	struct insn *insn = &ctxt->insn;
+	enum insn_mmio_type mmio;
+	unsigned int bytes = 0;
+	enum es_result ret;
+	u8 sign_byte;
+	long *reg_data;
+
+	mmio = insn_decode_mmio(insn, &bytes);
+	if (mmio == INSN_MMIO_DECODE_FAILED)
+		return ES_DECODE_FAILED;
+
+	if (mmio != INSN_MMIO_WRITE_IMM && mmio != INSN_MMIO_MOVS) {
+		reg_data = insn_get_modrm_reg_ptr(insn, ctxt->regs);
+		if (!reg_data)
+			return ES_DECODE_FAILED;
+	}
+
+	if (user_mode(ctxt->regs))
+		return ES_UNSUPPORTED;
+
+	switch (mmio) {
+	case INSN_MMIO_WRITE:
+		memcpy(ghcb->shared_buffer, reg_data, bytes);
+		ret = vc_do_mmio(ghcb, ctxt, bytes, false);
+		break;
+	case INSN_MMIO_WRITE_IMM:
+		memcpy(ghcb->shared_buffer, insn->immediate1.bytes, bytes);
+		ret = vc_do_mmio(ghcb, ctxt, bytes, false);
+		break;
+	case INSN_MMIO_READ:
+		ret = vc_do_mmio(ghcb, ctxt, bytes, true);
+		if (ret)
+			break;
+
+		/* Zero-extend for 32-bit operation */
+		if (bytes == 4)
+			*reg_data = 0;
+
+		memcpy(reg_data, ghcb->shared_buffer, bytes);
+		break;
+	case INSN_MMIO_READ_ZERO_EXTEND:
+		ret = vc_do_mmio(ghcb, ctxt, bytes, true);
+		if (ret)
+			break;
+
+		/* Zero extend based on operand size */
+		memset(reg_data, 0, insn->opnd_bytes);
+		memcpy(reg_data, ghcb->shared_buffer, bytes);
+		break;
+	case INSN_MMIO_READ_SIGN_EXTEND:
+		ret = vc_do_mmio(ghcb, ctxt, bytes, true);
+		if (ret)
+			break;
+
+		if (bytes == 1) {
+			u8 *val = (u8 *)ghcb->shared_buffer;
+
+			sign_byte = (*val & 0x80) ? 0xff : 0x00;
+		} else {
+			u16 *val = (u16 *)ghcb->shared_buffer;
+
+			sign_byte = (*val & 0x8000) ? 0xff : 0x00;
+		}
+
+		/* Sign extend based on operand size */
+		memset(reg_data, sign_byte, insn->opnd_bytes);
+		memcpy(reg_data, ghcb->shared_buffer, bytes);
+		break;
+	case INSN_MMIO_MOVS:
+		ret = vc_handle_mmio_movs(ctxt, bytes);
+		break;
+	default:
+		ret = ES_UNSUPPORTED;
+		break;
+	}
+
+	return ret;
+}
+
+static enum es_result vc_handle_dr7_write(struct ghcb *ghcb,
+					  struct es_em_ctxt *ctxt)
+{
+	struct sev_es_runtime_data *data = this_cpu_read(runtime_data);
+	long val, *reg = vc_insn_get_rm(ctxt);
+	enum es_result ret;
+
+	if (sev_status & MSR_AMD64_SNP_DEBUG_SWAP)
+		return ES_VMM_ERROR;
+
+	if (!reg)
+		return ES_DECODE_FAILED;
+
+	val = *reg;
+
+	/* Upper 32 bits must be written as zeroes */
+	if (val >> 32) {
+		ctxt->fi.vector = X86_TRAP_GP;
+		ctxt->fi.error_code = 0;
+		return ES_EXCEPTION;
+	}
+
+	/* Clear out other reserved bits and set bit 10 */
+	val = (val & 0xffff23ffL) | BIT(10);
+
+	/* Early non-zero writes to DR7 are not supported */
+	if (!data && (val & ~DR7_RESET_VALUE))
+		return ES_UNSUPPORTED;
+
+	/* Using a value of 0 for ExitInfo1 means RAX holds the value */
+	ghcb_set_rax(ghcb, val);
+	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_WRITE_DR7, 0, 0);
+	if (ret != ES_OK)
+		return ret;
+
+	if (data)
+		data->dr7 = val;
+
+	return ES_OK;
+}
+
+static enum es_result vc_handle_dr7_read(struct ghcb *ghcb,
+					 struct es_em_ctxt *ctxt)
+{
+	struct sev_es_runtime_data *data = this_cpu_read(runtime_data);
+	long *reg = vc_insn_get_rm(ctxt);
+
+	if (sev_status & MSR_AMD64_SNP_DEBUG_SWAP)
+		return ES_VMM_ERROR;
+
+	if (!reg)
+		return ES_DECODE_FAILED;
+
+	if (data)
+		*reg = data->dr7;
+	else
+		*reg = DR7_RESET_VALUE;
+
+	return ES_OK;
+}
+
+static enum es_result vc_handle_wbinvd(struct ghcb *ghcb,
+				       struct es_em_ctxt *ctxt)
+{
+	return sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_WBINVD, 0, 0);
+}
+
+static enum es_result vc_handle_rdpmc(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
+{
+	enum es_result ret;
+
+	ghcb_set_rcx(ghcb, ctxt->regs->cx);
+
+	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_RDPMC, 0, 0);
+	if (ret != ES_OK)
+		return ret;
+
+	if (!(ghcb_rax_is_valid(ghcb) && ghcb_rdx_is_valid(ghcb)))
+		return ES_VMM_ERROR;
+
+	ctxt->regs->ax = ghcb->save.rax;
+	ctxt->regs->dx = ghcb->save.rdx;
+
+	return ES_OK;
+}
+
+static enum es_result vc_handle_monitor(struct ghcb *ghcb,
+					struct es_em_ctxt *ctxt)
+{
+	/*
+	 * Treat it as a NOP and do not leak a physical address to the
+	 * hypervisor.
+	 */
+	return ES_OK;
+}
+
+static enum es_result vc_handle_mwait(struct ghcb *ghcb,
+				      struct es_em_ctxt *ctxt)
+{
+	/* Treat the same as MONITOR/MONITORX */
+	return ES_OK;
+}
+
+static enum es_result vc_handle_vmmcall(struct ghcb *ghcb,
+					struct es_em_ctxt *ctxt)
+{
+	enum es_result ret;
+
+	ghcb_set_rax(ghcb, ctxt->regs->ax);
+	ghcb_set_cpl(ghcb, user_mode(ctxt->regs) ? 3 : 0);
+
+	if (x86_platform.hyper.sev_es_hcall_prepare)
+		x86_platform.hyper.sev_es_hcall_prepare(ghcb, ctxt->regs);
+
+	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_VMMCALL, 0, 0);
+	if (ret != ES_OK)
+		return ret;
+
+	if (!ghcb_rax_is_valid(ghcb))
+		return ES_VMM_ERROR;
+
+	ctxt->regs->ax = ghcb->save.rax;
+
+	/*
+	 * Call sev_es_hcall_finish() after regs->ax is already set.
+	 * This allows the hypervisor handler to overwrite it again if
+	 * necessary.
+	 */
+	if (x86_platform.hyper.sev_es_hcall_finish &&
+	    !x86_platform.hyper.sev_es_hcall_finish(ghcb, ctxt->regs))
+		return ES_VMM_ERROR;
+
+	return ES_OK;
+}
+
+static enum es_result vc_handle_trap_ac(struct ghcb *ghcb,
+					struct es_em_ctxt *ctxt)
+{
+	/*
+	 * Calling ecx_alignment_check() directly does not work, because it
+	 * enables IRQs and the GHCB is active. Forward the exception and call
+	 * it later from vc_forward_exception().
+	 */
+	ctxt->fi.vector = X86_TRAP_AC;
+	ctxt->fi.error_code = 0;
+	return ES_EXCEPTION;
+}
+
+static enum es_result vc_handle_exitcode(struct es_em_ctxt *ctxt,
+					 struct ghcb *ghcb,
+					 unsigned long exit_code)
+{
+	enum es_result result = vc_check_opcode_bytes(ctxt, exit_code);
+
+	if (result != ES_OK)
+		return result;
+
+	switch (exit_code) {
+	case SVM_EXIT_READ_DR7:
+		result = vc_handle_dr7_read(ghcb, ctxt);
+		break;
+	case SVM_EXIT_WRITE_DR7:
+		result = vc_handle_dr7_write(ghcb, ctxt);
+		break;
+	case SVM_EXIT_EXCP_BASE + X86_TRAP_AC:
+		result = vc_handle_trap_ac(ghcb, ctxt);
+		break;
+	case SVM_EXIT_RDTSC:
+	case SVM_EXIT_RDTSCP:
+		result = vc_handle_rdtsc(ghcb, ctxt, exit_code);
+		break;
+	case SVM_EXIT_RDPMC:
+		result = vc_handle_rdpmc(ghcb, ctxt);
+		break;
+	case SVM_EXIT_INVD:
+		pr_err_ratelimited("#VC exception for INVD??? Seriously???\n");
+		result = ES_UNSUPPORTED;
+		break;
+	case SVM_EXIT_CPUID:
+		result = vc_handle_cpuid(ghcb, ctxt);
+		break;
+	case SVM_EXIT_IOIO:
+		result = vc_handle_ioio(ghcb, ctxt);
+		break;
+	case SVM_EXIT_MSR:
+		result = vc_handle_msr(ghcb, ctxt);
+		break;
+	case SVM_EXIT_VMMCALL:
+		result = vc_handle_vmmcall(ghcb, ctxt);
+		break;
+	case SVM_EXIT_WBINVD:
+		result = vc_handle_wbinvd(ghcb, ctxt);
+		break;
+	case SVM_EXIT_MONITOR:
+		result = vc_handle_monitor(ghcb, ctxt);
+		break;
+	case SVM_EXIT_MWAIT:
+		result = vc_handle_mwait(ghcb, ctxt);
+		break;
+	case SVM_EXIT_NPF:
+		result = vc_handle_mmio(ghcb, ctxt);
+		break;
+	default:
+		/*
+		 * Unexpected #VC exception
+		 */
+		result = ES_UNSUPPORTED;
+	}
+
+	return result;
+}
+
+static __always_inline bool is_vc2_stack(unsigned long sp)
+{
+	return (sp >= __this_cpu_ist_bottom_va(VC2) && sp < __this_cpu_ist_top_va(VC2));
+}
+
+static __always_inline bool vc_from_invalid_context(struct pt_regs *regs)
+{
+	unsigned long sp, prev_sp;
+
+	sp      = (unsigned long)regs;
+	prev_sp = regs->sp;
+
+	/*
+	 * If the code was already executing on the VC2 stack when the #VC
+	 * happened, let it proceed to the normal handling routine. This way the
+	 * code executing on the VC2 stack can cause #VC exceptions to get handled.
+	 */
+	return is_vc2_stack(sp) && !is_vc2_stack(prev_sp);
+}
+
+static bool vc_raw_handle_exception(struct pt_regs *regs, unsigned long error_code)
+{
+	struct ghcb_state state;
+	struct es_em_ctxt ctxt;
+	enum es_result result;
+	struct ghcb *ghcb;
+	bool ret = true;
+
+	ghcb = __sev_get_ghcb(&state);
+
+	vc_ghcb_invalidate(ghcb);
+	result = vc_init_em_ctxt(&ctxt, regs, error_code);
+
+	if (result == ES_OK)
+		result = vc_handle_exitcode(&ctxt, ghcb, error_code);
+
+	__sev_put_ghcb(&state);
+
+	/* Done - now check the result */
+	switch (result) {
+	case ES_OK:
+		vc_finish_insn(&ctxt);
+		break;
+	case ES_UNSUPPORTED:
+		pr_err_ratelimited("Unsupported exit-code 0x%02lx in #VC exception (IP: 0x%lx)\n",
+				   error_code, regs->ip);
+		ret = false;
+		break;
+	case ES_VMM_ERROR:
+		pr_err_ratelimited("Failure in communication with VMM (exit-code 0x%02lx IP: 0x%lx)\n",
+				   error_code, regs->ip);
+		ret = false;
+		break;
+	case ES_DECODE_FAILED:
+		pr_err_ratelimited("Failed to decode instruction (exit-code 0x%02lx IP: 0x%lx)\n",
+				   error_code, regs->ip);
+		ret = false;
+		break;
+	case ES_EXCEPTION:
+		vc_forward_exception(&ctxt);
+		break;
+	case ES_RETRY:
+		/* Nothing to do */
+		break;
+	default:
+		pr_emerg("Unknown result in %s():%d\n", __func__, result);
+		/*
+		 * Emulating the instruction which caused the #VC exception
+		 * failed - can't continue so print debug information
+		 */
+		BUG();
+	}
+
+	return ret;
+}
+
+static __always_inline bool vc_is_db(unsigned long error_code)
+{
+	return error_code == SVM_EXIT_EXCP_BASE + X86_TRAP_DB;
+}
+
+/*
+ * Runtime #VC exception handler when raised from kernel mode. Runs in NMI mode
+ * and will panic when an error happens.
+ */
+DEFINE_IDTENTRY_VC_KERNEL(exc_vmm_communication)
+{
+	irqentry_state_t irq_state;
+
+	/*
+	 * With the current implementation it is always possible to switch to a
+	 * safe stack because #VC exceptions only happen at known places, like
+	 * intercepted instructions or accesses to MMIO areas/IO ports. They can
+	 * also happen with code instrumentation when the hypervisor intercepts
+	 * #DB, but the critical paths are forbidden to be instrumented, so #DB
+	 * exceptions currently also only happen in safe places.
+	 *
+	 * But keep this here in case the noinstr annotations are violated due
+	 * to bug elsewhere.
+	 */
+	if (unlikely(vc_from_invalid_context(regs))) {
+		instrumentation_begin();
+		panic("Can't handle #VC exception from unsupported context\n");
+		instrumentation_end();
+	}
+
+	/*
+	 * Handle #DB before calling into !noinstr code to avoid recursive #DB.
+	 */
+	if (vc_is_db(error_code)) {
+		exc_debug(regs);
+		return;
+	}
+
+	irq_state = irqentry_nmi_enter(regs);
+
+	instrumentation_begin();
+
+	if (!vc_raw_handle_exception(regs, error_code)) {
+		/* Show some debug info */
+		show_regs(regs);
+
+		/* Ask hypervisor to sev_es_terminate */
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
+
+		/* If that fails and we get here - just panic */
+		panic("Returned from Terminate-Request to Hypervisor\n");
+	}
+
+	instrumentation_end();
+	irqentry_nmi_exit(regs, irq_state);
+}
+
+/*
+ * Runtime #VC exception handler when raised from user mode. Runs in IRQ mode
+ * and will kill the current task with SIGBUS when an error happens.
+ */
+DEFINE_IDTENTRY_VC_USER(exc_vmm_communication)
+{
+	/*
+	 * Handle #DB before calling into !noinstr code to avoid recursive #DB.
+	 */
+	if (vc_is_db(error_code)) {
+		noist_exc_debug(regs);
+		return;
+	}
+
+	irqentry_enter_from_user_mode(regs);
+	instrumentation_begin();
+
+	if (!vc_raw_handle_exception(regs, error_code)) {
+		/*
+		 * Do not kill the machine if user-space triggered the
+		 * exception. Send SIGBUS instead and let user-space deal with
+		 * it.
+		 */
+		force_sig_fault(SIGBUS, BUS_OBJERR, (void __user *)0);
+	}
+
+	instrumentation_end();
+	irqentry_exit_to_user_mode(regs);
+}
+
+bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
+{
+	unsigned long exit_code = regs->orig_ax;
+	struct es_em_ctxt ctxt;
+	enum es_result result;
+
+	vc_ghcb_invalidate(boot_ghcb);
+
+	result = vc_init_em_ctxt(&ctxt, regs, exit_code);
+	if (result == ES_OK)
+		result = vc_handle_exitcode(&ctxt, boot_ghcb, exit_code);
+
+	/* Done - now check the result */
+	switch (result) {
+	case ES_OK:
+		vc_finish_insn(&ctxt);
+		break;
+	case ES_UNSUPPORTED:
+		early_printk("PANIC: Unsupported exit-code 0x%02lx in early #VC exception (IP: 0x%lx)\n",
+				exit_code, regs->ip);
+		goto fail;
+	case ES_VMM_ERROR:
+		early_printk("PANIC: Failure in communication with VMM (exit-code 0x%02lx IP: 0x%lx)\n",
+				exit_code, regs->ip);
+		goto fail;
+	case ES_DECODE_FAILED:
+		early_printk("PANIC: Failed to decode instruction (exit-code 0x%02lx IP: 0x%lx)\n",
+				exit_code, regs->ip);
+		goto fail;
+	case ES_EXCEPTION:
+		vc_early_forward_exception(&ctxt);
+		break;
+	case ES_RETRY:
+		/* Nothing to do */
+		break;
+	default:
+		BUG();
+	}
+
+	return true;
+
+fail:
+	show_regs(regs);
+
+	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
+}
+
diff --git a/arch/x86/coco/sev/vc-shared.c b/arch/x86/coco/sev/vc-shared.c
new file mode 100644
index 0000000..2c0ab0f
--- /dev/null
+++ b/arch/x86/coco/sev/vc-shared.c
@@ -0,0 +1,504 @@
+// SPDX-License-Identifier: GPL-2.0
+
+static enum es_result vc_check_opcode_bytes(struct es_em_ctxt *ctxt,
+					    unsigned long exit_code)
+{
+	unsigned int opcode = (unsigned int)ctxt->insn.opcode.value;
+	u8 modrm = ctxt->insn.modrm.value;
+
+	switch (exit_code) {
+
+	case SVM_EXIT_IOIO:
+	case SVM_EXIT_NPF:
+		/* handled separately */
+		return ES_OK;
+
+	case SVM_EXIT_CPUID:
+		if (opcode == 0xa20f)
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_INVD:
+		if (opcode == 0x080f)
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_MONITOR:
+		/* MONITOR and MONITORX instructions generate the same error code */
+		if (opcode == 0x010f && (modrm == 0xc8 || modrm == 0xfa))
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_MWAIT:
+		/* MWAIT and MWAITX instructions generate the same error code */
+		if (opcode == 0x010f && (modrm == 0xc9 || modrm == 0xfb))
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_MSR:
+		/* RDMSR */
+		if (opcode == 0x320f ||
+		/* WRMSR */
+		    opcode == 0x300f)
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_RDPMC:
+		if (opcode == 0x330f)
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_RDTSC:
+		if (opcode == 0x310f)
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_RDTSCP:
+		if (opcode == 0x010f && modrm == 0xf9)
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_READ_DR7:
+		if (opcode == 0x210f &&
+		    X86_MODRM_REG(ctxt->insn.modrm.value) == 7)
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_VMMCALL:
+		if (opcode == 0x010f && modrm == 0xd9)
+			return ES_OK;
+
+		break;
+
+	case SVM_EXIT_WRITE_DR7:
+		if (opcode == 0x230f &&
+		    X86_MODRM_REG(ctxt->insn.modrm.value) == 7)
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_WBINVD:
+		if (opcode == 0x90f)
+			return ES_OK;
+		break;
+
+	default:
+		break;
+	}
+
+	sev_printk(KERN_ERR "Wrong/unhandled opcode bytes: 0x%x, exit_code: 0x%lx, rIP: 0x%lx\n",
+		   opcode, exit_code, ctxt->regs->ip);
+
+	return ES_UNSUPPORTED;
+}
+
+static bool vc_decoding_needed(unsigned long exit_code)
+{
+	/* Exceptions don't require to decode the instruction */
+	return !(exit_code >= SVM_EXIT_EXCP_BASE &&
+		 exit_code <= SVM_EXIT_LAST_EXCP);
+}
+
+static enum es_result vc_init_em_ctxt(struct es_em_ctxt *ctxt,
+				      struct pt_regs *regs,
+				      unsigned long exit_code)
+{
+	enum es_result ret = ES_OK;
+
+	memset(ctxt, 0, sizeof(*ctxt));
+	ctxt->regs = regs;
+
+	if (vc_decoding_needed(exit_code))
+		ret = vc_decode_insn(ctxt);
+
+	return ret;
+}
+
+static void vc_finish_insn(struct es_em_ctxt *ctxt)
+{
+	ctxt->regs->ip += ctxt->insn.length;
+}
+
+static enum es_result vc_insn_string_check(struct es_em_ctxt *ctxt,
+					   unsigned long address,
+					   bool write)
+{
+	if (user_mode(ctxt->regs) && fault_in_kernel_space(address)) {
+		ctxt->fi.vector     = X86_TRAP_PF;
+		ctxt->fi.error_code = X86_PF_USER;
+		ctxt->fi.cr2        = address;
+		if (write)
+			ctxt->fi.error_code |= X86_PF_WRITE;
+
+		return ES_EXCEPTION;
+	}
+
+	return ES_OK;
+}
+
+static enum es_result vc_insn_string_read(struct es_em_ctxt *ctxt,
+					  void *src, char *buf,
+					  unsigned int data_size,
+					  unsigned int count,
+					  bool backwards)
+{
+	int i, b = backwards ? -1 : 1;
+	unsigned long address = (unsigned long)src;
+	enum es_result ret;
+
+	ret = vc_insn_string_check(ctxt, address, false);
+	if (ret != ES_OK)
+		return ret;
+
+	for (i = 0; i < count; i++) {
+		void *s = src + (i * data_size * b);
+		char *d = buf + (i * data_size);
+
+		ret = vc_read_mem(ctxt, s, d, data_size);
+		if (ret != ES_OK)
+			break;
+	}
+
+	return ret;
+}
+
+static enum es_result vc_insn_string_write(struct es_em_ctxt *ctxt,
+					   void *dst, char *buf,
+					   unsigned int data_size,
+					   unsigned int count,
+					   bool backwards)
+{
+	int i, s = backwards ? -1 : 1;
+	unsigned long address = (unsigned long)dst;
+	enum es_result ret;
+
+	ret = vc_insn_string_check(ctxt, address, true);
+	if (ret != ES_OK)
+		return ret;
+
+	for (i = 0; i < count; i++) {
+		void *d = dst + (i * data_size * s);
+		char *b = buf + (i * data_size);
+
+		ret = vc_write_mem(ctxt, d, b, data_size);
+		if (ret != ES_OK)
+			break;
+	}
+
+	return ret;
+}
+
+#define IOIO_TYPE_STR  BIT(2)
+#define IOIO_TYPE_IN   1
+#define IOIO_TYPE_INS  (IOIO_TYPE_IN | IOIO_TYPE_STR)
+#define IOIO_TYPE_OUT  0
+#define IOIO_TYPE_OUTS (IOIO_TYPE_OUT | IOIO_TYPE_STR)
+
+#define IOIO_REP       BIT(3)
+
+#define IOIO_ADDR_64   BIT(9)
+#define IOIO_ADDR_32   BIT(8)
+#define IOIO_ADDR_16   BIT(7)
+
+#define IOIO_DATA_32   BIT(6)
+#define IOIO_DATA_16   BIT(5)
+#define IOIO_DATA_8    BIT(4)
+
+#define IOIO_SEG_ES    (0 << 10)
+#define IOIO_SEG_DS    (3 << 10)
+
+static enum es_result vc_ioio_exitinfo(struct es_em_ctxt *ctxt, u64 *exitinfo)
+{
+	struct insn *insn = &ctxt->insn;
+	size_t size;
+	u64 port;
+
+	*exitinfo = 0;
+
+	switch (insn->opcode.bytes[0]) {
+	/* INS opcodes */
+	case 0x6c:
+	case 0x6d:
+		*exitinfo |= IOIO_TYPE_INS;
+		*exitinfo |= IOIO_SEG_ES;
+		port	   = ctxt->regs->dx & 0xffff;
+		break;
+
+	/* OUTS opcodes */
+	case 0x6e:
+	case 0x6f:
+		*exitinfo |= IOIO_TYPE_OUTS;
+		*exitinfo |= IOIO_SEG_DS;
+		port	   = ctxt->regs->dx & 0xffff;
+		break;
+
+	/* IN immediate opcodes */
+	case 0xe4:
+	case 0xe5:
+		*exitinfo |= IOIO_TYPE_IN;
+		port	   = (u8)insn->immediate.value & 0xffff;
+		break;
+
+	/* OUT immediate opcodes */
+	case 0xe6:
+	case 0xe7:
+		*exitinfo |= IOIO_TYPE_OUT;
+		port	   = (u8)insn->immediate.value & 0xffff;
+		break;
+
+	/* IN register opcodes */
+	case 0xec:
+	case 0xed:
+		*exitinfo |= IOIO_TYPE_IN;
+		port	   = ctxt->regs->dx & 0xffff;
+		break;
+
+	/* OUT register opcodes */
+	case 0xee:
+	case 0xef:
+		*exitinfo |= IOIO_TYPE_OUT;
+		port	   = ctxt->regs->dx & 0xffff;
+		break;
+
+	default:
+		return ES_DECODE_FAILED;
+	}
+
+	*exitinfo |= port << 16;
+
+	switch (insn->opcode.bytes[0]) {
+	case 0x6c:
+	case 0x6e:
+	case 0xe4:
+	case 0xe6:
+	case 0xec:
+	case 0xee:
+		/* Single byte opcodes */
+		*exitinfo |= IOIO_DATA_8;
+		size       = 1;
+		break;
+	default:
+		/* Length determined by instruction parsing */
+		*exitinfo |= (insn->opnd_bytes == 2) ? IOIO_DATA_16
+						     : IOIO_DATA_32;
+		size       = (insn->opnd_bytes == 2) ? 2 : 4;
+	}
+
+	switch (insn->addr_bytes) {
+	case 2:
+		*exitinfo |= IOIO_ADDR_16;
+		break;
+	case 4:
+		*exitinfo |= IOIO_ADDR_32;
+		break;
+	case 8:
+		*exitinfo |= IOIO_ADDR_64;
+		break;
+	}
+
+	if (insn_has_rep_prefix(insn))
+		*exitinfo |= IOIO_REP;
+
+	return vc_ioio_check(ctxt, (u16)port, size);
+}
+
+static enum es_result vc_handle_ioio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
+{
+	struct pt_regs *regs = ctxt->regs;
+	u64 exit_info_1, exit_info_2;
+	enum es_result ret;
+
+	ret = vc_ioio_exitinfo(ctxt, &exit_info_1);
+	if (ret != ES_OK)
+		return ret;
+
+	if (exit_info_1 & IOIO_TYPE_STR) {
+
+		/* (REP) INS/OUTS */
+
+		bool df = ((regs->flags & X86_EFLAGS_DF) == X86_EFLAGS_DF);
+		unsigned int io_bytes, exit_bytes;
+		unsigned int ghcb_count, op_count;
+		unsigned long es_base;
+		u64 sw_scratch;
+
+		/*
+		 * For the string variants with rep prefix the amount of in/out
+		 * operations per #VC exception is limited so that the kernel
+		 * has a chance to take interrupts and re-schedule while the
+		 * instruction is emulated.
+		 */
+		io_bytes   = (exit_info_1 >> 4) & 0x7;
+		ghcb_count = sizeof(ghcb->shared_buffer) / io_bytes;
+
+		op_count    = (exit_info_1 & IOIO_REP) ? regs->cx : 1;
+		exit_info_2 = min(op_count, ghcb_count);
+		exit_bytes  = exit_info_2 * io_bytes;
+
+		es_base = insn_get_seg_base(ctxt->regs, INAT_SEG_REG_ES);
+
+		/* Read bytes of OUTS into the shared buffer */
+		if (!(exit_info_1 & IOIO_TYPE_IN)) {
+			ret = vc_insn_string_read(ctxt,
+					       (void *)(es_base + regs->si),
+					       ghcb->shared_buffer, io_bytes,
+					       exit_info_2, df);
+			if (ret)
+				return ret;
+		}
+
+		/*
+		 * Issue an VMGEXIT to the HV to consume the bytes from the
+		 * shared buffer or to have it write them into the shared buffer
+		 * depending on the instruction: OUTS or INS.
+		 */
+		sw_scratch = __pa(ghcb) + offsetof(struct ghcb, shared_buffer);
+		ghcb_set_sw_scratch(ghcb, sw_scratch);
+		ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_IOIO,
+					  exit_info_1, exit_info_2);
+		if (ret != ES_OK)
+			return ret;
+
+		/* Read bytes from shared buffer into the guest's destination. */
+		if (exit_info_1 & IOIO_TYPE_IN) {
+			ret = vc_insn_string_write(ctxt,
+						   (void *)(es_base + regs->di),
+						   ghcb->shared_buffer, io_bytes,
+						   exit_info_2, df);
+			if (ret)
+				return ret;
+
+			if (df)
+				regs->di -= exit_bytes;
+			else
+				regs->di += exit_bytes;
+		} else {
+			if (df)
+				regs->si -= exit_bytes;
+			else
+				regs->si += exit_bytes;
+		}
+
+		if (exit_info_1 & IOIO_REP)
+			regs->cx -= exit_info_2;
+
+		ret = regs->cx ? ES_RETRY : ES_OK;
+
+	} else {
+
+		/* IN/OUT into/from rAX */
+
+		int bits = (exit_info_1 & 0x70) >> 1;
+		u64 rax = 0;
+
+		if (!(exit_info_1 & IOIO_TYPE_IN))
+			rax = lower_bits(regs->ax, bits);
+
+		ghcb_set_rax(ghcb, rax);
+
+		ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_IOIO, exit_info_1, 0);
+		if (ret != ES_OK)
+			return ret;
+
+		if (exit_info_1 & IOIO_TYPE_IN) {
+			if (!ghcb_rax_is_valid(ghcb))
+				return ES_VMM_ERROR;
+			regs->ax = lower_bits(ghcb->save.rax, bits);
+		}
+	}
+
+	return ret;
+}
+
+static int vc_handle_cpuid_snp(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
+{
+	struct pt_regs *regs = ctxt->regs;
+	struct cpuid_leaf leaf;
+	int ret;
+
+	leaf.fn = regs->ax;
+	leaf.subfn = regs->cx;
+	ret = snp_cpuid(ghcb, ctxt, &leaf);
+	if (!ret) {
+		regs->ax = leaf.eax;
+		regs->bx = leaf.ebx;
+		regs->cx = leaf.ecx;
+		regs->dx = leaf.edx;
+	}
+
+	return ret;
+}
+
+static enum es_result vc_handle_cpuid(struct ghcb *ghcb,
+				      struct es_em_ctxt *ctxt)
+{
+	struct pt_regs *regs = ctxt->regs;
+	u32 cr4 = native_read_cr4();
+	enum es_result ret;
+	int snp_cpuid_ret;
+
+	snp_cpuid_ret = vc_handle_cpuid_snp(ghcb, ctxt);
+	if (!snp_cpuid_ret)
+		return ES_OK;
+	if (snp_cpuid_ret != -EOPNOTSUPP)
+		return ES_VMM_ERROR;
+
+	ghcb_set_rax(ghcb, regs->ax);
+	ghcb_set_rcx(ghcb, regs->cx);
+
+	if (cr4 & X86_CR4_OSXSAVE)
+		/* Safe to read xcr0 */
+		ghcb_set_xcr0(ghcb, xgetbv(XCR_XFEATURE_ENABLED_MASK));
+	else
+		/* xgetbv will cause #GP - use reset value for xcr0 */
+		ghcb_set_xcr0(ghcb, 1);
+
+	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_CPUID, 0, 0);
+	if (ret != ES_OK)
+		return ret;
+
+	if (!(ghcb_rax_is_valid(ghcb) &&
+	      ghcb_rbx_is_valid(ghcb) &&
+	      ghcb_rcx_is_valid(ghcb) &&
+	      ghcb_rdx_is_valid(ghcb)))
+		return ES_VMM_ERROR;
+
+	regs->ax = ghcb->save.rax;
+	regs->bx = ghcb->save.rbx;
+	regs->cx = ghcb->save.rcx;
+	regs->dx = ghcb->save.rdx;
+
+	return ES_OK;
+}
+
+static enum es_result vc_handle_rdtsc(struct ghcb *ghcb,
+				      struct es_em_ctxt *ctxt,
+				      unsigned long exit_code)
+{
+	bool rdtscp = (exit_code == SVM_EXIT_RDTSCP);
+	enum es_result ret;
+
+	/*
+	 * The hypervisor should not be intercepting RDTSC/RDTSCP when Secure
+	 * TSC is enabled. A #VC exception will be generated if the RDTSC/RDTSCP
+	 * instructions are being intercepted. If this should occur and Secure
+	 * TSC is enabled, guest execution should be terminated as the guest
+	 * cannot rely on the TSC value provided by the hypervisor.
+	 */
+	if (sev_status & MSR_AMD64_SNP_SECURE_TSC)
+		return ES_VMM_ERROR;
+
+	ret = sev_es_ghcb_hv_call(ghcb, ctxt, exit_code, 0, 0);
+	if (ret != ES_OK)
+		return ret;
+
+	if (!(ghcb_rax_is_valid(ghcb) && ghcb_rdx_is_valid(ghcb) &&
+	     (!rdtscp || ghcb_rcx_is_valid(ghcb))))
+		return ES_VMM_ERROR;
+
+	ctxt->regs->ax = ghcb->save.rax;
+	ctxt->regs->dx = ghcb->save.rdx;
+	if (rdtscp)
+		ctxt->regs->cx = ghcb->save.rcx;
+
+	return ES_OK;
+}
diff --git a/arch/x86/include/asm/sev-internal.h b/arch/x86/include/asm/sev-internal.h
index a78f972..b723208 100644
--- a/arch/x86/include/asm/sev-internal.h
+++ b/arch/x86/include/asm/sev-internal.h
@@ -3,7 +3,6 @@
 #define DR7_RESET_VALUE        0x400
 
 extern struct ghcb boot_ghcb_page;
-extern struct ghcb *boot_ghcb;
 extern u64 sev_hv_features;
 extern u64 sev_secrets_pa;
 
@@ -59,8 +58,6 @@ DECLARE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
 void early_set_pages_state(unsigned long vaddr, unsigned long paddr,
 			   unsigned long npages, enum psc_op op);
 
-void __noreturn sev_es_terminate(unsigned int set, unsigned int reason);
-
 DECLARE_PER_CPU(struct svsm_ca *, svsm_caa);
 DECLARE_PER_CPU(u64, svsm_caa_pa);
 
@@ -100,11 +97,6 @@ static __always_inline void sev_es_wr_ghcb_msr(u64 val)
 	native_wrmsr(MSR_AMD64_SEV_ES_GHCB, low, high);
 }
 
-enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
-				   struct es_em_ctxt *ctxt,
-				   u64 exit_code, u64 exit_info_1,
-				   u64 exit_info_2);
-
 void snp_register_ghcb_early(unsigned long paddr);
 bool sev_es_negotiate_protocol(void);
 bool sev_es_check_cpu_features(void);
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index a8661df..6158893 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -521,6 +521,28 @@ static __always_inline void vc_ghcb_invalidate(struct ghcb *ghcb)
 	__builtin_memset(ghcb->save.valid_bitmap, 0, sizeof(ghcb->save.valid_bitmap));
 }
 
+void vc_forward_exception(struct es_em_ctxt *ctxt);
+
+/* I/O parameters for CPUID-related helpers */
+struct cpuid_leaf {
+	u32 fn;
+	u32 subfn;
+	u32 eax;
+	u32 ebx;
+	u32 ecx;
+	u32 edx;
+};
+
+int snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf);
+
+void __noreturn sev_es_terminate(unsigned int set, unsigned int reason);
+enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
+				   struct es_em_ctxt *ctxt,
+				   u64 exit_code, u64 exit_info_1,
+				   u64 exit_info_2);
+
+extern struct ghcb *boot_ghcb;
+
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
 
 #define snp_vmpl 0

