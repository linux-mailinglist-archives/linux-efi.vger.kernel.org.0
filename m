Return-Path: <linux-efi+bounces-4626-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E789B3998F
	for <lists+linux-efi@lfdr.de>; Thu, 28 Aug 2025 12:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 561F17BA3F8
	for <lists+linux-efi@lfdr.de>; Thu, 28 Aug 2025 10:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903BC30BB80;
	Thu, 28 Aug 2025 10:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gbi5VxGH"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9128330AD05
	for <linux-efi@vger.kernel.org>; Thu, 28 Aug 2025 10:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376559; cv=none; b=ljnsL+6q/xS/KFLUlEFS7ASQu4n8ywiy/Qaaspyssw1ovPgWrbB4XiNvnkS0JoUXZBLzlx+nUp62k4NGN3pGKMsaSG4VDTglFR/hlhQcRqVrslVD8Fy7OXNKMsPL45B31TcNCduAVtAAJFstbO0xQZEmNjYQKuw9wfW4IpS6JQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376559; c=relaxed/simple;
	bh=GXtJm8Sqq8CakQQvfcS8jAZmx42AgbMq8RzCkNfALNc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kidrBg6e+y6m66tTFsxEOcvHmnNC7U+smbq09lnp5dW0SgDgtnljN+56kWUQAsszD7YuzTiQuxHiUKSsmiKky7fUsnyi8EN+WufJloKe0touHnA7z0hdx/rb/ccmW5yI1qaN5hLFbmgQfCY0HjXj1IDgJVtKzTH0wLtkTZqNChY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gbi5VxGH; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45a1b0b14daso4604415e9.2
        for <linux-efi@vger.kernel.org>; Thu, 28 Aug 2025 03:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756376555; x=1756981355; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U8yCAI700QoeD0KjAlm516eTIXfj/D0G5f0Bt5v0978=;
        b=gbi5VxGHPhBed6EaYFqRWYJrs4OBSvPOxIi7Geu7qsHt6FWRDzTVS+p+Y4B/QP1+wt
         NAq9bcuLjYV5x6i4X3fzNCRPRTj8YCsAsJFrwzG+HD5YzCIubqbMKJuBTVLQXj5vlIoG
         5XRApqUYGDczg0EdElKzo/NA7isg0X+TsPwuxvN+Oq3ycDsRIx49hC+BFpSMExMsQQTi
         IyNU81z33Y8vgLHIv5c+28aCux2x4SLZzm0MbQrCFA34CS788HY9QvKBhRNWajXZ7sc8
         MOD9zTtMVNQGIhp7Kk9EPdVa+67uIz2whTc8jLk9hqHZK7ZkTleZt7bfU7Vq+q8wq1Fo
         8V8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376555; x=1756981355;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U8yCAI700QoeD0KjAlm516eTIXfj/D0G5f0Bt5v0978=;
        b=NiJ7C/fFLuW3wSLyDQ9JFTplE52pZ0+ba4OnwH2FbLPl1Ba0bgK0lFnXv4GYPxvfyA
         A6e1iff4SfQGAEqVvB5AJwD1KVKwVd49kR35moyeVTv+Vcm610fk8YKxKNC3uegbT14G
         jywCKsKaTMHX60DOcNglwbMvXTTyffIatxcDgbBR/k55nszCG1fUqdf0iR4s0edxX0aX
         kNpbEbyY3GHVB2hxDV1OnzQUigl3aJCHt145dXDTyLqtGNxMi7dU05JDgpteW+YTiVbx
         zjLeM07fCGpaRsXa8pdz0+D6PMWnLclpfKT+rrzspD3+rviRTJF5w+a8InBZF7uGGgEX
         B7RA==
X-Gm-Message-State: AOJu0YzERJvZ7W9H3vy5VdN4pI/56FJpnUUZfVQmv6D37HOWoWkMXBgs
	C57LrbqDIxCyy55rEqjGBM9AAEru30uIYrI3tgposY42aHE0yzXj8o3/CqJ2HERhIwKnaHLBMQ=
	=
