Return-Path: <linux-efi+bounces-4700-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06022B4591C
	for <lists+linux-efi@lfdr.de>; Fri,  5 Sep 2025 15:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20261A468CC
	for <lists+linux-efi@lfdr.de>; Fri,  5 Sep 2025 13:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6293570B7;
	Fri,  5 Sep 2025 13:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2l4vZB4E"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEA9356907
	for <linux-efi@vger.kernel.org>; Fri,  5 Sep 2025 13:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757079057; cv=none; b=UAwZdAYpXdr5/4TCDCfxrLfMh13lD4iUE4mhcj9HrD16vJfxUahIClc9Hb5sB445/SwYAuJwJVIC9RAGiTOjpJ26ikSCJjXYxC/dMWhTiSYKGbTmL5wXSE4Uw3rfqB20HoqafdzJYDagZuCQr+WT/Pc1EJ77DGocoaibfLFus3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757079057; c=relaxed/simple;
	bh=vCN+7KY/Jr0TywSZW8mKMyvfechRFEsHvYFf7BYUBzI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IP1z0DO+TlPBpPNF/A0rBBjfFlNQ2ARHTEXu8HCp2DAi395IZEt9x/ts8f+boDafbU67n5Hg/6lpqmQ5M8MkYmFEH3q771AnwmQDmB9emgWEx89iStD9ErDlPPu+opE2QJM5hSYmmoVs/Aq4NZbJbvc9sStzxmJZIZTSVzpRrpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2l4vZB4E; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3e3b77972cbso482694f8f.1
        for <linux-efi@vger.kernel.org>; Fri, 05 Sep 2025 06:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757079054; x=1757683854; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UAF98sQpATPhOILk8yZBv19jRmRkto76vQZwCOx0WtQ=;
        b=2l4vZB4Ezl/R7QWLvaxLA4D+C0dFWMngn/ljacW1xtRxgee8YSinkOzjSsBIFwFC/m
         dE8lilcvEneBap82hfq/7pKfNddwT65/mZxeh7xBT2mNVUEOb+eg2bF9Y1tS3dbcK6Gu
         br5JSAyS22g8Qu3gwuUQ4Z+QXZgNB/7JYhJb4SeVuTnE1F5UnJ2pddK+kScF1/X1Ttuw
         iO/OG3BwYGCsAC3QTNzIxNYcDn80moUGmTQllyW39dGKtAMz83upzuGm8Te32IwJ9MNK
         jKmZWOT3OK0sleUP5+hNe33R9yUn3ztQ/wx7bb2QOwvjbZ7S7rHR/FHBcHfpmBpRuhlQ
         /pVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757079054; x=1757683854;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UAF98sQpATPhOILk8yZBv19jRmRkto76vQZwCOx0WtQ=;
        b=ucabsyx9yinuAc8z+j2RZaegUz8PCxBy1Tb9R6hCgF1ouOM0eOY5DA4+asYrTFuFHy
         5ZEbwBDO5DaLxmGDal94/nFcI+aJbFJTZJNND0LpurskcgxH6PJsm79zyyFYG/BPUPKx
         H785HMGpPS2BDjkfQQLB8dNOUCZCMcogLIfdyblA2rc5kQnQHBJSYwAJ/9WFTtRv586r
         VWgsiBeepizVMkZN9XaRQycqBIfos6+9AsqnlvGgfF03nbUXuesJFDiNO5GImoFkcqSv
         7ORlwaUHT4/PS2sJlXP6RunG7ClP8OQAvY6Y/Z7/Upu4gBGBXiTug+xbGLUOMwkyb9yk
         g/8Q==
X-Gm-Message-State: AOJu0YyyONKeU2/NlFidyF3KLgh8m2M504Peyf0D13r8TCHCcrsTc4Xw
	mah5rMDe2MoWiN8lxWezFdJmW/7rE9mMLWt8wl0+4JLxVwFNuy7TATqvhdv4B4WRFVhI9GWD7f5
	TDsHdOukLUvOgXBHwU3RaziMS+fTWBPHWavDiUtXsTltW835F0Eb7ZuawafaWzMBm2g8ZtL5q2w
	c+T3WPkZ0rnv6oTSiJ/pLlZRzYgpJ04A==
X-Google-Smtp-Source: AGHT+IHLpO7vPeIPvV0hzS6kpc52u4CYIVWVnX+yyG4DktDXavuZLD82XV3iPv6GN2Z2q98RRymwXSY0
X-Received: from wmbds17.prod.google.com ([2002:a05:600c:6291:b0:45d:cf67:3908])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:65b:b0:3d4:a64:6758
 with SMTP id ffacd0b85a97d-3d40a646c13mr15248912f8f.3.1757079054348; Fri, 05
 Sep 2025 06:30:54 -0700 (PDT)
Date: Fri,  5 Sep 2025 15:30:42 +0200
In-Reply-To: <20250905133035.275517-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250905133035.275517-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2686; i=ardb@kernel.org;
 h=from:subject; bh=EAF0+F/3qCMp7xJeOjrqAiIGXMepd3zxzLCGJhcn/30=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIWPXM8YdJe3LeJP4vwf3THd6ylR4S3rtYu34UmZbxSsJR
 pLrjm7qKGVhEONikBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABOpO8/IsO1P5uV/fr7rn8sb
 HFA07HxQLGpdHLL5R/aHORPLOqddXszwhytGu7NGZYpawm6jP93C5XNWqF49PV9rVtz7Q79O/bN YxQkA
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250905133035.275517-15-ardb+git@google.com>
Subject: [PATCH v2 6/7] arm64/efi: Move uaccess en/disable out of efi_set_pgd()
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
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
index 8b999c07c7d1..ece046bcf0db 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -178,6 +178,15 @@ bool arch_efi_call_virt_setup(void)
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
 	__efi_fpsimd_begin();
 	return true;
 }
@@ -185,6 +194,15 @@ bool arch_efi_call_virt_setup(void)
 void arch_efi_call_virt_teardown(void)
 {
 	__efi_fpsimd_end();
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
 	up(&efi_rt_lock);
 }
-- 
2.51.0.355.g5224444f11-goog


