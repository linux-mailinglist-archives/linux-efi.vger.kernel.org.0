Return-Path: <linux-efi+bounces-2539-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A9FA0644D
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jan 2025 19:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FE4F18898BB
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jan 2025 18:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DC21F37C1;
	Wed,  8 Jan 2025 18:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GFe7vx6a"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0191FF7BE
	for <linux-efi@vger.kernel.org>; Wed,  8 Jan 2025 18:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736360578; cv=none; b=cm/Kkg9rsInjWMdIjruMOuk9+jQy0PrXeHkCe/BmcO9nm6hz/Hc2ogoB7tbyRY8J57Y/rfGxswEi4GAttB0cXcEKSLLLSTxjU2h9GyUqzGw2WS84cywNYs5FfByYEScwEMjmEZp6IHBuhGxoTnGDloKAHgDw1lyNgtXfKPYbbj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736360578; c=relaxed/simple;
	bh=5aZsSKDqucBQ6tFp0pxoZMte3MmpDtZA7VB/THD1IXs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TZh872ByAGxn1+wAm0IEhSG0Hj4yzZ009VvFtrLZKzXMyYQfQypxb+rdCBldiWfWyJg6uY1HGQ7/LmktLFQZ7voA/L2Dq59WDDIpUh6rMc/1tM+DiOR29mdmaypeg8A96+mhMwXFTaeGTj3wQL2cziLE77/pnGiw1vMje4XFz68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GFe7vx6a; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43621907030so988845e9.1
        for <linux-efi@vger.kernel.org>; Wed, 08 Jan 2025 10:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736360575; x=1736965375; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a7cVtdq5SKa/m4ejGzp2zpEWpp87o08TE6jwR8+FTF8=;
        b=GFe7vx6avnh0uOq/pS+/wAh2TkLTL85+m8H9a5D+wQNKbHxGbv+g8oha7foEMG4zDS
         iGlekzGfHgnTE1VTyLttB8aYQe0KxvFZTIrRLG7P1MqaXUT6UXr4en5gHgVJysPMBGuU
         mW8lmLBxKNli4ZthrysBq79pVVljWwrPntkmHhxs5HEv0Ombo2jvrM/WhXT/lyZqzc9Z
         8+QcscNGapcuDGaSAd3TCFAMv3u4NsSdUbkv3hKSFZv6TPO6L7xLRJePWv3EEWUTvKln
         Xz/XkEoO30N/U21VenqU4Ry8roK6wrtnxC5jjcRqvJKWxS7U9vQPpb5WbXWdBpJxEhux
         G1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736360575; x=1736965375;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a7cVtdq5SKa/m4ejGzp2zpEWpp87o08TE6jwR8+FTF8=;
        b=msqVLbT6AU/uEkwLgYJpKXCJGNFCd/LaYqpO0i8Lm5JbEljbsoRcFYZAOXvTGvMg+/
         VJ6QRWYY50JdUP2h1M3wkjsgzHTnmuhJbrXmokUZN/ZdhYqgahPCQbwkO9HLrsVjEGwE
         e4NYoWalA5Ya8IlGj9QI7snXMyAgvgIL/LHTK0eknmRcuev/XXzE63PuxN8PGbB8HRrT
         x573nF6MEhskWDAWZE2YGKfm52GXIjsMJhrl7aVDV1abIMVcra1AN3wHG1KWsErHAJCc
         dQQulgn4XyKnfAAYUvkuQ0tfVeBdQey4T5KpJd9bKRGTFvTuNJH3cd9Tg+r0E9H0SOmI
         CV8g==
X-Gm-Message-State: AOJu0YxNZP71zOB5s9WyHjoYHkiKhK5HOdlUqTQlNGkKa4SV4+bxzm2V
	LsZ7/fBASYPlUaCraQXEKIOLvu5Nr36ve8GLznzzcu6rmtPskcb0YAZYX0ZAZ8K66fDNDgdgZEF
	rOKbsdRrwviXxCCd4kd7rI/CazULOJ45NkT7bFHc12Cjm2TkwfwDne2I2Jmk6eJp3h5PeLLj0sa
	8KUzxhPA57uV+yoo9UtfFGF4mI2Q==
