Return-Path: <linux-efi+bounces-5751-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D53C9AFE2
	for <lists+linux-efi@lfdr.de>; Tue, 02 Dec 2025 10:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3C4E4E2B13
	for <lists+linux-efi@lfdr.de>; Tue,  2 Dec 2025 09:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAA4315D3B;
	Tue,  2 Dec 2025 09:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y0zpZkkM"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3EA313E22
	for <linux-efi@vger.kernel.org>; Tue,  2 Dec 2025 09:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764669132; cv=none; b=DPdHQSqGYXVieIiwta59UvTy6ojtBiMCFsLEE23JT9TJo1XmF+Q1Edq0wqRVsqmJv0G/Z3sh1NOGG/PC3nr6gPPOXgvtW+OSmNdEwqdCQyz8irkPzTwp4RaOCjtO80MGggFi6skn3ebzS+73yQXrbvIK0j3DojzYY0Y4DMC2A1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764669132; c=relaxed/simple;
	bh=cGVJeB1biFkbYFI2PpV76u0GBvHHeEl1D+nK4Ssp4OY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Z+j9Rva3/RkxCc0fy69GBqDLyTTo66AWJDt4+2ei/0I9eVgYwkgyngJQrsQrnQN2qYKLsPbxPDbfzKvAsQ3PqCUg7FL9Oc0GJZxIzWp0zcT8JOOFVKmSblSHPODzf/wNLZSQHLn2YCklCwAknlhJnQmqV5bf1hUcH1gp5h3pxTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y0zpZkkM; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-42b3c965ce5so3816737f8f.2
        for <linux-efi@vger.kernel.org>; Tue, 02 Dec 2025 01:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764669129; x=1765273929; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8+8dul6+U8cE9528GTL7NwOeLD1imDBXo0lXVhSR/i8=;
        b=y0zpZkkMCjJt3T5Wkum8/XP99x6/NsVYWFN5S9eoPKSzwDmZ3xRyoPwnjy52hDgNm+
         YNUj2eI53wPasXCTezSIiASmpGWM4h2CCPTjVG5RH5X4zzZu/0S/j2dV+SBr71N+Ung6
         w28NeJCyuKvLA7mRWQYv+BzZD/GPytv41SYYrYEj1kUuLFuwwfOYxkBYFCm00nniU757
         o4PajczGBZfLiZmhLjKkH1ScbfAPjSscq7At0tWl821jUdsCtZLlDio5TP6wJgy2WoGQ
         iBNBNrVLWEmi3d/sDVUbxO13UjLK3NRqFswTMIwat0oJLZtJyHS9ovYoGF1fEdWXsrCu
         t1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764669129; x=1765273929;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8+8dul6+U8cE9528GTL7NwOeLD1imDBXo0lXVhSR/i8=;
        b=cckBpjCdtzv39IHC0P35HgbSw1ZLoit9SxCCTUu/uGWl+jG0/+6wk53Lc4Yup1IUzj
         6gurMhfBwXg/neTrRH7CdwINpxQJp7YC8apLCar75g88581YfLOMUertPV7H1roEP8pf
         aOlceT7vH8Sfamep8KaCcrRxXbsp/brwz+EurIx43EISoQbXOfeDdqxVd3CsbQ7nRcrn
         Ydhx3/s+IVlsBM7+bGmvNutdynf9yQiKMp9LPjAO1CZgLtgkK9ivZPXyvYMoqL6xzJQ7
         jHc60Gkhe6Y/kfLqYIZeuYuUqFvAAIXrVQM13oOlozTy1oX7+gdCB9O70b5TjhLJN7wJ
         gRUA==
X-Gm-Message-State: AOJu0YzUbZftC4RmtCQ5sIDIdiAjPNWrQnvCJ+WFwi9cD1q9SjKMwpHm
	E93/j+9e3fWcqo6XIEDoEzENsdJvfowAAjSctQ7Gyk1ly3CqVdgU9YdqTIYagYYMUX45gUtJTA=
	=
X-Google-Smtp-Source: AGHT+IHslhJAo2T0QgJc1YKbJUANq1Fp3G4YCWe9QQdYpTAKcY6nZwZGe9fWqHvmOYip83vUWHf6VhNs
X-Received: from wrqr1.prod.google.com ([2002:a5d:4981:0:b0:429:c40a:27c0])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:64c5:0:b0:3f2:b077:94bc
 with SMTP id ffacd0b85a97d-42e0f1fc074mr31019911f8f.4.1764669129268; Tue, 02
 Dec 2025 01:52:09 -0800 (PST)
