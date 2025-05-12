Return-Path: <linux-efi+bounces-3660-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED050AB448E
	for <lists+linux-efi@lfdr.de>; Mon, 12 May 2025 21:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E3F116EB06
	for <lists+linux-efi@lfdr.de>; Mon, 12 May 2025 19:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22952298CC9;
	Mon, 12 May 2025 19:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a7ilOvTL"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78986298CAB
	for <linux-efi@vger.kernel.org>; Mon, 12 May 2025 19:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747077107; cv=none; b=RRFnKqBSdJs/ixz80/iaCnGL8VhZO8KL77N/gzu02nF/gwhux34UbXmzDoXz8JkDvnERydHu9Vo56zCy6f3WknW6cWco/bQdi4ZRzMkyNVCPrQQYb9vCu6pe9GUBkE35XYTFI6uS4ilYIlcIHx1MbaqIvA334bye5FeoQsPjnag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747077107; c=relaxed/simple;
	bh=EsOakeC/Phz2KSj3ueqUKzDoUxs7glVALXUQVB7i3bM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YCDsDeXkmnDqaAPcdLCAT2qEzZPWtP7FfYMVn9ASnJIIvt0RUdUtyrRrPIkqabGWuELiIe2peHcEzxzY6ayw157oPT9YaKBlv9zouTgHdtdBwqZifGqpYGhTphAnlXHi5lCTHcebX4B4ehlirt2tzZdw6tYm5fURbPQnLaj8Lnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a7ilOvTL; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43cf5196c25so23815995e9.0
        for <linux-efi@vger.kernel.org>; Mon, 12 May 2025 12:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747077103; x=1747681903; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/r+WMXBO/gfDlqsyugcImJrsAq/d8Zz4Wr6G5LEn+9E=;
        b=a7ilOvTLhgq1D0pUUXX4FDj+JrH3n+erzKFL0RrESWo29YnROTDfc668JZcbeM6gsx
         zI1EPLr/fpChtgyw0kUbnO8/mrhYQ9Ssg14QEs6rw7dHggtU1gA8ZwZvoFTQe640Yvcs
         8Vrj8yuk5a8B3tomNQ7yfgQqlPsChhjzG5DHW6VBW4NlF3/91u2QjU5H3hoAJ1OYFXwO
         3WP1uuOiU7ZZF1RSgXoEF8e4cTCOn0bLtHkzie6gcyP3NQaLezH85c38dWlHsJa2XvcF
         4iLgMLWQrZEbmO57jQe17PJWSDz9+wACIt2Yc3TBC73IV4CVv3SfWndDwAQk6HR1Co8O
         ZwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747077103; x=1747681903;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/r+WMXBO/gfDlqsyugcImJrsAq/d8Zz4Wr6G5LEn+9E=;
        b=KLYFD2svh3uQzm7kBhkznZMqj8dSKmHHJc/hl96Y95bVBUcfxeTBxGG6KKmP81fSDc
         SA8mHiln777q20cw2h/68+rJNSOg5DNDRLEBpRGnMEWssohe73YdocM9eTGPqzjLraXM
         N0x0PhM9gS8TvkFN1MMMcbJsXGG/lOvYJJptaKEbzZYp3FYMkIZnzal4TD3CsKHBdH/v
         ILF3XQf86jQAK2ZBlv7YoGavwcPQawvvn6p16KhjzgN9E45/dwDU8fLzYB9wjaQP24Yb
         E/C4qjkj2AgUOIsHkBxw3bTMMJyK5SuboLZuQiKb/QZl1RS1FVHhgASbmxC/zdXx8ZZW
         xpDw==
X-Gm-Message-State: AOJu0YxMXhSIfy7KBHo4tqPdVUWI30+83P+fz553Z3RG4zzhkskO/a1u
	p4Zzr+YJxm5a57TSkk8nPzbnIljme+DR6sg5fEdTP97oaKn/pCuG6M0WFgBFvGCQeLh1dw==
