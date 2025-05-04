Return-Path: <linux-efi+bounces-3560-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C13B8AA85AB
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 11:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72AE818985AC
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 09:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C6B1C84BE;
	Sun,  4 May 2025 09:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sqHFUAWg"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF741B423D
	for <linux-efi@vger.kernel.org>; Sun,  4 May 2025 09:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746352406; cv=none; b=lwllhwt403povgvqYWM2THgdtzeDJIRJliyaCp8eVsk/cTElTRXfgnCGr+HCWPuvGmm9tGm7dvcBPWXeM5ojmeW+3UicQo++XG7sIcx5CQFQM+M912k/91JgszLa5LWL8tXBtLYT9TwHH/QeiUZyjrnw72N1qFoOWsdyG3NKwl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746352406; c=relaxed/simple;
	bh=y89axQVBWipouQHDSui3OGxlzl+xhdZc/Zk8JNOfNdM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cNsx/7Kj3VhMLWvTCGyy2yQW0LveBMuP3jZ2Alm9nnKuEc9pQL7HB/2+8KZuBejUsIhVrH4kzUieDWt9L+kerl3x+7JOyIV/pJsmIiW9pnQzucrMmYWFYgHURAXdfTULJTssQq8f20TGh8tIVpvMNbwtOjA4SMMfzFOGR5WnhSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sqHFUAWg; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43cf3168b87so14045635e9.2
        for <linux-efi@vger.kernel.org>; Sun, 04 May 2025 02:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746352403; x=1746957203; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z1QH716ojaXjFcqqp07sVPR7HrgO2wCXBEAvpYPhtoI=;
        b=sqHFUAWg3qHBIt9CIBqYcFpBVNLC7c4OnrpmxNe6UMQTE6XWqI9AKw+QYiakZBD6nh
         EBddY29/p89sqcJ53gZg0OJAoyQa9RziRH79T/Go70f8pWV3SuzFFMjNLGKoYxOjkDXe
         Y9gOAgrPF3SgDdF/Mpo8CWu6cyCarQKfjAmN3bjcS8yFIg+9jlIaUgVWPv2c/+9JntNs
         zDCa5fTwP4XqPQSNPrn7jmM94TWt6bWz14raLg7L6bAwTVHNROFQQ5Z1/dnG0WFCL8JL
         2J8A7j36sUtmXVAbNMGXbbEjoUbOprWaWbc96tNOlSGp6GoKAbGanY8+VEKWZnXDSbw6
         XUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746352403; x=1746957203;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z1QH716ojaXjFcqqp07sVPR7HrgO2wCXBEAvpYPhtoI=;
        b=tMDnhguw9QRCoqugebc8iroOQBJ9N1vv+IJOZCgyM2rzX5UCanHI941x+IHw55XAz6
         OvXq2CmxbV8fZ2+xPe14oBewKkPxGF1q4T0rWZl9Oee37clRTNRwV21ybIBj2FpaeoFy
         +9FkEyr4ZcQxLgE8MmVOnTX9DyphD/OTmHugDItScV8UwhYRZfz1oeB4/HowpR/xV9ms
         ESVeKZiC2aWbgtCzWPM3CPCtMgsLMMJ+DfvIX13JNBeFkVOKpMcRHmB+Kz0LkISgWHUH
         B6CIi8ossFSoYHsCTX3/6ROWXz6hC3j4CSExnyLoBaZFiC9oahtD9Bt2DWqQtqIt1W0J
         JG7w==
X-Gm-Message-State: AOJu0YxExaAus3JFBbp/UzYcQyVEbCUF+SJm7QoHoqL7m6JcIClILd7W
	FDtsAMaVjuRdlK8mP/N1iYgHCMPmVzlx/HTof2Oq7iCNBIOvZfX4Th0o94nphhiWBWeLaw==
X-Google-Smtp-Source: AGHT+IHiGEF2ESmBkDldONt9tAIuqdZIas0i+OaCNwgRPOhI5Ltffdmqvhw/PGG0XlGutukjhLU6tHYy
X-Received: from wmbes9.prod.google.com ([2002:a05:600c:8109:b0:43b:d523:6ad8])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3507:b0:43c:f8fc:f687
 with SMTP id 5b1f17b1804b1-441bbf3bd94mr57367955e9.27.1746352402830; Sun, 04
 May 2025 02:53:22 -0700 (PDT)
Date: Sun,  4 May 2025 11:52:39 +0200
In-Reply-To: <20250504095230.2932860-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250504095230.2932860-25-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=18216; i=ardb@kernel.org;
 h=from:subject; bh=t8Vlwi5e8jQExbTgowtVYDZST8xqzSWPWGIcCPnvdy0=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPc4lUdO3NU5NebL/42ze51msFQ3et+p+P073NXLKUNp
 MvC50/rKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABP5tZuRYU3yYqaq2ZYi5yWd
 UvP3Wqxp416eYn/0+Ir29NCYh0ceszAyNG9+Yx685RpnUvep/Xmztq1h68jdUsYTqfpunouRYMV ZJgA=
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250504095230.2932860-34-ardb+git@google.com>
Subject: [RFT PATCH v2 09/23] x86/sev: Move GHCB page based HV communication
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
configured a bit later. The SVSM PVALIDATE code can use either
interface, but will prefer the GHCB page based one once available.

Accessing this shared GHCB page from the core kernel's startup code is
problematic, because it involves converting the GHCB address provided by
the caller to a physical address. In the startup code, which may execute
from a 1:1 mapping of memory, virtual to physical address translations
are therefore ambiguous, and should be avoided.

