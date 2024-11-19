Return-Path: <linux-efi+bounces-2180-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AAD9D2F58
	for <lists+linux-efi@lfdr.de>; Tue, 19 Nov 2024 21:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 904E61F236D1
	for <lists+linux-efi@lfdr.de>; Tue, 19 Nov 2024 20:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBCD1D2B04;
	Tue, 19 Nov 2024 20:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jhx5OVXM"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACC2198E63
	for <linux-efi@vger.kernel.org>; Tue, 19 Nov 2024 20:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732047164; cv=none; b=PYfeOSYDD+WkjZfmU0GXLSDkGtcMx3VTfIv8ReRLPAcbjfiQADjY4hw3GU6VxFc0/NeNb0mojZpOpuFY9+0EpeXJzwjF3zdOlytvUGHJmFLsISXu88Mqz2+65TqcISupXsyKwR4nhunujG6bTpWXJ4jwFwMQ+bsc8psSFsNJtwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732047164; c=relaxed/simple;
	bh=qW+lnzdqjtS9NQj9yk51kdFASp6pNDH4gps3Hj72ZaI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LaYZ7hqMkLKt8tZOHqDTf9GyGyAanl3XWGDn5ND2BV8hqiQozYCaHIW6wzopYwsgW/S9wWIqi4iTSBNuN33K2q3mSlS0X84/ORFEMz6280lDPL2YpoHtylMAA7tAnhpcWcb6+fISvfpkBCJ2a0012UJIRMW03pWUPql3qCGVR2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jhx5OVXM; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6eeb5ee73f0so12374117b3.3
        for <linux-efi@vger.kernel.org>; Tue, 19 Nov 2024 12:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732047161; x=1732651961; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HRKeOFovcZVCuKyilU+rXAKb4WtWzJb7w/eFRD32RFc=;
        b=Jhx5OVXMFS938mgyOVHWFcf7lhf4Ezx9zdDiB4QOeUE5p/KEkGoG7tbRgOw8G9TAXl
         +5RCfNsw28aWZCTmeqwuo+consq/hUYr497YtNemyc3V1jg8FOLyitI7ZyHyipzpda7O
         lLN5W88hyU8XnA3fkRSvHebf1JxdP4gshN9K+RQJf3+OvFsAvo7xulYGB7Iv0mg48p9S
         YnHA7QmISpf6234sHyE9Ucr7M9fwc2FnoOo8wzye+s7mKmtOIsksoahYI1DL6slIuiyZ
         jUBnSpNVdZK2uWrvdJ55ZAVHkuyDkC041UaGvX0ojZqWlZW+ZP+02FhgmBP3XukaqapO
         vvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732047161; x=1732651961;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HRKeOFovcZVCuKyilU+rXAKb4WtWzJb7w/eFRD32RFc=;
        b=d+/nuC02GsJLpbbAz4fXXh+FIaK+nsGJqPMEx927ktjPrydE/isSnury8229g5Mls7
         wyHYo8paL/RZgorlrxqBAEzdGfOeDQ3EVYnlFP6l60cSvLGF+DvOV/c6Np5mjdOVJYhI
         IUDM/6NzcUsAfzzkeqrE2bormDBpozPigUqFyOR02qRkLupMnS3oFo8t34NHYXbZh7kz
         /V+LVyYBDUUBrXqI7xdrjpDTwdtgv7zwSYg8+II19J8ODYgcLYTR8ZncNur9CFXX506w
         K6mouZYL9iJLSlhN4o6kltYeZDR3W7JTmw+JIK9VYGli9Hfluc6BdxlneOIvcAoD3fqw
         auOQ==
X-Gm-Message-State: AOJu0YxgcjdRIB5qKQdxwOxMVwcjNu+BArBT5iNEVBvEWeDetJNaSQLe
	fXVxYdFnQLHkuAZbC6dSJIk6B2K1QYruIoIpYgP346dxh/Q9pKGhl2ufwnBEWGB3yWjJ/g==
X-Google-Smtp-Source: AGHT+IGkRb0olXy0ZNAlaUuZ2GPVWL3qfg1msLzVLkJ2rQ8xEgQEB32Bcg+8+BMr/ehhNQLGwoj/YydJ
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:690c:2b06:b0:6ee:3b47:59a3 with SMTP id
 00721157ae682-6eebd12b0e2mr687b3.2.1732047161006; Tue, 19 Nov 2024 12:12:41
 -0800 (PST)
