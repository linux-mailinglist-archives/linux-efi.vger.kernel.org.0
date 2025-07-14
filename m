Return-Path: <linux-efi+bounces-4333-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A22B03C8B
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 12:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3E4C17E90F
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 10:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4873824A06A;
	Mon, 14 Jul 2025 10:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZgKmApd7"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B2B246348;
	Mon, 14 Jul 2025 10:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752490169; cv=none; b=SRd0QbwpEhU2po3EtSS1TJ7EzraYXh0Vr+8vZKj4yRfyLhtx6aCxOS1kK2Xs+ONW9tRtrHQC1dd2pYYG3dE3/q+ug71PjTdPrVr2DI2/RAz4f9ICeq9xsqyi8i1qWg0BXzR754v6VgljOEA5b+yNRtza8Z/HvrNwqefc9ZGOFVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752490169; c=relaxed/simple;
	bh=lmMO9oWiY1La7NZpL7XvxppUXvYIpzkkNjadrtUu4bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m67ntqh4Ov93FngLHKdUNbCNj7V+jIAshPLoN+gWUtrUITthSYr6PPbDrsR+rG/QeB5QA69cyvaoYZlz5FE7qzuzTW4WNc4sDjUF4+lmBw9lF1S426cCqZrsGl9MtTsF6oIadIuu1Cv5LzcFVo+VeDpsxqWR5h0i5asn0vEOUz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZgKmApd7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sO+NWpjecFiPMw41O/Ux4KHMrLlaxGVkWqwkrh1sfjg=; b=ZgKmApd78AJ8K+Zxx2N+3LgMYS
	e+q4x/TjxrEwsKIWi5LhxsYA7mFvf4cqT0UkD9/LrLMx9/qvwZkzrwaFNAdwGtJx1Jnlhsd7+M5D1
	95nLHfjk98QmtXcsEnC4+ZJi4GEuOEr6GrauK6VuFd5qPGMsOFp42zOyUqzDpQHR8jD+Z9aT9Pcli
	ZJn2xfw94xoz3RQzndfwe/7WDsREwiJNrXWBouxZwJMWLANI+YiIT43PldtrjTyBULVtb1mrLcAp1
	TtLgcwgtrlXreF/N1SQ6zsGookNGMJoiLoe8J3ctRx5noHazWD2MotKNQcRUDQ6ENecBusKSQMZQJ
	UYG0Oazw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubGkJ-00000006v9i-3mPe;
	Mon, 14 Jul 2025 10:49:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 633F4300186; Mon, 14 Jul 2025 12:49:19 +0200 (CEST)
Date: Mon, 14 Jul 2025 12:49:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	seanjc@google.com, pbonzini@redhat.com, ardb@kernel.org,
	kees@kernel.org, Arnd Bergmann <arnd@arndb.de>,
	gregkh@linuxfoundation.org, jpoimboe@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-efi@vger.kernel.org,
	samitolvanen@google.com, ojeda@kernel.org
Subject: Re: [PATCH v3 16/16] objtool: Validate kCFI calls
Message-ID: <20250714104919.GR905792@noisy.programming.kicks-ass.net>
References: <20250714102011.758008629@infradead.org>
 <20250714103441.496787279@infradead.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714103441.496787279@infradead.org>

On Mon, Jul 14, 2025 at 12:20:27PM +0200, Peter Zijlstra wrote:

> --- a/arch/x86/platform/efi/efi_stub_64.S
> +++ b/arch/x86/platform/efi/efi_stub_64.S
> @@ -11,6 +11,10 @@
>  #include <asm/nospec-branch.h>
>  
>  SYM_FUNC_START(__efi_call)
> +	/*
> +	 * The EFI code doesn't have any CFI, annotate away the CFI violation.
> +	 */
> +	ANNOTATE_NOCFI_SYM
>  	pushq %rbp
>  	movq %rsp, %rbp
>  	and $~0xf, %rsp

FWIW, we should probably do something like this as well.

---

--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -562,6 +562,13 @@ __noendbr u64 ibt_save(bool disable)
 {
 	u64 msr = 0;
 
+	/*
+	 * Firmware code will not provide the same level of
+	 * control-flow-integriry. Taint the kernel to let the user know.
+	 */
+	if (disable || (IS_ENABLED(CONFIG_CFI_CLANG) && cfi_mode != CFI_OFF))
+		add_taint(TAINT_CFI, LOCKDEP_STILL_OK);
+
 	if (cpu_feature_enabled(X86_FEATURE_IBT)) {
 		rdmsrq(MSR_IA32_S_CET, msr);
 		if (disable)
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -73,7 +73,8 @@ static inline void set_arch_panic_timeou
 #define TAINT_RANDSTRUCT		17
 #define TAINT_TEST			18
 #define TAINT_FWCTL			19
-#define TAINT_FLAGS_COUNT		20
+#define TAINT_CFI			20
+#define TAINT_FLAGS_COUNT		21
 #define TAINT_FLAGS_MAX			((1UL << TAINT_FLAGS_COUNT) - 1)
 
 struct taint_flag {

