Return-Path: <linux-efi+bounces-693-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD76887002D
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 12:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1F5B1C2351E
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 11:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAC239861;
	Mon,  4 Mar 2024 11:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HY8dWX8b"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7388239AE4
	for <linux-efi@vger.kernel.org>; Mon,  4 Mar 2024 11:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709551224; cv=none; b=No9UIKjBhrCORnU42Sun3eNucaQ/zCVtngGyzXv+T5SLLIX5BEqZ6COrU0AfO+xlDCrLmhX0WBp/nN75xjA+wZg87RvZuBzPCU3V8qDJ6AA1/cVQCH6zBfoB9KdrWkNSHUedXndzhqqx803Pz8y0+5EXOnhrpN/dU0DDVC+O4oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709551224; c=relaxed/simple;
	bh=BFiNWLCAe0jCC41FREpQH/wmzfLvfCC7xhwJrTAhOqs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Kvi+veWluoPfacordefdnVSL/OQjBDM+/LMuvumsl7nVr6oIRyiEBGu3+9I3vpjsrCa1OmzY1M4WB6THRZ07F3C3l8txI3di4NNJ8JAGmoD7FkhhEcOK/Vp+23cINV8qonermfxpa2dXkY8YcPXmTScm/8eW8P8z0YKxhz7v2CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HY8dWX8b; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-412d557cea6so10571835e9.1
        for <linux-efi@vger.kernel.org>; Mon, 04 Mar 2024 03:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709551221; x=1710156021; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ms+JKTISnZNQdC2YUh7lwAmB+kZyLlZbk/GzbIS13s0=;
        b=HY8dWX8bUh1AfyBRc3YTC3qDF5ZXn85GHpl+PSxdq2/FinCeYDx1s4VUS+u4ulp/Jk
         oiuGMlQAPYTurv+Myc4MCe5bGFfZBpXQrDKQgyw6s9B0lk2aR4xvoduwI0BTXEos+CJF
         hUVRsej2UrNs9HwIDSd1h8RysxiBd744XeK2V9UGbpohnmSYJIhcocBiApBvnlYJXsAv
         70KjnqVOKec0hqAZflP/ZEmzi6g1IvrVAU4oCHhWeKjEI8JQ5EDxVDLlFBCCLko4wcGX
         VSpZXIdC13ChGuxR6ymqYgc0xLyf8qKPCGfOylP23+0hhSayT++16bIXuWi08XWC3Kdq
         UyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709551221; x=1710156021;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ms+JKTISnZNQdC2YUh7lwAmB+kZyLlZbk/GzbIS13s0=;
        b=PFcSTvsorqvmWf5OF3SZU/96QSISaQIoEF2aqWjF0J4xGqUGEHSjmg01zr60z8hAKO
         3vAwZt6uUD0DNFn9MmoeCne9RaPDR0Mqq1r9rgayQwnLDryEhgQt/gtTb4JgmxHnPLN1
         a+aUwBLFA4/MHiU9Wa5q+tN2bSmyO+8J57P2kd0fuTag8d1UUfrguoCBQhjwfb1fLT8n
         ia8A4MZHj4dLg47s0rM2HkUVl8vOXtmDxsxFnuJMu06COU7SssbNKVYzSC2fuE5SBD/u
         MvamPr4dAPzbRJZv6E05is64Rkfot+y8MtKBZkHFvB8l30RhZsetDHx9jU5Aal5126U8
         gp8A==
X-Gm-Message-State: AOJu0YyeyxGAaDHk0EHGMUDS0mg/lP1eaujj1Sux8GnnpaiXrhkBzYF7
	kbhJoqSRDOoIJpqd30NH1quEW/AIX7lKmbV1aazN+8yabw/sneVSWNSGtRmhRdueBI3UKg==
X-Google-Smtp-Source: AGHT+IFO9r2f+sKEn5j5+2Hk7NZviOjP/K6hZ8dgylLJ/8KSF76c8BZdVV2oFE3f95NgCVk/JR7uB+XB
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:5029:b0:412:e84d:e4cc with SMTP id
 n41-20020a05600c502900b00412e84de4ccmr1383wmr.4.1709551221035; Mon, 04 Mar
 2024 03:20:21 -0800 (PST)
Date: Mon,  4 Mar 2024 12:19:39 +0100
In-Reply-To: <20240304111937.2556102-20-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304111937.2556102-20-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4415; i=ardb@kernel.org;
 h=from:subject; bh=CjvifhxZjqj5qUKlFUVQIX+zGzeNCvbb+z3eMz88VXM=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXpOq811n+fpQlEbH22Umw9i8Us/QiZWTy/88vLHt/p/
 v4qb7VsRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZhI7zZGhgfPz+RMZtRu2uJ9
 W6rVZWebeE2y5FrT9EJdjdKK+/uXLmNkmNXEtCNl3SwVeaa7Re2f/WPmz/ht/P9mROMxvfvbdTt 5OQE=
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240304111937.2556102-21-ardb+git@google.com>
Subject: [PATCH stable-v6.1 01/18] arm64: efi: Limit allocations to 48-bit
 addressable physical region
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

