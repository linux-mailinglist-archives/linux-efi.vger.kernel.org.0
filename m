Return-Path: <linux-efi+bounces-4372-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC72B06C3D
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 05:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4244A561161
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 03:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FD328CF68;
	Wed, 16 Jul 2025 03:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kmMwB3Xa"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F329B28BABD
	for <linux-efi@vger.kernel.org>; Wed, 16 Jul 2025 03:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752636170; cv=none; b=MxvdOOYFAeJuidj14w0s+JK+1hrtvKZbljQOORPgaOxclXYvg8JBYf2ogMmI8b19IJasnaWlB+HEE8yaALxn8KBbrvTgDQN8ngRbYrsCIjPptVZMME205T6mZR9bzZIvQCkAxM5Hvad02DgkaG4BZJuOr77mMnfDoxX3nxiqWOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752636170; c=relaxed/simple;
	bh=qi/XSlH/3m0Py+I72AmudGPp6EWjqjC8xYfnH6HfggU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XKwVyjzPzhX+guomAAeOlFffhTOYnWIraSifEAQr8xn94Z7rhlJfIYoFO5fJ4F1kg/m0YjAdwvwcYvgzCi9VIhJBAXrGDkyIAXT66CVIVKy/aW7Bbvc/gP2Dr52PuY2pGfgFvHqintgxzUgijgQWBbqnUkJ7FIga8YkY4xFAxXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kmMwB3Xa; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3a58939191eso2335395f8f.0
        for <linux-efi@vger.kernel.org>; Tue, 15 Jul 2025 20:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752636167; x=1753240967; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HHREQvw4opT+z1wL8T5wjMmNHsYkeJcC/ePiz2KgcJA=;
        b=kmMwB3Xab6+7Wgad83HdzaLUsmn8bDRxqI92dqirx/UxOI/yU+KMIOuZHukvC4G2VW
         /LubNq+vWzIlMfnktVpHBYXNwrQLKBOwG8QXmfe0M38S1rzkMEtKcA6+TF0TgvunKcjF
         rP4k93MnqqXh+vwhpd0EeRran9gjEfvkr335cNGwcG3uPgNNDZztpZ1nVJssw/GfdWpU
         I9qtNpT8k3qhs6rZi/gyQ5Mn2+B3mJuLuBDN8dbjklKFgyDy7GsXKHIvdWhBrOKflfbU
         5YrZEdYniwIaV7keNZQkQyB+z8T2SgV4l8JlNWA1iqqJrqRJ+rVyaSvclidUzy4sBiFv
         SWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752636167; x=1753240967;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HHREQvw4opT+z1wL8T5wjMmNHsYkeJcC/ePiz2KgcJA=;
        b=vPc2rAeYHzqIOOXhu6THhvDWStMgHH5AYbifP1mXeB/R5ucD0w20jFsfNVYy5F5GG8
         S6hfZgK4Z7ko4OZDHbj8VRNVfPmBukzkLe08fSd2BotsyR9us/r9+UA9gPGaroIrhzmU
         aoQzeoD+/9y3jvK/4Um4OiNSw1GdlOBauCAlArD2dr59rjXLY+SJZ7OjfoDqfvykroTS
         qK4HxiPbC07doZwcR8HkJuGrVCyM8Lwq46LEIH6oCT6Unpamx6N2IPdjzGG6taUOPPf3
         BiPKrI2DrgQuTtPvDftVkh9RUpWnewVeXzSCunPUryUsQ67eDaXE8+Ykg92OKmPccy3f
         ZN/A==
X-Gm-Message-State: AOJu0YwVdLbB/anqShTGCrrRrNA5cXO2cHCMYlBjfMCYJG7ithuO2/eY
	RjF4Vbsk0YmDU4g3exqAjxTOfu+akoyPgr83wgkHP7ak3FZlt2kjY7WlTLhKVRBS3TozJUWFiA=
	=
X-Google-Smtp-Source: AGHT+IHCDF28uhxLChWY201JTyXnDh+mV9s7xysG12xzVOaBfwcEjRnjq+G7EOVRHZSpSmIkxdVi1rSl
X-Received: from wrth4.prod.google.com ([2002:a5d:5044:0:b0:3a5:7a26:fcd])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:290f:b0:3a3:6a9a:5ebf
 with SMTP id ffacd0b85a97d-3b60e4d0841mr609066f8f.20.1752636167659; Tue, 15
 Jul 2025 20:22:47 -0700 (PDT)
Date: Wed, 16 Jul 2025 05:18:33 +0200
In-Reply-To: <20250716031814.2096113-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716031814.2096113-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1689; i=ardb@kernel.org;
 h=from:subject; bh=N6Uq2lVfV25Jk1mFXhfGvG4B+EmaRioUjXHyXI14Co0=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaNcKmL7jszVT6MOl35jqfwRG7FLI/js7ikfRZd9yti8S
 cRJo3xDRykLgxgXg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjIYjlGhmdpa/7fqVZafJ1n
 Hsu8nRI+OxKZLWp4lateyHxsSDMWFWJkuBXos8E0tt1npUfBC/4b3LslV3V+vMLIx3lbncko1kO IGwA=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716031814.2096113-42-ardb+git@google.com>
Subject: [PATCH v5 18/22] x86/kbuild: Incorporate boot/startup/ via Kbuild makefile
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Using core-y is not the correct way to get kbuild to descend into
arch/x86/boot/startup. For instance, building an individual object does
not work as expected when the pattern rule is local to the Makefile

  $ make arch/x86/boot/startup/map_kernel.pi.o
    GEN     Makefile
    CALL    /home/ardb/linux/scripts/checksyscalls.sh
    DESCEND objtool
    INSTALL libsubcmd_headers
  make[3]: *** No rule to make target 'arch/x86/boot/startup/map_kernel.pi.o'.  Stop.
  make[2]: *** [/home/ardb/linux/scripts/Makefile.build:461: arch/x86] Error 2
  make[1]: *** [/home/ardb/linux/Makefile:2011: .] Error 2
  make: *** [/home/ardb/linux/Makefile:248: __sub-make] Error 2

So use obj-y from arch.x86/Kbuild instead, which makes things work as
expected.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/Kbuild   | 2 ++
 arch/x86/Makefile | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kbuild b/arch/x86/Kbuild
index f7fb3d88c57b..36b985d0e7bf 100644
--- a/arch/x86/Kbuild
+++ b/arch/x86/Kbuild
@@ -3,6 +3,8 @@
 # Branch profiling isn't noinstr-safe.  Disable it for arch/x86/*
 subdir-ccflags-$(CONFIG_TRACE_BRANCH_PROFILING) += -DDISABLE_BRANCH_PROFILING
 
+obj-y += boot/startup/
+
 obj-$(CONFIG_ARCH_HAS_CC_PLATFORM) += coco/
 
 obj-y += entry/
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 1913d342969b..9b76e77ff7f7 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -286,7 +286,6 @@ archprepare: $(cpufeaturemasks.hdr)
 ###
 # Kernel objects
 
-core-y  += arch/x86/boot/startup/
 libs-y  += arch/x86/lib/
 
 # drivers-y are linked after core-y
-- 
2.50.0.727.gbf7dc18ff4-goog


