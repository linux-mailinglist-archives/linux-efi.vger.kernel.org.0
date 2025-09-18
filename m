Return-Path: <linux-efi+bounces-4854-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 034A5B841DC
	for <lists+linux-efi@lfdr.de>; Thu, 18 Sep 2025 12:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9C401C82DCC
	for <lists+linux-efi@lfdr.de>; Thu, 18 Sep 2025 10:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1DA303A1D;
	Thu, 18 Sep 2025 10:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zJwpeDh+"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F03302178
	for <linux-efi@vger.kernel.org>; Thu, 18 Sep 2025 10:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191442; cv=none; b=A3uRlhPwRQ/QkgVMu4MYrM2NFoGafeAnDe4yQyvezxzCVLxQC5gphFMy8o7B0EMwspz+suXYHfCLMuGcOdfQn6HfOmUxrP5M93V8FOKek+ep9WPtcllzr0CKce6fwgGOPIxAcZ54QNct08jbVAyBGp88jgK4twq+ujOFsl/vtrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191442; c=relaxed/simple;
	bh=zGTDavJNAxx18PM4b7p0B2MVa9hlUct/kDb6lm3LiYk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gSer3f9ync0FdtB2M+5pho5vwAT2SDl1MruB3r3k3anCycfsYKjHLsTE1NMmhVAiYUVItvrR+izSeiKwxB30McENJIBCHjVVSI5ge8Y9qKRFN6q+8Kz+0LMfs4Sj7TO0F5Xu400QkiqmEzYZJsUISCvLOaR8gtNtXt8tRkZ3Bdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zJwpeDh+; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45f29c99f99so4709495e9.1
        for <linux-efi@vger.kernel.org>; Thu, 18 Sep 2025 03:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758191439; x=1758796239; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NR5f/DGegjp210rMbwdyPD4vKBD/9uV5LYcxqzD4mrs=;
        b=zJwpeDh+vd2H0HViwA6EU7s516fu+i1A8Bx1gWMET9UYMGYG+KKhOjYlHSS0Y7CD4p
         hp/Q6Lc6hF2d31Sxy01G+7QGJZCovy4gTjSKmwVigMUBcDMwyL+mKPzDnZnMBWYCVWGs
         hlN8jgbFq4wtiwa4Tbvo01F8KGAu2evkCjklfUmJRn0mBpqsEawpFSLycbeF7hXvJGnr
         BgFfofOggOOZ5EvCsPUFrlHAaxJGvK11uzfsqs0kQxmDoNs/ZMxaO+o48+n5+fK13JEg
         2Bm1iTk+m+sD6z508IQc/fvzcLHDX6FsWBDQPhpixKadrLZt2MIa8OvGhYGvuTimiwlI
         pPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758191439; x=1758796239;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NR5f/DGegjp210rMbwdyPD4vKBD/9uV5LYcxqzD4mrs=;
        b=IlLldzu0B29xgS6+iP1FdBTfvR3iwBpAbcZlOi0/SlDko+qQm7FR+8xdszYx8LwOtW
         jriYvNKdCegs5u5EaH11BZAN97yo8Ui6A56eqlSc0tHQaxS7dx9xVUc8+/UsosNGignt
         CNkoGy9EEPlfW24Gg6ATOYt6oJoVuWwTh1Z+nJznpBF9sGcn5w2pOZMlQxUTzEMLbG7c
         wHA98zjFQK60bbW7pMSu4ukh8JkAuf2OybqKVRTlUB4Y/po0OVgH3gbemmoIl0ciXjTX
         dWrIFFG/rFYVMwdoJwVGnJgH397ypmkzxMMAVTTRu1yXkkIBB+7a3XrVc2kL2bfp9V5r
         Kspw==
X-Gm-Message-State: AOJu0YyQK7LYfEUnhN9vAHYqHUDGLBlP7ICUndnqlI3A/SBaOo8eZdNx
	q/onELaRWT0TSWSfzV4llnt7PvJPD0Sj8+cEptfyHFgsxVGL4GWL+LV8K5T/lRJuM3kSsLJnSAR
	XgowlYHolJT56SvmFS04ZdnkOgXWOleZRi8RUT1G6IJpEv0PY4F2XHi/tLh/MSwSzmkb5M6Yw9d
	vvP5Tj0Rew+6dEqReVVTVwgmh9Jz0SRw==