X-Google-Smtp-Source: AGHT+IGeZ8WHDz26AwgYy2WzgMv+UkYbW3RhB9TUZyp4YSODwPSMXcZk6HwbNe3vsD95GO3ECZsBPDgC
X-Received: from wmbet13.prod.google.com ([2002:a05:600c:818d:b0:459:e027:2d9b])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1c82:b0:45b:5efc:e97b
 with SMTP id 5b1f17b1804b1-45b5f4e343cmr135704025e9.12.1756376554871; Thu, 28
 Aug 2025 03:22:34 -0700 (PDT)
Date: Thu, 28 Aug 2025 12:22:03 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=8071; i=ardb@kernel.org;
 h=from:subject; bh=51Omh/TQfJiq6f6ShqQ+zr/qzf6aJSUGv5CIRvBWdDo=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIWOD7un+ls1zOnzjvU75bC+5bqvlUTlDqH+T3Pbpb5POr
 1f/4fu/o5SFQYyLQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzk5U9GhnnzJmT4vple8TNL
 92J9eual1K+H9i61yCxPa76tdkeDZTUjw51JUu+/HXqzhsPvaVrXnh/Hd4a6B3Rnbj/u/efNwR2 CE3gB
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828102202.1849035-24-ardb+git@google.com>
Subject: [PATCH v7 00/22] x86: strict separation of startup code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

This series implements a strict separation between startup code and
ordinary code, where startup code is built in a way that tolerates being
invoked from the initial 1:1 mapping of memory.

The existing approach of emitting this code into .head.text and checking
for absolute relocations in that section is not 100% safe, and produces
diagnostics that are sometimes difficult to interpret. [0]

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

The majority of changes is around early SEV code. The main issue is that
its use of GHCB pages and SVSM calling areas in code that may run from
both the 1:1 mapping and the kernel virtual mapping is problematic as it
relies on __pa() to perform VA to PA translations, which are ambiguous
in this context. Also, __pa() pulls in non-trivial instrumented code
when CONFIG_DEBUG_VIRTUAL=y and so it is better to avoid VA to PA
translations altogether in the startup code.

Changes since v6:
- Rebase onto latest tip/master which incorporates v6.17-rc1
- Use a descriptor struct instead of two additional function arguments
  in patch #8
- Clarify in commit log why the latent entropy GCC plugin needs to be
  disabled for startup code
- Apply Tom's Rb to patch #3

Changes since v5:
- Some cosmetic touchups to patch #1
- Fix error spotted by Tom in patch #2
- Rejig objtool 'noabs' feature using an arch hook to check for
  relocations that should be considered absolute, which includes all of
  R_X86_64_32, R_X86_64_32S and R_X86_64_64 on x86_64

Changes since v4:
- Incorporate feedback from Tom, and add a couple of RBs
- Drop patch that moved the MSR save/restore out of the early page state
  change helper - this is less efficient but likely negligible in
  practice
- Drop patch that unified the SEV-SNP hypervisor feature check, which
  was identified by Nikunj as the one breaking SEV-SNP boot.

Changes since RFT/v3:
- Rebase onto tip/master
- Incorporate Borislav's feedback on v3
- Switch to objtool to check for absolute references in startup code
- Remap inittext R-X when running on EFI implementations that require
  strict R-X/RW- separation
- Include a kbuild fix to incorporate arch/x86/boot/startup/ in the
  right manner
- For now, omit the LA57 changes that remove the problematic early
  5-level paging checks. We can revisit this once there is agreement on
  the approach. 

Changes since RFT/v2:
- Rebase onto tip/x86/boot and drop the patches from the previous
  revision that have been applied in the meantime.
- Omit the pgtable_l5_enabled() changes for now, and just expose PIC
  aliases for the variables in question - this can be sorted later.
- Don't use the boot SVSM calling area in snp_kexec_finish(), but pass
  down the correct per-CPU one to the early page state API.
- Rename arch/x86/coco/sev/sev-noinstr.o to arch/x86/coco/sev/noinstr.o
- Further reduce the amount of SEV code that needs to be constructed in
  a special way.

Change since RFC/v1:
- Include a major disentanglement/refactor of the SEV-SNP startup code,
  so that only code that really needs to run from the 1:1 mapping is
  included in the startup/ code

- Incorporate some early notes from Ingo

Cc: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Kevin Loughlin <kevinloughlin@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Nikunj A Dadhania <nikunj@amd.com>

[0] https://lore.kernel.org/all/CAHk-=wj7k9nvJn6cpa3-5Ciwn2RGyE605BMkjWE4MqnvC9E92A@mail.gmail.com/


