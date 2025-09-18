Return-Path: <linux-efi+bounces-4855-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B02DB841E6
	for <lists+linux-efi@lfdr.de>; Thu, 18 Sep 2025 12:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4127D3B8227
	for <lists+linux-efi@lfdr.de>; Thu, 18 Sep 2025 10:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED673043AC;
	Thu, 18 Sep 2025 10:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rjjH8yOx"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6107303A01
	for <linux-efi@vger.kernel.org>; Thu, 18 Sep 2025 10:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191443; cv=none; b=jux6MG69oDk17TBVAXdmrX4KqyeR6rLDWtxBGGBC/2Nzw6TzZUisfVAEWM1Np0x5e9oO9P+CdXB5HhytLNPxa/u0vtZijartqJDFkENT24nNAmFnvdJhuT5OzRDYQmc5uN5OcI0CX0nWSN4bV6cOm1GtyyVmnLtmZHDWGe63Dn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191443; c=relaxed/simple;
	bh=ZGdtaP9UOrhJQRg7Jb5jXlPg0xetCedeLXyyV6Xl2fI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tulm9CxAJrk85hINvpFk7JNgwykqVeOsYqR7+OEhbxjgLk2UZL2YPOyPuiT2V4ywwdpDTpyFqDf57RkFhOtnociBk8JarXCOEt5XqEQReLqoRFzxvEs+qBXiYjDs1VS0W4Pag2NEcVAbUyDFscJpqX+jxEJXNGVQ8L96RWd4Fec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rjjH8yOx; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-62f4f1c70c9so738584a12.0
        for <linux-efi@vger.kernel.org>; Thu, 18 Sep 2025 03:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758191440; x=1758796240; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6H562hA4phalkuc9iW32nFe+iytT6ATVUAyAxRehk0A=;
        b=rjjH8yOxVU/IKdx87dcq4W0F5+mfwZu2WfCOzPfDo9vw++qjSclxbfHkG16gz0O5On
         muCkhxlUvLS+CCu5FLag4sL14M/1qWWdQpDXdl3laeSsL8BUDTinAPHPenwpaiZIueHb
         IXBxhKDBeiZo2FKKrd6ySI7bZXDQj9cOrldruadqjKuuVAbdNrv9smXV8og6Tq+XoBqC
         uth9OzzCjJTWa+XU75S52GGCucfJGuItwVicuo8UG3WNaD1r3TiiZsZEHLOOKWrz6AqE
         xilpat96uSBcc7ecKE4BGZdtBjSYaAWpQj/w8rmpMBP2iEFDgGnUFjUNrUuhACrc84Iv
         8UOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758191440; x=1758796240;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6H562hA4phalkuc9iW32nFe+iytT6ATVUAyAxRehk0A=;
        b=BAJiSPNRlcCIxd95G351AjA8VJYxGjFdPDhHAN+2kj++aj/TTrqxEO2Y95SSmHRSu8
         zW6lJ/pMSQaXZsS/63LItfiWixXrA7Stppx+K3jwbWojKNDjjPvPEH3EDuen1slcp8uO
         YHz+n3VOZcCr3cgdGWnf1b2sonOhGw7gHjQWeKkxpgHnImR9CM3bPWvn1GkczbJOVFyl
         LaiTLPAZ69BdnSLxztlYmR+FI8AOClWnMz0ktoWMhaQoIlBUzYmgX9g8vjCLYfauz0J+
         G2Tf6vM+75rx3/bL78DhRDLatPlqcWCx7eHlJkcIEn/NcbxPC3DPIA6sL1VsZd1HKibZ
         8tfg==
X-Gm-Message-State: AOJu0Ywaacd7wjjTcGJViAHli7OhR1pUdo8Mq35y+CsNiE942dJ8+UqW
	Ilk1MFNzLeqTBalKu4/Tsv8R5BsHvKJWjefy9SWFU+dO90IqaEJtlj5cxACZss+hydf9isCvQYv
	FmqbBXVB4bJWj/4xbII1BqA0+bxrF6t5LhUJD9tYXPbEWlYFQz9zT1Sa2X7oFTf4PYxK46mcc12
	Eqyln0lTMThcWiziiAe5sXEFYx0Y7xfw==
X-Google-Smtp-Source: AGHT+IFkRHFzfELswznyWLkr4CvOF50Fe853eqdKU+2tOajHyQGbMjOvGvY8FOB3foL9HdzwA1/E0NRu
X-Received: from ede13.prod.google.com ([2002:a05:6402:20cd:b0:62f:48cb:a0])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:35d2:b0:62f:48e3:2224
 with SMTP id 4fb4d7f45d1cf-62f8444146amr4820234a12.20.1758191440174; Thu, 18
 Sep 2025 03:30:40 -0700 (PDT)
