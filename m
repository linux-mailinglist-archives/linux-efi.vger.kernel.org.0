Return-Path: <linux-efi+bounces-3018-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B48A67506
	for <lists+linux-efi@lfdr.de>; Tue, 18 Mar 2025 14:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB53719A2E8A
	for <lists+linux-efi@lfdr.de>; Tue, 18 Mar 2025 13:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1B61E5209;
	Tue, 18 Mar 2025 13:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PM3uKoNZ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA768148827
	for <linux-efi@vger.kernel.org>; Tue, 18 Mar 2025 13:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742304273; cv=none; b=FOh5M3ose5GFEvxNBrxDWF8QAZpiSdXXXKhXj2dubBZcFtX84KjPy8IL8h3end0OY2IMUp1ENRmUH2tjpL18OuKCf0GlbkqF/ZijYe85flEw8x+YrQneINilvrbrdn6ckX7TSunNNfRys18x/FdrMT/FPaBNAP9TWEpG/bgIFZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742304273; c=relaxed/simple;
	bh=AUg642Y2fRNp9T9XGQIDMCFm8FgF6ru/Gkj3tqLjGlo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nV2+Ed7R3fRQax5k2Bsv3qFWPIskhqmEmHcxMP3lz0tou+9u3tNc5JrwNJLW4h1hft7TH6P4dWIqd34IJl5/Pa1Re5OSx5ztvobiAYB4ywSo6AX7Qc6beVedcry9cHe+11CHtoUTQxWEiwem0U0TCjvHOnu89GFf244Dz1S/roY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PM3uKoNZ; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-438e4e9a53fso20900655e9.1
        for <linux-efi@vger.kernel.org>; Tue, 18 Mar 2025 06:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742304270; x=1742909070; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DEgzWr2E2NAy7FDuPhBSzhgvxiM8c4iYHbXwNyOFveY=;
        b=PM3uKoNZb6CeILCc2/osxWGdLCXF2w+h/YJL8OuZZQHWcJ4GMBgtgkP5O06JeqJ1Sc
         RIi6Alu8AjwHYVreFOMKIPG/RmMrRhn9FckzDkz6B7gFibsQzws1Hf1z+4E45tvtAMzZ
         cFUyDIwJICiRJmgumXQ9QlnaM0fmPlHyo7JyH/Q2t83WLt0oatqMlNITxJVFWu/Kxvlt
         ZTGe2ZPvZfGser3Q26PLIpF7eMgyv4z3HLpfF6mULa4yWTpiImDqBCMtNvGEUJgdFles
         LGSDX+G4HyRzP2XLDvmr1M9A8gAIlEx4skmTecU+32+CD7jUNnaeeUeXqO2QD3Uj7atO
         7UVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742304270; x=1742909070;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DEgzWr2E2NAy7FDuPhBSzhgvxiM8c4iYHbXwNyOFveY=;
        b=AFORkdgBkTPFUcaMXhmKT1C0MR7EATHbtlXq8oXPtnR8+Qfy4x7Y/bDbgWozLsa0s2
         hDlTOrq5C0MKvkHW0i0ecnLOlHIB4r10C4DKPIhlO0QslEHzS2k6xjmgGBOIOB2ntA8I
         o1kAM2AspxBvfzzXWhPPePBVQwVl5RffAqc6CBXVE5MSgTjadZumVWaYBK3GIn0q43h0
         Odc5V5s54WySk9SZqP4iGsgTlCWVMkvLgqEV9+TiWMyzvYG18rkvXXERSm3ErCt1H6dS
         pfTnIN+ce2zR2j8tggwlHPioxifB8xVH7kc7Co3Fq+/KGbaCY/Xo9LsuTQeiz8B8T4xg
         CFZg==
X-Gm-Message-State: AOJu0Yx5G/rngo7riCDsFBt4WdDJLgJPDSd3yBT3Bcx1MSpGzUKJrgLu
	l2/xbg+WMgAEcStm2Md6O9pGNbNikWkb6W5bB5ndoPaH51FzJ9oRRkwpsmh6looybz8b1A==
X-Google-Smtp-Source: AGHT+IG88/y2gUxFHhZYjd0nXNVh9L0hGC3+X2VVnSItfQsqi/IKCNxpAkyqMZIO+vJlAmNrXHgC/TLn
X-Received: from wmbes18.prod.google.com ([2002:a05:600c:8112:b0:43b:c7e5:66e0])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3ca6:b0:43c:f8fc:f6a6
 with SMTP id 5b1f17b1804b1-43d3b9865c2mr25721555e9.9.1742304270191; Tue, 18
 Mar 2025 06:24:30 -0700 (PDT)
