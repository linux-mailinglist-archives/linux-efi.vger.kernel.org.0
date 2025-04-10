Return-Path: <linux-efi+bounces-3260-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E62CA84532
	for <lists+linux-efi@lfdr.de>; Thu, 10 Apr 2025 15:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 370784A08F6
	for <lists+linux-efi@lfdr.de>; Thu, 10 Apr 2025 13:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4F11F930;
	Thu, 10 Apr 2025 13:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QHGCg7hN"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20466156677
	for <linux-efi@vger.kernel.org>; Thu, 10 Apr 2025 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744292503; cv=none; b=HKJkADRuMaBdSzNPv045HPgrsSsvyZaVESVznYPeQtp1URo+cuR732PS26VxjebRwIYM/5vjQWGbH0nsOjVVNZIVQx2/pTiY6Z4HbRe8lMSBWBk+QnkfMi6S/vIZpcolksQc8FhAHm5m846BHaSzb+GamTbwK8kiW0d6fBE01pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744292503; c=relaxed/simple;
	bh=wiuhW5evU/Rc29bp6zkAQCWkITejo77ob/z9Dk+FeN0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KhNgTaTvMrk+xjCSHmzNSuYk0XNBNgueyqP7oiHvUW4ebPpmENlrfIvxhvxLu+DbC9gSZmpoWviuQVI2TMl+h7CWUcuLh8qs1utmd9X73Plcf2o6EFHMDih5/7m8HIqoiA9QcPLr1yXOBonlJPacgIJExqaPHNEyJDcvArhxGWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QHGCg7hN; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43d0830c3f7so7026225e9.2
        for <linux-efi@vger.kernel.org>; Thu, 10 Apr 2025 06:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744292500; x=1744897300; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F5BBjKPIekYrEeVKo50JLFBsOnCg/0jyb52yewb+mRo=;
        b=QHGCg7hNsq2glfe1EvHXCKVz0re+rJ65OeMZ1hvKzOcGvqkwndoQHh1FYWZM2tQ3Vz
         1eFebQ9MNdHgGFdToREpKtsCFG8X9EQdNHdBBuv4xBQGX9dISp6h/5IE9SW9bRvkGGi3
         5HYOQ5DfhaKuhxY5sAa4gB2dPvDTdE75ZH5F+DcjcWYNajI1b2qBDNX2Ei7OM9OBjtiJ
         LqqV8dKomKoijz8AfeEzADaUqxeDpTJB3W1oS60CPUKxe7DsQ9Cn90L1OEMSgXe6lA8z
         ks8tN6hf5mBc2SrfFntrT83mVSDFwJVKsVY/BR5IRBiTF2qqLS5DWIrSxdvuBilI/liS
         hG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744292500; x=1744897300;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F5BBjKPIekYrEeVKo50JLFBsOnCg/0jyb52yewb+mRo=;
        b=kAcaD4GudM45FMV06jLqtLmFZgpjbhsHKVNyY7MzQFai2jblRGtdozWwBMtJLRBp6L
         PIxNRDZKqNQvxNstmFL/ROtCWZoUg0trdlA04MkeleK+VHp78OWp3O8ztKcOqX4Qnfw2
         Mssngyr8xsqAKV2MQAMcaY8vMNa3MeULZUKi+qK5/HU/lzUEkrYlAQKNfd+egN+xjqXj
         WCf2XKOmB5xiNYYfWi2Yr5Sf1LRZ3+O89sB1/CxhSPMEgnPNx7RD7jQ85Pr79NlQUaxG
         J9xfeIhsWHlF/sstAbAnI5s/4W9YJyQ2t9JKyGBRwX4N2GQX0vHyxptfWqgEchkAZzVX
         AYgQ==
X-Gm-Message-State: AOJu0YwIaLznbveUFT4jsNI1/q6hJSBr2kOK8fsYljy1bkjLApAfglaM
	ByadqQlVEM7wNdO57g9kFGfnz800JtT46NuXL1zfJcjRAToAtPoeau43nykezfve2xjbjhmuns5
	nARk6g9Y8jMsLwBjJhCeAn/iwD2kkHRryt+juF3o6XbtQsShtpJxf1doTT+lZAAvUT617ZAxGn9
	f/gWtg/rLY48Sj7ii+auk4IPzDcA==
X-Google-Smtp-Source: AGHT+IHd+8MEBe16pE0XLxqL66PgJ7fdjUFAB3h4S7JE13Ct2X++z/lHUScP89jUOURI0VwTBl7NaPAX
X-Received: from wmbay35.prod.google.com ([2002:a05:600c:1e23:b0:43d:412e:82ce])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1d27:b0:43c:ec97:75db
 with SMTP id 5b1f17b1804b1-43f2fee0322mr17874155e9.11.1744292500447; Thu, 10
 Apr 2025 06:41:40 -0700 (PDT)
