Return-Path: <linux-efi+bounces-4332-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27648B03C64
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 12:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BE0916CCE7
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 10:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEE5256C9B;
	Mon, 14 Jul 2025 10:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZBddkl3h"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC050246771;
	Mon, 14 Jul 2025 10:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489913; cv=none; b=ANSMXJDhUyDFkLF4onUJA+fdpg+dGq/WsNmL7+rtNz3IVAM1y4salk7SK2foqq5xj3xyS7W3qgzwmky0XM6VTA8Mz+z5mI9qgSkeF72WKdeQ46X++pbbN4LkRwgg53k0VEm1gPDB1gTrQUjB2j1KcYFZajrI5BiheFagIW2iZ2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489913; c=relaxed/simple;
	bh=4BcP4fXrFBMBRLHjzTo4hB9zOH0/vrDJl5LSlbB8vJA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=KZt2iA8v8Gwhdl171vnCW0g0CpAyw25RXbi9nNmOlHp+mvw74yCYue/oX0Sn4BPo9NG+165+THPFk0JmRb04gCHvUxEHV0Tn4sXsXwOttEhmVGIASUN924uJDITR6Xvhf7M7WxxDedEe1SYP4QCf2rFy574xcVPtRjXedOTBT10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZBddkl3h; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=MeZEORZBfZVp+I+bBuCjS6/pJWWHjDhfB/pRSpagjvs=; b=ZBddkl3hDaDiOnTDk1oFxpLdsj
	SAbQD4KMDwIT7P98DltzebQ4aB2ygKBRrVJvkpYmIJRALJV4zAVqMluXyUpTu1GZJSOyk4CvlT3rb
	SEQXYniPOxt+M0I0B8bfFPzUPNMttMAFR4B2gRAbU6gar7rKpI0PzYZ7A4IDm61+P2tqzMWTW2iS9
	keFVLDvJAKGlKUSqnlWoBF3RsNvLhwspUSKr0Y7ikn9nNa00cBZqtd4hiPscMp2PG6h4LWlG4aIOR
	ot96ip9LZlGPWyDudZSesA9lOmMaPhV064XJYmR1p4ZL4s72NJaVOGWxQNvG1UrKdew0zh0R9Gb5F
	IZAp4RXg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubGg1-00000006uLE-0wad;
	Mon, 14 Jul 2025 10:44:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 01B35302D93; Mon, 14 Jul 2025 12:44:51 +0200 (CEST)
Message-ID: <20250714103440.897136093@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 14 Jul 2025 12:20:22 +0200
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
 ojeda@kernel.org,
 Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH v3 11/16] x86,hyperv: Clean up hv_do_hypercall()
References: <20250714102011.758008629@infradead.org>
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
Tested-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
---
 arch/x86/hyperv/hv_init.c       |   20 +++++
 arch/x86/hyperv/ivm.c           |   15 ++++
 arch/x86/include/asm/mshyperv.h |  137 +++++++++++-----------------------------
 arch/x86/kernel/cpu/mshyperv.c  |   19 +++--
 4 files changed, 89 insertions(+), 102 deletions(-)

--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -36,7 +36,27 @@
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
@@ -377,9 +377,23 @@ int hv_snp_boot_ap(u32 cpu, unsigned lon
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
@@ -429,6 +443,7 @@ u64 hv_tdx_hypercall(u64 control, u64 pa
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
 #include <asm/msr.h>
@@ -39,16 +40,21 @@ static inline unsigned char hv_get_nmi_r
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
@@ -65,37 +71,15 @@ static inline u64 hv_do_hypercall(u64 co
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
@@ -108,8 +92,8 @@ static inline u64 hv_do_hypercall(u64 co
 			       "D"(output_address_hi), "S"(output_address_lo),
 			       THUNK_TARGET(hv_hypercall_pg)
 			     : "cc", "memory");
-#endif /* !x86_64 */
 	return hv_status;
+#endif /* !x86_64 */
 }
 
 /* Hypercall to the L0 hypervisor */
@@ -121,41 +105,23 @@ static inline u64 hv_do_nested_hypercall
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
@@ -175,45 +141,24 @@ static inline u64 hv_do_fast_nested_hype
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
@@ -38,10 +38,6 @@
 bool hv_nested;
 struct ms_hyperv_info ms_hyperv;
 
-/* Used in modules via hv_do_hypercall(): see arch/x86/include/asm/mshyperv.h */
-bool hyperv_paravisor_present __ro_after_init;
-EXPORT_SYMBOL_GPL(hyperv_paravisor_present);
-
 #if IS_ENABLED(CONFIG_HYPERV)
 static inline unsigned int hv_get_nested_msr(unsigned int reg)
 {
@@ -288,8 +284,18 @@ static void __init x86_setup_ops_for_tsc
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
@@ -484,14 +490,14 @@ static void __init ms_hyperv_init_platfo
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
 
@@ -499,6 +505,7 @@ static void __init ms_hyperv_init_platfo
 			ms_hyperv.hints &= ~HV_X64_APIC_ACCESS_RECOMMENDED;
 
 			if (!ms_hyperv.paravisor_present) {
+				hypercall_update(hv_tdx_hypercall);
 				/*
 				 * Mark the Hyper-V TSC page feature as disabled
 				 * in a TDX VM without paravisor so that the



