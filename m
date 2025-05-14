Return-Path: <linux-efi+bounces-3707-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4142AB7322
	for <lists+linux-efi@lfdr.de>; Wed, 14 May 2025 19:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D24551BA4F2B
	for <lists+linux-efi@lfdr.de>; Wed, 14 May 2025 17:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3353B28850D;
	Wed, 14 May 2025 17:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R4qN7BRR"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621282882CE
	for <linux-efi@vger.kernel.org>; Wed, 14 May 2025 17:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747244652; cv=none; b=VEG5oD2UQj9S0MlJWI/Jm5XhRVdsEeZtbCl2DvOis8RjvfC77lWmxiGdU6NG70wRvungGIu3700cjsnsCV/FrJUnsRuLt9KWfg1VxZWN+IWa8jCUSkhYW3HAxADQJP2A/0Sb5QnOvQfx1yXNUQAn8xY4+9Jg4dEB54N0W+GHrZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747244652; c=relaxed/simple;
	bh=mgDdIliBTbo4FHq86K7xhTUvkNSSj/cvEBekZIhmtfI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r3YvChPDxZ3fik3rQpZBk/30SzUii0A8YD2zF6J1E1wwaTs0ztSBfu6loKgkAHlN+Krxi4wy05l82DlHayCmQHZiGyWbjS503y/L8E3RstOnlVOLtsayS4G+PRF0npIqv+XpETVaWm9b0igqEPaJn/Ovp/Fa5pvAhiHbVs7pauE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R4qN7BRR; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3a0b5c28f05so17331f8f.2
        for <linux-efi@vger.kernel.org>; Wed, 14 May 2025 10:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747244649; x=1747849449; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9m/dA5u8PP12xTyLEA47VdMolfQQBYIbnFJL4eUuTIo=;
        b=R4qN7BRRQgaHkyshZKF8AKwLbTplteOlS2AQSM3EJXNCg9Hzlea+lK7KX0TGtWXX35
         GWHlBaDZcfJAGPjsMiNkzxRM0B+rz09iHYMb9jLEf6cEWwShFzy+7JaFNbRLCm0Y73LD
         8lwV48bDeWkwoXecj/oWnU0Z6wW3I30B04QUfE91xggQ2YcgQeAgW1QVsAYixzKYNjIS
         78h+A9xlmDpOvQidoPO1a1iTNvfUBDGhGAQX4irs2fQPdVLDkyx/+kp6chzLY7SEOKt0
         139x/I6veudsSpcNEUhrh0fcD1JnuSFBQODoGh+BK2zKUV7XuO6MmZXMr2SXvJO+t9Wc
         ekXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747244649; x=1747849449;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9m/dA5u8PP12xTyLEA47VdMolfQQBYIbnFJL4eUuTIo=;
        b=mcQ75fXw5mrF5vku5Ja7eB6eOnZS3vssp66q24mgSjBUEfMXvobqHRCf83V2x8Vyrr
         2eZ815c74GolkMppaVqHDqh4jhAEaFhudWV56rJ2OQYjcLs1ipFPvYx+PS9lERiub1+q
         EUQHCHWrNvSr8xc8UUWny6NnxcDUt9PXSQIN00XN5JlZkWGuU934kYc/2UDzwyGnY4Zc
         mMsVzz5hsDAv3YKd8SdV9EbeJAU4oafstZnzffzzAb2DF8x3OBOk0zD29msrRgg+U/lf
         bXsf854eKnsCKyVVgoLYQ6g56rIuZ6CIfZNlac1U/f6DS9HAxHlecZyfgwvQqVwAwCW8
         immA==
X-Gm-Message-State: AOJu0YzM0UATjWNvWUSeFQ+ewKB9Y6+Mexp4DfigY66Vx2iFKEAQ/p92
	lD3gL5gWIAmcrZPuRmoVSvfL7t6l5uQl8caYXj9BdvAN/PFJNcRi1MNt+TA0ESp1pIen1TW8tNC
	iIKGPrRKzURc00K/LNCTtoR+B+7plHI47Eyha43PFd/muJswuPtE7PuTjh+6KLNSu6d+ADBfqZ0
	+uVG3Gx0EDjDsntzHQWiJsW1BI0g==
