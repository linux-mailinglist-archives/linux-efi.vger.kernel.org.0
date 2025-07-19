Return-Path: <linux-efi+bounces-4424-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC09B0B23E
	for <lists+linux-efi@lfdr.de>; Sun, 20 Jul 2025 00:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61A593A4131
	for <lists+linux-efi@lfdr.de>; Sat, 19 Jul 2025 22:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CFB1C862D;
	Sat, 19 Jul 2025 22:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="caqyzkwq"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF8C171CD
	for <linux-efi@vger.kernel.org>; Sat, 19 Jul 2025 22:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752963630; cv=none; b=WVS1mpn0/se+ufQjQ5KxclfM/xxDQ/1H0kVgoxJ/dWYImIJnOB4uBg0CUDY3xUDhF8zbkIc6JNV97M6rC0ljVKuTwFuFT4b7q4Fk8kTvP/0sW1be6O0yEqtjsgdVNzN5QcJOlRWVIy01tLjTXaijTtUp1B64VgMd7aYZYfuxAqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752963630; c=relaxed/simple;
	bh=YagSNtnhStvZ7TT+/k9tqzEgn0vctDeNkVxV38XkQXc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PowzvH/Lk25hNwmFyjrenIBDE2uGCAEbbvyLaDAwQYxGbnV1N8yFdf+00iQIbuUt8yyjMBPqGGTdeVySzvK8mFDSPzlb7lqTuHUAZThekFR0gZYHipbFi0C7JKXmmlsoMIthbBDJO/XK9oFdwl4mSKW1XeGFSUpkNhGs/YZcisw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=caqyzkwq; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-60724177a1fso3824822a12.3
        for <linux-efi@vger.kernel.org>; Sat, 19 Jul 2025 15:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752963627; x=1753568427; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DLNV6VoIXDZdsqTea5Db/jI9Gpyh3r6TynIgSa3eEzc=;
        b=caqyzkwqrCvF89oi8Jl5o7CjvvCAC6RuY+kvS+wC+C4kQnZeZZGrRLG7pxBxSjdMpU
         CwYrcrzUYVT37h8Zl0VY5sLxf/jA5Jua7QGMglVHhaFhQQrC1FJvY14tcgYe7UdJ5kJ5
         tooUN5P6AHzRGm3e8OA9tB8cDMMZKI7J2PQj8RgG0ZLYpnUuBpCeNXvXz74cZJmQJfDC
         150edx8K2nRPKBcW41msYKCA2ky1WbfK0yKITPmQAa+FIP0rASNFLgBx/eT6w26nmze2
         068iWO5TCdPBM+ABmp5yMOGcq5dYMDWn5vZaYJRazVISQxcB5btMFIcnZ2oYUxEZTzvq
         QuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752963627; x=1753568427;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DLNV6VoIXDZdsqTea5Db/jI9Gpyh3r6TynIgSa3eEzc=;
        b=MSnMu7U8Dz0ZAHn08qKTAub9v4vGdBQaoxBkbw2t2tWTYv+5wmqYu54mexYS6rydEg
         XH3RRhKw8ZEWf+Q/WY3a5gMzXnrPYuyeNA6ve++d4L81NERYL4/T+xgjPnwfd2SZ53Ne
         bVZJEQyXcE7Y1paIACDMqp9x670V6GRFjClyi205a9PZhw/Fk1SYNpedqZl2oCiCBD1h
         f74+iNdgt9HdYYMCuMmBpktLeIjAs74M04PwNyeDWqS1+T4lWRalzuMKVmEb9LOw/kPE
         GYdEY7IgE+AoCpLJpz2tetxpeDUzWMBupnWFjkCWatZmxnxie83F2/VAo0wW++FVHsoD
         XgEA==
X-Gm-Message-State: AOJu0YzdelEfuud+JgZINxXPWFNeI8ZFI4ABXDoNXKyTEeTnaHWYWiW+
	sPqDauafU03TYsESsH9eHZXbjavmXpMCOftFvkPuLGxHUdUA3M/y53qlDyTyJhb5KBtJV4TQcQ=
	=
X-Google-Smtp-Source: AGHT+IHxBTWijELumx1jMtLC3B+Y5jYQwiyaPB5fBrYv2MNlK8JXRHlPJvWBBch1QxefR6tJPM/NhviA
X-Received: from ediq8.prod.google.com ([2002:a50:cc88:0:b0:60c:3d42:d98])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a50:cddb:0:b0:60c:3c19:1e03
 with SMTP id 4fb4d7f45d1cf-612c735e8d2mr4301822a12.9.1752963627479; Sat, 19
 Jul 2025 15:20:27 -0700 (PDT)
Date: Sun, 20 Jul 2025 00:20:08 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=927; i=ardb@kernel.org;
 h=from:subject; bh=dc89AKKQrNv9xwlMHG4CK/hNybZ2js4CnNyNIE562nA=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaNGSrq9+3zcghzHJ28zJINT33/q5N1ZN+HNS82J17d6e
 f5M0XrVUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACYSxcDIsJajccWUlXG6XRtf
 LQvaKSBuM/+j9W/d6c8L+DhebZu6tYnhf/7nv8sifb9Kd35j/8fL4G3xRa5WI5hFqrNjdWnt/Nn 6fAA=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250719222008.760814-2-ardb+git@google.com>
Subject: [GIT PULL] EFI fixes for v6.16 #2
From: Ard Biesheuvel <ardb+git@google.com>
To: torvalds@linux-foundation.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Hi Linus,

Please merge this final EFI fix for v6.16


The following changes since commit f8b53cc9174c5980549f60c972faad82b660b62d:

  efi: Fix .data section size calculations when .sbat is present (2025-06-20 13:36:14 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.16-2

for you to fetch changes up to 64e135f1eaba0bbb0cdee859af3328c68d5b9789:

  efivarfs: Fix memory leak of efivarfs_fs_info in fs_context error paths (2025-07-18 12:00:20 +0200)

----------------------------------------------------------------
EFI fixes for v6.16 #2

- Fix potential memory leak reported by kmemleak

----------------------------------------------------------------
Breno Leitao (1):
      efivarfs: Fix memory leak of efivarfs_fs_info in fs_context error paths

 fs/efivarfs/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

