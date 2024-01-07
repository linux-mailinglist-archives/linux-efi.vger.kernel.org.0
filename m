Return-Path: <linux-efi+bounces-341-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CDA8263EE
	for <lists+linux-efi@lfdr.de>; Sun,  7 Jan 2024 12:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEDE5B213CC
	for <lists+linux-efi@lfdr.de>; Sun,  7 Jan 2024 11:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFF812E48;
	Sun,  7 Jan 2024 11:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FL6JMx4N"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C69B12E4A
	for <linux-efi@vger.kernel.org>; Sun,  7 Jan 2024 11:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-40e46f5e78aso172405e9.0
        for <linux-efi@vger.kernel.org>; Sun, 07 Jan 2024 03:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704627836; x=1705232636; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6Ajux1Ij3kHin76MGlbPRiRZ+8+wz2R3aGVmjyFtvIc=;
        b=FL6JMx4NMSYJ5uuewjWfbs33P1mqiAwYWw+MbIPqMKGVhqCHnfG3ZYjWhhGsoOTld8
         SXFMGLIVGRel0wq2JxOKdCet91EpV5P2rq+7kdqMOa4frtnvIC+txwyIPtpbRuJBQ6Mm
         D3uHFv248NzCa31EfNIsAJlKgjXFNcC2HMS4lRtd1fAevDT6eQge18sa8G56wByKS0zE
         E/DiI3qK8hL35U9R/WvFMhV5281EG9cAyUcyuv6FV92iSHvPueceMg7xdbRk3YuubvYP
         ehs4Xf1+yNF1TarEBv423+4JJHjjwo7RIJeV/zwjnvoES7qPimx2lTo5u4Tlvop5mGqc
         TCIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704627836; x=1705232636;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Ajux1Ij3kHin76MGlbPRiRZ+8+wz2R3aGVmjyFtvIc=;
        b=ZG/2a7NLBQ7g9U1eFFOjLuq8ZpevX7gr79F0Bgp1n62bt4frV4GGe3HeAkmWUZj2Ot
         aym20n50eresQ+YTwMgqmtHjjDoHHhg253waEEEQTCEgAbrYjM410IRR48Z4KbQExp62
         bJV2E+tA8ePQxi6VZvsaDgCNWwt8m6e65XXarkNNiiktYHpLCZomm+KRkEQFQX+Vhj9j
         rTEOZ8GLO2fUFTewPHxCvG0fuvA9LPeA20ADKszhKEhNjh3n49E83r3BLTgJsgwXjirW
         gU/ff/ehSUGRXiF+8+/jvgkb2SnwGqJwSXEyi8Rdq4FZhM7txn3CzY5GgjSzISeWI9k4
         LlRw==
X-Gm-Message-State: AOJu0Yw5LtL5dRwM2fVEL6ewjxsDK7DbbEPAm7DGRbAUe+kohOi5LOLg
	xuQy8fLA+zyhinda9oRM8hV9ki8cbuG1MHI=
X-Google-Smtp-Source: AGHT+IH16zLYduNFlA/cGuHwVL1Xk9sZgpVFsuuwZWnJhye3wcsSCJQV+ifPZc0+iBGbmHfjrtze4UFi
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:4f13:b0:40d:5eb0:dd86 with SMTP id
 l19-20020a05600c4f1300b0040d5eb0dd86mr96998wmq.2.1704627836179; Sun, 07 Jan
 2024 03:43:56 -0800 (PST)
Date: Sun,  7 Jan 2024 12:43:45 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3200; i=ardb@kernel.org;
 h=from:subject; bh=npO8sr7fsfLXyPsP/R5wVjS9S6hdmrqekHhiH28yl3k=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXVWX2HkfZnNnnrVlQ+jRW7sWZosm5bbN6F6gck+5vQKw
 dWeLd87SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwERychn+ijy57nP76TeuaKvA
 w56tiRd9P+6KE4q8uLnx6o/2wEffhBn+aQjMZ2oNuX22yCrNKYoj97tAjI1kShHzpfRS/tn347c wAQA=
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240107114345.3415677-2-ardb+git@google.com>
Subject: [GIT PULL] EFI updates for v6.8
From: Ard Biesheuvel <ardb+git@google.com>
To: torvalds@linux-foundation.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Hi Linus,

Please consider the EFI pull request below. There is some new stuff as well as
some low-urgency fixes, which may be backported later.


The following changes since commit 50d7cdf7a9b1ab6f4f74a69c84e974d5dc0c1bf1:

  efi/x86: Avoid physical KASLR on older Dell systems (2023-12-11 17:57:42 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.8

for you to fetch changes up to 4afa688d7141ae7a166d32224abbfd536acccfca:

  efi: memmap: fix kernel-doc warnings (2023-12-22 10:42:06 +0100)

----------------------------------------------------------------
EFI updates for v6.8

- Fix a syzbot reported issue in efivarfs where concurrent accesses to
  the file system resulted in list corruption

- Add support for accessing EFI variables via the TEE subsystem (and a
  trusted application in the secure world) instead of via EFI runtime
  firmware running in the OS's execution context

- Avoid linker tricks to discover the image base on LoongArch

----------------------------------------------------------------
Ard Biesheuvel (4):
      efivarfs: Move efivar availability check into FS context init
      efivarfs: Free s_fs_info on unmount
      efivarfs: Move efivarfs list into superblock s_fs_info
      Merge branch 'efi/urgent' into efi/next

Ilias Apalodimas (1):
      efivarfs: force RO when remounting if SetVariable is not supported

Masahisa Kojima (4):
      efi: expose efivar generic ops register function
      efi: Add EFI_ACCESS_DENIED status code
      efi: Add tee-based EFI variable driver
      efivarfs: automatically update super block flag

Randy Dunlap (1):
      efi: memmap: fix kernel-doc warnings

Wang Yao (1):
      efi/loongarch: Directly position the loaded image file

 arch/loongarch/include/asm/efi.h              |   2 -
 arch/loongarch/kernel/head.S                  |   1 -
 arch/loongarch/kernel/image-vars.h            |   1 -
 arch/loongarch/kernel/vmlinux.lds.S           |   1 -
 drivers/firmware/efi/Kconfig                  |  15 +
 drivers/firmware/efi/Makefile                 |   1 +
 drivers/firmware/efi/efi.c                    |  18 +
 drivers/firmware/efi/libstub/loongarch-stub.c |   9 +-
 drivers/firmware/efi/libstub/loongarch-stub.h |   4 +
 drivers/firmware/efi/libstub/loongarch.c      |   6 +-
 drivers/firmware/efi/memmap.c                 |   8 +-
 drivers/firmware/efi/stmm/mm_communication.h  | 236 ++++++++++
 drivers/firmware/efi/stmm/tee_stmm_efi.c      | 616 ++++++++++++++++++++++++++
 drivers/firmware/efi/vars.c                   |   8 +
 fs/efivarfs/inode.c                           |   3 +-
 fs/efivarfs/internal.h                        |   8 +-
 fs/efivarfs/super.c                           |  66 ++-
 fs/efivarfs/vars.c                            |   5 +-
 include/linux/efi.h                           |  12 +
 19 files changed, 987 insertions(+), 33 deletions(-)
 create mode 100644 drivers/firmware/efi/libstub/loongarch-stub.h
 create mode 100644 drivers/firmware/efi/stmm/mm_communication.h
 create mode 100644 drivers/firmware/efi/stmm/tee_stmm_efi.c

