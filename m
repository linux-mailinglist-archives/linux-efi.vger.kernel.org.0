Return-Path: <linux-efi+bounces-5817-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 856DACAAC8D
	for <lists+linux-efi@lfdr.de>; Sat, 06 Dec 2025 20:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6FEDA3009B75
	for <lists+linux-efi@lfdr.de>; Sat,  6 Dec 2025 19:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C86C1991B6;
	Sat,  6 Dec 2025 19:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tv40BQXf"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64FF2236F2
	for <linux-efi@vger.kernel.org>; Sat,  6 Dec 2025 19:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765047687; cv=none; b=RITsdXi89oulzgZXJk/Y/JZ73LUQt3asqo7reaXRsUvSDIOimxwx732ekpQqI2VVKaHDcsjBXnGS9Lp3a4eDV4qY/NuWaY27rb5HQWOl0dDD7uu69FjUlXODgT0rcL1f13oVxK1ULbBqlqOAmi/X9jITT83ch5sj1PYW0DRsbmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765047687; c=relaxed/simple;
	bh=kUUjaKsfohqrNmtXxJEaE0d09l9YyYzcjeOynrmblQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NeATpbEqUvzVlhk3Wt3mrpwx5wyjgEV5D7UxDEC2WJ4L4rWAhBgrPxG0EzAijo4BEfOWoIzcNXPItlmuSk1YbJbEW5/ST0/JyX4AybdpNZHnqlOzC8C7eP/MPhjmLWLKbJfd3pqIV4A93M06wLjuPQGPDyOqcyPBWnqO3Tfbu88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tv40BQXf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C3DC19421;
	Sat,  6 Dec 2025 19:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765047686;
	bh=kUUjaKsfohqrNmtXxJEaE0d09l9YyYzcjeOynrmblQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tv40BQXfdLIk/yP5RiseJljnqKqUZmIuTCRsQ9h5RmI5BpdLconbIiFydu2GFVZty
	 234WyIHz2zlWYImQWts/VQi9Ln9WcqkYtoo/034RElw1Uc2Hr9m3JQ3n0/1H7FjUlS
	 /A1+I3wxk9Ie/wDjui55ck8Vmjf99pLrT8wm5IE3gtgJdN45wlkayDG/glalyAUlUR
	 t3T6Mb9bOp5PA0beg25SBXj0T3AxhxEkUa+fxQyi326hOrmkmjm85EUtofXz/R7QQw
	 QLO3VH0FFe4SJgMk2VjaG4GHOlleXIpgvTDrzQnCpxpMxtJQIF28RL4je5CLo6JbiQ
	 eZ9OHLIgsirtg==
From: Ard Biesheuvel <ardb@kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-efi@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Kees Cook <keescook@chromium.org>
Subject: [PATCH v2 2/2] arm64/efi: Remove unneeded SVE/SME fallback preserve/store handling
Date: Sat,  6 Dec 2025 20:01:17 +0100
Message-ID: <20251206190114.892262-6-ardb@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251206190114.892262-4-ardb@kernel.org>
References: <20251206190114.892262-4-ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6306; i=ardb@kernel.org; h=from:subject; bh=kUUjaKsfohqrNmtXxJEaE0d09l9YyYzcjeOynrmblQM=; b=owGbwMvMwCVmkMcZplerG8N4Wi2JIdOktvaM6fdHmyYwFxqwTNxQmyrTmrHVJ6J8jvR296SNy zjuCE7pKGVhEONikBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABNZzcPwP+l0x9FTJdyfv339 dW2D3Jz/U9e9SuYKm/+S+RxHe0e4QSzD/xoNoTsV8w91LTi1N79sQqzCH+YfRzP1mQ+euNkRKlh gxwQA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit

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
2.47.3


