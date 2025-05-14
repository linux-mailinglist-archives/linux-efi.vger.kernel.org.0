Return-Path: <linux-efi+bounces-3702-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 044F8AB7317
	for <lists+linux-efi@lfdr.de>; Wed, 14 May 2025 19:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA02A3B398E
	for <lists+linux-efi@lfdr.de>; Wed, 14 May 2025 17:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D040F283FE6;
	Wed, 14 May 2025 17:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CxJJ2Tlw"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2562280CD9
	for <linux-efi@vger.kernel.org>; Wed, 14 May 2025 17:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747244642; cv=none; b=EpxfmquAbhNEqF/Jjj6MX5E/6ZUdlkDOfmiI4SaWohLsg0JZ3qlrpH1IWBoGQkp5vms+jB/n3ne52awvRnVk89tcWSaY4HBaqArTCJ9ZqMFnVmgPWy5/u+4DGm/u16S/azyvMnukaaEMRInSkqS8VY45+aiGGJbaTOeWM2fbQ5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747244642; c=relaxed/simple;
	bh=mVrD8G0mEVud+xrEngrBvbLdJt6fvh89BZud7f0K+CU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DW9B3rOJ1Vtehl9gmtmfTdSAvD0WwEtNUdeOZvkkQtM+KLRGe7iXDO7OMOwYgBMu4ZFWOLUv0ApJFWEphjpT99+tgGtE4uBRbmr2cMarY8s5TvZLzcWXHQLLcUfTt2Wb+RsGvZ3XNBlidoT7amaq+K/6VTlBib9IQ76++fV5fHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CxJJ2Tlw; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43eea5a5d80so424725e9.1
        for <linux-efi@vger.kernel.org>; Wed, 14 May 2025 10:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747244639; x=1747849439; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tXVJMsufZ9sm0rGmcq7nqIrA1daerFrHzMfPhoL+63A=;
        b=CxJJ2TlwvY7HQgFpVM6QXrVPonKnB6U3LjWS5GocZ6CD2A5468WSt2irMySx3A1Giz
         U9480QcdIeNsokDdxgyvO7btCUrFh7ZFCRXSRlUegWMIeR9dI/eAFHlNXkDfL+BBCsID
         70xUE73FZDuQDQFlSf//60oF8GNDGyHJhKseAh3G+YyJTH6kQyH3cTVlaood8PbiS7Id
         wQyKoGzDJ00Q+hT1dRkZNiaETonuLAuNigyapVUU+xWcSXe4gDeQm2mrhTM6KHfgWHrc
         UwK9MEUllPWIRjEwUN+Y0Cn1hNW/Q6vEt2JrRhH6vdCdlQuNhmzmipXDEPHr/FFUE5oM
         Sl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747244639; x=1747849439;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tXVJMsufZ9sm0rGmcq7nqIrA1daerFrHzMfPhoL+63A=;
        b=ZqFtLa7KQHuP2pMrxZiX6JxNmgAwyo5nc4go/RR9FmgQj83Lo1K8jttYMTQnKV/Vjb
         nzHQZSuGR4LIt/+YVqAqBU0pOgEE+8X1jfYxm25MdRhbfKQDHPOmTQK3GPtVw4zRN1zp
         w0bYk5wc7G7FVWJtOJ/OUUJW8N8h4zcO0VluAjkphV6eX9uIHsbzs49CpnkPCsikP5E5
         +oicYxWeMEaVFah3WE/UTgIEQSn2198YFwm2QLD/9tzBBhM6FjjcipYm8zL9pxdiDnSg
         Fvj0ksxQ2jKYGxJ+Lx3aiJVdxk5qohduk7jN4cTbprh+6vCYR9CABNHp8HAknYLtR+LJ
         ffGQ==
