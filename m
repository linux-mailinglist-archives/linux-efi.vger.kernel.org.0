Return-Path: <linux-efi+bounces-4699-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4EFB4590F
	for <lists+linux-efi@lfdr.de>; Fri,  5 Sep 2025 15:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 876D2581A4F
	for <lists+linux-efi@lfdr.de>; Fri,  5 Sep 2025 13:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1953D987;
	Fri,  5 Sep 2025 13:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UrVp63zm"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CD23568ED
	for <linux-efi@vger.kernel.org>; Fri,  5 Sep 2025 13:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757079055; cv=none; b=O33Q+vjMaXtiTT7L83vnokoKwiSx3Xf0x4wgUtSgbbbd9+p1/2KCvEaI6hxbwqWHgCfgULludpZASQt7Qt7qNysyU1YDfu4cIZE1pygCu5fixwecTqn0PF0FNyczkgo+lPey3EZA867NtA5cyxZxSWy2b0vgdVi5a+QgXcHB1PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757079055; c=relaxed/simple;
	bh=dSZsAM8dQkdzxBR5dzeF0mi5iq6iad7XREh2ikihpVI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GfFcaQ8EVTvo6STYhb7nKlFfwbpVo1zmZ5EYouJ5rECqD7f73iOYsNd6ryjIWjVC2oM4q9GgVpHOb9AHU/ZgaCWXhvGP+jrqQjiRvyFwathTU01GUw5RMNHU8Q8jkSfPuazFu6poLS5bLwff5wkG+eGKxZWgORa+Pf3T88Zsv4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UrVp63zm; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45dd9a66cfbso10347615e9.1
        for <linux-efi@vger.kernel.org>; Fri, 05 Sep 2025 06:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757079053; x=1757683853; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M5LnJAE3YZc7C+MgCps2xix2Kr7DZlZm+g8SIPc04+Q=;
        b=UrVp63zmmXZPvd1ULhLMGjNjWI+EpSIziCEYuyI3KJsAjBKHbQJZxTck9n7J/v9Pwx
         lVlrrByJKixjqqQFQbq6b3gyNu48OrRvA/wCioRbEjZIQm/jTOlzKmZEFSvEKg5fbh5g
         Y5+npxVRvUnd/b+9XRJBaxu+GTHbkk9t7slf9QsUOgYpJ2VFAVoer8Tqi8Eqj1tGE305
         RbO3Ynbl1qJQEhUf38P08POPlhHAr4fZ2U2KNvEKkcJr5zgtYGcu2ZsvCRyBqWdi2dC0
         zfBCHzXZFE2odd7T7kgX7O2sWWcEUzFJtPgNbhsp8wYME7yk9XE+7/tkCcYyszPr31jK
         NrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757079053; x=1757683853;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M5LnJAE3YZc7C+MgCps2xix2Kr7DZlZm+g8SIPc04+Q=;
        b=KRZp6mnhEpnye1Ixaz6RB3r9wOnON1iKkfKmNtvpr8wKLtSdpRedV21CQjIP0EsH2y
         fm6yxTYrTN8nBQ6O+UVm/uHSVmrRrvRQR5/pG+qO6y5owQ/q76dUfdtDTI9u8xLYRwFK
         yrv1krDFlbBvy+lFU8Mh1Or5H+AEMzjHPxuSNRvXUMJg3P5ly8EDBbmD+K1Z6ptiA4C+
         0g+sUDXDYePXr5swarGxU2VBTi31HXKUsAgaw7tu8/QQELNKyZ8lYemVuEJIwD19ssva
         FJ6C0+oYAmkX46Zu5eDV71xSSATox9YgObMjz1s1rpz2hwjQs5yMKu9yoo5pQ9Z3m5vd
         bfKA==
X-Gm-Message-State: AOJu0YwW3sS8l9X0a2B01dZXX64tnBTitwaeq02Rsoixnl9fQnGhzvZ/
	lcYghU6n/S9t7pf+XKITNCLJ50/RD3Y5Ifp6Xp6XbcioHb3a2Z0xU7PBBuGo6ZcPpQ3RjAz2XXH
	Gsc+iJrJw59RTy87+9QvSHH/nIMlV5owCGNkN4i32RlrVLJ/y+hJ20Eh/QmS3a2p/oIrzfx2bTP
	418zNI34ZpqKOFXicKUim0e/U1O0v7FA==
X-Google-Smtp-Source: AGHT+IHMbBeVKy4nTkbHNNXw1E6U+lB/o2tBsWIP/XOdZuFF9D5csjYK61b/Q6qJIegwb6HxvZsJhbcI
X-Received: from wmbf9.prod.google.com ([2002:a05:600c:5949:b0:45b:7262:8426])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:268a:b0:3d4:2f8c:1d37
 with SMTP id ffacd0b85a97d-3d42f8c2014mr18693666f8f.26.1757079052632; Fri, 05
 Sep 2025 06:30:52 -0700 (PDT)
Date: Fri,  5 Sep 2025 15:30:41 +0200
In-Reply-To: <20250905133035.275517-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250905133035.275517-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1404; i=ardb@kernel.org;
 h=from:subject; bh=LG9z8ZfG/9lulzNu83d9OgD0HFnWetupMNmr542q5Ks=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIWPXM4Y7F0JYuPJPl/FPqAhOvOS/S0fsxmm5cIbmeQeWv
 /m6IntxRykLgxgXg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjI+oeMDBuXdugdkF+/+e3a
 sumKH1zmv9ZLvBy+SMj9znyFJZlnEtUY/lnIbpn4UqD00YKSc7W+PmpfbbSXM27XOuGjy3zkxZ1 oSQ4A
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250905133035.275517-14-ardb+git@google.com>
Subject: [PATCH v2 5/7] arm64/efi: Use a semaphore to protect the EFI stack
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
index 9b03f3d77a25..8b999c07c7d1 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -165,12 +165,19 @@ asmlinkage efi_status_t efi_handle_corrupted_x18(efi_status_t s, const char *f)
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
@@ -178,8 +185,8 @@ bool arch_efi_call_virt_setup(void)
 void arch_efi_call_virt_teardown(void)
 {
 	__efi_fpsimd_end();
-	raw_spin_unlock(&efi_rt_lock);
 	efi_virtmap_unload();
+	up(&efi_rt_lock);
 }
 
 asmlinkage u64 *efi_rt_stack_top __ro_after_init;
-- 
2.51.0.355.g5224444f11-goog


