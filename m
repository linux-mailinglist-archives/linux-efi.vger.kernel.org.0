Return-Path: <linux-efi+bounces-4939-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7ADB9AA73
	for <lists+linux-efi@lfdr.de>; Wed, 24 Sep 2025 17:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C9953226EB
	for <lists+linux-efi@lfdr.de>; Wed, 24 Sep 2025 15:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89F9311C07;
	Wed, 24 Sep 2025 15:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BMbpjyN6"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0375F307AFA
	for <linux-efi@vger.kernel.org>; Wed, 24 Sep 2025 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758727651; cv=none; b=u8c4AL/326WbDCigfxwZY3cZrd5+KgtPFxGGtGeseAf/jFGcDwiQkd3di2okblRJj833gR5/+qivxEudCeUws6uX7Q9HbYTYjdjj2OFI/ufmpaQdNj1ei8EzasI25hWw31teRIMIL2pMcWlHRqZeHsfkF4PScsJe4vCHIWacq7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758727651; c=relaxed/simple;
	bh=MtOnPClbfdUyhB/9B1oW+PN3ZA3eRIpJ8ffVei1OWpk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f3rv3f1SfxUkkxUMajLu3ZwtjFfTUBMPJOINFNj10G0d1xwRIQ+u9RhLoH9cBPrMzIvSzD2YDN7DMeztdRUN+ybTD/onBBhBk9R82p4jn96d8Lp57n4+mrwZ8fQXDFG/uLEwVBtEh3GXeiE6Q059Lba91P+h1gn/y3wzjdCiGZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BMbpjyN6; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46d8ef3526dso21578495e9.1
        for <linux-efi@vger.kernel.org>; Wed, 24 Sep 2025 08:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758727648; x=1759332448; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5XviAeY7lSeSaJCaNoApmoT1KMIq12BnZAiqMT/S5OY=;
        b=BMbpjyN6INakeM2v/LIqwgfUwVrI6LEtDJt6NQaMvANWEJJZMt+qDvCL5P4ThS/hkN
         0CY00NDB7CJ5cTUULKksK6kSbjB23TnE210yrbEVVKMqtbLbLe/2stM+LHl28m+bB1cm
         tVkbHUX/LIyFumBenQFpk0NgE7uDXWnLt+QgA3okeq2+mHeOYXQdr6nOcRtxXUySICKF
         PL4YeajTaAo0Iwdb8KGJLrV93RJQ7WQQyH0qTB35mho/16rYX8DwoDGgNW1nzAxdBZt7
         u5BubTx4cGPNXBiZ5zZcHQPhfh+6a88zRyGg8SjXrcYh/bmGJt7dfjKqXUSOl7Ahz7cJ
         qYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758727648; x=1759332448;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5XviAeY7lSeSaJCaNoApmoT1KMIq12BnZAiqMT/S5OY=;
        b=P+UZUMJZwoW1+IZCGQ7LLDBJKAZ8UzmPB9GPkDXW4jKM5Qp1IHUpxGAOsC7Kh6G60D
         iYB6DSulDeHpDbDunicyZpugXuBJosMxTvI1cqZA0h/J/730qxHIRfcF0SJEP9vo3rYP
         HukbIa7sG6594ObmcP06pOFn9+pVHycHr3NIYbHJ/C/QsCjeD4cH8b+RTzRuJRUM/g/5
         UA6fOHBWuDZTKfk01D6vE1XHiR2j5aKwCfIjpXNXsAsWEBPFpIzfGfEa9eZe24aadQjM
         35Xz8CtmRrXHZYcBOSGBZEhbW24bGFAbTxfKIWpxBaVK/w4pMb8yS/uULa0jBgp9/hzM
         7PuA==
X-Gm-Message-State: AOJu0YzVYSXvlCO4NapjxRANoroDx/SyS9GsW9G4n5WUo/NglrTg9QGj
	40Mw0IoLR5WDhTunWFyun0anJ2lIYpJxVTQOwcgfd+j7OsCGuCHiflu0ieW34vdXB+mODl9NwD5
	I0ITUV/S/PbNFQW7dA2F3INaxeZcw1MXjPZEHnXaSTsh8qfocx2+ipAOL9s6HnOhdppNtwZrl5d
	KHOlFeD+bEpG3AAlMVm/Re2o0qVAem/Q==
X-Google-Smtp-Source: AGHT+IGGX7f3s3fIS7F6JjZ/EdBwQsTrzEkrdjWSZ27jkWwDpVAWC72cO2yCYMURkKd1dYsCB5YYDcSL
X-Received: from wmnp7.prod.google.com ([2002:a05:600c:2e87:b0:45d:e45e:96aa])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:5297:b0:465:a51d:ab
 with SMTP id 5b1f17b1804b1-46e329bbf5amr2850725e9.15.1758727648403; Wed, 24
 Sep 2025 08:27:28 -0700 (PDT)
Date: Wed, 24 Sep 2025 17:26:55 +0200
In-Reply-To: <20250924152651.3328941-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924152651.3328941-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=901; i=ardb@kernel.org;
 h=from:subject; bh=nKwv+wRF8AczbIGiloggDafTMLbsFJ1dEVBDncfmiHo=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIeMK7yEN/52J0oxlKw4rvHFWbdru73/z3MPftwrbj0RHO
 959ZjKxo5SFQYyLQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzkz2tGhu18n7TLZn0/d9F9
 2enNSjr+8u+U1bwK/1jHv9rbdeyOnTbDP901L/M0p7qkTt3/xy4m0jykxOHNvlcxM6K+lAZurev R4gcA
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250924152651.3328941-12-ardb+git@google.com>
Subject: [PATCH v4 3/7] arm64/fpsimd: Don't warn when EFI execution context is preemptible
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>
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
2.51.0.534.gc79095c0ca-goog


