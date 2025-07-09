Return-Path: <linux-efi+bounces-4223-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13801AFE228
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 10:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D73E1AA0B21
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 08:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EA027FD5D;
	Wed,  9 Jul 2025 08:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bN6nKz8q"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F9A27FB0D
	for <linux-efi@vger.kernel.org>; Wed,  9 Jul 2025 08:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752048703; cv=none; b=VpBCs5fBY0PNKdUhePjx4/DjFGWLKBr5nZ2M7BTVaRhjufYmxFjo2sjZa5KNt8XAq974M0PD4aBTa+dzRhf9x0lXI7Wf7fO+3+TpLOgfb++U1QLVyZ3Szr4djhuqLsSVp1XL6gr8v+yIQOS+6rXkYeZtUnRSa9mGbl8Fjc+1MbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752048703; c=relaxed/simple;
	bh=L0nuKM1iOS5J1LrRXwl6oFJ2k3UoNAHOTrQqnHSBepc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e+jxb6Mox+EPsRgBV0TOs9qjESuEhtr9byctlKGcClK7gZSbMm8K2R2kmlcIkqo6RH1wnezsgwEfiKnyY0lP8ZrMzuscNomqET1lpJJN0VDv0Ma92qHSsXJpSGA2yPoVc4aX/4zOrr5PteTXSwmE7gV+Kh8mLLPnQpDiC1NpxOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bN6nKz8q; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-454d910ea8dso83545e9.3
        for <linux-efi@vger.kernel.org>; Wed, 09 Jul 2025 01:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752048700; x=1752653500; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AJj7BKcgkJOUpVILvlutzG3sQyBRFRydGJczKsiTn/M=;
        b=bN6nKz8qQeWLT8ZgRQ9DTyT1cDWLWiUmGJxyJsUEPk+zGAFLd4usEfNd2Oj+XfAJhj
         Uki7MMQ7o1Xt85tEUTp60/lz9GeYcAuOjRI8F8FVGZEowNpFKLpf0Jls+DnkhZ+7hsvT
         ZPHhn5M/AzHPmYd2OoAqJp7HZSEk5sqgqS6XndtWwJfM+T8im6XaqWvN1BIEN0ThnYzi
         OLld4lxfDIhb2/IUxp8ELW4Kp9MlJtaTaryVgDSQl6AzMjYWMOzl1Ndtz39wvZ0NNtvY
         Aiqadd9jz9IzLG+dirP6PLPLAJkYHm3i7mqytTGE0YNCf3AlFROxaZE9IlHV/pOtnd4Q
         bj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752048700; x=1752653500;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AJj7BKcgkJOUpVILvlutzG3sQyBRFRydGJczKsiTn/M=;
        b=JW3XmsJsniZSchWYwqZJkQzYAwYgJE+ZHc9OR80w6l6UDNFZWNM79I+zFAyI5Jl1Sp
         eRnBXbpGVONXU2j2IDZFZ8dm/hhb7+H+h0HToBsDFz3d+lNA+gigVBpCX7WHMNiYjvKH
         zgYwxTAqkvhqKgRvm2t1MWhbVZRaquz0LtU0PLL1UwG8ahfwb1G/692kNj6PzWzRwjex
         Qsv27ynyfV0AVPJaAOEDcgJKwDoFI8nMG5W0y0SYMcPGVovqWoemlZwycd+rT8agcf3T
         7E2IEBcjPE0qaywXkifRgAoUbOgCGFQPwzBi1dMjEuAOUxpulx+tUax0xkwjJdCXCxIL
         /5og==
X-Gm-Message-State: AOJu0YxhREsuUtOV4rx5lbgq9jWWa+V2AeXxcq8UIIuHN7Zs7lS0UWMt
	h7/LaAl+Aez7zW5qxs9GZY0T7mCTNfmCgtRQIVDXfviDt/Do761WdtOqJiPqV54kPjV61j4kZA=
	=
X-Google-Smtp-Source: AGHT+IEPZp1VCmwNurBlUBLL5R2bEvNSuc5tGGEyVsOauyKXnhxJ0yeJAX3G1Kl1wdJ6ycwIpaQHUeFq
X-Received: from wmbfa23.prod.google.com ([2002:a05:600c:5197:b0:453:8b14:6e00])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:a407:b0:453:dbe:7574
 with SMTP id 5b1f17b1804b1-454d5c8d44dmr8602395e9.12.1752048699898; Wed, 09
 Jul 2025 01:11:39 -0700 (PDT)
Date: Wed,  9 Jul 2025 10:08:59 +0200
In-Reply-To: <20250709080840.2233208-26-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709080840.2233208-26-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1894; i=ardb@kernel.org;
 h=from:subject; bh=L4jffg2+Vf1ZB+P16ZYKMMQDycf2VYvq95i2j0U/b58=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JISNP+VmFo4ujna9JaX+z4FKNR2WPIq71tO+/tuedpeOpj
 6pP9vztKGVhEONikBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABOZWMvI8Fo45c/lmIBarub+
 3F2Z2ed8svOP+nRdTAxPS1yYHLNwEcMfrpA4bZ7zX6beaX0UcbRXw+4NQyvL7Lyj2wMuvJ9lvym OGQA=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709080840.2233208-44-ardb+git@google.com>
Subject: [PATCH v4 18/24] x86/boot: Check startup code for absence of absolute relocations
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
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


