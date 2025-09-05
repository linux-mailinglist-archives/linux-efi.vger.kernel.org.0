Return-Path: <linux-efi+bounces-4695-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 027A6B45912
	for <lists+linux-efi@lfdr.de>; Fri,  5 Sep 2025 15:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FE267C1806
	for <lists+linux-efi@lfdr.de>; Fri,  5 Sep 2025 13:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77FD352FF3;
	Fri,  5 Sep 2025 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N6vDMzco"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313E4350D79
	for <linux-efi@vger.kernel.org>; Fri,  5 Sep 2025 13:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757079050; cv=none; b=eS/bA9dvIAGgMGJ6r792OarhmFVQcRK5IMJvr7QCa3WHJpLLglc0JwxcKcPMRsEKfQvjKCOWTGKnR0cdgsqZbPr6LYV3QnEsS8QbLpHwBJzq5wfAEzlXxKH/xcUyo5gqSCeUZNNeE0F9vzN5724UKBQIf2vNkme/w7F26Ktj+og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757079050; c=relaxed/simple;
	bh=CACsa0TRT4zLg+xaffuStRVEVsT6GgVRc8Y4viIqiNg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RMgLoW+G17+90WSmAjoG4XzcR+MmapBnND4dQ0ufmJp0mXtxuKFrweY7s2QwSK7tktpBQfvuhqZcn676u7nfSP8shGrZnvlXS3U1TFQ0BFway4IwEigWPmfezL2GChbw5PxoFaxZulwOuHP4JZFANGR/tM9spp0P0jN1ZY2oSaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N6vDMzco; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45b80aecb97so17867775e9.3
        for <linux-efi@vger.kernel.org>; Fri, 05 Sep 2025 06:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757079045; x=1757683845; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8ZHeDW24WP1XSFE+jvhzynpDGxt9MOiB64/YvwvtypQ=;
        b=N6vDMzcoN8krk50XSTlbW9476K9TOs+Ld3cjlBhcRinPiAmOvc+KvYtoPhu81HTJsD
         2E3zAkt9GFtxmDv+dZHpXD0aCPkX/qCs/ttFROMX5g/zbvikALQIgn7jTI3lZ+9CZe80
         qqwVJnkysqu5jHD9dy5fMjZXr7MbXOwp8h2vfNUjdxsKhCB0qhfLlRCFmjPKr/WPpHWe
         6vwfsMBZBvbR2NMbqpf9yXUC3V+FHBFKJAu0A3/mOacwkdLu+SIvs1wlmHIZoIHhor5P
         bieTM5uiS2ANNBoPw9kMOfo3lGZV5jLaY1Zq55ORQvRIciFduCalllJK+1opNPrs+GYf
         IhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757079045; x=1757683845;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ZHeDW24WP1XSFE+jvhzynpDGxt9MOiB64/YvwvtypQ=;
        b=CLoGvUvySGgtVkNX2NsWWwxVLdR0R8ImK6BrBMDY7BcWtJKtAfWCwfa7yrXuBu8DlY
         9FI4wv6vfLQX7xF1vRnlGhh7aswQRfFZpHBWfivxrahDBV/uOFUIx6BRGcQxqRXiqYWM
         VOkwVWfVxkkvVrPt3KoJ6D8bxTKVg2HBcxbRdKIdnySlEpTCyE+HpbAYw6cbe/1zbpa5
         0o0o6gwxYVUjKMKlcBd5IV3ADazfHMqDVohv3CSsle/YhtYhBc4EMckpARzd+O4aXAh/
         Fdwd4Raoax4yCa/kPmpUi5e46QuKUE8ildjiv/SIZ+dQfk0wZDwxi3neKXpxSbacaNGA
         hytQ==
X-Gm-Message-State: AOJu0YyiRN3mib9Nx9F05ARFyAN/8lyilrEb8rrgZg1wFWJdCz1/ceHU
	K1B9s2WXjbT+2mK4J8uMNuJquJ6+FqrBYiUIZXkAUiHkdwZpzUx+8NgVyQKpm6XJ+pJPy9azxVu
	xZcwF6fVBAawu6SkOLMW1ICqxiHLtIfafZFWH1PI9Qb+GUCkwi/mCtisM7gE4rMtGhvYsnAUrio
	qZ1Ma0WuiiCzvjCaTnBU1AfEgr36Pm5A==
X-Google-Smtp-Source: AGHT+IEcAay+d9Q2HsIqksVMZuwbG0fIEpd9hdFpt9bpO8YYAbsVZJ7hLJVUgxBdyn6pNK9245tvkFy+
X-Received: from wmbez15.prod.google.com ([2002:a05:600c:83cf:b0:45d:d3ef:abb8])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4e91:b0:45d:5c71:76a9
 with SMTP id 5b1f17b1804b1-45d5c71790bmr73776295e9.24.1757079045445; Fri, 05
 Sep 2025 06:30:45 -0700 (PDT)
Date: Fri,  5 Sep 2025 15:30:36 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3170; i=ardb@kernel.org;
 h=from:subject; bh=JoTq1uEfGexvL5NaCkoOvfw2N83VC/SjYfCd8EObR0A=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIWPX0z+6Ky32OJn582/nqjMS+dvcaZvE9luse25HgcKnW
 t6ujlsdpSwMYlwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCKyTxgZduyImn9pcsfZ5GDD
 2zHSRUlG/hr3lGN3W+tada9l8ZKOYGT4dVPw7USe2ceu/tOX33tk+ZNpQTX7b7zqPnNMpnvP53Y lbgA=
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250905133035.275517-9-ardb+git@google.com>
Subject: [PATCH v2 0/7] arm64: Make EFI calls preemptible
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
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

Ard Biesheuvel (7):
  efi: Add missing static initializer for efi_mm::cpus_allowed_lock
  efi/runtime: Return success/failure from arch_efi_call_virt_setup()
  efi/runtime: Deal with arch_efi_call_virt_setup() returning failure
  arm64/fpsimd: Don't warn when EFI execution context is preemptible
  arm64/efi: Use a semaphore to protect the EFI stack and FP/SIMD state
  arm64/efi: Move uaccess en/disable out of efi_set_pgd()
  arm64/efi: Call EFI runtime services without disabling preemption

 arch/arm/include/asm/efi.h              |  2 +-
 arch/arm64/include/asm/efi.h            | 15 ++----
 arch/arm64/kernel/efi.c                 | 57 +++++++++++++++++---
 arch/arm64/kernel/fpsimd.c              |  4 +-
 arch/loongarch/include/asm/efi.h        |  2 +-
 arch/riscv/include/asm/efi.h            |  2 +-
 arch/x86/include/asm/efi.h              |  2 +-
 arch/x86/platform/efi/efi_32.c          |  3 +-
 arch/x86/platform/efi/efi_64.c          |  3 +-
 arch/x86/platform/uv/bios_uv.c          |  3 +-
 drivers/firmware/efi/efi.c              |  3 ++
 drivers/firmware/efi/riscv-runtime.c    |  3 +-
 drivers/firmware/efi/runtime-wrappers.c | 20 ++++---
 include/linux/efi.h                     |  8 +--
 14 files changed, 89 insertions(+), 38 deletions(-)


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.51.0.355.g5224444f11-goog


