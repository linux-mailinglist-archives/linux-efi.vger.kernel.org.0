Return-Path: <linux-efi+bounces-2388-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED24F9F695D
	for <lists+linux-efi@lfdr.de>; Wed, 18 Dec 2024 16:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54E47173614
	for <lists+linux-efi@lfdr.de>; Wed, 18 Dec 2024 15:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE20D15A856;
	Wed, 18 Dec 2024 15:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pNeOr8h8"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EE31B425F
	for <linux-efi@vger.kernel.org>; Wed, 18 Dec 2024 15:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734534213; cv=none; b=OFncfadsBDQ3+RgtniKEqkq9hj/4aHf1LSBHUQm54IC9PDNL8kKK+o3XEzQiIKJP5RUZmD1NgqHMhGgLZK3X1DCN1470Utu7RaQMsEGJLEFGIeNhWTxGtYiEUkZnJENyfjh5f15DWvt1cc7Y5HJwzAzs0VBDzJwfWzZUwb+N+nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734534213; c=relaxed/simple;
	bh=Rk0QtTruAwAflFsgbLLu8AWzj3irtnqOHLDiMbqKHSc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=c77gprcvGbp4A6thWJgLoHsfd0xq6gZ4n48Y2av3HB/1MIIMsFfqqo/ggc/ay7kh+tVbr5aV4uNebWwbgqKJ+5V5VjyjtrNtdfHfiMQDsfGgcY1aIcqkLfxnhbhguxpbW0uDfoX7nTI7EKpOEBQiqx69gpx8f08pvihxwPIdtTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pNeOr8h8; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4359206e1e4so58797735e9.2
        for <linux-efi@vger.kernel.org>; Wed, 18 Dec 2024 07:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734534210; x=1735139010; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rVcp1oHkCcDWpG9Aq4UIIvov9y5VFsij/UL30Q4m8Ec=;
        b=pNeOr8h8Jk/gcGg983shcrY2LlMIpjY/yklirgPoyoEpJhMt69T9A6kMjxizIUQTVo
         WiJhZqDlhqbLsUpEqbAnKjoghPuP+Ez0+e+NLEkyKphCpALh2HIDK+VyJxl0JlFQqy/H
         Tz7PeamHyS3KUylG24d8eW74jh95lhxvg2KmyIRMOuVUy1XBgkIKimq9EymgRg51AcDr
         DX4SWn4pclomMt6dXCNgxjgiDBycL75Fa4qMv7HNU8LRCfZe+NLuwyPx1A+9fybKi4m2
         SBLsBqi0mZGK/D7GQGa0lphiF+qyJQzJNjkZQltgekIVrvHGhINbV5i6mJcKHrO4MG5n
         O0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734534210; x=1735139010;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rVcp1oHkCcDWpG9Aq4UIIvov9y5VFsij/UL30Q4m8Ec=;
        b=wZ17m4JCcjJ7j8EraGgixmSK2Lu32OQCu4uw6sitrSixWYYtQbPetgd8NOKO5RcM2l
         1/3GApvhq9hYdNmO50IqhfINlkx08B9GPY45guLTgT1widBwH4TrOFthlUtus2GQKcCV
         jvGtkcsT7acAAezuhZkYmFGotHjvn2ws7RysHiv2Q2zpcMGiMz0w0nAZZmGdxTg7H4Xs
         7V7IE2F2xyV6acuBuBsfCBhsP4LJXnE4jY62e7w84yKugLiYwutjcTlcF7t651fIxsmA
         rG4CzKw7i1BtBYILgvKjadByukYFAk+jQcpQn3rjrbQ3tPtwN1GXIY4VRjsAQXqIQKXA
         7Wxw==
X-Gm-Message-State: AOJu0YwBIML1DObbJUzBi72d3utpsDU0a6Q91jz/vgkf2913t6RKjCb5
	zWma2KJ28QXEF166lVr4I5R/QDyChCu0MuXT8GYN0Eh24QU5Ti6arALQD5YPKbX//WkLWRQEoJA
	Pn4yHMU+rvQ7vn5xR26hJSPZl17niauPaJLv33ZyYpDosEmZFYL+ZzLraRCGnDR2NPd4Ka2zyCs
	M9TDfrq8H3PKGc3D4wPS5PWOogNg==
X-Google-Smtp-Source: AGHT+IGWsGWcxZHJnvXslFjLYpyURyqDaE8uGuJe7k1d/9fkb51dJqCMMguaLaPwo+rRzpPANYTenzX0
X-Received: from wmbfl12.prod.google.com ([2002:a05:600c:b8c:b0:434:a981:26f1])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:314a:b0:434:f817:4492
 with SMTP id 5b1f17b1804b1-436553ff1d2mr35459425e9.31.1734534210130; Wed, 18
 Dec 2024 07:03:30 -0800 (PST)
