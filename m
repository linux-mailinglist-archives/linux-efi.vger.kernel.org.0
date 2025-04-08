Return-Path: <linux-efi+bounces-3220-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79224A7F8D1
	for <lists+linux-efi@lfdr.de>; Tue,  8 Apr 2025 11:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E86E3BDBA7
	for <lists+linux-efi@lfdr.de>; Tue,  8 Apr 2025 08:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A482264638;
	Tue,  8 Apr 2025 08:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HRSihPhT"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06012641F5
	for <linux-efi@vger.kernel.org>; Tue,  8 Apr 2025 08:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744102399; cv=none; b=C8jBPsmm4H+3BGSaQWEQYHpFGxkGv2DIO1c0/V7nNQUT881RYAFSs/q2zBxlfOAZV1p+jYhRmVLar8vuSc13E5jMMJPYSF29qbyaKG5XRkeOFBwpUefyktR80uNccGQ1J/A0Q64dZDUFlLnQ1z7WQOKnUpTbVO7NTOrHf6jmHyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744102399; c=relaxed/simple;
	bh=peLvu1XlMQQklYW0rrgLUnJV5CDAxgIlZN8MTdxgJRo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JLD6xck/suERhwG4MbLzwGVkj/C7IqfBtFMAWMR3KocNF5/XO470ZQ3Ne5qTdB3vIMpu/TzRftnS5vaXuiqSuJdHdfZeNxt9GpdFjCoKS9A9nbGJAgOAGnnkiXK6/6nHAoxlIHcnDRbQsYk2osOPQvpJ0MKf/OHlmXJIzgzDGIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HRSihPhT; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43d733063cdso44923965e9.0
        for <linux-efi@vger.kernel.org>; Tue, 08 Apr 2025 01:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744102395; x=1744707195; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PaIwumfjl5mBoVTjHD7f3PhG3W8rDLB/7sV75J3HgqM=;
        b=HRSihPhTyJHWrbD/qlF8QU5oP+KoS/0r38tFRPerMEqZSwGMvXhvLNoGBUpzCVBJs5
         BISfz9G11gXgzuDciiai71BnTgF3Flr5OeSNP5knOQLiseW+hl5pF2h4fPqeBmeVfaTk
         D1hZryBGgK+htwvYM5QnTolCAEZsH/Fi1EaW9uWqjjBHfMp/jMq764B5m8NKpkxGmdsi
         zWXivooXf5Ps0LZshlctAkzlz8MOE92aluF8WwIZOFHRNgTI5CfCN6W4t6qvgd0igtnG
         K+pa7MDj1W1MY6oeLdwwThHtVKXtLLo9WZAJAob+PWBGqV5Z7Gz1LxwKtmcegh3P8hM1
         HYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744102395; x=1744707195;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PaIwumfjl5mBoVTjHD7f3PhG3W8rDLB/7sV75J3HgqM=;
        b=hEyySSvw8YyqFRxcbo/jQHSBin7WOy7xyptVSdHmeuxZXpQBWXK1YiQY4uwaX7p5NK
         AQiEcxsINcpR+bV/46pXHZbSeKTdQrVIJF36KIUh21V23uZQf/Z5V3ld5Wk1qq7bW71S
         Zq3bWRGk+gAJuh2d2pHjRYqVoxCi82jzpfcmxK6IAmhhoj0CZ4GGX09rrgd8YHlfDhUy
         jfY91AsR9d9BAyfyXR+GkpZwjkP2Ues6kNRNBP96J4yeklv/Hs6OEbQsc6U9ubxy4l6W
         zYPJkvVt4krWI8VS/EbfcX7nSptxn1H82Do1NP/+Dz614orV/LUcVnVnzc546KYwdnMc
         2KEw==
