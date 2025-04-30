Return-Path: <linux-efi+bounces-3502-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE2AAA49DD
	for <lists+linux-efi@lfdr.de>; Wed, 30 Apr 2025 13:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 926287B67EC
	for <lists+linux-efi@lfdr.de>; Wed, 30 Apr 2025 11:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBB325A624;
	Wed, 30 Apr 2025 11:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A5/hdivw"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B9823504D;
	Wed, 30 Apr 2025 11:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746012410; cv=none; b=MUfWdzfkR6/WGmP7yvZ87XIJt/vALm9gPsPKzkrO5KQZJMU5RO/uyQz0ymxVBUcfqo167qa7oY+iCQMl0vGjk5c2NT7/oPaHXdR4TSZ1F6SSQ9xTqYQ6NZNzWjpiTSed9Dv6KtKSKxogGoXwzn9gYfCeVmkzdbJTkkLbxlZ+jCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746012410; c=relaxed/simple;
	bh=lhKu5HOtgpbAFGXcKElUshSTx+uTc3VFG2oXFOKFPUY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=XsIcl1ZZca4WEo6BldNUAH5lK2uA5k3oHgzSejJXghsxckxi8ykSkFjaJ5TfpK4xOEM7Lh5dxqX8glX8c9ZRzDa9Ohr0PSUHyRI2t/8ZjsAeFSb3eyNE6KzhOM1wvWK8OAGcOfrSeayo1ZKYZTf7FKQiHG7Miv1vimEDp7stv28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A5/hdivw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=lUblvaO4TRbJSr6U7JLwwiOE6m5EUlv1vlS2etHnYj8=; b=A5/hdivwlOFACTQ/rzqCIm1RAT
	Z2lOPf0WBqQP5gqXThHZF/j9J13ICCvaMhMI3L8HbeLT1B+/cDzvSvZ/4+Sbu2bqcfFdWiU2Joet8
	8GgCBaOq5sQ9rVCo2jodL0ZKmt6WhARzfhSIW2Y/zNbvcsfsyl+k4X+Z4VpvdCIZqKoCrrptz9Nsv
	iR3R0IQjbxprPgM7Tt7dOMQlY9J5EB4BKFV/Mmp/euE4EjIsjvQS66OaIfGQB8LX2+Fzu4JQdpmtQ
	fLDSXGol/scWVq7T9RoFF+vbxKs+TmYUMYbOtYuhQww7xJyILb3ggIP4BtTm/0kUonsuA3iqXtrIV
	S2C5qOmA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uA5aH-0000000C6a8-07jm;
	Wed, 30 Apr 2025 11:26:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id F057530813A; Wed, 30 Apr 2025 13:26:35 +0200 (CEST)
Message-ID: <20250430112350.225006522@infradead.org>
User-Agent: quilt/0.66
Date: Wed, 30 Apr 2025 13:07:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: kys@microsoft.com,
 haiyangz@microsoft.com,
 wei.liu@kernel.org,
 decui@microsoft.com,
 tglx@linutronix.de,
 mingo@redhat.com,
 bp@alien8.de,
 dave.hansen@linux.intel.com,
 hpa@zytor.com,
 seanjc@google.com,
 pbonzini@redhat.com,
 ardb@kernel.org,
 kees@kernel.org,
 Arnd Bergmann <arnd@arndb.de>,
 gregkh@linuxfoundation.org,
 jpoimboe@kernel.org,
 peterz@infradead.org,
 linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org,
 linux-efi@vger.kernel.org,
 samitolvanen@google.com,
 ojeda@kernel.org
Subject: [PATCH v2 11/13] x86,hyperv: Clean up hv_do_hypercall()
References: <20250430110734.392235199@infradead.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

What used to be a simple few instructions has turned into a giant mess
(for x86_64). Not only does it use static_branch wrong, it mixes it
with dynamic branches for no apparent reason.

Notably it uses static_branch through an out-of-line function call,
which completely defeats the purpose, since instead of a simple
JMP/NOP site, you get a CALL+RET+TEST+Jcc sequence in return, which is
absolutely idiotic.

Add to that a dynamic test of hyperv_paravisor_present, something
which is set once and never changed.

Replace all this idiocy with a single direct function call to the
right hypercall variant.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/hyperv/hv_init.c       |   20 +++++
 arch/x86/hyperv/ivm.c           |   15 ++++
 arch/x86/include/asm/mshyperv.h |  137 +++++++++++-----------------------------
 arch/x86/kernel/cpu/mshyperv.c  |   19 +++--
 4 files changed, 89 insertions(+), 102 deletions(-)

