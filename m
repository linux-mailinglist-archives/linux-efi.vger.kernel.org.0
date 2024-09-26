Return-Path: <linux-efi+bounces-1844-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5609876B8
	for <lists+linux-efi@lfdr.de>; Thu, 26 Sep 2024 17:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E59C41C2033F
	for <lists+linux-efi@lfdr.de>; Thu, 26 Sep 2024 15:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACAA14F126;
	Thu, 26 Sep 2024 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sviNcktk"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A645114831C
	for <linux-efi@vger.kernel.org>; Thu, 26 Sep 2024 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727365349; cv=none; b=VQdfu/l/6hcjCsBrhgtrTgkqumHXL3KUUry8cBMI/XSwaShyaT7rw3DIeLF8Go4tnBeDb4WsjN2iRs7gHXypkC0I2x98blABonyTGuSp3nTtZGaH43kumC1OvB5NLCbopOUs0P3sqGA2H37GYcHPdaoicFLsLQaImjm/iTee2fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727365349; c=relaxed/simple;
	bh=wsVyQ+9R8jXs/Sp9h6wEbBE/ygfsYmHzgyAP7I6HXag=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fkb8DF4mJhZ2ZtBc3JOBX27UP8CdBOLWtDFy3C82yT9sthRJIPVyzsFTq8wtB5J14ugQiLgMwdqxXCAwk6qKICPQ3tN++wOtAnJwnRRfHdFNVra5+AZxcT7ow/Mq01/C6JdHOcknCs1t3LJNfgOLsDF5Qgth6+v9TVcQuVhBdtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sviNcktk; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3787ea79dceso398852f8f.2
        for <linux-efi@vger.kernel.org>; Thu, 26 Sep 2024 08:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727365346; x=1727970146; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2DCZ96IgqhoYHQphZuUHrWcqvB2LeVFAN88z3ST3LPI=;
        b=sviNcktkzhw4M3iHUXsIRNxr0dV2E2QpFiI6YVXAk3q79xDk2ZuA/C5/qGcpOOYwby
         9qHcPHPBXzG+c1jdvA/GhvbslsQ4NWVnKwlKngJKPJwr/nMTjfEvsLzBC7Wy+JuAWrMh
         jNQMbNew8+bEHK2g1REC6nszEWlbTl4jJe0Hfm36bymGjsx20crPAttAP/Ee8YZqvxcM
         h3XzydIKG9fYA0BIHP2pzFl/z4cIrij0T4iQXVvvkIMajlSpO03Cf8avkYiHzl+t/ujC
         CfPyNx0Cx6LP39jiF7eHZmTAsNO4TDscUAdUeyYBWWO1yfpR384NU4//efFMdFjN+tep
         WSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727365346; x=1727970146;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2DCZ96IgqhoYHQphZuUHrWcqvB2LeVFAN88z3ST3LPI=;
        b=XXIjjLXE0OVfmSQlUIBoSJh/l1nbjL3NdCLdP/oBRJUupBb+azRg4K+BtsyV3yJPU3
         1lixXgaiIaD6iGDrm2wQb2KP5HKUXylPD/YG5e/boDrY02qy4ttVdCXkh4Ci1DijHt+w
         FMgonCJQaDGy1fJLg8JBqNhstX4CvRwdRp+h5Vj4/7Ou3VVnYFcchIzdGBb5NBwW6Zv0
         EfMm78U7//PL8CP7a47gyq0pQhMbuO98pVCZtJIluxVMgd9Bfz/9O2b5jjUOhR4rCUu0
         TLgcd/GNpQlaOzWy7v8/6Mbu+EhK6uzABSug57Q3TRfKuQeVHwFh0WpTkHg8gNTE2kca
         QxHw==
X-Gm-Message-State: AOJu0Yw3bHGslmesx2tH2s9eggZvLUeKasQyib3/YELqRv7zqz7gThhc
	7waDEN9j6h1wmQvKbIsc52oA5Iav9S7R/VaRUeAKDwlnF3RWO7rfIe2zyyyO4rTLmonClw==
X-Google-Smtp-Source: AGHT+IGlfzdVUIBijDJOojpiQHc/tG0H1xHRtx3jKE/8kH1/howvCChiTpL2IOxxRsWXyT7WgmM6VZE0
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a5d:6745:0:b0:374:c61a:69bb with SMTP id
 ffacd0b85a97d-37cc2466276mr4137f8f.3.1727365345610; Thu, 26 Sep 2024 08:42:25
 -0700 (PDT)
Date: Thu, 26 Sep 2024 17:42:07 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1450; i=ardb@kernel.org;
 h=from:subject; bh=9SAuXgFsF3ZyQXV8j5nPQY5g+jFcbJm4a1zuxRlDpy4=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIe1rw/ld62/2aTyL9A2vrS0tfvb5mfMsyQSuzWcT+3SbD
 +w8omfeUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACZiXMDIMM1LLlpdUVuYz/OJ
 V5Wyp/fGFfd/Vih92fnwmIreC/7MNkaGpQI1Z1g/FCi02m5ydXaN+f/n8lap1T6aGgYsFrGFlwU ZAQ==
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240926154206.1041064-2-ardb+git@google.com>
Subject: [GIT PULL] EFI updates for v6.12
From: Ard Biesheuvel <ardb+git@google.com>
To: torvalds@linux-foundation.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Hi Linus,

Not a lot happening in EFI land this cycle.

Please pull,
Ard.


The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.12

for you to fetch changes up to 04736f7d1945722117def1462fd3602c72c02272:

  efi: Remove redundant null pointer checks in efi_debugfs_init() (2024-09-13 16:25:43 +0200)

----------------------------------------------------------------
EFI updates for v6.12

- Prevent kexec from crashing on a corrupted TPM log by using a memory
  type that is reserved by default
- Log correctable errors reported via CPER
- A couple of cosmetic fixes

----------------------------------------------------------------
Ard Biesheuvel (1):
      efistub/tpm: Use ACPI reclaim memory for event log to avoid corruption

Li Zetao (1):
      efi: Remove redundant null pointer checks in efi_debugfs_init()

Yazen Ghannam (1):
      efi/cper: Print correctable AER information

Yue Haibing (1):
      efi: Remove unused declaration efi_initialize_iomem_resources()

 drivers/firmware/efi/cper.c        | 11 ++++++++---
 drivers/firmware/efi/efi.c         |  2 +-
 drivers/firmware/efi/libstub/tpm.c |  2 +-
 include/linux/efi.h                |  2 --
 4 files changed, 10 insertions(+), 7 deletions(-)

