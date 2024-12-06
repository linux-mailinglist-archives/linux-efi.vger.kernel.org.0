Return-Path: <linux-efi+bounces-2309-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4C39E7001
	for <lists+linux-efi@lfdr.de>; Fri,  6 Dec 2024 15:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99DAF1880301
	for <lists+linux-efi@lfdr.de>; Fri,  6 Dec 2024 14:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326DB2066F0;
	Fri,  6 Dec 2024 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EKeoeUE1"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5352713A888
	for <linux-efi@vger.kernel.org>; Fri,  6 Dec 2024 14:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733495112; cv=none; b=Yv/cNqtG+XtuzST2RqLBow40iU0qG+ypnhkcqA2+UqQ/iqy7AVFppK25hGaHdwNoNEfPEMitNOv2ViGZGgtOeGFHCpH5T/m6DZKc7Wj1LiroBGvuWSQmVXQNOQFRatFFm0joIVMfpm38p9uZcTzx/3P/pYGAaBw3HWks9Mm8U6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733495112; c=relaxed/simple;
	bh=HR2qtBwja0LtWvxYsSCxU+WCQOz9Kjci5kokB2oN4fw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IKe6AbnTSdtPUPr2Q3vty0c3Sof3ivNAhOD2Lql+jHr/POJezUfay3MUMreOmzaBN3jdlCmsmzmPdIDePuUtrEaFxlRvAueDannZSkjmwCdhCwJIT5jZB8NBR63ZS5Aldg5MEwLEB1Zo9D+Zu1INoRcjVD1U8b1y2goStwNiBYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EKeoeUE1; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4349e97bfc4so19912925e9.3
        for <linux-efi@vger.kernel.org>; Fri, 06 Dec 2024 06:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733495108; x=1734099908; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rpzrNJUinx1Sx1XwKjpeU43IyCWUdoURuAMdRgCLZr8=;
        b=EKeoeUE1Fdp5xlEJmQyn4dAVgyW82jUNeEvGSJRzNAiM/tf8ZgS7aUJ1ovDcLBr7ag
         uArHC1ULtrU40sg4w+Vk+TJ8QXRVGUT8PlbE4tynClU3zE7bGhmIorDNQ5w4DsxEq6IY
         E/7XoRA5YqQmVD37JIQJNplcVSKvGluf2OAXR02CLJwcUVdPsKev4sFyGKNAOQqf+cQC
         HSzM7DLrBlr4OqSLI6sexm29iAhtKsvoP+a3mpyk4rwRtca8OM2NI/iKC0vrfVtfLxvJ
         tU4FEA9cznOVq/w3r0+LPPN4t4y29DLl13KpGeVL8RzOjVpx239UZumY1t/hqp+195zl
         cHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733495108; x=1734099908;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rpzrNJUinx1Sx1XwKjpeU43IyCWUdoURuAMdRgCLZr8=;
        b=mavcgfrgou2l0mlxeM62OP0DxDpOj49zuqaDnHNskrmELma+2RZ6BTQ5ICotTzyspr
         BJVMdwwkQQiZ0aVecry6UiPmVzpjLIXFn5JDbmf0WXuLTCl6IPOqKBspUz5n1d1WtAl4
         rbKHu5M3DpEMk+FjDoyLsFKw/SieBpige9gKAJNwXTi2XCFblu/bw/EBXf5rbpWSwZvl
         2h7cGU0zMwiMz+9WVJ56B1YzheyercRx1AdkespAYXuCd72zbDREqsrMY1nzBTmooHVo
         3MHhluBtUMoMWHmBPOUOdnl1jvjRUMbuhu40q9CHGGr49PTK/JZx+0AowtlET4lEIh6S
         gUWQ==
X-Gm-Message-State: AOJu0Yxt+UvMZxRbNONYnjF+8taqHC3zl7Wgvy9HQcczeF0d2/OxEhJV
	dyigatq3S2VoVcLHJS2UhPK0LQSDijbNmX5VEaCizvkG6HJdXhofpJpqaL9hqB8Egs/uqRD0u6R
	SxFGldl+RCmnBygou9dSKIviqg2uilPqC67UNK32jz9czRtEg73EAh/uIw2N/5uIaQ/U1ZeCNHp
	f+BDuOcTLHI6juwZ+YGEfYDMr9qw==
X-Google-Smtp-Source: AGHT+IH1R2JUL8u9qcNCc2mnUK2NvdxGNXdByO3Rtn1k/bFG6ynOFnpxRpL2BdPqGSTmR6qvTgEgjM1n
X-Received: from wmql5.prod.google.com ([2002:a05:600c:4f05:b0:434:9cfd:391e])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4684:b0:432:d735:cc71
 with SMTP id 5b1f17b1804b1-434dded7e52mr29695465e9.25.1733495108598; Fri, 06
 Dec 2024 06:25:08 -0800 (PST)
