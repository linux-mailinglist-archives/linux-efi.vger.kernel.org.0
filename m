Return-Path: <linux-efi+bounces-692-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 592C087002B
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 12:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D90E51F24E6D
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 11:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8659739859;
	Mon,  4 Mar 2024 11:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EfJM/zRG"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62E239AE4
	for <linux-efi@vger.kernel.org>; Mon,  4 Mar 2024 11:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709551221; cv=none; b=XaxHckKP2fdynPbB0Y/HAqIsPMY6utVF8/dZql1ANBFuMV0bb+A4cvtwqcg2F6dTe8Wa1w7x9zPQKRFruMjQa18ZQGVU0Tub/4AIcIi5hsFgOs6a3btFHxBBsBzrXfVt/Xzx6gfS9j+zyQ5ecCaq76hNA75RbCZ92rwL1ry/teQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709551221; c=relaxed/simple;
	bh=4WABv3LbX7RB6RL/LQUoVlByDA2A00lpXRli1Q5d06c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dj5WXNmO0bSaOa922x24C1PuQjXwAVA7LM5e2uFwbnncy5P4XqoM6AFOEifqwdFIQx3ts32lNNLAlC6S+3/8gvKX4RDJ9fGR+LdX2gFnDrHIlgbshW9DJjiBNrogwbiMzzrnEu1WhVJs0mDhnmCayKG/a2EAwSCXAOET3NF4zb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EfJM/zRG; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-607e8e8c2f1so71665857b3.3
        for <linux-efi@vger.kernel.org>; Mon, 04 Mar 2024 03:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709551219; x=1710156019; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D+X5faEeUBlay3vk+5zci3Xi22Op4CTAjCUtJzx6Rx8=;
        b=EfJM/zRGF5GvC0xfnRAsN1k8LX97v9k7oZ8B+Gf4DbTuaz+KwYHnR0vr/WWM4RcCPu
         jUAJLosDIQ50A49WXEbVVV0SU0i9vXchWvgA6w7fZCx+JJ5Rep7Uxld8shL9V+Mx6tbz
         ztfEkTpCRJ/rf4zidC094P18/G/11wliihq79+r8Es7f6xzE+hgHxAgM5KjHA+MU8GKT
         dpFyXA6csdpw7ytIFnkoR1/2ThIDx4coivoWxkXUE6sxPYXzo0xNsXitmXxYEI84Oof5
         nabTqovGyETdiYI6sHMRmPOvE9cRC9Ll69Wu8CwdmpVXMEJ38Izsi/Nqv/QVEbrhBH6n
         VokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709551219; x=1710156019;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D+X5faEeUBlay3vk+5zci3Xi22Op4CTAjCUtJzx6Rx8=;
        b=apjOmIVW/1+ETo4GPa6ue/5bTiHKDczNDOd+JjDmd8OApirilAaWMPurvwamErc5Gf
         Kdv6HCaKnKvvM2pq66Of8LZXYnYAOy07+ZzS1kSnDEGyJVRVUEBmo5dnt7igH/AcKElq
         I1kZJPNTWlYouf5o0WACOT4wy0sDByifHI94He4iCc8dua0eSZw0nn3KgJ/sqfKBZf93
         xD/q/3gLhbRHgZYvwDZMXdrMDOFhI1RLwRwqH3AXLCo88JF+G21ZKkGhdxasUHjpMSUl
         /ilpm3aefWlqjj4FF7iZn46ruY194V858hwwpae20NWTBczptEfc3k5y9dSxFch5YicV
         YgHA==
X-Gm-Message-State: AOJu0YwLW/iE39oXAdyM6tlku6HvOwFyek5nqQEuUS6WWNbv9fShbkzl
	gxtkN1cPwQzBQKuDsFJdJHgaB+w2tZiXseWICHxGr326hWOK2Gh3S8eYGpEhsX+eVd7mVQ==
X-Google-Smtp-Source: AGHT+IGxpdXyNbJ8NDNLY58QKkLKsMoe1cUbU9eDsZBMAQ5XgPPz7Nxib3nj/NtrkNAiThWbJnJ+O323
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:f0b:b0:dcd:2f2d:7a0f with SMTP id
 et11-20020a0569020f0b00b00dcd2f2d7a0fmr325290ybb.9.1709551218767; Mon, 04 Mar
 2024 03:20:18 -0800 (PST)
