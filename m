Return-Path: <linux-efi+bounces-1438-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C867932993
	for <lists+linux-efi@lfdr.de>; Tue, 16 Jul 2024 16:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A9A11C21D3E
	for <lists+linux-efi@lfdr.de>; Tue, 16 Jul 2024 14:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBE719B586;
	Tue, 16 Jul 2024 14:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Htd3OKrN"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8B719B5A3
	for <linux-efi@vger.kernel.org>; Tue, 16 Jul 2024 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721141056; cv=none; b=N54lVledAJh2OKmCXL8ZXB/Bv0k90gZ5XzgGRHnCrTF072kWSG9AL2yZwT7U5i8d7n1u9g0eiMpwdgI5Z/QOg6Tpb8KE5+r9cWtjYhOLdpI9pBNIUYF1YAi5XWxo5+fyrKeFMPh2W03tXVPtI0GNGN8bzs3Leo5tfEaq84Xx63g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721141056; c=relaxed/simple;
	bh=/byfM/sfVLWV0s0XezLpxvLi4zhXmmUVrNaJG95wKpo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jwCY3SSdeXtUEUn8O0pofP8i+w/gbDagJq9Zzmt7wd/gaXgRENlyLea3PrWfBEPszeRRQjDKM/lBj2XUmvTgVIWKemxXPq8ol/mzIdDkQEwEvghQ0vP8MpjyMdcQKqK70zKzws4/FhzP45lsb/5hwQ1Ayi7/ujlvGDmqO4hWbxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Htd3OKrN; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-65fdbfb8fe9so62259377b3.1
        for <linux-efi@vger.kernel.org>; Tue, 16 Jul 2024 07:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721141054; x=1721745854; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YfEG0gr9dXdRVxNzm4lZmlXV7YUSbq89ER6EiG6iCBs=;
        b=Htd3OKrNNFUN17gzalpuqhUkhU6DbTQPD5Kxs0XujSfLgwkqWydrZrekQOu6S72nyQ
         W+GFLIMlqAdH+9LEkVDbrMnP/QbqaN1tzbLv0jacLl7iMJYE/9k9Y4NBIeX9VXBCGBw0
         oMoOLODXYSQbA9n2mRWRS9Il14bnEHy1ddHD4a2dijSISCGd/6S6V1RJRRQ6CLyvlCMz
         z8wsFHX+Vu9IWay3vdq1qQMv1qZ/91CnMoNU/9VxpZ/JSJX8gOohy1PrJfd7YQ/BjX31
         3MKiliQRwTwh25BwYBpHI/MxGoUFFJWOTse9YeQgG66taSZfYsjrPLR8iw8jqG7P8gdq
         4a2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721141054; x=1721745854;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YfEG0gr9dXdRVxNzm4lZmlXV7YUSbq89ER6EiG6iCBs=;
        b=pE6GFXHF5PGD4HO4etYqDZITXE/2sRJJSrBU+OCpgDUSdbmSlWlXcVpeEWwaY+mMc+
         U2o3J3PZDGg8ot4XgqG4KM8NlrUAHQN2emuS11swYluiFHZYCvd89Qkx+e7m+qOPvjL6
         QQ/Eru1Ga2ArKaG0SJhDSbhqTA9/KMIE0T9SFpRJxQPBeOgVlSMMvXLsUI6wKycz1CjF
         9dtX013H5Q6EyzrpsCqgFr6jSNb6ETLnkxIiNOHMVUdqhXnhdtdsHdgnN5GpnG3uOha/
         nz0ZyAhysEHumo/FxIXit7FQ7+PrGo6vBs6uVJsFNw8LeBsp3Ig+n/pz6XYh/iBGVR3x
         0D9Q==
X-Gm-Message-State: AOJu0Yz2uRNVKgHTCa/MdgB9l9vKPyxyA8IuPtT8VTRu9M3KNCO+ygNc
	Dv0+Pqm/hafVYOIduTP4BYSxJS6EUPF1VwXivB71b8sco5qkZCFv2+YDuZBX1Xh7qFBthA==
X-Google-Smtp-Source: AGHT+IGyb8ov3NfenJzDxDuw923cgXnO7f6DpgKNdv0OQOB95F3WBOYsEzAkktNohv3cYq9SoQRKD9ik
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:690c:288:b0:622:cd7d:fec4 with SMTP id
 00721157ae682-66381db1fe8mr1329507b3.9.1721141053657; Tue, 16 Jul 2024
 07:44:13 -0700 (PDT)