[ Commit a37dac5c5dcfe0f1fd58513c16cdbc280a47f628 upstream ]

The UEFI spec does not mention or reason about the configured size of
the virtual address space at all, but it does mention that all memory
should be identity mapped using a page size of 4 KiB.

This means that a LPA2 capable system that has any system memory outside
of the 48-bit addressable physical range and follows the spec to the
letter may serve page allocation requests from regions of memory that
the kernel cannot access unless it was built with LPA2 support and
enables it at runtime.

So let's ensure that all page allocations are limited to the 48-bit
range.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/efi.h               | 1 +
 drivers/firmware/efi/libstub/alignedmem.c  | 2 ++
 drivers/firmware/efi/libstub/arm64-stub.c  | 5 +++--
 drivers/firmware/efi/libstub/efistub.h     | 4 ++++
 drivers/firmware/efi/libstub/mem.c         | 2 ++
 drivers/firmware/efi/libstub/randomalloc.c | 2 +-
 6 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 62c846be2d76..a75c0772ecfc 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -103,6 +103,7 @@ static inline void free_screen_info(struct screen_info *si)
 }
 
 #define EFI_ALLOC_ALIGN		SZ_64K
+#define EFI_ALLOC_LIMIT		((1UL << 48) - 1)
 
 /*
  * On ARM systems, virtually remapped UEFI runtime services are set up in two
diff --git a/drivers/firmware/efi/libstub/alignedmem.c b/drivers/firmware/efi/libstub/alignedmem.c
index 174832661251..6b83c492c3b8 100644
--- a/drivers/firmware/efi/libstub/alignedmem.c
+++ b/drivers/firmware/efi/libstub/alignedmem.c
@@ -29,6 +29,8 @@ efi_status_t efi_allocate_pages_aligned(unsigned long size, unsigned long *addr,
 	efi_status_t status;
 	int slack;
 
+	max = min(max, EFI_ALLOC_LIMIT);
+
 	if (align < EFI_ALLOC_ALIGN)
 		align = EFI_ALLOC_ALIGN;
 
diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index 08f46c072da5..40275c3131c8 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -191,10 +191,11 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 	if (status != EFI_SUCCESS) {
 		if (!check_image_region((u64)_text, kernel_memsize)) {
 			efi_err("FIRMWARE BUG: Image BSS overlaps adjacent EFI memory region\n");
-		} else if (IS_ALIGNED((u64)_text, min_kimg_align)) {
+		} else if (IS_ALIGNED((u64)_text, min_kimg_align) &&
+			   (u64)_end < EFI_ALLOC_LIMIT) {
 			/*
 			 * Just execute from wherever we were loaded by the
-			 * UEFI PE/COFF loader if the alignment is suitable.
+			 * UEFI PE/COFF loader if the placement is suitable.
 			 */
 			*image_addr = (u64)_text;
 			*reserve_size = 0;
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index ab505b07e626..002f02a6d359 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -29,6 +29,10 @@
 #define EFI_ALLOC_ALIGN		EFI_PAGE_SIZE
 #endif
 
+#ifndef EFI_ALLOC_LIMIT
+#define EFI_ALLOC_LIMIT		ULONG_MAX
+#endif
+
 extern bool efi_nochunk;
 extern bool efi_nokaslr;
 extern int efi_loglevel;
diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
index 03d147f17185..4f1fa302234d 100644
--- a/drivers/firmware/efi/libstub/mem.c
+++ b/drivers/firmware/efi/libstub/mem.c
@@ -89,6 +89,8 @@ efi_status_t efi_allocate_pages(unsigned long size, unsigned long *addr,
 	efi_physical_addr_t alloc_addr;
 	efi_status_t status;
 
+	max = min(max, EFI_ALLOC_LIMIT);
+
 	if (EFI_ALLOC_ALIGN > EFI_PAGE_SIZE)
 		return efi_allocate_pages_aligned(size, addr, max,
 						  EFI_ALLOC_ALIGN,
diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmware/efi/libstub/randomalloc.c
index ec44bb7e092f..1692d19ae80f 100644
--- a/drivers/firmware/efi/libstub/randomalloc.c
+++ b/drivers/firmware/efi/libstub/randomalloc.c
@@ -29,7 +29,7 @@ static unsigned long get_entry_num_slots(efi_memory_desc_t *md,
 		return 0;
 
 	region_end = min(md->phys_addr + md->num_pages * EFI_PAGE_SIZE - 1,
-			 (u64)ULONG_MAX);
+			 (u64)EFI_ALLOC_LIMIT);
 	if (region_end < size)
 		return 0;
 
-- 
2.44.0.278.ge034bb2e1d-goog


