Return-Path: <linux-efi+bounces-4936-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A40B9AA5E
	for <lists+linux-efi@lfdr.de>; Wed, 24 Sep 2025 17:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A3481B20338
	for <lists+linux-efi@lfdr.de>; Wed, 24 Sep 2025 15:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AAA30F921;
	Wed, 24 Sep 2025 15:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n0ZYbI6r"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C756F225A35
	for <linux-efi@vger.kernel.org>; Wed, 24 Sep 2025 15:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758727648; cv=none; b=qMa1HxmxBLCXUXAThBAPMivcebrANMWA1Qef6090PtwPESFyirEue+j6lVxgE/vhaKrELPvr0bsFUhVilouomftk29YqBffEWAS523FVXUmAc3eM9a/ITQBDaXQTv40zse08z9u1xN+wFWNDphZYI9Rm22bqx6JVrNZ2CU4zL9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758727648; c=relaxed/simple;
	bh=8ElRhhP0NIO5VlAhDDRg4x0RBQJvP0L/UFeQfgcITh8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VBZcT+uOsXkM4THIq5GIg1++lF8hYfpPP4KZ1AWvLX/KrcfToiS9Ksrn2K/+btWcghsM15YOl+Uy6sj4zfcvPhLCJ/SfbPFDEffNJdFsx+URnskcVlJf7+bAegUTL2SxhfL8nUW0UQGjF9fti2VoVCWkO6FYS3RcXojhZx6Xvfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n0ZYbI6r; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3ef21d77d2eso5500485f8f.1
        for <linux-efi@vger.kernel.org>; Wed, 24 Sep 2025 08:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758727645; x=1759332445; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NYzK0BK39cJnHRdQugTIBsQkrQwHuE548EDpH1xnRfg=;
        b=n0ZYbI6rjlpLiNdtsfpx95U8+8gSsUDIt4kOgigdozQvBcec57iX9Qs1uUTZWHh1zo
         xGd5Rdvm6JTFEzLtixNJXldZRzTqCcSyUnktDMQUJYDnOpVquMxxjcfrr958t6UfQOcI
         ygR88GNvbQqvCclbgpF8ytNV/BaifA1UtX796bgKiPBt0vB3HGdVvuJUtfX6KFXW3Wdl
         b5/Z4avRJ1jSg8nfWJBuuj+hAurhztqkRgZ1Xx82QSh4HChG4YkfVGFT/IUmbbofV2N+
         WuUonqtlDU7htBYg0krpbOB3iNUqyN8+swKKiG671H8bsmNgKSfwNZ5Eh+pJPa5BhCeI
         30yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758727645; x=1759332445;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NYzK0BK39cJnHRdQugTIBsQkrQwHuE548EDpH1xnRfg=;
        b=MuEFwbZK+jAog3mRMwyvfdqw0mCd3VE53N642j/7j4071QZTWe9y+2C3pIjIytbG3G
         eysAyNpJlq4OB5l+/JE8RrkEOLtgVHHK97Wp4qFSn0RcVTZbpPgg51AofNhTALgSMjnu
         YXhakRJBvqjJjQ6ZPoG3Fl+yMCO+4E9XPBQ/tQ272mjq5+kEJaTBi/Ai3vYqr2ivgMYg
         DGA+Kd1K7x+BOJ08Ky+qbOdGqOtXi1fwot2gQdJ4POXR5ctBihhjpf41xg/10VaklTCr
         E0mzUtr4ugyhsGAaPHORLkSk3yX+L1udlfty81sbCzKFFKi4V9mEFQGeBbcZ4vYJnF3h
         Ef6w==
X-Gm-Message-State: AOJu0YwB3ulhcvxWPX9oIOzNJ8z2sk9IhiVCAB08ArVwpH3fC/E5HNU+
	a3DRLC2sEk7mW7aKoqR6XjtLshmN2N9HoeTTJbwuATsTTu2moeY8uIxql52+hpiVYIIEKD1cFeV
	BSsfyKQIXCxGcndBJpPlvP9oyZihQZOTDcvak37RCz5bhbxj6t+CWob6JC43E+d9/FUnnifnZk2
	Uwa6V2xkG7mYJGfdk6sqsSvG0qPpybKA==
X-Google-Smtp-Source: AGHT+IHbefrd02lhuZ2Flyflx+b1N4aukNMbcJw3L7x/UfQUsJh20GIK+Ij/1IA/5QQZNocLfgc5VgIO
X-Received: from wrim2.prod.google.com ([2002:adf:e0c2:0:b0:402:d4b3:e79d])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:25c3:b0:3b7:8da6:1bb4
 with SMTP id ffacd0b85a97d-40e4accc86fmr331285f8f.58.1758727645084; Wed, 24
 Sep 2025 08:27:25 -0700 (PDT)
