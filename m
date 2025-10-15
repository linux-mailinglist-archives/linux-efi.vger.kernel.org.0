Return-Path: <linux-efi+bounces-5060-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4BDBE0BEB
	for <lists+linux-efi@lfdr.de>; Wed, 15 Oct 2025 23:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 980594F9682
	for <lists+linux-efi@lfdr.de>; Wed, 15 Oct 2025 21:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB1730506E;
	Wed, 15 Oct 2025 21:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sdniQ+/A"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAF83016F5
	for <linux-efi@vger.kernel.org>; Wed, 15 Oct 2025 21:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760562073; cv=none; b=Tfc4hqROInK+8Hebywxo6x+rJ7FYpWY/P8fzC88rjDkCqNHbDxAas2rfFzKKV5fwuOiVr5i+Ml5f+l+CboShsnCrtDJa4b5E+SV7IxfPMmYXkVl2ZToh/8kSSADtwx6MI0l+v8cc1Jg1xPloqNYLjg3WvJAOCFGwp2Qu3jlvGU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760562073; c=relaxed/simple;
	bh=5L4b1rIUXgU5wl8/jKyJxd4Vt1myFkIrr70lbjcEQg0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ad1XlYtfrCWwzdkaP5wFF+2uvWlNX1a6eeJVcZOrjdBi2vdSM4Ga7/sX//BpgICUwhsyEJxeRmSFzxOto0Dp4SyJ4jrrAXMhUgEmd3slxtoLM3+53UhmTj6/4kMeiJhB58RJtdRoBdj6pVoU21P0j5ImPWJh00OLOxLvM6YY/o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sdniQ+/A; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b3cbee9769fso611966b.3
        for <linux-efi@vger.kernel.org>; Wed, 15 Oct 2025 14:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760562068; x=1761166868; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HtXilHA5AAd1z6GdE3uGsC51Fo0T6TRa6MXgCog/xSk=;
        b=sdniQ+/AIrpNRxg4X/oiZktkjCV3G90M3L9OyRP2IMnm/D65G7fT2/EgGbPJ4UmtRc
         qnWBQ3LO6t+KGMvmXxIZk4Np1xVunWDMnfx8pfSbuH1poz8Ac1yMhwgVJKYKszveu42K
         +J95u90cw4ufhCDW3wNoSh3Q6cAoSGkl72a8W9kj4r4FY+TGsWdTX2LDAzY09DbDt3MM
         iaJ8o9gPYlcx5bsFT9XcIJxtt4Xxjnp9hJvU2cuzbjad7081FFzd+iXBpvsbucWKOPUU
         aYMvzyQAJ4FXsF+z2ZgryrjQrLcyGhEaBWZ/Qxzz9aNqZJX0ZFbeABJecbxY8+oqN0sB
         HMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760562068; x=1761166868;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HtXilHA5AAd1z6GdE3uGsC51Fo0T6TRa6MXgCog/xSk=;
        b=aoL0c0t7X0gyEkBjvQHwinH+1sOev0rWWfh5vhhxnCsYJSjS3JIsp8zmljuwgb8gjH
         DR9AzHloISIhiu1NMKcp+Eg1uKUXHF+17acZJW1jYYOXLY186zhnsFKHJ+e9x8DuGSnl
         kUCzfJjiY8xKxN0NAJhS1kHLlfTmVHj6xmQTrRMGOWz4CiXnTi3bhjee9SGztXAN1CjV
         CcwAnBnChE1Lph4wFbYPzmb6M6LLyDNgA+6meZ5AshvwBFORq6eUfy113xIbxLvygKQi
         G7UsqGQtX1bU+nprXijofGmUObxJNxIVsDpwzYDAjZflTTWfTMEnuGNx940X4fki37bc
         Mung==
X-Gm-Message-State: AOJu0Yx8ZF73X3sW+xyvkgR7lPblmc4U5eBDdi1gr4GYmEbqiXC15yPt
	7gdU/qDn2/I0QSMWCsZe+P66EVVLc6PugIrZNdzXX6obiBXh2hEykfp/5fsu3UAADFopSvQQVm5
	VD7PH/g8dBog3U4El3cOSnrUc7eiGybgD6FDZfjMOLzI33Cv+HnomOaJ9DidwY5AKY8b8+r6GDc
	OxgPUgTa0ZW1uf9XZNpOq/9csPdAzy1w==
X-Google-Smtp-Source: AGHT+IH3ROeCSpPWS9y2jZ7CvrP8/bWnx+s6dPg9rJBua5mdk6FXYUzuc6+UiuwI+/nVZ3rpHBAA+hiX
X-Received: from ejblo1.prod.google.com ([2002:a17:906:fa01:b0:b47:89a2:8c6c])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:980f:b0:b45:420c:81c0
 with SMTP id a640c23a62f3a-b50ac0cc34cmr3303674866b.36.1760562068221; Wed, 15
 Oct 2025 14:01:08 -0700 (PDT)
Date: Wed, 15 Oct 2025 22:56:41 +0200
In-Reply-To: <20251015205634.3820870-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251015205634.3820870-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2657; i=ardb@kernel.org;
 h=from:subject; bh=997YokF8smvlH2+7Du/063cegE+dHugAIUP6dU3Aa2s=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIeMDVzdTg/stWY4eySNf39jeOrDI2WBiyytOz6jjvWbRV
 x/v0FjRUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACaSeZKR4apV4b0pL78sZ598
 LzA4+I6BwcnoBUdSut9MUZh7iKesm5Phv0fEh9RthhFMgprc7NoZL8o/mqhbhr2MTOZkDl/GnKb KCgA=
X-Mailer: git-send-email 2.51.0.869.ge66316f041-goog
Message-ID: <20251015205634.3820870-15-ardb+git@google.com>
Subject: [PATCH v4 resend 6/7] arm64/efi: Move uaccess en/disable out of efi_set_pgd()
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
	Pierre Gondois <Pierre.Gondois@arm.com>, Sami Mujawar <Sami.Mujawar@arm.com>
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
2.51.0.869.ge66316f041-goog


