Return-Path: <linux-efi+bounces-4857-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22779B841F2
	for <lists+linux-efi@lfdr.de>; Thu, 18 Sep 2025 12:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C04F5445D7
	for <lists+linux-efi@lfdr.de>; Thu, 18 Sep 2025 10:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AA0305062;
	Thu, 18 Sep 2025 10:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XJ8Q/tMi"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DD63043BF
	for <linux-efi@vger.kernel.org>; Thu, 18 Sep 2025 10:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191446; cv=none; b=MJODAyhhqSbd8qzb8sOkCayPVCK+WNMJzipNEHsmhwzUSoF8VZNa5TCxY3CdhduhE2rc7/vBBEmk8xW5SHYa8+GOn0BISX3NKXsu2kGwanUo5sENAghM9+fVAjiLGhaa6Ba6vSQMRULAm1uF0L+qWn9k6atOYPlAps4fULlAKmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191446; c=relaxed/simple;
	bh=Wiezk90EeDViSxUviUNtzZTTt45XUjxOpMdjJkjt7Z4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PL2kxaZsqu6rG+98NpxbW0KNUcOYll1Rkhltf3EsH3IoThW8QvGQ8HQkG8jlJBVeUct8dCN/YphB8DSua66gtTypyQTqYE0DJ3TLPXvoMyjSKyOJycBTgOdLjyEUp+Kk9QbiI2b8Y6XMKdBUHzG+s7qlFdOuCbBBmJQdfHpV3sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XJ8Q/tMi; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45b98de0e34so7888325e9.0
        for <linux-efi@vger.kernel.org>; Thu, 18 Sep 2025 03:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758191442; x=1758796242; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DksqsAvPlifD5AcgvqzgUC2XrqtgGq1Wq0QfB7rSyJ4=;
        b=XJ8Q/tMiEhlkN/DJEBgAZ2myIg+tTe7qKrfvcYeNXDyxdlTfygneoyw85ck6lAq9uR
         ydy6ojoGz65v6uGdQVu+/dQSAYUMNeHcu0tpQMAeXX8r3zW/FZ6G0Q4tv8gPWwRH4xKY
         +QFbEKHOJG3igKrxfZ4jer/Px/NxCs3U8yMbS0pwWf05FeLSbk7RVsrx0HXm+tM71YXx
         vU5Um3n2jPqQA2/xMR8YYiMJCD51Pm2uidepPqSO7WFGRHsjYmIpuQcMaQGS7qPxcDYf
         ibhGQDyil3cDFNswcYlDpkoJ5xAXkD/WzgUj6bmQd1aTbC0k7jp4rk50mOJQfyVVecRZ
         322Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758191442; x=1758796242;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DksqsAvPlifD5AcgvqzgUC2XrqtgGq1Wq0QfB7rSyJ4=;
        b=QECL2z3ZB2dvHqs3JTy+q0EELaOTpsP2GZnRLG9FkkzpYeLeRfeMePxYvqAZg44OJZ
         1cSFVoWxodhjWEaU4hEX8sr+pw4KDIjnvF7GN5jJe1hnTIebVqt0ZoGgGnblqh9JGbYl
         MEbO2kn+WOGvyERHG7KprT2/zV+6tpM57ab8K6WCNFMAsGUeAinmPIsuu90LM2Eod14O
         QvbKvrxuF0FVXm0mh/rAiJMf+usxY8V/PPIWqqAhDsgfTt76bj6UrIZx9DvLXKVi3274
         sdDNBpgQcHM72m+5i6WXoYmR+0yc/ajTxA0L/W1BZpj2UON7WltaxaomMb+QOLpa8O08
         Ts7Q==
X-Gm-Message-State: AOJu0YxSvE1GyHUjGw3X7nUjDzr1q1Omv3123gCU20Rr0eDDGfHaUcp4
	dpusGyCT5fkbzkiMvS+NYCjdiBkcO9P21GZgHe9jRgG7KlAIx1+EGbR/rzQaUX+X+qPRrrDZ8Rj
	r1RhyWuIWNRxxgASpV62t8G2OBJ471CAPKM8QfZXXYcJ6cyyJ5OiUAHwGSdCEiNOAC4BmQInMP7
	/SQEen2aTAPhyq3glTm4ci9VGk6hFdMA==
