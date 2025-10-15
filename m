Return-Path: <linux-efi+bounces-5057-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F6BBE0BD9
	for <lists+linux-efi@lfdr.de>; Wed, 15 Oct 2025 23:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BC5A73582A9
	for <lists+linux-efi@lfdr.de>; Wed, 15 Oct 2025 21:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D352FFDF2;
	Wed, 15 Oct 2025 21:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TvReFQcv"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE452E2DFE
	for <linux-efi@vger.kernel.org>; Wed, 15 Oct 2025 21:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760562069; cv=none; b=AAd5Rp8v7QLitzxyN4RJxEY1hRHsugTNet5y4D9WweoCh9IQeuso4D0oe6dwcBXW6HOzVqt94GVqwEODsrs5+UP1QNwLIeDz7lhBI6Vu+mSw6T9U53pvQ/yza0IgiRf3S8xq9N3ObQuvJQcqBTwFMFm3+MMnO6KOPyj7EjmSHgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760562069; c=relaxed/simple;
	bh=plTDTpax7UhabJ3R97rpcaBJybZ/LXy6TKvHDYaOW40=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ciXhrv1RJSnLtrs58rY2H/RRu0gHtOCrG5KRIYCDA8SOgnQH9nn2xk5VT0XIg+gXYWmbxwVcd4DuVntHAG9oMqtCbKM3Ak5vx+q7V2m3Qf5h3vXAkXS5ZAiRwxyE4oYTjqp1C7GAxdg1fiEefdRvfavnDpIEniArjQjOzlX7AP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TvReFQcv; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3f384f10762so20245f8f.3
        for <linux-efi@vger.kernel.org>; Wed, 15 Oct 2025 14:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760562066; x=1761166866; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=19SuM8BkFU86AdrsVL9he5wmDJI8XYP735e24p7BzJE=;
        b=TvReFQcv9UcVKJ/bi0wglPCLAysT/jYaBlHwhTAsOzCC5Eq24laULjnH1nnhzfHmEi
         3/xyMBNmBnwWaC7p7zqb//0iUaYBZvIhT6bNHCPhDNIzvN131dHx8lLEirnZ8/mFn/AW
         V0wJzCex3YdTCMtcMNY4bm+2ZVrMLV5iwyAMkAjPalCDEwOqrZanJP+/MexLEFF8Khf9
         jr53L8a9bheX7/LOMMP7M4ua7I7mxP9w45xyi9BVJXITfxXrxplwem+Oy8MKKJBVm0ph
         w6/Yu4gSopLjGxJ9DWUJ4FR5OMOcWCutmERTw/Yri+MEPuCR/LQBEc8koN+d1mxfcv2G
         S2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760562066; x=1761166866;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=19SuM8BkFU86AdrsVL9he5wmDJI8XYP735e24p7BzJE=;
        b=DV0i1G9td7FSkKGboKbU9MAzml8yffzdnEYGfKdK2kCfJ6RkJhTLBFKFG7vEDEzN/z
         ygFGxYimUnmDQiRuc2I6FQ6O6k+6CZ1iiovzyl2XizLrHwfMTXyCAsAJJw0J4dZ1Xf30
         cjZ6XMd+3ve8Q3M3u4dY09jGRY0ELpo+jRN5rnajhrs4anzFTpsPVu6aq88U/IX7WRgO
         e3hfJ0fuyUuFqsjG6BSsC+cpDrbeUkCk2PnXg/7RW9DbM3ca6xNiHexHV3Drp+ij5GCL
         VW6fM9w+eCwvDITEJwRBzJIK8SNo6l4Ji/mAu8o1El4lhyhAKiTKYbZP3CvZDUeGy3ah
         cKvg==
X-Gm-Message-State: AOJu0Yw4h4ypaCW3OtqkjCXrq/dsy8yc3BijjSVAea+Do5ZDBS/eeQ4l
	L58YmVBb8E88lPt/QUxlFNOyt6fQGZqoK4QPJ2GOZyMNv15Wcp6FPJaGKM6mFcmONgLAx+mOjJU
	eGRv5VvkTqYaPxs2vtJLkQNZ/KiMxvchbIxLo3rQ44viRgbRrDn1O66TCZmMkqVv2Dscg09Rpt1
	SfZU7Kp6iTAQMga8RZlXuptSgxONcAhg==
X-Google-Smtp-Source: AGHT+IFQpVg2U3+T4NvaCVGg+3jjnpHjurMn96RVhjpcDm7JJIbQd5n2ckQZklYZZG14FZbDn1HXPBda
X-Received: from wmbjn22.prod.google.com ([2002:a05:600c:6b16:b0:46f:aa50:d718])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:1a8b:b0:425:8bd1:fbb4
 with SMTP id ffacd0b85a97d-4266e7df95cmr20229304f8f.50.1760562065972; Wed, 15
 Oct 2025 14:01:05 -0700 (PDT)
Date: Wed, 15 Oct 2025 22:56:39 +0200
In-Reply-To: <20251015205634.3820870-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251015205634.3820870-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3253; i=ardb@kernel.org;
 h=from:subject; bh=FjAcGhb6VYi+vJfe2JpmxvHhAqT8SyzVHt/xzyd0TNw=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIeMDV8ejrsz6he2dwTNnrNr5LD+tP1yqof/ebabW69esX
 2+PX2/SUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACaSYsHw369KU8vDXsfq9TfP
 xX7nJbPk247V5Kkv/vbC8eOWHEUvJUaGa8++1bypTZXk3J6btGcxy4fcT2o31pZyl61w259wpsW RBwA=
X-Mailer: git-send-email 2.51.0.869.ge66316f041-goog
Message-ID: <20251015205634.3820870-13-ardb+git@google.com>
Subject: [PATCH v4 resend 4/7] arm64/fpsimd: Permit kernel mode NEON with IRQs off
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
	Pierre Gondois <Pierre.Gondois@arm.com>, Sami Mujawar <Sami.Mujawar@arm.com>
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

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/simd.h |  2 +-
 arch/arm64/kernel/fpsimd.c    | 25 +++++++++++++++-----
 2 files changed, 20 insertions(+), 7 deletions(-)

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
index 3d848c89604e..6d956ed23bd2 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -225,10 +225,21 @@ static void fpsimd_bind_task_to_cpu(void);
  */
 static void get_cpu_fpsimd_context(void)
 {
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
-		local_bh_disable();
-	else
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		/*
+		 * The softirq subsystem lacks a true unmask/mask API, and
+		 * re-enabling softirq processing using local_bh_enable() will
+		 * not only unmask softirqs, it will also result in immediate
+		 * delivery of any pending softirqs.
+		 * This is undesirable when running with IRQs disabled, but in
+		 * that case, there is no need to mask softirqs in the first
+		 * place, so only bother doing so when IRQs are enabled.
+		 */
+		if (!irqs_disabled())
+			local_bh_disable();
+	} else {
 		preempt_disable();
+	}
 }
 
 /*
@@ -240,10 +251,12 @@ static void get_cpu_fpsimd_context(void)
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
2.51.0.869.ge66316f041-goog