X-Google-Smtp-Source: AGHT+IHWFoadMMw6DJrqhZ8yK4ycBZLMVndhAccvxLZMZpJp7mm9Gy7aW2fCl2/ASDbCWfa0yBkM3ymx
X-Received: from wmbhj14.prod.google.com ([2002:a05:600c:528e:b0:43b:d6ca:6dd3])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4e90:b0:43c:f050:fed3
 with SMTP id 5b1f17b1804b1-442d6d3e35amr95287015e9.11.1747077102857; Mon, 12
 May 2025 12:11:42 -0700 (PDT)
Date: Mon, 12 May 2025 21:08:40 +0200
In-Reply-To: <20250512190834.332684-23-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250512190834.332684-23-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=20707; i=ardb@kernel.org;
 h=from:subject; bh=xJuAohr1Yjdxojosm4HIflLT3rqnlRRJHuN1gXHuuDw=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPJ3e7T4c3Oef5X3ZfbVF+asCHcq+Pnuv6kdTyLkgM2R
 3n1uC3uKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABNZFcPIsFzXc87z4yxP6jdE
 CxyYLmq0e4rj6Yu9KyeZpvxaGqN8ZAPDP7UT3g090ya4SQQ8jP3t7tP1Zc7JVo0DtefL+Fa1flY 6yAcA
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250512190834.332684-28-ardb+git@google.com>
Subject: [RFT PATCH v3 05/21] x86/sev: Move GHCB page based HV communication
 out of startup code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Both the decompressor and the core kernel implement an early #VC
handler, which only deals with CPUID instructions, and full featured
one, which can handle any #VC exception.

The former communicates with the hypervisor using the MSR based
protocol, whereas the latter uses a shared GHCB page, which is
configured a bit later during the boot, when the kernel runs from its
ordinary virtual mapping, rather than the 1:1 mapping that the startup
code uses.

Accessing this shared GHCB page from the core kernel's startup code is
problematic, because it involves converting the GHCB address provided by
the caller to a physical address. In the startup code, virtual to
physical address translations are problematic, given that the virtual
address might be a 1:1 mapped address, and such translations should
therefore be avoided.

This means that exposing startup code dealing with the GHCB to callers
that execute from the ordinary kernel virtual mapping should be avoided
too. So move all GHCB page based communication out of the startup code,
now that all communication occurring before the kernel virtual mapping
is up relies on the MSR protocol only.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/sev-handle-vc.c |   3 +
 arch/x86/boot/startup/sev-shared.c       | 190 +-------------------
 arch/x86/boot/startup/sev-startup.c      |  42 -----
 arch/x86/coco/sev/core.c                 |  76 ++++++++
 arch/x86/coco/sev/vc-handle.c            |   2 +
 arch/x86/coco/sev/vc-shared.c            |  94 ++++++++++
 arch/x86/include/asm/sev-internal.h      |   7 +-
 arch/x86/include/asm/sev.h               |  59 +++++-
 8 files changed, 236 insertions(+), 237 deletions(-)

diff --git a/arch/x86/boot/compressed/sev-handle-vc.c b/arch/x86/boot/compressed/sev-handle-vc.c
index 89dd02de2a0f..7530ad8b768b 100644
--- a/arch/x86/boot/compressed/sev-handle-vc.c
+++ b/arch/x86/boot/compressed/sev-handle-vc.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include "misc.h"
+#include "error.h"
 #include "sev.h"
 
 #include <linux/kernel.h>
@@ -14,6 +15,8 @@
 #include <asm/fpu/xcr.h>
 
 #define __BOOT_COMPRESSED
+#undef __init
+#define __init
 
 /* Basic instruction decoding support needed */
 #include "../../lib/inat.c"
diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index 9c8dd6bfe833..7884884c0898 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -13,12 +13,9 @@
 
 #ifndef __BOOT_COMPRESSED
 #define error(v)			pr_err(v)
-#define has_cpuflag(f)			boot_cpu_has(f)
 #else
 #undef WARN
 #define WARN(condition, format...) (!!(condition))
-#undef vc_forward_exception
-#define vc_forward_exception(c)		panic("SNP: Hypervisor requested exception\n")
 #endif
 
 /*
@@ -39,7 +36,7 @@ u64 boot_svsm_caa_pa __ro_after_init;
  *
  * GHCB protocol version negotiated with the hypervisor.
  */
-static u16 ghcb_version __ro_after_init;
+u16 ghcb_version __ro_after_init;
 
 /* Copy of the SNP firmware's CPUID page. */
 static struct snp_cpuid_table cpuid_table_copy __ro_after_init;
@@ -54,16 +51,6 @@ static u32 cpuid_std_range_max __ro_after_init;
 static u32 cpuid_hyp_range_max __ro_after_init;
 static u32 cpuid_ext_range_max __ro_after_init;
 
-bool __init sev_es_check_cpu_features(void)
-{
-	if (!has_cpuflag(X86_FEATURE_RDRAND)) {
-		error("RDRAND instruction not supported - no trusted source of randomness available\n");
-		return false;
-	}
-
-	return true;
-}
-
 void __head __noreturn
 sev_es_terminate(unsigned int set, unsigned int reason)
 {
@@ -100,123 +87,7 @@ u64 get_hv_features(void)
 	return GHCB_MSR_HV_FT_RESP_VAL(val);
 }
 