Date: Wed, 18 Dec 2024 16:03:16 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3608; i=ardb@kernel.org;
 h=from:subject; bh=4XaLAxzVU1FxRyY4c5Oy5iQnBRLNFASq0eG41Wifocs=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIT3picnFwscrpOv+rypXM7og9VPhRa8Io0WvqVOGQVN6I
 P+vqvSOUhYGMQ4GWTFFFoHZf9/tPD1RqtZ5lizMHFYmkCEMXJwCMJGDpQx/BU7a57S0z1Fe0p61
 StGJofXE3rAub0feS+9Y9iobW/8XY2RYJrBM+q+ovuyny6ZPn/HNvXrtXof7ZReGhpaZSvIZcR/ 4AQ==
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241218150316.1583806-6-ardb+git@google.com>
Subject: [RFC PATCH 0/4] efi/zboot: Encapsulate ELF image for arm64
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>, 
	Gerd Hoffmann <kraxel@redhat.com>, Pingfan Liu <piliu@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The EFI zboot image format was introduced to provide a way to distribute
an EFI bootable image for architectures such as arm64, RISC-V and
Loongarch supporting both compression and EFI secure boot signing.

To make this format easy to digest for other consumers than EFI firmware
(e.g., qemu or kexec), the file header describes the compression type
and the offset and size of the compressed image inside the file.
Additional metadata of the payload is currently injected using ELF
symbols (currently, the size of the executable image's code region on
arm64), but this information is not accessible to other consumers unless
it is exposed either via the header, or via the payload itself.

It would be better to have a structured format inside the container, so
that any annotation can be added without the need to tweak the EFI zboot
header layout. On x86, the legacy decompressor encapsulates an ELF
image, so that ELF notes can be used for arbitrary metadata, and this
is heavily used by Xen.

Let's implement something similar for the generic EFI zboot format. This
removes the need for per-arch hacks to inject symbols, and makes a
future alignment of EFI zboot with x86 more feasible as well.

So switch to the ELF format for the EFI zboot payload, but implement it
in such a way that decompressing the entire ELF image is unnecessary.
Instead, decompress the ELF file header and program headers first, and
discard any file data that is not covered by a PT_LOAD program header
(and therefore not part of the executable's memory image).

The latter approach permits EFI zboot to be used with unstripped ELF
binaries, making EFI zboot suitable for future use as a hybrid bootable
image and debug symbol library for the running kernel.

Cc: Jeremy Linton <jeremy.linton@arm.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Pingfan Liu <piliu@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Kees Cook <kees@kernel.org>

Ard Biesheuvel (4):
  efi/libstub: Avoid legacy decompressor zlib/zstd wrappers
  efi/zboot: Add support for ELF payloads
  arm64/boot: Populate vmlinux ELF program headers
  efi/arm64: Use ELF payload for EFI zboot

 arch/arm64/boot/Makefile                             |   4 -
 arch/arm64/include/asm/efi.h                         |   2 +-
 arch/arm64/kernel/image-vars.h                       |   4 -
 arch/arm64/kernel/vmlinux.lds.S                      |  33 ++--
 drivers/firmware/efi/libstub/Makefile                |   9 +-
 drivers/firmware/efi/libstub/Makefile.zboot          |   6 +
 drivers/firmware/efi/libstub/arm64-stub.c            |   2 +-
 drivers/firmware/efi/libstub/arm64.c                 |  20 +--
 drivers/firmware/efi/libstub/efistub.h               |   9 ++
 drivers/firmware/efi/libstub/zboot-decompress-gzip.c |  77 ++++++++++
 drivers/firmware/efi/libstub/zboot-decompress-zstd.c |  91 +++++++++++
 drivers/firmware/efi/libstub/zboot-decompress.c      | 161 ++++++++++++++++++++
 drivers/firmware/efi/libstub/zboot.c                 |  58 ++-----
 drivers/firmware/efi/libstub/zboot.lds               |   7 +-
 14 files changed, 391 insertions(+), 92 deletions(-)
 create mode 100644 drivers/firmware/efi/libstub/zboot-decompress-gzip.c
 create mode 100644 drivers/firmware/efi/libstub/zboot-decompress-zstd.c
 create mode 100644 drivers/firmware/efi/libstub/zboot-decompress.c


base-commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
-- 
2.47.1.613.gc27f4b7a9f-goog


