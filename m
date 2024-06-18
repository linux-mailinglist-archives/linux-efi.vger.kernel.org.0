Return-Path: <linux-efi+bounces-1242-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B96E290D620
	for <lists+linux-efi@lfdr.de>; Tue, 18 Jun 2024 16:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7101A1F221F2
	for <lists+linux-efi@lfdr.de>; Tue, 18 Jun 2024 14:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D53139CFC;
	Tue, 18 Jun 2024 14:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hI2ha/Mu"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD53E14A4D8
	for <linux-efi@vger.kernel.org>; Tue, 18 Jun 2024 14:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718721960; cv=none; b=eV3E3Xz5XueeJwoOh+qILD2tLB6zwwdXmrlSeyQ/NpGsNrfQ515f1lDVsheNbBLtRfXJtTiZzToKDRThWc4NvTB1p1oP4TQCgLYLDmHvI6g29z5UpjZCPXnYVICEb0/al/d9jX4brumwPe4QSMBkAgVQoJdxCeS7aD76ah5QtLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718721960; c=relaxed/simple;
	bh=RTaLt8TwlMVnf7TzlMT6DU1Obmwn3h2erEN7XB/sCng=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Az5drYk1VUqffYXH/kQlHMty3gTl0MkNiJwf4uNInJL/xCITgZX1OUVuK6dUqUUOxXfZHVOxEA9IvlEZBZ2K5b7l0QyroeQrGRFhLK24AhwNeJm53biWj6Av8dKQ28MyNsWHV9UqbBGd5CTNqq0OQ0f+0Zk60y0+Of9MkukUYeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hI2ha/Mu; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-35f29246a35so3321869f8f.3
        for <linux-efi@vger.kernel.org>; Tue, 18 Jun 2024 07:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718721957; x=1719326757; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w8YwmsHwApvFoG7uoMvf3+nlZBIO5fRknNuieOQFPvM=;
        b=hI2ha/MuQwk3skpZvuRXyfrNaoKTOTCPulmot44y4/0VIsXtEmmHZZl6GteNZS9NbC
         UGcsbCgp+hJfkVCo54Xe6+g33sa3gKKy06DQBkz+giEMNXHaiPl6nMcDEBYirikKyPHT
         bIAYmBNfyYWsdOUoS4wzKN9NgvcnFB1H2ttVrAvaE/mWCsFfz74Upd6Nsj0leekWlmVL
         FNN07VAmnp/hbYYUEVcP8Q31Bw8PvpRbc6axvCOpmihDdUYMIebJggCqKIHrHiyrZX5F
         pyXoJQ5PsGRy5in9cVAsABvxowVWfezXEvRq2Dc+07BMIxNG7GIxp8Ws12mAUfVCOINU
         uqHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718721957; x=1719326757;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w8YwmsHwApvFoG7uoMvf3+nlZBIO5fRknNuieOQFPvM=;
        b=N+oYq5vX2vYJMcn7RQEx0oM/QahGkIDJXhoYaCdaqWcONuA8afvBv/7cnG923L5mrv
         HBTzgzwYSdIiOflHorXl44KNNKnFbRxgZ0uufnRagsP6cZUbMsgufe1EqAv5BjJGN1pV
         d77XyqKzOdADl8AvHRA8imu/dEsprUidZG34BC7P1kSZUdywD0T2VpMsJsSV2ZffD03w
         dZIC+Uw9JaqhV1X+fZrJoniZ/DJ9tneUzNvncZsGHXdSCjiHeO4X6AMNEpX0lk6IX+pM
         6RMcOntbDWs0TfhULBwi3PZAGcNIGPDhuRlULwZCQlo4uZAykjA3qFSOjIxoN/ZTcGcY
         z8Wg==
X-Gm-Message-State: AOJu0YwTlY3migfemNR6c1XVzQCBLsD+4NcgCfRsdSgYtQJ0HaixULbw
	XgewK+GE6X8DXDVw+SRuFUj7KEfChi93jKK3JqMuDo3d/J4X1mGIuZ9oEtiFeZ5Dchbkdg==
X-Google-Smtp-Source: AGHT+IG5219o4WHll7zvbUWt08O681zrusnmGf0nE1O9HCPBBYw+NXrJuTWmVOUy5R84i/Tf7VqOubMc
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6000:1252:b0:362:fe81:582 with SMTP id
 ffacd0b85a97d-362fe810803mr126f8f.4.1718721956840; Tue, 18 Jun 2024 07:45:56
 -0700 (PDT)
Date: Tue, 18 Jun 2024 16:45:48 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1602; i=ardb@kernel.org;
 h=from:subject; bh=wDu4LPgkmjrXGK+pvS9JjMOmsb9l7rmHQR8cqmhAhw8=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIa1w7hyhrY7RZYqbrT8rfreT0GjuPn8pIaflD1tRSsKzO
 Se2dV3oKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABOZmMTwm0VkuufhBNWmqUqt
 Igf1lTNvM3vuerxebxa3fK1S7TKF/Qz/3Ro4atfvjFgVI3b9urxv/XTBmtNZ5euuPL7d5/Fk+QY vVgA=
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240618144547.365311-2-ardb+git@google.com>
Subject: [GIT PULL] EFI fixes for v6.10 #3
From: Ard Biesheuvel <ardb+git@google.com>
To: torvalds@linux-foundation.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Hi Linus,

Please pull another small set of EFI fixes below. Only the x86 one is likely to
affect any actual users (and has a cc:stable), but the issue it fixes was only
observed in an unusual context (kexec in a confidential VM).

The following changes since commit 99280413a5b785f22d91e8a8a66dc38f4a214495:

  efi: Add missing __nocfi annotations to runtime wrappers (2024-06-05 10:18:58 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.10-3

for you to fetch changes up to 46e27b9961d8712bc89234444ede314cec0e8bae:

  efi/arm64: Fix kmemleak false positive in arm64_efi_rt_init() (2024-06-15 10:25:02 +0200)

----------------------------------------------------------------
EFI fixes for v6.10 #3

- Ensure that EFI runtime services are not unmapped by PAN on ARM
- Avoid freeing the memory holding the EFI memory map inadvertently on
  x86
- Avoid a false positive kmemleak warning on arm64

----------------------------------------------------------------
Ard Biesheuvel (2):
      efi/arm: Disable LPAE PAN when calling EFI runtime services
      efi/x86: Free EFI memory map only when installing a new one.

Waiman Long (1):
      efi/arm64: Fix kmemleak false positive in arm64_efi_rt_init()

 arch/arm/include/asm/efi.h     | 13 +++++++++++++
 arch/arm64/kernel/efi.c        |  2 ++
 arch/x86/include/asm/efi.h     |  1 -
 arch/x86/platform/efi/memmap.c | 12 +++++++++++-
 drivers/firmware/efi/memmap.c  |  9 ---------
 5 files changed, 26 insertions(+), 11 deletions(-)

