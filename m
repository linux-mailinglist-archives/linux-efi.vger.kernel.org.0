Return-Path: <linux-efi+bounces-1490-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E0D93B7C5
	for <lists+linux-efi@lfdr.de>; Wed, 24 Jul 2024 22:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E160C28116E
	for <lists+linux-efi@lfdr.de>; Wed, 24 Jul 2024 20:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A97115D5C4;
	Wed, 24 Jul 2024 20:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xA/UrpB3"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9120B77F15
	for <linux-efi@vger.kernel.org>; Wed, 24 Jul 2024 20:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721851680; cv=none; b=re58o/sOSH1RkvaBGB0BKZ674jJ38FO5WCAA752Pn4IGgcT10GYD8X8EpyiGJn6mkkda+V1v8QGi02EfCYESPDsGnRvt9AEMHZmXDPKVGui9MSFSlb9P53xec1gTcIfsvBsRZ9Z0w/WPZS5KfaCixC0w/r/KefmklZJWlsVZWlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721851680; c=relaxed/simple;
	bh=5zfsniCrRalI8HqxYzqa1DvKqrx8a/HvC/2Qp558cFg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=t8uOkWcFVzTtw5TtXQgaIj/3Ela4Dt9slHNjbyOwNY/Qde0odWf+Y9E2MJaYZXxyO9Fq68FGylTq41rOdNeildN2IudT6Zh2U6c2C4P2K2fGyxe7zogLokQnML6pfpnPt1CtfvWkJA9Pynisw5tvnCV44rKRfkRI/13H109dDgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xA/UrpB3; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e03623b24ddso235576276.1
        for <linux-efi@vger.kernel.org>; Wed, 24 Jul 2024 13:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721851677; x=1722456477; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IcSO1hIXZSp7ISLW/6mEiOaLnBKt1xdR0JsHZUZpetA=;
        b=xA/UrpB3KBdqLgZPhP1/yZj/VUoasRQyk62lTHYnNZu4lQ4obQrW0KIfEJzDeVe2F5
         Ej982hvHSOwgFVttMGFWvCbd2UcsW1BC/v5kk1bQhjIFXf1BgITgFGMUpdh2WwTFHqUj
         hx840FXT6ObfK9IF9LJMscI5xotGAugBEgimycwMlI++ueUEtn0YP088C6KqzNy5px5m
         9ObiDERP9lGvekbrUbYKp3pn1fgzMqDb+v7K4eM7m5ceAs56Y+hIYlrjIbnnleDo1lKM
         laLBLsX4mGc65JabJtdr3gBAwjsOLDMVpT1B/OG5TOj/btLZ3E4KYPjAi59nRr6/jhzj
         ulKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721851677; x=1722456477;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IcSO1hIXZSp7ISLW/6mEiOaLnBKt1xdR0JsHZUZpetA=;
        b=bysU6AXNoOxwKwKGPXzMK75VEIihZNQ1RBwaDy65ohKcE0LFEJJwF2TNZ/KxtBMaa6
         WkcQyPoV8j9mmY+HDmqm+LyqUGU3an3ip3DcZANNccHvX8qCnnr2M3tqNGN9F+jDbeyj
         c2oTxXKENMsUjj78GbviEEoWhCA5C5wIKVOrAajq3q75NmPE1g7/AFs4kyib9U+cirhl
         50LIcq3K6u+soYrib8KRWnL1nxS+wjioezno8nELKUB+CPIU0pFQNBuZmtsG/xKu7t38
         D6E7c/GeRCEwHXiJEIBoQDOwB3/zKcFDLzGX6ihPkY2yC0mlFL2T7x+zfzmk3c+hvj0E
         XOZQ==
X-Gm-Message-State: AOJu0YyutKmOvGrn//OLgIs9N2q3QYtBKGOEHBSsv5b77zkjnZmEQ0+X
	1EzORYJw6UWC3i+j2hpN/amDG/HnfSAwWY5nAau1Yl0XAGCOnTIDu2QN79DA4mlpBIHqxA==
X-Google-Smtp-Source: AGHT+IG2kaXbigVsFXVotEPU8LKiR9b6KnKZlvavc3x3X4ujBSmIrrPdvSCsZRpmGchS6eU79XeioIMU
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a25:8289:0:b0:e08:a80c:c27 with SMTP id
 3f1490d57ef6-e0b231f4020mr15961276.7.1721851677521; Wed, 24 Jul 2024 13:07:57
 -0700 (PDT)
Date: Wed, 24 Jul 2024 22:07:35 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1366; i=ardb@kernel.org;
 h=from:subject; bh=abdIQvtufByPjivE8/fxctUqQG9A4zoRMzxnj4Mzhy4=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIW1hPDvP1mlPnzYnJTnqh8dte/1v6sQTT5SXhIUzXVgwr
 4BNZrFMRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZiIkhcjw5Fjn2X2eXRt2GTM
 dN1nmYPGqQBzS+6zXUcj3zW8XhNm7sPI8EvRKE3Y7gvnxo7qm3u3lj5dtvp0hr6QVcbaHb3/Q27 MYAQA
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240724200734.1114800-2-ardb+git@google.com>
Subject: [GIT PULL] EFI fixes for v6.11 #1
From: Ard Biesheuvel <ardb+git@google.com>
To: torvalds@linux-foundation.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Hello Linus,

Please pull the fixes below.


The following changes since commit 4a2ebb082297f41803742729642961532e54079e:

  efi: Replace efi_memory_attributes_table_t 0-sized array with flexible array (2024-07-12 10:06:01 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.11-1

for you to fetch changes up to ae835a96d72cd025421910edb0e8faf706998727:

  x86/efistub: Revert to heap allocated boot_params for PE entrypoint (2024-07-18 23:05:02 +0200)

----------------------------------------------------------------
EFI fixes for v6.11 #1

- Wipe screen_info after allocating it from the heap - used by arm32 and
  EFI zboot, other EFI architectures allocate it statically

- Revert to allocating boot_params from the heap on x86 when entering
  via the native PE entrypoint, to work around a regression on older
  Dell hardware

----------------------------------------------------------------
Ard Biesheuvel (1):
      x86/efistub: Revert to heap allocated boot_params for PE entrypoint

Qiang Ma (1):
      efi/libstub: Zero initialize heap allocated struct screen_info

 drivers/firmware/efi/libstub/screen_info.c |  2 ++
 drivers/firmware/efi/libstub/x86-stub.c    | 20 +++++++++++++++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