--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -35,7 +35,27 @@
 #include <linux/highmem.h>
 
 void *hv_hypercall_pg;
+
+#ifdef CONFIG_X86_64
+u64 hv_std_hypercall(u64 control, u64 param1, u64 param2)
+{
+	u64 hv_status;
+
+	if (!hv_hypercall_pg)
+		return U64_MAX;
+
+	register u64 __r8 asm("r8") = param2;
+	asm volatile (CALL_NOSPEC
+		      : "=a" (hv_status), ASM_CALL_CONSTRAINT,
+		        "+c" (control), "+d" (param1), "+r" (__r8)
+		      : THUNK_TARGET(hv_hypercall_pg)
+		      : "cc", "memory", "r9", "r10", "r11");
+
+	return hv_status;
+}
+#else
 EXPORT_SYMBOL_GPL(hv_hypercall_pg);
+#endif
 
 union hv_ghcb * __percpu *hv_ghcb_pg;
 
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -376,9 +376,23 @@ int hv_snp_boot_ap(u32 cpu, unsigned lon
 	return ret;
 }
 
+u64 hv_snp_hypercall(u64 control, u64 param1, u64 param2)
+{
+	u64 hv_status;
+
+	register u64 __r8 asm("r8") = param2;
+	asm volatile("vmmcall"
+		     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
+		       "+c" (control), "+d" (param1), "+r" (__r8)
+		     : : "cc", "memory", "r9", "r10", "r11");
+
+	return hv_status;
+}
+
 #else
 static inline void hv_ghcb_msr_write(u64 msr, u64 value) {}
 static inline void hv_ghcb_msr_read(u64 msr, u64 *value) {}
+u64 hv_snp_hypercall(u64 control, u64 param1, u64 param2) { return U64_MAX; }
 #endif /* CONFIG_AMD_MEM_ENCRYPT */
 
 #ifdef CONFIG_INTEL_TDX_GUEST
@@ -428,6 +442,7 @@ u64 hv_tdx_hypercall(u64 control, u64 pa
 #else
 static inline void hv_tdx_msr_write(u64 msr, u64 value) {}
 static inline void hv_tdx_msr_read(u64 msr, u64 *value) {}
+u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2) { return U64_MAX; }
 #endif /* CONFIG_INTEL_TDX_GUEST */
 
 #if defined(CONFIG_AMD_MEM_ENCRYPT) || defined(CONFIG_INTEL_TDX_GUEST)
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -6,6 +6,7 @@
 #include <linux/nmi.h>
 #include <linux/msi.h>
 #include <linux/io.h>
+#include <linux/static_call.h>
 #include <asm/nospec-branch.h>
 #include <asm/paravirt.h>
 #include <hyperv/hvhdk.h>
@@ -38,16 +39,21 @@ static inline unsigned char hv_get_nmi_r
 	return 0;
 }
 
-#if IS_ENABLED(CONFIG_HYPERV)
-extern bool hyperv_paravisor_present;
+extern u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
+extern u64 hv_snp_hypercall(u64 control, u64 param1, u64 param2);
+extern u64 hv_std_hypercall(u64 control, u64 param1, u64 param2);
 
+#if IS_ENABLED(CONFIG_HYPERV)
 extern void *hv_hypercall_pg;
 
 extern union hv_ghcb * __percpu *hv_ghcb_pg;
 
 bool hv_isolation_type_snp(void);
 bool hv_isolation_type_tdx(void);
