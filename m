Return-Path: <linux-efi+bounces-3268-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F41FA84542
	for <lists+linux-efi@lfdr.de>; Thu, 10 Apr 2025 15:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF75A4E1480
	for <lists+linux-efi@lfdr.de>; Thu, 10 Apr 2025 13:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CC728A41B;
	Thu, 10 Apr 2025 13:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n1FqhGeL"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614DB28A41F
	for <linux-efi@vger.kernel.org>; Thu, 10 Apr 2025 13:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744292522; cv=none; b=gT2zTSXtcrzVN3zxR96Ip+u6D0b8ORwyHiy3+N1t3VGaofOGvjdTrr84cE4eFr/IxNXPNvjcv57jfXYUEcdcb7RQOBb2/HPy2apysrOxE9BYhSBfN4XyIZW1DzM96pGos0R1LRwq3Ko1PBlkCylS9QTSRT07iGT9X72DzfMRkJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744292522; c=relaxed/simple;
	bh=3RDY+InRbRGkZwpv/31rtaQafCmsuYt5wpq5FyYuVIo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fBaTdrUjK4JCvYSV/B3xcDWyhz+eWIyfdHMlB/MHtKiY5pJByeRRXfgYq9R79o0uiN4IHu6wwr3BI6iSRSI3CeiTwL6j1nNhJPruk0hRPl4ZJQxVOeX/X0xnRv3G+k9pm0f1S1Kj0Rx/QeRBLdyHG30k3Mino+zfakGWjkaJJMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n1FqhGeL; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43efa869b19so6361915e9.2
        for <linux-efi@vger.kernel.org>; Thu, 10 Apr 2025 06:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744292519; x=1744897319; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Yq2Udp4AIBfEdCHQPPm/mcMlKJxLC8HFZ/abGzZSPM=;
        b=n1FqhGeL1wkJ2opPaXf2P1r5lq1dURqO1pnbBelYGrzG60wGIx4ZAZzSGuuNXbP137
         cvstqzB1YmDjNtkZhjFwQzhZ1LmSHsVZXJ21VYgiMaaqANL3Cy2eIz2MQYV+O/eLhujE
         78HBgmiRhQSd9AZqWcE471JMVTbEtwYnU0pG78P1RxJzfAKT7WR07xcQqvHD5eK0Y/m/
         urcezOIXAtpvHEel52BxZsGcdmQLlDzzEtw1sLQb/CEKLc+IkAAgfJn5HVhIfcakA3Fq
         b5/D9O60/0PQrAOuecmORZYqWiHlBk3oXnpy4GnmCP5C3acZTyXuGhyIvFtUdpKwPxMi
         SH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744292519; x=1744897319;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Yq2Udp4AIBfEdCHQPPm/mcMlKJxLC8HFZ/abGzZSPM=;
        b=HX33tvs6D6NHUI05G9cEkYtPzLXJAtRINZYBjAkL1HXWsNfvDFIEhOQr36dl570tvI
         HFpIBPjb58t0ZDQMdTrYB779utOWjboy5dLjg85lX+3MuqwWT15gj8vqM3v1a48yQjZ1
         tlfES22VtQoLL1R3eHhA3bsgnrDoznbNFrwJWoreM2Tts3G+ZqiPN3RQq1RLCQKOo4EZ
         NsCmpVORS5Uu2dy28HwamZfMICoZbo2Uy0UhcqwNwCI9W1si6pf2sxsbW6I2At68u1c8
         yNnbOlLUC1FrdIYQL0PYT12O1nK6RnbnVN4vVZfalxtz3OVa4hMjpmxC8lkgLg8x8PPn
         95dw==
X-Gm-Message-State: AOJu0YxbXoYsTM6KKM4gVnbM4id4C43bi8RbPTi2p5eLlgenk9/vuyQ2
	dNCpscGYUwFbqN6CdUJZKpWssnb23co9lOjt9Kz/FydtvWDeCz7WvR3m9Nu+4BjEpR//scUfe9h
	GrMdRr7Tsuhm1crH6mTYBNEGQeiuFBzM/ktIJ0ZEyiu8LvD4H2hTWSP4mJugvBXiApH7yHAB+Kv
	NrbTHOSVr0HxMti03gn3N2cOr6qw==
X-Google-Smtp-Source: AGHT+IH5IZ4nLFaGoD4MuACElwJFU9aXPnUiWGgPaq1XTHhC2cKM31QzFF70nprkf6ZRYgrR6xmVXgVr
X-Received: from wmcn12.prod.google.com ([2002:a05:600c:c0cc:b0:43c:f60a:4c59])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1e13:b0:43c:e481:3353
 with SMTP id 5b1f17b1804b1-43f2d7f1b68mr32794315e9.17.1744292518802; Thu, 10
 Apr 2025 06:41:58 -0700 (PDT)
