Return-Path: <linux-efi+bounces-3099-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F15BA74435
	for <lists+linux-efi@lfdr.de>; Fri, 28 Mar 2025 08:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C6CD7A794C
	for <lists+linux-efi@lfdr.de>; Fri, 28 Mar 2025 07:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B19B2AD25;
	Fri, 28 Mar 2025 07:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dGiXrjWF"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE34E573
	for <linux-efi@vger.kernel.org>; Fri, 28 Mar 2025 07:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743145538; cv=none; b=hBy0dNa3mwkuxZ/x2VSspAOtq40m2a565QGlcOBNJwDHt48Ldry4rSNE+9WkjjOy0WrGDw5MxCoyqXgAbOtgidbGfeXKSFSLL5DS7wr0RS++g0qXdRGXabZNw/jFAkfliUrt9osvRXjxbIclgLBupZr7cIhUbnk9WvVOrlAeOm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743145538; c=relaxed/simple;
	bh=F8YEk+9hIy4MY8NDIMUm9hSrbziwIq1met4VrxWDOco=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TLDJaad41pACTqdAoUkOzcGYigOUUe7QtW/M49SmdG01ptz2PSJoFGYuL0yKHBoy4QOOIT0096Cmsnd9F+p5A8qvKpfcutQ7zYjAATYb712sumvDLq2ie1qXWjHwF1SE70kb5Qnh6KhB8Y05r85MenW+84ouY9Fq+tvAXoZ+4+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dGiXrjWF; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43cf327e9a2so16646905e9.3
        for <linux-efi@vger.kernel.org>; Fri, 28 Mar 2025 00:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743145533; x=1743750333; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NvzBoYJwLT7sj2himag1AmgAkm2O3eRVRQ76CegcpU8=;
        b=dGiXrjWFhDAL4FtDxzUEwpnS7o55BvpQm2VZLLVauXNYAe2rXZFvTbdxvKrhlDOf3d
         JlmGlVakoIcVsMcwmz23tl+rggWW4Amhg+npWqoKYEfZXnKI8j3aM1e+vynoJUzX5+FE
         XqWvE6C40cvov9W2pCpjERDNUUJCIUtG1t3F6Eq13JqqR0gyueVZ1c2YfMrs7MVQRz1l
         orF2sGIIi8/tXHHd9JfVwYgk1xWPf0at4/DcUmX1vd3p/e4HeddvFPfRFcYApgCwutSj
         Bwrl+Wm2GjztVeVTv+y7vPiU+Gb7/pymmJwEodea5KmM4buXN2/qyaEhKFM87puQ2TY2
         /I0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743145533; x=1743750333;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NvzBoYJwLT7sj2himag1AmgAkm2O3eRVRQ76CegcpU8=;
        b=Lml29xmvdzNTInN9XXse2ztns21wXzxeyi2DRwf4sqR8VeEzUryzemElIADCe4npwX
         +THHleW0LVbrOq8wyXOtM/2UbxBoxj1a31xFhIRZBT9LZdPEZY+C8suMiRsJUkrL82lT
         71HdnbKFGM94xOGLeWxXHHM3QpXejryfDf2rRsgIK8CoWBXTefC3RHEl4hVZMaZcxCRX
         64VjB/sdUMjoOq4AaYgfEKGa7ENYLmD8/eur3SwmQ5hP4JBMYQdRv/ZWY7Ntzyml68w3
         rzcaih/UTG9mhF7k1leYxOV8QyaQfBEOjnEbZthVGwMoMqlkhBOcz1+Ls4sGSTiBMdOx
         3dgw==
X-Gm-Message-State: AOJu0Yx64QXk/Adc4D16zkW4XeGeePmwLQp/BPyxN3SP1DpcfsMbo4hD
	wr3S6jG1RgCesI174waJXYFEtj0Xa1s/u5WKWhqXYgTjXjBSjpJl4dgD07CcoeSIdt6d6A==
X-Google-Smtp-Source: AGHT+IEn0NJzSnKHfX8VoBzv9370LDpWWCYxXzEm95Zwfxk+g8WWHMS7e5nj6uA9O9SSOIMkI/2fxh53
X-Received: from wmbfl10.prod.google.com ([2002:a05:600c:b8a:b0:43c:f6b3:fa10])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:154c:b0:43c:f87c:24d3
 with SMTP id 5b1f17b1804b1-43d850662damr54720675e9.20.1743145533801; Fri, 28
 Mar 2025 00:05:33 -0700 (PDT)
