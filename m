Return-Path: <linux-efi+bounces-2727-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1960A1BE64
	for <lists+linux-efi@lfdr.de>; Fri, 24 Jan 2025 23:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F8771882A97
	for <lists+linux-efi@lfdr.de>; Fri, 24 Jan 2025 22:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48841E1A35;
	Fri, 24 Jan 2025 22:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UIzur5/G"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5881E7C17
	for <linux-efi@vger.kernel.org>; Fri, 24 Jan 2025 22:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737757522; cv=none; b=uSfOWxiilsKfl9EG4oEgzboNjg/AOhvFEaZk8HYyxM/oNJB4qnc23ucJ0I+mpTICg+WGEWwYSgdYa48/frSKXFX/0o+I5QaRHjtLMXNHmxTWR+MY4cQqF4tWmTvGbLQ5WahrrYAlOYOV/kYHjr3MlTsDk0ZlNfKQnAEWg8qDJaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737757522; c=relaxed/simple;
	bh=4TO6mTzmcN7e7YI2lP/uEve2w/yAsrWEVsA3MOYZkkk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jl6A++I5FXHqPnIoxX9C8UMBWSQd2ISnlTuGhw6qEHLnIN7NNQadS6sIXcH+EGYGy5e2b4RgkvFYPLZIJFpK2nEHfnQWv08ydB/3T1947cHD0ytdRFnaCf1QUrtMHdggOM1ft9ER3C4pxl11Un/yUc1XVpO+uElGnJdBIP50xxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UIzur5/G; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-436723bf7ffso18736575e9.3
        for <linux-efi@vger.kernel.org>; Fri, 24 Jan 2025 14:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737757519; x=1738362319; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=op6C/OdnUoNG0tDQuXB60iQll8nYU9vD+v/Sby19SUg=;
        b=UIzur5/Gumud7on+Evw/CzOb9OwlamPn7JigPIXPaB0tccAMQp1tpWUgS05KqtJvzY
         UMcidbs9+siff3yUGCSDYJOuWCKj1SY0jVAjA4DjTDGrO/cQ2Q+iJbKfbIaTz/5QiXEe
         2ItU8zwJRv0j80tsv1AdlzFPQiyshQSqsP1jzcsHEHNP/adYpUXBmk5eTea+hdkCyUS5
         EsyeEncc5pmaLW1mMom+Pra4sfjNCn3WyeQ76Z6nhEEFoQBf/wCHXhXLlIWn4HzRmxXv
         fT4mB3E+68ivCUAApXLhD8Wy4EnrppgstOa37UM0T2jB7BgsHwgSGXlg0mVZ1koeekSd
         zgsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737757519; x=1738362319;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=op6C/OdnUoNG0tDQuXB60iQll8nYU9vD+v/Sby19SUg=;
        b=GtY5qKB+ehkwIpJZoQglFQVJuFA+AI/fnGYpEK5mpgziZ+q+n344PoQlLLHjoWzv52
         QK3OowlTn+zkpoY0oXL85eSVLTq4OtjNO5kbhi663Pdf5E6aBPUJ/PvYk/HW0TTOpCN0
         J3ekQLdIFPjz1rpOpDXk/hKKAXCndOnLkIYBu32aYQxbPtdluvVGLzjOTykVo+3GY1rB
         H/VypIbmEtFecgW/yq/2qYS/8m8xcj0JLxCFiWtix86bLh/fM0vCtrCq+49rR75Mnn+/
         weJwN5qQmLS6fGwGi0/xyIzwDvVcX3MjOyahxoXCOd3v5AVgZvNoEzsIPixpxhEVs5Hz
         nUnQ==
X-Gm-Message-State: AOJu0YwWflksv/z4Y70gqyno2jop9jZGIOShpJoKmj1m8DWxUUf0xYBP
	FwF9zp22x0Cm4H0hsmUEw5Zy+eBkRzvM/q0wYOOyCMBPuEzianp8KFuuRYJ+pavVOL+dWQ==
X-Google-Smtp-Source: AGHT+IElfJL+++cGtmbIZRCZY8xny6MPEVBgBPJakD1qHieGdRsg7SVeLTiQW54gnK/SZO8eBOrBe4qu
X-Received: from wmsn42.prod.google.com ([2002:a05:600c:3baa:b0:434:e9e2:2991])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4ed4:b0:434:f586:7520
 with SMTP id 5b1f17b1804b1-438913c5d53mr299586675e9.6.1737757519371; Fri, 24
 Jan 2025 14:25:19 -0800 (PST)
Date: Fri, 24 Jan 2025 23:25:11 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5148; i=ardb@kernel.org;
 h=from:subject; bh=/uzfUESl3vN0nmw3Pw3vpPzwY57jzg7EXlFA/BQEt7Q=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIX2KsHsY9+/eV4lBF69HMzsY3ay6GiEaquFw8NzsxfeZj
 Go70gM7SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwESmuTP8D5+YvLFme6HatueP
 TyiJTplvdnGNykKbP60sglxit1a+3cPIsDBEZ2WRhpt4+52JC8T8tTwuPVzVqXpEwfXFZa70D/t NuAE=
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <20250124222510.3849262-2-ardb+git@google.com>
Subject: [GIT PULL] EFI updates for v6.14
From: Ard Biesheuvel <ardb+git@google.com>
To: torvalds@linux-foundation.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Hi Linus,

