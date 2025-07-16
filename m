Return-Path: <linux-efi+bounces-4354-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D08AB06C17
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 05:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D960B1AA0F2A
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 03:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5180B26D4C1;
	Wed, 16 Jul 2025 03:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="waC8oFqE"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584B84EB38
	for <linux-efi@vger.kernel.org>; Wed, 16 Jul 2025 03:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752636150; cv=none; b=prf1tr7SuY+rGC6wn/AayUjozD4cisiUvMXG9s/dKN4bopcxXpBeM6gHHW7qJlLPdZPapwJU8ehH0PuPy+wB/kSn9ywqnMtaN66tdnGiy6ejRxa4HW44tc6tk7s13MuA+SyGf6caee1bOKU3Qc0RWljMD9OlcsdN/f5YyPUbYqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752636150; c=relaxed/simple;
	bh=WaXmMOQSsbZRZAWN31j1OD1nimIk2guclhmdBCUDz30=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=plc4zhbjZByMVCvdfeuCirgwAb43NpPf+cxESvkX6qkb+mcJYkuUd0rzA4gV20LxsK1KDRV9nHXZYpxhzBWJPXhjupWRCX3IQQptbcfZdZjMxf3v2jHvIEGpfPWnk9h5+kBqTZ9wJ+wnecNtC63ODKaiukLAD8yHESzHSXW7ZeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=waC8oFqE; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-453817323afso37534085e9.1
        for <linux-efi@vger.kernel.org>; Tue, 15 Jul 2025 20:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752636147; x=1753240947; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V8G98tP8Qdm2AVns+QQD1ks1tvLcoBsClrNcQbcD9fg=;
        b=waC8oFqEGLb5OpjEY5XyQVRp4V1opi8uny4wX2HWBOgZCDmCIU1DFIv6RftBL3WR5U
         a78qC17G2IrVE9EdIRTiU0BOtOpsXKqFeaLmvZ7HtIfM6TzIrieWC0qkIuwoQ1o1uM96
         8uuJs2p6I6h73K7ZFghwl7wm9Gsv1rp8OqeSSJRzje0l990yAP3ADxs+aNoVFqWmxV56
         zh1BaYz7uFaalLwAXkgRxEhuS2/LpISVUJPT8Y3LzqdAuD7h71UjVTR/rAsKd9q3aXU0
         cPiTJdUijC3fQkBNAKFR5Bvd8MywKyRrM87LADV/xtYCaIPfyweNpana7REJkxvjuZBs
         syuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752636147; x=1753240947;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V8G98tP8Qdm2AVns+QQD1ks1tvLcoBsClrNcQbcD9fg=;
        b=tM3cEvYAzxX7gc08jogvdtxnNvCE2DLW/77gcGHnRSvSy7IKO/Bl4QZbdfgpkErl+3
         gAd/eBkXOWWYT17saaMwFHdX8nxgXr7QOw4MhyLXtnmQAvTt2+m/ixwygdU1qh6Ri70C
         jeoKM6yY0YWzr632U8lB1/+6KMezCKkB5eLNKbgtsvSXIFEA1a8/WvSaAqPWDBYinkJY
         ClhyGZ7bbGMR/jRuTl/2mlXDdIhzSw3boyNaG0AlwG/jgKStUdE0T1z0Inoj9B1M3PZn
         FjmI7ZKxs3Lr02pcgsDGay6fiRh19+/hQlHVwxAxUEaD1UwfhXYVAocPUKC7JKyWH8GG
         Nm2Q==
X-Gm-Message-State: AOJu0YwslKGhtLEliVk0J1kQMN9mrCN9jqyNgEqC7NY2RRV1xuziSARF
	x5zq++bqdkwRwZXNmqcW4QahwZD3R2B/kMHyHzhasGmyhLeWNDgwRE6oNyFGRtxT3FxWHAZJeg=
	=
X-Google-Smtp-Source: AGHT+IGCtSvIz3fSrD3sAAby/yyCtnEEIWWHXfPcnFJjOsoY/UKIVsH+hyilTss9prIPk1MttSc8GfFb
X-Received: from wmoo26.prod.google.com ([2002:a05:600d:11a:b0:456:43c:dcc3])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:8216:b0:456:1d4e:c14f
 with SMTP id 5b1f17b1804b1-4562f1ecc51mr2987335e9.28.1752636146757; Tue, 15
 Jul 2025 20:22:26 -0700 (PDT)
Date: Wed, 16 Jul 2025 05:18:15 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=7312; i=ardb@kernel.org;
 h=from:subject; bh=88bKY3KhyZSyupM/hkxbatCn3w59RCv83690J9lgDko=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaNc8pfyjrZMDrvzt/64Jnm8efxsg9TCqbbVVzhWdkQ3a
 M2q/bmro5SFQYyLQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzkhhcjw4UnrAYps+52rY40
 fbT6ZaHfHBE1iTf9OeEbGmc8WtWw9zbDH/57C88f0P31lYv/UpBHgERFq4S7vNbHn9tuH724ca/ 6I3YA
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716031814.2096113-24-ardb+git@google.com>
Subject: [PATCH v5 00/22] x86: strict separation of startup code
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
 arch/x86/boot/startup/sev-shared.c         | 317 ++++++--------------
 arch/x86/boot/startup/sev-startup.c        | 196 ++----------
 arch/x86/boot/startup/sme.c                |  27 +-
 arch/x86/coco/sev/Makefile                 |   6 +-
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
 tools/objtool/builtin-check.c              |   2 +
 tools/objtool/check.c                      |  39 ++-
 tools/objtool/include/objtool/builtin.h    |   1 +
 35 files changed, 620 insertions(+), 623 deletions(-)
 create mode 100644 arch/x86/boot/startup/exports.h
 rename arch/x86/coco/sev/{sev-nmi.c => noinstr.c} (61%)

-- 
2.50.0.727.gbf7dc18ff4-goog


