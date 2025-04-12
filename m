Return-Path: <linux-efi+bounces-3303-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B905A86DB8
	for <lists+linux-efi@lfdr.de>; Sat, 12 Apr 2025 16:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5F0A189DE5D
	for <lists+linux-efi@lfdr.de>; Sat, 12 Apr 2025 14:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C7C1EBFFF;
	Sat, 12 Apr 2025 14:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bHNKDPbX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T0gTcUKQ"
X-Original-To: linux-efi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC681DFED;
	Sat, 12 Apr 2025 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744468425; cv=none; b=LSg31UZEcXhEcw6on65wIckZCjfEYveeR9a39KneuK4fI4NIjo3N6m+uhcD5MD2yH72WCDHbPby9JoPABmvM8IbztkGh8+MwAT581e0YfnWY4rKPIO7K1Of6dKH5Z9CWWmEqw2OoVMVows1MqXNXgCisnCwQBg6qbn0ykFEllNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744468425; c=relaxed/simple;
	bh=ehy2ooeiOvRFJldsTYOMq4qE39SKheYTqIYDT8FM5Qs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=P4904PoeSVH9+bw1QQTDAoDiMGExok5hX1QNdEQWDjyVtxiYNT1PMxBnqujY7X3JOnfm9wAcm802MIeUBdXfe/96DxmOdTSAMC7RiuK+PJM/PE90K8W4lF5OlOWbRuaXTSQGQYsGnlDR4nSnPmBXOxY3WLO8adx7vwdSzkA/RAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bHNKDPbX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T0gTcUKQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 12 Apr 2025 14:33:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744468415;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0qYMl2FgX4KNrUXJNWA90KwMjcQLGwMx6/QmOw37B54=;
	b=bHNKDPbXh3eZICHoMr5lkIKCGDRNmp0ZOFwkgHSk4Vn6fN4pYTlKb9zYzDkZWux6FMVRX9
	mjBTsYI48Xol0zSjMI91R5rxJDJgqu/p3dUMumXNqg6jWn09WVrhmIBn2/pyoFUjKLz3n1
	rDcVdF3Q0csDbd5P1tonM7efSoUmnu/jizxkhg8vqRby+ox8FjM/LPj9yU+Cvs7pnfofql
	PqbWvXiPlt2sJoo0wbEF+7tWT9aKuiIz0c/JXPh8ktx0J+raZnjpkGuU/xCPkTnmdsKUDm
	HTpBzuRw53u+eWcJNJNfM9+BR/oW5nWe3H30Sh8EA0Ibv9e/Yblb6FVk/W1yXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744468415;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0qYMl2FgX4KNrUXJNWA90KwMjcQLGwMx6/QmOw37B54=;
	b=T0gTcUKQc3VTHnsw175Xti2T2YGB3j5b4r1EQoPrRo1S8jWg0SSC4W61x7XNRKHk0d3p2k
	CrfDESb74FUHYmDg==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/sev: Prepare for splitting off early SEV code
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Dionna Amalie Glaze <dionnaglaze@google.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>,
 Kevin Loughlin <kevinloughlin@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Tom Lendacky <thomas.lendacky@amd.com>, linux-efi@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250410134117.3713574-20-ardb+git@google.com>
References: <20250410134117.3713574-20-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174446840910.31282.4561336297241642732.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     221df25fdf827b1fe5b904c6a396af06461a32f6
Gitweb:        https://git.kernel.org/tip/221df25fdf827b1fe5b904c6a396af06461a32f6
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 10 Apr 2025 15:41:25 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 12 Apr 2025 11:13:05 +02:00

x86/sev: Prepare for splitting off early SEV code

Prepare for splitting off parts of the SEV core.c source file into a
file that carries code that must tolerate being called from the early
1:1 mapping. This will allow special build-time handling of thise code,
to ensure that it gets generated in a way that is compatible with the
early execution context.

