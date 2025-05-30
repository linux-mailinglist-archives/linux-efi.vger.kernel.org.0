Return-Path: <linux-efi+bounces-3805-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28765AC95AF
	for <lists+linux-efi@lfdr.de>; Fri, 30 May 2025 20:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0A5F7B11BA
	for <lists+linux-efi@lfdr.de>; Fri, 30 May 2025 18:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881D721CA04;
	Fri, 30 May 2025 18:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="38EWY7B7"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5C41D6AA
	for <linux-efi@vger.kernel.org>; Fri, 30 May 2025 18:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748630112; cv=none; b=Khk35yWwdnLuQpx5TbOpZKWz7l0/Zo1/hWobD3eTo4yXxLiH2MOkzD2PZznFeP4Q+WoEoHA/WZf2vzhdYHYX9YQnMxhPvUEgU9FYAjQLO10MjfSLJdhYpih9Atk2XYt3BqzHmV9BKW1fSX7vHXAWLVW2DmnZIJKTpKvt6jXrM1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748630112; c=relaxed/simple;
	bh=i4kypj9hiNUEfQ2WQSybM+qTRBYzMWRHxidmZOF4ESU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Q3RdBxUJ9RP+cRmHBGxgOfEO8CIjOjkKccY7qSx1GJKtR9hIx2EAUaSMrYuaYC3k2GVk/CE+KD6i2yeszQbF7H08CWKf+YAm1B6gv747y22gBgDPJwggQqLogEsJDYp6cEieyucB7qpsofdGunK9p3hYg4bXwS9Z1iP8ZjlgWKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=38EWY7B7; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a4ea7e46dfso939388f8f.3
        for <linux-efi@vger.kernel.org>; Fri, 30 May 2025 11:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748630108; x=1749234908; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NQ1jWA7unC5Q+gMw1FhcdnAgONLYpu12xjYbUZvnb6I=;
        b=38EWY7B7J2/iEo+iJg+QtO+aDkbjW6ZCfdQNCF8Ln/KeOZtP7UYFXsuuARPYbCsMiA
         uD2ZW0WvGFTPsJ0mAzqxXda3cj3OmP+xj/S/r2waiWkscs5aXTGU0E0TSslL5IIAeQYy
         +wdbyzb6TbVbySxEpLvivs3gCi8fAvCCCGsGxNO3OgrVEO2GPxvYl1biPJHnRZV/iCwG
         5ma3iv3iCvXqMMYsM5Hn4D6f+PX/VgYZpkFzRAUsQ1DI3KCiPDTADbsO5wWJFGfEf63K
         41kydujMBiKTmDUa/Ub1C4t2BrA7WCA3LWeRbnMjZaciLSwacoKaeHinttGO1yVNWNOV
         TSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748630108; x=1749234908;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NQ1jWA7unC5Q+gMw1FhcdnAgONLYpu12xjYbUZvnb6I=;
        b=MAf+sc+w41eSn+9W6dbRfkwKX+qGlxMNmzuRFN3DfS34Urkq080jAHpQt3bl/MfKI3
         l/AdXonocKOKJsKKBm7BRGq9jNzTLRXH8rD6sVZjKZH1SyrduDxC/kaL6Lotf+B2KJDn
         k+6ygZ4Myvr0OnuV++uVZB2kg44NiWZIRStub0qGeLL6Fyfnttx6l047uUiMsp3QNZLl
         rpjeiIdw3YpzTuPS4rmh3y5cxDwbTAd5SRGDn3dnD4Biz3J+4s/5EKGpyRS0jsR+Lq/4
         NjSc7J84LlKJtc8UbZruPuLBbG19cvND/VlGDGzidFzhOYxfPq/ljtrrspTNRZpajfh6
         JA9A==
X-Gm-Message-State: AOJu0YwhvuFcjDdK2T/yPav7QFfyUiqclmG629EoIiwDAXlb6vXwO1XZ
	wqmK/9+gO2QnxM6UJT12Yg5DGZM04/0XIqOjegzdMz6m0RvUZJxyfU1x0xe3XQWp60y1ypQFAg=
	=
