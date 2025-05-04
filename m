Return-Path: <linux-efi+bounces-3551-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD07AA859A
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 11:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC3A83AFFE8
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 09:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CB619DF4A;
	Sun,  4 May 2025 09:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pQ9hQhvU"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B94B19D8A2
	for <linux-efi@vger.kernel.org>; Sun,  4 May 2025 09:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746352387; cv=none; b=ekKcEOeVKI2WpTw3Dr+1lIYNbB6iHv0K8MCEKjLrUaP/L6bEyJAhluV+sKhRyMGTb/y/2vk0IsDSj+57VP/moNLOe7jc+1dtCnxmrcsMZg4ooZ/GsLK6L9NAoty4i2wBFIiNgGP6KALrLz7B7BPTg0jIGdkq6FaHFEgXZ2QuI70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746352387; c=relaxed/simple;
	bh=UXRAHnrW6o1Hrp9nY+SdVgPlslZXfTGylV7XaZlZmQg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nu1PBjubr+mzwpWfseGoUzwmZBO979d8IAAdAF1ApBhrn87XwZZg4nFlAv+LshUVH7P/FAXfTI8L26quD/eIjJQ9v0Df0BVeZCBFRHzLwkImh3XfbrimHMpPh55sFHITjpns4ZbnAhtPzpMwXBSmvSWHMJRKSKk8ud6Mj94Q8aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pQ9hQhvU; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-391315098b2so982548f8f.2
        for <linux-efi@vger.kernel.org>; Sun, 04 May 2025 02:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746352384; x=1746957184; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tgjYGmqJERA16GUSQyNl5d/TCxFdDCj9qH5HlRk6i3s=;
        b=pQ9hQhvUW4v9Og0qlq3hctczxdD/V/6ezNfxncZ89jmQZurCK43aZBXQ8JDRTryiET
         heO0RDt3TCZxbVXlECSKnFFF3bxmqhb8FoIt31Dt+YVHw8aLXDQYV6VbUBTkjd9nh7L4
         cfi9H+E04RArs8V10ylkQZOiCcZBZ/Jo/B7O0Y9dyMbay5kVAcdNOF/ak2xPp29fnEZu
         I3K2MkTMI2VAkAE98MDMlQxZpkiclEE4E5UGB7jlnmUREA4uAdKLtyft+V4a6BA003up
         pElzLJHw+0RImWyNkZvnDLngTKwdrYKNyG5acrHhbaNpC2HSfNwFvT9I29Zp65RN9w7+
         G0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746352384; x=1746957184;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tgjYGmqJERA16GUSQyNl5d/TCxFdDCj9qH5HlRk6i3s=;
        b=HZSsru8G5wPZT9y6B8wHCS0d1A3U3YpwwbiSZqky7jB0C/DXrETP38qXLJ2J7UN/5O
         Vk66KntTEcUFhHTmwAqKN2g3VUAS9DvqzHVDGF3qrg175OjGDMNHYuribYjP2IasnjW8
         5aF26sJZot5TpDfe/xL3S2G0vBXoB4tzx73VtlJ0UkCG99tP28OyTTZdBqH13jGbryVt
         wYAmi7bEdsRKITH9sd1rTLG4F+cZbWq1ZgENtAyl55Qd5kgkgGdJb1Zq/iZDUuc4T0NI
         gcwYrzmT1tIsnygdbwW+lzQn2vP3+HnCjhHj9f8Vwyu0ISfGSYYzrfUYkihWqzK3SS0m
         S/Cg==
X-Gm-Message-State: AOJu0Yz4oGSjzzcz4gGNDZ/e6vS5RWtS2Slsg0On1VxwIWsEbMPeS3lM
	ruYJ9abnCrcgxCv8sAuZXtU2jwmz8NYlkuFttdeyWrF2LMzUreO0zYdZqhmZDuy99UFBnw==