Date: Tue,  2 Dec 2025 10:52:00 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3230; i=ardb@kernel.org;
 h=from:subject; bh=W6EPHsngCjSxvV38wO22/ZDWV2a6d4M8xfJ7uftv3Qg=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIVNv24GVVg9nul3okpK+uqpu3QqJlr99Nnq8FXeUs5v+x
 K5lOfeto5SFQYyLQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEyk8Dsjwy/Dz+ZPja87V/RP
 KBZ5pRZXanlONmidgMHjmuq1U5tf5DIyvD/x0d5O6fDWFR2fzT49rk5Ie2lXcKQsfMf1pxlfC1k aOAE=
X-Mailer: git-send-email 2.52.0.107.ga0afd4fd5b-goog
Message-ID: <20251202095159.1183189-2-ardb+git@google.com>
Subject: [GIT PULL] EFI updates for v6.19
From: Ard Biesheuvel <ardb+git@google.com>
To: torvalds@linux-foundation.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Hi Linus,

The usual trickle of EFI contributions. There are some arm64 specific change
this cycle too, but they will land via the arm64 tree.

Please pull.


The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.19

for you to fetch changes up to 7a2ff00c3b5e3ca1bbeb13cda52efe870be8501b:

  docs: efi: add CPER functions to driver-api (2025-11-21 09:42:03 +0100)

----------------------------------------------------------------
EFI updates for v6.19:

- Parse SMBIOS tables in memory directly on Macbooks that do not
  implement the EFI SMBIOS protocol

- Obtain EDID information from the primary display while running in the
  EFI stub, and expose it via bootparams on x86 (generic method is in
  the works, and will likely land during the next cycle)

- Bring CPER handling for ARM systems up to data with the latest EFI
  spec changes.

- Various cosmetic changes.

----------------------------------------------------------------
Breno Leitao (1):
      efi/memattr: Convert efi_memattr_init() return type to void

Francesco Pompo (1):
      efistub/x86: Add fallback for SMBIOS record lookup

Jason Tian (1):
      RAS: Report all ARM processor CPER information to userspace

Mauro Carvalho Chehab (4):
      efi/cper: Adjust infopfx size to accept an extra space
      efi/cper: Add a new helper function to print bitmasks
      efi/cper: align ARM CPER type with UEFI 2.9A/2.10 specs
      docs: efi: add CPER functions to driver-api

Qiang Ma (1):
      efi/riscv: Remove the useless failure return message print

Randy Dunlap (1):
      efi: stmm: fix kernel-doc "bad line" warnings

Thomas Zimmermann (5):
      efi: Fix trailing whitespace in header file
      efi/libstub: gop: Find GOP handle instead of GOP data
      efi/libstub: gop: Initialize screen_info in helper function
      efi/libstub: gop: Add support for reading EDID
      efi/libstub: x86: Store EDID in boot_params

 Documentation/driver-api/firmware/efi/index.rst |  11 +-
 drivers/acpi/apei/ghes.c                        |  27 ++---
 drivers/firmware/efi/cper-arm.c                 |  52 +++++----
 drivers/firmware/efi/cper.c                     |  62 ++++++++++-
 drivers/firmware/efi/libstub/efi-stub.c         |   2 +-
 drivers/firmware/efi/libstub/efistub.h          |  31 +++++-
 drivers/firmware/efi/libstub/gop.c              | 137 +++++++++++++++---------
 drivers/firmware/efi/libstub/x86-stub.c         | 104 +++++++++++++++++-
 drivers/firmware/efi/memattr.c                  |   7 +-
 drivers/firmware/efi/riscv-runtime.c            |  10 +-
 drivers/firmware/efi/stmm/mm_communication.h    |   6 +-
 drivers/ras/ras.c                               |  40 ++++++-
 include/linux/cper.h                            |  12 ++-
 include/linux/efi.h                             |   6 +-
 include/linux/ras.h                             |  16 ++-
 include/ras/ras_event.h                         |  49 ++++++++-
 16 files changed, 438 insertions(+), 134 deletions(-)

