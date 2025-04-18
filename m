Return-Path: <linux-efi+bounces-3366-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A66CCA9386C
	for <lists+linux-efi@lfdr.de>; Fri, 18 Apr 2025 16:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC5E79200AA
	for <lists+linux-efi@lfdr.de>; Fri, 18 Apr 2025 14:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A66A15746F;
	Fri, 18 Apr 2025 14:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bk1M2hfI"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B2E15442A
	for <linux-efi@vger.kernel.org>; Fri, 18 Apr 2025 14:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744985648; cv=none; b=OaJJChQwyeo1/jXcw0leKbsvKaG/Nc1k9GNFoGatPyOmKI7GKU/QRRLq2VYrfB/bIBX6DlfcR8mzuAL93dYtRCeY3Bq+8M9UiUs9J55b+6Bkm/HIBWrCeX66kMjTFAtBD5rMnHVAheZUnVuDJHcOoQcF8pzE8cr6tEyirN7cq+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744985648; c=relaxed/simple;
	bh=eoypHYFJbnhI3cM5jTMzcCb5/LQ1yyBLt8XZW3eJwoo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IjXj1FK2bjbxCqklOOkCHsQvCWgF/r4x+/cXQHcQpJWCk2izSJgRZ6UuoNla9OBnUkP1a+YGSE2ypO9W/+zjOVUvAD/fSJk/8Yfk6nm1QvN5DiN2zaAlc8pPSf9lGLY2ckj55cfcxv7/gX8cOSfZ0RP6+goVAm4RZFn6KLgRWCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bk1M2hfI; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43cf327e9a2so13917755e9.3
        for <linux-efi@vger.kernel.org>; Fri, 18 Apr 2025 07:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744985645; x=1745590445; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a9IGVezPOkilLrKq9jah2asU3Ea63Qs7zBKDQ1lB5AA=;
        b=Bk1M2hfIHPB5qLNqwAb7CBC/7c2JQKjK4kx2eFGK+udquEvW6yJegul/nC6N0170xA
         XXsUidPCvGHUNF4gp7hHl/Q8gcWGHgwoEKTZAfoigsDiieT9O+aB3g0tj4eyptynuwah
         j5EicEMzPLWnAr5Encj72aY821vBzrPviMf0YBFVDwUslyPFs9DOeYMBkKh5LI66VWV8
         gyp+7Fp7O4ihuQCGInkGzzci/PLfB6Z9gTpZfDKVJjjQA0rRQHeUyrIke7kWfdG3h5fB
         UXp+p1GRmmEwDYJVWt/zK5AQm7oAwWDTgRbDHcf+CVyNtVSvlfxnVphHtP5Csz7se7XY
         wofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744985645; x=1745590445;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a9IGVezPOkilLrKq9jah2asU3Ea63Qs7zBKDQ1lB5AA=;
        b=ro8gj8h+3H6qYEK17i4HIOmGzfOEUrB7zKe4jsxnnB12xZxRgp2wmVN4CmZnE++GWX
         FH6fAWgDS1wtcELVjTRDygnCnDZyHkIeT0HdSmNIN6W+jk4yGmAFoWvNg1pnPFgLJh3i
         GXyL7KuWMQR8f/MWPiPZpy4PmTbBqOneGg46HLiCC6Ph/udKA3YoxoMbi7odpsdRfIhP
         dfMU68NMEk97cGy75S8fF0lIaRTN5qdeGnT+U+2lRcDAke/ZpypLt99rGmLcyUWDMJU2
         tEOH2m2Knp9rXv6uHgUj9iKKo1LGhzXnSU51SbpKjbmhZZuVNVlId1+Ltqma3UkZ9HFh
         8qXA==
X-Gm-Message-State: AOJu0YwRnZQNxkzLjOpzbRbIJ7IetOjmi/HEyOGZJLvk7aEBx+DkuUCT
	7k8PJ81me3+2NbKvKjBweUkYil04IGCM61HiEQRCjsfWSOa0at61qGAecisYAmRf+bM16g==
X-Google-Smtp-Source: AGHT+IGeeboR9LNaCfFHJGSv6CTfOBZFSExVBWnjlZFq2lCEkiAbh1KlEcSN+Z1v0vWXDJB6+Fj+8ZjP
X-Received: from wmbbh9.prod.google.com ([2002:a05:600c:3d09:b0:440:68aa:44b])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3d15:b0:43c:fa24:873e
 with SMTP id 5b1f17b1804b1-4406ab98740mr25460635e9.13.1744985645193; Fri, 18
 Apr 2025 07:14:05 -0700 (PDT)
Date: Fri, 18 Apr 2025 16:12:54 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2572; i=ardb@kernel.org;
 h=from:subject; bh=EUs9Ho6X1BW2Z/6wKHu4GkQswolV9uFnsQmKgY+Uz30=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYMp9umBw3F6zXO9erYui2MsOeNwo+HS7f9iEucf5mbnv
 ++RFpXvKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABPRtGJk+CRwyfzc6qJXE6tC
 ln+t/bWCz8x/ldxPFcfsidc7k9/MfsXIcG+3dPBFXZ6E7BCWlizf3WZca5JnbDxfWtIvwKq0wjm JEwA=
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250418141253.2601348-8-ardb+git@google.com>
Subject: [PATCH v5 0/6] x86: Refactor and consolidate startup code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, mingo@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Reorganize C code that is used during early boot, either in the
decompressor/EFI stub or the kernel proper, but before the kernel
virtual mapping is up.

v5:
- add new patches #1 and #2 to address issues that were reported by Ingo
  for v4
- drop another couple of patches that have been queued up after v4
- rebase onto today's tip/x86/boot

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

Ard Biesheuvel (6):
  vmlinux.lds: Include .data.rel[.local] into .data section
  x86/sev: Move noinstr NMI handling code into separate source file
  x86/sev: Split off startup code from core code
  x86/boot: Move SEV startup code into startup/
  x86/boot: Drop RIP_REL_REF() uses from early SEV code
  x86/asm: Retire RIP_REL_REF()

 arch/x86/boot/compressed/sev.c                            |    4 +-
 arch/x86/boot/startup/Makefile                            |    2 +-
 arch/x86/{coco/sev/shared.c => boot/startup/sev-shared.c} |  307 +---
 arch/x86/boot/startup/sev-startup.c                       | 1390 +++++++++++++++++
 arch/x86/coco/sev/Makefile                                |   23 +-
 arch/x86/coco/sev/core.c                                  | 1620 +++-----------------
 arch/x86/coco/sev/sev-nmi.c                               |  108 ++
 arch/x86/include/asm/asm.h                                |    5 -
 arch/x86/include/asm/sev-internal.h                       |   18 +-
 include/asm-generic/vmlinux.lds.h                         |    4 +-
 10 files changed, 1757 insertions(+), 1724 deletions(-)
 rename arch/x86/{coco/sev/shared.c => boot/startup/sev-shared.c} (81%)
 create mode 100644 arch/x86/boot/startup/sev-startup.c
 create mode 100644 arch/x86/coco/sev/sev-nmi.c


base-commit: 433bf33adc6605f3798cbf2b2c42d0b499233c7b
-- 
2.49.0.805.g082f7c87e0-goog


