Return-Path: <linux-efi+bounces-5493-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB757C53D42
	for <lists+linux-efi@lfdr.de>; Wed, 12 Nov 2025 19:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BF883B51DB
	for <lists+linux-efi@lfdr.de>; Wed, 12 Nov 2025 17:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE20923BCEE;
	Wed, 12 Nov 2025 17:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DISM0op2"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAE0346E5E
	for <linux-efi@vger.kernel.org>; Wed, 12 Nov 2025 17:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762970013; cv=none; b=ahSbMiYwInhopVM96XULiguf4u7qS3MfNJScdfB15L/QhU/fxd8M0bHwl78j7Rf8y0hZcBa5T/OdG51z2mZ+b14/gmZc1N1H9YRddeNiNemrdQ0oDryxRcDPbypZmqYsB2VvCHr570SybPY4G+zrY4rlmylvkvTEPO2Ti0XlhP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762970013; c=relaxed/simple;
	bh=/IgQdi//BI5jazxMmoFRIeq0CQIAIEzpcbw1hfUDZ1g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tuCUF0BE8NZk2xd2FnQiG/IeFXJhg7Ld+ITnBS4fnhEPecaUI5LIhYtlr22QYomyMI7dCFAiYetJlfO01UGUbdSAspG3uqeIjr85xHhHuZaW5XJuARbJeW+kkQ4eAZA3R744h8cSj+WNLDSE+HG/5rA5sG2DB1xvShTRc2/ph2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DISM0op2; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4776b0ada3dso8556715e9.0
        for <linux-efi@vger.kernel.org>; Wed, 12 Nov 2025 09:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762970010; x=1763574810; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1lzPVIM0jk6lCfmTlDsfm5un5OoFWyFqiOUlY/XxPP4=;
        b=DISM0op25UH14dHkKNw1pCE9qmzRfUUgcCJ4MGjuzR3NTORuuovtfowiqHBjo1bL9/
         W6foy9HYOqLEdSub0MAnyScT3Y2YlMQw6gw5yB9kZp3cv4YTvvwUPcndKn0LIQUBbGFv
         tO/fYB4hJieokGUcoFnVG7zvaHxlCFKVBmq+dNsmkcmU2FRNxP0x+lwXPOG6cLu7ad7C
         IlL74KXKPEn9NPCBa+uTjvfwdYWx/CTB759/YsQCscZhgrSy6CUAeQdbBVWmThB/t/vQ
         hq3MS6a2B4kHmj5Bsmpw/XwIDvCFYjv9zkAe1Z1UZn8ybtdy4wZrOdVwdG9XAPxybMum
         GcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762970010; x=1763574810;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1lzPVIM0jk6lCfmTlDsfm5un5OoFWyFqiOUlY/XxPP4=;
        b=KG+NYjOeDABrq+kKZsVxs1mt+EQQVaaUQBA+XitmuAJSAYeXKwqfdZEVhWLzk4Cqy2
         JYa+BUSg5mfhDGYqpnvu9nj91wMZ4lwiiyslnAmJbZS7NFbLtQbTNTHhxb5j/+qa+EUh
         AEIL9OUz32S8U91RnmcA5o/VIkGu1heH4zgHQoNKQfnKbTabQfSkdajBwlmSES2w79ZX
         xWaGywiFUdtStuBQb0XgmBx6vPPHBK4WEaWZzD+bzkbZ5CskYgrtyk9z6N2mHKtjRVnN
         zDX6p9Xa9kpQAx4k6Rg2yRwZV2LFX7cEmlJVX9PbgwXHQcK2wUdHgHItJfsEm2tf8J1d
         9thg==
X-Gm-Message-State: AOJu0Yz0Newe8htFq/p/VzS+Y+bOz1wN+Uobq0zeP7cA8t7iIveFlQ/Q
	fQzP039Pxpcl9k6BQjlGyAlsKF8KsbQ8Ij1soUNSXmKLWh225nR0BU1WqLhDiWNQah/9kjcUzQ=
	=
X-Google-Smtp-Source: AGHT+IGIMXmYeRKXlEYO/PcQd+fxrWZjo1uSvFM0H1BRc6rGvHjPZtyXCBPm01G3tFei08dAZ/y0oJAk
X-Received: from wmat24.prod.google.com ([2002:a05:600c:6d18:b0:471:6089:1622])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:c87:b0:477:7f4a:44bd
 with SMTP id 5b1f17b1804b1-4778bc98ae5mr2813645e9.0.1762970010295; Wed, 12
 Nov 2025 09:53:30 -0800 (PST)