Date: Tue, 18 Mar 2025 14:24:22 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=6366; i=ardb@kernel.org;
 h=from:subject; bh=hrpsKvpCDfcxtB4oZkUT6QqF+MEdOioUp4OeO1ExQqs=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf1mCZvJcoufl57vnFTjEG+c+XVH492zdVylekv8Oxnsj
 Rx+dB3vKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABPhu8zIsH/SoVfT3F+KmDBP
 3plybImVemfvRMYWbU6P55v4v6ruD2VkOKrd4HbzkWuKRYThDtNN13xLN64OMQ5Ot/LKXLLQxmw xMwA=
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250318132421.3155799-2-ardb+git@google.com>
Subject: [PATCH] arm64/fpsimd: Avoid unnecessary per-CPU buffers for EFI
 runtime calls
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-efi@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, 
	mark.rutland@arm.com, broonie@kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The EFI specification has some elaborate rules about which runtime
services may be called while another runtime service call is already in
progress. In Linux, however, for simplicity, all EFI runtime service
invocations are serialized via the efi_runtime_lock semaphore.

This implies that calls to the helper pair arch_efi_call_virt_setup()
and arch_efi_call_virt_teardown() are serialized too, and are guaranteed
not to nest.  Furthermore, the arm64 arch code has its own spinlock to
serialize use of the EFI runtime stack, of which only a single instance
exists.

This all means that the FP/SIMD and SVE state preserve/restore logic in
__efi_fpsimd_begin() and __efi_fpsimd_end() are also serialized, and
only a single instance of the associated per-CPU variables can ever be
in use at the same time. There is therefore no need at all for per-CPU
variables here, and they can all be replaced with singleton instances.
This saves a non-trivial amount of memory on systems with many CPUs.

To be more robust against potential future changes in the core EFI code
that may invalidate the reasoning above, move the invocations of
__efi_fpsimd_begin() and __efi_fpsimd_end() into the critical section
covered by the efi_rt_lock spinlock.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/efi.c    |  4 +--
 arch/arm64/kernel/fpsimd.c | 54 ++++++++++++++++++--------------------
 2 files changed, 27 insertions(+), 31 deletions(-)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 1d25d8899dbf..250e9d7c08a7 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -169,14 +169,14 @@ static DEFINE_RAW_SPINLOCK(efi_rt_lock);
 void arch_efi_call_virt_setup(void)
 {
 	efi_virtmap_load();
-	__efi_fpsimd_begin();
 	raw_spin_lock(&efi_rt_lock);
+	__efi_fpsimd_begin();
 }
 
 void arch_efi_call_virt_teardown(void)
 {
-	raw_spin_unlock(&efi_rt_lock);
 	__efi_fpsimd_end();
+	raw_spin_unlock(&efi_rt_lock);
 	efi_virtmap_unload();
 }
 
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 2b601d88762d..788cc3ad6101 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -180,12 +180,12 @@ static inline void set_sve_default_vl(int val)
 	set_default_vl(ARM64_VEC_SVE, val);
 }
 
-static void __percpu *efi_sve_state;
+static u8 *efi_sve_state;
 
 #else /* ! CONFIG_ARM64_SVE */
 
 /* Dummy declaration for code that will be optimised out: */
-extern void __percpu *efi_sve_state;
+extern u8 *efi_sve_state;
 
 #endif /* ! CONFIG_ARM64_SVE */
 
@@ -1131,15 +1131,15 @@ static void __init sve_efi_setup(void)
 	if (!sve_vl_valid(max_vl))
 		goto fail;
 
-	efi_sve_state = __alloc_percpu(
-		SVE_SIG_REGS_SIZE(sve_vq_from_vl(max_vl)), SVE_VQ_BYTES);
+	efi_sve_state = kmalloc(SVE_SIG_REGS_SIZE(sve_vq_from_vl(max_vl)),
+				GFP_KERNEL);
 	if (!efi_sve_state)
 		goto fail;
 
 	return;
 
 fail:
-	panic("Cannot allocate percpu memory for EFI SVE save/restore");
+	panic("Cannot allocate memory for EFI SVE save/restore");
 }
 
 void cpu_enable_sve(const struct arm64_cpu_capabilities *__always_unused p)