Date: Fri, 28 Mar 2025 08:05:26 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3013; i=ardb@kernel.org;
 h=from:subject; bh=WHqP5k+gJv1warnPRbIkH3hE3SLxq5DuSVl6OvGKFw0=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf2Zl1lmuOZjeYcwdpY7vVcS/87jV7ogFi5/6+2ikneHZ
 UW/Wbt1lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIm8/c7IsPxe3zof66UJUzjv
 dr5/cUBwW/cJa51fP4tzZh3f/2rOoTKGfyqLit7oZX09xG/5rfOAzIo+jrltEVe0Tvfuq94TlCc kzQEA
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250328070525.2248563-2-ardb+git@google.com>
Subject: [GIT PULL] EFI updates for v6.15
From: Ard Biesheuvel <ardb+git@google.com>
To: torvalds@linux-foundation.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Hi Linus,

Please pull the EFI updates for this cycle. Details are in the tag.


The following changes since commit 7eb172143d5508b4da468ed59ee857c6e5e01da6:

  Linux 6.14-rc5 (2025-03-02 11:48:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.15

for you to fetch changes up to 0dc1754e16b4c14ae42f6cf59f319331d885f0f6:

  efi/libstub: Avoid legacy decompressor zlib/zstd wrappers (2025-03-14 12:36:11 +0100)

----------------------------------------------------------------
EFI updates for v6.15

- Decouple mixed mode startup code from the traditional x86 decompressor

- Revert zero-length file hack in efivarfs

- Prevent EFI zboot from using the CopyMem/SetMem boot services after
  ExitBootServices()

- Update EFI zboot to use the ZLIB/ZSTD library interfaces directly

----------------------------------------------------------------
Ard Biesheuvel (11):
      x86/efistub: Merge PE and handover entrypoints
      x86/efi/mixed: Check CPU compatibility without relying on verify_cpu()
      x86/efi/mixed: Factor out and clean up long mode entry
      x86/efi/mixed: Set up 1:1 mapping of lower 4GiB in the stub
      x86/efi/mixed: Remove dependency on legacy startup_32 code
      x86/efi/mixed: Simplify and document thunking logic
      x86/efi/mixed: Move mixed mode startup code into libstub
      Merge branch 'x86-mixed-mode' into efi/next
      efivarfs: Revert "allow creation of zero length files"
      efi/libstub: Avoid CopyMem/SetMem EFI services after ExitBootServices
      efi/libstub: Avoid legacy decompressor zlib/zstd wrappers

Ethan Carter Edwards (1):
      efi: efibc: change kmalloc(size * count, ...) to kmalloc_array()

 arch/x86/boot/compressed/Makefile                  |   1 -
 arch/x86/boot/compressed/efi_mixed.S               | 341 ---------------------
 arch/x86/boot/compressed/head_64.S                 |   7 -
 drivers/firmware/efi/efibc.c                       |   2 +-
 drivers/firmware/efi/libstub/Makefile              |  10 +-
 drivers/firmware/efi/libstub/efistub.h             |   3 +
 drivers/firmware/efi/libstub/intrinsics.c          |  26 ++
 drivers/firmware/efi/libstub/x86-mixed.S           | 253 +++++++++++++++
 drivers/firmware/efi/libstub/x86-stub.c            |  52 ++--
 .../firmware/efi/libstub/zboot-decompress-gzip.c   |  68 ++++
 .../firmware/efi/libstub/zboot-decompress-zstd.c   |  49 +++
 drivers/firmware/efi/libstub/zboot.c               |  65 +---
 drivers/firmware/efi/libstub/zboot.lds             |   1 +
 fs/efivarfs/file.c                                 |  10 +-
 14 files changed, 452 insertions(+), 436 deletions(-)
 delete mode 100644 arch/x86/boot/compressed/efi_mixed.S
 create mode 100644 drivers/firmware/efi/libstub/x86-mixed.S
 create mode 100644 drivers/firmware/efi/libstub/zboot-decompress-gzip.c
 create mode 100644 drivers/firmware/efi/libstub/zboot-decompress-zstd.c

