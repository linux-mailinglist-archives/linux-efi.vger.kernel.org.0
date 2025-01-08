Return-Path: <linux-efi+bounces-2538-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA6DA0644C
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jan 2025 19:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6AAE188980E
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jan 2025 18:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA42A201002;
	Wed,  8 Jan 2025 18:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zFdl2XcJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93DA201026
	for <linux-efi@vger.kernel.org>; Wed,  8 Jan 2025 18:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736360576; cv=none; b=kDOtH9E3BJMypPNFdIiF+VdigcbbzVkjRkpPNcei8nY19m9dWytFOslyB31g/yfzOGBj2gZEqME6ER8DCyGMhf2AU/O6jTXqQziqVCXFrC2r3IZBeWWTtgz817L+GCkBxWO6EDT8I1pBgUAFU9cAUq0lRomJn1XFB/9/0opkHkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736360576; c=relaxed/simple;
	bh=cHdxDG+CZLPQVM0hykUhARikRkONgl0Kis3lMtVaXe4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fVpWT12O2gA+p7PRp7spzEJUqXt8xorPowzt0P9J0FLELb8sq+JmabmvWgwIRppa8uI3glQADmkfUp8rO80uLWI1dNLs24PDciQNnLA2bJK0S+Vawj0kIckIsKVaKfRhesPPklfYjoa2A1MYq1ZzQX/ZCUTEHbUMGgokZrA+Fak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zFdl2XcJ; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-385e1fd40acso41073f8f.3
        for <linux-efi@vger.kernel.org>; Wed, 08 Jan 2025 10:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736360573; x=1736965373; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jMNqoigFiWM5TbLMD0Xi2MHr+lE9/rI9qjc7yUxHIVg=;
        b=zFdl2XcJNNWAOrg44c68Ayy32jbKkQPMEqrg8wiNu/HbcEeYjWECYVzByNm+6AZSGD
         kuvb3OPQDV8yevyBlgFhBmQUEgbHu6noy+hnSx2nbj9SWZyidvt/aF1bvEcyoFZA8BvY
         Fb6Iau/aTrOr+4cX4jsBX3UO5405AmcIX0tlqv7bZ649nxRvlpZZiO5QDlD+3NR6hG+B
         Q2QyNOgV/GQoGQnbydNOHdPCjRlSMzOZPDbqVej5jPnFgFHZZ5inOiMG9FmSCDTOHjnD
         SdhsBAvNuEPRUeQiLmsdYh5lYBknjhfHYA2ircGqbGtveVlFOLl01sKn3hjeR7QGqvM7
         cFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736360573; x=1736965373;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jMNqoigFiWM5TbLMD0Xi2MHr+lE9/rI9qjc7yUxHIVg=;
        b=tKGQTTlMlAOSpTJUjW4NyM3cpwQHFaJO/HDranCLMQb8giDI2H9WTUwa5rymHz+G9O
         Yd1Zp+Bup9rvK+IZwJliDgHKNt8lh2pTdbXvEJw/dZmSApceT3eftA37uFscBhT0Nqrx
         3Jw0KzBUwiGll0rYobUtNwyO9zewPd6Ch/KC+WA2dl+PKS/gQDC5u4qNfSylBP1CZZfU
         Jn/lvoKM/DP0fk3N2M4m6TVycgqNWGBSVrzdJNnGHZO9E10K2GE9NbghVjugcNYsgRlG
         dBamkhZJHJRbsXLEaZZtvc4QN7XxqjEft8o5nma08XGzgfYHe3M6gdeHXFDQ2/SI5Kbi
         BOXw==
X-Gm-Message-State: AOJu0Yz5KU8gFtotYUHxrP1e1jaD+9ZiNbPprsK7emdqE7zglbwtEiiv
	AI/OHhar5yQQw3HaVzNbwSJzq0unVL3abdbIkZIwDTDnPWCJh2mFKNWtitpdJZCge1WqC03bfOV
	P+Yg2Vt9TIeM9QRsm4Dl/skAfzQ4LJmJhYa4T353olOaKGaItwUe3feBAjyWR9ZZzA4/IE+JnXF
	TM49k6+Qfjpr31fO3SY03l0xZZdQ==
X-Google-Smtp-Source: AGHT+IF5FxHo/GxUg3M9bFpnWUOS3dfV3YLDhvFEBW4ZokvEkI7JN0wADt0+mqzGvEDzIXQxewD2mXEf
X-Received: from wmbay14.prod.google.com ([2002:a05:600c:1e0e:b0:434:a2c3:d51b])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:1aca:b0:385:fa3d:1988
 with SMTP id ffacd0b85a97d-38a872fc2d2mr3347130f8f.8.1736360573138; Wed, 08
 Jan 2025 10:22:53 -0800 (PST)
Date: Wed,  8 Jan 2025 19:22:24 +0100
In-Reply-To: <20250108182218.1453754-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250108182218.1453754-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3975; i=ardb@kernel.org;
 h=from:subject; bh=OYEz/LdyZY7FNclv23VBaoW3nBN5gwqCUebHiTAjWjo=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIb3uUNImbxO/ZUb6TyTW7Dypmnz5xRMd3coGbqET6ze/k
 XE6yny2o5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEwk6jHDX/HPNmb5nvn6lfHP
 PwQqRh3Y+Otx/dJb/+6m/Zy3on12xCGGX0y3HgtGzhYtmyCwfzJXQ/GppfHp077X8s+vV9hwUI3 lFy8A
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250108182218.1453754-13-ardb+git@google.com>
Subject: [PATCH 5/6] x86/efi/mixed: Reduce padding by moving some code around
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: x86@kernel.org, kees@kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The 32-bit and 64-bit entrypoints for the EFI handover protocol need to
be exactly 0x200 bytes apart, and so the 64-bit version is placed at the
end, using padding to move it into place.

