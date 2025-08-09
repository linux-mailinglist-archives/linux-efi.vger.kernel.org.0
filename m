Return-Path: <linux-efi+bounces-4523-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41601B1F2A0
	for <lists+linux-efi@lfdr.de>; Sat,  9 Aug 2025 08:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C38117AE73A
	for <lists+linux-efi@lfdr.de>; Sat,  9 Aug 2025 06:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827B9267B12;
	Sat,  9 Aug 2025 06:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tQ2B/xQJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCDF18A6AB
	for <linux-efi@vger.kernel.org>; Sat,  9 Aug 2025 06:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754721987; cv=none; b=J3oeff8iAesqZFLAei20zEPWEfyZM5cEN7zhJqiEpSmhw7kWu/1U/GYBKxu7JyiGQlhzwB2n3NAMF/MLpWGFIZjsmCmt94Smesn3GG8oQ3ts8T0LWIxuH0uc6yy7VPSrLP8PnP4Hkywt8syYdADJI4LbDOrvJvDerm8bPfs+j98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754721987; c=relaxed/simple;
	bh=xzn6/O54Y6TcTzgZM5XOF8LO/951c2MkV8UeCpRSIUk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=otpv/PwUnImiIC5l9xuOS/EFvE56MyxCc+8OE0kKx8fIQuWMyELUULVauZYF7JitFbvyvkRv9ev8VOj3YfB3Gfl9CPRQpG8uMMV9iKwcheKNJvB2qQtbccYFT3/4LY3JS9/vAxqlesCadUGEawwENanVNzDIU4olweXpTk6aXfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tQ2B/xQJ; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3b7806a620cso1312962f8f.3
        for <linux-efi@vger.kernel.org>; Fri, 08 Aug 2025 23:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754721984; x=1755326784; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FCBZt4B3Kro3GVcUjAvV1eoRvGn+sQEtdirROwRw3TM=;
        b=tQ2B/xQJrCGTmTERsxMyFGBCdxKluefYYyEBv4YovShqNFpQTXN0x8j5MJMiGjv5c+
         yflr+WibVC7p78jO0+gZZbBsnAo3tpuBdOX0nd+nUKMc8N4baN5YfqU/6t7oxL91uf3b
         ZoEOsqDIsCxRxNx7XufiM8uSoY/RGmifLqdK17Cs6N3q4d5xDcKxQQLws4DySZYyJJP1
         NbPfUbqDtxjSa3U5RotyS23q8I8GA9OPt6wwAOqwnj6bUHax0XISq8RC8EZVSvhoAZDy
         vrmi5cRAe4Wty7lquIFPY/Q9YuQG7yYk5WhR0rILxPUzoAhE5vfgP1dhwaJcEyRX1elz
         Jayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754721984; x=1755326784;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FCBZt4B3Kro3GVcUjAvV1eoRvGn+sQEtdirROwRw3TM=;
        b=jgSXKaWnbFT5OFbxc39enxuagYy2o52iqU3zCs9rMbAJRIYpEeMd/wiNNkFm4J0r5z
         +U7RW/1n0+XxSqc+w/XjmNHkL1uOa9d9aGhSY20SFsg0OvbKkNJ7zHNLoXOzbw5bczSg
         9Uk3uoVX/q+vKH7akqxBqJVWTtJFe54n0aumaZYlrqv8q0yALw0e6EgwVFhJkLLOjGGM
         qtegXG4/7EGXYNzbsYVsxBkk/TB+Gayg+ixF6ZgH1JVM60PrJXd34QhQdRqmLzahmiC1
         Bbxytb+1mcKh3Gjtqzf/EjAOno+VTfvYLNDeJgY6mu7H2mNjidV7/EUr3oafR88qffJB
         5Z3A==
X-Gm-Message-State: AOJu0YzfOqC3969saYrVjwptMyNNY70mO1rPSHPctVVcYSPEEUYLB5e7
	Y3Ge0lFBTkVPMAs/5baUl5Fl6i8rIYnLpWQPkWNLjre+L0RdwvEqWDXMHtRaKGa5qp2r8sAhZg=
	=
X-Google-Smtp-Source: AGHT+IGrHCslrjUtbTNBfsuqguOapWEWIqoNyPIgJnhjdXGvqrmKohBwwxu7oelGciYWGnXv4QZ+2bpJ
X-Received: from wmbfa23.prod.google.com ([2002:a05:600c:5197:b0:458:c0cd:291c])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:3108:b0:3a3:67bb:8f3f
 with SMTP id ffacd0b85a97d-3b900b5743cmr4403967f8f.53.1754721984018; Fri, 08
 Aug 2025 23:46:24 -0700 (PDT)
Date: Fri,  8 Aug 2025 23:46:07 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1611; i=ardb@kernel.org;
 h=from:subject; bh=qIoHdfhGXFrXSiQ/+EzsWrMzwXFaU7SvRbdFb25K+4A=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIWPau426CR17jK9klzbbrn5h73XUMD3qf3mJO9tFFmmbW
 WwnTq/tKGVhEONikBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABP5cJqR4aLg/0+9y0IY9Q+I
 HXGrvnwgxdLo55pFE7aL7rq5kq/TtomRYen9E6U/vAsPVJoocyZ8vhx0+M5BzRdln1aeerzv/KW QYzwA
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250809064606.35568-2-ardb+git@google.com>
Subject: [GIT PULL] EFI updates for v6.17
From: Ard Biesheuvel <ardb+git@google.com>
To: torvalds@google.com
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Hi Linus,

Apologies for the late notice - I was on vacation and wasn't aware of your
condensed schedule until today.

Please consider pulling the changes below.


The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.17

for you to fetch changes up to 02eb7a8eee20b9ec6aafd5e17c5c41b53e8b13ef:

  efi: add API doc entry for ovmf_debug_log (2025-07-15 04:15:30 +0200)

----------------------------------------------------------------
EFI updates for v6.17

- Expose the OVMF firmware debug log via sysfs

- Lower the default log level for the EFI stub to avoid corrupting any
  splash screens with unimportant diagnostic output

----------------------------------------------------------------
Aaron Kling (1):
      efistub: Lower default log level

Gerd Hoffmann (2):
      efi: add ovmf debug log driver
      efi: add API doc entry for ovmf_debug_log

 Documentation/ABI/testing/sysfs-firmware-efi |   7 ++
 drivers/firmware/efi/Kconfig                 |   8 ++
 drivers/firmware/efi/Makefile                |   1 +
 drivers/firmware/efi/efi.c                   |   8 ++
 drivers/firmware/efi/libstub/printk.c        |   4 +-
 drivers/firmware/efi/ovmf-debug-log.c        | 111 +++++++++++++++++++++++++++
 include/linux/efi.h                          |   4 +
 7 files changed, 141 insertions(+), 2 deletions(-)
 create mode 100644 drivers/firmware/efi/ovmf-debug-log.c