-void snp_register_ghcb_early(unsigned long paddr)
-{
-	unsigned long pfn = paddr >> PAGE_SHIFT;
-	u64 val;
-
-	sev_es_wr_ghcb_msr(GHCB_MSR_REG_GPA_REQ_VAL(pfn));
-	VMGEXIT();
-
-	val = sev_es_rd_ghcb_msr();
-
-	/* If the response GPA is not ours then abort the guest */
-	if ((GHCB_RESP_CODE(val) != GHCB_MSR_REG_GPA_RESP) ||
-	    (GHCB_MSR_REG_GPA_RESP_VAL(val) != pfn))
-		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_REGISTER);
-}
-
-bool sev_es_negotiate_protocol(void)
-{
-	u64 val;
-
-	/* Do the GHCB protocol version negotiation */
-	sev_es_wr_ghcb_msr(GHCB_MSR_SEV_INFO_REQ);
-	VMGEXIT();
-	val = sev_es_rd_ghcb_msr();
-
-	if (GHCB_MSR_INFO(val) != GHCB_MSR_SEV_INFO_RESP)
-		return false;
-
-	if (GHCB_MSR_PROTO_MAX(val) < GHCB_PROTOCOL_MIN ||
-	    GHCB_MSR_PROTO_MIN(val) > GHCB_PROTOCOL_MAX)
-		return false;
-
-	ghcb_version = min_t(size_t, GHCB_MSR_PROTO_MAX(val), GHCB_PROTOCOL_MAX);
-
-	return true;
-}
-
-static enum es_result verify_exception_info(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
-{
-	u32 ret;
-
-	ret = ghcb->save.sw_exit_info_1 & GENMASK_ULL(31, 0);
-	if (!ret)
-		return ES_OK;
-
-	if (ret == 1) {
-		u64 info = ghcb->save.sw_exit_info_2;
-		unsigned long v = info & SVM_EVTINJ_VEC_MASK;
-
-		/* Check if exception information from hypervisor is sane. */
-		if ((info & SVM_EVTINJ_VALID) &&
-		    ((v == X86_TRAP_GP) || (v == X86_TRAP_UD)) &&
-		    ((info & SVM_EVTINJ_TYPE_MASK) == SVM_EVTINJ_TYPE_EXEPT)) {
-			ctxt->fi.vector = v;
-
-			if (info & SVM_EVTINJ_VALID_ERR)
-				ctxt->fi.error_code = info >> 32;
-
-			return ES_EXCEPTION;
-		}
-	}
-
-	return ES_VMM_ERROR;
-}
-
-static inline int svsm_process_result_codes(struct svsm_call *call)
-{
-	switch (call->rax_out) {
-	case SVSM_SUCCESS:
-		return 0;
-	case SVSM_ERR_INCOMPLETE:
-	case SVSM_ERR_BUSY:
-		return -EAGAIN;
-	default:
-		return -EINVAL;
-	}
-}
-
-/*
- * Issue a VMGEXIT to call the SVSM:
- *   - Load the SVSM register state (RAX, RCX, RDX, R8 and R9)
- *   - Set the CA call pending field to 1
- *   - Issue VMGEXIT
- *   - Save the SVSM return register state (RAX, RCX, RDX, R8 and R9)
- *   - Perform atomic exchange of the CA call pending field
- *
- *   - See the "Secure VM Service Module for SEV-SNP Guests" specification for
- *     details on the calling convention.
- *     - The calling convention loosely follows the Microsoft X64 calling
- *       convention by putting arguments in RCX, RDX, R8 and R9.
- *     - RAX specifies the SVSM protocol/callid as input and the return code
- *       as output.
- */
-static __always_inline void svsm_issue_call(struct svsm_call *call, u8 *pending)
-{
-	register unsigned long rax asm("rax") = call->rax;
-	register unsigned long rcx asm("rcx") = call->rcx;
-	register unsigned long rdx asm("rdx") = call->rdx;
-	register unsigned long r8  asm("r8")  = call->r8;
-	register unsigned long r9  asm("r9")  = call->r9;
-
-	call->caa->call_pending = 1;
-
-	asm volatile("rep; vmmcall\n\t"
-		     : "+r" (rax), "+r" (rcx), "+r" (rdx), "+r" (r8), "+r" (r9)
-		     : : "memory");
-
-	*pending = xchg(&call->caa->call_pending, *pending);
-
-	call->rax_out = rax;
-	call->rcx_out = rcx;
-	call->rdx_out = rdx;
-	call->r8_out  = r8;
-	call->r9_out  = r9;
-}
-
-static int svsm_perform_msr_protocol(struct svsm_call *call)
+int svsm_perform_msr_protocol(struct svsm_call *call)
 {
 	u8 pending = 0;
 	u64 val, resp;
@@ -247,63 +118,6 @@ static int svsm_perform_msr_protocol(struct svsm_call *call)
 	return svsm_process_result_codes(call);
 }
 
-static int svsm_perform_ghcb_protocol(struct ghcb *ghcb, struct svsm_call *call)
-{
-	struct es_em_ctxt ctxt;
-	u8 pending = 0;
-
-	vc_ghcb_invalidate(ghcb);
-
-	/*
-	 * Fill in protocol and format specifiers. This can be called very early
-	 * in the boot, so use rip-relative references as needed.
-	 */
-	ghcb->protocol_version = ghcb_version;
-	ghcb->ghcb_usage       = GHCB_DEFAULT_USAGE;
-
-	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_SNP_RUN_VMPL);
-	ghcb_set_sw_exit_info_1(ghcb, 0);
-	ghcb_set_sw_exit_info_2(ghcb, 0);
-
-	sev_es_wr_ghcb_msr(__pa(ghcb));
-
-	svsm_issue_call(call, &pending);
-
-	if (pending)
-		return -EINVAL;
-
-	switch (verify_exception_info(ghcb, &ctxt)) {
-	case ES_OK:
-		break;
-	case ES_EXCEPTION:
-		vc_forward_exception(&ctxt);
-		fallthrough;
-	default:
-		return -EINVAL;
-	}
-
-	return svsm_process_result_codes(call);
-}
-
-enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
-				   struct es_em_ctxt *ctxt,
-				   u64 exit_code, u64 exit_info_1,
-				   u64 exit_info_2)
-{
-	/* Fill in protocol and format specifiers */
-	ghcb->protocol_version = ghcb_version;
-	ghcb->ghcb_usage       = GHCB_DEFAULT_USAGE;
-
-	ghcb_set_sw_exit_code(ghcb, exit_code);
-	ghcb_set_sw_exit_info_1(ghcb, exit_info_1);
-	ghcb_set_sw_exit_info_2(ghcb, exit_info_2);
-
-	sev_es_wr_ghcb_msr(__pa(ghcb));
-	VMGEXIT();
-
-	return verify_exception_info(ghcb, ctxt);
-}
-
 static int __sev_cpuid_hv(u32 fn, int reg_idx, u32 *reg)
 {
 	u64 val;
diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index 1f928e8264bb..0000885dc24c 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -41,15 +41,6 @@
 #include <asm/cpuid.h>
 #include <asm/cmdline.h>
 
-/* For early boot hypervisor communication in SEV-ES enabled guests */
-struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
-
-/*
- * Needs to be in the .data section because we need it NULL before bss is
- * cleared
- */
-struct ghcb *boot_ghcb __section(".data");
-
 /* Bitmap of SEV features supported by the hypervisor */
 u64 sev_hv_features __ro_after_init;
 
@@ -139,39 +130,6 @@ noinstr void __sev_put_ghcb(struct ghcb_state *state)
 	}
 }
 