Date: Fri,  6 Dec 2024 15:25:00 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3379; i=ardb@kernel.org;
 h=from:subject; bh=pscVSVrf1YBtRv4xbRQzQ4A/gCRXOM3BML6aKJdzmJI=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIT2Y06ahT/Uvn8uCczPq2M58c5E9mX3gONvajOV5Nq+01
 tX/kdDrKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABNhWM7IsHuyWcHjnre/km6t
 kDjEv+JjYujkXVKFqTuvqf+4q64h08LIsPaS2yL1dzpX9S34w0XzT/+7o31ooerEUt81K5MumMb 4cgIA
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241206142459.3974886-2-ardb+git@google.com>
Subject: [PATCH] efi/zboot: Limit compression options to GZIP and ZSTD
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, Peter Jones <pjones@redhat.com>, 
	Pingfan Liu <piliu@redhat.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

For historical reasons, the legacy decompressor code on various
architectures supports 7 different compression types for the compressed
kernel image.

EFI zboot is not a compression library museum, and so the options can be
limited to what is likely to be useful in practice:

- GZIP is tried and tested, and is still one of the fastest at
  decompression time, although the compression ratio is not very high;
  moreover, Fedora is already shipping EFI zboot kernels for arm64 that
  use GZIP, and QEMU implements direct support for it when booting a
  kernel without firmware loaded;

- ZSTD has a very high compression ratio (although not the highest), and
  is almost as fast as GZIP at decompression time.

Reducing the number of options makes it less of a hassle for other
consumers of the EFI zboot format (such as QEMU today, and kexec in the
future) to support it transparently without having to carry 7 different
decompression libraries.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Peter Jones <pjones@redhat.com>
Cc: Pingfan Liu <piliu@redhat.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/Kconfig                |  4 ----
 drivers/firmware/efi/libstub/Makefile.zboot | 18 ++++++------------
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index e312d731f4a3..5fe61b9ab5f9 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -76,10 +76,6 @@ config EFI_ZBOOT
 	bool "Enable the generic EFI decompressor"
 	depends on EFI_GENERIC_STUB && !ARM
 	select HAVE_KERNEL_GZIP
-	select HAVE_KERNEL_LZ4
-	select HAVE_KERNEL_LZMA
-	select HAVE_KERNEL_LZO
-	select HAVE_KERNEL_XZ
 	select HAVE_KERNEL_ZSTD
 	help
 	  Create the bootable image as an EFI application that carries the
diff --git a/drivers/firmware/efi/libstub/Makefile.zboot b/drivers/firmware/efi/libstub/Makefile.zboot
index 65ffd0b760b2..48842b5c106b 100644
--- a/drivers/firmware/efi/libstub/Makefile.zboot
+++ b/drivers/firmware/efi/libstub/Makefile.zboot
@@ -12,22 +12,16 @@ quiet_cmd_copy_and_pad = PAD     $@
 $(obj)/vmlinux.bin: $(obj)/$(EFI_ZBOOT_PAYLOAD) FORCE
 	$(call if_changed,copy_and_pad)
 
-comp-type-$(CONFIG_KERNEL_GZIP)		:= gzip
-comp-type-$(CONFIG_KERNEL_LZ4)		:= lz4
-comp-type-$(CONFIG_KERNEL_LZMA)		:= lzma
-comp-type-$(CONFIG_KERNEL_LZO)		:= lzo
-comp-type-$(CONFIG_KERNEL_XZ)		:= xzkern
-comp-type-$(CONFIG_KERNEL_ZSTD)		:= zstd22
-
 # in GZIP, the appended le32 carrying the uncompressed size is part of the
 # format, but in other cases, we just append it at the end for convenience,
 # causing the original tools to complain when checking image integrity.
-# So disregard it when calculating the payload size in the zimage header.
-zboot-method-y                         := $(comp-type-y)_with_size
-zboot-size-len-y                       := 4
+comp-type-y				:= gzip
+zboot-method-y				:= gzip
+zboot-size-len-y			:= 0
 
-zboot-method-$(CONFIG_KERNEL_GZIP)     := gzip
-zboot-size-len-$(CONFIG_KERNEL_GZIP)   := 0
+comp-type-$(CONFIG_KERNEL_ZSTD)		:= zstd
+zboot-method-$(CONFIG_KERNEL_ZSTD)	:= zstd22_with_size
+zboot-size-len-$(CONFIG_KERNEL_ZSTD)	:= 4
 
 $(obj)/vmlinuz: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,$(zboot-method-y))
-- 
2.47.0.338.g60cca15819-goog


