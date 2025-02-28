Return-Path: <linux-efi+bounces-2859-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A42A49B28
	for <lists+linux-efi@lfdr.de>; Fri, 28 Feb 2025 15:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E00C13B3683
	for <lists+linux-efi@lfdr.de>; Fri, 28 Feb 2025 14:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB92E276D02;
	Fri, 28 Feb 2025 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R3CDVLRO"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ADE2557A
	for <linux-efi@vger.kernel.org>; Fri, 28 Feb 2025 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740751234; cv=none; b=nHaMVwGf9ebnG3zYty3VMYLfuj4mAW6LRAIrnpY7Wsw1vqJ2K4qUIQZRSGczyxx0GGYfme9W28afRpjsrqcAolfe9vhKq6OBSFJ+zg0lXGCz7W4CMIaCOwQUw9n9EnIs6gBz7pph34rsxHPQJddCwf92gk7tYQ2sxR1CJXcPALo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740751234; c=relaxed/simple;
	bh=bTZwWgQQoOLYJn+hNVS/7FiW8csViIyEHaW6bgEqoiI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=eOlfRKp6cZIQ5MgFeElkSeWO0b6b4CaI5LSbVtMooze/PjVUqjZkwP0RJsgJA6r2Z6Nrf1VvO/yrUd5gF4+qPa70Xu0+wPSqBKZfIp7STEQ2/QF+q9MGeD7lGjUf3d3ePcrZQOg5YKcTrxhfJmsk1vKTBS1R3HWgbc/tPMpSSfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R3CDVLRO; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4394b8bd4e1so11442005e9.0
        for <linux-efi@vger.kernel.org>; Fri, 28 Feb 2025 06:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740751229; x=1741356029; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JuRmyngR+bQk79AWwRaP8X58fidE7IsatMoO9ZozP9Y=;
        b=R3CDVLROA84kGbRAbDoIEByTN4U173FqRKGyxPASPzYK6P7mBv09mZZI89h7GRSYwk
         vRcmF03v9jl6ksqYgPT6HVHK2HXGScL0d8U/N9mleEzS5hHemEQLeLTVHQsxKNRKWCsy
         BcCHv/p3zTU5zu/jX2HPXGCU5+PS60lUhNOB72ccHk1gzh5csRaJw4ZJer+WTsRHy+x3
         GMStM98WktRMuvv+9Wqc9K7RbmSNxZyS8+n/BfDVPlenCymmjMR249v+N73DwbR1kIWP
         ogUa/QUvzwsrMyxJ0KALbv4zT+/rSeDcPE88AQk72IVBBXLG+KiBY8g4am/7HwcwfMON
         JNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740751229; x=1741356029;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JuRmyngR+bQk79AWwRaP8X58fidE7IsatMoO9ZozP9Y=;
        b=JA/C4LWqTmumye29yoQKi0+aoj6fdUsURLhgZCOP11XE3t3KD74vlCPmhvIcrSLhpr
         7vlFEOKBViVKAZWUqQPCyRaSYVAk6HjrS32F6O5HiAcqmzgjbJxDNKAZaESonpB5pzQ2
         VoMTHqyyGej1O4rWmT3gpjI6351DfQBtdK09a9KeAbW0KM1uuQC5OMRSQXtk3tuUWwHG
         6u1zYL56Ja8Xwa6pJCDY+cJfWyEAL/jdTA+lfW3Puu5kiB35KZWXavDmeATY0HQv/EFr
         D2vGUhkomNj/N33hdQZEaVdSaRM4VLW+UdEFx0vkWzasufBePY8bEnBi7x4Ug0vP8mIz
         pgYw==
X-Gm-Message-State: AOJu0YwlahiJ/oQWR8IwQ9knHpI0snQ865QbPclMBX5yn1XfkwhMevtG
	5JCiTD5uiARLq+5QIIpBMsXLxyxcn8auBYpoNk0MIG2TUfBigC05E8UI3GiMx6TplPghxw==