Date: Tue, 16 Jul 2024 16:44:02 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3686; i=ardb@kernel.org;
 h=from:subject; bh=dIpPWULH7+xaNQb+BpVM0Dh7IFedzIxRjB3mfkaAhAI=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIW1au/HToOz7vxbq1d/1+5bEJRD++bupxmcDKbsbK64VJ
 Ryb3t3TUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACYSP5WRYUH5Px1G0RksCr2R
 9ne7l1bE2huEn/jb05SY1XveIGndcoa/4ideht9o1zoSmWeUdH1/mFFcQ8fi7vfRFoeuRzxd9Fm cGwA=
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240716144401.1742972-2-ardb+git@google.com>
Subject: [GIT PULL] EFI updates for v6.11
From: Ard Biesheuvel <ardb+git@google.com>
To: torvalds@linux-foundation.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Hello Linus,

Please pull the EFI updates described below. Details are in the tag.

Note the removal of the EFI fake memory map support - this is believed to be
unused and no longer worth supporting. However, we could easily bring it back if
needed.

(With recent developments regarding confidential VMs and unaccepted memory,
combined with kexec, creating a known inaccurate view of the firmware's memory
map and handing it to the OS is a feature we can live without, hence the
removal.  Alternatively, I could imagine making this feature mutually exclusive
with those confidential VM related features, but let's try simply removing it
first)

The following changes since commit f2661062f16b2de5d7b6a5c42a9a5c96326b8454:

  Linux 6.10-rc5 (2024-06-23 17:08:54 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.11

for you to fetch changes up to 4a2ebb082297f41803742729642961532e54079e:

  efi: Replace efi_memory_attributes_table_t 0-sized array with flexible array (2024-07-12 10:06:01 +0200)

----------------------------------------------------------------
EFI updates for v6.11

- Drop support for the 'fake' EFI memory map on x86

- Add an SMBIOS based tweak to the EFI stub instructing the firmware on
  x86 Macbook Pros to keep both GPUs enabled

- Replace 0-sized array with flexible array in EFI memory attributes
  table handling

- Drop redundant BSS clearing when booting via the native PE entrypoint
  on x86

- Avoid returning EFI_SUCCESS when aborting on an out-of-memory
  condition

- Cosmetic tweak for arm64 KASLR loading logic

----------------------------------------------------------------
Aditya Garg (1):
      x86/efistub: Call Apple set_os protocol on dual GPU Intel Macs

Ard Biesheuvel (6):
      x86/efi: Drop support for fake EFI memory maps
      efistub/smbios: Simplify SMBIOS enumeration API
      x86/efistub: Enable SMBIOS protocol handling for x86
      x86/efistub: Avoid returning EFI_SUCCESS on error
      x86/efistub: Drop redundant clearing of BSS
      arm64/efistub: Clean up KASLR logic

Kees Cook (2):
      efi: Rename efi_early_memdesc_ptr() to efi_memdesc_ptr()
      efi: Replace efi_memory_attributes_table_t 0-sized array with flexible array

 Documentation/admin-guide/kernel-parameters.txt  |  21 ---
 arch/x86/Kconfig                                 |  20 ---
 arch/x86/boot/compressed/kaslr.c                 |  43 ++---
 arch/x86/include/asm/efi.h                       |  22 +--
 arch/x86/kernel/setup.c                          |   1 -
 arch/x86/platform/efi/Makefile                   |   1 -
 arch/x86/platform/efi/efi.c                      |   2 -
 arch/x86/platform/efi/fake_mem.c                 | 197 -----------------------
 arch/x86/platform/efi/memmap.c                   |   1 +
 drivers/firmware/efi/libstub/Makefile            |   2 +-
 drivers/firmware/efi/libstub/arm64-stub.c        |  13 +-
 drivers/firmware/efi/libstub/arm64.c             |   3 +-
 drivers/firmware/efi/libstub/efistub.h           |   9 +-
 drivers/firmware/efi/libstub/kaslr.c             |  20 +--
 drivers/firmware/efi/libstub/relocate.c          |   2 +-
 drivers/firmware/efi/libstub/smbios.c            |  43 +++--
 drivers/firmware/efi/libstub/unaccepted_memory.c |   2 +-
 drivers/firmware/efi/libstub/x86-stub.c          |  83 ++++++++--
 drivers/firmware/efi/memattr.c                   |   2 +-
 include/linux/efi.h                              |  15 +-
 20 files changed, 146 insertions(+), 356 deletions(-)
 delete mode 100644 arch/x86/platform/efi/fake_mem.c

