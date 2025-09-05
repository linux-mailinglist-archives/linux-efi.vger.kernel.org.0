Return-Path: <linux-efi+bounces-4696-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA7EB45914
	for <lists+linux-efi@lfdr.de>; Fri,  5 Sep 2025 15:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C56F27C3109
	for <lists+linux-efi@lfdr.de>; Fri,  5 Sep 2025 13:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A737352FFF;
	Fri,  5 Sep 2025 13:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0B1UPLpP"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A8E352FC6
	for <linux-efi@vger.kernel.org>; Fri,  5 Sep 2025 13:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757079051; cv=none; b=ix5FaGrbcqyvfByl0x/oV1VSNsM2Lssd3hRZKR95vjh38XKjSMVo2UAuT/EFjzihWyGbT/28mtK7Pv8RjAFHymqjwTjamMtPHArDalOVyJd8NoIbSE8eSZBlVa8NfS738MSGJM3sUZvRnMTxfArEYmEAvn78RpFYT4TCkx8r6FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757079051; c=relaxed/simple;
	bh=0m/8gh/l82++JSDONCCBj3AtslRmuEaMeOFM1uKkYlw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s5Y6xb2djlioAmcGhqkmK6bzJAHgOg717RxmXwsnDdAFo07GgscJ1rIrLxGJ3fi5q1xoK9eIC7OQJfenQvns/rYNmbNwnKPcNvIwUzkTyuG9JIbqpLl6pMMfzBAH15KcYKbD/FxABll47XRR80fzcBf3j3QTio9W7kHblfHte60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0B1UPLpP; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45d6c770066so12062675e9.0
        for <linux-efi@vger.kernel.org>; Fri, 05 Sep 2025 06:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757079048; x=1757683848; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RnWShrZLR7vPEU2B78j7+Lb7nzOaNYK0ui51c7MAe+o=;
        b=0B1UPLpP88rLa3lsWB90SnnJz8kOZRUsWx4a4yM3zXOs3gZPX1Ld0qfwt/3j9q+IGK
         St+WyCgVk4tVFOi+uhSTB87uGIxPyEsGIdWToUcP4aev5IJfNC4bncpr9LAl7G9O0/ui
         Wd6WwQeh0vbKnL7f/lzxrcBCszAHOuVl4IJPVdfgSYSVJHRJLHB7+y7HyJTvp0cWVmQ7
         OUg4a4FUs3gWp+Hc9+Yps/nSV4Ype/IXwpf4y6BTF5EGIO5SaLR+iVb6SlMpy1PIB5/6
         0dMX1LdyI51YbaanJbK/4fjRl38l414Hu1tc/wU7ZoX1jVVY6tGuExGZDQxRRt2Xx4bs
         v9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757079048; x=1757683848;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RnWShrZLR7vPEU2B78j7+Lb7nzOaNYK0ui51c7MAe+o=;
        b=o10ZmUP/fSmyQYXb0r9c3XWEGHbMI4V0ZKQNFQEzLLol5ceUPGPUY2X+KlUWCGtEJi
         mQUeFUwcXJLkzoYWs4JbyDpXobU11BFGe/YkyhK7Vva5mE43dUl0DG0wMYrumX2eXjB0
         PlMd/pcf0os0H1MrJBCV9US7JfgkGPdi4coGw7wyeY1PSwe2yrYOtTbCr4IttkWOp4sz
         wXabZ9PdX66VoZtH/tt6wQ47RLFE9ZI3gYUZWB8pFqW0QEoGN/zkhHOgMq/HuOqyhq52
         V+n4sux3ts+myhV5JKTwo8NHGfBn4o1u9nCeb0Ep3P+rPyNmrUAKKGscszWtrqpuZNC5
         fVLA==
X-Gm-Message-State: AOJu0YxTHKo1KyZbvaggmUIMPdTpfquBOeZ79EelyuTR4cMX0tKvM+2f
	6MS/KG4PKaEOfp5lvUDNDyD2+HfIM6OBTcSv/ppezT9LONEdzvDB5HcANfBfhVMMr6szz9gtymf
	b5PNTGkZWwqOls+ScKWnvyozQBbXSLb+D6IxocgrEC5r7R6sQ4aDvVRDkHZ1oUVunoJRRfvNhwl
	icjEIwzYP20oVSB38Ej5Bwo3SvF3X5XQ==
X-Google-Smtp-Source: AGHT+IElALc0lZ+KzdRQ2dRMVCGqhkLpgISWWuaMfOGta1rBFF8GrBs1+cH4A40kb4E6vXjqoOQHmNcF
X-Received: from wmbhj7.prod.google.com ([2002:a05:600c:5287:b0:45b:883d:4704])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:8b22:b0:45b:4a98:91cf
 with SMTP id 5b1f17b1804b1-45b8554fa14mr221341505e9.15.1757079047829; Fri, 05
 Sep 2025 06:30:47 -0700 (PDT)
Date: Fri,  5 Sep 2025 15:30:38 +0200
In-Reply-To: <20250905133035.275517-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250905133035.275517-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5534; i=ardb@kernel.org;
 h=from:subject; bh=j5/ecr8uALf7Q3nJBo6TOOBIUrCfY89Wx0Sfg11CrLo=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIWPX03/PGg7Hc66b+swzatZ//hyxHTtL6q8f+id1TzVOs
 mP7n33eHaUsDGJcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAij+8yMhyzX+Fb8tmx1cBh
 ubWomssPdta0xuBQ/kRP/ZqzT5JMDzAy/D6vknj/wtZNKmIrLhlwyp7sfPve3XVZjKvxH7cjZzi KGAE=
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250905133035.275517-11-ardb+git@google.com>
Subject: [PATCH v2 2/7] efi/runtime: Return success/failure from arch_efi_call_virt_setup()
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
index 6c371b158b99..9b03f3d77a25 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -167,11 +167,12 @@ asmlinkage efi_status_t efi_handle_corrupted_x18(efi_status_t s, const char *f)
 
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
index b4409df2105a..d4b1e70f41fa 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -443,12 +443,13 @@ static void efi_leave_mm(void)
 	unuse_temporary_mm(efi_prev_mm);
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
2.51.0.355.g5224444f11-goog


