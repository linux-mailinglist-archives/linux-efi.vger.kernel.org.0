Return-Path: <linux-efi+bounces-4452-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D22B0D33D
	for <lists+linux-efi@lfdr.de>; Tue, 22 Jul 2025 09:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFC901885562
	for <lists+linux-efi@lfdr.de>; Tue, 22 Jul 2025 07:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435A92E11AD;
	Tue, 22 Jul 2025 07:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="noD/b8ju"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B612A2E041D
	for <linux-efi@vger.kernel.org>; Tue, 22 Jul 2025 07:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169410; cv=none; b=clIm0LkFXhPIpXJAAOvcRumG8fFLmp1Ag0qYqgDKMuy8vkUICNL1F/VHPuAm63oHAHdMj0k5oFJqvkJFSA/8ngQrT2r7iHcNeKb6qhr8Ae+cziBL45Q19lP9h3KUCTeJFJoz5ynfU/HB7HPh7Uluc/+VjyOfaVEGFzLMfiZroCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169410; c=relaxed/simple;
	bh=L0nuKM1iOS5J1LrRXwl6oFJ2k3UoNAHOTrQqnHSBepc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Lb9fRR2ke8EaQmpVMiC0C97/PaCGSbsWQB8okYC+KPEJ54XB/pXPNhV7w5tFNSvCGV8CfX5I7245/N7HGkNh+MLiFSzoKWBLG/MrJwjp3eYSmsuaqSk/ttwTlmRmqcvizQDb+r3whaqCQQTxvM/Kp//VwNBYzNvHm2ux2XFuN5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=noD/b8ju; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-451d7de4ae3so28901085e9.2
        for <linux-efi@vger.kernel.org>; Tue, 22 Jul 2025 00:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753169406; x=1753774206; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AJj7BKcgkJOUpVILvlutzG3sQyBRFRydGJczKsiTn/M=;
        b=noD/b8juAxSt6DvNWlan/K+IV1lw7QJKL0mDhBbeyQlyAP8Amed4BW/WJawuwCWgx2
         Fapy2I21fOD8xIZja8uvR6MvrhxWvA87sNBJwn0LsZ38K+0hj9WvE1cQlIyPIQOLhJrg
         5sXFvjW5soqygUZpdvw6Mxa/B6k76QJa09cdeVd46R0V9VtZPfi2KPTkvbp6cU3cDEpb
         aoyOOaIkyziUef7BKJHN+b4teY1yoxFftX9bYMXmde6lrVScgfCE0BitoXWMxK0z1dam
         ShlMaAPqRLY3eeZyguAV9PTBy70he9KYljz5xbCipcBnR1e1DalUUjP3YfYPjvU+KtkM
         g8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753169406; x=1753774206;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AJj7BKcgkJOUpVILvlutzG3sQyBRFRydGJczKsiTn/M=;
        b=VNJ7f4wpzvyfc1/oe0J5AEzIgjasxlfBEAhtzIH1RF+9Nh4C7HZ84vPJQ5+2z9z+XT
         +oJvuDBc+T228l37vwX8npSPey72cbBdVOu+PMnTlWD4GfhpcvA4L2vIIS591O/kukPD
         ufq11BSG6AMoF/VXlMquBD3/s4MjBndIdvZQvr4UnTZDpEHd3FPJgeWvDffwZRaMHpEA
         oaDQVYZjlOoLfjFO46ZN/8BLH1VJuoZlKx6MA74sgTEGjsZgrbzWknzG/CGyS8fGRYLG
         qq313ccqS+NEOgys4CClnCzEYNN7JMJw8ACXueZu4DBQbZdP3dj1DO7aclf5QKGeRWsE
         Losw==
X-Gm-Message-State: AOJu0YzEU80Gb2HZf1mjtMen6RDmrx4bYhJPiOxPAd3UIvCzoRsKhkoL
	VPF+jR65ixKdZkjR1wMbVSNdxWzEwJmT86/Mk/iSR1dc6/5oYmf9k94BfMxxBXLVTHnMJwiaBQ=
	=
X-Google-Smtp-Source: AGHT+IGLWlgWa6RzVmCAyoMlmr3VIPZ+jJqUabm06ARqHBLvdkCPayHMIQ+HOYsB4R8ZUt+WXLNEYOV1
X-Received: from wmsp39.prod.google.com ([2002:a05:600c:1da7:b0:456:1ccb:7fbc])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:a310:b0:450:d4a6:799e
 with SMTP id 5b1f17b1804b1-4563c231876mr99156905e9.20.1753169406218; Tue, 22
 Jul 2025 00:30:06 -0700 (PDT)
Date: Tue, 22 Jul 2025 09:27:25 +0200
In-Reply-To: <20250722072708.2079165-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722072708.2079165-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1894; i=ardb@kernel.org;
 h=from:subject; bh=L4jffg2+Vf1ZB+P16ZYKMMQDycf2VYvq95i2j0U/b58=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaPednaFo4ujna9JaX+z4FKNR2WPIq71tO+/tuedpeOpj
 6pP9vztKGVhEONikBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABPZ58XIcHmWWlK2Q+uyqnM+
 /7R1OkSimm8UsscYrC7U+HB+hhNLOSND07Ivx3ktG6qfL5EoD9oWlpvVXpO19jerp6G9rdmTnPe cAA==
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722072708.2079165-40-ardb+git@google.com>
Subject: [PATCH v6 16/22] x86/boot: Check startup code for absence of absolute relocations
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Invoke objtool on each startup code object individually to check for the
absence of absolute relocations. This is needed because this code will
be invoked from the 1:1 mapping of memory before those absolute virtual
addresses (which are derived from the kernel virtual base address
provided to the linker and possibly shifted at boot) are mapped.

Only objects built under arch/x86/boot/startup/ have this restriction,
and once they have been incorporated into vmlinux.o, this distinction is
difficult to make. So force the invocation of objtool for each object
file individually, even if objtool is deferred to vmlinux.o for the rest
of the build. In the latter case, only pass --noabs and nothing else;
otherwise, append it to the existing objtool command line.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/startup/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index b514f7e81332..32737f4ab5a8 100644
--- a/arch/x86/boot/startup/Makefile
+++ b/arch/x86/boot/startup/Makefile
@@ -19,6 +19,7 @@ KCOV_INSTRUMENT	:= n
 
 obj-$(CONFIG_X86_64)		+= gdt_idt.o map_kernel.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= sme.o sev-startup.o
+pi-objs				:= $(patsubst %.o,$(obj)/%.o,$(obj-y))
 
 lib-$(CONFIG_X86_64)		+= la57toggle.o
 lib-$(CONFIG_EFI_MIXED)		+= efi-mixed.o
@@ -28,3 +29,10 @@ lib-$(CONFIG_EFI_MIXED)		+= efi-mixed.o
 # to be linked into the decompressor or the EFI stub but not vmlinux
 #
 $(patsubst %.o,$(obj)/%.o,$(lib-y)): OBJECT_FILES_NON_STANDARD := y
+
+#
+# Invoke objtool for each object individually to check for absolute
+# relocations, even if other objtool actions are being deferred.
+#
+$(pi-objs): objtool-enabled	= 1
+$(pi-objs): objtool-args	= $(if $(delay-objtool),,$(objtool-args-y)) --noabs
-- 
2.50.0.727.gbf7dc18ff4-goog