Date: Thu, 18 Sep 2025 12:30:16 +0200
In-Reply-To: <20250918103010.2973462-10-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250918103010.2973462-10-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5359; i=ardb@kernel.org;
 h=from:subject; bh=mQrrF+d2zLkSHcwIimPMiS9vJSwzrw0LbijljjwZNyA=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIeP0feskWV6NoLork+f7ttzccMu/xfTijM+qp5L37fx7L
 rrsZPPWjlIWBjEuBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjAR6S5Ghjf1zQcPLCm9mPG4
 XmWlicr89ZPmXw4q2rlK0pD7h3rpndeMDDu3TlBgWrWp4PP1q2p6bawHWIpTpvF1rme6ynCree+ a1TwA
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250918103010.2973462-15-ardb+git@google.com>
Subject: [PATCH v3 5/8] arm64/fpsimd: Drop special handling for EFI runtime services
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Now that the use of kernel mode FP/SIMD is generally permitted when IRQs
are disabled, the only purpose served by the EFI-specific fallback code
in fpsimd.c is the case where an EFI call occurs from hardirq or NMI
context. No such cases are known to occur in practice, and it is
doubtful whether calling into the EFI firmware for any reason under such
conditions would be a good idea to begin with.

So disallow EFI runtime services in such cases. This means all the
fallback code can be dropped.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/fpsimd.h |   4 -
 arch/arm64/kernel/efi.c         |   8 +-
 arch/arm64/kernel/fpsimd.c      | 121 --------------------
 3 files changed, 6 insertions(+), 127 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index b8cf0ea43cc0..139ee1393730 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -458,10 +458,6 @@ static inline size_t sme_state_size(struct task_struct const *task)
 
 #endif /* ! CONFIG_ARM64_SME */
 
-/* For use by EFI runtime services calls only */
-extern void __efi_fpsimd_begin(void);
-extern void __efi_fpsimd_end(void);
-
 #endif
 
 #endif
diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 9b03f3d77a25..0d52414415f3 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -14,6 +14,7 @@
 #include <linux/vmalloc.h>
 
 #include <asm/efi.h>
+#include <asm/simd.h>
 #include <asm/stacktrace.h>
 #include <asm/vmap_stack.h>
 
@@ -169,15 +170,18 @@ static DEFINE_RAW_SPINLOCK(efi_rt_lock);
 
 bool arch_efi_call_virt_setup(void)
 {
+	if (!may_use_simd())
+		return false;
+
 	efi_virtmap_load();
 	raw_spin_lock(&efi_rt_lock);
-	__efi_fpsimd_begin();
+	kernel_neon_begin();
 	return true;
 }
 
 void arch_efi_call_virt_teardown(void)
 {
-	__efi_fpsimd_end();
+	kernel_neon_end();
 	raw_spin_unlock(&efi_rt_lock);
 	efi_virtmap_unload();
 }
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 96a226316d1f..e543dd569bd7 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1907,127 +1907,6 @@ void kernel_neon_end(void)
 		clear_thread_flag(TIF_KERNEL_FPSTATE);
 }
 EXPORT_SYMBOL_GPL(kernel_neon_end);
-
-#ifdef CONFIG_EFI
-
-static struct user_fpsimd_state efi_fpsimd_state;
-static bool efi_fpsimd_state_used;
-static bool efi_sve_state_used;
-static bool efi_sm_state;
-
-/*
- * EFI runtime services support functions
- *
- * The ABI for EFI runtime services allows EFI to use FPSIMD during the call.
- * This means that for EFI (and only for EFI), we have to assume that FPSIMD
- * is always used rather than being an optional accelerator.
- *
- * These functions provide the necessary support for ensuring FPSIMD
- * save/restore in the contexts from which EFI is used.
- *
- * Do not use them for any other purpose -- if tempted to do so, you are
- * either doing something wrong or you need to propose some refactoring.
- */
-
-/*
- * __efi_fpsimd_begin(): prepare FPSIMD for making an EFI runtime services call
- */
-void __efi_fpsimd_begin(void)
-{
-	if (!system_supports_fpsimd())
-		return;
-
-	WARN_ON(preemptible());
-
-	if (may_use_simd()) {
-		kernel_neon_begin();
-	} else {
-		/*
-		 * If !efi_sve_state, SVE can't be in use yet and doesn't need
-		 * preserving:
-		 */
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
-	}
-}
-
-/*
- * __efi_fpsimd_end(): clean up FPSIMD after an EFI runtime services call
- */
-void __efi_fpsimd_end(void)
-{
-	if (!system_supports_fpsimd())
-		return;
-
-	if (!efi_fpsimd_state_used) {
-		kernel_neon_end();
-	} else {
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
-	}
-}
-
-#endif /* CONFIG_EFI */
-
 #endif /* CONFIG_KERNEL_MODE_NEON */
 
 #ifdef CONFIG_CPU_PM
-- 
2.51.0.384.g4c02a37b29-goog