X-Google-Smtp-Source: AGHT+IH3phkZ7ohlhjgxOaGGl2tv6LZdappybOOhIxd+mP8S8HpGAaQTtF38WgvqXaHzyraEHHalvwjR
X-Received: from wmbbe14.prod.google.com ([2002:a05:600c:1e8e:b0:43b:bf16:d6be])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:40e0:b0:3a0:b807:73f5
 with SMTP id ffacd0b85a97d-3a34994b80bmr3189200f8f.41.1747244649004; Wed, 14
 May 2025 10:44:09 -0700 (PDT)
Date: Wed, 14 May 2025 19:43:47 +0200
In-Reply-To: <20250514174339.1834871-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250514174339.1834871-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2681; i=ardb@kernel.org;
 h=from:subject; bh=JjGNi4y/M2NE/6+1Wwj3Vc6eI4ogOEIDwoxo0yxqFF0=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPlWniyzKukuNYtPWVi83+nOgoYcF7St7l2WeCP/LLzO
 Wr7m9d1lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgImk3mVkmHnt2ZKM6yE3I3Vv
 Ljbq2pLfmct77FIyQ2u3x8PJ5/XM/zAybGfwWlep2fBor0PGypszriS6OCo+zZojGrXHwTmjxqC NHQA=
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250514174339.1834871-16-ardb+git@google.com>
Subject: [RFC PATCH 7/7] arm64/efi: Call EFI runtime services without
 disabling preemption
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The only remaining reason why EFI runtime services are invoked with
preemption disabled is the fact that the mm is swapped out behind the
back of the context switching code.

The kernel no longer disables preemption in kernel_neon_begin().
Furthermore, the EFI spec is being clarified to explicitly state that
only baseline FP/SIMD is permitted in EFI runtime service
implementations, and so the existing kernel mode NEON context switching
code is sufficient to preserve and restore the execution context of an
in-progress EFI runtime service call.

Most EFI calls are made from the efi_rts_wq, which is serviced by a
kthread. As kthreads never return to user space, they usually don't have
an mm, and so we can use the existing infrastructure to swap in the
efi_mm while the EFI call is in progress. This is visible to the
scheduler, which will therefore reactivate the selected mm when
switching out the kthread and back in again.

Given that the EFI spec explicitly permits runtime services to be called
with interrupts enabled, firmware code is already required to tolerate
interruptions. So rather than disable preemption, disable only migration
so that EFI runtime services are less likely to cause scheduling delays.

Note, though, that the firmware executes at the same privilege level as
the kernel, and is therefore able to disable interrupts altogether.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/efi.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 5d188c6c44d7..1c86a891f6d7 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -10,6 +10,7 @@
 #include <linux/efi.h>
 #include <linux/init.h>
 #include <linux/kmemleak.h>
+#include <linux/kthread.h>
 #include <linux/screen_info.h>
 #include <linux/vmalloc.h>
 
@@ -176,7 +177,12 @@ bool arch_efi_call_virt_setup(void)
 	if (WARN_ON(down_trylock(&efi_rt_lock)))
 		return false;
 
-	efi_virtmap_load();
+	if (preemptible() && (current->flags & PF_KTHREAD)) {
+		migrate_disable();
+		kthread_use_mm(&efi_mm);
+	} else {
+		efi_virtmap_load();
+	}
 	uaccess_ttbr0_enable();
 	post_ttbr_update_workaround();
 	__efi_fpsimd_begin();
@@ -186,7 +192,12 @@ bool arch_efi_call_virt_setup(void)
 void arch_efi_call_virt_teardown(void)
 {
 	__efi_fpsimd_end();
-	efi_virtmap_unload();
+	if (preemptible() && (current->flags & PF_KTHREAD)) {
+		kthread_unuse_mm(&efi_mm);
+		migrate_enable();
+	} else {
+		efi_virtmap_unload();
+	}
 	uaccess_ttbr0_disable();
 	up(&efi_rt_lock);
 }
-- 
2.49.0.1101.gccaa498523-goog