So create a de-facto internal SEV API and put the definitions into
sev-internal.h. No attempt is made to allow this header file to be
included in arbitrary other sources - this is explicitly not the intent.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Kevin Loughlin <kevinloughlin@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-efi@vger.kernel.org
Link: https://lore.kernel.org/r/20250410134117.3713574-20-ardb+git@google.com
---
 arch/x86/boot/compressed/sev.c      |  15 ++-
 arch/x86/coco/sev/core.c            | 108 ++----------------------
 arch/x86/coco/sev/shared.c          |  64 ++------------
 arch/x86/include/asm/sev-internal.h | 122 +++++++++++++++++++++++++++-
 arch/x86/include/asm/sev.h          |  37 ++++++++-
 5 files changed, 194 insertions(+), 152 deletions(-)
 create mode 100644 arch/x86/include/asm/sev-internal.h

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index bb55934..6eadd79 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -126,20 +126,25 @@ static bool fault_in_kernel_space(unsigned long address)
 #include "../../lib/inat.c"
 #include "../../lib/insn.c"
 
-/* Include code for early handlers */
-#include "../../coco/sev/shared.c"
+extern struct svsm_ca *boot_svsm_caa;
+extern u64 boot_svsm_caa_pa;
 
-static struct svsm_ca *svsm_get_caa(void)
+struct svsm_ca *svsm_get_caa(void)
 {
 	return boot_svsm_caa;
 }
 
-static u64 svsm_get_caa_pa(void)
+u64 svsm_get_caa_pa(void)
 {
 	return boot_svsm_caa_pa;
 }
 
