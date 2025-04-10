Return-Path: <linux-efi+bounces-3265-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D53A9A84520
	for <lists+linux-efi@lfdr.de>; Thu, 10 Apr 2025 15:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE0B37A73E7
	for <lists+linux-efi@lfdr.de>; Thu, 10 Apr 2025 13:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4A928CF58;
	Thu, 10 Apr 2025 13:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bHEGPwDo"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E19A28C5C9
	for <linux-efi@vger.kernel.org>; Thu, 10 Apr 2025 13:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744292514; cv=none; b=ICzGs+KySi5cbRdfO2NiHGGOhUxVPXzhSxFBQkdKpnvhPIZbxf/FdM6VNcjdgS+jvOsaoc+te9KvfMug6h8ynYA9Mz1jJWE0qrqJZLqulP/efHoygpJWYeRnE3oQ0d88S24lIWfaROLVIFkKXT6o81HtdFD5W+1gXCiq8ZYdRns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744292514; c=relaxed/simple;
	bh=rGZMX0G8lRLt0dY4UTfyPAeFNjieLVMC1P9MjIC1z4k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QKTPkfS+VRZkvwzyvWW/lMqK8E/JRLq8F4/dDOMRCclEqAmzxwfxUJG2s5rKji2MpOor0kq9OBF/m/1APTwk1Uv4OV7Or539co+2zaEOkGUwXG5cLMMYi5yTjmrEw//5bTJ4qSBnH0eDl068EJrhKjnoSyZuOBBD1S5P99BXn08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bHEGPwDo; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-391315098b2so353669f8f.2
        for <linux-efi@vger.kernel.org>; Thu, 10 Apr 2025 06:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744292510; x=1744897310; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ut3DF7cdGnYGcsB+1y8GBrdozOKwjcN3MDn2MzZHkLM=;
        b=bHEGPwDoo3kYs7xiBXTKO01dFpfFevD/s6ceH2tldTcQV/ICyoHnnMvQPMWGNTM4Vt
         /u0Hc8femlmQO12vFdMNEtNu7S9giSQn8EQL0t8eetKAtSDlhb4NVu27/gpYlspwXxUH
         GDusrHSDY5ICE1YbaNwN9feVATQLlrkxCwVjdKkukEXC2iQ7jVwO/2/6r7e6z637pX8b
         jldWi2ybsKGYZl47UNHOZOlpAQqOgyvUf7lIsoyVnKJik/isBGg3wu6cOuyjN15HFJIJ
         50OLMjYfIQAd8TGEpfQQd3/LISi4vvp2+tG1svOlqUhxMEkwK7pA0whsD4QA4Ycgmm5t
         cSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744292510; x=1744897310;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ut3DF7cdGnYGcsB+1y8GBrdozOKwjcN3MDn2MzZHkLM=;
        b=WyX/qqlSUwTScdG+6RnbiSHyaKs62IGa0s6exwOT3M1giyAaxvMtoqhlvxQieXbOe2
         TcuR4o4n4m/oPPxcx+Qym9L28dc31nDrBz0PGhdhsdouYEnI909iMDoCrKYzsROajm6L
         awW4yPwZ2JIeOjjKy6r25QToVRmQTnhJfuER0J7/LPalfX9VPHUUng/2Ax/m4RdWlUJ6
         GrDxpmDpYr/KratdTFBia7FC49gSghWcp0+hf1at/jFm7uZTjckCLk1OArQIh4qT21lt
         jhQlM1C3mdTqDla5aJ1+ZP/5iaPtJNM6FEHsYDRzy5Fmccj3ws/AGcQsUgvkbdwI36hV
         AVug==
X-Gm-Message-State: AOJu0YzGvLpf6nQqDn3liypZh94pyPM62P4rGJxwQ8GYZ9TyW0pcaSFS
	ED5mgaEJeO5RWb9+dxsN6A/55bt9rsLeemJ5AoovyTYn4HmlQvoB3o2Fw7h9iz704oo0qnn/KRw
	m0GY36r+MIUHHcHOTRPbTn3YNyLFVHeOfLdTE+FKHSsptisNBQcPgk1m/CK/0rBI1Xaw5jmjp2u
	mKa2TVwcpLgzqBS9iUwYrDVLAiww==
X-Google-Smtp-Source: AGHT+IE4m6fPKqx/35XmbrFlcOeYZO9KrixDd7VjHDR0y2s4p9wZTI76FsNpYTfEVOGWOh1JL4I+B4WW
X-Received: from wmbgx3.prod.google.com ([2002:a05:600c:8583:b0:43d:48c5:64a2])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:248a:b0:39d:724f:a8cd
 with SMTP id ffacd0b85a97d-39d8f4993d5mr2529023f8f.35.1744292510373; Thu, 10
 Apr 2025 06:41:50 -0700 (PDT)
