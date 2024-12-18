Return-Path: <linux-efi+bounces-2391-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE2D9F696B
	for <lists+linux-efi@lfdr.de>; Wed, 18 Dec 2024 16:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E04E188D19B
	for <lists+linux-efi@lfdr.de>; Wed, 18 Dec 2024 15:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F611C5CDD;
	Wed, 18 Dec 2024 15:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pwmuQfAh"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D081B042F
	for <linux-efi@vger.kernel.org>; Wed, 18 Dec 2024 15:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734534220; cv=none; b=k1gbM2NK5hbtxJyiumtfnzCCsgbzLA89DbVQTAV9S/l90JU7KJwIM7gtDvnY9j27I80qFMhs2yrH5T8/Hrl9r2JwXJuP57Q6tMmBBQhnlqoR2MaH+t/a2KxF6DOGLKDIWVaGrmN+LyyQCJeBWB90CLl804ujSrViqOFPJTh9t/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734534220; c=relaxed/simple;
	bh=UkEQAPU0BOE7Cvbr49Sj5hH1WmXbgLg2wGhFh652QNc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Krq2g54t3rrJvok5HVR3oZcoNMAWN6cTAKbIjkQ0gZ94JskVadxp5U7Iq4PMaO3PO6J6D6TpNsHYxkgnb020fi5LwzxGfPP/B3rrfsNoL26pSPaAglwBE9lAB6QW6w/EX7oJG0RIRFnv0e1WqKCgpd5Z2GDHHCwGhrXXnVFPlZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pwmuQfAh; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43627bb20b5so52095685e9.1
        for <linux-efi@vger.kernel.org>; Wed, 18 Dec 2024 07:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734534216; x=1735139016; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KuIlLWp32KxrnX+b+TFBJxsTzZwQ84RmgJbgBG8fYVY=;
        b=pwmuQfAhMTc1HCZFd1trx1HZhcMVKpdOJ1SWtywb61hh544bY/SLQ+hwc5TrgRjn7L
         n+V3E2Fwt5X+b2+YzxN3c0ws4NZiP5yuxau5FybHkt05+tdyUPgCkQbT+tLpWPvwFKK5
         KbxzpL6xT/CNEwJqJJyILfEEb5Lkuc9WXiuc05ZaxtQ7F40FPSm63bJNCtoLCltjAiiU
         T+6aHBYXSDEhY4IxIyeC40hsxnZhBBZnfRIbczxwgY7x8U2r5DNKEHEDxMaVIZk6qm4a
         E6RdgZhevRb75OvbFWiy310htZk4I+lX61cRAziWBDN9c7MGspXnfLNDFTiBCJgFtYF1
         DD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734534217; x=1735139017;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KuIlLWp32KxrnX+b+TFBJxsTzZwQ84RmgJbgBG8fYVY=;
        b=Xjr7Um+hbXddPMBZitLQ+k9Xk03CHoCZ/80mtKvsZrhrpMg1pNhhwzfQi7CWkrPoYd
         W7VAyqdstFG0Me3MARoPuSKxgZ06nm3CJoeqccvoFAzL0KvwURr5d7/J2lmv1TksUesT
         SOH+PcgweDint7yCadpHA4A5KWH/rOEWV0X30DcN9eAitT8v6UCM2XBm6HsvyboC8+8z
         a4tamHoXTaJOLFuGbTlMzAyLLVD/eXPQ3X4v186Qnh2DWebuXx8R204391DZjEvyiXzP
         U9z47fc5J1ApoqFp1aki0obLreFsjaTpt+YS+vF+YCoYWVJ7Er6kLUUMZnXJVBg+px9L
         pOzw==
X-Gm-Message-State: AOJu0Yw7BN+Hn74N+tQnuKN2m2hPlEYjQD5HOatEerLBtlIJnQQcsPh3
	BQFSVECjiOUjlmFmEXlReDF/6F2uPGhDxlB2B06MhLZjXz+/kDHwpz61fMnhHqTLbK6AJ8VJpxw
	u4kL0fiEXVl+ikK1ymGisKpYknRtFEtGdk/FyWSqhw5U1L0rzoI1qDaEQE2iWV3KkYpDyEcMLgn
	EtvUK/OQpXEciq31ihtkGQDhwMzA==
X-Google-Smtp-Source: AGHT+IHUywDhYzEQoh8qG89QtR2fYeZOhh/y11YZQtpRYKYnPH/DXnov2cw8yVX+5sfOgjyqqIWOAgGk
X-Received: from wmbew11.prod.google.com ([2002:a05:600c:808b:b0:434:9da4:2fa5])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:154c:b0:42c:c28c:e477
 with SMTP id 5b1f17b1804b1-436553e9de5mr22498345e9.23.1734534216426; Wed, 18
 Dec 2024 07:03:36 -0800 (PST)
