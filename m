Return-Path: <linux-efi+bounces-2606-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2BEA09A32
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jan 2025 19:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 110267A460E
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jan 2025 18:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C0924B247;
	Fri, 10 Jan 2025 18:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wujPq0Gt"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lf1-f73.google.com (mail-lf1-f73.google.com [209.85.167.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7160324B23D
	for <linux-efi@vger.kernel.org>; Fri, 10 Jan 2025 18:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736534994; cv=none; b=FRc7FifsX96Pp93C/PZDvI87JlqXDxeK38GjqCVBIi9ZGpRr1FeyKAxPvbKOHhVRtR8vfMM8A3HOu4wiyspv1DVRERTSTVO7IaRs112+OP/4BlVvM5PC8ZJr1Mp4CNLUYoEOKKexJIjW2tqkGsuC08ixuiPHrk3nnqtu9lueJQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736534994; c=relaxed/simple;
	bh=Ua0Eznh6vBIqJokkBKNt1xiE4aA9cS4fZDm05XjqWbo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Cn+qYC2PTvuDFXgCfWlPPXzHhiv723zH/7aEwuPp0X53y4ZF9uEuXJEI4BSTkSUfQHi+T6EVizF2qpMA6hLViCRSAyyskTwPaPRbU/64hcLnqnRtcuMRDk15oyCcQYp6yGnuPUd5UdNiP+anbvcQABqtHE+pONLleReWkgWwPgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wujPq0Gt; arc=none smtp.client-ip=209.85.167.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-lf1-f73.google.com with SMTP id 2adb3069b0e04-53e39a081f9so1115544e87.0
        for <linux-efi@vger.kernel.org>; Fri, 10 Jan 2025 10:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736534991; x=1737139791; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YGrdWVEeU4Ptbj/O5LlMCmxq+nbCGI8+4U1HKBQ0dew=;
        b=wujPq0Gt26ldQtuQHJmENnGZE8bof3BRR58fIDtLLMxmYpnMQVfTIxyuG1u+h19oid
         Vk2wmnk9kBJlqP3n0FyYBctipRxEvEE4621LvMo2r6rlfe8+UcNEMJXgENH27RZeK1I5
         NOYUXeOnCA6mifSbyLi7lUcP/1L05IN9IwxfWrQlGltgy147CfR+4mKX0fqIylnTmymu
         SFcKqOeOJaHGqK3Z5aBE5JeF8XYlAywu+7OoHRl5ac2WsO/rkWm1Eo3PMwOkQBMLyChe
         rr4/9fh7bI6DQxqBK/2YHX0jibLcd8Ht+PgMorItcDYG5ZZiR0y/A14bbOqTdHEOwwGX
         +7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736534991; x=1737139791;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YGrdWVEeU4Ptbj/O5LlMCmxq+nbCGI8+4U1HKBQ0dew=;
        b=h/Thyh5JHc85QrfFgP8hxSgONnsZWJ7NBcvwzLogRrPZKsGO5yfmSYDpW0rf4F31Kb
         zN4b794yLy8B55w21ndgFUH0SmlP9htroAnLXxXuZ1ylsndmJEsR+XaVbBiiOIjRLYeI
         UWlkpZ7Adr2CX0We2jQy5EF69o47LTpSlOdJsPy+Wsu2vA0mTYZcIiAoIqEvXyx1WA79
         nSCvKu14EIBm7WaXrKOTNtEA62bp8gpuYy0n/S2zVAdgx8YyjxzFzmKoTEoHZEMpmLBL
         L5nQHE5po1JloxEWTi5QqHcFZvORq2S0Y2ZAfDEITsIzBKT8D37mksTmHSTLh189LcQ2
         uzBg==
X-Forwarded-Encrypted: i=1; AJvYcCUUUXmarf/wR8tSZCiYzx4ogFDiLfCsx/vS+bftZBr4phGUpcXxBiodPu9vaM68xWEGuS/+WGYHf24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws+VOOXFTWbivw3krpgkgGq+Vgb3Rxs0k4jbtwrjHP8q0Q98y6
	H/UmPHXa+f/72MB9X9kTtTo9T871eZPYxZ8m1VsJU42QiqlNrH+fobgvI/Shfh15TN93KcSkjk5
	Zp+gCkojF3A==
X-Google-Smtp-Source: AGHT+IEgsXbDoolH8oLFMalWBy0djT9uJM60zMy+Lo0ErgHawFZLEGOSZUiE5P0d6bxzOZZfpK4Vh92Jd6K16A==
X-Received: from wmrn43.prod.google.com ([2002:a05:600c:502b:b0:434:a9bd:e68c])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f81:b0:434:f1d5:1453 with SMTP id 5b1f17b1804b1-436e2531ec8mr120237105e9.0.1736534506703;
 Fri, 10 Jan 2025 10:41:46 -0800 (PST)
Date: Fri, 10 Jan 2025 18:40:53 +0000
In-Reply-To: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250110-asi-rfc-v2-v2-27-8419288bc805@google.com>
Subject: [PATCH RFC v2 27/29] mm: asi: Add some mitigations on address space transitions
From: Brendan Jackman <jackmanb@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Chris Zankel <chris@zankel.net>, 
	Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mike Rapoport <rppt@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	kvm@vger.kernel.org, linux-efi@vger.kernel.org, 
	Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

Here we ASI actually starts becoming a real exploit mitigation,

On CPUs with L1TF, flush L1D when the ASI data taints say so.

On all CPUs, do some general branch predictor clearing
whenever the control taints say so.