Date: Mon,  4 Mar 2024 12:19:38 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3462; i=ardb@kernel.org;
 h=from:subject; bh=8zK9T8Um6D+rimjHJ8fjgKpgLdtOefuReu6MIS11PB0=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXpOs/Ws3tmX8oVrT7l5TGPR3SWfWF5V+lt/4+xLvmCl
 5/pyKV3lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIl8vsXIMPea9ovjR67IsdVc
 nPon0UhO5WhC5iRdnX5P/ZYdz7YYv2dkeOQi91uxo1t94uKO1StUP3pZLd/jODV8rsX+EKnVvcf P8wAA
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240304111937.2556102-20-ardb+git@google.com>
Subject: [PATCH stable-v6.1 00/18] efistub/x86 changes for secure boot
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

These are the remaining patches that bring v6.1 in sync with v6.6 in
terms of support for 4k section alignment and strict separation of
executable and writable mappings. More details in [0].

[0] https://lkml.kernel.org/r/CAMj1kXE5y%2B6Fef1SqsePO1p8eGEL_qKR9ZkNPNKb-y6P8-7YmQ%40mail.gmail.com

Ard Biesheuvel (15):
  arm64: efi: Limit allocations to 48-bit addressable physical region
  x86/efistub: Simplify and clean up handover entry code
  x86/decompressor: Avoid magic offsets for EFI handover entrypoint
  x86/efistub: Clear BSS in EFI handover protocol entrypoint
  x86/decompressor: Move global symbol references to C code
  efi/libstub: Add limit argument to efi_random_alloc()
  x86/efistub: Perform 4/5 level paging switch from the stub
  x86/decompressor: Factor out kernel decompression and relocation
  x86/efistub: Prefer EFI memory attributes protocol over DXE services
  x86/efistub: Perform SNP feature test while running in the firmware
  x86/efistub: Avoid legacy decompressor when doing EFI boot
  efi/x86: Avoid physical KASLR on older Dell systems
  x86/efistub: Avoid placing the kernel below LOAD_PHYSICAL_ADDR
  x86/boot: Rename conflicting 'boot_params' pointer to
    'boot_params_ptr'
  x86/boot: efistub: Assign global boot_params variable

Evgeniy Baskov (1):
  efi/libstub: Add memory attribute protocol definitions

Johan Hovold (1):
  efi: efivars: prevent double registration

Yuntao Wang (1):
  efi/x86: Fix the missing KASLR_FLAG bit in boot_params->hdr.loadflags

 Documentation/x86/boot.rst                     |   2 +-
 arch/arm64/include/asm/efi.h                   |   1 +
 arch/x86/boot/compressed/Makefile              |   5 +
 arch/x86/boot/compressed/acpi.c                |  14 +-
 arch/x86/boot/compressed/cmdline.c             |   4 +-
 arch/x86/boot/compressed/efi_mixed.S           | 107 +++----
 arch/x86/boot/compressed/head_32.S             |  32 ---
 arch/x86/boot/compressed/head_64.S             |  63 +----
 arch/x86/boot/compressed/ident_map_64.c        |   7 +-
 arch/x86/boot/compressed/kaslr.c               |  26 +-
 arch/x86/boot/compressed/misc.c                |  69 +++--
 arch/x86/boot/compressed/misc.h                |   1 -
 arch/x86/boot/compressed/pgtable_64.c          |   9 +-
 arch/x86/boot/compressed/sev.c                 | 114 ++++----
 arch/x86/include/asm/boot.h                    |  10 +
 arch/x86/include/asm/efi.h                     |  14 +-
 arch/x86/include/asm/sev.h                     |   7 +
 drivers/firmware/efi/libstub/Makefile          |   1 +
 drivers/firmware/efi/libstub/alignedmem.c      |   2 +
 drivers/firmware/efi/libstub/arm64-stub.c      |   7 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c |   2 +
 drivers/firmware/efi/libstub/efistub.h         |  28 +-
 drivers/firmware/efi/libstub/mem.c             |   2 +
 drivers/firmware/efi/libstub/randomalloc.c     |  14 +-
 drivers/firmware/efi/libstub/x86-5lvl.c        |  95 +++++++
 drivers/firmware/efi/libstub/x86-stub.c        | 295 +++++++++++---------
 drivers/firmware/efi/libstub/x86-stub.h        |  17 ++
 drivers/firmware/efi/vars.c                    |  13 +-
 include/linux/efi.h                            |   1 +
 29 files changed, 560 insertions(+), 402 deletions(-)
 create mode 100644 drivers/firmware/efi/libstub/x86-5lvl.c
 create mode 100644 drivers/firmware/efi/libstub/x86-stub.h

-- 
2.44.0.278.ge034bb2e1d-goog