Date: Wed, 12 Nov 2025 18:53:19 +0100
In-Reply-To: <20251112175316.2841017-4-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112175316.2841017-4-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=6331; i=ardb@kernel.org;
 h=from:subject; bh=7htj8rfQixeDPnEtJrTCJldExjmPThxir1A3bYKWWBY=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIVPkZP+Dtbe1qqzs7utJ6lceDFJJmPnok/HZlxoLcr84M
 vMx8CztKGVhEONikBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABOxP8rIMMM5U3V6LStTx9Kb
 Cec/r1Gpz741d87hkpnzlB4wbKxvOcTwz3CJl0Yo94FbgZrRrwtP7Y423CYiUGtRNLXGT2jFbp6 bvAA=
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251112175316.2841017-6-ardb+git@google.com>
Subject: [PATCH 2/2] arm64/efi: Remove unneeded SVE/SME fallback
 preserve/store handling
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Since commit 7137a203b251 ("arm64/fpsimd: Permit kernel mode NEON with
IRQs off"), the only condition under which the fallback path is taken
for FP/SIMD preserve/restore across a EFI runtime call is when it is
called from hardirq or NMI context.

In practice, this only happens when the EFI pstore driver is called to
dump the kernel log buffer into a EFI variable under a panic, oops or
emergency_restart() condition, and none of these can be expected to
result in a return to user space for the task in question.

This means that the existing EFI-specific logic for preserving and
restoring SVE/SME state is pointless, and can be removed.

Instead, kill the task, so that an exceedingly unlikely inadvertent
return to user space does not proceed with a corrupted FP/SIMD state.
Also, retain the preserve and restore of the base FP/SIMD state, as that
might belong to kernel mode use of FP/SIMD. (Note that EFI runtime calls
are never invoked reentrantly, even in this case, and so any interrupted
kernel mode FP/SIMD usage will be unrelated to EFI)

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/fpsimd.c | 130 +++-----------------
 1 file changed, 20 insertions(+), 110 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index c154f72634e0..9de1d8a604cb 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -180,13 +180,6 @@ static inline void set_sve_default_vl(int val)
 	set_default_vl(ARM64_VEC_SVE, val);
 }
 
-static u8 *efi_sve_state;
-
-#else /* ! CONFIG_ARM64_SVE */
-
-/* Dummy declaration for code that will be optimised out: */
-extern u8 *efi_sve_state;
-
 #endif /* ! CONFIG_ARM64_SVE */
 
 #ifdef CONFIG_ARM64_SME
@@ -1095,36 +1088,6 @@ int vec_verify_vq_map(enum vec_type type)
 	return 0;
 }
 