X-Gm-Message-State: AOJu0YyzrgfYdeIY7OY+oH0VWc+OnQGQsOwLKfaOz8rYhtw46UZz+6u/
	V/tHpqkLUnML+fbIvPC5cz/etu8CKQeJMnKy3cyl/iilIxCGQKuKSG/hPem2D5S78ucILovdgzP
	ATSjnMhuoO+N08kaxZY35FIBeGA9tc2kX5WcbYWpwBZAyaaeJuXLDu1TbfyTuuRedZ/aLTzOPIj
	b9ZHVW1QZMh7yBYcQSSJNvPghvrg==
X-Google-Smtp-Source: AGHT+IEFMJweCFn/YJy00TUveKZvloJ8ozZW7ocyXdHKJvi0QMeGWaS9uMuGA5J4Ptlhdx+EEwEvRi9t
X-Received: from wmrn6.prod.google.com ([2002:a05:600c:5006:b0:43c:fe64:2de3])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1e84:b0:43c:e7a7:1e76
 with SMTP id 5b1f17b1804b1-442f20b8554mr32240165e9.1.1747244639223; Wed, 14
 May 2025 10:43:59 -0700 (PDT)
Date: Wed, 14 May 2025 19:43:42 +0200
In-Reply-To: <20250514174339.1834871-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250514174339.1834871-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5541; i=ardb@kernel.org;
 h=from:subject; bh=5U5zQ0g4Nylx2meOob6iW9ucS95iuPh4XIaL8oIC4Co=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPlWuD06w/y06a7Tpn6tO6j+rPwRDlL+xfXBFZv+6jOu
 tKxdW9CRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZhIBxfDP4OTO6NSUk0c1NZu
 E5HaJNtptfjfmibztg1O+ilpqgrK8xj+B4Qt7urwXH1sys6X8fMMBBJ92Rf8SeuPdC7fuORk58p PPAA=
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250514174339.1834871-11-ardb+git@google.com>
Subject: [RFC PATCH 2/7] efi/runtime: Return success/failure from arch_efi_call_virt_setup()
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Permit the arch glue to signal failure from arch_efi_call_virt_setup().
This permits the use of sleeping locks in the call wrappers, and this
will allow EFI runtime services to be invoked without the need for
disabling preemption.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/include/asm/efi.h           | 2 +-
 arch/arm64/include/asm/efi.h         | 2 +-
 arch/arm64/kernel/efi.c              | 3 ++-
 arch/loongarch/include/asm/efi.h     | 2 +-
 arch/riscv/include/asm/efi.h         | 2 +-
 arch/x86/include/asm/efi.h           | 2 +-
 arch/x86/platform/efi/efi_32.c       | 3 ++-
 arch/x86/platform/efi/efi_64.c       | 3 ++-
 drivers/firmware/efi/riscv-runtime.c | 3 ++-
 9 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
index e408399d5f0e..0809a69bb579 100644
--- a/arch/arm/include/asm/efi.h
+++ b/arch/arm/include/asm/efi.h
@@ -23,7 +23,7 @@ void arm_efi_init(void);
 int efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md);
 int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md, bool);
 
-#define arch_efi_call_virt_setup()	efi_virtmap_load()
+#define arch_efi_call_virt_setup()	(efi_virtmap_load(), true)
 #define arch_efi_call_virt_teardown()	efi_virtmap_unload()
 
 #ifdef CONFIG_CPU_TTBR0_PAN
diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index bcd5622aa096..decf87777f57 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -37,7 +37,7 @@ int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md,
 extern u64 *efi_rt_stack_top;
 efi_status_t __efi_rt_asm_wrapper(void *, const char *, ...);
 
