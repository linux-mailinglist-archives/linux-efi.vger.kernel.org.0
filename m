Return-Path: <linux-efi+bounces-1969-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0311999F4FD
	for <lists+linux-efi@lfdr.de>; Tue, 15 Oct 2024 20:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01F9C1C232C4
	for <lists+linux-efi@lfdr.de>; Tue, 15 Oct 2024 18:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CC81F8F17;
	Tue, 15 Oct 2024 18:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0+0zc2eR"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CB41FAEF3
	for <linux-efi@vger.kernel.org>; Tue, 15 Oct 2024 18:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729016161; cv=none; b=XibpRf8KyNmYsQbzrDf8J8S8BoSOTZmt9UpTxff9rIUhpA9ZQAgCZxuBHUS5DoIl/nvrnZQZz9vIK5fmdinFIh5NgLGCcN6qIaoDNKTroF5q2xLnyla3ZqzZG1pECddMfQi8mt0ZlUO3dbTQf9d/xSuM7f4Pg0zgec+XM9BB7gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729016161; c=relaxed/simple;
	bh=Io01pTFYMIte9yxemTwKWh2HZlTI2RwLBGB6qdLs3TQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fnyCndPWYGB7uPhDYg5DXlaY7s4BMmiU7D40RVOvVcNHiB2NWMBgiPjS4MvncEV3MYD6oz7+qaX5Bc3p+pIhjyFZiJpf3bskYe6dr8bNvWPaXGpuEAiRRWDbrEJ2vMhUdzGLjWqoKKaow4w2U9+EaSiMFrTR2B50tMqpWwMgwpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0+0zc2eR; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-37d45de8bbfso3588222f8f.3
        for <linux-efi@vger.kernel.org>; Tue, 15 Oct 2024 11:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729016158; x=1729620958; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=djozh5uPHkhGo9UNi3Y9YhvBqfn2inN4dQSDVEKC3H4=;
        b=0+0zc2eRTeZ5IrCCmbJn5ahLrwg4e1pwCBkDEm6WeROARsgKGd0W+OB0xeDBSHSEbQ
         WS2GLH9yBySLAVrHUCHrUd5TtElrUsS4Du/LgwGJnaaI4e0rR+QdRtNb6oy8u55gOA7p
         yNk+yafJ6VwkSU3/5JNCS6jhGA7KoufGKsAVIC6tsr8KCzEX+JJlwyO1c1cHgdQUe2gi
         fbX/lyO54CaHgJsG1MfyUSy01e+UXIkS46+5I34gVUQ21doun8ZTe2spRHh0fBQIGWxG
         VnR6GQJpa4ke92rnZh1reVeKUr6lYRkXqt1Wf6fTrV8PAiGjlr6qjCDRwUWGlN8qwweW
         2Siw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729016158; x=1729620958;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=djozh5uPHkhGo9UNi3Y9YhvBqfn2inN4dQSDVEKC3H4=;
        b=IJp8qSwVZoZqUB0cCL6+7mow2/AWiuQgey3BICx8eTpYb/DyyDcWzVl0gfPmDSQnCC
         O5JfaRJ7gD+1dtYplTX1BhHLVUEk8nwfQVQxXXEwhB+PTeWJDlBjREToJiR5DMbmizzJ
         S06EGe2BlmByaiDjsGu+YNM2rrj3tOT/73HDTlealVeoi6lC2eQnjpStrzIHj8Pkt4A9
         mbDchhMuKtcVrenSSSrSt1lzs3ng68U47eQAl5lfMN+0AGV3YJOp5oASmZayqm8m9M7+
         IuRruskz7ht6OhRgJxabccdIE8TGjLUdattsGF0tjSwCjAHDvp6PNhU5H41q3L3siav2
         8zXw==
X-Gm-Message-State: AOJu0YxEggMW4k0q4TCYWsCigPCTfUwCvM0wTQOw1KnhZshRDhdodgiH
	koGDBdtNFYFh2h5TdIBdNDx7Hry5jE4Yo4voe41ixhv37aOObJ44IeUq1bYwvkycjWhXjKVNMun
	9s7/CP38zSsmaFgqwvA2BV31Z1YRbS6VJ+lXgvi4Loxf7t7EcJkLzxuKmayNMSAszlmn/iO1biv
	3Of0F6wb3xeew8lPF03ai28lc+5w==
X-Google-Smtp-Source: AGHT+IG4Uy9PI8UTU9F3FRndbtgnqsTldhV9xKQgyAhjmwPGeg1iI5C46nO1uWYKJDjFKIqWqpHzH+z6
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:adf:f810:0:b0:37c:cfb6:cbaa with SMTP id
 ffacd0b85a97d-37d86d2bba3mr678f8f.7.1729016157392; Tue, 15 Oct 2024 11:15:57
 -0700 (PDT)
Date: Tue, 15 Oct 2024 20:15:50 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1577; i=ardb@kernel.org;
 h=from:subject; bh=bvf6wCIdyOAFYcyFQzZ9oiRaXWmrTQSbnH5NqlRgblA=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZ1vY1jQhwcfBfJNS3o4PNVzYy6UmR6+w8ESfveA1wP3e
 KH/OeIdpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCJupxn+pwoIFHy589lmwvfT
 flFtr9MYHxd86Kqftk4p8MXTjFNbxRj+ChecZ7/5rFafvzPSj6GXa8+pvwreqTHbXBlF73Cd+bq PEQA=
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241015181549.3121999-6-ardb+git@google.com>
Subject: [PATCH 0/4] efi/libstub: Clean up command line handling
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Jonathan Marek <jonathan@marek.ca>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

This is a follow-up to the patches sent out by Jonathan last week
[0][1], to fix the broken command line handling in the EFI stub, which
currently fails to use the built-on command line as a fallback as it
never considers the bootloader provided command line to be empty.

This series fixes some more identified issues:
- free the correct pointer on error
- parse the built-in command line *after* the bootloader provided one,
  if both are available, to match the core kernel's behavior
- implement the missing fallback handling when loading files provided on
  the command line via initrd= or dtb=
- ignore the bootloader provided command line when FORCE or OVERRIDE are
  configured

The latter is provided as a separate change, as it changes behavior in a
way that could result in regressions, however unlikely.

[0] https://lore.kernel.org/all/20241011224812.25763-1-jonathan@marek.ca/#r
[1] https://lore.kernel.org/all/CAMj1kXGbuZnM8GoHasWNxs2YOnUDL-JViRmvGdVc91WHkMbdqA@mail.gmail.com/T/#u

Cc: Jonathan Marek <jonathan@marek.ca>

Ard Biesheuvel (4):
  efi/libstub: Free correct pointer on failure
  efi/libstub: Parse builtin command line after bootloader provided one
  efi/libstub: Fix command line fallback handling when loading files
  efi/libstub: Take command line overrides into account for loaded files

 drivers/firmware/efi/libstub/efi-stub.c | 21 +++++++++-----------
 drivers/firmware/efi/libstub/file.c     | 21 ++++++++++++++++++++
 2 files changed, 30 insertions(+), 12 deletions(-)

-- 
2.47.0.rc1.288.g06298d1525-goog


