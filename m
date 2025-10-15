Return-Path: <linux-efi+bounces-5055-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F20BE0BCA
	for <lists+linux-efi@lfdr.de>; Wed, 15 Oct 2025 23:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8FE35357939
	for <lists+linux-efi@lfdr.de>; Wed, 15 Oct 2025 21:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0D22F8BF5;
	Wed, 15 Oct 2025 21:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LeXLlNlp"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E652D7381
	for <linux-efi@vger.kernel.org>; Wed, 15 Oct 2025 21:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760562068; cv=none; b=LrtmX5C4jQjE9YXFktpyGLPZjaiPGY8g2z4aSiKeR0qEF4DzVf7n5PwOlmptOSIRPXbR0nKZODeLw8Y+1U3S2VpJk9ecBsmgGMuJER3oHBV3xP6Pw+6mMityqbbGosVOjNMRmUjtd0L5kx5Bm+2+FSbUhwHXAL7LMu6FBbNZRvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760562068; c=relaxed/simple;
	bh=OKkz72icLYW14imSSGsnJwZQIz4ZrV8RIoFMrz/DOHo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H/6tSdiFYUOOENy56rIchA5jJMBOgx71ImYHZBh3HYotIlpPQGSu1G8XzyQAdAePFw7W4aXw61QkL8RZey84ch8nUD8iwfaunHGJMq9aCQQT2jGmaBB3pF/8aH2sT+8OsgTmZ8Y3JBju7AvmIuwJgz7Ge+c0ehpclFW4iHiD9cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LeXLlNlp; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b5ffd44fcc0so1597266b.1
        for <linux-efi@vger.kernel.org>; Wed, 15 Oct 2025 14:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760562065; x=1761166865; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dl7DSFNXrvgC8fPiu6fPIF6OEEmMKscydyxcv7oyMcM=;
        b=LeXLlNlp4b5CawJnjlxgzI2sM0o6Rkxo2gmwphjX5/HO63aVLI8971cXQmnLgago7o
         5YJ8/N0Vw4pgM00+Q4oFJPkhL1tfYSwjo8H/d456arLYjxGPWFp3I8yyz1dCyVWXazjc
         N0NnzvA8WXFadgLQfVxv2TsXr3swEZfhtMzX5jhK7ilgWCcv5zo01p6jcrM7yIDrgacM
         bp+N3n8PO0tRh8GN545EDJS5y3zAXUV2TiV3sNXqYYKrq+I6Rix8hyPGG9Yrx7kBldEj
         HYZPVjG2BX+Ewi3Gl3e6Tl6cSOM1OBh37dgNJqKaOVnFC/2ZK4RM7istHOaVyVkU0q23
         1gWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760562065; x=1761166865;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dl7DSFNXrvgC8fPiu6fPIF6OEEmMKscydyxcv7oyMcM=;
        b=ofD4XWmW3uls3RJJiY3/6Ud1rQVGeY/gxB/g8n2ybeICGimoQ9bhhYEWyGHhBuAyGZ
         FdymUrNWCT9OSFwnDuNp9aRvoYak8RH3nhpafyAmkhSK8agXCBjQwWUaczSBCT0FHfvg
         HtE5SLTgHRIjwZ904Q352RjvXuQMcXiKhj7IoFJpZaN3/1dy/jxBQl3ns6GSpCsPQ+E6
         cezWo6BWNG25EsdoBIZOD8ZSAU05bATh39Nx8wS5pydpKPgsmpR0/YsybT6kbRumF2Fw
         y8yYOoJ4tWgZK+VQW9QCJ6nhPFrHFjCtU9P+ps4Gsnp5QkLcCEB1B0E67HQCFVe6yJgN
         NolQ==
X-Gm-Message-State: AOJu0YyET5nq9JlO5tmKEIo2hvRuHwDU+kHrgQMzUVWMRKk1uGyaECk+
	stI0Q1rS6UJN6hQh0855e0Xiu4Bv/beMW0q2zA95vBpTd8P3VVv5uaVggHp/Uqvljm+rdY3aHPU
	lVO6Gj5qyk1+vlBsjf+L+p2xG7klcnaxYVmq7KoHU8yk2o3QQZbxAI5GJfkLnx6H5Jkpcc/Ge8X
	yuM7Tfb93cnLwuBwC+YFjHabhkuvh/wQ==
X-Google-Smtp-Source: AGHT+IFbnpDjbsGYz+B5RZXbbX+lQAERWey19YRdHXPDBHHjm8WsWQOtc3beJ3/VDPI6WGbFnSNWq6W+
X-Received: from ejkf21.prod.google.com ([2002:a17:906:60d5:b0:b3e:d65b:d781])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:980f:b0:b42:9840:eac5
 with SMTP id a640c23a62f3a-b50acb0e645mr3264235166b.61.1760562064831; Wed, 15
 Oct 2025 14:01:04 -0700 (PDT)
Date: Wed, 15 Oct 2025 22:56:38 +0200
In-Reply-To: <20251015205634.3820870-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251015205634.3820870-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=901; i=ardb@kernel.org;
 h=from:subject; bh=3k3eAeRzb5JtIy3mWW+ubq7svhGC8mUZQWnX3o9AW0Q=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIeMDV/tegTVS5dfXu18UWPjk1eM+1663m/bMeRC4e7bqM
 +23r1njOkpZGMS4GGTFFFkEZv99t/P0RKla51myMHNYmUCGMHBxCsBEmOwZ/oqnmq6ITeacf2jG
 mnnzLl0RqJGM0Df8/FlHNOxjasSsf5MZ/qc/KH/84UNLpdyBY1qtf2/cjU7fssu6aWcD8x4784P vOjkB
X-Mailer: git-send-email 2.51.0.869.ge66316f041-goog
Message-ID: <20251015205634.3820870-12-ardb+git@google.com>
Subject: [PATCH v4 resend 3/7] arm64/fpsimd: Don't warn when EFI execution
 context is preemptible
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
	Pierre Gondois <Pierre.Gondois@arm.com>, Sami Mujawar <Sami.Mujawar@arm.com>
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
index e3f8f51748bc..3d848c89604e 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1934,11 +1934,11 @@ void __efi_fpsimd_begin(void)
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
2.51.0.869.ge66316f041-goog


