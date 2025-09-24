Return-Path: <linux-efi+bounces-4941-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A48B9AA82
	for <lists+linux-efi@lfdr.de>; Wed, 24 Sep 2025 17:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16E7F171A47
	for <lists+linux-efi@lfdr.de>; Wed, 24 Sep 2025 15:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352473148D7;
	Wed, 24 Sep 2025 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WWi7cPjo"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407D6313D72
	for <linux-efi@vger.kernel.org>; Wed, 24 Sep 2025 15:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758727655; cv=none; b=kN7C3S8Zh6YdI7iYVkmw3qXJ/TieHeBYP5tgni7clTOsxDLGd+tpYuQFVLt3z710rBi1rBfSpAO7cv5vaxldswJPwkM7jUZzc+YF914AhvvPXdWflFtM6gMYcYjCDd/L1cHXVwV5hjxFGPbW6Qgf1mbRBqwXC+SMCpzFUWIOvOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758727655; c=relaxed/simple;
	bh=zbwGMZy4p1mf7vELCgM3/lRqm/LcVE69qufBNCRSm3Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fRQO3cbtDwDpwvM3kWRZRm3uXcUUVz07FSqu+UbK9HMyf1TTdo4PgiYnqd1kngLdGke4wowqwF4kKHN4ZEuHYxDS78RQQcVEB72zJNKf7jBvSiDrokG/ZiBlHbt45T5T4dGEWvl2pqn/N8jSTk+MbgvlOlfTZAs5ZWJAWGlNjQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WWi7cPjo; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b2e6b2bb443so310063866b.2
        for <linux-efi@vger.kernel.org>; Wed, 24 Sep 2025 08:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758727652; x=1759332452; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1hU3NU+EE/1FuOChBH3loy566bJ/0QuhejdT7NEwC48=;
        b=WWi7cPjoLiJ4QdU58gaIIZGVfjfDRvk+18KQ85lR2PtcPpHd9EGWzVfpX3MTG1j+RQ
         QxBq3sAk9Yu4l3e4z3KM3/e3oOyTWkLcTHq5WF29N4ndIsKNaeK2RBL88RIbsY0+oniL
         FAlpET97lpNfOXJLBG7XIQT+3m72MEuAEwe742V4R2sV0EY3quqGOPg9OEX6GhZVshgl
         QM95Hx80Oui1CPibcpyIP2fxiUOczCB45Ag4gfNYs23reiHcYeyTet/FcGcE+um/QVjp
         CgOSVomSH/J+WHTyLG2VXU00pK6CG87JbH5FhPAuzmhPiHy7ocKT0qlrjktEDmyW7koF
         jE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758727652; x=1759332452;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1hU3NU+EE/1FuOChBH3loy566bJ/0QuhejdT7NEwC48=;
        b=twzHwzFZ5zawkDE7vudwNwJEyy1vnD8f0O0Dlw2MAR1yCB7ygeWAOcfQlCHoG3GBB9
         sXeM9aeRU0RFrGZ1LSwgjjlMRM0gP8YkzsiaSHLj3jSv8L3n+OPPvT7zGbHf1pNuVlFl
         9kuvEK6yh7MPZXzwV27CodJNvCWpKiLldhPSI5tzIYmvnEEBAM/qCm/BlRI0XmqoTlX1
         J21yJYYfdsNW2WqwViQgMmlwSqbIjAkKpYzMDM73DnK5d02bcuDAcbAgq3us4w3R0gtO
         X0tw1TBX4BqmEZ8++6h9eoVCilk6S45Xch3zP/rrHS6z4Z+c6h1r0zFUG/H+vM5yZNLX
         yjNA==
X-Gm-Message-State: AOJu0YyJEuaUZgc6ovHhrJo+tFzgu/2iybaNRv6VWyK6gA8HWeWOqHku
	8/mZ+G9LN+2ZZVT538bad0MN6kB1++VSaltRJYymIraEDXFnUwIasBwHj3myrgxPSgpC9oXkG5n
	0W/3+PgNUuuVzDtLrgfGGueriX4/EkC3/HFAtRayd+QmBr5wz8rktTzrXPQg16O4iaS1zGqXsiE
	ElbgTI29Pq6Nfnde8X13ARJ8zGpWj20w==
X-Google-Smtp-Source: AGHT+IFZ2iwstoaHBb3YCwWIateYZTWtxaliteUts4ieGmp+JuUAeae4kOh4NCMKe4l2erWoMG1yxlHU
X-Received: from edqs17.prod.google.com ([2002:aa7:d791:0:b0:634:6ced:4ca9])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:c14c:b0:b33:d2f0:d1b6
 with SMTP id a640c23a62f3a-b34bad21acdmr24393666b.30.1758727651707; Wed, 24
 Sep 2025 08:27:31 -0700 (PDT)
Date: Wed, 24 Sep 2025 17:26:58 +0200
In-Reply-To: <20250924152651.3328941-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924152651.3328941-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2657; i=ardb@kernel.org;
 h=from:subject; bh=v8PXoWY9U3MlvdKFdHLzUBgWgUos6+58xgUiDJkn3es=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIeMK7/HmaafKmd+mXNZxST4s7RjcunHJj3apO1PvLZ526
 M2RXwpCHaUsDGJcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BeAiaQx/eJ3bJMQY1x39Zb7w
 yPJ+pWeGwd6STwtF9yyVPbNWm6ldk+F/iONEzTbRl6sZE1zPWk/XmzFTrIDluco3W+WH3/bPrNn NCgA=
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250924152651.3328941-15-ardb+git@google.com>
Subject: [PATCH v4 6/7] arm64/efi: Move uaccess en/disable out of efi_set_pgd()
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

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/efi.h | 13 +++----------
 arch/arm64/kernel/efi.c      | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index bcd5622aa096..aa91165ca140 100644
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
index 0094f5938ba6..85f65d5c863c 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -169,12 +169,30 @@ void arch_efi_call_virt_setup(void)
 {
 	efi_runtime_assert_lock_held();
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
 }
 
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
 }
 
-- 
2.51.0.534.gc79095c0ca-goog