Date: Wed, 24 Sep 2025 17:26:52 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3866; i=ardb@kernel.org;
 h=from:subject; bh=0ixWJi3tkymt62w+b2ulCqVUiaEKpOKlW7m61PJbgfo=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIeMK754OwZUmBt/WPl/IuNOg58rHbl0hOb2qBCEL7pdVU
 Y2fyys6SlkYxLgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwES8cxkZ1glsnq4m6O4fPuO+
 bInqbu4KR8H63ItGL9ylRBTubNj0jpHhx0eZMwf176V6nrh/5n7CYca/k6W+/vhmw12f/pddySe YCQA=
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250924152651.3328941-9-ardb+git@google.com>
Subject: [PATCH v4 0/7] arm64: Make EFI calls preemptible
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The arm64 port permits the use of the baseline FP/SIMD register file in
kernel mode, and no longer requires preemption to be disabled. Now that
the EFI spec is being clarified to state that EFI runtime services may
only use baseline FP/SIMD, the fact that EFI may code may use FP/SIMD
registers (while executing at the same privilege level as the kernel) is
no longer a reason to disable preemption when invoking them.

This means that the only remaining reason for disabling preemption is
the fact that the active mm is swapped out and replaced with efi_mm in a
way that is hidden from the scheduler, and so scheduling is not
supported currently. However, given that virtually all (*) EFI runtime
calls are made from the efi_rts_wq workqueue, the efi_mm can simply be
loaded into the workqueue worker kthread while the call is in progress,
and this does not require preemption to be disabled.

Note that this is only a partial solution in terms of RT guarantees,
given that the runtime services execute at the same privilege level as
the kernel, and can therefore disable interrupts (and therefore
preemption) directly. But it should prevent scheduling latency spikes
for EFI calls that simply take a long time to run to completion.

Changes since v3:
- Abandon changes that disallow EFI runtime calls in hardirq or NMI
  context, as these might occur when EFI pstore records an OOPS into the
  EFI variable store. Note that this suggests that preserving/restoring
  userland SVE state in such cases is rather futile, but this can be
  revisited at a later time.
- Drop the lock in the arch wrapper, which has become redundant now that
  all EFI calls are serialized under the efi_runtime_lock semaphore
- Add code comment to patch #4 to explain the kludge
- Add some acks from Will

Changes since v2:
- Permit ordinary kernel mode FP/SIMD with IRQs disabled, so that the
  special EFI case only deals with invocations in hardirq or NMI context
- Disallow EFI runtime calls in hardirq or NMI context, so that the
  special FP/SIMD handling for EFI can be dropped entirely
- Use a mutex rather than a semaphore for the arm64 EFI runtime lock,
  now that it is never trylock()ed in IRQ or NMI context.

Changes since v1/RFC:
- Disable uaccess for SWPAN before updating the preserved TTBR0 value
- Document why disabling migration is needed
- Rebase onto v6.17-rc1

(*) only efi_reset_system() and EFI pstore invoke EFI runtime services
    without going through the workqueue, and the latter only when saving
    a kernel oops log to the EFI varstore

Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Brown <broonie@kernel.org>

Ard Biesheuvel (7):
  efi: Add missing static initializer for efi_mm::cpus_allowed_lock
  efi/runtime-wrappers: Keep track of the efi_runtime_lock owner
  arm64/fpsimd: Don't warn when EFI execution context is preemptible
  arm64/fpsimd: Permit kernel mode NEON with IRQs off
  arm64/efi: Drop efi_rt_lock spinlock from EFI arch wrapper
  arm64/efi: Move uaccess en/disable out of efi_set_pgd()
  arm64/efi: Call EFI runtime services without disabling preemption

 arch/arm64/include/asm/efi.h            | 13 ++----
 arch/arm64/include/asm/simd.h           |  2 +-
 arch/arm64/kernel/efi.c                 | 46 +++++++++++++++++---
 arch/arm64/kernel/fpsimd.c              | 29 ++++++++----
 drivers/firmware/efi/efi.c              |  3 ++
 drivers/firmware/efi/runtime-wrappers.c | 17 +++++++-
 include/linux/efi.h                     |  2 +
 7 files changed, 86 insertions(+), 26 deletions(-)


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.51.0.534.gc79095c0ca-goog


