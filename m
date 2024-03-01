Return-Path: <linux-efi+bounces-676-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4103A86DE98
	for <lists+linux-efi@lfdr.de>; Fri,  1 Mar 2024 10:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6145E1C20FF2
	for <lists+linux-efi@lfdr.de>; Fri,  1 Mar 2024 09:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AAA6A8B6;
	Fri,  1 Mar 2024 09:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CbTKP5+T"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6D06995C
	for <linux-efi@vger.kernel.org>; Fri,  1 Mar 2024 09:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709286693; cv=none; b=BevOr7BX/Cx5a/c/iOAdclXxTtXApbLVEAIe6mahRYls9s3eSgsJzY9kdeAzLsRmAYQ5Ku0zqDCX8/a9+/kmoKLPH9qpkL2VrIdEmP5mYz9i0bVhb1P5BnkutnrfWJhmO6dttVXa/lxdaaE/toZkxAD28tn/FUr2/tKEwPtuohs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709286693; c=relaxed/simple;
	bh=TyXOZ7jbRpXP8AEUW5fL3+9OQN5AhwN+bbwo16GumPw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mNi4PP1Xg4mzXEP9Isr5Rq4BqGOmzSi7B6vUEqVVkV+WwxFRLvoZREm/F9k0wEk506/PYcBmDBjzh/72J5qcytRLYkSKL9uyKltquGM18m+EOcCbxIxx1+fLaIWoq2cdEmYkoxC3YhjYavyk5NcLHf1UX+fah8tSfd662ks1Sso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CbTKP5+T; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ee22efe5eeso33596557b3.3
        for <linux-efi@vger.kernel.org>; Fri, 01 Mar 2024 01:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709286691; x=1709891491; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e7pks1pSNXJdwGrT+6lps7jYlKrTpDYfq4px5X+sE1U=;
        b=CbTKP5+T1UBGHri+xGMyyyiDuamZ3eAWkCoNYZRcBfIPI/e0HLUeLd6tbvjMN+iRFm
         5yKxjj4xNAFD/Oy19x/Wv4YTHb8Qi09NjTy1o6veMmRg8Jrs/t4MDhkHrpQmfxw16Efw
         rZ7qHCoQ83L1BXCa7Wyyhwn8q4fTgCgcutfKCCdQt9zLlD3qHWpWYXBFuzBTUAL0JSrg
         Dt2THuBQQezbG75jjGD/Rblsn/36A3Dj43SjCororNuB5sKCyfhGq4IJZU83A0DHRbil
         HnFYSd9nQ+6S7Qcs25Z/Oa5BeHyBDLl76hUeaBaT9M8sO+PVrVNGZLiZiVrz/EUXKdc2
         Ey0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709286691; x=1709891491;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e7pks1pSNXJdwGrT+6lps7jYlKrTpDYfq4px5X+sE1U=;
        b=b4XeR3/Vt3QI3mvt8KWE9hGyhKexBkq4Eqs5JM5QOa0DCmGjpia9pUzCtxuhiMLXdQ
         yVU11NPCfD0enFdIY0aerkBKmbOB7TlBBTk5boJZ0xJHA3jiQbj/eo+XaDobPWjFJLdi
         sBXUFJ2JPMvCohd8O99G5azS/Sp1jLAuT4b7HkkU98qCP9Rv+kO6J/V8XQKAF8y2GrLM
         82QmM/KGFHRP7HxcPKgDNXhzDc+8xed12bJyjM+HuEfwrNaKGWU8G/ZKURU5I0XaARGU
         NV8Nk6z8LTIspRSMco8w7cOQiqEGOMYFh5QbB+8XjA68WkOTf/c/6YCCW/o8fnuBNkCW
         tr4g==
X-Gm-Message-State: AOJu0Ywooa8yvmIfhGeY5IMFOV6xUJ85lTRsWOQDqM4GsPblKRk20yG9
	Oy6UOT15nNpDBifN4/pIrqsbrUu4IlVfv/GN0H8GXpHAXDMQcOdS/KjNX4suG0iBx8Uc9A==
X-Google-Smtp-Source: AGHT+IHj5I1Myf8/NQR9LUYnVJBeGyRi2e1y9MPFNq8Si9/TUkLVVopS8617pSmVzydjJ2Qt3hyls72T
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a25:ef0b:0:b0:dcc:6bf0:2eb6 with SMTP id
 g11-20020a25ef0b000000b00dcc6bf02eb6mr26260ybd.6.1709286690906; Fri, 01 Mar
 2024 01:51:30 -0800 (PST)
Date: Fri,  1 Mar 2024 10:51:27 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1597; i=ardb@kernel.org;
 h=from:subject; bh=BKKftzjnJSMROEd9JsxhN3MMlUoOnIbkC+ZLMCrL9m4=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXhUvkZIQl/wu0unyu2EPA26+AV+b67z7KmcY4m146Pe
 oqBn9s7SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwEQKTjD8Zo1+ZPB+6g8xia2n
 O3NtuworUxt1soI+SLOEPc1ZoXxPkpHh+bqnK/6avjedL6Dyq0t66b3P4rVMJo8vPtkT+vnhcu8 dnAA=
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240301095126.1223559-2-ardb+git@google.com>
Subject: [GIT PULL] EFI fixes for v6.8 #2
From: Ard Biesheuvel <ardb+git@google.com>
To: torvalds@linux-foundation.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Hello Linus,

Please pull the EFI fixes below. Only the EFI variable name size change is
significant, and will be backported once it lands. The others are cleanup.


The following changes since commit 1ad55cecf22f05f1c884adf63cc09d3c3e609ebf:

  x86/efistub: Use 1:1 file:memory mapping for PE/COFF .compat section (2024-02-05 10:24:51 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.8-2

for you to fetch changes up to 2ce507f57ba9c78c080d4a050ebdc97263239de8:

  efivarfs: Drop 'duplicates' bool parameter on efivar_init() (2024-02-25 09:43:39 +0100)

----------------------------------------------------------------
EFI fixes for v6.8 #2

- Fix phys_addr_t size confusion in 32-bit capsule loader
- Reduce maximum EFI variable name size to 512 to work around buggy
  firmware
- Drop some redundant code from efivarfs while at it

----------------------------------------------------------------
Ard Biesheuvel (2):
      efivarfs: Drop redundant cleanup on fill_super() failure
      efivarfs: Drop 'duplicates' bool parameter on efivar_init()

Arnd Bergmann (1):
      efi/capsule-loader: fix incorrect allocation size

Tim Schumacher (1):
      efivarfs: Request at most 512 bytes for variable names

 drivers/firmware/efi/capsule-loader.c |  2 +-
 fs/efivarfs/internal.h                |  2 +-
 fs/efivarfs/super.c                   |  7 +------
 fs/efivarfs/vars.c                    | 23 +++++++++++++----------
 4 files changed, 16 insertions(+), 18 deletions(-)

