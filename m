Return-Path: <linux-efi+bounces-496-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC6184F51A
	for <lists+linux-efi@lfdr.de>; Fri,  9 Feb 2024 13:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76BBA1C20D67
	for <lists+linux-efi@lfdr.de>; Fri,  9 Feb 2024 12:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE0C2E852;
	Fri,  9 Feb 2024 12:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zySJsSXy"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA452E633
	for <linux-efi@vger.kernel.org>; Fri,  9 Feb 2024 12:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707481150; cv=none; b=mh5IEECWFyMfhGn5AhCUXaieyKxvlJWh81CTDxHJcK1sfYj4VQvxmzssD0/pxsFM7oOMHMFzBwmPU0Ymkj5UFFFHFWQPUp7wrOuIbgP1o2LxrNHRK8b24nl3qMgLeG/NhXVkQv4UJ5+Xmmt5bjqIa6bS8rIMyG28fNDb7ZvIwAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707481150; c=relaxed/simple;
	bh=Fz97hPtjSC+OlzB5S+RdJ497UrQcECmFNfNq8/St2qw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lx2whrENALrIITUI7LOS1jVEeRDEPVXPdO7F84yCGI87wNBHJHgu+dXXDned2/7FIPStOggFJ3NNTJ/9xB+ztOBEMLcqcrgfHEILo2Xz5Cj3xEK7p48hHXr7Dz5sZfDLQ88e6ZDB5VhTD3L20+40C47VCZcBh7l6oTcbluRALYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zySJsSXy; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-604a1a44b56so13981577b3.2
        for <linux-efi@vger.kernel.org>; Fri, 09 Feb 2024 04:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707481144; x=1708085944; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=quZsX58dQ+HVXzhaUb6f7zbFZuRk+f3w0M4WrUFa+BM=;
        b=zySJsSXySUM1p0OCWSHMrf5ekFH9+Kd0WHodk1niClDMSQuUZLWT6QNPKxrCuxsl/o
         y2yE+rnWzL1qyWXHH6LcNnb8EteT0bxxV1/u95UYubSDyQjmfK2G3EVYE8C/ugixhnmb
         X4dnlBuRNbxsmaVt34jrHQDh7ZipJ1vFxXFpbA1yArN9aY0TxPtIRYG2ClE5oAW9kmdm
         ok0A1lwAsrz/Ha23Qo3Jamwlj2DLPpAngtP1W275vrkp0WafyXHFd+zLIxBTeLJuBgZj
         tY3NGIJLCYnrKKeekNMYNmBV0Oy35S8lcyPeXzeC6RSyXYEH7jNGFq6S7uY/gI9OdS96
         pa6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707481144; x=1708085944;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=quZsX58dQ+HVXzhaUb6f7zbFZuRk+f3w0M4WrUFa+BM=;
        b=bNgdniU8/NDHF5hTo88qLllM4hmNnaBZTSVj+aUlbxyIHrs5RvpJ7m3+kRAVna46S5
         9I1sIfWUy335J7sW98vDRoHp36uWR2kZBEGFruYveWq7j5rGwr4bBfUsimB6LncId++Y
         tjc2L899DwO7xedrwQv1jid7rZqXWkyJUJe4jCPOaZE3bc+88/TQyRiEqaj3M5kKzw4h
         RA5qjAo2hcA4LnuDwNjBpQeF2QK2z4gD2YPtCQYXTL/eVEdc/OxNL1rAonBGAxoH1beQ
         rbqT/Mjq68hEkVYJz+r/FC9eiNCSdwr1VyF/+crl0QblZzC1eQoaQJrEEm78IEavsj4V
         RQ4Q==
X-Gm-Message-State: AOJu0YyK45Dgm4aXylKUw+TLlMSrsepijo//T5CaCkD59Z5JIL4yTajy
	fUMvpht1yJZv6ElDEbOU2xTdb3o1PnTCW+/Y7ZvMLhbm9vn+EYbubZOPLSa9TkFkNlm/CQ==
X-Google-Smtp-Source: AGHT+IH1vRDlMeGAxe8bcv81+IMNpQ93Jnuy0Ntz689CB/ZZcbADMTF5D5JDeSzXHtkorSyGRRki0J8T
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a0d:ccd0:0:b0:604:4c5:7dc8 with SMTP id
 o199-20020a0dccd0000000b0060404c57dc8mr203711ywd.8.1707481143926; Fri, 09 Feb
 2024 04:19:03 -0800 (PST)
