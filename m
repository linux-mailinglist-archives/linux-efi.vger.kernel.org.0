Return-Path: <linux-efi+bounces-5926-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D80A7CDED5C
	for <lists+linux-efi@lfdr.de>; Fri, 26 Dec 2025 18:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6CF213000923
	for <lists+linux-efi@lfdr.de>; Fri, 26 Dec 2025 17:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA6D2DA758;
	Fri, 26 Dec 2025 17:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cIOLFpz9"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F89B139D0A
	for <linux-efi@vger.kernel.org>; Fri, 26 Dec 2025 17:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766768458; cv=none; b=DRIRIBJVQ8Orc8weQ/gsh4aQErpoBcU9Kkiq471t0d3Vv7RxEvMaGGAXSih44RHFE2QE1d4BIv2Rm8AsxEaBc5ybeyDiMzzQEM0Az/U/xQX3TKUWZOB0LYRdzVyA56IAWJoYubzg1p6VyLrvah32DajedfX8IjN8Xd4F13F2x30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766768458; c=relaxed/simple;
	bh=9p0wEfN53oRtIPmuDjAZhb7Jn3XncK4whcljIT5vIuY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Rl8DjwCREB3C7fnM7yNbQC+zkk+i4WiraLzG5lzjK+ddYFiz4ej+Z245eAZ+OtpLDVeijCDZAbMX1tSiRG2c2DqkFz4Mgx0gTpflA73xlK/6Hh8FZ2+c6LNpr3BU0KIXLEJ1d0e3+I+1gQfYRDPinWIM1Df36ytNtb3FcOJSRBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cIOLFpz9; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47918084ac1so62019205e9.2
        for <linux-efi@vger.kernel.org>; Fri, 26 Dec 2025 09:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766768455; x=1767373255; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RRlOIWDggfCIZvxx4Cl5g7ki5UIRlY6KVxf9rSwoDPc=;
        b=cIOLFpz9zzNDT7ERgM+RZEtpcspWLMbqBiUypAwucNqL2u7qZhX+Zr/OzS5Bu0UF47
         5d5bRNZQP6kJ1vgmCaDs2wDOSoknPTOcRd4z99D2fG8TmjiNVx3/+KNQRub3cLen1JWb
         qI1ePl4vDBC9In1rl9MYusQIh7jAb7HGA1D5tpsLMb9SCj9oMhoIP5o22BIT4GVTsNGv
         mCTSePpbss9UVfQDVyjbUvVxjKUX/LR+piqpNu/SMUmbDJHJR8s6r6fAxcSAkZqcEYTh
         gbw6ICgrSerzQ3hKdX8/VWotNATt+nT82QQjM9SHED9V/3nnyQRupNvvpaYY0GclgDZO
         G3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766768455; x=1767373255;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RRlOIWDggfCIZvxx4Cl5g7ki5UIRlY6KVxf9rSwoDPc=;
        b=HPy+x8SVR01pJL61KZ7pMFR0zFF5qQxmUs2jpsP3McILdb8U7ZYOwC5QZrrAQMdP/s
         IaloupH8yhKEnhqgBhKQP+CdSzaQvpDnsO4XkB3NfojkZMrJffzbD+b9Y+19Fw3ODT7e
         Uhf0ZolPWPkqLrqP+0WB5BJVykq1EHLHAjTYPMhixJCWV/NvSJ1UMUs3h0jgQLC/nWO+
         z+Ka0BJKTVYhW5+0FEJMcmfALtZczDxkIbUQXaVhIokW3/UWVy+sKcrMihya4vkCZjFk
         BGK/54pXa6tvHDoVZ8Vdanr8cl81YK+uAfpA6f1XjNsUhGiBKlfMw4GL1bWQaK25qw72
         4sSw==
X-Gm-Message-State: AOJu0Ywipmn7QNHeV6I+TKCH+BRSM6mYzw2mX321/0InHedWqfaJ3iYX
	jJBX3yLpE07Gr1O+Vt6Yc34Ab508v0oJtt/NV3UdrCAtla7CM+90Rh+ymhAr+5dFi2WymJkgHQ=
	=
X-Google-Smtp-Source: AGHT+IEuF4IfhuS4L1RhRJgmcgQrE5r00JqUSTNxFEzJghPtYShRcSctDTuxprSW9GhSUfuDB1L2Y2h2
X-Received: from wmot16.prod.google.com ([2002:a05:600c:4510:b0:47a:838c:cece])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:348a:b0:46e:1a5e:211
 with SMTP id 5b1f17b1804b1-47d1958a755mr276604045e9.21.1766768454843; Fri, 26
 Dec 2025 09:00:54 -0800 (PST)
Date: Fri, 26 Dec 2025 18:00:40 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1311; i=ardb@kernel.org;
 h=from:subject; bh=DI1693K9EihgDie9UI9cVUKmQ2k9sJN05JHv29M9PfY=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIdNvv8XZc9ayv9svcJTulV+Vpn03fuX/1Uof4/x4Es6/l
 rYU7ZrfUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACay+wXD/+Iffx8bHLjUuXxR
 zyOtZXoevG135rf4zwpQ5sp+sGemygNGhvsXfX14E7csmJgecP7tjENiGZGBbpZLPuy8MGlXkbU GGwcA
X-Mailer: git-send-email 2.52.0.358.g0dd7633a29-goog
Message-ID: <20251226170040.2335976-2-ardb+git@google.com>
Subject: [GIT PULL] EFI fixes for v6.19 #1
From: Ard Biesheuvel <ardb+git@google.com>
To: torvalds@linux-foundation.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Hi Linus,

Details are in the tag. Please pull.


The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.19-1

for you to fetch changes up to cfe54f4591e675cedf2c0d25287ff4c0a2e0cb9d:

  kthread: Warn if mm_struct lacks user_ns in kthread_use_mm() (2025-12-24 21:32:58 +0100)

----------------------------------------------------------------
EFI fixes for v6.19 #1

A couple of fixes for EFI regressions introduced this cycle:

- Make EDID handling in the EFI stub mixed mode safe

- Ensure that efi_mm.user_ns has a sane value - this is needed now that
  EFI runtime calls are preemptible on arm64

----------------------------------------------------------------
Breno Leitao (2):
      arm64: efi: Fix NULL pointer dereference by initializing user_ns
      kthread: Warn if mm_struct lacks user_ns in kthread_use_mm()

Hans de Goede (1):
      efi/libstub: gop: Fix EDID support in mixed-mode

 drivers/firmware/efi/efi.c         | 1 +
 drivers/firmware/efi/libstub/gop.c | 8 ++++----
 kernel/kthread.c                   | 1 +
 3 files changed, 6 insertions(+), 4 deletions(-)

