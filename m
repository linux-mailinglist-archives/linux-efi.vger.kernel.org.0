Return-Path: <linux-efi+bounces-4852-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2033B841CE
	for <lists+linux-efi@lfdr.de>; Thu, 18 Sep 2025 12:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCCD5526645
	for <lists+linux-efi@lfdr.de>; Thu, 18 Sep 2025 10:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EB4302174;
	Thu, 18 Sep 2025 10:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C1RulU24"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF2E2F9DA5
	for <linux-efi@vger.kernel.org>; Thu, 18 Sep 2025 10:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191440; cv=none; b=Kekap0ZGhlmplXtPr7nz9w4YgczF87RGXOlcqHhFzrYhnYuxl3JfwHNrptozQd5tWJjKzzTBURwg/FVKpLlxA/oKQFpDBlKcg6Tp/wVMmHsLIzOlvCcJRgsK2b2kKHQm7KoanR35u1Le8QW7qGVxs5Wk2C4gApTvDBaL9xaj31o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191440; c=relaxed/simple;
	bh=XX1si8MsLZL6DKbFp9rsm3tH13zIzZwGncktoL6Zm9E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WssfWaYHBwngZEO7LHUTblDBeBFzySlUHOI7riNGbNUTnZm5GMmlYTXsSyF5ZrjMLqs0jzHHi0Ei3Y8ey98XxmtqJCdmIRL09K9eatG/pb2SdgX84lA+aj/3/0DX/b1LMdFzeiMaVOp7XFd3uBoOJ+n50sqXvZPf2eZ2mHDjUB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C1RulU24; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45b990eb77cso6246205e9.0
        for <linux-efi@vger.kernel.org>; Thu, 18 Sep 2025 03:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758191437; x=1758796237; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sJFIm2d9T+2x529qILYhaPbYtpi/V7t2rebVAI4uzpE=;
        b=C1RulU24pVgCPx4evYkikxWQruhAdnmSUJOKCKgxbm7tnydgP0yZap5b+kAYlHcBns
         vyPjN7UoieDo71pah13bv6c+UNNklLH+KdnXQe7cHgR2sNl0K6MEURzYF30+MqeS6DUY
         8ZEN2qMs+SR5Z9G8YkJX7hQZeemyrqdd+8MLlQiZCeXLgWQ1O2KUK0jXG9ROmuORrSvj
         himmS+R8dlJF3Y8zVQfSFrDR7y8Vb2wcQ8/trdlFkYOfFclB4QzLJAAh9EHoQQhfoofS
         e5eSgzXlCt/Zv3IDhX+JOVhJeXRqxQVUEfTJ+QYhGSL31lBY2OVIcFycA152cqv/ZQuY
         3eVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758191437; x=1758796237;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sJFIm2d9T+2x529qILYhaPbYtpi/V7t2rebVAI4uzpE=;
        b=KDPhzhvXoTPbMR8pVsdPwIS+T15FonPjQ7Gkw0HFkprfqzvjy50lCtzu+SAsH6JbPU
         6dcbMD4c18V77bzrdlGt5tt4vAIaGpXyjkHLozvCy/l5SY1ANdUTXrGB8PF7kgwHGztO
         EgZHYnc7naWAOvMnhsNqmp9/cq6NLaRYdqALfewlkWUgJyH2kYg8dcAakM/x4E4uHiLG
         FVWa+McNHMu0faT/ZedSfo7xAdwJzgs5Gw1bJ5TV+IIVJmw0M9XeDfaPIWw/ZdxrQPlw
         aS6QHFuD4aU89E4lemr6KkBYwJgPlJYWzBykjwF1F8Fw9x/ew3nYJmcjcO6nvoagwqWi
         3/Dw==
X-Gm-Message-State: AOJu0YxA6ZSVfPBVg2DGNuFF/FBqJ9Naer7SmSQTlF9sNBMLzlO9YWWi
	jMOOQSjQRQHVbL+3NOjmsItAjSjqkawfT9P87qAtXlqn+3ui1lQLXWPD4gA8h6sr3Mj3htayAP7
	w8GaJnkg3RCptquF6LOF07Mye7lZOurUjb39LakRgDJY7LMW3zaxQyyocD+zQIAaPuFus3PFwVq
	oBY9VV71KM6EQPnS4lI0CdvdtUH8wpJQ==
X-Google-Smtp-Source: AGHT+IECq4I0w3/6A7apwZOsonOjQiQiwYahHKMYIdDTMnYZ7BWgqvCSc9iRaAPTx8Hq2U9oL40BX8Uq
X-Received: from wmbjg18.prod.google.com ([2002:a05:600c:a012:b0:45f:28d1:7681])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a7b:cc13:0:b0:45d:5c71:769d
 with SMTP id 5b1f17b1804b1-465045b4a35mr22803025e9.8.1758191436765; Thu, 18
 Sep 2025 03:30:36 -0700 (PDT)
Date: Thu, 18 Sep 2025 12:30:13 +0200
In-Reply-To: <20250918103010.2973462-10-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250918103010.2973462-10-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5534; i=ardb@kernel.org;
 h=from:subject; bh=jAbiLA3tzC1h/HOwCrnaLpF/g7Oox62158I7TXeI+Yc=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIeP0fbOrV0QyptVlWF8wjmZdefrUxse3p3dosdhdObh1j
 7XsOrVJHaUsDGJcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAiKYcZ/ifGJYSa/tkbFLAs
 8frv13Nephy5xcfFFbx3otAZ/U8hZ5Yz/DMIqHx75Y+EkqJo6Ml5ApsXv1Ow4a9T2ZziNXdjXsK e5xwA
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250918103010.2973462-12-ardb+git@google.com>
Subject: [PATCH v3 2/8] efi/runtime: Return success/failure from arch_efi_call_virt_setup()
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>
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
2.51.0.384.g4c02a37b29-goog


