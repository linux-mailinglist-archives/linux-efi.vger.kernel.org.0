Return-Path: <linux-efi+bounces-4856-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C566B841E9
	for <lists+linux-efi@lfdr.de>; Thu, 18 Sep 2025 12:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D2DF720A20
	for <lists+linux-efi@lfdr.de>; Thu, 18 Sep 2025 10:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C3B30499B;
	Thu, 18 Sep 2025 10:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VcndOKmT"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA273303A24
	for <linux-efi@vger.kernel.org>; Thu, 18 Sep 2025 10:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191444; cv=none; b=Fd1PfOkMyIrw5dGDy19eZ/oDuOEct/wW6WjIxbo1CnI+fmOGWdGpawZh8TcbW7rKsHqW1uXvcqkF2u2t7ketBpRSTDzTxiyQ135j9ZvKyGsK+/CG1Sl6a5DEMllYxuTocIxW6FpPqZBOXahJZReRjUvw0DVSTD+GKNwhK/MRJVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191444; c=relaxed/simple;
	bh=o/hZvudtfRK4rr9zuVg3PqxrxE8wP3rPGUNeDSxyO5E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Gf5YbwsXN2ApLMM5RCpEF8IsglAqzpL9YGHKug5punqbAjWrhnWbzqmF2LEN7K2ZGwxcEj0UoGwCGoF5BavZUmrVdYFo17sAcaIujs4PQV8NjFPbox8GvTY/yBqfk3JpuIFva8tQTuKZNGcmrmPdQhzkim7cuMNzYUDyOd3Pdcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VcndOKmT; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b07c9056963so70940366b.2
        for <linux-efi@vger.kernel.org>; Thu, 18 Sep 2025 03:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758191441; x=1758796241; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MNHqAVLlhLv5W0htkEcz0OII/0HvpQvRWJKki7ay4x4=;
        b=VcndOKmTVE2w4LxGmEVmEvb9ZcpHUiWi2vNoUenb5xuE1D7Cxgrjpo9hNr1NaJdOkD
         AtVsKa/2OGZwD+7SUXQC4rNw4hcjWO7oXQBtUIdNHhtDK0mLllLFVrTt+rJWAeVaINqw
         8TQWJL6LqSkobDwX/84eFyCVGYpYxpNaxJ4wGO22ASUbM5SBqSyFj9hw0KMtAmC4ZX5D
         NeRbmLoCJpFkCFxb1d3xbeLcs9Ffiiu0i9P55Ww7SY9NyHI80zAaQftxzNnZoiInbamX
         8IcuTwEv0NtJS/Wb3wE/D/GmmdvH03ak7VOQliY6mYSF9p5LBLV5vjsIxB6fISOIFlP1
         e3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758191441; x=1758796241;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MNHqAVLlhLv5W0htkEcz0OII/0HvpQvRWJKki7ay4x4=;
        b=B12tQkamcQhAqVP0yttm28dASE33QEWxCFOJohLkeZ4iaKLHyQKvULJs+jVD2iRqgj
         BdhwQmj949bz6mWqPDcLXD6xIioTJc3DyiK2ddgxvLCQZP2b/oChP/2fz+IPSPWAzC5b
         4vTpsLsxRRtMcbeLItDCVfKMvwAIc3+svNQ3tt7mk15GxoiF8LcD1li5WBPTQTsfUWt6
         sZNkIOFFq00PHKV2RPEO33e7e4AF1NTr3HxuSMcbUdNRYTfhhHbrnxtdjjMc4Thl5Gv3
         r2EUqam5IMWENeTP1qqVqyGOScUl7a7ig2MTn5+o/LqIDGew/9gwyMZL7OyggwbLD3Mk
         dQmA==
X-Gm-Message-State: AOJu0YyuYYwaqELY3bFXBuxJe/3IHzd4qkeDm2Tu1X3m3MAsCisnr3DW
	0hHvefRTAn372BNCMr9DRnQskJ3XZBt0lIMtFpIw8le0GfqAtS+FMi/AyxRXcbYZDtbmrsyyCfy
	4FT0Rpf7Db8oQmws1UdqILpdTFrkr6yGo0XgwpqyXGq+z1IQxuu5pKGpj9dbMzgIlH7J+dUAYEj
	rbFVmxjAhOWBLeJsLerzai/qvKdYGj1A==
X-Google-Smtp-Source: AGHT+IFgHxWIDqP1JG9dsjSf5woDKGTvu3LMMfMFqln2zd5f55mk3oKmQw/5olbKzpy9I1HA/uIxbJPg
X-Received: from edbio10.prod.google.com ([2002:a05:6402:218a:b0:62f:4a87:a86b])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:4788:b0:b0f:a22a:4c60
 with SMTP id a640c23a62f3a-b1bb17c8ca5mr633978966b.11.1758191441397; Thu, 18
 Sep 2025 03:30:41 -0700 (PDT)
Date: Thu, 18 Sep 2025 12:30:17 +0200
In-Reply-To: <20250918103010.2973462-10-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250918103010.2973462-10-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1447; i=ardb@kernel.org;
 h=from:subject; bh=CzllZySlu7Zzk+9rgGtZjOjjeEN/aeVWkoZifxpGWQo=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIeP0fZur/x7YPo49KfFPamHLRgWB3fKCD7LceAUfLt13j
 mFqzDSujhIWBjEuBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjARp3cMX8U+BHJpr9zO6v9t
 xoPLDTu/XVfqvcBlKTTHQzN893PmFob/pTUOLdXPImb8152s75qsuTMpV8O3NPLvZo3OTz2Tkw6 xAgA=
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250918103010.2973462-16-ardb+git@google.com>
Subject: [PATCH v3 6/8] arm64/efi: Use a mutex to protect the EFI stack and
 FP/SIMD state
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Replace the spinlock in the arm64 glue code with a mutex, so that
the CPU can preempted while running the EFI runtime service.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/efi.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 0d52414415f3..4372fafde8e9 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -166,15 +166,22 @@ asmlinkage efi_status_t efi_handle_corrupted_x18(efi_status_t s, const char *f)
 	return s;
 }
 
-static DEFINE_RAW_SPINLOCK(efi_rt_lock);
+static DEFINE_MUTEX(efi_rt_lock);
 
 bool arch_efi_call_virt_setup(void)
 {
 	if (!may_use_simd())
 		return false;
 
+	/*
+	 * This might be called from a non-sleepable context so try to take the
+	 * lock but don't block on it. This should never fail in practice, as
+	 * all EFI runtime calls are serialized under the efi_runtime_lock.
+	 */
+	if (WARN_ON(!mutex_trylock(&efi_rt_lock)))
+		return false;
+
 	efi_virtmap_load();
-	raw_spin_lock(&efi_rt_lock);
 	kernel_neon_begin();
 	return true;
 }
@@ -182,8 +189,8 @@ bool arch_efi_call_virt_setup(void)
 void arch_efi_call_virt_teardown(void)
 {
 	kernel_neon_end();
-	raw_spin_unlock(&efi_rt_lock);
 	efi_virtmap_unload();
+	mutex_unlock(&efi_rt_lock);
 }
 
 asmlinkage u64 *efi_rt_stack_top __ro_after_init;
-- 
2.51.0.384.g4c02a37b29-goog