Date: Wed, 18 Dec 2024 16:03:19 +0100
In-Reply-To: <20241218150316.1583806-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241218150316.1583806-6-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2496; i=ardb@kernel.org;
 h=from:subject; bh=9vtzUeuZVMHbyIAsApU0U8bu7QdcmCaocZ+3CwCVfC4=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIT3piaUno547e6+JR9A/T93Xr8ODTxv9nO16fum1uPkOI
 WeSUnZ3lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgImYz2FkaJn6tCnlud+MmkNC
 9Xtndx32tApetqxm41l9eS7PNaxnRRkZtkpuiE3dvOWI5odN+7+9+jOdgWXP6XcfO65srvu0lOf VRxYA
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241218150316.1583806-9-ardb+git@google.com>
Subject: [RFC PATCH 3/4] arm64/boot: Populate vmlinux ELF program headers
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>, 
	Gerd Hoffmann <kraxel@redhat.com>, Pingfan Liu <piliu@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

In order to be able to use the ELF vmlinux image as the [zboot
compressed] boot image, populate the program headers explicitly to
describe text+rodata+inittext as R-X and initdata+data+bss as RW-.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/vmlinux.lds.S | 33 +++++++++++++-------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index f84c71f04d9e..33d9c683e434 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -59,6 +59,7 @@
 
 #define RO_EXCEPTION_TABLE_ALIGN	4
 #define RUNTIME_DISCARD_EXIT
+#define LOAD_OFFSET			KIMAGE_VADDR
 
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/cache.h>
@@ -70,7 +71,9 @@
 #include "image.h"
 
 OUTPUT_ARCH(aarch64)
-ENTRY(_text)
+ENTRY(elf_entry)
+
+elf_entry = ABSOLUTE(primary_entry - KIMAGE_VADDR);
 
 jiffies = jiffies_64;
 
@@ -150,6 +153,11 @@ PECOFF_FILE_ALIGNMENT = 0x200;
 #define PECOFF_EDATA_PADDING
 #endif
 
+PHDRS {
+	text PT_LOAD FLAGS(5);          /* R_X */
+	data PT_LOAD FLAGS(6);          /* RW_ */
+}
+
 SECTIONS
 {
 	/*
@@ -166,10 +174,10 @@ SECTIONS
 
 	. = KIMAGE_VADDR;
 
-	.head.text : {
+	.head.text : AT (0x0) {
 		_text = .;
 		HEAD_TEXT
-	}
+	} :text
 	.text : ALIGN(SEGMENT_ALIGN) {	/* Real text segment		*/
 		_stext = .;		/* Text and read-only data	*/
 			IRQENTRY_TEXT
@@ -248,10 +256,6 @@ SECTIONS
 	__inittext_end = .;
 	__initdata_begin = .;
 
-	init_idmap_pg_dir = .;
-	. += INIT_IDMAP_DIR_SIZE;
-	init_idmap_pg_end = .;
-
 	.init.data : {
 		INIT_DATA
 		INIT_SETUP(16)
@@ -259,13 +263,18 @@ SECTIONS
 		CON_INITCALL
 		INIT_RAM_FS
 		*(.init.altinstructions .init.bss)	/* from the EFI stub */
-	}
+	} :data
 	.exit.data : {
 		EXIT_DATA
 	}
 
 	RUNTIME_CONST_VARIABLES
 
+	. = ALIGN(PAGE_SIZE);
+	init_idmap_pg_dir = .;
+	. += INIT_IDMAP_DIR_SIZE;
+	init_idmap_pg_end = .;
+
 	PERCPU_SECTION(L1_CACHE_BYTES)
 	HYPERVISOR_PERCPU_SECTION
 
@@ -325,10 +334,12 @@ SECTIONS
 	init_pg_end = .;
 	/* end of zero-init region */
 
-	. += SZ_4K;		/* stack for the early C runtime */
-	early_init_stack = .;
+	.early_init_stack : {
+		. += SZ_4K;		/* stack for the early C runtime */
+		early_init_stack = .;
 
-	. = ALIGN(SEGMENT_ALIGN);
+		. = ALIGN(SEGMENT_ALIGN);
+	}
 	__pecoff_data_size = ABSOLUTE(. - __initdata_begin);
 	_end = .;
 
-- 
2.47.1.613.gc27f4b7a9f-goog