-static void __init sve_efi_setup(void)
-{
-	int max_vl = 0;
-	int i;
-
-	if (!IS_ENABLED(CONFIG_EFI))
-		return;
-
-	for (i = 0; i < ARRAY_SIZE(vl_info); i++)
-		max_vl = max(vl_info[i].max_vl, max_vl);
-
-	/*
-	 * alloc_percpu() warns and prints a backtrace if this goes wrong.
-	 * This is evidence of a crippled system and we are returning void,
-	 * so no attempt is made to handle this situation here.
-	 */
-	if (!sve_vl_valid(max_vl))
-		goto fail;
-
-	efi_sve_state = kmalloc(SVE_SIG_REGS_SIZE(sve_vq_from_vl(max_vl)),
-				GFP_KERNEL);
-	if (!efi_sve_state)
-		goto fail;
-
-	return;
-
-fail:
-	panic("Cannot allocate memory for EFI SVE save/restore");
-}
-
 void cpu_enable_sve(const struct arm64_cpu_capabilities *__always_unused p)
 {
 	write_sysreg(read_sysreg(CPACR_EL1) | CPACR_EL1_ZEN_EL1EN, CPACR_EL1);
@@ -1185,8 +1148,6 @@ void __init sve_setup(void)
 	if (sve_max_virtualisable_vl() < sve_max_vl())
 		pr_warn("%s: unvirtualisable vector lengths present\n",
 			info->name);
-
-	sve_efi_setup();
 }
 
 /*
@@ -1947,9 +1908,6 @@ EXPORT_SYMBOL_GPL(kernel_neon_end);
 #ifdef CONFIG_EFI
 
 static struct user_fpsimd_state efi_fpsimd_state;
-static bool efi_fpsimd_state_used;
-static bool efi_sve_state_used;
-static bool efi_sm_state;
 
 /*
  * EFI runtime services support functions
@@ -1976,43 +1934,26 @@ void __efi_fpsimd_begin(void)
 	if (may_use_simd()) {
 		kernel_neon_begin(&efi_fpsimd_state);
 	} else {
-		WARN_ON(preemptible());
-
 		/*
-		 * If !efi_sve_state, SVE can't be in use yet and doesn't need
-		 * preserving:
+		 * We are running in hardirq or NMI context, and the only
+		 * legitimate case where this might happen is when EFI pstore
+		 * is attempting to record the system's dying gasps into EFI
+		 * variables. This could be due to an oops, a panic or a call
+		 * to emergency_restart(), and in none of those cases, we can
+		 * expect the current task to ever return to user space again,
+		 * or for the kernel to resume any normal execution, for that
+		 * matter (an oops in hardirq context triggers a panic too).
+		 *
+		 * Therefore, there is no point in attempting to preserve any
+		 * SVE/SME state here. On the off chance that we might have
+		 * ended up here for a different reason inadvertently, kill the
+		 * task and preserve/restore the base FP/SIMD state, which
+		 * might belong to kernel mode FP/SIMD.
 		 */
-		if (system_supports_sve() && efi_sve_state != NULL) {
-			bool ffr = true;
-			u64 svcr;
-
-			efi_sve_state_used = true;
-
-			if (system_supports_sme()) {
-				svcr = read_sysreg_s(SYS_SVCR);
-
-				efi_sm_state = svcr & SVCR_SM_MASK;
-
-				/*
-				 * Unless we have FA64 FFR does not
-				 * exist in streaming mode.
-				 */
-				if (!system_supports_fa64())
-					ffr = !(svcr & SVCR_SM_MASK);
-			}
-
-			sve_save_state(efi_sve_state + sve_ffr_offset(sve_max_vl()),
-				       &efi_fpsimd_state.fpsr, ffr);
-
-			if (system_supports_sme())
-				sysreg_clear_set_s(SYS_SVCR,
-						   SVCR_SM_MASK, 0);
-
-		} else {
-			fpsimd_save_state(&efi_fpsimd_state);
-		}
-
-		efi_fpsimd_state_used = true;
+		pr_warn_ratelimited("Calling EFI runtime from %s context\n",
+				    in_nmi() ? "NMI" : "hardirq");
+		force_signal_inject(SIGKILL, SI_KERNEL, 0, 0);
+		fpsimd_save_state(&efi_fpsimd_state);
 	}
 }
 
@@ -2024,41 +1965,10 @@ void __efi_fpsimd_end(void)
 	if (!system_supports_fpsimd())
 		return;
 
-	if (!efi_fpsimd_state_used) {
+	if (may_use_simd()) {
 		kernel_neon_end(&efi_fpsimd_state);
 	} else {
-		if (system_supports_sve() && efi_sve_state_used) {
-			bool ffr = true;
-
-			/*
-			 * Restore streaming mode; EFI calls are
-			 * normal function calls so should not return in
-			 * streaming mode.
-			 */
-			if (system_supports_sme()) {
-				if (efi_sm_state) {
-					sysreg_clear_set_s(SYS_SVCR,
-							   0,
-							   SVCR_SM_MASK);
-
-					/*
-					 * Unless we have FA64 FFR does not
-					 * exist in streaming mode.
-					 */
-					if (!system_supports_fa64())
-						ffr = false;
-				}
-			}
-
-			sve_load_state(efi_sve_state + sve_ffr_offset(sve_max_vl()),
-				       &efi_fpsimd_state.fpsr, ffr);
-
-			efi_sve_state_used = false;
-		} else {
-			fpsimd_load_state(&efi_fpsimd_state);
-		}
-
-		efi_fpsimd_state_used = false;
+		fpsimd_load_state(&efi_fpsimd_state);
 	}
 }
 
-- 
2.52.0.rc1.455.g30608eb744-goog


