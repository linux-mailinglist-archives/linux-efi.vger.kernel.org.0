Return-Path: <linux-efi+bounces-4942-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 913DFB9AA6A
	for <lists+linux-efi@lfdr.de>; Wed, 24 Sep 2025 17:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F5C3B48DF
	for <lists+linux-efi@lfdr.de>; Wed, 24 Sep 2025 15:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3039D314A7B;
	Wed, 24 Sep 2025 15:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y6fMygO+"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3519E313D70
	for <linux-efi@vger.kernel.org>; Wed, 24 Sep 2025 15:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758727656; cv=none; b=kPoPlCxDgdethphG9gCPfjIPVdncDuWlrNQezVDI8/2d0qThSuwgzFb27H1dtsmmEVAShS4LTft3dBO+7l0Sbgshw3w5KrVLKigJ5nC5NHENb05/T29EL2l1/7Niq+2RNFMyRkDJl/EW7+ofHWqHLUcL9m4jMliaRclxUHw23xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758727656; c=relaxed/simple;
	bh=syY4SH9VeSO9lmfTJssqeO04+Z2PZYj5pDZKhxS0law=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HqNk7zhdV3LhpR99UHkShrnxmjPFVl9AliqlNlGj5RTIChItxKe87T97bViLNKmfm4kTfBx2Ti+sIhNbSZl6bWP42QvJeIzvN00iWD2DoyWKk7ZBPFK+a/nr2LR5GENnPDwhIRoCfN/EHgdMGB70yYbwA/cujnY04fmSMjKfa84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y6fMygO+; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46e19f9d18cso19735235e9.1
        for <linux-efi@vger.kernel.org>; Wed, 24 Sep 2025 08:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758727650; x=1759332450; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ln86/emlRW++8jlfCD8OhBzg2NppL+NIQ42e5m1YOIw=;
        b=y6fMygO+VDgmmchm8ixtjXtX2FBlqK9fgW8NREVTumcaliwHM8aYU4VkBkoMwGlEh6
         5jPjeSFV9ss+nVojUcwjaC1mCzJm8+aRuTaWQhDcvtzl9vDolGgZ4367C/xBAwY0tznQ
         J3RkB7nQhWfVkgc8wXLwSICnks1UW7ZYaJYjfTdB8XOKFM1IBI6wz1iAgWXbuJw/JAoT
         b/AA0LLKOHie5rvgUnuWwgW5f1vAXFZQBVqcN9JCxqsfLzzNBq6PByTpXreNChpYEZTE
         52/oyEEJ3sc4YgPWaA/fO2zFiRyItjg6oQsYkmhawjOaSocuoKvuHHDHH7b7zqmawpQR
         z+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758727650; x=1759332450;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ln86/emlRW++8jlfCD8OhBzg2NppL+NIQ42e5m1YOIw=;
        b=AITk2cgE9LyZqfAdCP5sz9LlHO73xpop2g28Tr1vc+W5hrQr+xhsignA3gYgv3/1e/
         BUbqwMyKVtQu6F8Yw9FBN2VcmNnhNWmasZsJ7XqknFq4oTOGelg58rNH7Ss+B7qr/BRW
         qQRTzuxY1xee94ZVsviyjZNDvHWDwp3rJfzP9Mn7qKXJtcOXZikf32AEfXvpRC3xvtn8
         EzL2mfvupJbxtxo9EJIH7g9DWQCeDFDgGarbhRwsoMs7FP4SzU2gBSJmRYSOtqnEaMe0
         Yv1xjFrFsb0KHGR84jFgqfZ4mJb/CdepFvkOLIhMxlpRBDrSvaN2LxB0He6xn4hJQuXX
         e3kQ==
X-Gm-Message-State: AOJu0YwPl48f483+rfcc1sOFMXYPDX0/r6Ojiny/3Ykrc/7hr7YzcqHb
	qv907PMhSCFJ7RqLQ2PWZhhJC8hEDhp4xiarX1WwGAjBGnk9X3Hexwdd4/9I83lGRreop9zEDY2
	Y7s1Fw7fkQJ8QZFBTm9aM9WZaTUAdTu30wL0ZMK2MH3LrfttROAbM1Yc0Wx4T/Yf+psktShyOZX
	U1Nkoy4BXyqRQQF/GwFFCKE0SlL4HfAA==
X-Google-Smtp-Source: AGHT+IGr/1cFTXgZdf6e+4nFNkNXF1/DJFBlumid+5SATHB0yGSyBfu3Vnrf7sHmr+Jznes2hE6aM/Tb
X-Received: from wmbdp9.prod.google.com ([2002:a05:600c:6489:b0:46c:aed0:23f3])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:181c:b0:46d:996b:826f
 with SMTP id 5b1f17b1804b1-46e32a02d46mr1753225e9.25.1758727650446; Wed, 24
 Sep 2025 08:27:30 -0700 (PDT)
Date: Wed, 24 Sep 2025 17:26:57 +0200
In-Reply-To: <20250924152651.3328941-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924152651.3328941-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1252; i=ardb@kernel.org;
 h=from:subject; bh=7GLyY2hmHXPr1fnp3jZiXNoyuiFGpy/XlEGtkndi7cg=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIeMK77F5kmrJ6gpp09KjLf7kCq57KHzvnUQ6ly6DaarJ4
 dkMqvIdpSwMYlwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCJX0xj+cLs+DtS2evBhqtKS
 ToszsruDvl5fGmZ+fYaHWNzEvrSWK4wMPZHRT7eHcv+1bu1WnOzmLvZxjqFf/JqNdr9/twpE7az nAgA=
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250924152651.3328941-14-ardb+git@google.com>
Subject: [PATCH v4 5/7] arm64/efi: Drop efi_rt_lock spinlock from EFI arch wrapper
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Since commit

  5894cf571e14 ("acpi/prmt: Use EFI runtime sandbox to invoke PRM handlers")

all EFI runtime calls on arm64 are routed via the EFI runtime wrappers,
which are serialized using the efi_runtime_lock semaphore.

This means the efi_rt_lock spinlock in the arm64 arch wrapper code has
become redundant, and can be dropped. For robustness, replace it with an
assert that the EFI runtime lock is in fact held by 'current'.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/efi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 6c371b158b99..0094f5938ba6 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -165,19 +165,16 @@ asmlinkage efi_status_t efi_handle_corrupted_x18(efi_status_t s, const char *f)
 	return s;
 }
 
-static DEFINE_RAW_SPINLOCK(efi_rt_lock);
-
 void arch_efi_call_virt_setup(void)
 {
+	efi_runtime_assert_lock_held();
 	efi_virtmap_load();
-	raw_spin_lock(&efi_rt_lock);
 	__efi_fpsimd_begin();
 }
 
 void arch_efi_call_virt_teardown(void)
 {
 	__efi_fpsimd_end();
-	raw_spin_unlock(&efi_rt_lock);
 	efi_virtmap_unload();
 }
 
-- 
2.51.0.534.gc79095c0ca-goog