-int svsm_perform_call_protocol(struct svsm_call *call)
-{
-	struct ghcb_state state;
-	unsigned long flags;
-	struct ghcb *ghcb;
-	int ret;
-
-	/*
-	 * This can be called very early in the boot, use native functions in
-	 * order to avoid paravirt issues.
-	 */
-	flags = native_local_irq_save();
-
-	if (sev_cfg.ghcbs_initialized)
-		ghcb = __sev_get_ghcb(&state);
-	else if (boot_ghcb)
-		ghcb = boot_ghcb;
-	else
-		ghcb = NULL;
-
-	do {
-		ret = ghcb ? svsm_perform_ghcb_protocol(ghcb, call)
-			   : svsm_perform_msr_protocol(call);
-	} while (ret == -EAGAIN);
-
-	if (sev_cfg.ghcbs_initialized)
-		__sev_put_ghcb(&state);
-
-	native_local_irq_restore(flags);
-
-	return ret;
-}
-
 void __head
 early_set_pages_state(unsigned long vaddr, unsigned long paddr,
 		      unsigned long npages, enum psc_op op)
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index ac400525de73..310d867be4dc 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -100,6 +100,15 @@ DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
 u8 snp_vmpl __ro_after_init;
 EXPORT_SYMBOL_GPL(snp_vmpl);
 
+/* For early boot hypervisor communication in SEV-ES enabled guests */
+static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
+
+/*
+ * Needs to be in the .data section because we need it NULL before bss is
+ * cleared
+ */
+struct ghcb *boot_ghcb __section(".data");
+
 static u64 __init get_snp_jump_table_addr(void)
 {
 	struct snp_secrets_page *secrets;
@@ -153,6 +162,73 @@ static u64 __init get_jump_table_addr(void)
 	return ret;
 }
 