Date: Tue, 19 Nov 2024 21:11:43 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3168; i=ardb@kernel.org;
 h=from:subject; bh=qcswWGi17DLzONr6gyxRCAeaur5RYeypzAkeRi6dc0Y=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JId3mw7+LwVaiUgLay+IqHAS/ewX84b4V/PWJ1ttZi37af
 gv2T3reUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbyag8jw65XChpbI79NKj8s
 n6Lq/NdrfV6I8+fiZcZPp23RZ+4p3cbIsPVbBaN7jJZ2aJHn+qyfmgamWziS3hXUxiw8UZ68IZK fGwA=
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241119201142.1339434-2-ardb+git@google.com>
Subject: [GIT PULL] EFI updates for v6.13
From: Ard Biesheuvel <ardb+git@google.com>
To: torvalds@linux-foundation.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Hi Linus,

Just some cleanups and bug fixes this time around.

Please pull,



The following changes since commit 8e929cb546ee42c9a61d24fae60605e9e3192354:

  Linux 6.12-rc3 (2024-10-13 14:33:32 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.13

for you to fetch changes up to c5d91b16f525ea8c98b3fd8efc5105106d17fe9a:

  efi: Fix memory leak in efivar_ssdt_load (2024-11-17 08:54:02 +0100)

----------------------------------------------------------------
EFI updates for v6.13

- Align handling of the compiled-in command line with the core kernel

- Measure the initrd into the TPM also when it was loaded via the EFI
  file I/O protocols

- Clean up TPM event log handling

- Sanity check the EFI memory attributes table, and apply it after kexec
  too

- Assorted other fixes

----------------------------------------------------------------
Ard Biesheuvel (6):
      efi/libstub: Free correct pointer on failure
      efi/zboot: Fix outdated comment about using LoadImage/StartImage
      efi/memattr: Ignore table if the size is clearly bogus
      efi/libstub: Parse builtin command line after bootloader provided one
      efi/libstub: Fix command line fallback handling when loading files
      efi/libstub: Take command line overrides into account for loaded files

Cyrill Gorcunov (1):
      efi: Fix memory leak in efivar_ssdt_load

Gregory Price (4):
      tpm: fix signed/unsigned bug when checking event logs
      tpm: do not ignore memblock_reserve return value
      tpm: fix unsigned/signed mismatch errors related to __calc_tpm2_event_size
      libstub,tpm: do not ignore failure case when reading final event log

Jeremy Linton (1):
      efi/libstub: measure initrd to PCR9 independent of source

Jonathan Marek (2):
      efi/libstub: fix efi_parse_options() ignoring the default command line
      efi/libstub: remove unnecessary cmd_line_len from efi_convert_cmdline()

Nicolas Saenz Julienne (2):
      x86/efi: Drop support for the EFI_PROPERTIES_TABLE
      x86/efi: Apply EFI Memory Attributes after kexec

 arch/x86/platform/efi/efi.c                    | 20 +-----------
 arch/x86/platform/efi/efi_64.c                 | 42 --------------------------
 drivers/firmware/efi/Kconfig                   | 10 +++---
 drivers/firmware/efi/efi.c                     | 41 +++++++++++++++++--------
 drivers/firmware/efi/libstub/efi-stub-helper.c | 12 ++++----
 drivers/firmware/efi/libstub/efi-stub.c        | 26 +++++++---------
 drivers/firmware/efi/libstub/efistub.h         |  2 +-
 drivers/firmware/efi/libstub/file.c            | 22 ++++++++++++++
 drivers/firmware/efi/libstub/tpm.c             |  9 ++++--
 drivers/firmware/efi/libstub/x86-stub.c        |  3 +-
 drivers/firmware/efi/memattr.c                 | 18 ++++++++++-
 drivers/firmware/efi/tpm.c                     | 26 ++++++++++------
 include/linux/efi.h                            | 17 ++---------
 include/linux/tpm_eventlog.h                   |  2 +-
 14 files changed, 117 insertions(+), 133 deletions(-)

