Return-Path: <linux-efi+bounces-872-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AB0887EEE
	for <lists+linux-efi@lfdr.de>; Sun, 24 Mar 2024 21:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F230F1F20C37
	for <lists+linux-efi@lfdr.de>; Sun, 24 Mar 2024 20:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8259C14A8B;
	Sun, 24 Mar 2024 20:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fJP8iqU3"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8D31426B
	for <linux-efi@vger.kernel.org>; Sun, 24 Mar 2024 20:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711313563; cv=none; b=euR+Ubl3PlcFpnfd9FjE6dwiztThsT0wKv/Cu5Gn8I9C8csSgP+rhAo98vuWL8ATDevNRvyuU041IiDcf6CKayNf44mz/p3wDM1F5qtMEALwNj2b1IVaqdsh4nVXNBapRhrSRiIIqWsP5b59hOX9k8DUWTbZSNTm0TJ6zfEoNAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711313563; c=relaxed/simple;
	bh=YL0sdHR5FB3zDf4mq6rbScidwi1dRM7cFGhk29gAzV0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=u/NVAlZMIOwFsTUuH2/8Fzlr2poIK55oHsYCQqoVsA5l4shic+leMf4YdKWsYAq3fJr5/Cbqj4kL1OTxcDds2fTZklYzDugRqi+FBZx+3Y1SIBt45hn2AHDdIK+9oPhAO4fgWWeppjNs0zCysbd3pUHwICry33ioRQhTF8TNflA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fJP8iqU3; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60ccc3cfa39so56612547b3.2
        for <linux-efi@vger.kernel.org>; Sun, 24 Mar 2024 13:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711313561; x=1711918361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dVWt3CMJ3NJdpEk3p1NC4pAX/+Zj3P2fsZIxsPqsAtE=;
        b=fJP8iqU37bMv0pTlanE+eyTOWdLm4vAtHpYhQwzwWulOhKRXcnY7Ys7Jw8RXEYz0D2
         S0xFrfajk74kwYWC85Oue125zGju8eRqFIq7Sdh3w9m8/tF+IhQawdc9Kv+3dXLkD98y
         HkCbeBva4ty2v/YUuoquseKGbREyml7UmlZpyTec8Nq7vjSLH3jcBnQ0P5vmsPIykd1j
         N7Y9CeiSs8IWFDziQIOSZUj7n3eMain36cEWZ/MVaVBnEcgW8ectkcvkN6YcFuPUlD6u
         Wg8i/koEodcigjaJuNGCh056lVY9z8iR+Uj3CdnXtKvf4OeoJ0U6LOzkQTq2E253RvCF
         gTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711313561; x=1711918361;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVWt3CMJ3NJdpEk3p1NC4pAX/+Zj3P2fsZIxsPqsAtE=;
        b=pY2x3QsvtlI5tL3cCBsk3rUqyq1cWN7zE+MCC9CoMGLLoL73iUU9qEicosOBl3Y1sg
         qvvbZOco8lOvom8FUTdQQtOLOwd/AA8Dbg3IVt/2DVT0upxcgXyv0j2BBC1jTCYbPahX
         s79oanuqdv6dc4e76kK+EPxjTPXzWrOcNMoawMz31BDYuIRJmk1qImEPjeligRI2l/Yw
         iuDo1uVHnPTbeSEEulA1Y9aM/Q9GJZsLT8Jrn11aPbOas+684BvQq0BcEhIitXnoYmKT
         5hURlSgVkJWByO/LyDCGuonP+DwCjLX33YudjbrlPacuyaB87Tefm9DRTTNcd8BQSwFu
         LQ3w==
X-Gm-Message-State: AOJu0YxDSP3haIvDyQBeYYSDo+Z8mLY9VF1w8DrJ+JvyzaCyG/ONQwZJ
	ZGJbYYzNOsip0jOYZ4T08qmBSAxxgw63h44pU7YARxeMNlzuktvN3WCCm9C+4Ia8js4ggA==
X-Google-Smtp-Source: AGHT+IGI/7j6RDbgihz3DyhcIooO0VCH2QKkxxjhz4O8e/em+iJhffGkWs3z53ebMm+pzWNDKIaBRHpI
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:2491:b0:dcb:e982:4e40 with SMTP id
 ds17-20020a056902249100b00dcbe9824e40mr1717391ybb.12.1711313560805; Sun, 24
 Mar 2024 13:52:40 -0700 (PDT)
Date: Sun, 24 Mar 2024 21:52:35 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1796; i=ardb@kernel.org;
 h=from:subject; bh=3H1tZuyeIM6rEwfbc8PzDHGzsjWmRD/PBPeAuvKFD14=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIY1h0hRd9liX6PQsgbs6z2z2t7DeLGe5+sC/d49OReeKu
 RMyGg52lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgImoMzH8M5h4rkxv2iYD1be9
 xjOMX/Ktq9hRz2uQsisiyeYlW69kAsP/6qhmybPT5yYvWeQbrcX8/TpDl9yJf2lLVnPNe7f2/E1 OPgA=
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240324205235.3988845-2-ardb+git@google.com>
Subject: [GIT PULL] EFI fixes for v6.9 #2
From: Ard Biesheuvel <ardb+git@google.com>
To: torvalds@linux-foundation.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Ard Biesheuvel <ardb@kernel.org>

Hi Linus,

A steady trickle of EFI fixes this cycle - this is due to the backports hit=
ting
kernels that are more widely used. There are a few more issues under
investigation, but these fixes are straight-forward and important, so no ne=
ed
to delay them.

Please pull.

The following changes since commit b3810c5a2cc4a6665f7a65bed5393c75ce3f3aa2=
:

  x86/efistub: Clear decompressor BSS in native EFI entrypoint (2024-03-15 =
19:47:09 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-=
for-v6.9-2

for you to fetch changes up to 62b71cd73d41ddac6b1760402bbe8c4932e23531:

  efi: fix panic in kdump kernel (2024-03-24 09:28:33 +0100)

----------------------------------------------------------------
EFI fixes for v6.9 #2

- Fix logic that is supposed to prevent placement of the kernel image
  below LOAD_PHYSICAL_ADDR
- Use the firmware stack in the EFI stub when running in mixed mode
- Clear BSS only once when using mixed mode
- Check efi.get_variable() function pointer for NULL before trying to
  call it

----------------------------------------------------------------
Ard Biesheuvel (2):
      x86/efistub: Call mixed mode boot services on the firmware's stack
      x86/efistub: Don't clear BSS twice in mixed mode

KONDO KAZUMA(=E8=BF=91=E8=97=A4=E3=80=80=E5=92=8C=E7=9C=9F) (1):
      efi/libstub: fix efi_random_alloc() to allocate memory at alloc_min o=
r higher address

Oleksandr Tymoshenko (1):
      efi: fix panic in kdump kernel

 arch/x86/boot/compressed/efi_mixed.S       | 9 +++++++++
 drivers/firmware/efi/efi.c                 | 2 ++
 drivers/firmware/efi/libstub/randomalloc.c | 2 +-
 drivers/firmware/efi/libstub/x86-stub.c    | 3 ++-
 4 files changed, 14 insertions(+), 2 deletions(-)