X-Google-Smtp-Source: AGHT+IHo8Kqw+JseTSXYsBlzSEjF4e1B9OSUon70rlUABse7IuY+I6flFtLllIYy7CqAFxqlzguGDnTH
X-Received: from wmbfo18.prod.google.com ([2002:a05:600c:6912:b0:43c:ebbe:4bce])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:40c7:b0:3a4:ead4:5ea4
 with SMTP id ffacd0b85a97d-3a4f89ab616mr2981911f8f.24.1748630107993; Fri, 30
 May 2025 11:35:07 -0700 (PDT)
Date: Fri, 30 May 2025 20:34:50 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3160; i=ardb@kernel.org;
 h=from:subject; bh=+LUHreD44F4tBGRS91Ul/Kl+2pFwpsvMF5+86mvJb7A=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIcPylxd37arnMjW5NRzP+zn1Wl/36jCkR72p6LF7M6967
 4otyus7SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwESkfzEyTA2ykekv7Weqs1fd
 xC6zQvKDT1J8W+9Ds0Nz9dj+rn7fwvCL2XSjBJ/q3d1fXdkYrK45iG5Svb7skoMsd9Vf9n3FHJI 8AA==
X-Mailer: git-send-email 2.49.0.1238.gf8c92423fb-goog
Message-ID: <20250530183449.3558067-2-ardb+git@google.com>
Subject: [GIT PULL] EFI updates for v6.16
From: Ard Biesheuvel <ardb+git@google.com>
To: torvalds@linux-foundation.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Hi Linus,

Not a lot going on in the EFI tree this cycle. The only thing that stands out
is the new support for SBAT metadata, which was a bit contentious when it was
first proposed, because in the initial incarnation, it would have required us
to maintain a revocation index, and bump it each time a vulnerability affecting
UEFI secure boot got fixed. This was shot down for obvious reasons.

This time, only the changes needed to emit the SBAT section into the PE/COFF
image are being carried upstream, and it is up to the distros to decide what to
put in there when creating and signing the build. This PR only has the EFI
zboot bits (which the distros will be using for arm64); the x86 bzImage changes
should be arriving next cycle, presumably via the -tip tree.

Please pull.

The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.16

for you to fetch changes up to 46550e2b878d60923c72f0526a7aac02e8eda3d5:

  include: pe.h: Fix PE definitions (2025-05-21 16:46:37 +0200)

----------------------------------------------------------------
EFI updates for v6.16

- Add support for emitting a .sbat section into the EFI zboot image, so
  that downstreams can easily include revocation metadata in the signed
  EFI images

- Align PE symbolic constant names with other projects

- Bug fix for the efi_test module

- Log the physical address and size of the EFI memory map when failing
  to map it

- A kerneldoc fix for the EFI stub code

----------------------------------------------------------------
Ard Biesheuvel (1):
      Merge branch 'efi-sbat' into efi/next

Bartosz Szczepanek (1):
      efi: Improve logging around memmap init

Hans Zhang (1):
      efi/libstub: Describe missing 'out' parameter in efi_load_initrd

Ivan Hu (1):
      efi/efi_test: Fix missing pending status update in getwakeuptime

Pali Rohar (1):
      include: pe.h: Fix PE definitions

Vitaly Kuznetsov (1):
      efi: zboot specific mechanism for embedding SBAT section

 arch/arm/boot/compressed/efi-header.S          |   6 +-
 arch/arm64/kernel/efi-header.S                 |   6 +-
 arch/loongarch/kernel/efi-header.S             |   4 +-
 arch/loongarch/kernel/head.S                   |   2 +-
 arch/riscv/kernel/efi-header.S                 |   8 +-
 arch/x86/boot/header.S                         |  10 +-
 crypto/asymmetric_keys/verify_pefile.c         |   8 +-
 drivers/firmware/efi/Kconfig                   |  24 +++
 drivers/firmware/efi/libstub/Makefile.zboot    |   4 +
 drivers/firmware/efi/libstub/efi-stub-helper.c |   1 +
 drivers/firmware/efi/libstub/zboot-header.S    |  32 ++-
 drivers/firmware/efi/libstub/zboot.lds         |  11 +
 drivers/firmware/efi/memmap.c                  |   3 +-
 drivers/firmware/efi/test/efi_test.c           |   4 +
 include/linux/pe.h                             | 279 +++++++++++++++----------
 15 files changed, 267 insertions(+), 135 deletions(-)

