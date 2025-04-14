Return-Path: <linux-efi+bounces-3323-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CECB1A87F51
	for <lists+linux-efi@lfdr.de>; Mon, 14 Apr 2025 13:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39EEC1751B7
	for <lists+linux-efi@lfdr.de>; Mon, 14 Apr 2025 11:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CAB29DB8A;
	Mon, 14 Apr 2025 11:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d7q2p+/P"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6454F298CBE;
	Mon, 14 Apr 2025 11:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744630781; cv=none; b=OLYovIDmggpFQgk4ghjxWDZzg2RQYsjf5wzVjNjHEpErce3CYOVKK7SgJyWpbiQZcnM5ie14juQt67H7H+dQgXC3LpqbPVTv7Giq7K3nPdx1NukyJ/OkQbpx4ZNrRp0RqxwR9F+bgSIWsOaux1D3cLRqKkdX0geoOlL8+lkk2AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744630781; c=relaxed/simple;
	bh=2pHvcytICOR27CCZF4HGChWq0sHLLAVds6wjhxK7xlg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=rFL7jMtcdCITkJku34oaG2qLVkH04Darcv3Y3jmw5yacunCqLyEv8bIbAKQTkb0uoKiOpV/aIJAWWrVbdY1sKgL9aYhgVmULD64MYsRKXXYoaWwfzoiGwSJ6xaLj1W1pgeospf2B7eCgMJTkeJ88n9S8P7f4r11fktcR/lhc/ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d7q2p+/P; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=Tw2TGqdS/SbI3jUKF6I+o/3BGdMLR7QI7YMxJmOUkxk=; b=d7q2p+/PO/GjuQwPyxkgFZV2K/
	rkOnryXJbtWrLlFXOK25iGBhIECC5VsXNJNjjkbTYPn/jIk3mALF7RdBf57n8qBH3T0a9wfBYuMgM
	oOeAyAUfFO/S87lEf06YYtK9uIj5NvSwfnkxKE2cT67WjMEznLHM49ZYzGLE3XOoQNj1qZXh29g7E
	bkDGUZnh2Bodp0x5+6Oi4R3GCLuIWYiRxTvIYnOuhthZHO8Xev2+vwn8QZl7oYFYrGswrdmgpKw+P
	gHhc3bWXpcHptM+te9GjOl3MkhcDC7YN3A0tCQlNdss5RrrC4t62BKTq2b2OZT4cD+S1+4xfP99IL
	zktLbPXw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4I9u-000000084H6-3UmO;
	Mon, 14 Apr 2025 11:39:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 3487D301171; Mon, 14 Apr 2025 13:39:26 +0200 (CEST)
Message-ID: <20250414113754.435282530@infradead.org>
User-Agent: quilt/0.66
Date: Mon, 14 Apr 2025 13:11:45 +0200
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
 peterz@infradead.org,
 jpoimboe@kernel.org,
 pawan.kumar.gupta@linux.intel.com,
 seanjc@google.com,
 pbonzini@redhat.com,
 ardb@kernel.org,
 kees@kernel.org,
 Arnd Bergmann <arnd@arndb.de>,
 gregkh@linuxfoundation.org,
 linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org,
 linux-efi@vger.kernel.org,
 samitolvanen@google.com,
 ojeda@kernel.org
Subject: [PATCH 5/6] x86_64,hyperv: Use direct call to hypercall-page
References: <20250414111140.586315004@infradead.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Instead of using an indirect call to the hypercall page, use a direct
call instead. This avoids all CFI problems, including the one where
the hypercall page doesn't have IBT on.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/hyperv/hv_init.c |   62 +++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -37,24 +37,42 @@
 void *hv_hypercall_pg;
 
 #ifdef CONFIG_X86_64
