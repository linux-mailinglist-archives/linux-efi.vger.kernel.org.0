Return-Path: <linux-efi+bounces-4323-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A6BB03C39
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 12:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24BB417D1EA
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 10:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBD4248889;
	Mon, 14 Jul 2025 10:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r4a5wYdB"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCB422836C;
	Mon, 14 Jul 2025 10:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489909; cv=none; b=TzDWn6VLnBX/4CLkvZWsCqgXgNC5u0ep1X1OlSTB+hwxZfP+X/DMSJ6FxBoURscFM+JokjWxesn1LNN5NnhyvkWlFECkwtrUhIEN4BCmqbuYGrt9HIlcSctAD+koTlOgAlR6bKUaTmuITnTHGeYUFxIURyfcJJKR3IYbyRDyx8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489909; c=relaxed/simple;
	bh=QX0FuRDOAhBaSmYLOCWMM+5snfSl3DY0vGzX5svD2Qs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=EWSBJLcK3JzSRHN08qncQQdsFYiFSyBeYEPOSoKgFwjG3bjULi9vcECkn9iw1sVVQfBGQpNcrb2j/qbH41YVX1HTlRrLfKMU0Zad5KnNOlj0So/1knJnIDuaNqqFQ76eK+57Vq2uCl2YPVh0SAJXNZPuJSlVJ4BqeFEC3hSHVZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=r4a5wYdB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=xyqfgYFIZicYr7jarOLRNC4OG3o0XqiWBsV4JdioE+8=; b=r4a5wYdBxnZB8a/vFS4cDKxcTO
	7oVK8XPBkbNVudpn22oc7xHDzTgfWEvqn/D+fkqGJY1X/Lb6DOjOuFDgvBBfrOkunXWat1NK2+sFA
	nULNlfr7b01z22k/KtThyq/iEkQR4p8SUyRAyjbP0TKFXNAcef0CzT8jeNdP3bYEUpzeyFRgeQRlD
	6mYrf59tJewGMJg5T86VkMt588DxtXJPhGPXeG/5rbcWUdfmuo/eKuKmEyIiDN4cUrMRlJPmJgeFz
	Es/6/TJOMlbg98UvRMvAX+NK/rIe/BQGVzV1RoPTVin0OZvstDoar4lprgdKThavzQGA26uLKVCLs
	rdmdiMDw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubGg1-00000006uLF-10Ax;
	Mon, 14 Jul 2025 10:44:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 0C74B300186; Mon, 14 Jul 2025 12:44:51 +0200 (CEST)
Message-ID: <20250714103441.011387946@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 14 Jul 2025 12:20:23 +0200
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
Subject: [PATCH v3 12/16] x86_64,hyperv: Use direct call to hypercall-page
References: <20250714102011.758008629@infradead.org>
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
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
---
 arch/x86/hyperv/hv_init.c |   61 ++++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -17,7 +17,6 @@
 #include <asm/desc.h>
 #include <asm/e820/api.h>
 #include <asm/sev.h>
-#include <asm/ibt.h>
 #include <asm/hypervisor.h>
 #include <hyperv/hvhdk.h>
 #include <asm/mshyperv.h>
@@ -38,23 +37,41 @@
 void *hv_hypercall_pg;
 
 #ifdef CONFIG_X86_64
+static u64 __hv_hyperfail(u64 control, u64 param1, u64 param2)
+{
+	return U64_MAX;
+}
+
+DEFINE_STATIC_CALL(__hv_hypercall, __hv_hyperfail);
+
 u64 hv_std_hypercall(u64 control, u64 param1, u64 param2)
 {
 	u64 hv_status;
 
-	if (!hv_hypercall_pg)
-		return U64_MAX;
-
 	register u64 __r8 asm("r8") = param2;
-	asm volatile (CALL_NOSPEC
+	asm volatile ("call " STATIC_CALL_TRAMP_STR(__hv_hypercall)
 		      : "=a" (hv_status), ASM_CALL_CONSTRAINT,
 		        "+c" (control), "+d" (param1), "+r" (__r8)
-		      : THUNK_TARGET(hv_hypercall_pg)
-		      : "cc", "memory", "r9", "r10", "r11");
+		      : : "cc", "memory", "r9", "r10", "r11");
 
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
 
@@ -349,7 +366,7 @@ static int hv_suspend(void)
 	 * pointer is restored on resume.
 	 */
 	hv_hypercall_pg_saved = hv_hypercall_pg;
-	hv_hypercall_pg = NULL;
+	hv_set_hypercall_pg(NULL);
 
 	/* Disable the hypercall page in the hypervisor */
 	rdmsrq(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
@@ -375,7 +392,7 @@ static void hv_resume(void)
 		vmalloc_to_pfn(hv_hypercall_pg_saved);
 	wrmsrq(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
 
-	hv_hypercall_pg = hv_hypercall_pg_saved;
+	hv_set_hypercall_pg(hv_hypercall_pg_saved);
 	hv_hypercall_pg_saved = NULL;
 
 	/*
@@ -529,8 +546,8 @@ void __init hyperv_init(void)
 	if (hv_isolation_type_tdx() && !ms_hyperv.paravisor_present)
 		goto skip_hypercall_pg_init;
 
-	hv_hypercall_pg = __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START,
-			VMALLOC_END, GFP_KERNEL, PAGE_KERNEL_ROX,
+	hv_hypercall_pg = __vmalloc_node_range(PAGE_SIZE, 1, MODULES_VADDR,
+			MODULES_END, GFP_KERNEL, PAGE_KERNEL_ROX,
 			VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
 			__builtin_return_address(0));
 	if (hv_hypercall_pg == NULL)
@@ -568,27 +585,9 @@ void __init hyperv_init(void)
 		wrmsrq(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
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



