Return-Path: <linux-efi+bounces-4698-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BE8B45908
	for <lists+linux-efi@lfdr.de>; Fri,  5 Sep 2025 15:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCBFC1BC01FB
	for <lists+linux-efi@lfdr.de>; Fri,  5 Sep 2025 13:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66DA3568F4;
	Fri,  5 Sep 2025 13:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OVwAq2Ei"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C3035336F
	for <linux-efi@vger.kernel.org>; Fri,  5 Sep 2025 13:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757079054; cv=none; b=Qiusg2WEIsK0E1G3jlHHFmDibib2de+5xhCJQMpLurnCLCBmNimx+5G6RHAvv+K77uXD3vnP339OP8J6/uFICE50bjXZlQjvt8qcm56adO5Y64XpsVyhQLrzch71HbDssCa/qk2t3+0hKjP7DBhss4TT8R24L2vR8iYEJrlEn7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757079054; c=relaxed/simple;
	bh=3x4Ov+quw/0QQMe9W2h79+/nvRgwRJWoim/Yeb3cedU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y3OwyYLM+X3HKOAUVl72mDNPZxT8GgJ6G2VMnEhOPRMuhjkbEGYz7HJaLb5sC6NJ9kOcPWEtPrcTfdlTckwAKmrWoxgtnjyeq7TQGiMjAIybkYiAoHyMfpFpIuWZxoIptWrMe4NtZHN1PM4+uKtOPkJ+nu3EZUwVVxyqq4N04Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OVwAq2Ei; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45b9a856d58so18008975e9.0
        for <linux-efi@vger.kernel.org>; Fri, 05 Sep 2025 06:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757079051; x=1757683851; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=prmt6wujZXZEYu4jILQGXIbirUOdEqPv5dUXUHxMI1Y=;
        b=OVwAq2Ei+WydT0GtqATN3sjs03DNvBdz46+DDo7ESR0ATU+F9wYuH7tBKvedMd/Eo+
         eMhtepXzfnmYl12Cp018LABtf0s3rbGrLk1ttjc5KByqETUwgq7cjHEzGgS7vNlSbSjB
         5tXAU2c1W5498ksagDXQn0ccZ8H9I0+d3vdjxz+bCHjdnc/g/UQhZ7aLwqSGPUc74zPr
         hhkUXHJrRvvUlEg1bhHvEjdyP7tdCrDSSzfjXZzZJYdB01Fs+mQEtZWrJ1HjONrHzbz8
         J1IQypQU5PxGih8chn5zMkiUJAU/IIB4QuQ4etd4DXDe25koqLZfkHnCPFsOJ1y22kDA
         vYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757079051; x=1757683851;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=prmt6wujZXZEYu4jILQGXIbirUOdEqPv5dUXUHxMI1Y=;
        b=GytLaqhIZKKiG1SZLNP6bAnHF9LO/djvIXra1lkyLdXW8c7WO4Qh79adUFoeaIZi+p
         iFwOCHk0u5Tsw6cKcFZnCggoa7dVAXuiCNcd3yCR5CaX+j/lOoD7Ns1T068PLsFBhF5G
         AUsNwJxHaNgDZcsh4trhbuiBN5CqHXv0JdnRExh5HScvObcVRDkdiJWDvaVWjgdRL7s+
         6LKVhWuiNyoe21VotE5OQslrQRLVFxNWkZJ9ftytgy/wNK3XWpjBiQXUDMYd4rwStONy
         apC/t8ihqUsr7Y43PsECXcwOcPhJYncYE7h2cX1+hylIDJi/htlXtBGW1Zxq0FLOApiY
         ip8Q==
X-Gm-Message-State: AOJu0Yw0yAXWxkuS2o2/mQm8faEKgx/fYbJCNXVBNmCqd2B0F/d9mmDU
	MtWo7/3yPxnVVYASmLXth/90fwp3IMVkUdtP6RwK4nygXH9WCDJotiulNCPTxpD+3bGaXaImh+0
	tWUNV06F6R9yY3jl9od5xkUZipuEazIO0GAI3YhGXyxJlkVgdo2LiX9yViR5kpHJLp7X2Y4XfEs
	IEVOlvcN8lV11HgPxYzoNEPniFau6VhQ==
X-Google-Smtp-Source: AGHT+IGcrXQUr4V8mfgwMOKWStLEjIiWgtx5sJLHPBI6rSUhc/g7n+CYYfQRUgy3XXrsY4OjTKbfO2Oh
X-Received: from wmqc10.prod.google.com ([2002:a05:600c:a4a:b0:45d:dbd2:ec9a])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:548a:b0:45c:b5f7:c6e1
 with SMTP id 5b1f17b1804b1-45cb5f7c990mr92681555e9.0.1757079051352; Fri, 05
 Sep 2025 06:30:51 -0700 (PDT)
Date: Fri,  5 Sep 2025 15:30:40 +0200
In-Reply-To: <20250905133035.275517-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250905133035.275517-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=901; i=ardb@kernel.org;
 h=from:subject; bh=ymeoG2jyFnfZxHt/XMud96BPHY4rNxDq3fGtVI/uoN4=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIWPX0/86gcet7k75+ikp4N/VlzWbwz3MFzX3nZsSJbTfe
 Mrlys9+HaUsDGJcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAiLa8Z/ukpNH9K793d5xX9
 gO3t6erK2Tt3XzghVfr337TlRnsmpzcyMvTJHGnzzFyjnTCjaMLd7e8XO6x7ZlfDxzbt1OKi0lP dqxgB
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250905133035.275517-13-ardb+git@google.com>
Subject: [PATCH v2 4/7] arm64/fpsimd: Don't warn when EFI execution context is preemptible
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Kernel mode FP/SIMD no longer requires preemption to be disabled, so
only warn on uses of FP/SIMD from preemptible context if the fallback
path is taken for cases where kernel mode NEON would not be allowed
otherwise.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/fpsimd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index c37f02d7194e..d26a02ea2bb9 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1933,11 +1933,11 @@ void __efi_fpsimd_begin(void)
 	if (!system_supports_fpsimd())
 		return;
 
-	WARN_ON(preemptible());
-
 	if (may_use_simd()) {
 		kernel_neon_begin();
 	} else {
+		WARN_ON(preemptible());
+
 		/*
 		 * If !efi_sve_state, SVE can't be in use yet and doesn't need
 		 * preserving:
-- 
2.51.0.355.g5224444f11-goog


