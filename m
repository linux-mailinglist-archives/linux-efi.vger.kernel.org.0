Return-Path: <linux-efi+bounces-4958-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B6710BB9B53
	for <lists+linux-efi@lfdr.de>; Sun, 05 Oct 2025 20:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9161E4E1B67
	for <lists+linux-efi@lfdr.de>; Sun,  5 Oct 2025 18:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD381D6194;
	Sun,  5 Oct 2025 18:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2hPNlWgz"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1B535962
	for <linux-efi@vger.kernel.org>; Sun,  5 Oct 2025 18:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759690728; cv=none; b=cskNotAFyzhEN0+4MNqboCNusz4uHzoizPRZPH13R4nlNY2LIycMi4sOfjCn8u3CaHr7fp/+PgqoojfOHpeha07GUhQbGtt8Y9eSN/uxhLFjzSWpOKtKyPuG2fOmssvIhU0PEiL4Wh+HhvN+bvkdiNTqz8+JV6L2eyVp09n3Zws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759690728; c=relaxed/simple;
	bh=rhGzCNC+0KGpmrWaNc6gUv0s65U/11aAhGFG+psy5T8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nYuD7XgdpqNt3B4jcZmXQcN1W4dk4STL1z2AqHz5lPB9IJx/j2WQEa9iZDW1gRLYZqFWv6nydWDIHOr7Zj8hjqc8OzQoTw4AS/xQfy6eGicU8b1UAOhtmaoZGWiyoFFdTtw7tm5Na9dSYvmz4s7jA1l6fDjG50ckQ1HHmWR8PwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2hPNlWgz; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3f6b44ab789so2160175f8f.3
        for <linux-efi@vger.kernel.org>; Sun, 05 Oct 2025 11:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759690725; x=1760295525; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P77ZEFpUS7D/wiOnNjfYOno7BLRAb4P+QOPSs1ervr8=;
        b=2hPNlWgz6L97sThEpdu+1u1RJankuqLYgPd0edDtoPFn2i2pBDW3rp4gaNly26dlHE
         TJ4/qFda6bvcmFTKkLz9Ae/sDyFXXh9pXGtDO8yKZqFebTSpn+haEn5KBbQyeUJ5/Ar3
         um00b3lM9TpF6MumQzTwsY/eltBvNsMo3vIkKRV77mkUoIWsGlCl9LronV5LIrQYYP4e
         ClSULPUMYpfV11WHTejAkEOPEHTv9f3xzJBC0gtBSO/IUziY54p+QqURTy+MDRVVLY+N
         5V/ORTFYwC798QNU/ie2CpSHSsRDW+rX8PswFHqaMAc5W3u4bH5xxOSSv/9BmsIqEQ9O
         O5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759690725; x=1760295525;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P77ZEFpUS7D/wiOnNjfYOno7BLRAb4P+QOPSs1ervr8=;
        b=qx6HwnMxbVDdf9g1nR85ONSwFGCN/boEEMPsjgrJZMftZZ9nJ3jpi4qdKP7iWoe+Y2
         oxZmHfDiz3k1xa+zkBqMTkrX6D77qyTxXf6nKaHdvq3CfX8lFAJuRqOtFJPGl5he8qnC
         XwSvjR0Ib2Ll7BBznVKdeOAkhl0h3ge79P8PfoxY3FCqRQdJWqBxxB1WvxGp9UI7LIjH
         y2mSMHV8/N574odU84/lLxK65A3j74rWNwJb6/MYoc45gafNpylI4kl/IIjAzYj4jknP
         7n/jnhK7NsImkRuftPeFjuHqkLr17cVg86Fk2fmX3HyGz7IIyrZLKOxipiEgCNPgKaM1
         NoMQ==
X-Gm-Message-State: AOJu0Yx3xOXsTiT1NIq4mpVMYwJ1sMOUEIQOr8sO/Mj8Nj3ruej/RsOw
	RcIe78+32c0yUPBreX8ApoDWXp87jQyq8KWsDpOsf32KGk9Hp8+UOgR3yUMLB2kCVQOVmguTLA=
	=
X-Google-Smtp-Source: AGHT+IE1SaoXZ2wvcxjSF8nzMR2hu4MPnrQuHI5R5Em8ndG7OX8G3sy/WlyFEBT44dEZuL/9JgPGRoad
X-Received: from wrxq13.prod.google.com ([2002:a05:6000:cd:b0:425:6889:250d])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:144a:b0:400:1bbb:d257
 with SMTP id ffacd0b85a97d-4256714d039mr7040065f8f.26.1759690725557; Sun, 05
 Oct 2025 11:58:45 -0700 (PDT)
Date: Sun,  5 Oct 2025 20:58:25 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1204; i=ardb@kernel.org;
 h=from:subject; bh=Ajvj0/SNB0X6ONPhoLR2TNFOCXrCQm+B+SlEmbognW0=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIePR/ovHePoTwn9mXbqy/azWTMvjVf9zFDTP5G9adWnd2
 aK6FZa3O0pZGMS4GGTFFFkEZv99t/P0RKla51myMHNYmUCGMHBxCsBETIQY/ntmHBWTu37z/HG2
 G9zBwjJyyxgce1zkLffL3f7/bydnWDcjw6aMjebPH17qf6HBOM9yScD8RZNsa6PehFVWfDx/wuS /DRcA
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251005185824.780948-2-ardb+git@google.com>
Subject: [GIT PULL] EFI updates for v6.18
From: Ard Biesheuvel <ardb+git@google.com>
To: torvalds@linux-foundation.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Hello Linus,

Please pull this pair of EFI tweaks - nothing else going on this cycle.

Thanks,


The following changes since commit a6358f8cf64850f3f27857b8ed8c1b08cfc4685c:

  efivarfs: Fix slab-out-of-bounds in efivarfs_d_compare (2025-08-28 08:39:49 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.18

for you to fetch changes up to 99da5bf3dd6a8cb951adcace6153c34c86547811:

  efi/x86: Memory protection on EfiGcdMemoryTypeMoreReliable (2025-09-29 17:13:39 +0200)

----------------------------------------------------------------
EFI updates for v6.18

- Document what OVMF stands for

- Clear NX restrictions also from 'more reliable' type memory when
  using the DXE service API

----------------------------------------------------------------
Geert Uytterhoeven (1):
      efi: Explain OVMF acronym in OVMF_DEBUG_LOG help text

Lenny Szubowicz (1):
      efi/x86: Memory protection on EfiGcdMemoryTypeMoreReliable

 drivers/firmware/efi/Kconfig            |  7 ++++---
 drivers/firmware/efi/libstub/x86-stub.c | 10 ++++++----
 2 files changed, 10 insertions(+), 7 deletions(-)

