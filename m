Return-Path: <linux-efi+bounces-4436-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22470B0D31C
	for <lists+linux-efi@lfdr.de>; Tue, 22 Jul 2025 09:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D05C3BB8CB
	for <lists+linux-efi@lfdr.de>; Tue, 22 Jul 2025 07:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5368C2C08DD;
	Tue, 22 Jul 2025 07:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ur3jzcBt"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4098F23FC52
	for <linux-efi@vger.kernel.org>; Tue, 22 Jul 2025 07:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169393; cv=none; b=sF4O82h/7fGgczFpSmnpAZ+WgbjoVo+3STRY0/LPlTvIosTNquXjTmXHHsaGM/1bmhl21JCCMO3xoyTc3hAlz+7/sUeEnlHFs5wHDDBVqfHa/slrDzLpcU2cqFTaPxopqHTqvawmEaHe962TtPL4jfW8Hn7cFEgpx4IM5ol/f5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169393; c=relaxed/simple;
	bh=FINodexBHvkZshOtpnTt8GEZrxrxOo9Yvv+EhIE+/gM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=i3hceveew/BImZ+phRgEy+OGqNnnwApBauvyFLyFRmMgLTJ+jTplh8JopMCW5YInAHUjlWVoPuEhuxv2fQetGsytKodjXxJ16TIAuqQHzNeJTn8IVZjiKFRDFveunD05p8vm28fYGgkcu7g4AjyyJoWtqBX3xu1uMFa3LtmM0V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ur3jzcBt; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3af3c860ed7so2033933f8f.1
        for <linux-efi@vger.kernel.org>; Tue, 22 Jul 2025 00:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753169389; x=1753774189; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vr/hEWsfOUPI5y3DFpYj5AsIj2tX7sGdT9gfjozAGQ4=;
        b=ur3jzcBtJZ+dPnSoxEBKh/FaVNStBDlwO9uC/D5wR5irhnqTaVKjkBlvmJ/TsMB/kl
         wPJmu1zTGLtjH7Itrp37Xra+Cpmh8cR8bfDJBIfIR3NOGcJ/mrbShU/Ng4gaigkjiWnI
         PQCm2PAoq35pZqnRDCy2wqRlEpJjw/1Gn1svsHInNz5kaBiliV5pBLImGrk1tDZUUlGJ
         s/RfSEsc7McJM72v6WV5MO+nZPqQ3H+Iln7kZ5nt4BfvpF7mipB4rG1DQdgImqGxWXqe
         mdZxOkA/lngzNerr3lpZpG3PYpCvV5TiHWTNVHVwxrqwQD7xReCFq8Cvn+7JBz3ZNTS3
         xJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753169389; x=1753774189;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vr/hEWsfOUPI5y3DFpYj5AsIj2tX7sGdT9gfjozAGQ4=;
        b=imeuq5Wemauq2J3UN24lhzry10h+BFtphtylV6L1OoEZhuRtUW2x/bTBQP2zXw1I5j
         oRteugjKVzOrAyvcm4U012wR0QxF3kYVwf4UTxmgFqTn8ERB5nhaLzMhNJr7Hhpdy6D4
         lNgjZrvsZqWPEnhR7bqApDvXekpyiji0ghx0z/j13lK0BGj+jRAb70rduDWtMFJnQbHl
         yEeCmCAw9j3TWRcNXmBCNbEVurosoofX7XvRwD9GmxfiTkX5xMN6s4xzKWuBWiuAcU7+
         MBwX5F4ljszqjI8XrCVvj9XC6Wn1euFlFnTHzaxmVk31hRHctKvGiyOxa4VwDLdS589q
         7zNQ==
X-Gm-Message-State: AOJu0YyYKYthSBqFJ98Kqw4+anEMGdvMJm7Pra3R5kR7ywAvnz3R8Mwg
	4pNw1PfpDeHpwFpKdPA+vkgmGMm1+PFpmvMz8YCR+yC5Mbc5J+VFeJRFmR5eNWrzI+eo8o0WKw=
	=
X-Google-Smtp-Source: AGHT+IE08ZdjgH4qRY0l4Uu3uK4AGfCUGUW8H8qAa/OECpkb0GBtWMBzn3l8Tqpzvk9k++FLlr5Kq/D9
X-Received: from wmbdr7.prod.google.com ([2002:a05:600c:6087:b0:455:fdc1:e6])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2dc1:b0:3a4:f786:4fa1
 with SMTP id ffacd0b85a97d-3b60e4d1e7fmr18292447f8f.2.1753169389698; Tue, 22
 Jul 2025 00:29:49 -0700 (PDT)
Date: Tue, 22 Jul 2025 09:27:09 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=7767; i=ardb@kernel.org;
 h=from:subject; bh=w7ifELRFeTN+34kNkATi8E5SmMjq3w2AYau/T1UaPQY=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaPe1p9L+9e2RdZLWM5ZlM0+2/prZaJrCQ/LxJqbM+WDO
 BwSP+/oKGVhEONikBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABNpecLwz2xb6V/+6ovnWUXv
 npzFL+fOonBqY2pQ466tTL9LpxlLVzAytBoavClymbu4/F6uZqLG1NceN7vjhDYftGCo6mYribJ nBgA=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722072708.2079165-24-ardb+git@google.com>
Subject: [PATCH v6 00/22] x86: strict separation of startup code
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
 arch/x86/boot/compressed/sev.c             | 108 +------
 arch/x86/boot/startup/Makefile             |  22 ++
 arch/x86/boot/startup/exports.h            |  14 +
 arch/x86/boot/startup/gdt_idt.c            |   4 +-
 arch/x86/boot/startup/map_kernel.c         |   4 +-
 arch/x86/boot/startup/sev-shared.c         | 318 ++++++--------------
 arch/x86/boot/startup/sev-startup.c        | 196 ++----------
 arch/x86/boot/startup/sme.c                |  27 +-
 arch/x86/coco/sev/Makefile                 |   8 +-
 arch/x86/coco/sev/core.c                   | 169 ++++++++---
 arch/x86/coco/sev/{sev-nmi.c => noinstr.c} |  74 +++++
 arch/x86/coco/sev/vc-handle.c              |   2 +
 arch/x86/coco/sev/vc-shared.c              | 143 ++++++++-
 arch/x86/include/asm/boot.h                |   2 +
 arch/x86/include/asm/init.h                |   6 -
 arch/x86/include/asm/setup.h               |   1 +
 arch/x86/include/asm/sev-internal.h        |  27 +-
 arch/x86/include/asm/sev.h                 |  17 +-
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
 37 files changed, 643 insertions(+), 624 deletions(-)
 create mode 100644 arch/x86/boot/startup/exports.h
 rename arch/x86/coco/sev/{sev-nmi.c => noinstr.c} (61%)


base-commit: 34481698fd9c3c21425ab744e9e15dc2ce3b1b85
-- 
2.50.0.727.gbf7dc18ff4-goog


