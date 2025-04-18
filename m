Return-Path: <linux-efi+bounces-3369-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18323A93873
	for <lists+linux-efi@lfdr.de>; Fri, 18 Apr 2025 16:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A091F1B6453C
	for <lists+linux-efi@lfdr.de>; Fri, 18 Apr 2025 14:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C5019882B;
	Fri, 18 Apr 2025 14:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z4axJ8u2"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0979219259F
	for <linux-efi@vger.kernel.org>; Fri, 18 Apr 2025 14:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744985656; cv=none; b=bTtaRuQ/flLNrO+lAT3FyGLPKtzxxK5McpZrCdCRnW7FSyHHnCj+qJlMcEqtCA3sFgRiWdAz9pyZVsoRblfi5nSCMfen2InyMwL5fEYM/CdIzrFaPSHgWDLDt21ihgwtoJ0m3YtzvWJRUg948v4f2Euk4xFdjkjjQdyX3FW35/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744985656; c=relaxed/simple;
	bh=7KW1MA75CA/KauhN0nHPzECShpbQ3n1/ZA/5yvl3k1o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wo4Gn0DH9iDBUKBmBKBE9GGirDy5zKk9IoPPqLMDKGdMLUQPNFR3pcbpeTjIBpdAqpH9qe/jQGyRShRpon4x3taiMkJpINgsaBvwQsj/8SjKQl+Erqc8eTTUGhHS+J1dsSaVhkoBhkae4/Ju6jRUh2VK26CcfVBVvvfEmwvxgXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z4axJ8u2; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43f405810b4so9488885e9.1
        for <linux-efi@vger.kernel.org>; Fri, 18 Apr 2025 07:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744985653; x=1745590453; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zHhe4J2kf97grySB1dghcoGwgwMgdWDWarBIG3W8Zrs=;
        b=Z4axJ8u2+r/noJOjHDXs87luiU336OO6XJIC1HqDKAsQzVhTxfUrLBOC83QriYOKUt
         IdeRItHpKjzKnHdL0FAT+d4ArtH3e7DlMvqr9rXsUFFTBa4pkfR7aV2KTKhbhTryxqZu
         yyzAFlXPzcSv7IrXX/o3hrcMPyrsq/kyoSIZsjA3x2WwfVKH9WHslfL99uBTLBmexRsT
         3OPE43F/9LVBgId9Z57b6HsRMpNAU3EYJBJA8du//wXrynaozgGwZmmR5HDTqz6SwIH5
         Yr1G5QjqhEArBI2ps3P7EPZUvx/w2BwAQFGxTPYRidKfFn0+pSUNN1iekhQwJOm9fQfL
         AszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744985653; x=1745590453;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zHhe4J2kf97grySB1dghcoGwgwMgdWDWarBIG3W8Zrs=;
        b=iJrCS6drEtZ8yOEyTzXXcdNMJS0bCp1RuSdu66jsOhJ17qbUvIyqCzUavJC7N5Fhbb
         gtPPU1//sZUe+JTd7YoKIluojj9Mw45GHn57IE65CaXKyedC6qw1x/50n3A3WvomJ400
         2uRNyiZJqWtnbOEacexI6ZVO52AlqLo73WQsBvXi+XvKz6Kx6zFmsVgFlxOmzrRLa8GQ
         5U5uCRdqV1arzgA1Qs/wSS9dIRRY6Ocp3dn0oJA+NQzHOKEvTsgp+0pRdhZe0JaDC2HP
         bGlY5mLiV2aFYi/gxUxtd4arqjdcp8gf6jxahNSYTUZOlOZQdgf2Z2iSYRfopiCVPcge
         +iTQ==
X-Gm-Message-State: AOJu0YxlaXg5lnO9acgO83EWf+tLYsllYZJmGBPulCQWVE5Fq/SaWqz5
	HHD+GkGUD8X50GVqy8z2SUeHIdQr/w0i7DilnMVUHU0N5fxa9ey71QbdbIkg0x3Hle2n7g==
X-Google-Smtp-Source: AGHT+IH2fs985NL9syEJxmzfaYzLtkZ8+tgwTx0XfOUAbx2HPO9MARD8qBLS6xHwxCgPFrviPb5dIaP1
X-Received: from wmbes11.prod.google.com ([2002:a05:600c:810b:b0:440:5d4e:87])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1990:b0:43d:4e9:27ff
 with SMTP id 5b1f17b1804b1-4406ab679famr21119115e9.7.1744985653442; Fri, 18
 Apr 2025 07:14:13 -0700 (PDT)
Date: Fri, 18 Apr 2025 16:12:58 +0200
In-Reply-To: <20250418141253.2601348-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250418141253.2601348-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3498; i=ardb@kernel.org;
 h=from:subject; bh=bksQ60B3uxdkOeoY7TfN+ieztWUBJigc7E5EyOzeidw=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYMp9rXhoj0JLUvYM38Ua5euSBarYl3AJ8NUNun23fcVc
 Y0x/L4dpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCIndzD8lVz/XuL4i+JnG/7f
 T7+ZX8cy3aN1Cbf6m3LX0C1c7UGnuBj+JzCu4BcKKc4RZfYV6JxydaHuN+HGV56l13uP3+V09/P lBgA=
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250418141253.2601348-12-ardb+git@google.com>
Subject: [PATCH v5 4/6] x86/boot: Move SEV startup code into startup/
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, mingo@kernel.org, 
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
 arch/x86/coco/sev/Makefile                                  | 20 ++------------------
 5 files changed, 5 insertions(+), 21 deletions(-)

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
index bb7c826e586c..21d911b61459 100644
--- a/arch/x86/boot/startup/Makefile
+++ b/arch/x86/boot/startup/Makefile
@@ -17,7 +17,7 @@ UBSAN_SANITIZE	:= n
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
index 57e25f946663..2919dcfc4b02 100644
--- a/arch/x86/coco/sev/Makefile
+++ b/arch/x86/coco/sev/Makefile
@@ -1,25 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y += core.o sev-nmi.o startup.o
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
+obj-y += core.o sev-nmi.o
 
 # Clang 14 and older may fail to respect __no_sanitize_undefined when inlining
-UBSAN_SANITIZE		:= n
+UBSAN_SANITIZE_sev-nmi.o	:= n
 
 # GCC may fail to respect __no_sanitize_address when inlining
 KASAN_SANITIZE_sev-nmi.o	:= n
-- 
2.49.0.805.g082f7c87e0-goog