This policy is very much just a starting point for discussion.
Primarily it's a vague gesture at the fact that there is leeway
in how ASI is used: it can be used to target CPU-specific issues (as
is the case for L1TF here), or it can be used as a fairly broad
mitigation (asi_maybe_flush_control() mitigates several known
Spectre-style attacks and very likely also some unknown ones).

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/include/asm/nospec-branch.h |  2 ++
 arch/x86/kvm/vmx/vmx.c               |  1 +
 arch/x86/lib/l1tf.c                  |  2 ++
 arch/x86/lib/retpoline.S             | 10 ++++++++++
 arch/x86/mm/asi.c                    | 29 +++++++++++++++++++++--------
 5 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 96b410b1d4e841eb02f53a4691ee794ceee4ad2c..4582fb1fb42f6fd226534012d969ed13085e943a 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -614,6 +614,8 @@ static __always_inline void mds_idle_clear_cpu_buffers(void)
 		mds_clear_cpu_buffers();
 }
 
+extern void fill_return_buffer(void);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_NOSPEC_BRANCH_H_ */
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b1a02f27b3abce0ef6ac448b66bef2c653a52eef..a532783caaea97291cd92a2e2cac617f74f76c7e 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6635,6 +6635,7 @@ int vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 	return ret;
 }
 
+/* Must be reentrant, for use by vmx_post_asi_enter. */
 static noinstr void vmx_l1d_flush(struct kvm_vcpu *vcpu)
 {
 	/*
diff --git a/arch/x86/lib/l1tf.c b/arch/x86/lib/l1tf.c
index c474f18ae331c8dfa7a029c457dd3cf75bebf808..ffe1c3d0ef43ff8f1781f2e446aed041f4ce3179 100644
--- a/arch/x86/lib/l1tf.c
+++ b/arch/x86/lib/l1tf.c
@@ -46,6 +46,8 @@ EXPORT_SYMBOL(l1tf_flush_setup);
  *  - may or may not work on other CPUs.
  *
  * Don't call unless l1tf_flush_setup() has returned successfully.
+ *
+ * Must be reentrant, for use by ASI.
  */
 noinstr void l1tf_flush(void)
 {
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 391059b2c6fbc4a571f0582c7c4654147a930cef..6d126fff6bf839889086fe21464d8af07316d7e5 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -396,3 +396,13 @@ SYM_CODE_END(__x86_return_thunk)
 EXPORT_SYMBOL(__x86_return_thunk)
 
 #endif /* CONFIG_MITIGATION_RETHUNK */
+
+.pushsection .noinstr.text, "ax"
+SYM_CODE_START(fill_return_buffer)
+	UNWIND_HINT_FUNC
+	ENDBR
+	__FILL_RETURN_BUFFER(%_ASM_AX,RSB_CLEAR_LOOPS)
+	RET
+SYM_CODE_END(fill_return_buffer)
+__EXPORT_THUNK(fill_return_buffer)
+.popsection
diff --git a/arch/x86/mm/asi.c b/arch/x86/mm/asi.c
index 1e9dc568e79e8686a4dbf47f765f2c2535d025ec..f10f6614b26148e5ba423d8a44f640674573ee40 100644
--- a/arch/x86/mm/asi.c
+++ b/arch/x86/mm/asi.c
@@ -10,6 +10,7 @@
 
 #include <asm/cmdline.h>
 #include <asm/cpufeature.h>
+#include <asm/l1tf.h>
 #include <asm/page.h>
 #include <asm/pgalloc.h>
 #include <asm/mmu_context.h>
@@ -38,6 +39,8 @@ struct asi __asi_global_nonsensitive = {
 	.mm = &init_mm,
 };
 
+static bool do_l1tf_flush __ro_after_init;
+
 static inline bool asi_class_id_valid(enum asi_class_id class_id)
 {
 	return class_id >= 0 && class_id < ASI_MAX_NUM_CLASSES;
@@ -361,6 +364,15 @@ static int __init asi_global_init(void)
 	asi_clone_pgd(asi_global_nonsensitive_pgd, init_mm.pgd,
 		      VMEMMAP_START + (1UL << PGDIR_SHIFT));
 
+	if (boot_cpu_has_bug(X86_BUG_L1TF)) {
+		int err = l1tf_flush_setup();
+
+		if (err)
+			pr_warn("Failed to setup L1TF flushing for ASI (%pe)", ERR_PTR(err));
+		else
+			do_l1tf_flush = true;
+	}
+
 #ifdef CONFIG_PM_SLEEP
 	register_syscore_ops(&asi_syscore_ops);
 #endif
@@ -512,10 +524,12 @@ static __always_inline void maybe_flush_control(struct asi *next_asi)
 	if (!taints)
 		return;
 
-	/*
-	 * This is where we'll do the actual dirty work of clearing uarch state.
-	 * For now we just pretend, clear the taints.
-	 */
+	/* Clear normal indirect branch predictions, if we haven't */
+	if (cpu_feature_enabled(X86_FEATURE_IBPB))
+		__wrmsr(MSR_IA32_PRED_CMD, PRED_CMD_IBPB, 0);
+
+	fill_return_buffer();
+
 	this_cpu_and(asi_taints, ~ASI_TAINTS_CONTROL_MASK);
 }
 
@@ -536,10 +550,9 @@ static __always_inline void maybe_flush_data(struct asi *next_asi)
 	if (!taints)
 		return;
 
-	/*
-	 * This is where we'll do the actual dirty work of clearing uarch state.
-	 * For now we just pretend, clear the taints.
-	 */
+	if (do_l1tf_flush)
+		l1tf_flush();
+
 	this_cpu_and(asi_taints, ~ASI_TAINTS_DATA_MASK);
 }
 

-- 
2.47.1.613.gc27f4b7a9f-goog


