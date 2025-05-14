Return-Path: <linux-efi+bounces-3704-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2558AAB731B
	for <lists+linux-efi@lfdr.de>; Wed, 14 May 2025 19:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 671A53AF7D3
	for <lists+linux-efi@lfdr.de>; Wed, 14 May 2025 17:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8739E286D45;
	Wed, 14 May 2025 17:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b88Ke3xx"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95CE28032E
	for <linux-efi@vger.kernel.org>; Wed, 14 May 2025 17:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747244646; cv=none; b=R6ru33AwQuzYdaeZuTeF3vG2i5+w5B3m4FeOR29Sh1lyb5+55f+r7pwBY3HQK0s10crvm1riNfnSnaYKMTFV1kiYJw+Yl6ZGPdvdFeyqMD81cfiC+nVJZ0/Out5wBSamtl75D9Qz5eycDhAQI5a5C2m16tZ9fPAJpo78iC38w7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747244646; c=relaxed/simple;
	bh=QCcKltXdUiS6ZvAwHQnUpG+n3tVeHgTvAF4dJYxbvu4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tkXGxQiiybmT6LBGB8k+e7RwODogjZ/tv4YzcTcHzvy7J0g5CxW3tUlVGM8Vzkk88qRI6Gwf7d22WTmS1WSXO4aLVb+b/0SUzDUoR7rKuRl9QsFTwBa+G/sNbodZJzlHS4AeIepKFiCAm1MOaJFtFoiwJrZGHMnqVG7ojhpsls4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b88Ke3xx; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43f251dc364so463965e9.2
        for <linux-efi@vger.kernel.org>; Wed, 14 May 2025 10:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747244643; x=1747849443; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D3joKKQQeIZmQE4kJSA51zMSWECAKvTydbD+tuMEGFg=;
        b=b88Ke3xxCNTe82Z3RoZjUOoLZY+4W5sXVY9mD7oGDeudxLES1VqB1nht6+6CaS/f/A
         P+wrmA1QAIVAb1oODE05mkQBuTNJ0PQQcKDmY55Kh/7KH9xKCSNqBi5GOVrd62N92V+i
         1dVSbJ8t7ljsa/PiVtet2dauQ8Ky/o8A49a3DIFiilas88pHKU6vNswU9LA2e6+hwPa4
         QOOHCL3NBDuoyEirTUHZwKdB+ZPvMkbHiAfmEZDmBm809SExB3r+9pML6wdzfY12h9TA
         2qQhJEffpIVlxBEdS8b0dUtZvKqUbBu5zwxakoQR6xNLkeerp8D8vSaJQiBUFt/UzdQR
         Jizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747244643; x=1747849443;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D3joKKQQeIZmQE4kJSA51zMSWECAKvTydbD+tuMEGFg=;
        b=fDnTzGrznh/k9RgrsAncdZZPAroif7v6F5jCO8qI2WbBx7u+v2p5m+DOrtGf9M7dBm
         IrqwcmRhsYAMnkiWZlEhRrvg2K0suoeCKHz6nPBXxphu6ncke0EAZGSxPZ2Y5HB2zi95
         IqH8ULCBGPfVcu3xja31u3KrYM6AVYq3q1cxkg4QYv5/grLkqSP7XLXvSV5rM18JGvR4
         dfPTxBqioCNgLhMSKXrOFwIf39bK/Bmw925dHgYdjmqywaLZkxTDqC/5tWjeMN9WaBOp
         xhAnvKetGRI7oK7sfR0w8OuA5FCOkmebw2DZpRh4m9oCidNLeF8NP8/B5d4j4NIlPvvx
         srFw==
X-Gm-Message-State: AOJu0YwuzZ5gT11yZK1UMjGmXLt57rJVH6hCmzY+K/k1Bczfo0UWO5Va
	RPuPDsBmwFK1OS2PxvGHd7b+QMkx8vyC/BkaCsJ+2gyvCj+S+oYHqzRuhiq9H4UV5Zr/oGu2Mf+
	g1/STOUZ7WLZzcVjehelIIe70DIooyspk4t0GtmdMuftDbGWgsm9CEh5n/V35Vch0oOcrR924nD
	KG1hNTI3wXQtcnHfmYslk9zH8HJg==
X-Google-Smtp-Source: AGHT+IEb+8/c9BiVGl1VreAZ1QbOIrYHfFd06gIJ4WYvdQgg+dQ9aQ2nVaMRaSnJ1H83VLXljFnK3HOA
X-Received: from wrgb2.prod.google.com ([2002:a05:6000:3c2:b0:39d:7be5:b8fa])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:420c:b0:3a1:fcd9:f300
 with SMTP id ffacd0b85a97d-3a3499224cbmr4177122f8f.39.1747244643209; Wed, 14
 May 2025 10:44:03 -0700 (PDT)
Date: Wed, 14 May 2025 19:43:44 +0200
In-Reply-To: <20250514174339.1834871-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250514174339.1834871-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=902; i=ardb@kernel.org;
 h=from:subject; bh=B/kHgdOpjuIm/yGgjP0zTXGcP6XnGaz+vciWyr3djVs=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPlWkj9BO3u3gnr2ypE5E2uvsxuvTddxnHDnQ7TowlXD
 uj/FmPqKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABOZo83wT9ddzsGtYhv3rz/7
 NOWs9zVYcR/I3iEhJNXOMquLS2aWN8P/rHDfI4ztPNuVmsOTZFLuFfz8f7KhK/XA42jhh4384g+ ZAQ==
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250514174339.1834871-13-ardb+git@google.com>
Subject: [RFC PATCH 4/7] arm64/fpsimd: Don't warn when EFI execution context
 is preemptible
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
index ae2ea0196030..47a8706e26b7 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1975,11 +1975,11 @@ void __efi_fpsimd_begin(void)
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
2.49.0.1101.gccaa498523-goog