X-Google-Smtp-Source: AGHT+IFP7pcbylgGxu6R39Tq+UfTbhQ2SfEuIioODn3+P7byuaBRj5NwgM/3nbyeIit2oXNCM/gTumnO
X-Received: from wmqa14.prod.google.com ([2002:a05:600c:348e:b0:43b:6943:f013])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:a48:b0:439:a1c7:7b2d
 with SMTP id 5b1f17b1804b1-43ba66da31fmr28260905e9.4.1740751229403; Fri, 28
 Feb 2025 06:00:29 -0800 (PST)
Date: Fri, 28 Feb 2025 15:00:21 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2556; i=ardb@kernel.org;
 h=from:subject; bh=9Jb7oY/WLoh5/2TPVlqEBdHLGEU043kmiacS24ckl0M=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf3gwVJuPfvoGUIr37mWWC0rPyK1L+fW29VyJ9lr1Rd63
 J/zK7Gmo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAExEgIvhf2DWDdWPF+4K5Xi9
 kZxq92RR7o7HUgyG7We62b3tgy8JH2P4p+wyTYlBhy/8oqAtm9Y17RgXkeM79ZtbOi6eW14wd81 0PgA=
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228140020.3558244-2-ardb+git@google.com>
Subject: [GIT PULL] EFI fixes for v6.14 #2
From: Ard Biesheuvel <ardb+git@google.com>
To: torvalds@linux-foundation.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Richard Hughes <richard@hughsie.com>, 
	James Bottomley <James.Bottomley@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Hi Linus,

Another couple of EFI fixes for v6.14. Only James's patch stands out, as it
implements a workaround for odd behavior in fwupd in user space, which creates
EFI variables by touching a file in efivarfs, clearing the immutable bit (which
gets set automatically for $reasons) and then opening it again for writing,
none of which is really necessary. The fwupd author and LVFS maintainer is
already rolling out a fix for this on the fwupd side, and suggested that the
workaround in this PR could be backed out again during the next cycle.

(There is a semantic mismatch in efivarfs where some essential variable
attributes are stored in the first 4 bytes of the file, and so zero length
files cannot exist, as they cannot be written back to the underlying variable
store. So now, they are dropped once the last reference is released.)

Please pull.


The following changes since commit bbc4578537e350d5bf8a7a2c7d054d6b163b3c41:

  efi: Use BIT_ULL() constants for memory attributes (2025-02-04 14:08:22 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.14-2

for you to fetch changes up to e3cf2d91d0583cae70aeb512da87e3ade25ea912:

  efi/mokvar-table: Avoid repeated map/unmap of the same page (2025-02-27 18:25:44 +0100)

Cc: Richard Hughes <richard@hughsie.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>

----------------------------------------------------------------
EFI fixes for v6.14 #2

- Fix CPER error record parsing bugs

- Fix a couple of efivarfs issues that were introduced in the merge
  window

- Fix an issue in the early remapping code of the MOKvar table

----------------------------------------------------------------
Ard Biesheuvel (2):
      efivarfs: Defer PM notifier registration until .fill_super
      efi/mokvar-table: Avoid repeated map/unmap of the same page

James Bottomley (1):
      efivarfs: allow creation of zero length files

Patrick Rudolph (2):
      efi/cper: Fix cper_ia_proc_ctx alignment
      efi/cper: Fix cper_arm_ctx_info alignment

Peter Jones (1):
      efi: Don't map the entire mokvar table to determine its size

 drivers/firmware/efi/cper-arm.c     |  2 +-
 drivers/firmware/efi/cper-x86.c     |  2 +-
 drivers/firmware/efi/mokvar-table.c | 57 ++++++++++++++++++-------------------
 fs/efivarfs/file.c                  | 10 ++++---
 fs/efivarfs/super.c                 |  3 +-
 5 files changed, 37 insertions(+), 37 deletions(-)