X-Google-Smtp-Source: AGHT+IFUmBh+5gegFiYMOlzv62Mjx0w8SlOm74pqvtSIgATSsKH7e5irJfmo4m3CeekRPpIfN+2PS0jf
X-Received: from wrbdn3.prod.google.com ([2002:a05:6000:c03:b0:3e7:6748:fa54])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:5d86:0:b0:3ec:ce37:3a6d
 with SMTP id ffacd0b85a97d-3ecdfa2ae03mr4664506f8f.47.1758191442249; Thu, 18
 Sep 2025 03:30:42 -0700 (PDT)
Date: Thu, 18 Sep 2025 12:30:18 +0200
In-Reply-To: <20250918103010.2973462-10-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250918103010.2973462-10-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2694; i=ardb@kernel.org;
 h=from:subject; bh=xrwXhuc4FPqL3CCntBsstjQDywcZZ1Gih2rwsqKYefE=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIeP0fTvNvTP51tUVfbQO9um+s2tq1D8Lxal183K23BS8W
 OS76NDVjlIWBjEuBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCR5XwM/4yCL/hXm09o4V71
 pFPRwNjmMcvy2bvZFx2+zTFhrsFOwwuMDNdiUvbEfrd6uzYhzjug5+//uNlJCrzPww5vSfdiK1X VZgQA
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250918103010.2973462-17-ardb+git@google.com>
Subject: [PATCH v3 7/8] arm64/efi: Move uaccess en/disable out of efi_set_pgd()
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

efi_set_pgd() will no longer be called when invoking EFI runtime
services via the efi_rts_wq work queue, but the uaccess en/disable are
still needed when using PAN emulation using TTBR0 switching. So move
these into the callers.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/efi.h | 13 +++----------
 arch/arm64/kernel/efi.c      | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index decf87777f57..09650b2e15af 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -126,21 +126,14 @@ static inline void efi_set_pgd(struct mm_struct *mm)
 		if (mm != current->active_mm) {
 			/*
 			 * Update the current thread's saved ttbr0 since it is
-			 * restored as part of a return from exception. Enable
-			 * access to the valid TTBR0_EL1 and invoke the errata
-			 * workaround directly since there is no return from
-			 * exception when invoking the EFI run-time services.
+			 * restored as part of a return from exception.
 			 */
 			update_saved_ttbr0(current, mm);
-			uaccess_ttbr0_enable();
-			post_ttbr_update_workaround();
 		} else {
 			/*
-			 * Defer the switch to the current thread's TTBR0_EL1
-			 * until uaccess_enable(). Restore the current
-			 * thread's saved ttbr0 corresponding to its active_mm
+			 * Restore the current thread's saved ttbr0
+			 * corresponding to its active_mm
 			 */
-			uaccess_ttbr0_disable();
 			update_saved_ttbr0(current, current->active_mm);
 		}
 	}
diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 4372fafde8e9..a60444dcec68 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -182,6 +182,15 @@ bool arch_efi_call_virt_setup(void)
 		return false;
 
 	efi_virtmap_load();
+
+	/*
+	 * Enable access to the valid TTBR0_EL1 and invoke the errata
+	 * workaround directly since there is no return from exception when
+	 * invoking the EFI run-time services.
+	 */
+	uaccess_ttbr0_enable();
+	post_ttbr_update_workaround();
+
 	kernel_neon_begin();
 	return true;
 }
@@ -189,6 +198,15 @@ bool arch_efi_call_virt_setup(void)
 void arch_efi_call_virt_teardown(void)
 {
 	kernel_neon_end();
+
+	/*
+	 * Defer the switch to the current thread's TTBR0_EL1 until
+	 * uaccess_enable(). Do so before efi_virtmap_unload() updates the
+	 * saved TTBR0 value, so the userland page tables are not activated
+	 * inadvertently over the back of an exception.
+	 */
+	uaccess_ttbr0_disable();
+
 	efi_virtmap_unload();
 	mutex_unlock(&efi_rt_lock);
 }
-- 
2.51.0.384.g4c02a37b29-goog