Date: Thu, 10 Apr 2025 15:41:27 +0200
In-Reply-To: <20250410134117.3713574-13-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250410134117.3713574-13-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3347; i=ardb@kernel.org;
 h=from:subject; bh=ZxH01yKh1YWsY6C3Y3GXCe7hCPc6xzGAIM8w8oIWNO0=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf37qV67Dyt0dPKafwRHms/cEjtZ1GTdBltth8sTJuusY
 C2IVl3RUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACairMrwh8+zpnrOPpvjyfue
 6Rkq7Zgf8aB5fcfPiSs+7Jt7J933ySFGhpmTdJn93AREKqN0D0uzM1a+XVT9ZtLnY/2l2S9Xr/g 9lx0A
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250410134117.3713574-22-ardb+git@google.com>
Subject: [PATCH v4 09/11] x86/boot: Move SEV startup code into startup/
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: x86@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Move the SEV startup code into arch/x86/boot/startup/, where it will
reside along with other code that executes extremely early, and
therefore needs to be built in a special manner.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/sev.c                              |  2 +-
 arch/x86/boot/startup/Makefile                              |  2 +-
 arch/x86/{coco/sev/shared.c => boot/startup/sev-shared.c}   |  0
 arch/x86/{coco/sev/startup.c => boot/startup/sev-startup.c} |  2 +-
 arch/x86/coco/sev/Makefile                                  | 21 +-------------------
 5 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 714e30c66eae..478c65149cf0 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -144,7 +144,7 @@ int svsm_perform_call_protocol(struct svsm_call *call);
 u8 snp_vmpl;
 
 /* Include code for early handlers */
-#include "../../coco/sev/shared.c"
+#include "../../boot/startup/sev-shared.c"
 
 int svsm_perform_call_protocol(struct svsm_call *call)
 {
diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index ccdfc42a4d59..b56facb9091a 100644
--- a/arch/x86/boot/startup/Makefile
+++ b/arch/x86/boot/startup/Makefile
@@ -16,7 +16,7 @@ UBSAN_SANITIZE	:= n
 KCOV_INSTRUMENT	:= n
 
 obj-$(CONFIG_X86_64)		+= gdt_idt.o map_kernel.o
-obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= sme.o
+obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= sme.o sev-startup.o
 
 lib-$(CONFIG_X86_64)		+= la57toggle.o
 lib-$(CONFIG_EFI_MIXED)		+= efi-mixed.o
diff --git a/arch/x86/coco/sev/shared.c b/arch/x86/boot/startup/sev-shared.c
similarity index 100%
rename from arch/x86/coco/sev/shared.c
rename to arch/x86/boot/startup/sev-shared.c
diff --git a/arch/x86/coco/sev/startup.c b/arch/x86/boot/startup/sev-startup.c
similarity index 99%
rename from arch/x86/coco/sev/startup.c
rename to arch/x86/boot/startup/sev-startup.c
index 9f5dc70cfb44..10b636009d1c 100644
--- a/arch/x86/coco/sev/startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -422,7 +422,7 @@ static __always_inline void vc_forward_exception(struct es_em_ctxt *ctxt)
 }
 
 /* Include code shared with pre-decompression boot stage */
-#include "shared.c"
+#include "sev-shared.c"
 
 noinstr void __sev_put_ghcb(struct ghcb_state *state)
 {
diff --git a/arch/x86/coco/sev/Makefile b/arch/x86/coco/sev/Makefile
index 7d7d2aee62f0..b89ba3fba343 100644
--- a/arch/x86/coco/sev/Makefile
+++ b/arch/x86/coco/sev/Makefile
@@ -1,22 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y += core.o startup.o
-
-# jump tables are emitted using absolute references in non-PIC code
-# so they cannot be used in the early SEV startup code
-CFLAGS_startup.o += -fno-jump-tables
-
-ifdef CONFIG_FUNCTION_TRACER
-CFLAGS_REMOVE_startup.o = -pg
-endif
-
-KASAN_SANITIZE_startup.o	:= n
-KMSAN_SANITIZE_startup.o	:= n
-KCOV_INSTRUMENT_startup.o	:= n
-
-# With some compiler versions the generated code results in boot hangs, caused
-# by several compilation units. To be safe, disable all instrumentation.
-KCSAN_SANITIZE		:= n
-
-# Clang 14 and older may fail to respect __no_sanitize_undefined when inlining
-UBSAN_SANITIZE		:= n
+obj-y += core.o
-- 
2.49.0.504.g3bcea36a83-goog