Date: Fri,  9 Feb 2024 13:18:55 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3415; i=ardb@kernel.org;
 h=from:subject; bh=Z411jHmvHC9CXaHKxH3FxGI8kz3lyIaloNgPcG5Bl4s=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfWYhL7G+iRNpV2Tdp03Z3g055rxn3Wmtk+erpF0ejn7l
 HXokm0PO0pZGMQ4GGTFFFkEZv99t/P0RKla51myMHNYmUCGMHBxCsBEHooz/OFb7PDAx1TRuOlv
 +Ipf7wTbmv+0cx35q/cjMmZqFbeyUw8jw/9GrZWW9Uuf9t84GXkricXtZ13xQqaAkzN7JNebvGB aygQA
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240209121854.4043660-2-ardb+git@google.com>
Subject: [GIT PULL] EFI fixes for v6.8 #1
From: Ard Biesheuvel <ardb+git@google.com>
To: torvalds@linux-foundation.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Hello Linus,

Please consider the changes below for v6.8.

Only notable change here is the patch that changes the way we deal with
spurious errors from the EFI memory attribute protocol. This will be backported
to v6.6, and is intended to ensure that we will not paint ourselves into a
corner when we tighten this further in order to comply with MS requirements on
signed EFI code. Note that this protocol does not currently exist in x86
production systems in the field, only in Microsoft's fork of OVMF, but it will
be mandatory for Windows logo certification for x86 PCs in the future.


The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.8-1

for you to fetch changes up to 1ad55cecf22f05f1c884adf63cc09d3c3e609ebf:

  x86/efistub: Use 1:1 file:memory mapping for PE/COFF .compat section (2024-02-05 10:24:51 +0000)

----------------------------------------------------------------
EFI fixes for v6.8 #1

- Tighten ELF relocation checks on the RISC-V EFI stub
- Give up if the new EFI memory attributes protocol fails spuriously on
  x86
- Take care not to place the kernel in the lowest 16 MB of DRAM on x86
- Omit special purpose EFI memory from memblock
- Some fixes for the CXL CPER reporting code
- Make the PE/COFF layout of mixed-mode capable images comply with a
  strict interpretation of the spec

----------------------------------------------------------------
Andrew Bresticker (2):
      efi: runtime: Fix potential overflow of soft-reserved region size
      efi: Don't add memblocks for soft-reserved memory

Ard Biesheuvel (4):
      riscv/efistub: Tighten ELF relocation check
      x86/efistub: Give up if memory attribute protocol returns an error
      x86/efistub: Avoid placing the kernel below LOAD_PHYSICAL_ADDR
      x86/efistub: Use 1:1 file:memory mapping for PE/COFF .compat section

Ira Weiny (2):
      cxl/cper: Fix errant CPER prints for CXL events
      cxl/trace: Remove unnecessary memcpy's

Jan Kiszka (1):
      riscv/efistub: Ensure GP-relative addressing is not used

Yang Li (1):
      efi/libstub: Add one kernel-doc comment

 arch/x86/boot/header.S                     | 14 ++++++--------
 arch/x86/boot/setup.ld                     |  6 +++---
 drivers/acpi/apei/ghes.c                   | 26 --------------------------
 drivers/cxl/core/trace.h                   |  6 +++---
 drivers/firmware/efi/arm-runtime.c         |  2 +-
 drivers/firmware/efi/cper.c                | 19 +++++++++++++++++++
 drivers/firmware/efi/efi-init.c            | 19 ++++++++++---------
 drivers/firmware/efi/libstub/Makefile      |  4 ++--
 drivers/firmware/efi/libstub/alignedmem.c  |  1 +
 drivers/firmware/efi/libstub/efistub.h     |  3 ++-
 drivers/firmware/efi/libstub/kaslr.c       |  2 +-
 drivers/firmware/efi/libstub/randomalloc.c | 12 +++++++-----
 drivers/firmware/efi/libstub/x86-stub.c    | 25 +++++++++++++++----------
 drivers/firmware/efi/libstub/x86-stub.h    |  4 ++--
 drivers/firmware/efi/libstub/zboot.c       |  2 +-
 drivers/firmware/efi/riscv-runtime.c       |  2 +-
 include/linux/cper.h                       | 23 +++++++++++++++++++++++
 17 files changed, 97 insertions(+), 73 deletions(-)