+static int svsm_perform_ghcb_protocol(struct ghcb *ghcb, struct svsm_call *call)
+{
+	struct es_em_ctxt ctxt;
+	u8 pending = 0;
+
+	vc_ghcb_invalidate(ghcb);
+
+	/*
+	 * Fill in protocol and format specifiers. This can be called very early
+	 * in the boot, so use rip-relative references as needed.
+	 */
+	ghcb->protocol_version = ghcb_version;
+	ghcb->ghcb_usage       = GHCB_DEFAULT_USAGE;
+
+	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_SNP_RUN_VMPL);
+	ghcb_set_sw_exit_info_1(ghcb, 0);
+	ghcb_set_sw_exit_info_2(ghcb, 0);
+
+	sev_es_wr_ghcb_msr(__pa(ghcb));
+
+	svsm_issue_call(call, &pending);
+
+	if (pending)
+		return -EINVAL;
+
+	switch (verify_exception_info(ghcb, &ctxt)) {
+	case ES_OK:
+		break;
+	case ES_EXCEPTION:
+		vc_forward_exception(&ctxt);
+		fallthrough;
+	default:
+		return -EINVAL;
+	}
+
+	return svsm_process_result_codes(call);
+}
+
+static int svsm_perform_call_protocol(struct svsm_call *call)
+{
+	struct ghcb_state state;
+	unsigned long flags;
+	struct ghcb *ghcb;
+	int ret;
+
+	flags = native_local_irq_save();
+
+	if (sev_cfg.ghcbs_initialized)
+		ghcb = __sev_get_ghcb(&state);
+	else if (boot_ghcb)
+		ghcb = boot_ghcb;
+	else
+		ghcb = NULL;
+
+	do {
+		ret = ghcb ? svsm_perform_ghcb_protocol(ghcb, call)
+			   : svsm_perform_msr_protocol(call);
+	} while (ret == -EAGAIN);
+
+	if (sev_cfg.ghcbs_initialized)
+		__sev_put_ghcb(&state);
+
+	native_local_irq_restore(flags);
+
+	return ret;
+}
+
 static inline void __pval_terminate(u64 pfn, bool action, unsigned int page_size,
 				    int ret, u64 svsm_ret)
 {
diff --git a/arch/x86/coco/sev/vc-handle.c b/arch/x86/coco/sev/vc-handle.c
index b4895c648024..3cadaa46b9d7 100644
--- a/arch/x86/coco/sev/vc-handle.c
+++ b/arch/x86/coco/sev/vc-handle.c
@@ -344,6 +344,8 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
 }
 
 #define sev_printk(fmt, ...)		printk(fmt, ##__VA_ARGS__)
+#define error(v)
+#define has_cpuflag(f)			boot_cpu_has(f)
 
 #include "vc-shared.c"
 
diff --git a/arch/x86/coco/sev/vc-shared.c b/arch/x86/coco/sev/vc-shared.c
index b4688f69102e..9b01c9ad81be 100644
--- a/arch/x86/coco/sev/vc-shared.c
+++ b/arch/x86/coco/sev/vc-shared.c
@@ -409,6 +409,53 @@ static enum es_result vc_handle_ioio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 	return ret;
 }
 