X-Google-Smtp-Source: AGHT+IEsbHg1DvvUyMgsdAz+afibrxWfkaiRXKvHW83Gd38cBmoNRQuFKDRc6S9YmcjoiQy/SaVyLC+Z
X-Received: from wmbbd18.prod.google.com ([2002:a05:600c:1f12:b0:436:1796:9989])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:1ace:b0:38a:4184:152a
 with SMTP id ffacd0b85a97d-38a87314dabmr3424920f8f.28.1736360575044; Wed, 08
 Jan 2025 10:22:55 -0800 (PST)
Date: Wed,  8 Jan 2025 19:22:25 +0100
In-Reply-To: <20250108182218.1453754-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250108182218.1453754-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2573; i=ardb@kernel.org;
 h=from:subject; bh=HpiQLIH+SBXUhj6Ia655frB2mrG7GycBSMSfn8QP/Dk=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIb3uUPKFdR/nHFkX5OFxRefdmQtcd+dqbwxTOrs44dKNt
 1LnclQedJSyMIhxMMiKKbIIzP77bufpiVK1zrNkYeawMoEMYeDiFICJ8Lgw/Hdb08exUv9duYxD
 KX/y3SKdGE735yVJGxXnlU0J6n1e5cXIMD9MTumYrrjGoh0Vanz5YQbzZ16P3TPHeEdk096bCy5 o8AIA
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250108182218.1453754-14-ardb+git@google.com>
Subject: [PATCH 6/6] x86/efi/mixed: Move mixed mode startup code into libstub
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: x86@kernel.org, kees@kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The EFI mixed mode code has been decoupled from the legacy decompressor,
in order to be able to reuse it with generic EFI zboot images for x86.

Move the source file into the libstub source directory to facilitate
this.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/Makefile                                                | 1 -
 drivers/firmware/efi/libstub/Makefile                                            | 3 +++
 arch/x86/boot/compressed/efi_mixed.S => drivers/firmware/efi/libstub/x86-mixed.S | 0
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index f2051644de94..fc5563704466 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -104,7 +104,6 @@ vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o $(obj)/tdcall.o $(obj)/td
 vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/mem.o
 
 vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
-vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
 vmlinux-libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 
 $(obj)/vmlinux: $(vmlinux-objs-y) $(vmlinux-libs-y) FORCE
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index e04285a7a6b9..f8cbd4557131 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -62,6 +62,8 @@ KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO), $(KBUILD_CFLAGS))
 # `-fdata-sections` flag from KBUILD_CFLAGS_KERNEL
 KBUILD_CFLAGS_KERNEL := $(filter-out -fdata-sections, $(KBUILD_CFLAGS_KERNEL))
 
+KBUILD_AFLAGS			:= $(KBUILD_CFLAGS) -D__ASSEMBLY__
+
 lib-y				:= efi-stub-helper.o gop.o secureboot.o tpm.o \
 				   file.o mem.o random.o randomalloc.o pci.o \
 				   skip_spaces.o lib-cmdline.o lib-ctype.o \
@@ -83,6 +85,7 @@ lib-$(CONFIG_EFI_GENERIC_STUB)	+= efi-stub.o string.o intrinsics.o systable.o \
 lib-$(CONFIG_ARM)		+= arm32-stub.o
 lib-$(CONFIG_ARM64)		+= kaslr.o arm64.o arm64-stub.o smbios.o
 lib-$(CONFIG_X86)		+= x86-stub.o smbios.o
+lib-$(CONFIG_EFI_MIXED)		+= x86-mixed.o
 lib-$(CONFIG_X86_64)		+= x86-5lvl.o
 lib-$(CONFIG_RISCV)		+= kaslr.o riscv.o riscv-stub.o
 lib-$(CONFIG_LOONGARCH)		+= loongarch.o loongarch-stub.o
diff --git a/arch/x86/boot/compressed/efi_mixed.S b/drivers/firmware/efi/libstub/x86-mixed.S
similarity index 100%
rename from arch/x86/boot/compressed/efi_mixed.S
rename to drivers/firmware/efi/libstub/x86-mixed.S
-- 
2.47.1.613.gc27f4b7a9f-goog