-static int svsm_perform_call_protocol(struct svsm_call *call)
+int svsm_perform_call_protocol(struct svsm_call *call);
+
+/* Include code for early handlers */
+#include "../../coco/sev/shared.c"
+
+int svsm_perform_call_protocol(struct svsm_call *call)
 {
 	struct ghcb *ghcb;
 	int ret;
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 832f7a7..aeb7731 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -31,6 +31,7 @@
 #include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
 #include <asm/sev.h>
+#include <asm/sev-internal.h>
 #include <asm/insn-eval.h>
 #include <asm/fpu/xcr.h>
 #include <asm/processor.h>
@@ -44,8 +45,6 @@
 #include <asm/cpuid.h>
 #include <asm/cmdline.h>
 
-#define DR7_RESET_VALUE        0x400
-
 /* AP INIT values as documented in the APM2  section "Processor Initialization State" */
 #define AP_INIT_CS_LIMIT		0xffff
 #define AP_INIT_DS_LIMIT		0xffff
@@ -82,16 +81,16 @@ static const char * const sev_status_feat_names[] = {
 };
 
 /* For early boot hypervisor communication in SEV-ES enabled guests */
-static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
+struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
 
 /*
  * Needs to be in the .data section because we need it NULL before bss is
  * cleared
  */
-static struct ghcb *boot_ghcb __section(".data");
+struct ghcb *boot_ghcb __section(".data");
 
 /* Bitmap of SEV features supported by the hypervisor */
-static u64 sev_hv_features __ro_after_init;
+u64 sev_hv_features __ro_after_init;
 
 /* Secrets page physical address from the CC blob */
 static u64 secrets_pa __ro_after_init;
@@ -105,54 +104,14 @@ static u64 snp_tsc_scale __ro_after_init;
 static u64 snp_tsc_offset __ro_after_init;
 static u64 snp_tsc_freq_khz __ro_after_init;
 
-/* #VC handler runtime per-CPU data */
-struct sev_es_runtime_data {
-	struct ghcb ghcb_page;
-
-	/*
-	 * Reserve one page per CPU as backup storage for the unencrypted GHCB.
-	 * It is needed when an NMI happens while the #VC handler uses the real
-	 * GHCB, and the NMI handler itself is causing another #VC exception. In
-	 * that case the GHCB content of the first handler needs to be backed up
-	 * and restored.
-	 */
-	struct ghcb backup_ghcb;
-
-	/*
-	 * Mark the per-cpu GHCBs as in-use to detect nested #VC exceptions.
-	 * There is no need for it to be atomic, because nothing is written to
-	 * the GHCB between the read and the write of ghcb_active. So it is safe
-	 * to use it when a nested #VC exception happens before the write.
-	 *
-	 * This is necessary for example in the #VC->NMI->#VC case when the NMI
-	 * happens while the first #VC handler uses the GHCB. When the NMI code
-	 * raises a second #VC handler it might overwrite the contents of the
-	 * GHCB written by the first handler. To avoid this the content of the
-	 * GHCB is saved and restored when the GHCB is detected to be in use
-	 * already.
-	 */
-	bool ghcb_active;
-	bool backup_ghcb_active;
-
-	/*
-	 * Cached DR7 value - write it on DR7 writes and return it on reads.
-	 * That value will never make it to the real hardware DR7 as debugging
-	 * is currently unsupported in SEV-ES guests.
-	 */
-	unsigned long dr7;
-};
-
-struct ghcb_state {
-	struct ghcb *ghcb;
-};
 
 /* For early boot SVSM communication */
-static struct svsm_ca boot_svsm_ca_page __aligned(PAGE_SIZE);
+struct svsm_ca boot_svsm_ca_page __aligned(PAGE_SIZE);
 
-static DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
-static DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
-static DEFINE_PER_CPU(struct svsm_ca *, svsm_caa);
-static DEFINE_PER_CPU(u64, svsm_caa_pa);
+DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
+DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
+DEFINE_PER_CPU(struct svsm_ca *, svsm_caa);
+DEFINE_PER_CPU(u64, svsm_caa_pa);
 
 static __always_inline bool on_vc_stack(struct pt_regs *regs)
 {
@@ -231,7 +190,7 @@ void noinstr __sev_es_ist_exit(void)
  *
  * Callers must disable local interrupts around it.
  */
-static noinstr struct ghcb *__sev_get_ghcb(struct ghcb_state *state)
+noinstr struct ghcb *__sev_get_ghcb(struct ghcb_state *state)
 {
 	struct sev_es_runtime_data *data;
 	struct ghcb *ghcb;
@@ -274,21 +233,6 @@ static noinstr struct ghcb *__sev_get_ghcb(struct ghcb_state *state)
 	return ghcb;
 }
 
-static inline u64 sev_es_rd_ghcb_msr(void)
-{
-	return __rdmsr(MSR_AMD64_SEV_ES_GHCB);
-}
-
-static __always_inline void sev_es_wr_ghcb_msr(u64 val)
-{
-	u32 low, high;
-
-	low  = (u32)(val);
-	high = (u32)(val >> 32);
-
-	native_wrmsr(MSR_AMD64_SEV_ES_GHCB, low, high);
-}
-
 static int vc_fetch_insn_kernel(struct es_em_ctxt *ctxt,
 				unsigned char *buffer)
 {
@@ -601,33 +545,7 @@ static __always_inline void vc_forward_exception(struct es_em_ctxt *ctxt)
 /* Include code shared with pre-decompression boot stage */
 #include "shared.c"
 
-static inline struct svsm_ca *svsm_get_caa(void)
-{
-	/*
-	 * Use rIP-relative references when called early in the boot. If
-	 * ->use_cas is set, then it is late in the boot and no need
-	 * to worry about rIP-relative references.
-	 */
-	if (RIP_REL_REF(sev_cfg).use_cas)
-		return this_cpu_read(svsm_caa);
-	else
-		return RIP_REL_REF(boot_svsm_caa);
-}
-
-static u64 svsm_get_caa_pa(void)
-{
-	/*
-	 * Use rIP-relative references when called early in the boot. If
-	 * ->use_cas is set, then it is late in the boot and no need
-	 * to worry about rIP-relative references.
-	 */
-	if (RIP_REL_REF(sev_cfg).use_cas)
-		return this_cpu_read(svsm_caa_pa);
-	else
-		return RIP_REL_REF(boot_svsm_caa_pa);
-}
-
-static noinstr void __sev_put_ghcb(struct ghcb_state *state)
+noinstr void __sev_put_ghcb(struct ghcb_state *state)
 {
 	struct sev_es_runtime_data *data;
 	struct ghcb *ghcb;
@@ -652,7 +570,7 @@ static noinstr void __sev_put_ghcb(struct ghcb_state *state)
 	}
 }
 
-static int svsm_perform_call_protocol(struct svsm_call *call)
+int svsm_perform_call_protocol(struct svsm_call *call)
 {
 	struct ghcb_state state;
 	unsigned long flags;
@@ -761,7 +679,7 @@ static u64 __init get_jump_table_addr(void)
 	return ret;
 }
 
-static void __head
+void __head
 early_set_pages_state(unsigned long vaddr, unsigned long paddr,
 		      unsigned long npages, enum psc_op op)
 {
diff --git a/arch/x86/coco/sev/shared.c b/arch/x86/coco/sev/shared.c
index 04982d3..a7c9402 100644
--- a/arch/x86/coco/sev/shared.c
+++ b/arch/x86/coco/sev/shared.c
@@ -38,12 +38,8 @@
  */
 u8 snp_vmpl __ro_after_init;
 EXPORT_SYMBOL_GPL(snp_vmpl);
-static struct svsm_ca *boot_svsm_caa __ro_after_init;
-static u64 boot_svsm_caa_pa __ro_after_init;
-
-static struct svsm_ca *svsm_get_caa(void);
-static u64 svsm_get_caa_pa(void);
-static int svsm_perform_call_protocol(struct svsm_call *call);
+struct svsm_ca *boot_svsm_caa __ro_after_init;
+u64 boot_svsm_caa_pa __ro_after_init;
 
 /* I/O parameters for CPUID-related helpers */
 struct cpuid_leaf {
@@ -56,36 +52,6 @@ struct cpuid_leaf {
 };
 
 /*
- * Individual entries of the SNP CPUID table, as defined by the SNP
- * Firmware ABI, Revision 0.9, Section 7.1, Table 14.
- */
-struct snp_cpuid_fn {
-	u32 eax_in;
-	u32 ecx_in;
-	u64 xcr0_in;
-	u64 xss_in;
-	u32 eax;
-	u32 ebx;
-	u32 ecx;
-	u32 edx;
-	u64 __reserved;
-} __packed;
-
-/*
- * SNP CPUID table, as defined by the SNP Firmware ABI, Revision 0.9,
- * Section 8.14.2.6. Also noted there is the SNP firmware-enforced limit
- * of 64 entries per CPUID table.
- */
-#define SNP_CPUID_COUNT_MAX 64
-
-struct snp_cpuid_table {
-	u32 count;
-	u32 __reserved1;
-	u64 __reserved2;
-	struct snp_cpuid_fn fn[SNP_CPUID_COUNT_MAX];
-} __packed;
-
-/*
  * Since feature negotiation related variables are set early in the boot
  * process they must reside in the .data section so as not to be zeroed
  * out when the .bss section is later cleared.
@@ -107,7 +73,7 @@ static u32 cpuid_std_range_max __ro_after_init;
 static u32 cpuid_hyp_range_max __ro_after_init;
 static u32 cpuid_ext_range_max __ro_after_init;
 
-static bool __init sev_es_check_cpu_features(void)
+bool __init sev_es_check_cpu_features(void)
 {
 	if (!has_cpuflag(X86_FEATURE_RDRAND)) {
 		error("RDRAND instruction not supported - no trusted source of randomness available\n");
@@ -117,7 +83,7 @@ static bool __init sev_es_check_cpu_features(void)
 	return true;
 }
 
-static void __head __noreturn
+void __head __noreturn
 sev_es_terminate(unsigned int set, unsigned int reason)
 {
 	u64 val = GHCB_MSR_TERM_REQ;
@@ -136,7 +102,7 @@ sev_es_terminate(unsigned int set, unsigned int reason)
 /*
  * The hypervisor features are available from GHCB version 2 onward.
  */
-static u64 get_hv_features(void)
+u64 get_hv_features(void)
 {
 	u64 val;
 
@@ -153,7 +119,7 @@ static u64 get_hv_features(void)
 	return GHCB_MSR_HV_FT_RESP_VAL(val);
 }
 
-static void snp_register_ghcb_early(unsigned long paddr)
+void snp_register_ghcb_early(unsigned long paddr)
 {
 	unsigned long pfn = paddr >> PAGE_SHIFT;
 	u64 val;
@@ -169,7 +135,7 @@ static void snp_register_ghcb_early(unsigned long paddr)
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_REGISTER);
 }
 
-static bool sev_es_negotiate_protocol(void)
+bool sev_es_negotiate_protocol(void)
 {
 	u64 val;
 
@@ -190,12 +156,6 @@ static bool sev_es_negotiate_protocol(void)
 	return true;
 }
 
-static __always_inline void vc_ghcb_invalidate(struct ghcb *ghcb)
-{
-	ghcb->save.sw_exit_code = 0;
-	__builtin_memset(ghcb->save.valid_bitmap, 0, sizeof(ghcb->save.valid_bitmap));
-}
-
 static bool vc_decoding_needed(unsigned long exit_code)
 {
 	/* Exceptions don't require to decode the instruction */
@@ -371,10 +331,10 @@ static int svsm_perform_ghcb_protocol(struct ghcb *ghcb, struct svsm_call *call)
 	return svsm_process_result_codes(call);
 }
 
-static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
-					  struct es_em_ctxt *ctxt,
-					  u64 exit_code, u64 exit_info_1,
-					  u64 exit_info_2)
+enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
+				   struct es_em_ctxt *ctxt,
+				   u64 exit_code, u64 exit_info_1,
+				   u64 exit_info_2)
 {
 	/* Fill in protocol and format specifiers */
 	ghcb->protocol_version = ghcb_version;
@@ -473,7 +433,7 @@ static int sev_cpuid_hv(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid
  * while running with the initial identity mapping as well as the
  * switch-over to kernel virtual addresses later.
  */
-static const struct snp_cpuid_table *snp_cpuid_get_table(void)
+const struct snp_cpuid_table *snp_cpuid_get_table(void)
 {
 	return rip_rel_ptr(&cpuid_table_copy);
 }
diff --git a/arch/x86/include/asm/sev-internal.h b/arch/x86/include/asm/sev-internal.h
new file mode 100644
index 0000000..73cb774
--- /dev/null
+++ b/arch/x86/include/asm/sev-internal.h
@@ -0,0 +1,122 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#define DR7_RESET_VALUE        0x400
+
+extern struct ghcb boot_ghcb_page;
+extern struct ghcb *boot_ghcb;
+extern u64 sev_hv_features;
+
+/* #VC handler runtime per-CPU data */
+struct sev_es_runtime_data {
+	struct ghcb ghcb_page;
+
+	/*
+	 * Reserve one page per CPU as backup storage for the unencrypted GHCB.
+	 * It is needed when an NMI happens while the #VC handler uses the real
+	 * GHCB, and the NMI handler itself is causing another #VC exception. In
+	 * that case the GHCB content of the first handler needs to be backed up
+	 * and restored.
+	 */
+	struct ghcb backup_ghcb;
+
+	/*
+	 * Mark the per-cpu GHCBs as in-use to detect nested #VC exceptions.
+	 * There is no need for it to be atomic, because nothing is written to
+	 * the GHCB between the read and the write of ghcb_active. So it is safe
+	 * to use it when a nested #VC exception happens before the write.
+	 *
+	 * This is necessary for example in the #VC->NMI->#VC case when the NMI
+	 * happens while the first #VC handler uses the GHCB. When the NMI code
+	 * raises a second #VC handler it might overwrite the contents of the
+	 * GHCB written by the first handler. To avoid this the content of the
+	 * GHCB is saved and restored when the GHCB is detected to be in use
+	 * already.
+	 */
+	bool ghcb_active;
+	bool backup_ghcb_active;
+
+	/*
+	 * Cached DR7 value - write it on DR7 writes and return it on reads.
+	 * That value will never make it to the real hardware DR7 as debugging
+	 * is currently unsupported in SEV-ES guests.
+	 */
+	unsigned long dr7;
+};
+
+struct ghcb_state {
+	struct ghcb *ghcb;
+};
+
+extern struct svsm_ca boot_svsm_ca_page;
+
+struct ghcb *__sev_get_ghcb(struct ghcb_state *state);
+void __sev_put_ghcb(struct ghcb_state *state);
+
+DECLARE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
+DECLARE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
+
+void early_set_pages_state(unsigned long vaddr, unsigned long paddr,
+			   unsigned long npages, enum psc_op op);
+
+void __noreturn sev_es_terminate(unsigned int set, unsigned int reason);
+
+DECLARE_PER_CPU(struct svsm_ca *, svsm_caa);
+DECLARE_PER_CPU(u64, svsm_caa_pa);
+
+extern struct svsm_ca *boot_svsm_caa;
+extern u64 boot_svsm_caa_pa;
+
+static __always_inline struct svsm_ca *svsm_get_caa(void)
+{
+	/*
+	 * Use rIP-relative references when called early in the boot. If
+	 * ->use_cas is set, then it is late in the boot and no need
+	 * to worry about rIP-relative references.
+	 */
+	if (RIP_REL_REF(sev_cfg).use_cas)
+		return this_cpu_read(svsm_caa);
+	else
+		return RIP_REL_REF(boot_svsm_caa);
+}
+
+static __always_inline u64 svsm_get_caa_pa(void)
+{
+	/*
+	 * Use rIP-relative references when called early in the boot. If
+	 * ->use_cas is set, then it is late in the boot and no need
+	 * to worry about rIP-relative references.
+	 */
+	if (RIP_REL_REF(sev_cfg).use_cas)
+		return this_cpu_read(svsm_caa_pa);
+	else
+		return RIP_REL_REF(boot_svsm_caa_pa);
+}
+
+int svsm_perform_call_protocol(struct svsm_call *call);
+
+static inline u64 sev_es_rd_ghcb_msr(void)
+{
+	return __rdmsr(MSR_AMD64_SEV_ES_GHCB);
+}
+
+static __always_inline void sev_es_wr_ghcb_msr(u64 val)
+{
+	u32 low, high;
+
+	low  = (u32)(val);
+	high = (u32)(val >> 32);
+
+	native_wrmsr(MSR_AMD64_SEV_ES_GHCB, low, high);
+}
+
+enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
+				   struct es_em_ctxt *ctxt,
+				   u64 exit_code, u64 exit_info_1,
+				   u64 exit_info_2);
+
+void snp_register_ghcb_early(unsigned long paddr);
+bool sev_es_negotiate_protocol(void);
+bool sev_es_check_cpu_features(void);
+u64 get_hv_features(void);
+
+const struct snp_cpuid_table *snp_cpuid_get_table(void);
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index ba7999f..a8661df 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -15,6 +15,7 @@
 #include <asm/sev-common.h>
 #include <asm/coco.h>
 #include <asm/set_memory.h>
+#include <asm/svm.h>
 
 #define GHCB_PROTOCOL_MIN	1ULL
 #define GHCB_PROTOCOL_MAX	2ULL
@@ -83,6 +84,36 @@ extern void vc_no_ghcb(void);
 extern void vc_boot_ghcb(void);
 extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
 
+/*
+ * Individual entries of the SNP CPUID table, as defined by the SNP
+ * Firmware ABI, Revision 0.9, Section 7.1, Table 14.
+ */
+struct snp_cpuid_fn {
+	u32 eax_in;
+	u32 ecx_in;
+	u64 xcr0_in;
+	u64 xss_in;
+	u32 eax;
+	u32 ebx;
+	u32 ecx;
+	u32 edx;
+	u64 __reserved;
+} __packed;
+
+/*
+ * SNP CPUID table, as defined by the SNP Firmware ABI, Revision 0.9,
+ * Section 8.14.2.6. Also noted there is the SNP firmware-enforced limit
+ * of 64 entries per CPUID table.
+ */
+#define SNP_CPUID_COUNT_MAX 64
+
+struct snp_cpuid_table {
+	u32 count;
+	u32 __reserved1;
+	u64 __reserved2;
+	struct snp_cpuid_fn fn[SNP_CPUID_COUNT_MAX];
+} __packed;
+
 /* PVALIDATE return codes */
 #define PVALIDATE_FAIL_SIZEMISMATCH	6
 
@@ -484,6 +515,12 @@ int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req
 void __init snp_secure_tsc_prepare(void);
 void __init snp_secure_tsc_init(void);
 
+static __always_inline void vc_ghcb_invalidate(struct ghcb *ghcb)
+{
+	ghcb->save.sw_exit_code = 0;
+	__builtin_memset(ghcb->save.valid_bitmap, 0, sizeof(ghcb->save.valid_bitmap));
+}
+
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
 
 #define snp_vmpl 0