Please pull the EFI updates below. Details are in the tag.

Note that, even though the commit dates may suggest otherwise, most of these
changes have been in linux-next for at least a week or so before the merge
window opened, with the exception of the GCC 15 and kexec/x86 fixes (which are
tagged for stable). There were some last minute tweaks to James's efivarfs
patches that necessitated a partial rebase (implementing a suggestion by Al
Viro to combine struct inode and struct efivar_entry into a single object)


The following changes since commit 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8:

  Linux 6.13-rc3 (2024-12-15 15:58:23 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.14

for you to fetch changes up to 64b45dd46e154ee7641d7e0457f3fa266e57179f:

  x86/efi: skip memattr table on kexec boot (2025-01-23 09:58:43 +0100)

----------------------------------------------------------------
EFI updates for v6.14

- Increase the headroom in the EFI memory map allocation created by the
  EFI stub. This is needed because event callbacks called during
  ExitBootServices() may cause fragmentation, and reallocation is not
  allowed after that.

- Drop obsolete UGA graphics code and switch to a more ergonomic API to
  traverse handle buffers. Simplify some error paths using a __free()
  helper while at it.

- Fix some W=1 warnings when CONFIG_EFI=n

- Rely on the dentry cache to keep track of the contents of the efivarfs
  filesystem, rather than using a separate linked list.

- Improve and extend efivarfs test cases.

- Synchronize efivarfs with underlying variable store on resume from
  hibernation - this is needed because the firmware itself or another OS
  running on the same machine may have modified it.

- Fix x86 EFI stub build with GCC 15.

- Fix kexec/x86 false positive warning in EFI memory attributes table
  sanity check.

----------------------------------------------------------------
Ard Biesheuvel (8):
      x86/efistub: Drop long obsolete UGA support
      efi/libstub: Use C99-style for loop to traverse handle buffer
      efi/libstub: Simplify GOP handling code
      efi/libstub: Refactor and clean up GOP resolution picker code
      efi/libstub: Simplify PCI I/O handle buffer traversal
      efi/libstub: Use cleanup helpers for freeing copies of the memory map
      efi/libstub: Use __free() helper for pool deallocations
      Merge branch 'efivarfs' into next

Dave Young (1):
      x86/efi: skip memattr table on kexec boot

Hamza Mahfooz (1):
      efi/libstub: Bump up EFI_MMAP_NR_SLACK_SLOTS to 32

James Bottomley (12):
      efivarfs: remove unused efi_variable.Attributes and efivar_entry.kobj
      efivarfs: add helper to convert from UC16 name and GUID to utf8 name
      efivarfs: make variable_is_present use dcache lookup
      efivarfs: prevent setting of zero size on the inodes in the cache
      selftests/efivarfs: add check for disallowing file truncation
      efivarfs: move variable lifetime management into the inodes
      efivarfs: remove unused efivarfs_list
      efivarfs: fix error on write to new variable leaving remnants
      selftests/efivarfs: fix tests for failed write removal
      selftests/efivarfs: add concurrent update tests
      efivarfs: abstract initial variable creation routine
      efivarfs: add variable resync after hibernation

Nathan Chancellor (1):
      efi: libstub: Use '-std=gnu11' to fix build with GCC 15

Randy Dunlap (1):
      efi: sysfb_efi: fix W=1 warnings when EFI is not set

 arch/x86/include/asm/efi.h                     |   3 +
 arch/x86/platform/efi/efi.c                    |  10 -
 arch/x86/platform/efi/quirks.c                 |   5 +
 drivers/firmware/efi/efi.c                     |   3 -
 drivers/firmware/efi/libstub/Makefile          |   2 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c |   9 +-
 drivers/firmware/efi/libstub/efi-stub.c        |  49 ++--
 drivers/firmware/efi/libstub/efistub.h         |  20 +-
 drivers/firmware/efi/libstub/gop.c             | 323 ++++++++++---------------
 drivers/firmware/efi/libstub/kaslr.c           |   4 +-
 drivers/firmware/efi/libstub/mem.c             |  20 +-
 drivers/firmware/efi/libstub/pci.c             |  34 +--
 drivers/firmware/efi/libstub/randomalloc.c     |   4 +-
 drivers/firmware/efi/libstub/relocate.c        |  10 +-
 drivers/firmware/efi/libstub/x86-stub.c        | 164 ++-----------
 drivers/firmware/efi/sysfb_efi.c               |   2 +-
 fs/efivarfs/file.c                             |  59 ++++-
 fs/efivarfs/inode.c                            |  58 ++---
 fs/efivarfs/internal.h                         |  27 ++-
 fs/efivarfs/super.c                            | 275 +++++++++++++++++----
 fs/efivarfs/vars.c                             | 181 ++++----------
 include/linux/efi.h                            |   4 -
 tools/testing/selftests/efivarfs/efivarfs.sh   | 168 ++++++++++++-
 23 files changed, 734 insertions(+), 700 deletions(-)

