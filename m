Return-Path: <linux-efi+bounces-1186-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC6F902195
	for <lists+linux-efi@lfdr.de>; Mon, 10 Jun 2024 14:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C983B23ECB
	for <lists+linux-efi@lfdr.de>; Mon, 10 Jun 2024 12:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8F3762D2;
	Mon, 10 Jun 2024 12:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IJz/5Ea2"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B4C7E58C
	for <linux-efi@vger.kernel.org>; Mon, 10 Jun 2024 12:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718022288; cv=none; b=JTuRiNiKXTJLQb0kZbLPvqVMoEQDEFBJhsvgcynr2DzapjWdI2B0cm82UWZONTqr0rSt/PStD1zpqES8jEe9fO/F9e5/lPY/uNEUtVMquR7IOzbkwgYjIECH0/vHh5j6DCCeIqz7ho/pP7zf6iPsRX+0YWVqFbfSNT1xuj+GyPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718022288; c=relaxed/simple;
	bh=lODJzX7RK/3gqW7SLI4sodAzP/4RKmEiLEanCBSHskY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IdelP1kclbjJPG6bDJBixTcIWxxcuJhH4dhZxM74UzISfKYtqig1GFvj6kOC9Yz3Eb9/kd5Z12ZKHeCBzwj964xAugbkPDhbm8grJ5VTRNLsfEEW0tZZ7Vq47HGjS9ZMadiaK4+OQ8rIAIMw+pzHQA9YTsqlmWaKuSnu9kf+liI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IJz/5Ea2; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfa5743655eso7848575276.1
        for <linux-efi@vger.kernel.org>; Mon, 10 Jun 2024 05:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718022286; x=1718627086; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=arVT1UJjpDifIxa4uEm/zmcaSk9BsvyP57DfTAzOe68=;
        b=IJz/5Ea24zuOzqgg6PpSLl+R3ziT8umMEg0af3fKeoGGKVJwOphfQkoqicY7s1C7Bt
         9aHg+8eqq/Ud1OtyLyFbmvbsDUJKF/s/AaCuA6FyULH7PHD43QRblVUwc6yxJf7TbIe2
         uHwyuT4FsTwaSKOcIKpTJEpjQdT4fvYXQolvUc6g2ZgRXiFyWhPgJy2yjw2nMkpcA5b9
         0tYd3A1TlABORhxSlg5iqW9uw17lwXOAtD+gasWODnWSygXdId54UbPVW0qNLkq++yK7
         f2L2/01L45RHi4ruuVLKYcTsp7nQxsqctXIFwmChr5UhXwdWb1wIDSXpk3y015UE7E4f
         W37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718022286; x=1718627086;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=arVT1UJjpDifIxa4uEm/zmcaSk9BsvyP57DfTAzOe68=;
        b=vS1wiqOdp4kLU1mBCJ1XAIYeXgW11eTsOts5jnzPPmRvAyrtLel8/wkxZkmL3qlFQf
         bxgyeuRlGauDWNbAGQDGynsT6YShP9tSmteYjOllo61mElPJxK+IjAWK59O0dTXKzIwH
         wysbuZRY5khxXLJdrDxFwHvB7ws7ijuNsDnYTkaxpk/3mmEQnqutifhTOVuaMg6BNcHi
         oFwSkznewZym4yVpWGWoAavwNIOEPMvRNGBCCqz0PcQ2ndyF+umR6lat/1WdPoblarFA
         IMYPcMnGp8efvyL8I/Rx/oqSupByzPPLT50xvAvMEsNZO9qCUtptMhJur4Yz2g+Ftxl6
         9RwA==
X-Gm-Message-State: AOJu0Yyar88MD8wR0VPP7RJIvclsZZI4Tq0QT4zYNv4MjU7RpaDXE/mC
	m3qnDgLlXH8qW/yJpzZcdxZVTTpaYitQNT1iZV8stsCQvODsGHDhKflayx8qPpfjoNR3o5gbDj5
	lgpjDYeDjafmNqzCWXxoz4i/STXUW//c16aukR5n0J6YjGfO3gtAmkLbm/6IycGHCJ8yxQylqSt
	pwXhPwBwbr2Ghhq8iKK8VCX9IpiQ==