X-Gm-Message-State: AOJu0YyjsGBgVCUwN3RfW004b2fcCq+YUQxmZGKxotQMitjZkNzLFAVM
	lYsavS1sQVZQLkdcNznExm1Z74veSFiJii1NW/S8s7IOe06hrx8Y1Xgtsq5U1Pi6y3YVKz7xtu6
	GctN4ZjLUnV2vzZ8oll8TeCLzAQsO2V3YbgDP/nw3FtfO5R6IaPYPILj1YZyyOMdD8G3gU/zM1+
	bU8F3h/Mi2/1KfeBPPQVvWSg89CQ==
X-Google-Smtp-Source: AGHT+IFjy/uHu0t82SD8X5h+W6UsNbFf0uwEATj50KtdsggRmtc9oI+P9OMnRhk02ZUR+9qe/IB/GX7G
X-Received: from wmbay15.prod.google.com ([2002:a05:600c:1e0f:b0:43d:48c5:64a2])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1e27:b0:43c:fc04:6d35
 with SMTP id 5b1f17b1804b1-43ee0615d04mr121318935e9.4.1744102395061; Tue, 08
 Apr 2025 01:53:15 -0700 (PDT)
Date: Tue,  8 Apr 2025 10:52:55 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2681; i=ardb@kernel.org;
 h=from:subject; bh=4+U2am4BRvyKb8mvQEYtUfJDvEvViqwOCsMY8eSvQWA=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf3L4+cba/L8uS88uClyVjqKY3ok7zSNL29Kl4iLqLQXm
 jCtkd/eUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACYSo8zwz5ZlNjv3zz/8weG7
 p9hH7OfuXvtsTUeXuNzJDap1Oa0zZBj+WS0+viDjzr6dxQ1Xoy+m5aS+/T4h74Tqtaeng6Vcv+7 4xAEA
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250408085254.836788-9-ardb+git@google.com>
Subject: [PATCH v3 0/7] x86: Refactor and consolidate startup code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: x86@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Reorganize C code that is used during early boot, either in the
decompressor/EFI stub or the kernel proper, but before the kernel
virtual mapping is up.

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

The SEV startup code needs to be moved first, though, and this is a bit
more complicated, so I will decouple that effort from this series, also
because there is a known issue that needs to be fixed first related to
memory acceptance from the EFI stub.

Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: Kevin Loughlin <kevinloughlin@google.com>

Ard Biesheuvel (7):
  x86/boot/startup: Disable objtool validation for library code
  x86/asm: Make rip_rel_ptr() usable from fPIC code
  x86/boot: Move the early GDT/IDT setup code into startup/
  x86/boot: Move early kernel mapping code into startup/
  x86/boot: Drop RIP_REL_REF() uses from early mapping code
  x86/boot: Move early SME init code into startup/
  x86/boot: Drop RIP_REL_REF() uses from SME startup code

 arch/x86/boot/compressed/Makefile                          |   2 +-
 arch/x86/boot/startup/Makefile                             |  22 ++
 arch/x86/boot/startup/gdt_idt.c                            |  83 ++++++
 arch/x86/boot/startup/map_kernel.c                         | 225 ++++++++++++++++
 arch/x86/{mm/mem_encrypt_identity.c => boot/startup/sme.c} |  19 +-
 arch/x86/coco/sev/core.c                                   |   2 +-
 arch/x86/coco/sev/shared.c                                 |   4 +-
 arch/x86/include/asm/asm.h                                 |   2 +-
 arch/x86/include/asm/coco.h                                |   2 +-
 arch/x86/include/asm/mem_encrypt.h                         |   2 +-
 arch/x86/kernel/head64.c                                   | 285 +-------------------
 arch/x86/mm/Makefile                                       |   6 -
 12 files changed, 346 insertions(+), 308 deletions(-)
 create mode 100644 arch/x86/boot/startup/gdt_idt.c
 create mode 100644 arch/x86/boot/startup/map_kernel.c
 rename arch/x86/{mm/mem_encrypt_identity.c => boot/startup/sme.c} (97%)


base-commit: 4f2d1bbc2c92a32fd612e6c3b51832d5c1c3678e
-- 
2.49.0.504.g3bcea36a83-goog


