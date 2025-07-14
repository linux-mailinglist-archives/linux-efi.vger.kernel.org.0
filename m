Return-Path: <linux-efi+bounces-4331-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E73B03C5A
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 12:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56F264A08EA
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 10:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E102505CB;
	Mon, 14 Jul 2025 10:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dZXGedzz"
X-Original-To: linux-efi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7978C1DF26A;
	Mon, 14 Jul 2025 10:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489911; cv=none; b=d56ldEGJbWbcq5+d0WVVD+3SbOLIysyaTtS355g99WL1jB818a0bLitg80Kpj+gNRdsTsZMJMwlpcx+6Z5VDregKshJHMcUnTKGl+ILU7cY3eWL6aPnEMpUFwhOub5iM7+aZyjwRVm5agegsB80M5mXrMKBsNiFMRIlki+/9oF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489911; c=relaxed/simple;
	bh=bkHFi5EFOP73EpSepmQZ4Q9VkRfFvaXax+LB6lsSbCM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=k1irD7ozCp3A6u2M6+IPE0v24hVjkvK2SyhBMzG9/OdI0m2ZlvTNoY74XvFpD+pwZiU+E1DbGy6Vtfq/nbul/6qqLDIzvfBqktMymO5Df3KfG+r0VVbYzYg70BabLtcUFTPWS2KMSOCjNCFkKrtcAiOPoHruw2FqWiFqRlLNzpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dZXGedzz; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=WIJjzE7IhtYykmJnVpMemXxfCZI1nRxY9Sjvw5cW+qs=; b=dZXGedzzBh/fghEtWOpO+lNJMl
	D8A2lujEejAlY0c9KFQpHgzgdUFlv7SFXkvIIy5g0Hvh9+HtIyNQ9shvhQVhk81+uE6faieRn9lPI
	H2ni3JWuNGXeePTfCXwkrlljP8xxMezV6McXMd51WhRUgGDIWWwxGMo/LCg7PxEMRcm9C6+Lk6K6L
	RQ7LEOaJbdseIHRixZbf2ke3w87fvWl74LmdphVdMd788Kxti7kM3MSAL6dQs0veAXnHt8KoTfBXe
	zKIlnWAO40HaAdLEd1ac/srXtkBEBal/Hr2e7Yo7/lsem3RsOBXAtO185jFhcUn+bD+cS7QMs6SKE
	txJBVI9w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubGg1-00000009kcp-0z61;
	Mon, 14 Jul 2025 10:44:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 2101F302D9C; Mon, 14 Jul 2025 12:44:51 +0200 (CEST)
Message-ID: <20250714103441.121251108@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 14 Jul 2025 12:20:24 +0200
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
Subject: [PATCH v3 13/16] x86/fred: Install system vector handlers even if FRED isnt fully enabled
References: <20250714102011.758008629@infradead.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Sean Christopherson <seanjc@google.com>

Install the system vector IRQ handlers for FRED even if FRED isn't fully
enabled in hardware.  This will allow KVM to use the FRED IRQ path even
on non-FRED hardware, which in turn will eliminate a non-CFI indirect CALL
(KVM currently invokes the IRQ handler via an IDT lookup on the vector).

[sean: extract from diff, drop stub, write changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/idtentry.h |    9 ++-------
 arch/x86/kernel/irqinit.c       |    6 ++++--
 2 files changed, 6 insertions(+), 9 deletions(-)

--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -460,17 +460,12 @@ __visible noinstr void func(struct pt_re
 #endif
 
 void idt_install_sysvec(unsigned int n, const void *function);
-
-#ifdef CONFIG_X86_FRED
 void fred_install_sysvec(unsigned int vector, const idtentry_t function);
-#else
-static inline void fred_install_sysvec(unsigned int vector, const idtentry_t function) { }
-#endif
 
 #define sysvec_install(vector, function) {				\
-	if (cpu_feature_enabled(X86_FEATURE_FRED))			\
+	if (IS_ENABLED(CONFIG_X86_FRED))				\
 		fred_install_sysvec(vector, function);			\
-	else								\
+	if (!cpu_feature_enabled(X86_FEATURE_FRED))			\
 		idt_install_sysvec(vector, asm_##function);		\
 }
 
--- a/arch/x86/kernel/irqinit.c
+++ b/arch/x86/kernel/irqinit.c
@@ -97,9 +97,11 @@ void __init native_init_IRQ(void)
 	/* Execute any quirks before the call gates are initialised: */
 	x86_init.irqs.pre_vector_init();
 
-	if (cpu_feature_enabled(X86_FEATURE_FRED))
+	/* FRED's IRQ path may be used even if FRED isn't fully enabled. */
+	if (IS_ENABLED(CONFIG_X86_FRED))
 		fred_complete_exception_setup();
-	else
+
+	if (!cpu_feature_enabled(X86_FEATURE_FRED))
 		idt_setup_apic_and_irq_gates();
 
 	lapic_assign_system_vectors();