Date: Thu, 10 Apr 2025 15:41:18 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3415; i=ardb@kernel.org;
 h=from:subject; bh=0sC8JgPvEW8/YSxATGrJydJbVmEf1dh2DbwZblMNlDI=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf37qbrnNXUVT/gmbLN6qpyQ7xX/tOH5AyUboycVVc+85
 XZJfNHpKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABPpS2X4X5Kk/81XWmJafqNZ
 p1Gzc5f7wxWXBB6wh7eUMZb869eLZGSY6ZJzbMmE2+Is+zt6H0u0FX+UvKOYuZFp/pPExdOYjnn yAAA=
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250410134117.3713574-13-ardb+git@google.com>
Subject: [PATCH v4 00/11] x86: Refactor and consolidate startup code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: x86@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

!! NOTE: patches #7 - #10 depend on [0] !!

Reorganize C code that is used during early boot, either in the
decompressor/EFI stub or the kernel proper, but before the kernel
virtual mapping is up.

v4:
- drop patches that were queued up
- fix address space error in patch #1
- add patches for SEV-SNP boot code - these cannot be applied yet, but
  are included for completeness

v3:
- keep rip_rel_ptr() around in PIC code - sadly, it is still needed in
  some cases
- remove RIP_REL_REF() uses in separate patches
- keep __head annotations for now, they will all be removed later
- disable objtool validation for library objects (i.e., pieces that are
  not linked into vmlinux)

I will follow up with a series that gets rid of .head.text altogether,
as it will no longer be needed at all once the startup code is checked
for absolute relocations.

Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: Kevin Loughlin <kevinloughlin@google.com>

[0] https://lore.kernel.org/all/20250410132850.3708703-2-ardb+git@google.com/T/#u

Ard Biesheuvel (11):
  x86/asm: Make rip_rel_ptr() usable from fPIC code
  x86/boot: Move the early GDT/IDT setup code into startup/
  x86/boot: Move early kernel mapping code into startup/
  x86/boot: Drop RIP_REL_REF() uses from early mapping code
  x86/boot: Move early SME init code into startup/
  x86/boot: Drop RIP_REL_REF() uses from SME startup code
  x86/sev: Prepare for splitting off early SEV code
  x86/sev: Split off startup code from core code
  x86/boot: Move SEV startup code into startup/
  x86/boot: Drop RIP_REL_REF() uses from early SEV code
  x86/asm: Retire RIP_REL_REF()

 arch/x86/boot/compressed/Makefile                          |    2 +-
 arch/x86/boot/compressed/sev.c                             |   17 +-
 arch/x86/boot/startup/Makefile                             |   16 +
 arch/x86/boot/startup/gdt_idt.c                            |   84 +
 arch/x86/boot/startup/map_kernel.c                         |  225 +++
 arch/x86/{coco/sev/shared.c => boot/startup/sev-shared.c}  |  375 +----
 arch/x86/boot/startup/sev-startup.c                        | 1395 ++++++++++++++++
 arch/x86/{mm/mem_encrypt_identity.c => boot/startup/sme.c} |   19 +-
 arch/x86/coco/sev/Makefile                                 |   19 -
 arch/x86/coco/sev/core.c                                   | 1726 ++++----------------
 arch/x86/include/asm/asm.h                                 |    5 -
 arch/x86/include/asm/coco.h                                |    2 +-
 arch/x86/include/asm/mem_encrypt.h                         |    2 +-
 arch/x86/include/asm/sev-internal.h                        |  112 ++
 arch/x86/include/asm/sev.h                                 |   37 +
 arch/x86/kernel/head64.c                                   |  285 +---
 arch/x86/mm/Makefile                                       |    6 -
 17 files changed, 2208 insertions(+), 2119 deletions(-)
 create mode 100644 arch/x86/boot/startup/gdt_idt.c
 create mode 100644 arch/x86/boot/startup/map_kernel.c
 rename arch/x86/{coco/sev/shared.c => boot/startup/sev-shared.c} (78%)
 create mode 100644 arch/x86/boot/startup/sev-startup.c
 rename arch/x86/{mm/mem_encrypt_identity.c => boot/startup/sme.c} (97%)
 create mode 100644 arch/x86/include/asm/sev-internal.h

-- 
2.49.0.504.g3bcea36a83-goog