-void arch_efi_call_virt_setup(void);
+bool arch_efi_call_virt_setup(void);
 void arch_efi_call_virt_teardown(void);
 
 /*
diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 250e9d7c08a7..44ad5e759af4 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -166,11 +166,12 @@ asmlinkage efi_status_t efi_handle_corrupted_x18(efi_status_t s, const char *f)
 
 static DEFINE_RAW_SPINLOCK(efi_rt_lock);
 
-void arch_efi_call_virt_setup(void)
+bool arch_efi_call_virt_setup(void)
 {
 	efi_virtmap_load();
 	raw_spin_lock(&efi_rt_lock);
 	__efi_fpsimd_begin();
+	return true;
 }
 
 void arch_efi_call_virt_teardown(void)
diff --git a/arch/loongarch/include/asm/efi.h b/arch/loongarch/include/asm/efi.h
index eddc8e79b3fa..84cf2151123f 100644
--- a/arch/loongarch/include/asm/efi.h
+++ b/arch/loongarch/include/asm/efi.h
@@ -14,7 +14,7 @@ void efifb_setup_from_dmi(struct screen_info *si, const char *opt);
 
 #define ARCH_EFI_IRQ_FLAGS_MASK  0x00000004  /* Bit 2: CSR.CRMD.IE */
 
-#define arch_efi_call_virt_setup()
+#define arch_efi_call_virt_setup()	true
 #define arch_efi_call_virt_teardown()
 
 #define EFI_ALLOC_ALIGN		SZ_64K
diff --git a/arch/riscv/include/asm/efi.h b/arch/riscv/include/asm/efi.h
index 46a355913b27..a7b4d719e7be 100644
--- a/arch/riscv/include/asm/efi.h
+++ b/arch/riscv/include/asm/efi.h
@@ -40,7 +40,7 @@ static inline unsigned long efi_get_kimg_min_align(void)
 
 #define EFI_KIMG_PREFERRED_ADDRESS	efi_get_kimg_min_align()
 
-void arch_efi_call_virt_setup(void);
+bool arch_efi_call_virt_setup(void);
 void arch_efi_call_virt_teardown(void);
 
 unsigned long stext_offset(void);
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index f227a70ac91f..879c8402e024 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -140,7 +140,7 @@ extern void efi_delete_dummy_variable(void);
 extern void efi_crash_gracefully_on_page_fault(unsigned long phys_addr);
 extern void efi_free_boot_services(void);
 
-void arch_efi_call_virt_setup(void);
+bool arch_efi_call_virt_setup(void);
 void arch_efi_call_virt_teardown(void);
 
 extern u64 efi_setup;
diff --git a/arch/x86/platform/efi/efi_32.c b/arch/x86/platform/efi/efi_32.c
index b2cc7b4552a1..215f16ce84ab 100644
--- a/arch/x86/platform/efi/efi_32.c
+++ b/arch/x86/platform/efi/efi_32.c
@@ -141,10 +141,11 @@ void __init efi_runtime_update_mappings(void)
 	}
 }
 
-void arch_efi_call_virt_setup(void)
+bool arch_efi_call_virt_setup(void)
 {
 	efi_fpu_begin();
 	firmware_restrict_branch_speculation_start();
+	return true;
 }
 
 void arch_efi_call_virt_teardown(void)
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index ac57259a432b..023368e9698a 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -445,12 +445,13 @@ static void efi_leave_mm(void)
 	switch_mm(&efi_mm, efi_prev_mm, NULL);
 }
 
-void arch_efi_call_virt_setup(void)
+bool arch_efi_call_virt_setup(void)
 {
 	efi_sync_low_kernel_mappings();
 	efi_fpu_begin();
 	firmware_restrict_branch_speculation_start();
 	efi_enter_mm();
+	return true;
 }
 
 void arch_efi_call_virt_teardown(void)
diff --git a/drivers/firmware/efi/riscv-runtime.c b/drivers/firmware/efi/riscv-runtime.c
index fa71cd898120..07e04b8f982a 100644
--- a/drivers/firmware/efi/riscv-runtime.c
+++ b/drivers/firmware/efi/riscv-runtime.c
@@ -142,10 +142,11 @@ static void efi_virtmap_unload(void)
 	preempt_enable();
 }
 
-void arch_efi_call_virt_setup(void)
+bool arch_efi_call_virt_setup(void)
 {
 	sync_kernel_mappings(efi_mm.pgd);
 	efi_virtmap_load();
+	return true;
 }
 
 void arch_efi_call_virt_teardown(void)
-- 
2.49.0.1101.gccaa498523-goog


