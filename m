Return-Path: <linux-efi+bounces-2783-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A30CEA2F5DD
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2025 18:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A41C16796A
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2025 17:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4E325B66B;
	Mon, 10 Feb 2025 17:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JZoLnnnu"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FAD25742F
	for <linux-efi@vger.kernel.org>; Mon, 10 Feb 2025 17:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209818; cv=none; b=RphUEE9cKa2doFPYvVqIY9Ma3YqRjobw+DZleYyzINYfb6UoZV+ABUDb8kcBXx4jEMXJXxyArZ6kmp/7ujAvEILeM7K+5WAQlG27u2brAglP5vzCRuj7Xmg3Syh2kB7G1atCllqL1sBvGwafylUk9kverEz+bqzLEavNJs7y/VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209818; c=relaxed/simple;
	bh=b5Y7ZBwua8q6S8xoX8bJWja8rSBdbaXg1go2fucz19o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KJn8FMCHN5Xd5/ij3aHifXVgu8bIrAGUa6cIKuptf7KodvurwnVESS3AYeE7+r4+TvBH+17PqDMMcodqw+0iDoPK+hVPZCCNxxTzcBKj1dYOGzDUhAXlOCB8SBreke89CfTxgWyU1YCwQmCoWQrnZ/Ft4n2O2wv9B3TdTdtRgPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JZoLnnnu; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-38ddba9814bso682575f8f.3
        for <linux-efi@vger.kernel.org>; Mon, 10 Feb 2025 09:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739209815; x=1739814615; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2tIHDOPF0PNls1nT25rio5qx/bjBew1n2yApk83FuUI=;
        b=JZoLnnnuc1RB97KG6XplP2Rn0PPRj2d1gHHMA337tl2VduP9TZbVUUMqIdxNxCvnJX
         Elg9ABrpMGDZD4A5vV5h7jrAYQsnkhJCzC/matektP1++y9lzA+85icjRoGzS0y1XnBk
         zUt/96acAa7dW4j+o7G2DnguflAxELymuc6+n0bcnzwwFIOu3HthfgmAJn6j7p5a/1rj
         J/M8CrBe3MrKRMhdV05w6GMT/Nc5uuTCyD31+zu5atB/xSjuz24CwvyJ02yx6kZI4NNO
         12OjpgAcLSam2T3cxgT9BZU1WhU1ARg8nmERIbSOuTNDLs//pwKn65ot/2HSlAUFhGy9
         eW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739209815; x=1739814615;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2tIHDOPF0PNls1nT25rio5qx/bjBew1n2yApk83FuUI=;
        b=G46A7yxAEUlqkxwsad3tzg0xB0vmK+JED83E3ePR1///yQVAvBkWQT4YsCW8ZcXwlY
         FMijz28QDu+NW4bW1vN+58m+vRcFY24aw3J19mkK4gzDRQ2wr7JfUYyh/v/N2hGJQexp
         px5Cjmw2zmot8JgkM0eR+Pu16Ww5ViCIeIkzjr2hNwhmTbec9dTS6NIrQ0U9t2D9B8if
         63phwwVXuz3tHxqaN2mlSC4H84eNE3oF+nQTp+m3fnkwXVcppn5fhICZFTITnoXyG3TJ
         +PCS7sBDK8M2KAM+KqUlqz7dh1wYj9SuubaTwu8TzcJEMCfRNakG3pynn41Hrcb6yus9
         n2Rw==
X-Gm-Message-State: AOJu0YyQcAXCHBOEswpeWD8iBcrrTzj5NYuogv2rtLZyNkdVC7nu3InG
	U9hN5/Diuc+hzJfMKZQIduf5fQ8U5gm4XzHe+ybbzHn5fD6Q86XEzitF98JHK0/RC8LNh95UDTX
	7AHBsHm+q9DhnfzuSkqf/9j7AXom+SpikGHUzyfrlFGyjqNoC2ryqdK/gxD/04V7dKG5fM7pAqY
	1Tn8M1umlzjoVc2jEtuglUVTLzoQ==
X-Google-Smtp-Source: AGHT+IHAUj/EzxRvKtgJ7QJN3LKDxgNe/A0xr0/YERyNf+9C200o4bBPmgSHauUpcJYocmkxvKfPsVKl
X-Received: from wmqd4.prod.google.com ([2002:a05:600c:34c4:b0:439:4c13:57e5])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:1883:b0:385:f7ef:a57f
 with SMTP id ffacd0b85a97d-38dc9233968mr11826038f8f.27.1739209814970; Mon, 10
 Feb 2025 09:50:14 -0800 (PST)
Date: Mon, 10 Feb 2025 18:49:49 +0100
In-Reply-To: <20250210174941.3251435-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250210174941.3251435-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2573; i=ardb@kernel.org;
 h=from:subject; bh=f8GMXZVc+ZgqfzipyO2wKCTDym84g0qfwV9FVQOEoyI=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIX2VjfW5siSre++kNEo+q6+8viNWfFN8/+R3PvYS7nNvr
 55w3Um7o5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEyk6wQjw1olLrm/vxfb6H+u
 kegTlJXMky4WvijZf2PV6t8O07gijzEyNF955r9ATrrvxU37RbOPae2Ovuw9wf0A88JtW90XOB7 ZywIA
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250210174941.3251435-16-ardb+git@google.com>
Subject: [PATCH v2 7/7] x86/efi/mixed: Move mixed mode startup code into libstub
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, hdegoede@redhat.com, 
	Ard Biesheuvel <ardb@kernel.org>
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
index 1141cd06011f..903afd2d3d58 100644
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
2.48.1.362.g079036d154-goog


