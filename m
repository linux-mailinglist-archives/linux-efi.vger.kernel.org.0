Return-Path: <linux-efi+bounces-4850-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5DDB841BF
	for <lists+linux-efi@lfdr.de>; Thu, 18 Sep 2025 12:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A05E4541762
	for <lists+linux-efi@lfdr.de>; Thu, 18 Sep 2025 10:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E892F90CE;
	Thu, 18 Sep 2025 10:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ScZE1Ul+"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E852F83A2
	for <linux-efi@vger.kernel.org>; Thu, 18 Sep 2025 10:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191438; cv=none; b=QxX1Pf9HGQinqoawfVDaesgCUkA/jLC71VmgxxTcss4ijyV16BXX0JHtMoZtT3wp4B8JuGc8O3WEsTN/d+EOySq1BRRsR4XzGq8HSplpDj2xd/6GdkslNUZsdLjU75X2FJaqifKVd+0aGZbx2p9zRNQNPCh28+sqrbGKGxDOUT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191438; c=relaxed/simple;
	bh=gh+SqZIPfKchODHEEMzVSO+ljFxyxhrM3bb24+dQSjw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qLkt4PPTsOaE/RVSaUJ1PDT2ub9hugkBNC58IhAX93lu2ikJ2A2WfVh3qdHxgohJ2PO22n1pqu+mb9APV/dW6hJlUQEa7nayfl1+julEPEh0JNteUJrLGbY/eocuyqnuYGCDa7Ua/GXZj9Jvq0bDGDp9txjcj6oQ+QuZjlU5pQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ScZE1Ul+; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-627eaf68bbfso648602a12.1
        for <linux-efi@vger.kernel.org>; Thu, 18 Sep 2025 03:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758191434; x=1758796234; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bkJPq8vMT8jfjXgOksIkMdTefdHPb/Z7GDoGNb5nNT0=;
        b=ScZE1Ul+xZ8+fkMtlryL14OdAO0xkfofr85XtnkznQi427IW7X81GliW6ls1CDxRyr
         Tty810ENBv6lsaldfV/kCpJz/XDvDBvMaKfTVl2I5YjMrSBH97X/8yWf9YSeXV90ZvF7
         W/VOM1ohZ4F1JFyIr7dT6fIAxlqKXxHduiDg7PILdSkwkt3hh7UHIMvaFzlvIZsAsjeY
         Zkl8Bi0t7ajrwnD8J/FuUMEDB3RdsEoVozI9nUjUaed7h+CunzoCnxLdnLQlpoTvgI7O
         dl89ySceAICy1SF6E7sxkKCC4+eRzPeAu2BJeO7JdKCH2qoQI2MNkmeXEXpr6T+SJ6/c
         +ZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758191434; x=1758796234;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bkJPq8vMT8jfjXgOksIkMdTefdHPb/Z7GDoGNb5nNT0=;
        b=YZwp89ZxPtNkbTLBO6B9HQW75rTwXPo3RqeC9U7N6p4O8GfexDNpZqI0pSh4ZbUQnE
         T7edXe3on9blYlIsmrTfSk018HkRdFiQ3OfWaZgFM3u/fwkv8X3sdxdVvgw6R6rbuiOS
         SupUfqMO5G7QPs8v1Ij2Wjdhh70MfHncFiDN8oxhZZO5HHF1JbjSPEeizT15aT01L6tE
         u8P9JBWdiDN7atMi/1KOC/El/bFjQjAt/1I/oHTwzT8n2d5oCqSNMXTdkV66F124NWqZ
         mOGaX+OfsvW/6yPI81nOAL8wk6hZGQU/0Ijel5vBPOBhLnhdqsovkw+FrFy8FT2fRe0d
         2p+A==
X-Gm-Message-State: AOJu0Yw4ldhOBkYIXqezpaaGrzncgXAqQN4YW2PxwbrZVSsTpbCkFv1H
	cuYEL+BsCzoXOiILGODu4WMsFpbtxTAQG5giTv5j2/jV3MUaF5HWOHdLW/8AA/aIE8D9EG0vyO9
	qcT+eXUxQ0uuMVh1r0bmAEDDKYrdVNN4AuZ58hqWCquqImK4ff9K1YM5WKspHRd0Ntiew6T/oQ3
	V3k4NyKC5DUeFrYziDfTYJPaSLiheXGA==
X-Google-Smtp-Source: AGHT+IH7GEHEQMPK5uR1AbK9qmrBXkbgHp6FO/i5/9MrPBxJXJII3NY2OOT9yPIy1QWcK3kcEWkWsKjc
X-Received: from edf16.prod.google.com ([2002:a05:6402:21d0:b0:61a:94f3:bf7b])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:46cc:b0:62f:8274:d6bd
 with SMTP id 4fb4d7f45d1cf-62f84213dafmr5553015a12.8.1758191434483; Thu, 18
 Sep 2025 03:30:34 -0700 (PDT)
Date: Thu, 18 Sep 2025 12:30:11 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3840; i=ardb@kernel.org;
 h=from:subject; bh=g/6iYjL/DBpqLHEsAcR+wB8/PZx01DdNCswq0jym5uU=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIeP0feP7mxklXj1nvFN8I3TVwrAPR0SLDTZenazq+aau9
 0H0rOOhHaUsDGJcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAi4fKMDO9eRs3N7ruxmFnw
 s++1z9P1F2d87b5luzR7h/2OKPvizDUMf+WPbAyvDgqS1o+LYG6p7I9yeWTNptL6mt9LdPHxlXc 0OQA=
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250918103010.2973462-10-ardb+git@google.com>
Subject: [PATCH v3 0/8] arm64: Make EFI calls preemptible
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

Ard Biesheuvel (8):
  efi: Add missing static initializer for efi_mm::cpus_allowed_lock
  efi/runtime: Return success/failure from arch_efi_call_virt_setup()
  efi/runtime: Deal with arch_efi_call_virt_setup() returning failure
  arm64/fpsimd: Permit kernel mode NEON with IRQs off
  arm64/fpsimd: Drop special handling for EFI runtime services
  arm64/efi: Use a mutex to protect the EFI stack and FP/SIMD state
  arm64/efi: Move uaccess en/disable out of efi_set_pgd()
  arm64/efi: Call EFI runtime services without disabling preemption

 arch/arm/include/asm/efi.h              |   2 +-
 arch/arm64/include/asm/efi.h            |  15 +--
 arch/arm64/include/asm/fpsimd.h         |   4 -
 arch/arm64/include/asm/simd.h           |   2 +-
 arch/arm64/kernel/efi.c                 |  65 ++++++++--
 arch/arm64/kernel/fpsimd.c              | 137 ++------------------
 arch/loongarch/include/asm/efi.h        |   2 +-
 arch/riscv/include/asm/efi.h            |   2 +-
 arch/x86/include/asm/efi.h              |   2 +-
 arch/x86/platform/efi/efi_32.c          |   3 +-
 arch/x86/platform/efi/efi_64.c          |   3 +-
 arch/x86/platform/uv/bios_uv.c          |   3 +-
 drivers/firmware/efi/efi.c              |   3 +
 drivers/firmware/efi/riscv-runtime.c    |   3 +-
 drivers/firmware/efi/runtime-wrappers.c |  20 ++-
 include/linux/efi.h                     |   8 +-
 16 files changed, 104 insertions(+), 170 deletions(-)


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.51.0.384.g4c02a37b29-goog