This padding can be reduced now, since the code in between has reduced
in size as well. So move efi32_stub_entry() to the beginning of the
source file.

Note that this code is outside of the compressed kernel image, and so
the padding is not compressed.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/efi_mixed.S | 51 ++++++++++----------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
index a44e522bbbed..b5a46a4ce083 100644
--- a/arch/x86/boot/compressed/efi_mixed.S
+++ b/arch/x86/boot/compressed/efi_mixed.S
@@ -21,12 +21,32 @@
 #include <asm/processor-flags.h>
 #include <asm/segment.h>
 
-	.code64
 	.text
 	.balign	8
 SYM_DATA_LOCAL(gdt, .quad 0x0, 0x0, 0xaf9a000000ffff)	/* __KERNEL_CS */
 	.set	gdt_size, . - gdt
 
+#ifdef CONFIG_EFI_HANDOVER_PROTOCOL
+	.code32
+SYM_FUNC_START_NOALIGN(efi32_stub_entry)
+	call	1f
+1:	popl	%ecx
+
+	/* Clear BSS */
+	xorl	%eax, %eax
+	leal	(_bss - 1b)(%ecx), %edi
+	leal	(_ebss - 1b)(%ecx), %ecx
+	subl	%edi, %ecx
+	shrl	$2, %ecx
+	cld
+	rep	stosl
+
+	add	$0x4, %esp		/* Discard return address */
+	movl	8(%esp), %edi		/* struct boot_params pointer */
+	jmp	efi32_entry
+SYM_FUNC_END(efi32_stub_entry)
+#endif
+
 /*
  * When booting in 64-bit mode on 32-bit EFI firmware, startup_64_mixed_mode()
  * is the first thing that runs after switching to long mode. Depending on
@@ -50,6 +70,7 @@ SYM_DATA_LOCAL(gdt, .quad 0x0, 0x0, 0xaf9a000000ffff)	/* __KERNEL_CS */
  *                          |   vmlinux   |<----| efi_stub_entry |<--------+
  *                          +-------------+     +----------------+
  */
+	.code64
 SYM_FUNC_START_LOCAL_NOALIGN(startup_64_mixed_mode)
 	xorl	%eax, %eax
 	movl	%eax, %ds
@@ -79,7 +100,7 @@ SYM_FUNC_START_LOCAL_NOALIGN(startup_64_mixed_mode)
 	jmp	efi_pe_entry
 SYM_FUNC_END(startup_64_mixed_mode)
 
-SYM_FUNC_START(__efi64_thunk)
+SYM_FUNC_START_NOALIGN(__efi64_thunk)
 	push	%rbx
 
 	/* Store live GDT and IDT descriptors */
@@ -125,26 +146,6 @@ SYM_FUNC_START(__efi64_thunk)
 SYM_FUNC_END(__efi64_thunk)
 
 	.code32
-#ifdef CONFIG_EFI_HANDOVER_PROTOCOL
-SYM_FUNC_START(efi32_stub_entry)
-	call	1f
-1:	popl	%ecx
-
-	/* Clear BSS */
-	xorl	%eax, %eax
-	leal	(_bss - 1b)(%ecx), %edi
-	leal	(_ebss - 1b)(%ecx), %ecx
-	subl	%edi, %ecx
-	shrl	$2, %ecx
-	cld
-	rep	stosl
-
-	add	$0x4, %esp		/* Discard return address */
-	movl	8(%esp), %edi		/* struct boot_params pointer */
-	jmp	efi32_entry
-SYM_FUNC_END(efi32_stub_entry)
-#endif
-
 /*
  * Called using a far call from 64-bit code, using the x86_64 SysV ABI (except
  * for R8/R9 which are inaccessible to 32-bit code - EAX/EBX are used instead).
@@ -155,7 +156,7 @@ SYM_FUNC_END(efi32_stub_entry)
  * Entered with ESP+40 pointing to the arguments passed via the stack, and with
  * the 64-bit mode GDT and IDT descriptors at ESP+8 and ESP+14, respectively.
  */
-SYM_FUNC_START_LOCAL(efi_enter32)
+SYM_FUNC_START_LOCAL_NOALIGN(efi_enter32)
 	/*
 	 * Convert x86-64 SysV ABI params to i386 ABI
 	 */
@@ -232,7 +233,7 @@ SYM_FUNC_END(efi_enter32)
  * stub may still exit and return to the firmware using the Exit() EFI boot
  * service.]
  */
-SYM_FUNC_START_LOCAL(efi32_entry)
+SYM_FUNC_START_LOCAL_NOALIGN(efi32_entry)
 	call	1f
 1:	pop	%ebx
 
@@ -306,7 +307,7 @@ SYM_FUNC_END(efi32_entry)
  * efi_status_t efi32_pe_entry(efi_handle_t image_handle,
  *			       efi_system_table_32_t *sys_table)
  */
-SYM_FUNC_START(efi32_pe_entry)
+SYM_FUNC_START_NOALIGN(efi32_pe_entry)
 	pushl	%ebx				// save callee-save registers
 
 	/* Check whether the CPU supports long mode */
-- 
2.47.1.613.gc27f4b7a9f-goog