-u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
+
+#ifdef CONFIG_X86_64
+DECLARE_STATIC_CALL(hv_hypercall, hv_std_hypercall);
+#endif
 
 /*
  * DEFAULT INIT GPAT and SEGMENT LIMIT value in struct VMSA
@@ -64,37 +70,15 @@ static inline u64 hv_do_hypercall(u64 co
 {
 	u64 input_address = input ? virt_to_phys(input) : 0;
 	u64 output_address = output ? virt_to_phys(output) : 0;
-	u64 hv_status;
 
 #ifdef CONFIG_X86_64
-	if (hv_isolation_type_tdx() && !hyperv_paravisor_present)
-		return hv_tdx_hypercall(control, input_address, output_address);
-
-	if (hv_isolation_type_snp() && !hyperv_paravisor_present) {
-		__asm__ __volatile__("mov %[output_address], %%r8\n"
-				     "vmmcall"
-				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
-				       "+c" (control), "+d" (input_address)
-				     : [output_address] "r" (output_address)
-				     : "cc", "memory", "r8", "r9", "r10", "r11");
-		return hv_status;
-	}
-
-	if (!hv_hypercall_pg)
-		return U64_MAX;
-
-	__asm__ __volatile__("mov %[output_address], %%r8\n"
-			     CALL_NOSPEC
-			     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
-			       "+c" (control), "+d" (input_address)
-			     : [output_address] "r" (output_address),
-			       THUNK_TARGET(hv_hypercall_pg)
-			     : "cc", "memory", "r8", "r9", "r10", "r11");
+	return static_call_mod(hv_hypercall)(control, input_address, output_address);
 #else
 	u32 input_address_hi = upper_32_bits(input_address);
 	u32 input_address_lo = lower_32_bits(input_address);
 	u32 output_address_hi = upper_32_bits(output_address);
 	u32 output_address_lo = lower_32_bits(output_address);
+	u64 hv_status;
 
 	if (!hv_hypercall_pg)
 		return U64_MAX;
@@ -107,8 +91,8 @@ static inline u64 hv_do_hypercall(u64 co
 			       "D"(output_address_hi), "S"(output_address_lo),
 			       THUNK_TARGET(hv_hypercall_pg)
 			     : "cc", "memory");
-#endif /* !x86_64 */
 	return hv_status;
+#endif /* !x86_64 */
 }
 
 /* Hypercall to the L0 hypervisor */
@@ -120,41 +104,23 @@ static inline u64 hv_do_nested_hypercall
 /* Fast hypercall with 8 bytes of input and no output */
 static inline u64 _hv_do_fast_hypercall8(u64 control, u64 input1)
 {
-	u64 hv_status;
-
 #ifdef CONFIG_X86_64
-	if (hv_isolation_type_tdx() && !hyperv_paravisor_present)
-		return hv_tdx_hypercall(control, input1, 0);
-
-	if (hv_isolation_type_snp() && !hyperv_paravisor_present) {
-		__asm__ __volatile__(
-				"vmmcall"
-				: "=a" (hv_status), ASM_CALL_CONSTRAINT,
-				"+c" (control), "+d" (input1)
-				:: "cc", "r8", "r9", "r10", "r11");
-	} else {
-		__asm__ __volatile__(CALL_NOSPEC
-				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
-				       "+c" (control), "+d" (input1)
-				     : THUNK_TARGET(hv_hypercall_pg)
-				     : "cc", "r8", "r9", "r10", "r11");
-	}
+	return static_call_mod(hv_hypercall)(control, input1, 0);
 #else
-	{
-		u32 input1_hi = upper_32_bits(input1);
-		u32 input1_lo = lower_32_bits(input1);
-
-		__asm__ __volatile__ (CALL_NOSPEC
-				      : "=A"(hv_status),
-					"+c"(input1_lo),
-					ASM_CALL_CONSTRAINT
-				      :	"A" (control),
-					"b" (input1_hi),
-					THUNK_TARGET(hv_hypercall_pg)
-				      : "cc", "edi", "esi");
-	}
-#endif
+	u32 input1_hi = upper_32_bits(input1);
+	u32 input1_lo = lower_32_bits(input1);
+	u64 hv_status;
+
+	__asm__ __volatile__ (CALL_NOSPEC
+			      : "=A"(hv_status),
+			      "+c"(input1_lo),
+			      ASM_CALL_CONSTRAINT
+			      :	"A" (control),
+			      "b" (input1_hi),
+			      THUNK_TARGET(hv_hypercall_pg)
+			      : "cc", "edi", "esi");
 	return hv_status;
+#endif
 }
 
 static inline u64 hv_do_fast_hypercall8(u16 code, u64 input1)
