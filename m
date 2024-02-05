Return-Path: <linux-efi+bounces-475-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C4E849522
	for <lists+linux-efi@lfdr.de>; Mon,  5 Feb 2024 09:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50BE91C2363E
	for <lists+linux-efi@lfdr.de>; Mon,  5 Feb 2024 08:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112DD11197;
	Mon,  5 Feb 2024 08:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E4nwTgKy"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488E2125AD
	for <linux-efi@vger.kernel.org>; Mon,  5 Feb 2024 08:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707120678; cv=none; b=hfFpoeIdxOxVAHkZnGfU03TMGGbzfdBMaFE8eBtt81tzuLct1/HQHRsQ6c03w2rbJA8+W5XuH236bPJw6uabTgVEdixURi3xH/CtJJcOO/hdNe4LH8xqCwOG/A2KJ91VMN+CpY4WXJ63SORBUGPYqEoUsTm07y5hUk6znhoLch0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707120678; c=relaxed/simple;
	bh=BAFgpR4X3KpDnnVtmJyyiOT88VRWGQpHuRzwOTnj+V8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=l0RMgbdmKWPmy+lvWCQ0X2ofhql4uoBvgrHWm01YroLKiPaXKEGKA3OYLZYObIfmtxqQlByrv7swCnxnz1uX1G/vOamBdggqSHKaoyaXjIDP2Wh7/9ztif2H9yavF2WgoJbPPm9aaB4rdrz4FmLSrs7os7QI+13h9Q2mspp2bHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E4nwTgKy; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b267bf11so4228987276.2
        for <linux-efi@vger.kernel.org>; Mon, 05 Feb 2024 00:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707120675; x=1707725475; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y5NqMyMM2YuT7vFLbcYH8NZXZb8hqxsabSo6d+pQx28=;
        b=E4nwTgKyCbl2/rP9I3nMNjbaRlHwjyTnrcg3eR+eTymHJo00axmf291fOS1HPjR2Ya
         Vli4fuLhClnfIu26k0oJdN4ss7/HUv3mKmDa9RYcG35oEUyOGW/Au/4jYj5zX5gY0fmk
         O0roLP2vEWNr05fyhkGyCl0BgBh496Z3eR6L7y5GnDUsMqYw9chM3i/cNHYxhBJooH3j
         s9/mCFG+Bv0GjwUANqC6gf6VhlrZwx6aPo6ndZlKIe1i8Uy2MvoIwPZBYRedwzJUH/D1
         4Auj1ZojSwa9jGF2jyT9ZfyLX3LlK7A5OjG+3yCvD7EFcGibBxPniiborTqt/562+FnH
         aV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707120675; x=1707725475;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y5NqMyMM2YuT7vFLbcYH8NZXZb8hqxsabSo6d+pQx28=;
        b=lMQwibjQDVAUK5oeUMn597gByGguGGgNx4Jpb2cmEiKIgwBuJctNf/GmPXyv72XHC8
         RDIg54kPxkfHQaLxSmMHIsk9MZXQm9m7NH7gHE4pxxmP3rJAetu8LiPvImhyh94JRD2O
         u8ZRG1L4WFqVuvWBNYF9dNDyFshfAZadKfjRMDBP+NyCcE27lbb1JNoriaOFgODYm+QI
         BrBIV0xiRraHQUpP0eJ0VWqsBs/n/Ur4RJSq5x8GY7C31oF9VhhrYoufug/uiVlHcUDr
         vGQUR9OPkntiH7NqeMjRp8Rpynrm3Jq+tOYqJyHsq8SIZ8FijvqE7p4J3ucq8nEjeyYy
         Mviw==
X-Gm-Message-State: AOJu0Yy8EV4HdvkwngOYjeY0J4VWh5g7bHI9iREuz+mxTFLtO3FhcHYN
	d11HxAx6K2vSZPhKBR4AsxBNfUYjsbLrT7Pi3DayZUhea/jHL44dYe1qiUVMIenT1p6A7cLeEnc
	+iCe82QUG6LCTICn9BJdbFzNHU3iE3r5RErS4jfrW4aXajVucPKlrPfemtMAiNsyyYZGX14c9XJ
	/BV9OuDHL/jAw8j0IaKZPtyA6azA==
X-Google-Smtp-Source: AGHT+IFdrGBMa/35mQZy1MMgRlgEfMkwNyLEbFPg/KYVJJx7UGNvqhAH4mAPdBJHijjDDvfwBh2qgLZ4
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:993:b0:dc2:25fd:eff1 with SMTP id
 bv19-20020a056902099300b00dc225fdeff1mr422690ybb.4.1707120675257; Mon, 05 Feb
 2024 00:11:15 -0800 (PST)
