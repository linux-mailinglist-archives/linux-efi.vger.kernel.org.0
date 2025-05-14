Return-Path: <linux-efi+bounces-3705-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 869BCAB731D
	for <lists+linux-efi@lfdr.de>; Wed, 14 May 2025 19:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CCB91BA4DED
	for <lists+linux-efi@lfdr.de>; Wed, 14 May 2025 17:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE3A2882A7;
	Wed, 14 May 2025 17:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R11Q16tR"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABCE28541B
	for <linux-efi@vger.kernel.org>; Wed, 14 May 2025 17:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747244648; cv=none; b=d70TBFTVSpS1nJaebWtr3qrMguldac/9KvkgGCNLeCje2utoxXd0t/i4v0NCcbT1IK3xzbEQFQKOjOsrON+xggwzHxfDFGV62JZ15GBMRCUq9P75Ub/Ajpgp/8MuNPhrIhKCdNYq18vYS67SfVpD17ZMNTI0Wi1Uz/81r2XTQ9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747244648; c=relaxed/simple;
	bh=6bwhz9ZVsfJUN+XIkS14v/agbd7AKeEqEWWL1cLcs74=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LiCbxI778CAbHE1S2v3J4Oufp7P2GjkgnSmE8rOA4u8KQSLwaBwNVvQclb9+n0e/nQIOAEi3HDmqEXFtEKTyQU18uvSYFvn5Gzifxla6DXMrPYBrKdAOHgYN9ynCVBumMpD7uOOH18xCNSYZkPqw/FNtdqbv1C/1spEcV07AtiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R11Q16tR; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3a0b2e56da1so24281f8f.0
        for <linux-efi@vger.kernel.org>; Wed, 14 May 2025 10:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747244645; x=1747849445; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D5xC8ZFXHRFQPPNvAQ6eM6+yxFQwHsYqCLzJSlhA3po=;
        b=R11Q16tRVF/f6C8C+UmkpQbjMwlLYoDEl0r7sI5NgOfG5lBIbjwdlZW/mIAHipOw+Q
         a1S5WZcipPs3xripfEga35YR65LYy9y9ffk/K2OD2fUQ9XRgmlzqY5gMa92uy+eB5uur
         9oNPLOEV/FrkI1BiIteHMtANAg390STTxNRoTuNtM4lRxDtxbwPwHBWpTcHV4+RTL8De
         i5YbghCyyP0sih+YxpPn2VAsj7bNGX93PGp2jW8j89ChB9IXtlY/Xgwsi2hOIbLw+DhV
         PSxk2I5rK9oVwVXuj1pJfKc31Ha8Nb7x2IL/pOsFiSi7nFvDub5hxXRh08ISP0DEiSUl
         5/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747244645; x=1747849445;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D5xC8ZFXHRFQPPNvAQ6eM6+yxFQwHsYqCLzJSlhA3po=;
        b=OsdiLM7am58pvbg8gW3iYbknp6evlGRV87Q8m6NeL30bEleAYUSiAC0u0ZvANENKqU
         zt33AI+Dn6hh0uH2L3AxXz6VHivF/ALNPA6NfSDULgMC/WxdosHamEnDogL174SE6B3F
         VRhStcafMdynvnined+rNRcqCZkYDQblIy0SyLNrghPesE0gL2Rkp1shW0Y+Yh1iFOaT
         Uqo7cxPQIKZrTyPjuCCc+X+bS+Kxno/oDx89DbzEN7bazHbmy2pKvJlLAV4q5v8MDq8h
         8VkHGJfoKxHKOHAWO4K3r7wD4LR6Dm4UX3xGusINrc9pPmb5cy15rdhlwn923x2bUFDz
         S4Jg==
X-Gm-Message-State: AOJu0YwX4tpXA+0hCYwyH1+AIBcn45CIpr6+vjXB0kBE5pjufRW2J/0F
	YiPNm4MG/D7m24kxajZ3PtfqmYxB5bBw52ZW6lbiFdST7Azf9BfG7dlJIzo1LQ5aqjkXb20xDxl
	3ZJYXxdOM7P83SrVP2fEAel+yuvJm2To5iBekXtKxTSeHlnb9RD2m9/T47NBNGTuBbuyBSFUTRt
	G+XoPXRYvGBzi5EGgGYaSZPJdoSw==
X-Google-Smtp-Source: AGHT+IFCeHUHZ8o9ekV/c+77/nX9iPRwbsYxu0u1T1i997Dl2Av4gPqLXFQx3wbBFDsMJ1AUDDf7weNp
X-Received: from wrbgx8.prod.google.com ([2002:a05:6000:4708:b0:390:e710:324a])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2284:b0:3a0:b448:e654
 with SMTP id ffacd0b85a97d-3a349927550mr4086391f8f.47.1747244645140; Wed, 14
 May 2025 10:44:05 -0700 (PDT)
Date: Wed, 14 May 2025 19:43:45 +0200
In-Reply-To: <20250514174339.1834871-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250514174339.1834871-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1405; i=ardb@kernel.org;
 h=from:subject; bh=TxFz/hG01vyA1ZDzUGKKYj1NGAs9wXcTsurQl3x2mv4=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPlWqiwsrlNUoHqW/v7Ui9uq92Lzc5f1aDO/jh5Sb1fx
 6+z3kc6SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwEQCvjEyHOi68Gim9dW3Bd76
 sn/tflxf2yIwn0XwqEn4l55ZF47WMDMy3GvUDTDOz7l4UdB6wdp1hx8qN+Q/kzllfp9vf+e51Ef fGAE=
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250514174339.1834871-14-ardb+git@google.com>
Subject: [RFC PATCH 5/7] arm64/efi: Use a semaphore to protect the EFI stack
 and FP/SIMD state
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Replace the spinlock in the arm64 glue code with a semaphore, so that
the CPU can preempted while running the EFI runtime service.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/efi.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 44ad5e759af4..d01ae156bb63 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -164,12 +164,19 @@ asmlinkage efi_status_t efi_handle_corrupted_x18(efi_status_t s, const char *f)
 	return s;
 }
 
-static DEFINE_RAW_SPINLOCK(efi_rt_lock);
+static DEFINE_SEMAPHORE(efi_rt_lock, 1);
 
 bool arch_efi_call_virt_setup(void)
 {
+	/*
+	 * This might be called from a non-sleepable context so try to take the
+	 * lock but don't block on it. This should never occur in practice, as
+	 * all EFI runtime calls are serialized under the efi_runtime_lock.
+	 */
+	if (WARN_ON(down_trylock(&efi_rt_lock)))
+		return false;
+
 	efi_virtmap_load();
-	raw_spin_lock(&efi_rt_lock);
 	__efi_fpsimd_begin();
 	return true;
 }
@@ -177,8 +184,8 @@ bool arch_efi_call_virt_setup(void)
 void arch_efi_call_virt_teardown(void)
 {
 	__efi_fpsimd_end();
-	raw_spin_unlock(&efi_rt_lock);
 	efi_virtmap_unload();
+	up(&efi_rt_lock);
 }
 
 asmlinkage u64 *efi_rt_stack_top __ro_after_init;
-- 
2.49.0.1101.gccaa498523-goog