+enum es_result verify_exception_info(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
+{
+	u32 ret;
+
+	ret = ghcb->save.sw_exit_info_1 & GENMASK_ULL(31, 0);
+	if (!ret)
+		return ES_OK;
+
+	if (ret == 1) {
+		u64 info = ghcb->save.sw_exit_info_2;
+		unsigned long v = info & SVM_EVTINJ_VEC_MASK;
+
+		/* Check if exception information from hypervisor is sane. */
+		if ((info & SVM_EVTINJ_VALID) &&
+		    ((v == X86_TRAP_GP) || (v == X86_TRAP_UD)) &&
+		    ((info & SVM_EVTINJ_TYPE_MASK) == SVM_EVTINJ_TYPE_EXEPT)) {
+			ctxt->fi.vector = v;
+
+			if (info & SVM_EVTINJ_VALID_ERR)
+				ctxt->fi.error_code = info >> 32;
+
+			return ES_EXCEPTION;
+		}
+	}
+
+	return ES_VMM_ERROR;
+}
+
+enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
+				   struct es_em_ctxt *ctxt,
+				   u64 exit_code, u64 exit_info_1,
+				   u64 exit_info_2)
+{
+	/* Fill in protocol and format specifiers */
+	ghcb->protocol_version = ghcb_version;
+	ghcb->ghcb_usage       = GHCB_DEFAULT_USAGE;
+
+	ghcb_set_sw_exit_code(ghcb, exit_code);
+	ghcb_set_sw_exit_info_1(ghcb, exit_info_1);
+	ghcb_set_sw_exit_info_2(ghcb, exit_info_2);
+
+	sev_es_wr_ghcb_msr(__pa(ghcb));
+	VMGEXIT();
+
+	return verify_exception_info(ghcb, ctxt);
+}
+
 static int __sev_cpuid_hv_ghcb(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
 {
 	u32 cr4 = native_read_cr4();
@@ -549,3 +596,50 @@ static enum es_result vc_handle_rdtsc(struct ghcb *ghcb,
 
 	return ES_OK;
 }
+
+void snp_register_ghcb_early(unsigned long paddr)
+{
+	unsigned long pfn = paddr >> PAGE_SHIFT;
+	u64 val;
+
+	sev_es_wr_ghcb_msr(GHCB_MSR_REG_GPA_REQ_VAL(pfn));
+	VMGEXIT();
+
+	val = sev_es_rd_ghcb_msr();
+
+	/* If the response GPA is not ours then abort the guest */
+	if ((GHCB_RESP_CODE(val) != GHCB_MSR_REG_GPA_RESP) ||
+	    (GHCB_MSR_REG_GPA_RESP_VAL(val) != pfn))
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_REGISTER);
+}
+
+bool __init sev_es_check_cpu_features(void)
+{
+	if (!has_cpuflag(X86_FEATURE_RDRAND)) {
+		error("RDRAND instruction not supported - no trusted source of randomness available\n");
+		return false;
+	}
+
+	return true;
+}
+
+bool sev_es_negotiate_protocol(void)
+{
+	u64 val;
+
+	/* Do the GHCB protocol version negotiation */
+	sev_es_wr_ghcb_msr(GHCB_MSR_SEV_INFO_REQ);
+	VMGEXIT();
+	val = sev_es_rd_ghcb_msr();
+
+	if (GHCB_MSR_INFO(val) != GHCB_MSR_SEV_INFO_RESP)
+		return false;
+
+	if (GHCB_MSR_PROTO_MAX(val) < GHCB_PROTOCOL_MIN ||
+	    GHCB_MSR_PROTO_MIN(val) > GHCB_PROTOCOL_MAX)
+		return false;
+
+	ghcb_version = min_t(size_t, GHCB_MSR_PROTO_MAX(val), GHCB_PROTOCOL_MAX);
+
+	return true;
+}
diff --git a/arch/x86/include/asm/sev-internal.h b/arch/x86/include/asm/sev-internal.h
index b7232081f8f7..4269d9dbefdf 100644
--- a/arch/x86/include/asm/sev-internal.h
+++ b/arch/x86/include/asm/sev-internal.h
@@ -2,7 +2,6 @@
 
 #define DR7_RESET_VALUE        0x400
 
-extern struct ghcb boot_ghcb_page;
 extern u64 sev_hv_features;
 extern u64 sev_secrets_pa;
 
@@ -80,7 +79,8 @@ static __always_inline u64 svsm_get_caa_pa(void)
 		return boot_svsm_caa_pa;
 }
 
-int svsm_perform_call_protocol(struct svsm_call *call);
+enum es_result verify_exception_info(struct ghcb *ghcb, struct es_em_ctxt *ctxt);
+void vc_forward_exception(struct es_em_ctxt *ctxt);
 
 static inline u64 sev_es_rd_ghcb_msr(void)
 {
@@ -97,9 +97,6 @@ static __always_inline void sev_es_wr_ghcb_msr(u64 val)
 	native_wrmsr(MSR_AMD64_SEV_ES_GHCB, low, high);
 }
 
