Return-Path: <linux-efi+bounces-3346-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5E5A90976
	for <lists+linux-efi@lfdr.de>; Wed, 16 Apr 2025 18:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8B387A61C5
	for <lists+linux-efi@lfdr.de>; Wed, 16 Apr 2025 16:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D13214A9D;
	Wed, 16 Apr 2025 16:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SStQOg4X"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FD3209673
	for <linux-efi@vger.kernel.org>; Wed, 16 Apr 2025 16:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744822684; cv=none; b=f2k3eG6eoGtVbuU12Ofw6qx0f2qj/0FvUNDGsaS/c+RTPwizLMo9UBK1Yy4i02At8KE6XwjUKkJv0HBwLb1mGoCa+e7oQuOjwjmVVCeCFAU+Frsum0+0woX5UH+q2U4E7RzuvYYfpyUINcC1iYu0OBAGvKd4t5JeT3Zbq5gntF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744822684; c=relaxed/simple;
	bh=K6pLnfWwXU9CUrSrZB7vxbnKjaj5uNFAr9G2599uI4Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=of7fAeOh6ZIVNyeXJorEPvfdm5Ua+2Ts/CW2Mr2btqJIePBQ+o4KkWe5EbFpZvSeFU10hItbYWcuc0iXNfJGVdscddKxy4SQyYkKxRNQFwhmoxLUF0s4lZYBDj5tCZe0nfAtsdmBUZAuGJFblzhROD4KnZpEAqDq7RfJAGhpsoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SStQOg4X; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-39d917b105bso3981253f8f.2
        for <linux-efi@vger.kernel.org>; Wed, 16 Apr 2025 09:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744822680; x=1745427480; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dmdBoA6zz78+xOLW9xsC44zh3bW6ooVzFnjRvgSK8Hw=;
        b=SStQOg4XjPpD9E9kjRv45wZDJbglf2KWAnEO3apsUqojSCNKUZp3p6fra1ZFWaX5LW
         6UvBD3hEna4otZ6s/KJfObAAaO2G6bQzHggb/SHRq+tOraspvmkb1+PJTEnkAF254l9s
         Q4D+spD6d563AT7pKmJhS6ih6wkrB359ZoccqlbLrDXJRmtkCg12t7NO5SgVRIfpPVMI
         K7vyzoxE+u+ybobKXoJhscgdyloMM02yIYf47f1Hy143L2NDJ8Iz9FjUF9MgjbEQbU1W
         cvjaUZFsOVbT7atffyH+xmQqgP6ScSnF9kU0pRrB0z7d4mXVC08BFUSaYtAVLuS6J/vf
         Aq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744822680; x=1745427480;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dmdBoA6zz78+xOLW9xsC44zh3bW6ooVzFnjRvgSK8Hw=;
        b=DobwxO/Qb/sDDyr1XxPmMI0/n16xvixxCWfamX8EflHCiY/i09n9ZiaGJ1PJ+6whq8
         Id86xQ5bqxiMuCP+mrKrjEywqY40rllCJjdbZsttHPUhT/T4cvxUM7pNc6eslFU77K+f
         znwCfgdzehSc67LRhChxXcRoNaQDUWhjmNcquzV5k0Qn6vEsoDWyA74VVGRUdYjBw+Qr
         L1f1dr2OOpfELAHbr+WScfVJgcK5c5e7fLziahv+4kpLw++YVEpcDEjUfn/NSFb0by8J
         pHv2fFumg41p+MTaBRnP1OFAWSpVY6sCQs6koAmGW2kSPFNjoxo/3nZLr3D6F3+U18/J
         wWGQ==
X-Gm-Message-State: AOJu0YztN6p1BbfzX/GrwrzNmd//eg04vtn0IASOiqWddP/gAu5jre/C
	zUIp9xVGc7cpAuMjpqdrLCfekjh3KRoLpBK9Tb3qi+xr0vShP1dMZvPK2dZbzoh+PempLsltErw
	0mZHCtFfGNvrcf1hRRPEPRYY7Wwi38uhdhsvf5Wsim/MKXdY2yQddYOd3d7Y6yifokmGEuCnqmx
	eHNQNMKfQZJn+lG9GUY8fkZBjNMQ==
X-Google-Smtp-Source: AGHT+IFPFFb1EniwwTjYw4OJuOpLJGMjTOv5HhlzQpBXQ+xCVbnT4IKosegkJyCI/sHUbC8u1XWfVfsL
X-Received: from wmqd19.prod.google.com ([2002:a05:600c:34d3:b0:43e:9aac:5a49])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:4201:b0:39c:1f10:c74c
 with SMTP id ffacd0b85a97d-39ee5b37021mr2691786f8f.35.1744822680255; Wed, 16
 Apr 2025 09:58:00 -0700 (PDT)
Date: Wed, 16 Apr 2025 18:57:44 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1224; i=ardb@kernel.org;
 h=from:subject; bh=N+fKRIG32MGIDHSfCLW8zpajv2xa0m+Wt5yRK9xdwD8=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf3/ww77Y6YHuNIePlGd7KElHDCvi3lD2qsAtpj45qrH7
 56HBud3lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIl0eDMyPHNiXH7v5e+Azruu
 9wO4kltvM/h9eaLBvrh7uxrvrV+L9zIyzH+5INhg2wrFs2vtdp9gexzbPvl658S7t113yi6S0z5 UxQgA
X-Mailer: git-send-email 2.49.0.777.g153de2bbd5-goog
Message-ID: <20250416165743.4080995-6-ardb+git@google.com>
Subject: [PATCH v2 0/4] efi: Don't initalize SEV-SNP from the EFI stub
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Borislav Petkov <bp@alien8.de>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Changes since v1: [0]
- address shortcomings pointed out by Tom, related to missing checks and
  to discovery of the CC blob table from the EFI stub

[0] https://lore.kernel.org/all/20250414130417.1486395-2-ardb+git@google.com/T/#u

Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: Kevin Loughlin <kevinloughlin@google.com>

Ard Biesheuvel (4):
  x86/efistub: Obtain SEV CC blob address from the stub
  x86/boot: Drop redundant RMPADJUST in SEV SVSM presence check
  x86/sev: Unify SEV-SNP hypervisor feature check
  x86/efistub: Don't bother enabling SEV in the EFI stub

 arch/x86/boot/compressed/sev.c          | 33 +-------------------
 arch/x86/boot/startup/sme.c             |  2 ++
 arch/x86/coco/sev/core.c                | 11 -------
 arch/x86/coco/sev/shared.c              | 33 +++++++++++++++-----
 arch/x86/include/asm/sev-internal.h     |  3 +-
 arch/x86/include/asm/sev.h              |  4 +--
 drivers/firmware/efi/libstub/x86-stub.c | 27 +++++++++-------
 7 files changed, 48 insertions(+), 65 deletions(-)


base-commit: 221df25fdf827b1fe5b904c6a396af06461a32f6
-- 
2.49.0.805.g082f7c87e0-goog