+static u64 __hv_hyperfail(u64 control, u64 param1, u64 param2)
+{
+	return U64_MAX;
+}
+
+DEFINE_STATIC_CALL(__hv_hypercall, __hv_hyperfail);
+
 u64 hv_pg_hypercall(u64 control, u64 param1, u64 param2)
 {
 	u64 hv_status;
 
-	if (!hv_hypercall_pg)
-		return U64_MAX;
-
 	register u64 __r8 asm("r8") = param2;
-	asm volatile (CALL_NOSPEC
+	asm volatile ("call " STATIC_CALL_TRAMP_STR(__hv_hypercall)
 		      : "=a" (hv_status), ASM_CALL_CONSTRAINT,
 		        "+c" (control), "+d" (param1)
-		      : "r" (__r8),
-		        THUNK_TARGET(hv_hypercall_pg)
+		      : "r" (__r8)
 		      : "cc", "memory", "r9", "r10", "r11");
 
 	return hv_status;
 }
+
+typedef u64 (*hv_hypercall_f)(u64 control, u64 param1, u64 param2);
+
+static inline void hv_set_hypercall_pg(void *ptr)
+{
+	hv_hypercall_pg = ptr;
+
+	if (!ptr)
+		ptr = &__hv_hyperfail;
+	static_call_update(__hv_hypercall, (hv_hypercall_f)ptr);
+}
 #else
+static inline void hv_set_hypercall_pg(void *ptr)
+{
+	hv_hypercall_pg = ptr;
+}
 EXPORT_SYMBOL_GPL(hv_hypercall_pg);
 #endif
 
@@ -349,7 +367,7 @@ static int hv_suspend(void)
 	 * pointer is restored on resume.
 	 */
 	hv_hypercall_pg_saved = hv_hypercall_pg;
-	hv_hypercall_pg = NULL;
+	hv_set_hypercall_pg(NULL);
 
 	/* Disable the hypercall page in the hypervisor */
 	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
@@ -375,7 +393,7 @@ static void hv_resume(void)
 		vmalloc_to_pfn(hv_hypercall_pg_saved);
 	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
 
-	hv_hypercall_pg = hv_hypercall_pg_saved;
+	hv_set_hypercall_pg(hv_hypercall_pg_saved);
 	hv_hypercall_pg_saved = NULL;
 
 	/*
@@ -529,8 +547,8 @@ void __init hyperv_init(void)
 	if (hv_isolation_type_tdx() && !ms_hyperv.paravisor_present)
 		goto skip_hypercall_pg_init;
 
-	hv_hypercall_pg = __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START,
-			VMALLOC_END, GFP_KERNEL, PAGE_KERNEL_ROX,
+	hv_hypercall_pg = __vmalloc_node_range(PAGE_SIZE, 1, MODULES_VADDR,
+			MODULES_END, GFP_KERNEL, PAGE_KERNEL_ROX,
 			VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
 			__builtin_return_address(0));
 	if (hv_hypercall_pg == NULL)
@@ -568,27 +586,9 @@ void __init hyperv_init(void)
 		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
 	}
 
-skip_hypercall_pg_init:
-	/*
-	 * Some versions of Hyper-V that provide IBT in guest VMs have a bug
-	 * in that there's no ENDBR64 instruction at the entry to the
-	 * hypercall page. Because hypercalls are invoked via an indirect call
-	 * to the hypercall page, all hypercall attempts fail when IBT is
-	 * enabled, and Linux panics. For such buggy versions, disable IBT.
-	 *
-	 * Fixed versions of Hyper-V always provide ENDBR64 on the hypercall
-	 * page, so if future Linux kernel versions enable IBT for 32-bit
-	 * builds, additional hypercall page hackery will be required here
-	 * to provide an ENDBR32.
-	 */
-#ifdef CONFIG_X86_KERNEL_IBT
-	if (cpu_feature_enabled(X86_FEATURE_IBT) &&
-	    *(u32 *)hv_hypercall_pg != gen_endbr()) {
-		setup_clear_cpu_cap(X86_FEATURE_IBT);
-		pr_warn("Disabling IBT because of Hyper-V bug\n");
-	}
-#endif
+	hv_set_hypercall_pg(hv_hypercall_pg);
 
+skip_hypercall_pg_init:
 	/*
 	 * hyperv_init() is called before LAPIC is initialized: see
 	 * apic_intr_mode_init() -> x86_platform.apic_post_init() and
@@ -658,7 +658,7 @@ void hyperv_cleanup(void)
 	 * let hypercall operations fail safely rather than
 	 * panic the kernel for using invalid hypercall page
 	 */
-	hv_hypercall_pg = NULL;
+	hv_set_hypercall_pg(NULL);
 
 	/* Reset the hypercall page */
 	hypercall_msr.as_uint64 = hv_get_msr(HV_X64_MSR_HYPERCALL);