-void snp_register_ghcb_early(unsigned long paddr);
-bool sev_es_negotiate_protocol(void);
-bool sev_es_check_cpu_features(void);
 u64 get_hv_features(void);
 
 const struct snp_cpuid_table *snp_cpuid_get_table(void);
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index f50a606be4f1..07081bb85331 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -485,6 +485,7 @@ static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate)
 struct snp_guest_request_ioctl;
 
 void setup_ghcb(void);
+void snp_register_ghcb_early(unsigned long paddr);
 void early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
 				  unsigned long npages);
 void early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
@@ -521,8 +522,6 @@ static __always_inline void vc_ghcb_invalidate(struct ghcb *ghcb)
 	__builtin_memset(ghcb->save.valid_bitmap, 0, sizeof(ghcb->save.valid_bitmap));
 }
 
-void vc_forward_exception(struct es_em_ctxt *ctxt);
-
 /* I/O parameters for CPUID-related helpers */
 struct cpuid_leaf {
 	u32 fn;
@@ -533,15 +532,71 @@ struct cpuid_leaf {
 	u32 edx;
 };
 
+int svsm_perform_msr_protocol(struct svsm_call *call);
 int snp_cpuid(void (*cpuid_hv)(void *ctx, struct cpuid_leaf *),
 	      void *ctx, struct cpuid_leaf *leaf);
 
+/*
+ * Issue a VMGEXIT to call the SVSM:
+ *   - Load the SVSM register state (RAX, RCX, RDX, R8 and R9)
+ *   - Set the CA call pending field to 1
+ *   - Issue VMGEXIT
+ *   - Save the SVSM return register state (RAX, RCX, RDX, R8 and R9)
+ *   - Perform atomic exchange of the CA call pending field
+ *
+ *   - See the "Secure VM Service Module for SEV-SNP Guests" specification for
+ *     details on the calling convention.
+ *     - The calling convention loosely follows the Microsoft X64 calling
+ *       convention by putting arguments in RCX, RDX, R8 and R9.
+ *     - RAX specifies the SVSM protocol/callid as input and the return code
+ *       as output.
+ */
+static __always_inline void svsm_issue_call(struct svsm_call *call, u8 *pending)
+{
+	register unsigned long rax asm("rax") = call->rax;
+	register unsigned long rcx asm("rcx") = call->rcx;
+	register unsigned long rdx asm("rdx") = call->rdx;
+	register unsigned long r8  asm("r8")  = call->r8;
+	register unsigned long r9  asm("r9")  = call->r9;
+
+	call->caa->call_pending = 1;
+
+	asm volatile("rep; vmmcall\n\t"
+		     : "+r" (rax), "+r" (rcx), "+r" (rdx), "+r" (r8), "+r" (r9)
+		     : : "memory");
+
+	*pending = xchg(&call->caa->call_pending, *pending);
+
+	call->rax_out = rax;
+	call->rcx_out = rcx;
+	call->rdx_out = rdx;
+	call->r8_out  = r8;
+	call->r9_out  = r9;
+}
+
+static inline int svsm_process_result_codes(struct svsm_call *call)
+{
+	switch (call->rax_out) {
+	case SVSM_SUCCESS:
+		return 0;
+	case SVSM_ERR_INCOMPLETE:
+	case SVSM_ERR_BUSY:
+		return -EAGAIN;
+	default:
+		return -EINVAL;
+	}
+}
+
 void __noreturn sev_es_terminate(unsigned int set, unsigned int reason);
 enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
 				   struct es_em_ctxt *ctxt,
 				   u64 exit_code, u64 exit_info_1,
 				   u64 exit_info_2);
 
+bool sev_es_negotiate_protocol(void);
+bool sev_es_check_cpu_features(void);
+
+extern u16 ghcb_version;
 extern struct ghcb *boot_ghcb;
 
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
-- 
2.49.0.1045.g170613ef41-goog