Date: Mon,  5 Feb 2024 09:11:07 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3574; i=ardb@kernel.org;
 h=from:subject; bh=ETg8Vjh2MQ+rYHZXOgrc0v0V9MSi8UuMU2QlvfPlXSA=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXADOm/rax8jTFLv/g0pWgKPNO9c0I4Lop/85ug9dInz
 c/OXLy4o5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzEtoCRYUpW/j+X90F5N+2V
 dX5PPD5P2MYqz3/+sqcLrFXyS9acZmNkeCilkvDOUtXk4pmnF03+TXEK22tZWPq4xfbn8nWPzmw 8zwgA
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240205081106.2415414-2-ardb+git@google.com>
Subject: [PATCH] x86/efistub: Use 1:1 file:memory mapping for PE/COFF .compat section
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Mike Beaton <mjsbeaton@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The .compat section is a dummy PE section that contains the address of
the 32-bit entrypoint of the 64-bit kernel image if it is bootable from
32-bit firmware (i.e., CONFIG_EFI_MIXED=y)

This section is only 8 bytes in size and is only referenced from the
loader, and so it is placed at the end of the memory view of the image,
to avoid the need for padding it to 4k, which is required for sections
appearing in the middle of the image.

Unfortunately, this violates the PE/COFF spec, and even if most EFI
loaders will work correctly (including the Tianocore reference
implementation), PE loaders do exist that reject such images, on the
basis that both the file and memory views of the file contents should be
described by the section headers in a manner that is monotonic and does
not leave any gaps.

So reorganize the sections to avoid this issue. This results in a slight
padding overhead (< 4k) but this can be avoided by disabling
CONFIG_EFI_MIXED (which is only needed in rare cases these days)

Reported-by: Mike Beaton <mjsbeaton@gmail.com>
Link: https://lkml.kernel.org/r/CAHzAAWQ6srV6LVNdmfbJhOwhBw5ZzxxZZ07aHt9oKkfYAdvuQQ%40mail.gmail.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/header.S | 13 +++++--------
 arch/x86/boot/setup.ld |  6 +++---
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index b2771710ed98..8c093a2b18eb 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -106,8 +106,7 @@ extra_header_fields:
 	.word	0				# MinorSubsystemVersion
 	.long	0				# Win32VersionValue
 
-	.long	setup_size + ZO__end + pecompat_vsize
-						# SizeOfImage
+	.long	setup_size + ZO__end		# SizeOfImage
 
 	.long	salign				# SizeOfHeaders
 	.long	0				# CheckSum
@@ -143,7 +142,7 @@ section_table:
 	.ascii	".setup"
 	.byte	0
 	.byte	0
-	.long	setup_size - salign 		# VirtualSize
+	.long	pecompat_fstart - salign 	# VirtualSize
 	.long	salign				# VirtualAddress
 	.long	pecompat_fstart - salign	# SizeOfRawData
 	.long	salign				# PointerToRawData
@@ -156,8 +155,8 @@ section_table:
 #ifdef CONFIG_EFI_MIXED
 	.asciz	".compat"
 
-	.long	8				# VirtualSize
-	.long	setup_size + ZO__end		# VirtualAddress
+	.long	pecompat_fsize			# VirtualSize
+	.long	pecompat_fstart			# VirtualAddress
 	.long	pecompat_fsize			# SizeOfRawData
 	.long	pecompat_fstart			# PointerToRawData
 
@@ -172,8 +171,7 @@ section_table:
 	 * modes this image supports.
 	 */
 	.pushsection ".pecompat", "a", @progbits
-	.balign	falign
-	.set	pecompat_vsize, salign
+	.balign	salign
 	.globl	pecompat_fstart
 pecompat_fstart:
 	.byte	0x1				# Version
@@ -182,7 +180,6 @@ pecompat_fstart:
 	.long	setup_size + ZO_efi32_pe_entry	# Entrypoint
 	.popsection
 #else
-	.set	pecompat_vsize, 0
 	.set	pecompat_fstart, setup_size
 #endif
 	.ascii	".text"
diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
index 83bb7efad8ae..3a2d1360abb0 100644
--- a/arch/x86/boot/setup.ld
+++ b/arch/x86/boot/setup.ld
@@ -24,6 +24,9 @@ SECTIONS
 	.text		: { *(.text .text.*) }
 	.text32		: { *(.text32) }
 
+	.pecompat	: { *(.pecompat) }
+	PROVIDE(pecompat_fsize = setup_size - pecompat_fstart);
+
 	. = ALIGN(16);
 	.rodata		: { *(.rodata*) }
 
@@ -36,9 +39,6 @@ SECTIONS
 	. = ALIGN(16);
 	.data		: { *(.data*) }
 
-	.pecompat	: { *(.pecompat) }
-	PROVIDE(pecompat_fsize = setup_size - pecompat_fstart);
-
 	.signature	: {
 		setup_sig = .;
 		LONG(0x5a5aaa55)
-- 
2.43.0.594.gd9cf4e227d-goog


