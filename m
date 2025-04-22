Return-Path: <linux-efi+bounces-3408-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1622A96572
	for <lists+linux-efi@lfdr.de>; Tue, 22 Apr 2025 12:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD40617BDA4
	for <lists+linux-efi@lfdr.de>; Tue, 22 Apr 2025 10:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B7C21517E;
	Tue, 22 Apr 2025 10:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OiTYFkJn"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EBE20C490
	for <linux-efi@vger.kernel.org>; Tue, 22 Apr 2025 10:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745316477; cv=none; b=lwky35QrZekZ6pLn9XSjoBheQ/Pei/GGeJgBP3Skt/GK45CnjJ+ZXmmlG6KqwnQvz/rxhdhPdEv2dJCUq5OdYYnRBr+WKPPsEtPdXEn7Qt1CIdxZlOaQA8uu9GJi2PVm0heUvTz+xh/Q3yKs0WqtkxvBsSlQN/cBYcNVLAo7Z0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745316477; c=relaxed/simple;
	bh=OZC01qFvs+z6NnFJ35K2gqqtQjNtdb1vBdWCiuPeZkM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZqN+vbExAvb7r12DWP2bg5cnh7q6mf3cIlzUU/8nBwDY10LgyJUj3EvHqvkcA17d/0F8uD2amRgpXWCCO7w2r54X9JyXGs4/3SbmhPiozJkPN98OZGhderFhI3zy2zrGCBj64+APqgP9aKyoQvyPoZgXsmRWsgNwCE/RL4rVgac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OiTYFkJn; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43cf5196c25so28147895e9.0
        for <linux-efi@vger.kernel.org>; Tue, 22 Apr 2025 03:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745316474; x=1745921274; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ws8tmZmzNzitVKHYH495oHPaAWftQig6IJtfdT6v6zc=;
        b=OiTYFkJnZT3qAnomg1JPhYYRp99s0TMS9b3wy64HJRj4zeyV8eFhQk3oX/N0kzer5z
         1erOBc1iM8hq/fvFhTo2gIVdjCyuRE/S/vabWgwKll+XJApS7tDrRMJLvFLffWH8mem5
         Ruag/3VJX/cRoPbkzRdb6dm/suEK4sAgBoK6qK5/P7fukA0mFjlljI6XsjIfhxnltArW
         OcKLf8z69xQqygjndlYPbvAg9/dm5BJah5JRT3kVy83l0l9ePNu5DrNhz5lMjSQ3O0mv
         KD+yGn8CACD7QvE3/oBVpvDp5xjzVinYqJTuW03BeCbE2KKtsEFGWUI/AH70NM3rgLok
         D+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745316474; x=1745921274;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ws8tmZmzNzitVKHYH495oHPaAWftQig6IJtfdT6v6zc=;
        b=G3SgE/oHJSsAvde32JQRFVhqW1Abb4KrMw5kLvIP80lQ/toAp1vgUrCgN9Ms/c1Ks6
         JWbj7ab94vIEWQW7EglWrcyZeKhctAmXoKpKu/sInlM7Gpnqn0avC6yMj84S7SVt/3ur
         +t/OrQmX/4+S4kxFuIFXVlKACxphcSzbbFSI7LLyVJwA4n/2BmoMkY4lZLMKv1g8bTBE
         XmNTO3E97k7Z/it/urvSn/IwisClwTogJQQjlH0PKb9jY/lohnJiEBxx6FW5dPbTj9NV
         cU/bxmmFswSPr6BmL1tYZF80eqmg7LZH0l/+8xfbFLmL9wM4+md4G0IAG/Jf4p6yY1ai
         a5gQ==
X-Gm-Message-State: AOJu0YzDYMlp9kJP7CaXS2T8P6ve6+Bk7eyfzuNjxrx6UxlDSG4Y8bky
	y5m7l8c7mLrExIIm3gSZnEF+I4c3rZ6o03sicOy9cyrqQI0zTYzAThgUc8fQRUMxvXyXNjA2xjl
	+6Q0nAmjd7/2dS+Oks7hDPYg2nx7AimZW/msHM3qk46IyS5gbRg6nsSGWFbuc2hu7VMcnm0/iXz
	nAUpMb+gYNtXSAoI4jaDlqWWel4g==
X-Google-Smtp-Source: AGHT+IEsttKPc+1+pKNp7wkrPzKN6VR701tpMP/CW7FNllIuNswL8vMW3YW3zCuV2chYoM5R1a48fkwQ
X-Received: from wmbes27.prod.google.com ([2002:a05:600c:811b:b0:440:5d62:5112])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:6da1:0:b0:39e:e259:91fd
 with SMTP id ffacd0b85a97d-39efba3cbbbmr12965416f8f.17.1745316473972; Tue, 22
 Apr 2025 03:07:53 -0700 (PDT)
Date: Tue, 22 Apr 2025 12:07:34 +0200
In-Reply-To: <20250422100728.208479-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250422100728.208479-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2375; i=ardb@kernel.org;
 h=from:subject; bh=KbofsdXhZq5FJV6/iTzACT581EDT107l3QmYOrFF/SU=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYM9K6tdQlZX18VTVZD5U4KU+89rsWY8U8+8cj5x9dXax
 Y7e55Z1lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIm8d2X4w6cs5zrZdvuntbLL
 jbva9n5p2Lr01SahS4en9lo+iXvOuIiR4bbH9LYNztfO6tovfTOl8EL2qv4wO42sWWeSXq16Ira siRkA
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250422100728.208479-12-ardb+git@google.com>
Subject: [PATCH v3 5/5] x86/efistub: Don't bother enabling SEV in the EFI stub
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Borislav Petkov <bp@alien8.de>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

One of the last things the EFI stub does before handing over to the core
kernel when booting as a SEV guest is enabling SEV, even though this is
mostly redundant: one of the first things the core kernel does is
calling sme_enable(), after setting up the early GDT and IDT but before
even setting up the kernel page tables. sme_enable() performs the same
SEV-SNP initialization that the decompressor performs in sev_enable().

So let's just drop this call to sev_enable(), and rely on the core
kernel to initiaize SEV correctly.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/sev.h              | 2 --
 drivers/firmware/efi/libstub/x86-stub.c | 6 ------
 2 files changed, 8 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 8637a65973ef..d762cc0fd47e 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -443,7 +443,6 @@ static __always_inline void sev_es_nmi_complete(void)
 		__sev_es_nmi_complete();
 }
 extern int __init sev_es_efi_map_ghcbs(pgd_t *pgd);
-extern void sev_enable(struct boot_params *bp);
 
 /*
  * RMPADJUST modifies the RMP permissions of a page of a lesser-
@@ -531,7 +530,6 @@ static inline void sev_es_ist_exit(void) { }
 static inline int sev_es_setup_ap_jump_table(struct real_mode_header *rmh) { return 0; }
 static inline void sev_es_nmi_complete(void) { }
 static inline int sev_es_efi_map_ghcbs(pgd_t *pgd) { return 0; }
-static inline void sev_enable(struct boot_params *bp) { }
 static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate) { return 0; }
 static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs) { return 0; }
 static inline void setup_ghcb(void) { }
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index d9ae1a230d39..6b4f5ac91e7f 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -936,12 +936,6 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 		goto fail;
 	}
 
-	/*
-	 * Call the SEV init code while still running with the firmware's
-	 * GDT/IDT, so #VC exceptions will be handled by EFI.
-	 */
-	sev_enable(boot_params);
-
 	efi_5level_switch();
 
 	enter_kernel(kernel_entry, boot_params);
-- 
2.49.0.805.g082f7c87e0-goog