X-Google-Smtp-Source: AGHT+IFy4fbRMOr/D5J8Mb5DIZLL8qf8J1a9nL1lZPR65XOkeoC1GSF3L7mKwVVdHZBxRxLrQKLcHzk8
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:2b8b:b0:dfa:849d:3a59 with SMTP id
 3f1490d57ef6-dfaf667471bmr3293606276.13.1718022285824; Mon, 10 Jun 2024
 05:24:45 -0700 (PDT)
Date: Mon, 10 Jun 2024 14:24:38 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2514; i=ardb@kernel.org;
 h=from:subject; bh=vAdAgJhZ88ZG4Hss513g3YwUrqqEyDQZv4qPQ2fT/YE=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIS3tQzv314Nsr2KfVHF22yjY7PFVCbTY8X/dO2ax1vyLR
 wr3iip1lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIlwlzL8L49aFu9/c9ehzi2u
 CX7qp84E7IyYs+/uU41nMjHzn0XbZzAyvDpcPzuiKWrjxejV1juF9rHLBB0wzhWd6VfGJuxk5hP KAgA=
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240610122437.2358778-2-ardb+git@google.com>
Subject: [PATCH] efi/arm: Disable LPAE PAN when calling EFI runtime services
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org, 
	linux@armlinux.org.uk, Ard Biesheuvel <ardb@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

EFI runtime services are remapped into the lower 1 GiB of virtual
address space at boot, so they are guaranteed to be able to co-exist
with the kernel virtual mappings without the need to allocate space for
them in the kernel's vmalloc region, which is rather small.

This means those mappings are covered by TTBR0 when LPAE PAN is enabled,
and so 'user' access must be enabled while such calls are in progress.

To avoid the need to refactor the code that is shared between ARM, arm64
and other EFI architectures, fold this into efi_set_pgd(). Given that
EFI runtime services are serialized and not pre-emptible, storing the
flags into a global variable is reasonable here - efi_set_pgd() calls
will always occur in pairs on a single CPU.

Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/include/asm/efi.h | 15 +++++++++++++++
 arch/arm/kernel/efi.c      |  4 ++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
index 78282ced5038..773fb072c040 100644
--- a/arch/arm/include/asm/efi.h
+++ b/arch/arm/include/asm/efi.h
@@ -14,6 +14,7 @@
 #include <asm/mach/map.h>
 #include <asm/mmu_context.h>
 #include <asm/ptrace.h>
+#include <asm/uaccess.h>
 
 #ifdef CONFIG_EFI
 void efi_init(void);
@@ -32,6 +33,20 @@ int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md, boo
 static inline void efi_set_pgd(struct mm_struct *mm)
 {
 	check_and_switch_context(mm, NULL);
+
+	if (IS_ENABLED(CONFIG_ARM_TTBR0_PAN)) {
+		extern unsigned int efi_arm_ttbr0_pan_flags;
+
+		/*
+		 * EFI runtime services are mapped in the lower TTBR0 region,
+		 * so TTBR0 based PAN should be disabled while making a EFI
+		 * runtime service call.
+		 */
+		if (mm != current->active_mm)
+			efi_arm_ttbr0_pan_flags = uaccess_save_and_enable();
+		else
+			uaccess_restore(efi_arm_ttbr0_pan_flags);
+	}
 }
 
 void efi_virtmap_load(void);
diff --git a/arch/arm/kernel/efi.c b/arch/arm/kernel/efi.c
index 6f9ec7d28a71..6864338073e6 100644
--- a/arch/arm/kernel/efi.c
+++ b/arch/arm/kernel/efi.c
@@ -11,6 +11,10 @@
 #include <asm/mach/map.h>
 #include <asm/mmu_context.h>
 
+#ifdef CONFIG_ARM_TTBR0_PAN
+unsigned int efi_arm_ttbr0_pan_flags;
+#endif
+
 static int __init set_permissions(pte_t *ptep, unsigned long addr, void *data)
 {
 	efi_memory_desc_t *md = data;
-- 
2.45.2.505.gda0bf45e8d-goog