@@ -174,45 +140,24 @@ static inline u64 hv_do_fast_nested_hype
 /* Fast hypercall with 16 bytes of input */
 static inline u64 _hv_do_fast_hypercall16(u64 control, u64 input1, u64 input2)
 {
-	u64 hv_status;
-
 #ifdef CONFIG_X86_64
-	if (hv_isolation_type_tdx() && !hyperv_paravisor_present)
-		return hv_tdx_hypercall(control, input1, input2);
-
-	if (hv_isolation_type_snp() && !hyperv_paravisor_present) {
-		__asm__ __volatile__("mov %[input2], %%r8\n"
-				     "vmmcall"
-				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
-				       "+c" (control), "+d" (input1)
-				     : [input2] "r" (input2)
-				     : "cc", "r8", "r9", "r10", "r11");
-	} else {
-		__asm__ __volatile__("mov %[input2], %%r8\n"
-				     CALL_NOSPEC
-				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
-				       "+c" (control), "+d" (input1)
-				     : [input2] "r" (input2),
-				       THUNK_TARGET(hv_hypercall_pg)
-				     : "cc", "r8", "r9", "r10", "r11");
-	}
+	return static_call_mod(hv_hypercall)(control, input1, input2);
 #else
-	{
-		u32 input1_hi = upper_32_bits(input1);
-		u32 input1_lo = lower_32_bits(input1);
-		u32 input2_hi = upper_32_bits(input2);
-		u32 input2_lo = lower_32_bits(input2);
-
-		__asm__ __volatile__ (CALL_NOSPEC
-				      : "=A"(hv_status),
-					"+c"(input1_lo), ASM_CALL_CONSTRAINT
-				      :	"A" (control), "b" (input1_hi),
-					"D"(input2_hi), "S"(input2_lo),
-					THUNK_TARGET(hv_hypercall_pg)
-				      : "cc");
-	}
-#endif
+	u32 input1_hi = upper_32_bits(input1);
+	u32 input1_lo = lower_32_bits(input1);
+	u32 input2_hi = upper_32_bits(input2);
+	u32 input2_lo = lower_32_bits(input2);
+	u64 hv_status;
+
+	__asm__ __volatile__ (CALL_NOSPEC
+			      : "=A"(hv_status),
+			      "+c"(input1_lo), ASM_CALL_CONSTRAINT
+			      :	"A" (control), "b" (input1_hi),
+			      "D"(input2_hi), "S"(input2_lo),
+			      THUNK_TARGET(hv_hypercall_pg)
+			      : "cc");
 	return hv_status;
+#endif
 }
 
 static inline u64 hv_do_fast_hypercall16(u16 code, u64 input1, u64 input2)
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -37,10 +37,6 @@
 bool hv_nested;
 struct ms_hyperv_info ms_hyperv;
 
-/* Used in modules via hv_do_hypercall(): see arch/x86/include/asm/mshyperv.h */
-bool hyperv_paravisor_present __ro_after_init;
-EXPORT_SYMBOL_GPL(hyperv_paravisor_present);
-
 #if IS_ENABLED(CONFIG_HYPERV)
 static inline unsigned int hv_get_nested_msr(unsigned int reg)
 {
@@ -287,8 +283,18 @@ static void __init x86_setup_ops_for_tsc
 	old_restore_sched_clock_state = x86_platform.restore_sched_clock_state;
 	x86_platform.restore_sched_clock_state = hv_restore_sched_clock_state;
 }
+
+#ifdef CONFIG_X86_64
+DEFINE_STATIC_CALL(hv_hypercall, hv_std_hypercall);
+EXPORT_STATIC_CALL_TRAMP_GPL(hv_hypercall);
+#define hypercall_update(hc) static_call_update(hv_hypercall, hc)
+#endif
 #endif /* CONFIG_HYPERV */
 
+#ifndef hypercall_update
+#define hypercall_update(hc) (void)hc
+#endif
+
 static uint32_t  __init ms_hyperv_platform(void)
 {
 	u32 eax;
@@ -483,14 +489,14 @@ static void __init ms_hyperv_init_platfo
 			ms_hyperv.shared_gpa_boundary =
 				BIT_ULL(ms_hyperv.shared_gpa_boundary_bits);
 
-		hyperv_paravisor_present = !!ms_hyperv.paravisor_present;
-
 		pr_info("Hyper-V: Isolation Config: Group A 0x%x, Group B 0x%x\n",
 			ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
 
 
 		if (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP) {
 			static_branch_enable(&isolation_type_snp);
+			if (!ms_hyperv.paravisor_present)
+				hypercall_update(hv_snp_hypercall);
 		} else if (hv_get_isolation_type() == HV_ISOLATION_TYPE_TDX) {
 			static_branch_enable(&isolation_type_tdx);
 
@@ -498,6 +504,7 @@ static void __init ms_hyperv_init_platfo
 			ms_hyperv.hints &= ~HV_X64_APIC_ACCESS_RECOMMENDED;
 
 			if (!ms_hyperv.paravisor_present) {
+				hypercall_update(hv_tdx_hypercall);
 				/*
 				 * Mark the Hyper-V TSC page feature as disabled
 				 * in a TDX VM without paravisor so that the