Ard Biesheuvel (22):
  x86/sev: Separate MSR and GHCB based snp_cpuid() via a callback
  x86/sev: Use MSR protocol for remapping SVSM calling area
  x86/sev: Use MSR protocol only for early SVSM PVALIDATE call
  x86/sev: Run RMPADJUST on SVSM calling area page to test VMPL
  x86/sev: Move GHCB page based HV communication out of startup code
  x86/sev: Avoid global variable to store virtual address of SVSM area
  x86/sev: Share implementation of MSR-based page state change
  x86/sev: Pass SVSM calling area down to early page state change API
  x86/sev: Use boot SVSM CA for all startup and init code
  x86/boot: Drop redundant RMPADJUST in SEV SVSM presence check
  x86/boot: Provide PIC aliases for 5-level paging related constants
  x86/sev: Provide PIC aliases for SEV related data objects
  x86/sev: Move __sev_[get|put]_ghcb() into separate noinstr object
  x86/sev: Export startup routines for later use
  objtool: Add action to check for absence of absolute relocations
  x86/boot: Check startup code for absence of absolute relocations
  x86/boot: Revert "Reject absolute references in .head.text"
  x86/kbuild: Incorporate boot/startup/ via Kbuild makefile
  x86/boot: Create a confined code area for startup code
  efistub/x86: Remap inittext read-execute when needed
  x86/boot: Move startup code out of __head section
  x86/boot: Get rid of the .head.text section

 arch/x86/Kbuild                            |   2 +
 arch/x86/Makefile                          |   1 -
 arch/x86/boot/compressed/Makefile          |   2 +-
 arch/x86/boot/compressed/misc.c            |   2 +
 arch/x86/boot/compressed/sev-handle-vc.c   |   3 +
 arch/x86/boot/compressed/sev.c             | 120 ++------
 arch/x86/boot/startup/Makefile             |  22 ++
 arch/x86/boot/startup/exports.h            |  14 +
 arch/x86/boot/startup/gdt_idt.c            |   4 +-
 arch/x86/boot/startup/map_kernel.c         |   4 +-
 arch/x86/boot/startup/sev-shared.c         | 314 ++++++--------------
 arch/x86/boot/startup/sev-startup.c        | 205 ++-----------
 arch/x86/boot/startup/sme.c                |  27 +-
 arch/x86/coco/sev/Makefile                 |   8 +-
 arch/x86/coco/sev/core.c                   | 173 ++++++++---
 arch/x86/coco/sev/{sev-nmi.c => noinstr.c} |  74 +++++
 arch/x86/coco/sev/vc-handle.c              |   2 +
 arch/x86/coco/sev/vc-shared.c              | 143 ++++++++-
 arch/x86/include/asm/boot.h                |   2 +
 arch/x86/include/asm/init.h                |   6 -
 arch/x86/include/asm/setup.h               |   1 +
 arch/x86/include/asm/sev-internal.h        |  26 +-
 arch/x86/include/asm/sev.h                 |  23 +-
 arch/x86/kernel/head64.c                   |   5 +-
 arch/x86/kernel/head_32.S                  |   2 +-
 arch/x86/kernel/head_64.S                  |  10 +-
 arch/x86/kernel/vmlinux.lds.S              |   9 +-
 arch/x86/mm/mem_encrypt_amd.c              |   6 -
 arch/x86/mm/mem_encrypt_boot.S             |   6 +-
 arch/x86/platform/pvh/head.S               |   2 +-
 arch/x86/tools/relocs.c                    |   8 +-
 drivers/firmware/efi/libstub/x86-stub.c    |   4 +-
 tools/objtool/arch/x86/decode.c            |  12 +
 tools/objtool/builtin-check.c              |   2 +
 tools/objtool/check.c                      |  47 ++-
 tools/objtool/include/objtool/arch.h       |   1 +
 tools/objtool/include/objtool/builtin.h    |   1 +
 37 files changed, 671 insertions(+), 622 deletions(-)
 create mode 100644 arch/x86/boot/startup/exports.h
 rename arch/x86/coco/sev/{sev-nmi.c => noinstr.c} (61%)


base-commit: cab48e960d35f35ff799f7aafce7a7bf7c56d8e3
-- 
2.51.0.268.g9569e192d0-goog