X-Google-Smtp-Source: AGHT+IEpJosi85FQJ/nHfqkdlZQgieG1drSYGfXL59uYsmeFMxvQ6gG5cmC9kEPdRbsX4/WBIOplsZs2
X-Received: from wrbaz15.prod.google.com ([2002:adf:e18f:0:b0:39e:e563:b90a])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2506:b0:39c:1f19:f0c3
 with SMTP id ffacd0b85a97d-3a09fdbbb18mr2670134f8f.46.1746352384424; Sun, 04
 May 2025 02:53:04 -0700 (PDT)
Date: Sun,  4 May 2025 11:52:30 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=6293; i=ardb@kernel.org;
 h=from:subject; bh=/UH2pkR9KgWDh14J48RhsK2IpL+B5SgKPXbJ8BbF+g4=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPc4p7dae41MXuDd9pdu6fMUBTxzmde3j7JWx/WRL26+
 v7539+eHaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAiwgUMf8X/zC1hfTrbm/VG
 0Jk1LL5Oe9tnB3wWnfM5ePblPtNlrVcZGW7+/blBt5B3GveEIy15X11Un867t+GQ3tnKtM/WK8/ 1r+YHAA==
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250504095230.2932860-25-ardb+git@google.com>
Subject: [RFT PATCH v2 00/23] x86: strict separation of startup code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

This RFT series implements a strict separation between startup code and
ordinary code, where startup code is built in a way that tolerates being
invoked from the initial 1:1 mapping of memory.

The existsing approach of emitting this code into .head.text and
checking for absolute relocations in that section is not 100% safe, and
produces diagnostics that are sometimes difficult to interpret.

Instead, rely on symbol prefixes, similar to how this is implemented for
the EFI stub and for the startup code in the arm64 port. This ensures
that startup code can only call other startup code, unless a special
symbol alias is emitted that exposes a non-startup routine to the
startup code.

This is somewhat intrusive, as there are many data objects that are
referenced both by startup code and by ordinary code, and an alias needs
to be emitted for each of those. If startup code references anything
that has not been made available to it explicitly, a build time link
error will occur.

This ultimately allows the .head.text section to be dropped entirely, as
it no longer has a special significance. Instead, code that only
executes at boot is emitted into .init.text as it should.

Change since RFC/v1:
- Include a major disentanglement/refactor of the SEV-SNP startup code,
  so that only code that really needs to run from the 1:1 mapping is
  included in the startup/ code

- Incorporate some early notes from Ingo

Build tested defconfig and allmodconfig

!!! Boot tested on non-SEV guest ONLY !!!!

Again, I will need to lean on Tom to determine whether this breaks
SEV-SNP guest boot. As I mentioned before, I am still waiting for
SEV-SNP capable hardware to be delivered.

Cc: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: Kevin Loughlin <kevinloughlin@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>