@@ -1973,10 +1973,10 @@ EXPORT_SYMBOL_GPL(kernel_neon_end);
 
 #ifdef CONFIG_EFI
 
-static DEFINE_PER_CPU(struct user_fpsimd_state, efi_fpsimd_state);
-static DEFINE_PER_CPU(bool, efi_fpsimd_state_used);
-static DEFINE_PER_CPU(bool, efi_sve_state_used);
-static DEFINE_PER_CPU(bool, efi_sm_state);
+static struct user_fpsimd_state efi_fpsimd_state;
+static bool efi_fpsimd_state_used;
+static bool efi_sve_state_used;
+static bool efi_sm_state;
 
 /*
  * EFI runtime services support functions
@@ -2009,18 +2009,16 @@ void __efi_fpsimd_begin(void)
 		 * If !efi_sve_state, SVE can't be in use yet and doesn't need
 		 * preserving:
 		 */
-		if (system_supports_sve() && likely(efi_sve_state)) {
-			char *sve_state = this_cpu_ptr(efi_sve_state);
+		if (system_supports_sve() && efi_sve_state != NULL) {
 			bool ffr = true;
 			u64 svcr;
 
-			__this_cpu_write(efi_sve_state_used, true);
+			efi_sve_state_used = true;
 
 			if (system_supports_sme()) {
 				svcr = read_sysreg_s(SYS_SVCR);
 
-				__this_cpu_write(efi_sm_state,
-						 svcr & SVCR_SM_MASK);
+				efi_sm_state = svcr & SVCR_SM_MASK;
 
 				/*
 				 * Unless we have FA64 FFR does not
@@ -2030,19 +2028,18 @@ void __efi_fpsimd_begin(void)
 					ffr = !(svcr & SVCR_SM_MASK);
 			}
 
-			sve_save_state(sve_state + sve_ffr_offset(sve_max_vl()),
-				       &this_cpu_ptr(&efi_fpsimd_state)->fpsr,
-				       ffr);
+			sve_save_state(efi_sve_state + sve_ffr_offset(sve_max_vl()),
+				       &efi_fpsimd_state.fpsr, ffr);
 
 			if (system_supports_sme())
 				sysreg_clear_set_s(SYS_SVCR,
 						   SVCR_SM_MASK, 0);
 
 		} else {
-			fpsimd_save_state(this_cpu_ptr(&efi_fpsimd_state));
+			fpsimd_save_state(&efi_fpsimd_state);
 		}
 
-		__this_cpu_write(efi_fpsimd_state_used, true);
+		efi_fpsimd_state_used = true;
 	}
 }
 
@@ -2054,12 +2051,10 @@ void __efi_fpsimd_end(void)
 	if (!system_supports_fpsimd())
 		return;
 
-	if (!__this_cpu_xchg(efi_fpsimd_state_used, false)) {
+	if (!efi_fpsimd_state_used) {
 		kernel_neon_end();
 	} else {
-		if (system_supports_sve() &&
-		    likely(__this_cpu_read(efi_sve_state_used))) {
-			char const *sve_state = this_cpu_ptr(efi_sve_state);
+		if (system_supports_sve() && efi_sve_state_used) {
 			bool ffr = true;
 
 			/*
@@ -2068,7 +2063,7 @@ void __efi_fpsimd_end(void)
 			 * streaming mode.
 			 */
 			if (system_supports_sme()) {
-				if (__this_cpu_read(efi_sm_state)) {
+				if (efi_sm_state) {
 					sysreg_clear_set_s(SYS_SVCR,
 							   0,
 							   SVCR_SM_MASK);
@@ -2082,14 +2077,15 @@ void __efi_fpsimd_end(void)
 				}
 			}
 
-			sve_load_state(sve_state + sve_ffr_offset(sve_max_vl()),
-				       &this_cpu_ptr(&efi_fpsimd_state)->fpsr,
-				       ffr);
+			sve_load_state(efi_sve_state + sve_ffr_offset(sve_max_vl()),
+				       &efi_fpsimd_state.fpsr, ffr);
 
-			__this_cpu_write(efi_sve_state_used, false);
+			efi_sve_state_used = false;
 		} else {
-			fpsimd_load_state(this_cpu_ptr(&efi_fpsimd_state));
+			fpsimd_load_state(&efi_fpsimd_state);
 		}
+
+		efi_fpsimd_state_used = false;
 	}
 }
 
-- 
2.49.0.rc1.451.g8f38331e32-goog


