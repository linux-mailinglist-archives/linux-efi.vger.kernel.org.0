Return-Path: <linux-efi+bounces-1034-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 112938C4CBA
	for <lists+linux-efi@lfdr.de>; Tue, 14 May 2024 09:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA67A2823DA
	for <lists+linux-efi@lfdr.de>; Tue, 14 May 2024 07:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA76FE574;
	Tue, 14 May 2024 07:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3dSGT/vQ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCC6D304
	for <linux-efi@vger.kernel.org>; Tue, 14 May 2024 07:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715671258; cv=none; b=snruyj2KDfehiAobXsXcTQadS7gtTK79XCKfMiaRURjeYtMNYXB3lQOldbEH+kC/oaDbtRyT432om2OFFgBWryGTlAElUwmk7+5MLynJ4A8fxaJxH3gzMy0ycttmMt4+1zLB2jO1vL1EdmwZaOM+v2polXbHuMd3iGnfKPLzi/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715671258; c=relaxed/simple;
	bh=izZZ5pSN6kbhuxAOBi/+aSS+bWDueTCv1fcgUmZ3S3c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uxImo4tEqMqJr3ZqiEV5tfqbE/XDrLM2JMJ24kHd95S4V2v1wIBZi/TATKVwFDP7aX1XdeZqCYTMdAFBhtP9XGCiJjaVny2SD+p5LSoboAxHG9rXNZN57ZQ2nEV+S6KH0I61BMT61I9QksPVTU99c+oSAWHNLtj3A4oifekTL+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3dSGT/vQ; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4200e6a9901so17116615e9.3
        for <linux-efi@vger.kernel.org>; Tue, 14 May 2024 00:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715671255; x=1716276055; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PbOcLaE4+rmbsAmc1ksnbJ2QGvvMGokokMhFld6zAtw=;
        b=3dSGT/vQVYQ2c8hxSNLI/cEg5zrQN0IriRkwNtXJSPHlMyvodxsxqN3BpSjjJ1z5ah
         e4tkpu+OIFVFMzcFOHlBeiQsRTM1ZZTGiSvj0S+0gTJ8rT3t93s1Qd6EnZGgG3++LII9
         hW9f3CPEshUzb+zklRyyr2emKw6imWTuU9OQVcsKNhTp9N4GfH6u96XapWfgv7IGvmaC
         UlNSk0vAEKxyKKyx0pa7/a6vw6SG93aXH8XGH+8QP4Cz7xi71+uQ2+nqF/YCuErjBzW2
         kXZBlpQaMbMBiWzZ/sSTcdFHt2a0DwYlws/qi1jwjCNKshex8JWFpmLsjiTXEJ5f56aH
         Mvog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715671255; x=1716276055;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PbOcLaE4+rmbsAmc1ksnbJ2QGvvMGokokMhFld6zAtw=;
        b=DHcUncg/OW+oU3jyTZhMfUnfCMQFrr5KhEseuut38GzTczd6IW09RJVpvD9iPjsA+b
         iSl/RF12ik3TkgcDt3FdIkzWPhVCGgLt7naczZopU3ziMMZ7PQr7fAp1/+YBDQr4KbkD
         Eb5Xg7ObMtVdXyKSvjrgCrP5cZsMxV9CilrARvGufmFURbUJL7KEJr19IO//1bWxwkwh
         v4/A718NP0GP08QWKY01XBtHG74Eys+npNZmh1wjNfCR9KSvKEfrm+UUJwXO5SFEjhqY
         jkfSa+ZRnt8Xi17xHXr9u2nHCc7UEFsMK0F9FfZldSlOJsu4hWPSeRIlvvPlsc2XpNmP
         g23A==
X-Gm-Message-State: AOJu0YzfbRlMFcMTAGJ32Fs8VGPSBEOXlfVAsPL7M+rHNmizwI6KOXlX
	3A++STy7iuNh50BiEwLfTLImmo01YvaRXJKh74a0ZdeCHWHFganhP2NU+EZXLet2Lc2ROw==
X-Google-Smtp-Source: AGHT+IHig4sa2Lk+evTPV1MP24fcECo+OX3aXsaFZEIcro+vWeWPao28oLDY9+NBSrwJpFwX7saliRG/
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:3c86:b0:41f:d056:159d with SMTP id
 5b1f17b1804b1-41fead645abmr567915e9.6.1715671255177; Tue, 14 May 2024
 00:20:55 -0700 (PDT)
Date: Tue, 14 May 2024 09:20:40 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2007; i=ardb@kernel.org;
 h=from:subject; bh=FqJmtVIcMp/nBSYA320JM2RBg8LlaVMgxpAcCN/cO34=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIc1Z4ESYKtO0V79UYoMP/znWHJ3KXvlm0pQbU7iSJxn5W
 QaHHLzZUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACZiLsDIsHaq2K/D/XOWvY3K
 e7a4q/FGadXXA37OjLvX/Tv3JV21OpPhn1m8lPBR3tIlhz5J+DwXl5lwb+KX50uL7rDO00k6rK3 7gAcA
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240514072039.3346871-2-ardb+git@google.com>
Subject: [GIT PULL] EFI updates for v6.10
From: Ard Biesheuvel <ardb+git@google.com>
To: torvalds@linux-foundation.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Hello Linus,

Only a handful of changes this cycle, consisting of cleanup work and a low-prio
bugfix.

Please pull.

 
The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.10

for you to fetch changes up to 4b2543f7e1e6b91cfc8dd1696e3cdf01c3ac8974:

  efi: libstub: only free priv.runtime_map when allocated (2024-04-29 17:47:32 +0200)

----------------------------------------------------------------
EFI updates for v6.10:

- Additional cleanup by Tim for the efivarfs variable name length
  confusion

- Avoid freeing a bogus pointer when virtual remapping is omitted in the
  EFI boot stub

----------------------------------------------------------------
Hagar Hemdan (1):
      efi: libstub: only free priv.runtime_map when allocated

Tim Schumacher (4):
      efi: pstore: Request at most 512 bytes for variable names
      Documentation: Mark the 'efivars' sysfs interface as removed
      efivarfs: Remove unused internal struct members
      efi: Clear up misconceptions about a maximum variable name size

 Documentation/ABI/removed/sysfs-firmware-efi-vars | 12 ++++
 Documentation/ABI/stable/sysfs-firmware-efi-vars  | 79 -----------------------
 Documentation/filesystems/efivarfs.rst            |  2 +-
 drivers/firmware/efi/efi-pstore.c                 | 10 ++-
 drivers/firmware/efi/libstub/fdt.c                |  4 +-
 drivers/firmware/efi/vars.c                       |  2 +-
 fs/efivarfs/internal.h                            |  5 +-
 fs/efivarfs/vars.c                                |  5 +-
 include/linux/efi.h                               |  9 ++-
 9 files changed, 33 insertions(+), 95 deletions(-)
 create mode 100644 Documentation/ABI/removed/sysfs-firmware-efi-vars
 delete mode 100644 Documentation/ABI/stable/sysfs-firmware-efi-vars