X-Google-Smtp-Source: AGHT+IGJRDEcVjOSC0x4VhiypKhaeygXXwL8oEycCf0lebIDZdWUzxAElbwqtEPvM8D7TYbl26IgU59P
X-Received: from wmbjg15.prod.google.com ([2002:a05:600c:a00f:b0:459:dac7:4ea6])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1e8c:b0:456:29da:bb25
 with SMTP id 5b1f17b1804b1-46205adf58emr50900465e9.19.1758191438954; Thu, 18
 Sep 2025 03:30:38 -0700 (PDT)
Date: Thu, 18 Sep 2025 12:30:15 +0200
In-Reply-To: <20250918103010.2973462-10-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250918103010.2973462-10-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2763; i=ardb@kernel.org;
 h=from:subject; bh=poM+J5QCFnAX0KM+dokbbxbcB3uDup+BM3HzFyYLTNo=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIeP0fctrGjeLUg8v1i7zzZd+7yCZv9R4om+bjWA9q/VtS
 U81k6kdpSwMYlwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCIGOxgZvkYvit31ctcXe14r
 63MzuU/LONUXFV0L36zL3Lud60jtXYb/vtuX/9geGc6oe+3d/UeKUz5pz7ZcX2Rr8l/0zJoVV1d /4AEA
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250918103010.2973462-14-ardb+git@google.com>
Subject: [PATCH v3 4/8] arm64/fpsimd: Permit kernel mode NEON with IRQs off
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Currently, may_use_simd() will return false when called from a context
where IRQs are disabled. One notable case where this happens is when
calling the ResetSystem() EFI runtime service from the reboot/poweroff
code path. For this case alone, there is a substantial amount of FP/SIMD
support code to handle the corner case where a EFI runtime service is
invoked with IRQs disabled.

The only reason kernel mode SIMD is not allowed when IRQs are disabled
is that re-enabling softirqs in this case produces a noisy diagnostic
when lockdep is enabled. The warning is valid, in the sense that
delivering pending softirqs over the back of the call to
local_bh_enable() is problematic when IRQs are disabled.

While the API lacks a facility to simply mask and unmask softirqs
without triggering their delivery, disabling softirqs is not needed to
begin with when IRQs are disabled, given that softirqs are only every
taken asynchronously over the back of a hard IRQ.

So dis/enable softirq processing conditionally, based on whether IRQs
are enabled, and relax the check in may_use_simd().

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/simd.h |  2 +-
 arch/arm64/kernel/fpsimd.c    | 16 ++++++++++------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/simd.h b/arch/arm64/include/asm/simd.h
index 8e86c9e70e48..abd642c92f86 100644
--- a/arch/arm64/include/asm/simd.h
+++ b/arch/arm64/include/asm/simd.h
@@ -29,7 +29,7 @@ static __must_check inline bool may_use_simd(void)
 	 */
 	return !WARN_ON(!system_capabilities_finalized()) &&
 	       system_supports_fpsimd() &&
-	       !in_hardirq() && !irqs_disabled() && !in_nmi();
+	       !in_hardirq() && !in_nmi();
 }
 
 #else /* ! CONFIG_KERNEL_MODE_NEON */
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index c37f02d7194e..96a226316d1f 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -225,10 +225,12 @@ static void fpsimd_bind_task_to_cpu(void);
  */
 static void get_cpu_fpsimd_context(void)
 {
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
-		local_bh_disable();
-	else
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		if (!irqs_disabled())
+			local_bh_disable();
+	} else {
 		preempt_disable();
+	}
 }
 
 /*
@@ -240,10 +242,12 @@ static void get_cpu_fpsimd_context(void)
  */
 static void put_cpu_fpsimd_context(void)
 {
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
-		local_bh_enable();
-	else
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		if (!irqs_disabled())
+			local_bh_enable();
+	} else {
 		preempt_enable();
+	}
 }
 
 unsigned int task_get_vl(const struct task_struct *task, enum vec_type type)
-- 
2.51.0.384.g4c02a37b29-goog