This means that exposing startup code dealing with the GHCB to callers
that execute from the ordinary kernel virtual mapping should be avoided
too. So move all GHCB page based communication out of the startup code,
and rely on the MSR protocol only for all communication occurring before
the kernel virtual mapping is up, as well as all SVSM PVALIDATE calls
made via the 'early' page state change API (which may be called a bit
later as well)

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/sev.c      |  20 ---
 arch/x86/boot/startup/sev-shared.c  | 160 +-------------------
 arch/x86/boot/startup/sev-startup.c |  35 +----
 arch/x86/coco/sev/core.c            |  67 ++++++++
 arch/x86/coco/sev/vc-shared.c       |  63 ++++++++
 arch/x86/include/asm/sev-internal.h |   4 +-
 arch/x86/include/asm/sev.h          |  56 ++++++-
 7 files changed, 190 insertions(+), 215 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 804166457022..9b6eebc24e78 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -50,31 +50,11 @@ u64 svsm_get_caa_pa(void)
 	return boot_svsm_caa_pa;
 }
 
-int svsm_perform_call_protocol(struct svsm_call *call);
-
 u8 snp_vmpl;
 
 /* Include code for early handlers */
 #include "../../boot/startup/sev-shared.c"
 
-int svsm_perform_call_protocol(struct svsm_call *call)
-{
-	struct ghcb *ghcb;
-	int ret;
-
-	if (boot_ghcb)
-		ghcb = boot_ghcb;
-	else
-		ghcb = NULL;
-
-	do {
-		ret = ghcb ? svsm_perform_ghcb_protocol(ghcb, call)
-			   : svsm_perform_msr_protocol(call);
-	} while (ret == -EAGAIN);
-
-	return ret;
-}
-
 static bool sev_snp_enabled(void)
 {
 	return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index 408e064a80d9..0709c8a8655a 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -17,8 +17,6 @@
 #else
 #undef WARN
 #define WARN(condition, format...) (!!(condition))
-#undef vc_forward_exception
-#define vc_forward_exception(c)		panic("SNP: Hypervisor requested exception\n")
 #endif
 
 /*
@@ -39,7 +37,7 @@ u64 boot_svsm_caa_pa __ro_after_init;
  *
  * GHCB protocol version negotiated with the hypervisor.
  */
-static u16 ghcb_version __ro_after_init;
+u16 ghcb_version __ro_after_init;
 
 /* Copy of the SNP firmware's CPUID page. */
 static struct snp_cpuid_table cpuid_table_copy __ro_after_init;
@@ -100,22 +98,6 @@ u64 get_hv_features(void)
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
 bool sev_es_negotiate_protocol(void)
 {
 	u64 val;
@@ -137,86 +119,7 @@ bool sev_es_negotiate_protocol(void)
 	return true;
 }
 
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
@@ -247,63 +150,6 @@ static int svsm_perform_msr_protocol(struct svsm_call *call)
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
@@ -755,7 +601,7 @@ static void __head svsm_pval_4k_page(unsigned long paddr, bool validate)
 	call.rax = SVSM_CORE_CALL(SVSM_CORE_PVALIDATE);
 	call.rcx = pc_pa;
 
-	ret = svsm_perform_call_protocol(&call);
+	ret = svsm_perform_msr_protocol(&call);
 	if (ret)
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
 
diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index 435853a55768..797ca3e29b12 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -139,39 +139,6 @@ noinstr void __sev_put_ghcb(struct ghcb_state *state)
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
@@ -325,7 +292,7 @@ static __head void svsm_setup(struct cc_blob_sev_info *cc_info)
 	call.caa = svsm_get_caa();
 	call.rax = SVSM_CORE_CALL(SVSM_CORE_REMAP_CA);
 	call.rcx = pa;
-	ret = svsm_perform_call_protocol(&call);
+	ret = svsm_perform_msr_protocol(&call);
 	if (ret)
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_CA_REMAP_FAIL);
 
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index fd5cd7d9b5f2..883b2719986d 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -153,6 +153,73 @@ static u64 __init get_jump_table_addr(void)
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
diff --git a/arch/x86/coco/sev/vc-shared.c b/arch/x86/coco/sev/vc-shared.c
index b4688f69102e..6df758560803 100644
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
@@ -549,3 +596,19 @@ static enum es_result vc_handle_rdtsc(struct ghcb *ghcb,
 
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
diff --git a/arch/x86/include/asm/sev-internal.h b/arch/x86/include/asm/sev-internal.h
index b7232081f8f7..0d02e780beb3 100644
--- a/arch/x86/include/asm/sev-internal.h
+++ b/arch/x86/include/asm/sev-internal.h
@@ -80,7 +80,8 @@ static __always_inline u64 svsm_get_caa_pa(void)
 		return boot_svsm_caa_pa;
 }
 
-int svsm_perform_call_protocol(struct svsm_call *call);
+enum es_result verify_exception_info(struct ghcb *ghcb, struct es_em_ctxt *ctxt);
+void vc_forward_exception(struct es_em_ctxt *ctxt);
 
 static inline u64 sev_es_rd_ghcb_msr(void)
 {
@@ -97,7 +98,6 @@ static __always_inline void sev_es_wr_ghcb_msr(u64 val)
 	native_wrmsr(MSR_AMD64_SEV_ES_GHCB, low, high);
 }
 
-void snp_register_ghcb_early(unsigned long paddr);
 bool sev_es_negotiate_protocol(void);
 bool sev_es_check_cpu_features(void);
 u64 get_hv_features(void);
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index f50a606be4f1..ca7168cc2118 100644
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
@@ -533,15 +532,68 @@ struct cpuid_leaf {
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
 
+extern u16 ghcb_version;
 extern struct ghcb *boot_ghcb;
 
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
-- 
2.49.0.906.g1f30a19c02-goog