Ard Biesheuvel (23):
  x86/boot: Move early_setup_gdt() back into head64.c
  x86/boot: Disregard __supported_pte_mask in __startup_64()
  x86/boot: Drop global variables keeping track of LA57 state
  x86/sev: Make sev_snp_enabled() a static function
  x86/sev: Move instruction decoder into separate source file
  x86/sev: Disentangle #VC handling code from startup code
  x86/sev: Separate MSR and GHCB based snp_cpuid() via a callback
  x86/sev: Fall back to early page state change code only during boot
  x86/sev: Move GHCB page based HV communication out of startup code
  x86/sev: Use boot SVSM CA for all startup and init code
  x86/boot: Drop redundant RMPADJUST in SEV SVSM presence check
  x86/sev: Unify SEV-SNP hypervisor feature check
  x86/linkage: Add SYM_PIC_ALIAS() macro helper to emit symbol aliases
  x86/boot: Add a bunch of PIC aliases
  x86/boot: Provide __pti_set_user_pgtbl() to startup code
  x86/sev: Provide PIC aliases for SEV related data objects
  x86/sev: Move __sev_[get|put]_ghcb() into separate noinstr object
  x86/sev: Export startup routines for ordinary use
  x86/boot: Created a confined code area for startup code
  x86/boot: Move startup code out of __head section
  x86/boot: Disallow absolute symbol references in startup code
  x86/boot: Revert "Reject absolute references in .head.text"
  x86/boot: Get rid of the .head.text section

 arch/x86/boot/compressed/Makefile              |    6 +-
 arch/x86/boot/compressed/misc.h                |   12 +-
 arch/x86/boot/compressed/pgtable_64.c          |   12 -
 arch/x86/boot/compressed/sev-handle-vc.c       |  134 +++
 arch/x86/boot/compressed/sev.c                 |  210 +---
 arch/x86/boot/compressed/sev.h                 |   21 +-
 arch/x86/boot/compressed/vmlinux.lds.S         |    1 +
 arch/x86/boot/startup/Makefile                 |   21 +
 arch/x86/boot/startup/exports.h                |   14 +
 arch/x86/boot/startup/gdt_idt.c                |   17 +-
 arch/x86/boot/startup/map_kernel.c             |   18 +-
 arch/x86/boot/startup/sev-shared.c             |  804 +-------------
 arch/x86/boot/startup/sev-startup.c            | 1169 +-------------------
 arch/x86/boot/startup/sme.c                    |   45 +-
 arch/x86/coco/core.c                           |    2 +
 arch/x86/coco/sev/Makefile                     |    6 +-
 arch/x86/coco/sev/core.c                       |  189 +++-
 arch/x86/coco/sev/{sev-nmi.c => sev-noinstr.c} |   74 ++
 arch/x86/coco/sev/vc-handle.c                  | 1060 ++++++++++++++++++
 arch/x86/coco/sev/vc-shared.c                  |  614 ++++++++++
 arch/x86/include/asm/init.h                    |    6 -
 arch/x86/include/asm/linkage.h                 |   10 +
 arch/x86/include/asm/pgtable_64_types.h        |   43 +-
 arch/x86/include/asm/setup.h                   |    2 +
 arch/x86/include/asm/sev-internal.h            |   30 +-
 arch/x86/include/asm/sev.h                     |   78 ++
 arch/x86/kernel/cpu/common.c                   |    3 +-
 arch/x86/kernel/head64.c                       |   27 +-
 arch/x86/kernel/head_32.S                      |    2 +-
 arch/x86/kernel/head_64.S                      |   18 +-
 arch/x86/kernel/setup.c                        |    1 +
 arch/x86/kernel/vmlinux.lds.S                  |   11 +-
 arch/x86/lib/memcpy_64.S                       |    1 +
 arch/x86/lib/memset_64.S                       |    1 +
 arch/x86/lib/retpoline.S                       |    2 +
 arch/x86/mm/kasan_init_64.c                    |    3 -
 arch/x86/mm/mem_encrypt_amd.c                  |    2 +
 arch/x86/mm/mem_encrypt_boot.S                 |    6 +-
 arch/x86/mm/pgtable.c                          |    1 +
 arch/x86/platform/pvh/head.S                   |    2 +-
 arch/x86/tools/relocs.c                        |    8 +-
 tools/objtool/arch/x86/decode.c                |    6 +-
 42 files changed, 2367 insertions(+), 2325 deletions(-)
 create mode 100644 arch/x86/boot/compressed/sev-handle-vc.c
 create mode 100644 arch/x86/boot/startup/exports.h
 rename arch/x86/coco/sev/{sev-nmi.c => sev-noinstr.c} (61%)
 create mode 100644 arch/x86/coco/sev/vc-handle.c
 create mode 100644 arch/x86/coco/sev/vc-shared.c


base-commit: 18ea89eae404d119ced26d80ac3e62255ce15409
-- 
2.49.0.906.g1f30a19c02-goog