Date: Thu, 10 Apr 2025 15:41:23 +0200
In-Reply-To: <20250410134117.3713574-13-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250410134117.3713574-13-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3139; i=ardb@kernel.org;
 h=from:subject; bh=1OMnBnM3B5uy1EYv4XyX2QqLee71wb5xFGUqQq+IsUU=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf37qTbnjFluV2qrldV1vde/X/1KYO3nsp1yTdMyjm3QP
 vPWOYeho5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzkywJGhuvBnsdjV3w5vvnH
 OivuuDnN8bn3XLa+VD8vqSyx96O2vDYjw8SF97e8VRB3Xb4tx/qV6ub1+gv8m8TuH7RhjJv6xeU oAysA
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250410134117.3713574-18-ardb+git@google.com>
Subject: [PATCH v4 05/11] x86/boot: Move early SME init code into startup/
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: x86@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Move the SME initialization code, which runs from the 1:1 mapping of
memory as it operates on the kernel virtual mapping, into the new
sub-directory arch/x86/boot/startup/ where all startup code will reside
that needs to tolerate executing from the 1:1 mapping.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/startup/Makefile                             | 1 +
 arch/x86/{mm/mem_encrypt_identity.c => boot/startup/sme.c} | 2 --
 arch/x86/mm/Makefile                                       | 6 ------
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index 10319aee666b..ccdfc42a4d59 100644
--- a/arch/x86/boot/startup/Makefile
+++ b/arch/x86/boot/startup/Makefile
@@ -16,6 +16,7 @@ UBSAN_SANITIZE	:= n
 KCOV_INSTRUMENT	:= n
 
 obj-$(CONFIG_X86_64)		+= gdt_idt.o map_kernel.o
+obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= sme.o
 
 lib-$(CONFIG_X86_64)		+= la57toggle.o
 lib-$(CONFIG_EFI_MIXED)		+= efi-mixed.o
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/boot/startup/sme.c
similarity index 99%
rename from arch/x86/mm/mem_encrypt_identity.c
rename to arch/x86/boot/startup/sme.c
index e7fb3779b35f..23d10cda5b58 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/boot/startup/sme.c
@@ -45,8 +45,6 @@
 #include <asm/coco.h>
 #include <asm/sev.h>
 
-#include "mm_internal.h"
-
 #define PGD_FLAGS		_KERNPG_TABLE_NOENC
 #define P4D_FLAGS		_KERNPG_TABLE_NOENC
 #define PUD_FLAGS		_KERNPG_TABLE_NOENC
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 32035d5be5a0..3faa60f13a61 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -3,12 +3,10 @@
 KCOV_INSTRUMENT_tlb.o			:= n
 KCOV_INSTRUMENT_mem_encrypt.o		:= n
 KCOV_INSTRUMENT_mem_encrypt_amd.o	:= n
-KCOV_INSTRUMENT_mem_encrypt_identity.o	:= n
 KCOV_INSTRUMENT_pgprot.o		:= n
 
 KASAN_SANITIZE_mem_encrypt.o		:= n
 KASAN_SANITIZE_mem_encrypt_amd.o	:= n
-KASAN_SANITIZE_mem_encrypt_identity.o	:= n
 KASAN_SANITIZE_pgprot.o		:= n
 
 # Disable KCSAN entirely, because otherwise we get warnings that some functions
@@ -16,12 +14,10 @@ KASAN_SANITIZE_pgprot.o		:= n
 KCSAN_SANITIZE := n
 # Avoid recursion by not calling KMSAN hooks for CEA code.
 KMSAN_SANITIZE_cpu_entry_area.o := n
-KMSAN_SANITIZE_mem_encrypt_identity.o := n
 
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_mem_encrypt.o		= -pg
 CFLAGS_REMOVE_mem_encrypt_amd.o		= -pg
-CFLAGS_REMOVE_mem_encrypt_identity.o	= -pg
 CFLAGS_REMOVE_pgprot.o			= -pg
 endif
 
@@ -32,7 +28,6 @@ obj-y				+= pat/
 
 # Make sure __phys_addr has no stackprotector
 CFLAGS_physaddr.o		:= -fno-stack-protector
-CFLAGS_mem_encrypt_identity.o	:= -fno-stack-protector
 
 CFLAGS_fault.o := -I $(src)/../include/asm/trace
 
@@ -63,5 +58,4 @@ obj-$(CONFIG_MITIGATION_PAGE_TABLE_ISOLATION)	+= pti.o
 obj-$(CONFIG_X86_MEM_ENCRYPT)	+= mem_encrypt.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_amd.o
 
-obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_identity.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_boot.o
-- 
2.49.0.504.g3bcea36a83-goog


